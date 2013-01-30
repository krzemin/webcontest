class ApiClient
  constructor: (@url_base) ->

  # prefetching
  loadAllRequest: =>
  	$.ajax({
  	  dataType: 'json'
  	  url: '/load-all'
  	  success: @loadAllResponse
  	})

  loadAllResponse: (data) =>
  	console.log(data)

  # saving code
  saveCodeResponse: (result) =>
    console.log(result)

  saveCodeRequest: (code) =>
  	console.log(code)
  	$.ajax({
  	  dataType: 'json'
  	  data: { code: code }
  	  type: 'POST'
  	  url: '/save-code'
  	  success: (data) => @saveCodeResponse(data.status)
  	})



