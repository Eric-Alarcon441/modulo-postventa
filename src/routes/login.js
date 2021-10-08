const express = require('express');
const router = express.Router();
const dbConnection = require('../dbConnection');
const conn = dbConnection();
//rutas
router.get('/', (req, res) => {
	res.render('login', { message: null, regist: null });
});

router.post('/', async (req, res) => {
	const { email, password } = req.body;
	await conn.query(
		'select * from usuario as u where u.email = ? and u.password = ?',
		[email, password],
		(err, rows) => {
			if (rows.length > 0) {
				if (rows[0].id_role == 2) {
					res.redirect('jefe', { regist: true });
				} else {
					res.redirect('cliente', { regist: true });
				}
			} else {
				res.redirect('login', { message: 'Usuario o contraseña incorrecta' });
			}
		}
	);
});

module.exports = router;
