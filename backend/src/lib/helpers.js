const helpers = {};
const bcrypt = require('bcryptjs');
helpers.encryptPass = async (contraseña) =>{
    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(contraseña, salt);
    return hash;
};
helpers.matchPass = async (contraseña, contraseñaGuardada) =>{
    try {
        return await bcrypt.compare(contraseña, contraseñaGuardada);
    }catch(e){
        console.log(e);
    }
};
module.exports = helpers;