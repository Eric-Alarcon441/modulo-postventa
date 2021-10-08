const express = require('express');
const router = express.Router();
const dbConnection = require('../dbConnection');
const conn = dbConnection();
//rutas
router.get('/jefe', (req, res) => {
	const { regist } = req.session.message;
	conn.query(
		'select s.nom_serv, a.nom_as, v.calificacion from venta as v, asesor as a, servicio as s  WHERE a.id_asesor = v.id_asesor and s.id_servicio = v.id_servicio ORDER BY nom_serv;',
		(err, rows) => {
			conn.query('select * from avisos', (err, avisos) => {
				res.render('jefe', { regist, rows, avisos });
			});
		}
	);
});

module.exports = router;
