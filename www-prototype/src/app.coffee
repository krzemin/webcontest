#<< utils
#<< local_storage
#<< use_case
#<< gui
#<< glue

class App
  constructor: ->
    useCase      = new UseCase()
    gui          = new Gui()
    localStorage = new LocalStorage("webcontest")
    websocket    = new WebSocket()
    glue         = new Glue(useCase, gui, localStorage, websocket)
    
    useCase.start()

$(-> new App())

