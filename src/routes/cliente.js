const express = require('express');
const router = express.Router();
const dbConnection = require('../dbConnection');
const conn = dbConnection();
//rutas
router.get('/cliente', (req, res) => {
	conn.query('select');
	res.render('cliente', { regist: null });
});

module.exports = router;
