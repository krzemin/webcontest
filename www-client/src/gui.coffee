class Gui
  
  constructor: ->
    @saveCodeEvery = 15

  # utils

  _render: (template, target, data) =>
    console.log('template = ' + template)
    template = Handlebars.templates[template]
    html = template(data)
    $(target).html(html)

  _setLayout: (layout) =>
    @_render("layout-#{layout}.tmpl", 'body', {})


  # GUI actions
  start: =>
    @_setLayout('center')
    @showSignInForm()

  showSignInForm: =>
    @_render('sign-in.tmpl', '#main', {})
    $('#sign-in').click( =>
        credentials =
            email: $('#email').val()
            password: $('#password').val()
        @signInClicked(credentials)
    )
  signInClicked: (credentials) =>
    $('#sign-in').off('click').addClass('disabled').text('Signing in...')
  

  showContestList: (contests) =>
    console.log(contests)
    @_render('contest-list.tmpl', '#main', contests)

  initCodeView: (codeText) =>
    opts = {
      mode: 'text/x-c++src',
      theme: 'monokai',
      lineNumbers: true,
      indentUnit: 4,
      extraKeys: {
        'F11': (cm) => @setCodeViewFullScreen(cm, !@isCodeViewFullScreen(cm))
        'Esc': (cm) => @setCodeViewFullScreen(cm, false) if @isCodeViewFullScreen(cm)
      }
    }
    codeWidget = document.getElementById('code')
    @cm = CodeMirror.fromTextArea(codeWidget, opts)
    @cm.setValue(codeText)
    @cm.markClean()
    setTimeout(@saveCodeCallback, @saveCodeEvery * 1000)
    # previously, saving the code was performed every editor's content change
    # CodeMirror.on(@cm, "change", (instance, chObj) => @codeChanged(instance.getValue()))

  isCodeViewFullScreen: (cm) =>
    /\bCodeMirror-fullscreen\b/.test(cm.getWrapperElement().className)

  setCodeViewFullScreen: (cm, full) =>
    wrap = cm.getWrapperElement()
    winHeight = window.innerHeight || (document.documentElement || document.body).clientHeight
    if full
      wrap.className += ' CodeMirror-fullscreen'
      wrap.style.height = winHeight + 'px'
      document.documentElement.style.overflow = 'hidden'
    else
      wrap.className = wrap.className.replace(" CodeMirror-fullscreen", "")
      wrap.style.height = ""
      document.documentElement.style.overflow = ""
    cm.refresh()

  saveCodeCallback: =>
    @codeChanged(@cm.getValue()) unless @cm.isClean()
    @cm.markClean()
    setTimeout(@saveCodeCallback, @saveCodeEvery * 1000)

  codeChanged: (newText) =>



