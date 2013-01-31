class ApiClient
  constructor: ->

  # prefetching
  loadAllRequest: =>
    $.ajax {
      url: '/load-all'
      dataType: 'json'
      success: @loadAllResponse
    }

  loadAllResponse: (data) =>
    console.log data

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
      success: (data) => if data.status then @submitCodeResponse(data) else @submitCodeResponse(false)
      error: => @submitCodeResponse(false)
    }

  submitCodeResponse: (result) =>
  