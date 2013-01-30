#<< utils
#<< local_storage
#<< use_case
#<< gui
#<< websocket
#<< glue

class App
  constructor: ->
    useCase       = new UseCase()
    gui           = new Gui()
    local_storage = new LocalStorage("webcontest")
    websocket     = new WebSocket("http://localhost:3000/faye")
    api	   		  = new ApiClient("http://localhost:3000")
    glue          = new Glue(useCase, gui, api, local_storage, websocket)
    
    useCase.start()

$(-> new App())

