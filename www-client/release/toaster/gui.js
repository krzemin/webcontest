var Gui,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Gui = (function() {

  function Gui() {
    this.codeChanged = __bind(this.codeChanged, this);

    this.initCodeView = __bind(this.initCodeView, this);

    this.start = __bind(this.start, this);

  }

  Gui.prototype.start = function() {};

  Gui.prototype.initCodeView = function(codeText) {
    var codeWidget, opts,
      _this = this;
    opts = {
      mode: "text/x-c++src",
      theme: "monokai",
      lineNumbers: true
    };
    codeWidget = document.getElementById('code');
    this.cm = CodeMirror.fromTextArea(codeWidget, opts);
    this.cm.setValue(codeText);
    return CodeMirror.on(this.cm, "change", function(instance, chObj) {
      return _this.codeChanged(instance.getValue());
    });
  };

  Gui.prototype.codeChanged = function(newText) {};

  return Gui;

})();
