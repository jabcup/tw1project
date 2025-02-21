const data = require('./data');
const express = require('express');
const mysql = require('mysql2');
const app = express();

app.use(express.json());
const puerto = 2000;

// Configuración de la conexión a MySQL
const conexion = mysql.createPool({
    host: 'localhost',
    user : data.username,
    password: data.password,
    database: 'tw1project'
});

// Ruta de inicio
app.get('/', (req, res) => {
    res.send('Ruta de roles');
});

// Obtener todos los roles
app.get('/roles', (req, res) => {
    let sql = "SELECT * FROM t_roles;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener roles:', err.message);
            return res.status(500).json({ error: 'Error al obtener roles' });
        }
        res.json(resultados);
    });
});

// Insertar un nuevo rol utilizando el procedimiento almacenado
app.post('/roles', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL prol(?)';
    let valores = [req.body.nombre];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar rol:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar el rol' });
        }
        res.json({ mensaje: 'Rol agregado correctamente' });
    });
});

// Editar un rol
app.put('/roles/:id', (req, res) => { 
    let id = req.params.id; 
    let nombre = req.body.nombre;

    let sql = 'UPDATE t_roles SET nombre = ? WHERE id_rol = ?'; 
    
    conexion.query(sql, [nombre, id], (err, resul) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Rol modificado correctamente' });
        } 
    }); 
}); 

// Eliminar un rol
app.delete('/roles/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_roles WHERE id_rol = ?'; 

    console.log("Intentando eliminar el rol con ID:", id); 

    conexion.query(sql, [id], (err, resul) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Rol eliminado correctamente", resultado: resul });
        } 
    }); 
});

// Servidor
app.listen(puerto, () => {
    console.log('Servidor OK en puerto: ' + puerto);
});
