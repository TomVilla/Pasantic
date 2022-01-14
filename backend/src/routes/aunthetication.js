const express = require('express');
const passport = require('passport');

function PasanticApi(app){
    const router = express.Router();
    app.use('/', router);
    router.get('/signup', (req, res)=>{
        res.send('Vista para Registro');
    });
    
    router.post('/signup', passport.authenticate('local.signup', {
        successRedirect: '/profile',
        failureRedirect: '/signup',
        failureMessage: true
    }));
    router.get('/signin', (req, res)=>{
        res.send('Vista para logearse');
    });
    
    router.post('/signin', passport.authenticate('local.signin', {
        successRedirect: '/profile',
        failureRedirect: '/signin',
        failureFlash: true
    }));
    
    router.get('/profile',(req, res)=>{
        res.send('profile');
    });
    
    router.get('/logout', (req, res)=>{
        res.redirect('/signin');
    });
}

module.exports =  PasanticApi;