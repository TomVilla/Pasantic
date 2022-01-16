const express = require('express');
//se requiere la libreia
const passport = require('passport');
const flash = require('connect-flash');
function PasanticApi(app) {
    const router = express.Router();
    app.use('/', router);
    //Para proteger la ruta
    //const {isLoggedIn , isNotLoggedIn} = require('../lib/auth');
    //Renderizar el formulario
    router.get('/signup', (req, res) => {
        res.send('Vista de Registro');
    });
    //Recibir los datos del formulario
    router.post('/signup', passport.authenticate('local.signup', {
        successRedirect: '/profile',
        failureRedirect: '/signup'
    }));
    router.get('/signin', (req, res) => {
        res.send('Vista de Inicio de Sesión');
    });
    router.post('/signin', (req, res, next) => {
        passport.authenticate('local.signin', {
            successRedirect: '/profile',
            failureRedirect: '/signin'
        })(req, res, next);
    });

    router.get('/profile', (req, res) => {
        res.send('Vista de Perfil');
    });

    router.get('/logout', (req, res) => {
        req.logOut();
        res.redirect('/signin');
    });
}

module.exports = PasanticApi;