var UseCase,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

UseCase = (function() {

  function UseCase() {
    this.codeChanged = __bind(this.codeChanged, this);

    this.initCodeView = __bind(this.initCodeView, this);

    this.signOut = __bind(this.signOut, this);

    this.exitContestArea = __bind(this.exitContestArea, this);

    this.settings = __bind(this.settings, this);

    this.messages = __bind(this.messages, this);

    this.ranking = __bind(this.ranking, this);

    this.status = __bind(this.status, this);

    this.problem = __bind(this.problem, this);

    this.contestWelcome = __bind(this.contestWelcome, this);

    this.loadContest = __bind(this.loadContest, this);

    this.openContest = __bind(this.openContest, this);

    this.loadContestList = __bind(this.loadContestList, this);

    this.signInError = __bind(this.signInError, this);

    this.signIn = __bind(this.signIn, this);

    this.start = __bind(this.start, this);
    this.user = {};
    this.contest_list = [];
    this.contest = {};
  }

  UseCase.prototype.start = function() {};

  UseCase.prototype.signIn = function(response) {
    if (response) {
      this.user = response.user;
      this.contest_list = response.contest_list;
      return this.loadContestList();
    } else {
      return this.signInError();
    }
  };

  UseCase.prototype.signInError = function() {};

  UseCase.prototype.loadContestList = function() {};

  UseCase.prototype.openContest = function(id) {};

  UseCase.prototype.loadContest = function(contest) {
    this.contest = contest;
    return this.contestWelcome();
  };

  UseCase.prototype.contestWelcome = function() {};

  UseCase.prototype.problem = function() {};

  UseCase.prototype.status = function() {};

  UseCase.prototype.ranking = function() {};

  UseCase.prototype.messages = function() {};

  UseCase.prototype.settings = function() {};

  UseCase.prototype.exitContestArea = function() {
    return this.loadContestList();
  };

  UseCase.prototype.signOut = function() {};

  UseCase.prototype.initCodeView = function() {};

  UseCase.prototype.codeChanged = function(newText) {};

  return UseCase;

})();
