<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Carrito - Oleum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/estilos.css">
</head>
<body>

    <!-- CABECERA -->
    <header>
        <div class="logo">
            <h1><a href="${pageContext.request.contextPath}/productos">Oleum</a></h1>
        </div>
        <nav aria-label="Navegación principal">
            <ul>
                <li><a href="${pageContext.request.contextPath}/productos">Catálogo</a></li>

                <!-- JSTL evalúa si existe el objeto en la sesión del servidor -->
                <c:choose>
                    <c:when test="${not empty sessionScope.usuarioLogueado}">
                        <!-- Solo se muestra si el usuario ha iniciado sesión -->
                        <li><a href="${pageContext.request.contextPath}/perfil" class="nav-usuario">Hola, ${sessionScope.usuarioLogueado.nombre}</a></li>
                    </c:when>
                    <c:otherwise>
                        <!-- Solo se muestra para visitantes anónimos -->
                        <li><a href="${pageContext.request.contextPath}/login">Mi Cuenta</a></li>
                    </c:otherwise>
                </c:choose>

                <li><a href="${pageContext.request.contextPath}/carrito">Carrito</a></li>
            </ul>
        </nav>
    </header>

    <!-- CONTENIDO PRINCIPAL: Carrito -->
    <main class="contenedor-proceso-pago">
        <h2>Mi Carrito de la Compra</h2>
        
        <div class="carrito-layout">
            <!-- Tabla de productos -->
            <div class="carrito-lista">
                <table class="tabla-datos">
                    <thead>
                        <tr>
                            <th>Producto</th>
                            <th>Precio</th>
                            <th>Cantidad</th>
                            <th>Subtotal</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Las líneas de pedido se generan dinámicamente por app.js -->
                    </tbody>
                </table>
            </div>

            <!-- Panel lateral de resumen -->
            <aside class="carrito-resumen">
                <h3>Resumen</h3>
                <div class="resumen-linea">
                    <span>Subtotal artículos:</span>
                    <span>0,00 €</span>
                </div>
                <div class="resumen-linea">
                    <span>Gastos de envío:</span>
                    <span>4,99 €</span>
                </div>
                <div class="resumen-total">
                    <span>Total a pagar:</span>
                    <span>0,00 €</span>
                </div>
                
                <form action="${pageContext.request.contextPath}/pedidos/confirmar" method="POST" id="form-tramitar">
                    <!-- Input oculto donde app.js inyecta dinámicamente los productos -->
                    <input type="hidden" name="datosCarrito" id="datosCarrito">
                    <button type="submit" class="btn-primario btn-block">Tramitar Pedido</button>
                </form>
            </aside>
        </div>
    </main>

    <!-- PIE DE PÁGINA -->
    <footer>
        <div class="footer-contenido">
            <p>&copy; 2026 Oleum - Proyecto de Arquitectura y Diseño Web</p>
            <ul>
                <li><a href="#">Aviso Legal</a></li>
                <li><a href="#">Contacto</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/productos">Panel de Administración</a></li>
            </ul>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>