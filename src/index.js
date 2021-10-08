const express = require('express');
const path = require('path');
const session = require('express-session');
const app = express();
const port = process.env.PORT || 3000;

//configuraciones
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

//middleware
app.use(express.urlencoded({ extended: true }));
app.use(
	session({
		secret: 'mySecret',
		resave: false,
		saveUninitialized: true,
	})
);

//rutas
app.use(require('./routes/login'));
app.use(require('./routes/cliente'));
app.use(require('./routes/jefe'));
//servidor listen
app.listen(port, () => console.log(`listening on http://localhost:${port}`));
