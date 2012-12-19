var UseCase,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

UseCase = (function() {

  function UseCase() {
    this.codeChanged = __bind(this.codeChanged, this);

    this.loadCode = __bind(this.loadCode, this);

    this.start = __bind(this.start, this);

  }

  UseCase.prototype.start = function() {};

  UseCase.prototype.loadCode = function(codeText) {};

  UseCase.prototype.codeChanged = function(newText) {};

  return UseCase;

})();
