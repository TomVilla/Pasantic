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
    //obtener informacion del perfil
    router.get('/profile', (req, res)=>{
        db.query(`SELECT * FROM estudiante WHERE idestudiante = ${idEstudianteGl};`, (err, rows)=>{
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
    
    //agregar una pasantia a favoritos
    router.post('/practices/addfav/:id', (req, res)=>{
        var idpasantia = req.params.id;
        db.query(`INSERT INTO favorito (idpasantia, idestudiante) VALUES (${idpasantia}, ${idEstudianteGl})`, (err, rows)=>{
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

    //verificar si la pasantia ya esta en favoritos
    router.get('/practices/verfav/:id', (req, res)=>{
        var idpasantia = req.params.id;
        db.query(`SELECT * FROM favorito WHERE idestudiante = ${idEstudianteGl} AND idpasantia = ${idpasantia};`, (err, rows)=>{
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
    router.get('/practices/fav', (req, res)=>{
        db.query(`SELECT * FROM favorito f INNER JOIN pasantia p ON f.idpasantia = p.idpasantia WHERE f.idestudiante = ${idEstudianteGl};`, (err, rows)=>{
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
    router.delete('/practices/delfav/:idpasantia', (req, res)=>{
        var idpasantia = req.params.idpasantia;
        
        db.query(`DELETE FROM favorito WHERE idpasantia = ${idpasantia} and idestudiante = ${idEstudianteGl}`, (err, rows)=>{
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

    //verificar si ya se ha postulado a una pasantia
    router.get('/practices/verpost/:id', (req, res)=>{
        var idpasantia = req.params.id;
        db.query(`SELECT * FROM postulacion WHERE idestudiante = ${idEstudianteGl} AND idpasantia = ${idpasantia};`, (err, rows)=>{
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
    router.post('/practices/post/:id', (req, res)=>{
        var idpasantia = req.params.id;
        var estado = "postulado";
        var comentarios = "Sin comentarios";
      
        db.query(`INSERT INTO postulacion (idpasantia, idestudiante, estado, comentarios) VALUES (${idpasantia}, ${idEstudianteGl}, "${estado}", "${comentarios}")`, (err, rows)=>{
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
        });
    })
    // -------------------------------Fin Luis Carlos Sanchez Plaza-----------------------------------------------
    //PAUL------------------------------------------
    //ver mis postulaciones
    router.get('/practices/mypostulations', (req, res)=>{
        
        db.query(`SELECT * FROM postulacion WHERE idestudiante = ${idEstudianteGl}`, (err, rows)=>{
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

   //eliminar una postulacion
    router.delete('/practices/mypostulations/:id', (req, res)=>{
        var idpostulacion = req.params.id;
        db.query(`UPDATE pasantia SET disponibilidad = disponibilidad + 1 WHERE idpasantia = (SELECT idpasantia FROM postulacion WHERE idpostulacion = ${idpostulacion} AND idestudiante = ${idEstudianteGl})`, (err, rows)=>{
            if(err){
                res.status(500).json({
                    ok: false,
                    err
                });
            }else{
                db.query(`DELETE FROM postulacion WHERE idpostulacion = ${idpostulacion}`);
                res.json({
                    rows
                });
                
            }
        }
        );    
    });
    
}

module.exports = PasanticApi;