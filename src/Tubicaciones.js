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
    res.send('Ruta de ubicaciones');
});

// Obtener todas las ubicaciones
router.get('/', (req, res) => {
    let sql = "SELECT * FROM t_ubicaciones;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener ubicaciones:', err.message);
            return res.status(500).json({ error: 'Error al obtener ubicaciones' });
        }
        res.json(resultados);
    });
});

// Insertar una nueva ubicación utilizando el procedimiento almacenado
router.post('/', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL pt_ubicacion(?)';
    let valores = [
        req.body.nombre_ubicacion
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar ubicación:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar la ubicación' });
        }
        res.json({ mensaje: 'Ubicación agregada correctamente' });
    });
});

// Editar una ubicación
router.put('/:id', (req, res) => { 
    let id = req.params.id; 
    let { nombre_ubicacion } = req.body;

    let sql = 'UPDATE t_ubicaciones SET nombre_ubicacion = ? WHERE id_ubicacion = ?'; 
    
    conexion.query(sql, [nombre_ubicacion, id], (err, resul) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Ubicación modificada correctamente' });
        } 
    }); 
}); 

// Eliminar una ubicación
router.delete('/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_ubicaciones WHERE id_ubicacion = ?'; 

    console.log("Intentando eliminar la ubicación con ID:", id); 

    conexion.query(sql, [id], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Ubicación eliminada correctamente", resultado: resul });
        } 
    }); 
});

module.exports = router
