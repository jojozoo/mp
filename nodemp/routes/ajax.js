module.exports = function(app){

    app.get('/check/:key', function(req, res){
        console.log(req.params.key);
        res.send('success');
    });
}