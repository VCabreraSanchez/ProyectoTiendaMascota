function updateUserStatus(username) {
    const userStatus = document.getElementById("user-status");
    if (username) {
        userStatus.innerHTML = `<a href="perfil.html">Cuenta: ${username}</a>`; // Cambia el texto al nombre del usuario
    } else {
        userStatus.innerHTML = '<a href="formulario.html">Iniciar sesión/Registrarse</a>';
    }
}

// Ejemplo de uso:
//updateUserStatus('usuarioEjemplo'); // Llama a esta función cuando el usuario inicie sesión
