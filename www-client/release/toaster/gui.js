var Gui,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Gui = (function() {

  function Gui() {
    this.codeChanged = __bind(this.codeChanged, this);

    this.saveCodeCallback = __bind(this.saveCodeCallback, this);

    this.setCodeViewFullscreen = __bind(this.setCodeViewFullscreen, this);

    this.isCodeViewFullScreen = __bind(this.isCodeViewFullScreen, this);

    this.initCodeView = __bind(this.initCodeView, this);

    this.start = __bind(this.start, this);
    this.saveCodeEvery = 15;
  }

  Gui.prototype.start = function() {};

  Gui.prototype.initCodeView = function(codeText) {
    var codeWidget, opts,
      _this = this;
    opts = {
      mode: "text/x-c++src",
      theme: "monokai",
      lineNumbers: true,
      indentUnit: 4,
      extraKeys: {
        "F11": function(cm) {
          return _this.setCodeViewFullScreen(cm, !_this.isCodeViewFullScreen(cm));
        },
        "Esc": function(cm) {
          if (_this.isCodeViewFullScreen(cm)) {
            return _this.setCodeViewFullScreen(cm, false);
          }
        }
      }
    };
    codeWidget = document.getElementById('code');
    this.cm = CodeMirror.fromTextArea(codeWidget, opts);
    this.cm.setValue(codeText);
    this.cm.markClean();
    return setTimeout(this.saveCodeCallback, this.saveCodeEvery * 1000);
  };

  Gui.prototype.isCodeViewFullScreen = function(cm) {
    return /\bCodeMirror-fullscreen\b/.test(cm.getWrapperElement().className);
  };

  Gui.prototype.setCodeViewFullscreen = function(cm, full) {
    var winHeight, wrap;
    wrap = cm.getWrapperElement();
    winHeight = window.innerHeight || (document.documentElement || document.body).clientHeight;
    if (full) {
      wrap.className += " CodeMirror-fullscreen";
      wrap.style.height = winHeight + "px";
      document.documentElement.style.overflow = "hidden";
    } else {
      wrap.className = wrap.className.replace(" CodeMirror-fullscreen", "");
      wrap.style.height = "";
      document.documentElement.style.overflow = "";
    }
    return cm.refresh;
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
