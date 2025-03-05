const express = require('express');
const app = express();
const port = 2000;
const { exec } = require('child_process');
const schedule = require('node-schedule');

app.use(express.json());

//Tabla climas de la base de datos
const climas = require('./src/Tclimas');
app.use('/Tclimas', climas);

//Tabla datos monedas de la base de datos
const datosMonedas = require('./src/Tdatosmonedas');
app.use('/Tdatosmonedas', datosMonedas);

//Tabla eventos de la base de datos
const eventos = require('./src/Teventos');
app.use('/Teventos', eventos);

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


app.listen(port, () => {
  console.log(`Server running on port ${port}`);


schedule.scheduleJob('0 8 * * *', () => {
    console.log('Ejecutando script Ruby...');
    exec('ruby ruta/al/script.rb', (error, stdout, stderr) => {
        if (error) {
            console.error(`Error al ejecutar el script: ${error.message}`);
            return;
        }
        if (stderr) {
            console.error(`Error en la ejecución: ${stderr}`);
            return;
        }
        console.log(`Salida del script: ${stdout}`);
    });
});

});
