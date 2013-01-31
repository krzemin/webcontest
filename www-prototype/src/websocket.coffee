class WebSocket
  constructor: (@url) ->
  	@faye_settings = {
  	  timeout: 20
  	  retry: 5
  	}

  init: =>
  	@faye = new Faye.Client @url, @faye_settings
  	@faye.bind 'transport:down', => @transportDown()
  	@faye.bind 'transport:up', => @transportUp()

  	@broadcast = @faye.subscribe '/broadcast', @broadcastReceived

  transportDown: =>
    console.log "transport is down!!!"

  transportUp: =>
    console.log "transport is up!!!"

  broadcastReceived: (message) =>
    console.log message
    @compileCodeIndication(message.data) if message.type == 'compile-code-indication'
    @submitCodeIndication(message.data) if message.type == 'submit-indication'
    @rankingUpdateIndication(message.data) if message.type == 'ranking-indication'

  compileCodeIndication: (result) =>
  submitCodeIndication: (result) =>
  rankingUpdateIndication: (ranking) =>
