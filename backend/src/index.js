const express = require('express');
const morgan = require('morgan');
const path = require('path');
const mysql = require('mysql');
const PasanticApiPractices = require('./routes/practices');
const PasanticApiAuth = require('./routes/aunthetication');
const session = require('express-session');
const MySqlSTORE= require('express-mysql-session');
const passport = require('passport');

const {database}=require('./keys');

//inicializaciones

var app = express();
require('./lib/passport');
//configuraciones
// app.set('port', process.env.PORT || 4000);
//Funciones cada vez el cliente pide algo

app.use(session({
    secret: 'fastmysqlnodessesion',
    resave: false,
    save: false,
    store: new MySqlSTORE(database)
}));

app.use(express.json());
//para aunthetication
app.use(passport.initialize());
app.use(passport.session());
//Variables globales

//Rutas 
//app.use(require('./routes/index'));
//app.use(require('./routes/aunthetication'));

PasanticApiPractices(app);
PasanticApiAuth(app);
//empezar el server 
app.listen(3000, () => {
    console.log('Server on port3000');
});

module.exports = app;