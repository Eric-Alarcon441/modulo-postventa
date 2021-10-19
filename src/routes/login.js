const express = require('express');
const router = express.Router();
const dbConnection = require('../dbConnection');
const conn = dbConnection();
//rutas
router.get('/', (req, res) => {
	req.session.data = { regist: null, msg: null };
	res.render('login', req.session.data);
});

router.post('/', (req, res) => {
	const { email, password } = req.body;
	conn.query(
		'select * from usuario as u where u.email = ? and u.password = ?',
		[email, password],
		(err, rows) => {
			if (rows.length >= 1) {
				const { email, id_usuario } = rows[0];
				req.session.data = { email, id_usuario };
				rows[0].id_role == 2
					? ((req.session.data.regist = 'jefe'), res.redirect('/jefe'))
					: ((req.session.data.regist = 'cliente'), res.redirect('/cliente'));
			} else {
				req.session.data.msg = 'usuario o contraseña incorrecto';
				res.render('login', req.session.data);
			}
		}
	);
});

module.exports = router;
