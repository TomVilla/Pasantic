const helpers = {};
const bcrypt = require('bcryptjs');
helpers.encryptPass = async (contra) =>{
    const salt = await bcrypt.genSalt(10);
    const hash = await bcrypt.hash(contra, salt);
    return hash;
};
helpers.matchPass = async (contra, contraGuardada) =>{
    try {
        return await bcrypt.compare(contra, contraGuardada);
    }catch(e){
        console.log(e);
    }
};
module.exports = helpers;