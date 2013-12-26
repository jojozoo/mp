/**
 * Module dependencies.
 */

var express      = require('express')
    , routes     = require('./routes')
    , http       = require('http')
    , path       = require('path');

var app = express();
app.all('*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "X-Requested-With");
    res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
    res.header("X-Powered-By",' 3.2.1');
    // res.header("Content-Type", "application/json;charset=utf-8");
    next();
});
// all environments
app.set('port', process.env.PORT || 8080);
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.cookieParser());

app.use(express.session({
    key: '_mp_session',
    secret: '1c4e7ba050e27cfb027e68980fd5ba1299f19175b1e4c10bc2d934e811ae5a7c8e0a4716753aa25485948b62a8792fa920f423e459e1d5309f48a1ec4988512c',
    cookie: {domain: '.manpai.com', path: '/'}
}));

app.use(express.static(path.join(__dirname, 'public')));


// development only
if ('development' == app.get('env')) {
    app.use(express.errorHandler());
}

http.createServer(app).listen(app.get('port'), function(){
    console.log('nodemp server listening on port ' + app.get('port'));
});

routes(app);
