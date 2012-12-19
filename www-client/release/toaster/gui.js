var Gui,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Gui = (function() {

  function Gui() {
    this.start = __bind(this.start, this);

  }

  Gui.prototype.start = function() {
    return $('#code').codemirror({
      value: 'int add(int a, int b) { return a + b; }',
      mode: 'clike'
    });
  };

  return Gui;

})();
