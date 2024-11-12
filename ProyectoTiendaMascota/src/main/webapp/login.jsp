<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TiendaPet</title>
    <link rel="stylesheet" href="css/stylesHome.css">
    <link rel="stylesheet" href="css/stylesLogin.css">
</head>
<body>
    <header>
        <!-- Logo -->
        <div class="logo">
            <a href="index.jsp"><img src="imagenes_iconos/PetShopLogo.png" alt="Logo"></a>
        </div>

        <!-- Buscador -->
        <div class="search-bar">
            <input type="text" placeholder="Buscar productos...">
            <button>Buscar</button>
        </div>

        <!-- Carrito e Inicio de Sesión -->
        <div class="user-options">
            <div class="cart-icon">
                <img src="imagenes_iconos/carritoIcon.png" alt="Carrito">
            </div>
            <span id="user-status">
                <%
                    String user = (String) session.getAttribute("usuario");
                    if (user != null) {
                %>
                <a href="cuenta.jsp">Cuenta: <%= user%></a>
                <% } else { %>
                <a href="login.jsp">Iniciar sesión/Registrarse</a>
                <% }%>
            </span>
        </div>
    </header>

    <div class="auth-form">
        <div class="mode-selector">
            <button id="loginMode" class="active">Iniciar sesión</button>
            <button id="registerMode">Registrarse</button>
        </div>
        <h2 id="formTitle">Iniciar sesión</h2>
        <form id="authForm">
            <div class="form-group">
                <label for="email">Correo electrónico</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group register-fields">
                <label for="name">Nombre completo</label>
                <input type="text" id="name" name="name">
            </div>
            <div class="form-group register-fields">
                <label for="dni">DNI</label>
                <input type="text" id="dni" name="dni">
            </div>
            <div class="form-group register-fields">
                <label for="phone">Teléfono</label>
                <input type="tel" id="phone" name="phone">
            </div>
            <div class="form-group">
                <label for="password">Contraseña</label>
                <div class="password-input">
                    <input type="password" id="password" name="password" required>
                    <button type="button" class="password-toggle" id="passwordToggle">?</button>
                </div>
            </div>
            <button type="submit" class="submit-btn" id="submitBtn">Iniciar sesión</button>
        </form>
        <div class="auth-links">
            <a href="#" id="forgotPassword">¿Olvidaste tu contraseña?</a>
        </div>
    </div>
    <script src="js/jsLogin.js"></script>        
</body>