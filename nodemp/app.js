/**
 * Module dependencies.
 */

var express      = require('express')
    , routes     = require('./routes')
    , http       = require('http')
    , path       = require('path');

var app = express();

// all environments
app.set('port', process.env.PORT || 80);
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
// app.use(express.favicon('public/favicon.ico'));
app.use(express.logger('dev'));
// app.use(express.bodyParser());
app.use(express.json());
app.use(express.urlencoded());
// 解析cookie
app.use(express.cookieParser());
// session存储和key

app.use(express.bodyParser());

app.use(express.static(path.join(__dirname, 'public')));


// development only
if ('development' == app.get('env')) {
    app.use(express.errorHandler());
}

http.createServer(app).listen(app.get('port'), function(){
    console.log('nodemp server listening on port ' + app.get('port'));
});

routes(app);
