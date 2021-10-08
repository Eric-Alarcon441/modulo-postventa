const express = require('express');
const router = express.Router();
const dbConnection = require('../dbConnection');
const conn = dbConnection();
//rutas
router.get('/cliente', (req, res) => {
	const { regist, email } = req.session.message;
	conn.query('select * from servicio', (err, servicios) => {
		conn.query('select * from asesor', (err, asesores) => {
			conn.query(
				'select s.nom_serv,a.nom_as, v.calificacion from venta as v, servicio as s, asesor as a, usuario as u where a.id_asesor= v.id_asesor and s.id_servicio=v.id_servicio and v.id_usuario = u.id_usuario and u.email =  ?',
				[email],
				(err, result) => {
					res.render('cliente', {
						regist,
						servicios,
						asesores,
						result,
					});
				}
			);
		});
	});
});
router.post('/cliente', (req, res) => {
	const { servicio, asesor, calificacion } = req.body;
	const { idUsuario } = req.session.message;
	conn.query(
		'insert into venta values (null,?,?,?,?) ',
		[idUsuario, servicio, asesor, calificacion],
		(err, rows) => {
			res.redirect('/cliente');
		}
	);
});

module.exports = router;
