const express = require('express');
const PasanticApiPractices = require('./routes/practices');
const PasanticApiAuth = require('./routes/aunthetication');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const passport = require('passport');
const cors = require('cors');
const {database}=require('./keys');


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

app.use(passport.initialize());
app.use(passport.session());

PasanticApiPractices(app);
PasanticApiAuth(app);


app.listen(3000, () => {
    console.log('Server on port 3000');
});

module.exports = app;
