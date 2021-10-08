const express = require('express');
const router = express.Router();
const dbConnection = require('../dbConnection');
const conn = dbConnection();
//rutas
router.get('/jefe', (req, res) => {
	res.render('jefe', { regist: null });
});

module.exports = router;
