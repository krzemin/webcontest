class Gui
  constructor: ->
    @saveCodeEvery = 15

  start: =>

  initCodeView: (codeText) =>
    opts = {
      mode: "text/x-c++src",
      theme: "monokai",
      lineNumbers: true,
      indentUnit: 4,
      extraKeys: {
        "F11": (cm) => @setCodeViewFullScreen(cm, !@isCodeViewFullScreen(cm))
        "Esc": (cm) => @setCodeViewFullScreen(cm, false) if @isCodeViewFullScreen(cm)
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
      wrap.className += " CodeMirror-fullscreen"
      wrap.style.height = winHeight + "px"
      document.documentElement.style.overflow = "hidden"
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



