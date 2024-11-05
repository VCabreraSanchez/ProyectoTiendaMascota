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

function sortProducts() {
    const order = document.getElementById('orderSelect').value;
    // Lógica para ordenar productos en función del valor de "order"
    if (order === 'asc') {
        // Implementa la lógica para ordenar de forma ascendente
        console.log("Ordenar Ascendente");
    } else if (order === 'desc') {
        // Implementa la lógica para ordenar de forma descendente
        console.log("Ordenar Descendente");
    }
}
