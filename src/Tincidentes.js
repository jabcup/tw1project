const data = require('./data');
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
    res.send('Ruta de incidentes');
});

// Obtener todos los incidentes
app.get('/incidentes', (req, res) => {
    let sql = "SELECT * FROM t_incidentes;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener incidentes:', err.message);
            return res.status(500).json({ error: 'Error al obtener incidentes' });
        }
        res.json(resultados);
    });
});

// Insertar un nuevo incidente utilizando el procedimiento almacenado
app.post('/incidentes', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL pincidente(?, ?, ?, ?, ?, ?, ?)';
    let valores = [
        req.body.lugar,
        req.body.tipo,
        req.body.descripcion_incidente,
        req.body.fecha,
        req.body.hora,
        req.body.id_fuente,
        req.body.url
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar incidente:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar el incidente' });
        }
        res.json({ mensaje: 'Incidente agregado correctamente' });
    });
});

// Editar un incidente
app.put('/incidentes/:id', (req, res) => { 
    let id = req.params.id; 
    let { lugar, tipo, descripcion_incidente, fecha, hora, id_fuente, url } = req.body;

    let sql = 'UPDATE t_incidentes SET lugar = ?, tipo = ?, descripcion_incidente = ?, fecha = ?, hora = ?, id_fuente = ?, url = ? WHERE id_incidente = ?'; 
    
    conexion.query(sql, [lugar, tipo, descripcion_incidente, fecha, hora, id_fuente, url, id], (err, resul) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Incidente modificado correctamente' });
        } 
    }); 
}); 

// Eliminar un incidente
app.delete('/incidentes/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_incidentes WHERE id_incidente = ?'; 

    console.log("Intentando eliminar el incidente con ID:", id); 

    conexion.query(sql, [id], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Incidente eliminado correctamente", resultado: resul });
        } 
    }); 
});

// Servidor
app.listen(puerto, () => {
    console.log('Servidor OK en puerto: ' + puerto);
});
