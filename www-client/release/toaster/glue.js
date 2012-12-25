var Glue;

Glue = (function() {

  function Glue(useCase, gui, storage) {
    var _this = this;
    this.useCase = useCase;
    this.gui = gui;
    this.storage = storage;
    AutoBind(this.gui, this.useCase);
    LogAll(this.useCase, 'UseCase');
    LogAll(this.gui, 'Gui');
    LogAll(this.storage, 'Storage');
    After(this.useCase, 'start', this.gui.start);
    After(this.gui, 'start', this.useCase.problem('1'));
    After(this.gui, 'signIn', function(credentials) {
      return _this.storage.signIn(credentials);
    });
    After(this.storage, 'signInResponse', function(response) {
      return _this.useCase.signIn(response);
    });
    After(this.useCase, 'signInError', this.gui.signInError);
    After(this.useCase, 'signOut', this.gui.signOut);
    After(this.useCase, 'loadContestList', function() {
      return _this.gui.showContestList(_this.useCase.contest_list);
    });
    After(this.useCase, 'openContest', function(id) {
      return _this.storage.getContest(id);
    });
    After(this.storage, 'contestResponse', function(contest) {
      return _this.useCase.loadContest(contest);
    });
    Before(this.useCase, 'loadContest', function(contest) {
      return _this.gui.showContestArea(_this.useCase.user, contest);
    });
    After(this.useCase, 'contestWelcome', function() {
      return _this.gui.showContestWelcome(_this.useCase.contest);
    });
    After(this.useCase, 'problem', function(id) {
      return _this.gui.showProblem(_this.useCase.getProblem(id));
    });
    After(this.useCase, 'status', function() {
      return _this.gui.showStatus([]);
    });
    After(this.useCase, 'ranking', function() {
      return _this.gui.showRanking({});
    });
    After(this.useCase, 'messages', function() {
      return _this.gui.showMessages([]);
    });
    After(this.useCase, 'settings', function() {
      return _this.gui.showSettingsForm({});
    });
  }

  return Glue;

})();
