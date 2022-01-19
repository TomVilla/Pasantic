const express = require('express');
const PasanticApiPractices = require('./routes/practices');
const PasanticApiAuth = require('./routes/aunthetication');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const passport = require('passport');
const cors = require('cors');
const {database}=require('./keys');

//inicializaciones

const app = express();
require('./lib/passport');

app.use(session({
    secret: 'faztmysqlnodemysql',
    resave: false,
    save: false,
    store: new MySQLStore(database)
}));


app.use(express.json());
app.use(cors({origin: "http://localhost:8000"}));
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
