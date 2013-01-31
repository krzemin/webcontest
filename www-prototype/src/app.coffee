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
    websocket     = new WebSocket("/faye")
    api	   		  = new ApiClient()
    glue          = new Glue(useCase, gui, api, local_storage, websocket)
    
    useCase.start()

$(-> new App())

