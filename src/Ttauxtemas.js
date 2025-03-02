const express = require('express');
const mysql = require('mysql2');
const dbConfig = require('./data'); 
const router = express.Router()
const app = express();
router.use(express.json());
const puerto = 2000;

// Configuración de la conexión a MySQL usando los datos de data.js
const conexion = mysql.createPool(dbConfig);

// Obtener todas las relaciones entre usuarios y temas
router.get('/', (req, res) => {
    let sql = "SELECT * FROM taux_temas;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener las relaciones:', err.message);
            return res.status(500).json({ error: 'Error al obtener las relaciones' });
        }
        res.json(resultados);
    });
});

// Insertar una nueva relación entre usuario y tema utilizando el procedimiento almacenado
router.post('/', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL pt_taux_temas(?, ?)';
    let valores = [
        req.body.id_usuario,
        req.body.id_tema
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar la relación:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar la relación' });
        }
        res.json({ mensaje: 'Relación entre usuario y tema agregada correctamente' });
    });
});

// Eliminar una relación entre usuario y tema
router.delete('/', (req, res) => { 
    const { id_usuario, id_tema } = req.body; 
    let sql = 'DELETE FROM taux_temas WHERE id_usuario = ? AND id_tema = ?'; 

    conexion.query(sql, [id_usuario, id_tema], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Relación eliminada correctamente", resultado: resul });
        } 
    }); 
}); 

module.exports = router
