class Gui
  
  constructor: ->
    @codemirror_opts = {
      mode: 'text/x-c++src'
      theme: 'elegant'
      lineNumbers: true
      indentUnit: 4
    }

  # utils

  _render: (template, target, data) =>
    console.log('template = ' + template)
    template = Handlebars.templates[template]
    html = template(data)
    $(target).html(html)

  _initHandlebarsHelpers: =>
    Handlebars.registerHelper 'submission_status', (submission) ->
      if submission.status == 'finished'
        code = 'Passed' if submission.code == 'passed'
        code = 'Runtime error' if submission.code == 're'
        code = 'Wrong answer' if submission.code == 'wa'
        code = 'Time limit exceeded' if submission.code == 'tle'
        code = 'Memory limit exceeded' if submission.code == 'mle'
        return new Handlebars.SafeString """
          <span class="submission-#{submission.code}">
            #{code}
          </span>
        """
      else if submission.status
        return new Handlebars.SafeString """
          <div class="progress progress-striped active submission-progress">
            <div class="bar" style="width: #{submission.progress || 100}%;">
              #{submission.status.capitalize()}...
            </div>
          </div>
        """
      else "WTF???"

  _refreshScrollSpy: =>
    $('body').scrollspy('refresh')
    
  _bindUIControls: =>
    $('#toggle-messages').click( => $('#messages').toggle() )
    $('#save').click( => @saveCode(@codemirror.getValue()) )
    $('#compile').click( => @compileCode(@codemirror.getValue()) )
    $('#submit').click( => @submitCode(@codemirror.getValue()) )
    $('#fullscreen').click( => @_setFullScreen(!@_isFullScreen()) )

  _initCodeMirror: (code) =>
    codewidget = document.getElementById('codemirror')
    @codemirror_opts.mode = code.mode
    @codemirror = CodeMirror.fromTextArea(codewidget, @codemirror_opts)
    @codemirror.markClean()
    CodeMirror.on(window, "resize", =>
      showing = document.body.getElementsByClassName("CodeMirror-fullscreen")[0]
      return unless showing
      showing.CodeMirror.getWrapperElement().style.height = @_winHeight() + "px"
    )
  _isFullScreen: =>
    /\bCodeMirror-fullscreen\b/.test(@codemirror.getWrapperElement().className)
  _winHeight: =>
    window.innerHeight || (document.documentElement || document.body).clientHeight
  _setFullScreen: (fullscreen) =>
    wrap = @codemirror.getWrapperElement()
    if fullscreen
      wrap.className += " CodeMirror-fullscreen"
      wrap.style.height = @_winHeight() + "px"
      document.documentElement.style.overflow = "hidden"
      $(window).scrollTop(0);
    else
      wrap.className = wrap.className.replace(" CodeMirror-fullscreen", "")
      wrap.style.height = ""
      document.documentElement.style.overflow = ""
    @codemirror.refresh()
    
  start: =>
    @_initHandlebarsHelpers()
    $.extend($.easing, {
      def: 'easeInExpo'
      easeInExpo: (x, t, b, c, d) =>
        return b if t == 0
        c * Math.pow(2, 10 * (t/d - 1)) + b
    })
  
  loadAll: (data) =>
    @_render('main.tmpl', '#main', data)
    @_render('problem.tmpl', '#problem', data.problem)
    @_render('code.tmpl', '#code', data.code)
    @_render('submissions.tmpl', '#submissions', data.submissions)
    @_render('ranking.tmpl', '#ranking', data.ranking)
    @_refreshScrollSpy()
    @_initCodeMirror(data.code)
    @_bindUIControls()

  saveCode: (code) =>
    $('#code-alert-container').html('')
    $('#save').button('loading')

  codeSaved: (result) =>
    $('#save').button('reset')
    if result
      opts = { type: 'error', title: 'Error', text: 'An error has occured while saving the code to the server. Try again.'}
      @_render('alert.tmpl', '#code-alert-container', opts)
    else
      opts = { type: 'success', title: 'Code saved!', text: 'Code was successfully saved to the server'}
      @_render('alert.tmpl', '#code-alert-container', opts)
    $('#code-alert-container .alert').fadeOut(5000, 'easeInExpo')

  compileCode: (code) =>
    $('#code-alert-container').html('')
    $('#compile').button('loading')

  codeCompilationStarted: (result) =>
    unless result
      $('#compile').button('reset')
      opts = { type: 'error', title: 'Error', text: 'An error has occured while trying to send compilation request. Try again.'}
      @_render('alert.tmpl', '#code-alert-container', opts)
      $('#code-alert-container .alert').fadeOut(5000, 'easeInExpo')

  codeCompilationFinished: (result) =>
    $('#compile').button('reset')
    if result.status == 'error'
      $('#messages').addClass('messages-compilation-error')
    else
      $('#messages').removeClass('messages-compilation-error')
    $('#messages').text(result.messages).show()

  submitCode: (code) =>
    $('#code-alert-container').html('')
    $('#submit').button('loading')

  submissionPosted: (result) =>
    $('#submit').button('reset')
    if result
      console.log(result)
      status = Handlebars.helpers['submission_status'](result).toString()

      row = $('<tr>').attr('data-id', result.id).append(
        $('<td>').addClass('submission-timestamp').append(
          $('<a>').attr('nohref', '').append(result.timestamp)
        )
      ).append(
        $('<td>').addClass('submission-status').html(status)
      ).append(
        $('<td>').addClass('submission-score')
      ).append(
        $('<td>').addClass('submission-performance-time').addClass('hidden-phone')
      ).append(
        $('<td>').addClass('submission-performance-memory').addClass('hidden-phone')
      )

      $('table#submissions-table > tbody > tr:first').before(row)
    else
      opts = { type: 'error', title: 'Error', text: 'An error has occured while trying submit a code. Try again.'}
      @_render('alert.tmpl', '#code-alert-container', opts)
      $('#code-alert-container .alert').fadeOut(5000, 'easeInExpo')


  submissionResultUpdated: (result) =>
    console.log(result)
    status_html = Handlebars.helpers['submission_status'](result).toString()
    tr = $('table#submissions-table > tbody > tr[data-id="'+result.id+'"]')
    tr.find('td.submission-status').html(status_html)
    if result.score
      tr.find('td.submission-score').text(result.score)
    if result.performance
      if result.performance.time
        console.log(result.performance.time)
        tr.find('td.submission-performance-time').html(
          """<nobr><i class="icon-time"></i> #{result.performance.time}</nobr> &nbsp;"""
        )
      if result.performance.memory
        console.log(result.performance.memory)
        tr.find('td.submission-performance-memory').html(
          """<nobr><i class="icon-tasks"></i> #{result.performance.memory}</nobr>"""
        )

  rankingUpdated: (ranking) =>
    console.log(ranking)
    @_render('ranking.tmpl', '#ranking', ranking)
    $('#ranking > table > tbody > tr[data-no="'+ranking.change[0]+'"]').css('background-color', 'green')


