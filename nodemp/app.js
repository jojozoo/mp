/**
 * Module dependencies.
 */

var express      = require('express')
    , routes     = require('./routes')
    , http       = require('http')
    , path       = require('path');

var app = express();

// all environments
app.set('port', process.env.PORT || 8080);
app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
// app.use(express.favicon('public/favicon.ico'));
app.use(express.logger('dev'));
// app.use(express.bodyParser());

// // 等同于:
// app.use(express.json());
// app.use(express.urlencoded());
// app.use(express.multipart());
app.use(express.bodyParser());
// 解析cookie
app.use(express.cookieParser());
// session存储和key

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
