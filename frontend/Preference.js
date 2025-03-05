
// Obtener el id_usuario desde la URL
const urlParams = new URLSearchParams(window.location.search);
const id_usuario = urlParams.get('id_usuario');

if (!id_usuario) {
    document.getElementById('mensaje').textContent = 'Error: No se encontró el usuario.';
}

// Cargar ubicaciones al iniciar
fetch('http://localhost:2000/Tubicaciones')
    .then(response => response.json())
    .then(ubicaciones => {
        const selectUbicacion = document.getElementById('ubicacion');
        ubicaciones.forEach(ubicacion => {
            const option = document.createElement('option');
            option.value = ubicacion.id_ubicacion;
            option.textContent = ubicacion.nombre_ubicacion; // Ajusta si el campo tiene otro nombre
            selectUbicacion.appendChild(option);
        });
    })
    .catch(error => console.error('Error al cargar ubicaciones:', error));


// Guardar la preferencia
document.getElementById('btnGuardarPreferencia').addEventListener('click', () => {
    const id_ubicacion = document.getElementById('ubicacion').value;
    const notification_time = document.getElementById('notification_time').value;

    if (!id_ubicacion || !notification_time) {
        document.getElementById('mensaje').textContent = 'Debes seleccionar una ubicación y hora.';
        return;
    }

    fetch('http://localhost:2000/Tpreferencias', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id_usuario,
            id_ubicacion,
            notification_time
        })
    })
    .then(response => {
        if (!response.ok) throw new Error('Error al guardar preferencia');
        return response.json();
    })
    .then(data => {
        document.getElementById('mensaje').textContent = 'Preferencia guardada exitosamente.';
    })
    .catch(error => {
        document.getElementById('mensaje').textContent = 'Error al guardar preferencia.';
        console.error(error);
    });
});
