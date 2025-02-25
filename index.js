const express = require('express');
const app = express();
const port = 2000;

app.use(express.json());

//Tabla climas de la base de datos
const climas = require('src/Tclimas.js');
app.use('src/Tclimas', climas);

//Tabla datos monedas de la base de datos
const datosMonedas = require('src/TdatosMonedas.js');
app.use('src/TdatosMonedas', datosMonedas);

//Tabla eventos de la base de datos
const eventos = require('src/Teventos.js');
app.use('src/Teventos', eventos);

//Tabla fuentes de la base de datos
const fuentes = require('src/Tfuentes.js');
app.use('src/Tfuentes', fuentes);

//Tabla incidentes de la base de datos
const incidentes = require('src/Tincidentes.js');
app.use('src/Tincidentes', incidentes);

//Tabla monedas de la base de datos
const monedas = require('src/Tmonedas.js');
app.use('src/Tmonedas', monedas);

//Tabla noticias de la base de datos
const noticias = require('src/Tnoticias.js');
app.use('src/Tnoticias', noticias);

//Tabla preferencias de la base de datos
const preferencias = require('src/Tpreferencias.js');
app.use('src/Tpreferencias', preferencias);

//Tabla roles de la base de datos
const roles = require('src/Troles.js');
app.use('src/Troles', roles);

//Tabla taux temas de la base de datos
const temas = require('src/Ttauxtemas.js');
app.use('src/Ttauxtemas', temas);

//Tabla temas de la base de datos
const temas = require('src/Ttemas.js');
app.use('src/Ttemas', temas);

//Tabla ubicaciones de la base de datos
const ubicaciones = require('src/Tubicaciones.js');
app.use('src/Tubicaciones', ubicaciones);

//Tabla usuarios de la base de datos
const usuarios = require('src/Tusuarios.js');
app.use('src/Tusuarios', usuarios);

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});