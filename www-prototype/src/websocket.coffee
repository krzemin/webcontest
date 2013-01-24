class WebSocket
  constructor: (@url_base) ->
  	@faye_settings = {
  	  timeout: 60
  	  retry: 3
  	}

  start: =>
  	@faye = new Faye.Client(@url_base, @faye_settings)
  	@faye.bind('transport:down', => @transportDown())
  	@faye.bind('transport:up', => @transportUp())

  	@broadcast = @faye.subscribe('/broadcast', (message) =>
  					@broadcastReceived(message)
  				 )
  	@broadcast.callback( => console.log('broadcast callback') )
  	@broadcast.errback( (error) => console.log(error) )

  transportDown: =>

  transportUp: =>

  broadcastReceived: (message) =>
  	console.log(message)
