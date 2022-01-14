const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const dbConnection = require('../config/config');
const helpers = require('./helpers');
const db = dbConnection();

passport.use('local.signin', new LocalStrategy({
    usernameField: 'correo',
    passwordField: 'contraseña',
    passReqToCallback: true
}, async(req, correo, contraseña, done)=>{
    const rows = await db.query('SELECT * FROM estudiante WHERE correo =?',[correo]);
    if (rows.length>0){
        const user = rows[0];
        //const validPass = await helpers.matchPass(contraseña, user.contraseña);
        if(validPass){
            //Aqui debería presentarse un mensaje de bienvenida desde DART
            //Por eso dejare comentado esta linea
            done(null, user, console.log('welcome'));
        } else {
            done(null, false,console.log('Contraseña incorrecta'));
        }
    }else{
        return done(null, false, console.log('El usuario no existe'));
    }
}));

/**
 * Usaremos el correo para tener la validacion del login
 * pero también al momento de registrar al usuario, debemos pedir la contraseña
 * Y explicarle que passport siempre va a pedir un campo usernameField (no existe emailField)
 * entonces solo le cambia el valor que por usuarioField se le dará el correo.
 * Al momento de insertar el registro insertamos los campos, sabiendo que falta el de la contraseña
 * por ahora voy a dejar comentar el proceso para encryptar
 */
passport.use('local.signup', new LocalStrategy({
    usernameField: 'correo',
    passwordField: 'contraseña',
    passReqToCallback: true

}, async(req, correo, contraseña, done)=>{
    const {nombre} = req.body;
    const {apellido} = req.body;
    const {celular} = req.body;
    const {direccion} = req.body;
    const nuevoEstudiante = {
        nombre,
        apellido,
        correo,
        celular,
        direccion,
        contraseña
    };
    //nuevoEstudiante.password = await helpers.encryptPass(contraseña);
    //de esta forma se guarda la contraseña como texto plano
    const result = await db.query('INSERT INTO estudiante SET ?', [nuevoEstudiante]);
    nuevoEstudiante.id = result.insertId;
    return done(null, nuevoEstudiante);
}));