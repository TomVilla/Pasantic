const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const dbConnection = require('../config/config');
const helpers = require('../lib/helpers');
const db = dbConnection();
global.idEstudianteGl = undefined;
passport.use('local.signin', new LocalStrategy({
    usernameField: 'correo',
    passwordField: 'contra',
    passReqToCallback: true
}, (req, correo, contra, done) => {
    db.query('SELECT * FROM estudiante WHERE correo =?', [correo], async (err, rows) => {
        if (err) {
            console.error(err);
        } else {
            if (rows.length > 0) {
                const estudiante = rows[0];
                const validPass = await helpers.matchPass(contra, estudiante.contra);
                if (validPass) {
                    idEstudianteGl = estudiante.idEstudiante;
                    done(null, estudiante, console.log('Welcome ' + estudiante.nombre));
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

}, async (req, correo, contra, done) => {
    const { nombre } = req.body;
    const { celular } =req.body;
    const { universidad } = req.body;
    const { carrera } = req.body;
    const nuevoEstudiante = {
        nombre,
        celular,
        universidad,
        carrera,
        correo,
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
            return done(null, nuevoEstudiante);
        }
    });

}));

passport.serializeUser((estudiante, done) => {
    done(null, estudiante.idEstudiante);
});

passport.deserializeUser((idEstudiante, done) => {
     db.query('SELECT * FROM estudiante WHERE idEstudiante = ?', [idEstudiante], (err, rows) => {
        if (err) {
            console.error(err);
        } else {
            if (rows.length > 0) {
                done(null, rows[0]);
            }
        }
    });
});
