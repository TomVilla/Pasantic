const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const dbConnection = require('../config/config');
const helpers = require('../lib/helpers');
const db = dbConnection();
passport.use('local.signin', new LocalStrategy({
    usernameField: 'correo',
    passwordField: 'contra',
    passReqToCallback: true
}, async (req, correo, contra, done) => {
    db.query('SELECT * FROM estudiante WHERE correo =?', [correo], (err, rows) => {
        if (err) {
            console.error(err);
        } else {
            if (rows.length > 0) {
                const estudiante = rows[0];
                const validPass = helpers.matchPass(contra, estudiante.contra);
                if (validPass) {
                    done(null, estudiante, console.log('Welcome'));
                } else {
                    done(null, false, console.log('Incorrect Pass'));
                }
            } else {
                return done(null, false, console.log('El usuario no existe'));
            }
        }
    }
    );
}));
passport.use('local.signup', new LocalStrategy({
    usernameField: 'correo',
    passwordField: 'contra',
    passReqToCallback: true


}, async (req, done) => {
    const { nombre } = req.body.nombre;
    const { telefono } = req.body.telefono;
    const { universidad } = req.body.universidad;
    const { carrera } = req.body.carrera;
    const { email } = req.body.email;
    const { contra } = req.body.contra;

    const nuevoEstudiante = {
        nombre,
        telefono,
        universidad,
        carrera,
        email,
        contra
    };
    nuevoEstudiante.contra = await helpers.encryptPass(contra);
    //de esta forma se guarda la contraseña como texto plano
    db.query('INSERT INTO estudiante SET ?', [nuevoEstudiante], (err, rows)=>{
        if(err){
            console.error(err);
        }else{
            const result = rows;
            nuevoEstudiante.idEstudiante = result.insertId;
            return done(null, nuevoEstudiante, );
        }
    });

}));

passport.serializeUser((nuevoEstudiante, done) => {
    done(null, nuevoEstudiante.idEstudiante);
});

passport.deserializeUser(async (idEstudiante, done) => {
    const rows = await db.query('SELECT * FROM estudiante WHERE idEstudiante = ?', [idEstudiante]);
    done(null, rows);
});
