var UseCase,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

UseCase = (function() {

  function UseCase() {
    this.codeChanged = __bind(this.codeChanged, this);

    this.initCodeView = __bind(this.initCodeView, this);

    this.start = __bind(this.start, this);

  }

  UseCase.prototype.start = function() {
    return this.initCodeView();
  };

  UseCase.prototype.initCodeView = function() {};

  UseCase.prototype.codeChanged = function(newText) {};

  return UseCase;

})();
