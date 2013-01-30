class WebSocket
  constructor: (@url_base) ->
  	@faye_settings = {
  	  timeout: 20
  	  retry: 5
  	}

  init: =>
  	@faye = new Faye.Client(@url_base, @faye_settings)
  	@faye.bind('transport:down', => @transportDown())
  	@faye.bind('transport:up', => @transportUp())

  	@broadcast = @faye.subscribe('/broadcast', (message) =>
  					@broadcastReceived(message)
  	)
  	#@broadcast.callback( => console.log('broadcast callback') )
  	#@broadcast.errback( (error) => console.log("ERR: "); console.log(error) )

  transportDown: =>
    console.log("transport is down!!!")

  transportUp: =>
    console.log("transport is up!!!")

  broadcastReceived: (message) =>
  	console.log(message)
