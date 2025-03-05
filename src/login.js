const express = require('express');
const mysql = require('mysql2');
const dbConfig = require('./data');
const router = express.Router();

const conexion = mysql.createPool(dbConfig);

router.post('/', (req, res) => {
  const { usuario, password } = req.body;

  const sql = 'SELECT * FROM t_usuarios WHERE usuario = ? AND password = ?';
  conexion.query(sql, [usuario, password], (err, resultados) => {
    if (err) {
      console.error('Error en login:', err.message);
      return res.status(500).json({ error: 'Error en el servidor' });
    }

    if (resultados.length > 0) {
      const usuarioData = resultados[0];

      res.json({
        success: true,
        mensaje: 'Login exitoso',
        id_usuario: usuarioData.id_usuario,
        nombres_usuario: usuarioData.nombres_usuario,
        apellidos_usuario: usuarioData.apellidos_usuario,
        usuario: usuarioData.usuario,
        id_rol: usuarioData.id_rol
      });

    } else {
      res.status(401).json({ success: false, mensaje: 'Credenciales incorrectos' });
    }
  });
});

module.exports = router;
