const express = require('express');
const router = express.Router();

router.get('/',  (req, res)=> {
    res.send('Proyecto de Lenguaje');
});

module.exports = router;