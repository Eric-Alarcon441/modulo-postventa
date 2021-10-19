const express = require('express');
const router = express.Router();
const dbConnection = require('../dbConnection');
const conn = dbConnection();
//rutas
router.get('/', (req, res) => {
	req.session.message = { message: null, regist: null };
	const { regist, message } = req.session.message;
	res.render('login', { regist, message });
});

router.post('/', async (req, res) => {
	const { email, password } = req.body;
	await conn.query(
		'select * from usuario as u where u.email = ? and u.password = ?',
		[email, password],
		(err, rows) => {
			if (rows.length > 0) {
				const email = rows[0].email;
				const idUsuario = rows[0].id_usuario;
				if (rows[0].id_role == 2) {
					req.session.message = { regist: 'jefe', email, idUsuario };
					res.redirect('/jefe');
				} else {
					req.session.message = {
						regist: 'cliente',
						email,
						idUsuario,
					};
					res.redirect('/cliente');
				}
			} else {
				req.session.message = { regist: null };
				const { regist } = req.session.message;
				res.render('login', {
					message: 'usuario o contraseña incorrecto',
					regist,
				});
			}
		}
	);
});

module.exports = router;
