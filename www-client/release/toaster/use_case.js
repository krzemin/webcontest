var UseCase,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

UseCase = (function() {

  function UseCase() {
    this.codeChanged = __bind(this.codeChanged, this);

    this.initCodeView = __bind(this.initCodeView, this);

    this.openContest = __bind(this.openContest, this);

    this.loadContestList = __bind(this.loadContestList, this);

    this.signIn = __bind(this.signIn, this);

    this.start = __bind(this.start, this);

  }

  UseCase.prototype.start = function() {};

  UseCase.prototype.signIn = function(credentials) {
    console.log(credentials);
    if (credentials.email === 'a' && credentials.password === 'a') {
      return this.loadContestList();
    }
  };

  UseCase.prototype.loadContestList = function() {};

  UseCase.prototype.openContest = function(id) {};

  UseCase.prototype.initCodeView = function() {};

  UseCase.prototype.codeChanged = function(newText) {};

  return UseCase;

})();
