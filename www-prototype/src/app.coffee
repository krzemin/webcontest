#<< utils
#<< local_storage
#<< use_case
#<< gui
#<< websocket
#<< glue

class App
  constructor: ->
    useCase      = new UseCase()
    gui          = new Gui()
    localStorage = new LocalStorage("webcontest")
    websocket    = new WebSocket("http://localhost:3000/faye")
    glue         = new Glue(useCase, gui, localStorage, websocket)
    
    useCase.start()

$(-> new App())

