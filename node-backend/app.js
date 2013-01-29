
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , user = require('./routes/user')
  , http = require('http')
  , path = require('path')
  , faye = require('faye');

var app = express();

var bayeux = new faye.NodeAdapter({
  mount:    '/faye',
  timeout:  45
});

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});

app.get('/', routes.index);
app.get('/users', user.list);
app.get('/test', function(req, res){
  //bayeux.getClient().publish('/channel', {text: req.body.message});
  bayeux.getClient().publish('/broadcast', {text: "kaka demona"});
  res.end('Hahaha, OK ;)');
});

bayeux.attach(app);

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
