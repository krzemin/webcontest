
express = require 'express'
http = require 'http'
path = require 'path'
faye = require 'faye'
sugar = require 'sugar'
mongoose = require 'mongoose'
async = require 'async'
stub_data = require './stub_data'
data = new stub_data.StubData()

db_url = 'mongodb://localhost/webcontest'
db = mongoose.connect(db_url)

Schema = mongoose.Schema
ObjectId = mongoose.Schema.ObjectId
Mixed = mongoose.Schema.Types.Mixed

ProblemSchema = new Schema({
  id: ObjectId
  name: String
  limits: Mixed
  content: String
  input: String
  output: String
  examples: [Mixed]
})

SubmissionSchema = new Schema({
  id: ObjectId
  timestamp: Date
  status: String
  progress: Number
  code: String
  performance: Mixed
  score: Number
})

mongoose.model('Problem', ProblemSchema)
mongoose.model('Submission', SubmissionSchema)

Problem = mongoose.model('Problem')
Submission = mongoose.model('Submission')

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

app.get '/prefetch-all', (req, res) ->
  prefetch_data = data.all_data()
  async.parallel [
    (callback) ->
      Problem.find().execFind (err, problems) ->
        i = Number.random(problems.length-1)
        prefetch_data.problem = problems[i]
        callback err
    (callback) ->
      Submission.find({}, null, {sort: { timestamp: -1}}).execFind (err, submissions) ->
        prefetch_data.submissions = submissions
        callback err
    ], (err) ->
      if err
        res.json { status: false }
      else
        res.json prefetch_data

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
  Submission.findById msg._id, (err, s) =>
    if err
      console.log 'submitIndication: error on getting submission by id'
    else
      s.set('status', msg.status)
      s.set('code', msg.code) if msg.code
      s.set('score', msg.score) if msg.score
      s.set('performance', msg.performance) if msg.performance
      s.save (err) =>
        if err
          console.log 'submitIndication:: error on saving submission'
        else
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
    s = new Submission { timestamp: Date.create(), status: 'waiting' }
    s.save (err) =>
      if err
        console.log '/submit => error on saving submission'
        res.json {status: false}
      else
        result2 = { _id: s._id, status: 'compiling' }
        setTimeout submitIndication, 300, result2
        result3 = { _id: s._id, status: 'running', progress: 20 }
        setTimeout submitIndication, 600, result3
        result4 = { _id: s._id, status: 'running', progress: 40 }
        setTimeout submitIndication, 900, result4
        result5 = { _id: s._id, status: 'running', progress: 50 }
        setTimeout submitIndication, 1500, result5
        result6 = { _id: s._id, status: 'running', progress: 60 }
        setTimeout submitIndication, 1900, result6
        result7 = { _id: s._id, status: 'running', progress: 70 }
        setTimeout submitIndication, 2100, result7
        result8 = { _id: s._id, status: 'running', progress: 90 }
        setTimeout submitIndication, 2500, result8
        result9 = data._generateFinishedSubmissionStatus(s._id)
        setTimeout submitIndication, 2800, result9
        res.json s.toObject()
  else
    res.json {status: false}

app.get '/test', (req, res) ->
  rankingIndication()
  res.json {type: 'OK'}

### listen HTTP ###

server = http.createServer app
bayeux.attach server
server.listen app.get('port'), ->
  console.log "Express server listening on port " + app.get('port')
