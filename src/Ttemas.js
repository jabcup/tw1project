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
    res.send('Ruta de temas');
});

// Obtener todos los temas
app.get('/temas', (req, res) => {
    let sql = "SELECT * FROM t_temas;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener temas:', err.message);
            return res.status(500).json({ error: 'Error al obtener temas' });
        }
        res.json(resultados);
    });
});

// Insertar un nuevo tema utilizando el procedimiento almacenado
app.post('/temas', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL pt_tema(?, ?, ?)';
    let valores = [
        req.body.nombre_tema,
        req.body.descripcion_tema,
        req.body.id_fuente
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar tema:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar el tema' });
        }
        res.json({ mensaje: 'Tema agregado correctamente' });
    });
});

// Editar un tema
app.put('/temas/:id', (req, res) => { 
    let id = req.params.id; 
    let { nombre_tema, descripcion_tema, id_fuente } = req.body;

    let sql = 'UPDATE t_temas SET nombre_tema = ?, descripcion_tema = ?, id_fuente = ? WHERE id_tema = ?'; 
    
    conexion.query(sql, [nombre_tema, descripcion_tema, id_fuente, id], (err, resul) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Tema modificado correctamente' });
        } 
    }); 
}); 

// Eliminar un tema
app.delete('/temas/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_temas WHERE id_tema = ?'; 

    console.log("Intentando eliminar el tema con ID:", id); 

    conexion.query(sql, [id], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Tema eliminado correctamente", resultado: resul });
        } 
    }); 
});

// Servidor
app.listen(puerto, () => {
    console.log('Servidor OK en puerto: ' + puerto);
});
