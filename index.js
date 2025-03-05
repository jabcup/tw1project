const express = require('express');
const cors = require('cors');
const app = express();
const port = 2000;

app.use(cors({
  origin: '*', // Permitir acceso desde cualquier origen
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type']
}));

app.use(express.json());

//Tabla climas de la base de datos
const climas = require('./src/Tclimas');
app.use('/Tclimas', climas);

//Tabla datos monedas de la base de datos
const datosMonedas = require('./src/Tdatosmonedas');
app.use('/Tdatosmonedas', datosMonedas);

//Tabla fuentes de la base de datos
const fuentes = require('./src/Tfuentes');
app.use('/Tfuentes', fuentes);

//Tabla incidentes de la base de datos
const incidentes = require('./src/Tincidentes');
app.use('/Tincidentes', incidentes);

//Tabla monedas de la base de datos
const monedas = require('./src/Tmonedas');
app.use('/Tmonedas', monedas);

//Tabla noticias de la base de datos
const noticias = require('./src/Tnoticias');
app.use('/Tnoticias', noticias);

//Tabla preferencias de la base de datos
const preferencias = require('./src/Tpreferencias');
app.use('/Tpreferencias', preferencias);

//Tabla roles de la base de datos
const roles = require('./src/Troles');
app.use('/Troles', roles);

//Tabla taux temas de la base de datos
const aux_temas = require('./src/Ttauxtemas');
app.use('/Ttauxtemas', aux_temas);

//Tabla temas de la base de datos
const temas = require('./src/Ttemas');
app.use('/Ttemas', temas);

//Tabla ubicaciones de la base de datos
const ubicaciones = require('./src/Tubicaciones');
app.use('/Tubicaciones', ubicaciones);

//Tabla usuarios de la base de datos
const usuarios = require('./src/Tusuarios');
app.use('/Tusuarios', usuarios);

const login = require('./src/login');
app.use('/login', login);

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
