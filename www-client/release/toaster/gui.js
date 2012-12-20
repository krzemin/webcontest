var Gui,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Gui = (function() {

  function Gui() {
    this.codeChanged = __bind(this.codeChanged, this);

    this.saveCodeCallback = __bind(this.saveCodeCallback, this);

    this.initCodeView = __bind(this.initCodeView, this);

    this.start = __bind(this.start, this);
    this.saveCodeEvery = 15;
  }

  Gui.prototype.start = function() {};

  Gui.prototype.initCodeView = function(codeText) {
    var codeWidget, opts;
    opts = {
      mode: "text/x-c++src",
      theme: "monokai",
      lineNumbers: true,
      indentUnit: 4
    };
    codeWidget = document.getElementById('code');
    this.cm = CodeMirror.fromTextArea(codeWidget, opts);
    this.cm.setValue(codeText);
    this.cm.markClean();
    return setTimeout(this.saveCodeCallback, this.saveCodeEvery * 1000);
  };

  Gui.prototype.saveCodeCallback = function() {
    if (!this.cm.isClean()) {
      this.codeChanged(this.cm.getValue());
    }
    this.cm.markClean();
    return setTimeout(this.saveCodeCallback, this.saveCodeEvery * 1000);
  };

  Gui.prototype.codeChanged = function(newText) {};

  return Gui;

})();
