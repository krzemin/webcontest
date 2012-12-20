class Gui
  constructor: ->
    @saveCodeEvery = 15

  start: =>

  initCodeView: (codeText) =>
    opts = {
      mode: "text/x-c++src",
      theme: "monokai",
      lineNumbers: true,
      indentUnit: 4 
    }
    codeWidget = document.getElementById('code')
    @cm = CodeMirror.fromTextArea(codeWidget, opts)
    @cm.setValue(codeText)
    setTimeout(@saveCodeCallback, @saveCodeEvery * 1000)
    # previously, saving the code was performed every editor's content change
    # CodeMirror.on(@cm, "change", (instance, chObj) => @codeChanged(instance.getValue()))

  saveCodeCallback: =>
    @codeChanged(@cm.getValue()) unless @cm.isClean()
    @cm.markClean()
    setTimeout(@saveCodeCallback, @saveCodeEvery * 1000)

  codeChanged: (newText) =>



