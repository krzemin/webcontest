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
          <span class="submission-status submission-#{submission.code}">
            #{code}
          </span>
        """
      else
        return new Handlebars.SafeString """
          <div class="progress progress-striped active  submission-progress">
            <div class="bar" style="width: #{submission.progress}%;">
              Running...
            </div>
          </div>
        """

  _refreshScrollSpy: =>
    $('body').scrollspy('refresh')
    
  _bindUIControls: =>
    $('#toggle-messages').click( => $('#messages').toggle() )
    $('#save').click( => @saveCode(@codemirror.getValue()) )
    $('#compile').click( => @compileCode(@codemirror.getValue()) )
    $('#fullscreen').click( => @_setFullScreen(!@_isFullScreen()))
    

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

  submissionPosted: =>

  submissionResultUpdated: (result) =>

  rankingUpdated: (ranking) =>




