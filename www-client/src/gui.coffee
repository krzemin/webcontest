class Gui
  constructor: ->

  start: =>
    @initCodeMirror()

  initCodeMirror: =>
    opts = {
      mode: "text/x-c++src",
      theme: "eclipse",
      lineNumbers: true,
    }
    codeWidget = document.getElementById('code')
    @cm = CodeMirror.fromTextArea(codeWidget, opts)
    CodeMirror.on(@cm, "change", (instance, chObj) => @codeChanged(instance.getValue()))

  loadCode: (codeText) =>
    @cm.setValue(codeText)

  codeChanged: (newText) =>



