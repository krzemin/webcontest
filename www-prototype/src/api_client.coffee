class ApiClient
  constructor: (@url_base) ->

  # prefetching
  loadAllRequest: =>
  	$.ajax {
      url: '/load-all'
  	  dataType: 'json'
  	  success: @loadAllResponse
  	}

  loadAllResponse: (data) =>

  # saving code
  saveCodeRequest: (code) =>
  	$.ajax {
      type: 'POST'
      url: '/save-code'
  	  dataType: 'json'
  	  data: { code: code }
  	  success: (data) => @saveCodeResponse(data.status)
  	}

  saveCodeResponse: (result) =>
    console.log result

  # compiling code
  compileCodeRequest: (code) =>
    $.ajax {
      type: 'POST'
      url: '/compile-code'
      dataType: 'json'
      data: { code: code }
      success: (data) => @compileCodeResponse(data.status)
    }

  compileCodeResponse: (result) =>

