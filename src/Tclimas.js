const express = require('express');
const mysql = require('mysql2');
const dbConfig = require('./data'); // Importar configuración desde data.js

const app = express();
app.use(express.json());
const puerto = 2000;

// Configuración de la conexión a MySQL usando los datos de data.js
const conexion = mysql.createPool(dbConfig);

// Ruta de inicio
app.get('/', (req, res) => {
    res.send('Ruta de climas');
});

// Obtener todos los registros de climas
app.get('/climas', (req, res) => {
    let sql = "SELECT * FROM t_climas;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener climas:', err.message);
            return res.status(500).json({ error: 'Error al obtener climas' });
        }
        res.json(resultados);
    });
});

// Insertar un nuevo clima utilizando el procedimiento almacenado
app.post('/climas', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL pclima(?, ?, ?, ?, ?, ?, ?, ?)';
    let valores = [
        req.body.fecha,
        req.body.id_ubicacion,
        req.body.t_max,
        req.body.t_min,
        req.body.condiciones,
        req.body.precipitacion,
        req.body.humedad,
        req.body.id_fuente
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar clima:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar el clima' });
        }
        res.json({ mensaje: 'Clima agregado correctamente' });
    });
});

// Editar un clima
app.put('/climas/:id', (req, res) => { 
    let id = req.params.id; 
    let { fecha, id_ubicacion, t_max, t_min, condiciones, precipitacion, humedad, id_fuente } = req.body;

    let sql = 'UPDATE t_climas SET fecha = ?, id_ubicacion = ?, t_max = ?, t_min = ?, condiciones = ?, precipitacion = ?, humedad = ?, id_fuente = ? WHERE id_clima = ?'; 
    
    conexion.query(sql, [fecha, id_ubicacion, t_max, t_min, condiciones, precipitacion, humedad, id_fuente, id], (err, resul) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Clima modificado correctamente' });
        } 
    }); 
}); 

// Eliminar un clima
app.delete('/climas/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_climas WHERE id_clima = ?'; 

    console.log("Intentando eliminar el clima con ID:", id); 

    conexion.query(sql, [id], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Clima eliminado correctamente", resultado: resul });
        } 
    }); 
});

// Servidor
app.listen(puerto, () => {
    console.log('Servidor OK en puerto: ' + puerto);
});
