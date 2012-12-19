var Gui,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Gui = (function() {

  function Gui() {
    this.codeChanged = __bind(this.codeChanged, this);

    this.initCodeMirror = __bind(this.initCodeMirror, this);

    this.start = __bind(this.start, this);

  }

  Gui.prototype.start = function() {
    return this.initCodeMirror();
  };

  Gui.prototype.initCodeMirror = function() {
    var cm, codeWidget, opts,
      _this = this;
    opts = {
      mode: "text/x-c++src",
      theme: "eclipse",
      lineNumbers: true
    };
    codeWidget = document.getElementById('code');
    cm = CodeMirror.fromTextArea(codeWidget, opts);
    return CodeMirror.on(cm, "change", function(instance, chObj) {
      return _this.codeChanged(instance, chObj);
    });
  };

  Gui.prototype.codeChanged = function(instance, chObj) {
    console.log('from: ' + chObj.from);
    console.log('to: ' + chObj.to);
    console.log('text: ' + chObj.text);
    console.log('next: ' + chObj.next);
    return console.log('TXT: ' + instance.getValue());
  };

  return Gui;

})();
