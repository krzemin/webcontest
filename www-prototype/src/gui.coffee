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
    else
      wrap.className = wrap.className.replace(" CodeMirror-fullscreen", "")
      wrap.style.height = ""
      document.documentElement.style.overflow = ""
    @codemirror.refresh()
    
  start: =>
    @_initHandlebarsHelpers()
    # init stuff here, before loading any data
  
  loadAll: (data) =>
    # init stuff when data is loaded
    @_render('main.tmpl', '#main', data)
    @_refreshScrollSpy()
    @_initCodeMirror(data.code)
    @_bindUIControls()

  saveCode: (code) =>
    # triggered when user wants to save code buffer in editor
    # to persistent storage

  compileCode: (code) =>
    # compilation request also should save code remotely, so we
    # doesn't need to save code before compilation

  codeCompilationStarted: =>

  codeCompilationFinished: (result) =>

  submitCode: (code) =>

  submissionPosted: =>

  submissionResultUpdated: (result) =>

  rankingUpdated: (ranking) =>




