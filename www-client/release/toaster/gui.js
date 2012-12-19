var Gui,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Gui = (function() {

  function Gui() {
    this.codeChanged = __bind(this.codeChanged, this);

    this.loadCode = __bind(this.loadCode, this);

    this.initCodeMirror = __bind(this.initCodeMirror, this);

    this.start = __bind(this.start, this);

  }

  Gui.prototype.start = function() {
    return this.initCodeMirror();
  };

  Gui.prototype.initCodeMirror = function() {
    var codeWidget, opts,
      _this = this;
    opts = {
      mode: "text/x-c++src",
      theme: "eclipse",
      lineNumbers: true
    };
    codeWidget = document.getElementById('code');
    this.cm = CodeMirror.fromTextArea(codeWidget, opts);
    return CodeMirror.on(this.cm, "change", function(instance, chObj) {
      return _this.codeChanged(instance.getValue());
    });
  };

  Gui.prototype.loadCode = function(codeText) {
    return this.cm.setValue(codeText);
  };

  Gui.prototype.codeChanged = function(newText) {};

  return Gui;

})();
