
/*
 * GET home page.
 */
// req.query 处理 get 请求
// req.params 处理 /:xxx 形式的 get 请求
// req.body 处理 post 请求
// req.param(name) 可以处理 get 和 post 请求，但查找优先级由高到低为 req.params→req.body→req.query
// 写adapter
module.exports = function(app){

    // global admin filter
    app.use(function (req, res, next) {
        console.log(req.url);
        next();
        
    });
    
    app.use(app.router);
    // AJAX
    require('./ajax')(app);
}




