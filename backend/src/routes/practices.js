const express = require('express');
const dbConnection = require('../config/config');
function PasanticApi(app){
    const db = dbConnection();
    const router = express.Router();
    app.use('/', router);
    //tommy-----------------------------------------
    //todas las pasantias
    router.get('/practices/all', (req, res)=>{
        
        db.query('SELECT * FROM pasantia p INNER JOIN empresa e ON p.idempresa=e.idempresa', (err, rows)=>{
            if(err){
                res.status(500).json({
                    ok: false,
                    err
                });
            }else{
                res.json({
                    rows
                });
            }
        });
    });

    //pasantias por fechapublicacion, devolver el nombre de la empresa y su correo y telefono
    //pensarla mejor
    router.get('/practices/fecha/:fechapub', (req, res)=>{
        var fechapub = req.params.fechapub;
        //obtener las pasantias publicadas, dias antes un mes antes y 3 meses antes
        db.query('SELECT * FROM pasantia p INNER JOIN empresa e ON p.idempresa=e.idempresa WHERE p.fechapub=?', [fechapub], (err, rows)=>{
            if(err){
                res.status(500).json({
                    ok: false,
                    err
                });
            }else{
                res.json({
                    rows
                });
            }
        });
    });

    //pasantias por palabra clave
    router.get('/practices/keyword/:keyword', (req, res)=>{
        var keyword = req.params.keyword
        //obtener las pasantias que en su descripcion contengan la palabra clave
        db.query(`SELECT * FROM pasantia p INNER JOIN empresa e ON p.idempresa=e.idempresa WHERE p.descripcion LIKE '%${keyword}%'`, (err, rows)=>{
            if(err){
                res.status(500).json({
                    ok: false,
                    err
                });
            }else{
                res.json({
                    rows
                });
            }
        });
    });

    //tommy-----------------------------------------

    // -------------------------------Comienzo Luis Carlos Sanchez Plaza-----------------------------------------------
    //agregar una pasantia a favoritos
    router.post('/practices/addfav', (req, res)=>{
        var idpasantia = req.body.idpasantia;
        var idestudiante = req.body.idestudiante;
        db.query(`INSERT INTO favorito (idpasantia, idestudiante) VALUES (${idpasantia}, ${idestudiante})`, (err, rows)=>{
            if(err){
                res.status(500).json({
                    ok: false,
                    err
                });
            }else{
                res.json({
                    rows
                });
            }
        });
    });

    //ver pasantias favoritas por id de estudiante
    router.get('/practices/fav/:id', (req, res)=>{
        var idestudiante = req.params.id;
        db.query(`SELECT * FROM favorito f INNER JOIN pasantia p ON f.idpasantia = p.idpasantia WHERE f.idestudiante = ${idestudiante};`, (err, rows)=>{
            if(err){
                res.status(500).json({
                    ok: false,
                    err
                });
            }else{
                res.json({
                    rows
                });
            }
        });
    });

    //eliminar una pasantia de favoritos
    router.delete('/practices/delfav/:idpasantia/:idestudiante', (req, res)=>{
        var idpasantia = req.params.idpasantia;
        var idestudiante = req.params.idestudiante;
        db.query(`DELETE FROM favorito WHERE idpasantia = ${idpasantia} and idestudiante = ${idestudiante}`, (err, rows)=>{
            if(err){
                res.status(500).json({
                    ok: false,
                    err
                });
            }else{
                res.json({
                    rows
                });
            }
        });
    });

    //postular a una pasantia
    router.post('/practices', (req, res)=>{
        var body = req.body;
        var idpasantia = body.idpasantia;
        var idestudiante = body.idestudiante;
        var estado = "postulado";
        var comentarios = body.comentarios;
      
        db.query(`INSERT INTO postulacion (idpasantia, idestudiante, estado, comentarios) VALUES (${idpasantia}, ${idestudiante}, "${estado}", "${comentarios}")`, (err, rows)=>{
            if(err){
                res.status(500).json({
                    ok: false,
                    err
                });
            }else{
                //restar 1 en el atributo disponibles de la pasantia
                db.query(`UPDATE pasantia SET disponibilidad = disponibilidad - 1 WHERE idpasantia = ${idpasantia}`); 
                res.json({
                    rows
                });
                
            }
        }
        );
    })
}
// -------------------------------Fin Luis Carlos Sanchez Plaza-----------------------------------------------

module.exports = PasanticApi;