module.exports = function(application){
    application.get('/isUp',(req,resp)=>{
        resp.json('API disponivel para consulta, servidor esta no ar !');
    })
}