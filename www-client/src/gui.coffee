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
    cm = CodeMirror.fromTextArea(codeWidget, opts)
    CodeMirror.on(cm, "change", (instance, chObj) => @codeChanged(instance, chObj))

  codeChanged: (instance, chObj) =>
    console.log('from: ' + chObj.from)
    console.log('to: ' + chObj.to)
    console.log('text: ' + chObj.text)
    console.log('next: ' + chObj.next)
    console.log('TXT: ' + instance.getValue())



