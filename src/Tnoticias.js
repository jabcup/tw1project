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
    res.send('Ruta de noticias');
});

// Obtener todas las noticias
app.get('/noticias', (req, res) => {
    let sql = "SELECT * FROM t_noticias;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener noticias:', err.message);
            return res.status(500).json({ error: 'Error al obtener noticias' });
        }
        res.json(resultados);
    });
});

// Insertar una nueva noticia utilizando el procedimiento almacenado
app.post('/noticias', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL pnoticia(?, ?, ?, ?, ?)';
    let valores = [
        req.body.id_fuente,
        req.body.id_tema,
        req.body.fecha,
        req.body.titulo,
        req.body.descripcion_noticia
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar noticia:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar la noticia' });
        }
        res.json({ mensaje: 'Noticia agregada correctamente' });
    });
});

// Editar una noticia
app.put('/noticias/:id', (req, res) => { 
    let id = req.params.id; 
    let { id_fuente, id_tema, fecha, titulo, descripcion_noticia } = req.body;

    let sql = 'UPDATE t_noticias SET id_fuente = ?, id_tema = ?, fecha = ?, titulo = ?, descripcion_noticia = ? WHERE id_noticia = ?'; 
    
    conexion.query(sql, [id_fuente, id_tema, fecha, titulo, descripcion_noticia, id], (err, resul) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Noticia modificada correctamente' });
        } 
    }); 
}); 

// Eliminar una noticia
app.delete('/noticias/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_noticias WHERE id_noticia = ?'; 

    console.log("Intentando eliminar la noticia con ID:", id); 

    conexion.query(sql, [id], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Noticia eliminada correctamente", resultado: resul });
        } 
    }); 
});

// Servidor
app.listen(puerto, () => {
    console.log('Servidor OK en puerto: ' + puerto);
});
