<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TiendaPet</title>
    <link rel="stylesheet" href="css/stylesHome.css">
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

        <!-- Carrito e Inicio de Sesi�n -->
        <div class="user-options">
            <div class="cart-icon">
                <img src="imagenes_iconos/carritoIcon.png" alt="Carrito">
            </div>
            <span id="user-status">
                <%
                    String user = (String) session.getAttribute("usuario");
                    if (user != null) {
                %>
                    <a href="cuenta.jsp">Cuenta: <%= user %></a>
                <% } else { %>
                    <a href="login.jsp">Iniciar sesi�n/Registrarse</a>
                <% } %>
            </span>
        </div>
    </header>
    
    <main>
        <!-- Categor�as y Subcategor�as -->
        <nav>
            <ul class="categorias">
                <li class="categoria">Todos los productos</li>
                <li class="categoria">Comida
                    <ul class="subcategoria">
                        <li>Seco</li>
                        <li>H�medo</li>
                    </ul>
                </li>
                <li class="categoria">Limpieza
                    <ul class="subcategoria">
                        <li>Ba�o</li>
                        <li>Casa</li>
                    </ul>
                </li>
                <li class="categoria">Juguetes</li>
            </ul>
        </nav>
        
        <!-- Combobox para ordenar productos -->
        <div class="product-sorting">
            <label for="orderSelect">Ordenar por:</label>
            <select id="orderSelect" onchange="sortProducts()">
                <option value="">Elegir orden</option>
                <option value="asc">Ascendente</option>
                <option value="desc">Descendente</option>
            </select>
        </div>

        <!-- Contenedor de productos -->
        <div class="product-list">
            
        </div>
    </main>

    <footer>
        <div class="footer-content">
            <!-- Informaci�n sobre la empresa -->
            <div class="footer-section about">
                <h3>Qui�nes Somos</h3>
                <p>Somos una tienda dedicada a ofrecer los mejores productos para mascotas. Nuestro objetivo es brindar calidad y comodidad para el bienestar de tus amigos peludos.</p>
            </div>

            <!-- Informaci�n de contacto -->
            <div class="footer-section contact">
                <h3>Cont�ctanos</h3>
                <p>Tel�fono: +51 123 456 789</p>
                <p>Email: contacto@tiendapet.com</p>
                <p>Direcci�n: Av. Ejemplo 123, Lima, Per�</p>
            </div>
            
            <!-- Enlaces de pol�ticas -->
            <div class="footer-section links">
                <h3>Enlaces �tiles</h3>
                <ul>
                    <li><a href="#">Pol�tica de Privacidad</a></li>
                    <li><a href="#">T�rminos y Condiciones</a></li>
                    <li><a href="#">Pol�tica de Devoluciones</a></li>
                </ul>
            </div>
        </div>

        <!-- Derechos reservados -->
        <div class="footer-bottom">
            <p>&copy; 2024 TiendaPet. Todos los derechos reservados.</p>
        </div>
    </footer>

    <script src="js/jsHome.js"></script>
</body>
</html>
