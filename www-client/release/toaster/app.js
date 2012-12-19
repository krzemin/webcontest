var App;

App = (function() {

  function App() {
    var glue, gui, localStorage, useCase;
    useCase = new UseCase();
    gui = new Gui();
    localStorage = new LocalStorage("webcontest");
    glue = new Glue(useCase, gui, localStorage);
    useCase.start();
  }

  return App;

})();

$(function() {
  return new App();
});
