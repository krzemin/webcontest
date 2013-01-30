
express = require('express')
http = require('http')
path = require('path')
faye = require('faye')
sugar = require('sugar')
stub_data = require('./stub_data')
data = new stub_data.StubData()

app = express()

bayeux = new faye.NodeAdapter({
  mount: '/faye'
  timeout: 45
})

app.configure( ->
  app.set('port', process.env.PORT || 3000)
  app.use(express.logger('dev'))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(express.static(path.join(__dirname, '../www-prototype')))
)

app.configure('development', ->
  app.use(express.errorHandler())
)

app.get('/load-all', (req, res) ->
  res.json(data.all_data())
)

app.post('/save-code', (req, res) ->
  if Number.random(0,4) != 0
    data.code = req.body.code
    res.json({status: true})
  else
    res.json({status: false})
)

app.get('/test', (req, res) ->
  bayeux.getClient().publish('/broadcast', {
    text: "kaka demona"
  })
  res.json({type: 'OK'})
)

server = http.createServer(app)
bayeux.attach(server)
server.listen(app.get('port'), ->
  console.log("Express server listening on port " + app.get('port'))
)
