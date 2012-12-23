var Glue;

Glue = (function() {

  function Glue(useCase, gui, storage) {
    this.useCase = useCase;
    this.gui = gui;
    this.storage = storage;
    AutoBind(this.gui, this.useCase);
    LogAll(this.useCase, 'UseCase');
    LogAll(this.gui, 'Gui');
    LogAll(this.storage, 'Storage');
    After(this.useCase, 'start', this.gui.start);
  }

  return Glue;

})();
