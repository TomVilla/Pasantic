const express = require('express');
//se requiere la libreia
const passport = require('passport');
const flash = require('connect-flash');
function PasanticApi(app) {
    const router = express.Router();
    app.use('/', router);
    //Para proteger la ruta
    //const {isLoggedIn , isNotLoggedIn} = require('../lib/auth');
    //Recibir los datos del formulario
    router.post('/signup', passport.authenticate('local.signup', {
        successRedirect: '/correcto',
        failureRedirect: '/error'
    }));
    router.post('/signin', (req, res, next) => {
        passport.authenticate('local.signin', {
            successRedirect: '/correcto',
            failureRedirect: '/error'
        });
    });

    router.get('/correcto', (req, res) => {
        res.json({"result": true})
    });

    router.get('/error', (req, res) => {
        res.json({"result": false})
    });
}

module.exports = PasanticApi;