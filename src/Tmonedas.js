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
    res.send('Ruta de monedas');
});

// Obtener todas las monedas
app.get('/monedas', (req, res) => {
    let sql = "SELECT * FROM t_monedas;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener monedas:', err.message);
            return res.status(500).json({ error: 'Error al obtener monedas' });
        }
        res.json(resultados);
    });
});

// Insertar una nueva moneda utilizando el procedimiento almacenado
app.post('/monedas', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL pmoneda(?, ?, ?)';
    let valores = [
        req.body.nombre_moneda,
        req.body.denominacion,
        req.body.pais
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar moneda:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar la moneda' });
        }
        res.json({ mensaje: 'Moneda agregada correctamente' });
    });
});

// Editar una moneda
app.put('/monedas/:id', (req, res) => { 
    let id = req.params.id; 
    let { nombre_moneda, denominacion, pais } = req.body;

    let sql = 'UPDATE t_monedas SET nombre_moneda = ?, denominacion = ?, pais = ? WHERE id_moneda = ?'; 
    
    conexion.query(sql, [nombre_moneda, denominacion, pais, id], (err, resul) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Moneda modificada correctamente' });
        } 
    }); 
}); 

// Eliminar una moneda
app.delete('/monedas/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_monedas WHERE id_moneda = ?'; 

    console.log("Intentando eliminar la moneda con ID:", id); 

    conexion.query(sql, [id], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Moneda eliminada correctamente", resultado: resul });
        } 
    }); 
});

// Servidor
app.listen(puerto, () => {
    console.log('Servidor OK en puerto: ' + puerto);
});
