class Gui
  
  constructor: ->
    _gui = @
    @codeMirrorOpts = {
      mode: 'text/x-c++src'
      theme: 'elegant'
      lineNumbers: true
      indentUnit: 4
      extraKeys: {
        "F11": (cm) -> _gui._setFullScreen(!_gui._isFullScreen())
        "Esc": (cm) -> _gui._setFullScreen(false) if _gui._isFullScreen()
      }
    }
    @rankingUpdateOptions = {
      duration: [600, 50, 400, 50, 400]
      animationSettings: {
          up: { left: -25, backgroundColor: '#AAFFAA' }
          down: { left: 25, backgroundColor: '#FFAAAA' }
          fresh: { left: 0, backgroundColor: '#FFFF33' }
          drop: { left: 0, backgroundColor: '#FF88FF' }
      }
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
    Handlebars.registerHelper 'ranking_points_passed', (points) ->
      if points != '0.00'
        return new Handlebars.SafeString """<span class="ranking-points-passed">#{points}</span>"""
      else
        return new Handlebars.SafeString points
    
  _initCodeMirror: (code) =>
    codewidget = document.getElementById('codemirror')
    @codeMirrorOpts.mode = code.mode
    @codemirror = CodeMirror.fromTextArea(codewidget, @codeMirrorOpts)
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
      $('.CodeMirror-scroll').css('overflow-y', 'auto')
    else
      wrap.className = wrap.className.replace(" CodeMirror-fullscreen", "")
      wrap.style.height = ""
      document.documentElement.style.overflow = ""
      $('.CodeMirror-scroll').css('overflow-y', 'hidden')
    @codemirror.refresh()

  _bindCodeActions: =>
    $('#toggle-messages').click( => $('#messages').toggle() )
    $('#save').click( => @saveCode(@codemirror.getValue()) )
    $('#compile').click( => @compileCode(@codemirror.getValue()) )
    $('#submit').click( => @submitCode(@codemirror.getValue()) )
    $('#fullscreen').click( => @_setFullScreen(!@_isFullScreen()) )

  uiChanged: =>
    $('body').scrollspy('refresh')

  start: =>
    @_initHandlebarsHelpers()
    $.extend($.easing, {
      def: 'easeInExpo'
      easeInExpo: (x, t, b, c, d) =>
        return b if t == 0
        c * Math.pow(2, 10 * (t/d - 1)) + b
    })

  showPrefetchingError: =>
    opts = { type: 'error', title: 'Error', text: 'An error has occured during prefetching the data.'}
    @_render('alert.tmpl', '#main', opts)
  
  showUIContainers: =>
    @_render('main.tmpl', '#main', {})

  showProblem: (problem) =>
    @_render('problem.tmpl', '#problem', problem)

  showCode: (code) =>
    @_render('code.tmpl', '#code', code)
    @_initCodeMirror(code)
    @_bindCodeActions()

  showSubmissions: (submissions) =>
    @_render('submissions.tmpl', '#submissions', submissions)

  showRanking: (ranking) =>
    if $('#ranking > table#ranking-table').size() == 0
      @_render('ranking.tmpl', '#ranking', ranking)
    else
      newRankingMarkup = Handlebars.templates['ranking.tmpl'](ranking)
      newRanking = $(document.createElement()).html(newRankingMarkup)
      newTable = $(newRanking).find('table#ranking-table')
      $('table#ranking-table').rankingTableUpdate(newTable, @rankingUpdateOptions)

  saveCode: (code) =>
    $('#code-alert-container').html('')
    $('#save').button('loading')

  codeSaved: (result) =>
    $('#save').button('reset')
    unless result
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
    if result
      $('#messages').text('Compiling...').show()
      $('#messages').removeClass('messages-compilation-error')
    else
      $('#compile').button('reset')
      opts = { type: 'error', title: 'Error', text: 'An error has occured while trying to send compilation request. Try again.'}
      @_render('alert.tmpl', '#code-alert-container', opts)
      $('#code-alert-container .alert').fadeOut(5000, 'easeInExpo')

  codeCompilationFinished: (result) =>
    $('#compile').button('reset')
    if result.status == 'error'
      $('#messages').text(result.message).show()
      $('#messages').addClass('messages-compilation-error')
    else
      if result.message
        $('#messages').text("#{result.message}\nCompilation finished in #{result.time}s.").show()
      else
        $('#messages').text("Compilation finished in #{result.time}s.").show()
      $('#messages').removeClass('messages-compilation-error')

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
    tr = $("""table#submissions-table > tbody > tr[data-id="#{result.id}"]""")
    tr.find('td.submission-status').html(status_html)
    if result.score
      tr.find('td.submission-score').text(result.score)
    if result.performance
      if result.performance.time
        tr.find('td.submission-performance-time').html(
          """<nobr><i class="icon-time"></i> #{result.performance.time}</nobr> &nbsp;"""
        )
      if result.performance.memory
        tr.find('td.submission-performance-memory').html(
          """<nobr><i class="icon-tasks"></i> #{result.performance.memory}</nobr>"""
        )

