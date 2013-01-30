
express = require 'express'
http = require 'http'
path = require 'path'
faye = require 'faye'
sugar = require 'sugar'
stub_data = require './stub_data'
data = new stub_data.StubData()

app = express()

bayeux = new faye.NodeAdapter {
  mount: '/faye'
  timeout: 45
}

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.static(path.join(__dirname, '../www-prototype'))

app.configure 'development', ->
  app.use express.errorHandler()

### API calls ###

app.get '/load-all', (req, res) ->
  res.json data.all_data()

app.post '/save-code', (req, res) ->
  if Number.random(0,4) != 0
    data.code = req.body.code
    res.json {status: true}
  else
    res.json {status: false}


compilationIndication = (time) ->
  status = if Number.random(0,2) == 0 then 'error' else 'success'
  if status == 'error'
    message = data.compilation_with_error
  else if Number.random(0,1) == 0
    message = data.compilation_with_warning
  else
    message = ''

  msg = {
    type: 'compile-code-indication'
    data: {
      status: status
      message: message
      time: parseFloat(time / 1000).toFixed(2)
    }
  }
  console.log "bayeux: broadcasting " + msg.type
  bayeux.getClient().publish '/broadcast', msg


app.post '/compile-code', (req, res) ->
  if Number.random(0,4) != 0
    data.code = req.body.code
    time = Number.random(300, 4000)
    setTimeout compilationIndication, time, time
    res.json {status: true}
  else
    res.json {status: false}


rankingIndication = ->
  msg = {
    type: 'ranking-indication'
    data: data.updateRanking()
  }
  console.log "bayeux: broadcasting " + msg.type
  bayeux.getClient().publish '/broadcast', msg

submitIndication = (msg) ->
  msg = {
    type: 'submit-indication'
    data: msg
  }
  console.log "bayeux: broadcasting " + msg.type
  bayeux.getClient().publish '/broadcast', msg
  if msg.data.status == 'finished' and msg.data.code == 'passed'
    rankingIndication()


app.post '/submit', (req, res) ->
  if Number.random(0,4) != 0
    data.code = req.body.code
    subId = Number.random(10, 1000)
    result1 = { id: subId, timestamp: Date.create().format('{yyyy}-{MM}-{dd} {HH}:{mm}:{ss}'), status: 'waiting' }
    if result1
      result2 = { id: subId, status: 'compiling' }
      setTimeout submitIndication, 300, result2
      result3 = { id: subId, status: 'running', progress: 20 }
      setTimeout submitIndication, 600, result3
      result4 = { id: subId, status: 'running', progress: 40 }
      setTimeout submitIndication, 900, result4
      result5 = { id: subId, status: 'running', progress: 50 }
      setTimeout submitIndication, 1500, result5
      result6 = { id: subId, status: 'running', progress: 60 }
      setTimeout submitIndication, 1900, result6
      result7 = { id: subId, status: 'running', progress: 70 }
      setTimeout submitIndication, 2100, result7
      result8 = { id: subId, status: 'running', progress: 90 }
      setTimeout submitIndication, 2500, result8
      result9 = data._generateFinishedSubmissionStatus(subId)
      setTimeout submitIndication, 2800, result9
    res.json result1
  else
    res.json {status: false}



app.get '/test', (req, res) ->
  bayeux.getClient().publish '/broadcast', { text: "kaka demona" }
  res.json {type: 'OK'}

### listen HTTP ###

server = http.createServer app
bayeux.attach server
server.listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
