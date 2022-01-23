const express = require('express');
const dbConnection = require('../config/config');
function PasanticApi(app) {
    const db = dbConnection();
    const router = express.Router();
    app.use('/', router);

    router.get('/practices/all', (req, res) => {

        db.query('SELECT * FROM pasantia p INNER JOIN empresa e ON p.idempresa=e.idempresa', (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                res.json({
                    rows
                });
            }
        });
    });

    router.get('/practices/findone/:id', (req, res) => {
        var idpasantia = req.params.id;
        db.query(`SELECT * FROM pasantia p INNER JOIN empresa e ON p.idempresa=e.idempresa WHERE p.idpasantia = ${idpasantia}`, (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                res.json({
                    rows
                });
            }
        });
    });
    
    router.get('/practices/keyword/:keyword', (req, res) => {
        var keyword = req.params.keyword

        db.query(`SELECT * FROM pasantia p INNER JOIN empresa e ON p.idempresa=e.idempresa WHERE p.descripcion LIKE '%${keyword}%'`, (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                res.json({
                    rows
                });
            }
        });
    });

    router.get('/profile', (req, res) => {
        db.query(`SELECT * FROM estudiante WHERE idestudiante = ${idEstudianteGl};`, (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                res.json({
                    rows
                });
            }
        });
    });
    router.get('/practices/fav/all', (req, res) => {
        db.query(`SELECT * FROM favorito f INNER JOIN pasantia p INNER JOIN empresa e WHERE f.idestudiante = ${idEstudianteGl} AND f.idpasantia = p.idpasantia AND p.idempresa = e.idempresa;`, (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                res.json({
                    rows
                });
            }
        });
    });
    router.get('/practices/fav/ver/:id', (req, res) => {
        var idpasantia = req.params.id;
        db.query(`SELECT * FROM favorito WHERE idestudiante = ${idEstudianteGl} AND idpasantia = ${idpasantia};`, (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                res.json({
                    rows
                });
            }
        });
    });
    router.post('/practices/fav/add/:id', (req, res) => {
        var idpasantia = req.params.id;
        db.query(`INSERT INTO favorito (idpasantia, idestudiante) VALUES (${idpasantia}, ${idEstudianteGl})`, (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                res.json({
                    rows
                });
            }
        });
    });

    router.delete('/practices/fav/delete/:id', (req, res) => {
        var idpasantia = req.params.id;

        db.query(`DELETE FROM favorito WHERE idpasantia = ${idpasantia} AND idestudiante = ${idEstudianteGl};`, (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                res.json({
                    rows
                });
            }
        });
    });
    router.get('/practices/post/all', (req, res) => {

        db.query(`SELECT * FROM postulacion post INNER JOIN pasantia p INNER JOIN empresa e WHERE post.idestudiante = ${idEstudianteGl} AND post.idpasantia = p.idpasantia AND p.idempresa = e.idempresa`, (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                res.json({
                    rows
                });
            }
        });
    });
    router.get('/practices/post/ver/:id', (req, res) => {
        var idpasantia = req.params.id;
        db.query(`SELECT * FROM postulacion WHERE idestudiante = ${idEstudianteGl} AND idpasantia = ${idpasantia};`, (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                res.json({
                    rows
                });
            }
        });
    });
    router.post('/practices/post/add/:id', (req, res) => {
        var idpasantia = req.params.id;
        var estado = "Postulado";
        var comentarios = "Sin comentarios";

        db.query(`INSERT INTO postulacion (idpasantia, idestudiante, estado, comentarios) VALUES (${idpasantia}, ${idEstudianteGl}, "${estado}", "${comentarios}")`, (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                db.query(`UPDATE pasantia SET disponibilidad = disponibilidad - 1 WHERE idpasantia = ${idpasantia}`);
                res.json({
                    rows
                });
            }
        });
    })
    router.delete('/practices/post/delete/:id', (req, res) => {
        var idpasantia = req.params.id;
        db.query(`UPDATE pasantia SET disponibilidad = disponibilidad + 1 WHERE idpasantia = ${idpasantia}`, (err, rows) => {
            if (err) {
                res.status(500).json({
                    ok: false,
                    err
                });
            } else {
                db.query(`DELETE FROM postulacion WHERE idpasantia = ${idpasantia} AND idestudiante = ${idEstudianteGl}`);
                res.json({
                    rows
                });

            }
        }
        );
    });

}

module.exports = PasanticApi;