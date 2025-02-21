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
    res.send('Ruta de usuarios');
});

// Obtener todos los usuarios
app.get('/usuarios', (req, res) => {
    let sql = "SELECT * FROM t_usuarios;";
    conexion.query(sql, (err, resultados) => {
        if (err) {
            console.error('Error al obtener usuarios:', err.message);
            return res.status(500).json({ error: 'Error al obtener usuarios' });
        }
        res.json(resultados);
    });
});

// Insertar un nuevo usuario utilizando el procedimiento almacenado
app.post('/usuarios', (req, res) => {
    console.log('Datos recibidos:', req.body);

    let sql = 'CALL p_usuario(?, ?, ?, ?, ?)';
    let valores = [
        req.body.nombres_usuario,
        req.body.apellidos_usuario,
        req.body.usuario,
        req.body.password,
        req.body.id_rol
    ];

    conexion.query(sql, valores, (err, resultado) => {
        if (err) {
            console.error('Error al insertar usuario:', err.message);
            return res.status(500).json({ error: 'No se pudo insertar el usuario' });
        }
        res.json({ mensaje: 'Usuario agregado correctamente' });
    });
});

// Editar un usuario
app.put('/usuarios/:id', (req, res) => { 
    let id = req.params.id; 
    let nombres = req.body.nombres_usuario; 
    let apellidos = req.body.apellidos_usuario; 
    let usuario = req.body.usuario; 
    let password = req.body.password;
    let id_rol = req.body.id_rol;

    let sql = 'UPDATE t_usuarios SET nombres_usuario = ?, apellidos_usuario = ?, usuario = ?, password = ?, id_rol = ? WHERE id_usuario = ?'; 
    
    conexion.query(sql, [nombres, apellidos, usuario, password, id_rol, id], (err, resultado) => { 
        if (err) { 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: 'Usuario modificado correctamente' });
        } 
    }); 
}); 

// Eliminar un usuario
app.delete('/usuarios/:id', (req, res) => { 
    let id = req.params.id; 
    let sql = 'DELETE FROM t_usuarios WHERE id_usuario = ?'; 

    console.log("Intentando eliminar el usuario con id_usuario:", id); 

    conexion.query(sql, [id], (err, resultado) => { 
        if (err) { 
            console.log(err.message); 
            return res.status(500).json({ error: err.message });
        } else { 
            res.json({ mensaje: "Usuario eliminado correctamente", resultado });
        } 
    }); 
});

// Servidor
app.listen(puerto, () => {
    console.log('Servidor OK en puerto: ' + puerto);
});
