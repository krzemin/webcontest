class ApiClient
  constructor: (@url_base) ->

  loadAllRequest: =>
  	$.ajax({
  	  dataType: 'json'
  	  url: '/load-all'
  	  success: @loadAllResponse
  	})

  loadAllResponse: (data) =>
  	console.log(data)
