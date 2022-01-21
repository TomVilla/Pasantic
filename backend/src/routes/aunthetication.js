const express = require('express');
const router = express.Router();
const passport = require('passport');
const flash = require('connect-flash');
function PasanticApi(app) {
    const router = express.Router();
    app.use('/', router);
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

    router.get('/logout', (req, res)=>{
        res.json({"result": true})
        req.logOut();
    });
}

module.exports = PasanticApi;