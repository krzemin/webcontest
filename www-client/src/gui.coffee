class Gui
  constructor: ->

  start: =>

  initCodeView: (codeText) =>
    opts = {
      mode: "text/x-c++src",
      theme: "monokai",
      lineNumbers: true,
    }
    codeWidget = document.getElementById('code')
    @cm = CodeMirror.fromTextArea(codeWidget, opts)
    @cm.setValue(codeText)
    CodeMirror.on(@cm, "change", (instance, chObj) => @codeChanged(instance.getValue()))

  codeChanged: (newText) =>



