const express = require('express');
const mysql = require('mysql2');
const dbConfig = require('./data'); 
const router = express.Router()
const app = express();
router.use(express.json());
const puerto = 2000;

// Configuración de la conexión a MySQL usando los datos de data.js
const conexion = mysql.createPool(dbConfig);

// Ruta de inicio
router.get('/', (req, res) => {
    res.send('Ruta de preferencias');
});

// Obtener todas las preferencias
router.get('/', (req, res) => {
    let sql = "SELECT * FROM t_preferencias;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener preferencias:', err.message);
            return res.status(500).json({ error: 'Error al obtener preferencias' });
        }
        res.json(resultados);
    });
});

// Insertar una nueva preferencia utilizando el procedimiento almacenado
router.post('/', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL ppreferencia(?, ?, ?)';
    let valores = [
        req.body.id_usuario,
        req.body.id_ubicacion,
        req.body.notification_time
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar preferencia:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar la preferencia' });
        }
        res.json({ mensaje: 'Preferencia agregada correctamente' });
    });
});

// Editar una preferencia
router.put('/:id', (req, res) => { 
    let id = req.params.id; 
    let { id_usuario, id_ubicacion, notification_time } = req.body;

    let sql = 'UPDATE t_preferencias SET id_usuario = ?, id_ubicacion = ?, notification_time = ? WHERE id_preferencia = ?'; 
    
    conexion.query(sql, [id_usuario, id_ubicacion, notification_time, id], (err, resul) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Preferencia modificada correctamente' });
        } 
    }); 
}); 

// Eliminar una preferencia
router.delete('/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_preferencias WHERE id_preferencia = ?'; 

    console.log("Intentando eliminar la preferencia con ID:", id); 

    conexion.query(sql, [id], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Preferencia eliminada correctamente", resultado: resul });
        } 
    }); 
});

module.exports = router
