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
    After(this.useCase, 'initCodeView', function() {
      return _this.gui.initCodeView(_this.storage.getCode());
    });
    After(this.useCase, 'codeChanged', function(newText) {
      return _this.storage.setCode(newText);
    });
    After(this.gui, 'codeChanged', function(newText) {
      return _this.useCase.codeChanged(newText);
    });
  }

  return Glue;

})();
