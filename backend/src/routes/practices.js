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
        db.query('SELECT * FROM pasantia p INNER JOIN empresa e ON p.idempresa=e.idempresa WHERE p.fechapublicacion=?', [fechapub], (err, rows)=>{
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
        db.query(`SELECT * FROM pasantia p INNER JOIN empresa e ON p.idempresa=e.idempresa WHERE p.descripcion=LIKE "%${keyword}%"`, (err, rows)=>{
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


    


}

module.exports = PasanticApi;