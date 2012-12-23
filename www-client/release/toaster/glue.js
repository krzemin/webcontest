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
    After(this.useCase, 'loadContestList', function() {
      return _this.gui.showContestList(_this.storage.getContestList());
    });
  }

  return Glue;

})();
