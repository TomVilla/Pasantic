const express = require('express');
const router = express.Router();
//se requiere la libreia
const passport = require('passport');
const flash = require('connect-flash');
function PasanticApi(app) {
    const router = express.Router();
    app.use('/', router);
    //Para proteger la ruta
    //const {isLoggedIn , isNotLoggedIn} = require('../lib/auth');
    //Renderizar el formulario
    //Recibir los datos del formulario
    /*
    router.post('/signup', (req, res)=> {
        passport.authenticate('local.signup', {
            successRedirect: '/correcto',
            failureRedirect: '/error'
        });
        res.json({success: true, msg: 'Successfully Saved'})
        //res.json({success: true, msg: 'Successfully Saved'});
    });
       */ 
       
    router.post('/signup', passport.authenticate('local.signup', {
        successRedirect: '/correcto',
        failureRedirect: '/error'
    }));
    
    router.post('/signin', (req, res, next) => {
        passport.authenticate('local.signin', {
            successRedirect: '/correcto',
            failureRedirect: '/error'
        })(req, res, next);
    });

    router.get('/correcto', (req, res) => {
        res.json({"result": true})
        
    });

    router.get('/error', (req, res) => {
        res.json({"result": false})
    });
}

module.exports = PasanticApi;