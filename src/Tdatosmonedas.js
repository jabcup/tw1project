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
    res.send('Ruta de datos de monedas');
});

// Obtener todos los datos de monedas
router.get('/', (req, res) => {
    let sql = "SELECT * FROM t_datos_monedas;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener los datos de monedas:', err.message);
            return res.status(500).json({ error: 'Error al obtener los datos de monedas' });
        }
        res.json(resultados);
    });
});

// Insertar un nuevo dato de moneda utilizando el procedimiento almacenado
router.post('/', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL pDatosMonedas(?, ?, ?, ?, ?)';
    let valores = [
        req.body.id_fuente,
        req.body.id_moneda,
        req.body.fecha,
        req.body.venta,
        req.body.compra
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar datos de moneda:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar el dato de moneda' });
        }
        res.json({ mensaje: 'Dato de moneda agregado correctamente' });
    });
});

// Editar un dato de moneda
router.put('/:id', (req, res) => { 
    let id = req.params.id; 
    let { id_fuente, id_moneda, fecha, valor_respecto_dolar } = req.body;

    let sql = 'UPDATE t_datos_monedas SET id_fuente = ?, id_moneda = ?, fecha = ?, valor_respecto_dolar = ? WHERE id_dato = ?'; 
    
    conexion.query(sql, [id_fuente, id_moneda, fecha, valor_respecto_dolar, id], (err, resul) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Dato de moneda modificado correctamente' });
        } 
    }); 
}); 

// Eliminar un dato de moneda
router.delete('/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_datos_monedas WHERE id_dato = ?'; 

    console.log("Intentando eliminar el dato de moneda con ID:", id); 

    conexion.query(sql, [id], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Dato de moneda eliminado correctamente", resultado: resul });
        } 
    }); 
});

module.exports = router
