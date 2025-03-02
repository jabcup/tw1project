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
    res.send('Ruta de fuentes');
});

// Obtener todas las fuentes
router.get('/', (req, res) => {
    let sql = "SELECT * FROM t_fuentes;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener fuentes:', err.message);
            return res.status(500).json({ error: 'Error al obtener fuentes' });
        }
        res.json(resultados);
    });
});

// Insertar una nueva fuente utilizando el procedimiento almacenado
router.post('/', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL pfuente(?, ?, ?, ?)';
    let valores = [
        req.body.nombre_fuente,
        req.body.descripcion_fuente,
        req.body.ulr,
        req.body.dato_provisto
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar fuente:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar la fuente' });
        }
        res.json({ mensaje: 'Fuente agregada correctamente' });
    });
});

// Editar una fuente
router.put('/:id', (req, res) => { 
    let id = req.params.id; 
    let { nombre_fuente, descripcion_fuente, ulr, dato_provisto } = req.body;

    let sql = 'UPDATE t_fuentes SET nombre_fuente = ?, descripcion_fuente = ?, ulr = ?, dato_provisto = ? WHERE id_fuente = ?'; 
    
    conexion.query(sql, [nombre_fuente, descripcion_fuente, ulr, dato_provisto, id], (err, resul) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Fuente modificada correctamente' });
        } 
    }); 
}); 

// Eliminar una fuente
router.delete('/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_fuentes WHERE id_fuente = ?'; 

    console.log("Intentando eliminar la fuente con ID:", id); 

    conexion.query(sql, [id], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Fuente eliminada correctamente", resultado: resul });
        } 
    }); 
});

module.exports = router