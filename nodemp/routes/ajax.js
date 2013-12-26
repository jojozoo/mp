module.exports = function(app){

    app.get('/check/:name', function(req, res){
        console.log(req.query.key);
        console.log(req.params.name);
        res.send('success');
    });
}