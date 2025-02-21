const express = require('express');
const mysql = require('mysql2');
const app = express();

app.use(express.json());
const puerto = 2000;

// Configuración de la conexión a MySQL
const conexion = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '7090',
    database: 'tw1project'
});

// Ruta de inicio
app.get('/', (req, res) => {
    res.send('Ruta de eventos');
});

// Obtener todos los eventos
app.get('/eventos', (req, res) => {
    let sql = "SELECT * FROM t_eventos;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener eventos:', err.message);
            return res.status(500).json({ error: 'Error al obtener eventos' });
        }
        res.json(resultados);
    });
});

// Insertar un nuevo evento utilizando el procedimiento almacenado
app.post('/eventos', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL pEvento(?, ?, ?, ?, ?, ?, ?)';
    let valores = [
        req.body.direccion,
        req.body.nombre,
        req.body.tipo,
        req.body.fecha,
        req.body.contacto,
        req.body.id_fuente,
        req.body.url
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar evento:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar el evento' });
        }
        res.json({ mensaje: 'Evento agregado correctamente' });
    });
});

// Editar un evento
app.put('/eventos/:id', (req, res) => { 
    let id = req.params.id; 
    let { direccion, nombre, tipo, fecha, contacto, id_fuente, url } = req.body;

    let sql = 'UPDATE t_eventos SET direccion = ?, nombre = ?, tipo = ?, fecha = ?, contacto = ?, id_fuente = ?, url = ? WHERE id_evento = ?'; 
    
    conexion.query(sql, [direccion, nombre, tipo, fecha, contacto, id_fuente, url, id], (err, resul) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Evento modificado correctamente' });
        } 
    }); 
}); 

// Eliminar un evento
app.delete('/eventos/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_eventos WHERE id_evento = ?'; 

    console.log("Intentando eliminar el evento con ID:", id); 

    conexion.query(sql, [id], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Evento eliminado correctamente", resultado: resul });
        } 
    }); 
});

// Servidor
app.listen(puerto, () => {
    console.log('Servidor OK en puerto: ' + puerto);
});
