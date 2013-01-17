class LocalStorage
  constructor: (@namespace) ->

  set: (key, value) =>
    $.jStorage.set("#{@namespace}/#{key}", value)

  get: (key) =>
    $.jStorage.get("#{@namespace}/#{key}")

  remove: (key) =>
    $.jStorage.deleteKey("#{@namespace}/#{key}")

  flush: =>
    for key in $.jStorage.index()
      if key.match("^#{@namespace}")
        $.jStorage.deleteKey(key)

  # prefetching all the stuff
  loadAllRequest: =>
    data = {}
    setTimeout( (=> @loadAllResponse(data)), 1000)
  loadAllResponse: (data) =>

  # saving code
  saveCodeRequest: (code) =>
    # async saving code, result ok
    result = true
    setTimeout( (=> @saveCodeResponse(result)), 1000)
  saveCodeResponse: (result) =>

  # compiling code
  compileCodeRequest: (data) =>
    result1 = true
    setTimeout( (=> @compileCodeResponse(result1)), 1000)
    result2 = { status: 'error', message: 'bla bla bla' }
    setTimeout( (=> @compileCodeIndication(result2)), 5000)
  compileCodeResponse: (result) =>
    # boolean result determining whether compilation has beed successfully queued
  compileCodeIndication: (result) => # websocket
    # indicated by websocket channel when compilation is finished

  # submitting code
  submitCodeRequest: (code) =>
    result1 = true
    setTimeout( (=> @submitCodeResponse(result1)), 1000)
    result2 = { status: 'waiting' }
    setTimeout( (=> @submitCodeIndication(result2)), 2000)
    result3 = { status: 'compiling' }
    setTimeout( (=> @submitCodeIndication(result3)), 4000)
    result4 = { status: 'running', progress: '10%' }
    setTimeout( (=> @submitCodeIndication(result4)), 6000)
    result5 = { status: 'running', progress: '70%' }
    setTimeout( (=> @submitCodeIndication(result5)), 8000)
    result6 = {
                status: 'finished', progress: '100%', code: 'passed',
                performance: { time: '3.26s', memory: '19325kb'},
                score: '315.23'
              }
    setTimeout( (=> @submitCodeIndication(result6)), 10000)
  submitCodeResponse: (result) =>
    # boolean result determining whether submission has been successfully received
  submitCodeIndication: (result) => # websocket
    # compilation status & progress update

  # async update of ranking
  rankingUpdateIndication: (ranking) =>
    




