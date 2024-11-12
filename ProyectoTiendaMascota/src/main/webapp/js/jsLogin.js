const authForm = document.getElementById('authForm');
const formTitle = document.getElementById('formTitle');
const submitBtn = document.getElementById('submitBtn');
const forgotPassword = document.getElementById('forgotPassword');
const registerFields = document.querySelectorAll('.register-fields');
const passwordInput = document.getElementById('password');
const passwordToggle = document.getElementById('passwordToggle');
const loginMode = document.getElementById('loginMode');
const registerMode = document.getElementById('registerMode');

let isLogin = true;

function toggleMode(login) {
    isLogin = login;
    formTitle.textContent = isLogin ? 'Iniciar sesión' : 'Registrarse';
    submitBtn.textContent = isLogin ? 'Iniciar sesión' : 'Registrarse';
    forgotPassword.style.display = isLogin ? 'inline' : 'none';
    registerFields.forEach(field => {
        field.style.display = isLogin ? 'none' : 'block';
    });
    loginMode.classList.toggle('active', isLogin);
    registerMode.classList.toggle('active', !isLogin);
}

loginMode.addEventListener('click', () => toggleMode(true));
registerMode.addEventListener('click', () => toggleMode(false));

passwordToggle.addEventListener('click', () => {
    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordInput.setAttribute('type', type);
    passwordToggle.textContent = type === 'password' ? '👁️' : '👁️‍🗨️';
});

authForm.addEventListener('submit', (e) => {
    e.preventDefault();
    // Aquí puedes agregar la lógica para manejar el envío del formulario
    console.log('Formulario enviado', isLogin ? 'Inicio de sesión' : 'Registro');
});