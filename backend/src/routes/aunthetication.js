const express = require('express');
const router = express.Router();

router.get('/signup', (req, res)=>{
    res.send('Vista para Registro');
});

router.post('/signup', (req, res)=>{
    res.send('Vista que redirige al perfil');
});

router.get('/signin', (req, res)=>{
    res.send('Vista para logearse');
});

router.post('/signin', (req, res)=>{
    res.send('Vista para que una vez iniciado sesion vaya al perfil');
});

router.get('/profile',(req, res)=>{
    res.send('profile');
});

router.get('/logout', (req, res)=>{
    res.redirect('/signin');
});
module.exports = router;