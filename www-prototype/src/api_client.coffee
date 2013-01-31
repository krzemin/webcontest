class ApiClient
  constructor: ->

  # prefetching
  prefetchAllResponse: (data) =>
    console.log data
  prefetchAllRequest: =>
    $.ajax {
      url: '/prefetch-all'
      dataType: 'json'
      success: @prefetchAllResponse
      error: => @prefetchAllResponse(false)
    }


  # saving code
  saveCodeRequest: (code) =>
    $.ajax {
      type: 'POST'
      url: '/save-code'
      dataType: 'json'
      data: { code: code }
      success: (data) => @saveCodeResponse(data.status)
      error: => @saveCodeResponse(false)
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
      error: => @compileCodeResponse(false)
    }

  compileCodeResponse: (result) =>

  # submitting a solution
  submitCodeRequest: (code) =>
    $.ajax {
      type: 'POST'
      url: '/submit'
      dataType: 'json'
      data: { code: code }
      success: (data) =>
        if data.status
          @submitCodeResponse(data)
        else
          @submitCodeResponse(false)
      error: => @submitCodeResponse(false)
    }

  submitCodeResponse: (result) =>
  