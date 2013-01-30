
express = require('express')
http = require('http')
path = require('path')
faye = require('faye')

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
)

app.configure('development', ->
  app.use(express.errorHandler())
)

app.get('/', (req, res) ->
  res.end("raz\ndwa\ntrzycztery")
)

app.get('/load-all', (req, res) ->
  res.json({type: 'hahaha'});
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
