var Glue;

Glue = (function() {

  function Glue(useCase, gui, storage) {
    this.useCase = useCase;
    this.gui = gui;
    this.storage = storage;
    LogAll(this.useCase, 'UseCase');
    LogAll(this.gui, 'Gui');
    After(this.useCase, 'start', this.gui.start);
  }

  return Glue;

})();
