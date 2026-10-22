<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aceite Arbequina Familiar - Oleum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/estilos.css">
</head>
<body>

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

    <main class="contenedor-detalle">
        <nav aria-label="Migas de pan" class="migas-de-pan">
            <a href="${pageContext.request.contextPath}/productos">Inicio</a> &gt; 
            <a href="${pageContext.request.contextPath}/productos">Catálogo</a> &gt; 
            <span>Aceite Arbequina Familiar</span>
        </nav>

        <section class="detalle-grid">
            <div class="detalle-imagen">
                <img src="${pageContext.request.contextPath}/assets/img/botella2.jpg" alt="Lata de Aceite Arbequina Familiar 2 Litros">
            </div>

            <div class="detalle-info">
                <h2>Aceite Arbequina Familiar</h2>
                <p class="productor">Por <strong>Cooperativa Les Borges</strong></p>
                <p class="precio-grande">34,00 €</p>
                
                <div class="descripcion-larga">
                    <p>Aceite de oliva virgen extra de variedad Arbequina, caracterizado por su suavidad, ausencia de amargor y notas dulces de manzana y almendra. Formato de lata ideal para el consumo diario familiar, protegiendo el aceite de la luz.</p>
                </div>

                <ul class="lista-caracteristicas">
                    <li><strong>Variedad:</strong> Arbequina</li>
                    <li><strong>Origen:</strong> Lleida, Cataluña</li>
                    <li><strong>Formato:</strong> Lata 2 Litros</li>
                    <li class="stock-ok"><strong>Disponibilidad:</strong> 10 unidades en stock</li>
                </ul>

                <div class="formulario-compra">
                    <label for="cantidad">Cantidad:</label>
                    <input type="number" id="cantidad" name="cantidad" value="1" min="1" max="10">
                    <button type="button" class="btn-primario btn-grande btn-agregar"
                            data-id="PROD-002" 
                            data-nombre="Aceite Arbequina Familiar" 
                            data-precio="34.00">Añadir al carrito</button>
                </div>
                
                <div style="margin-top: 1.5rem;">
                    <a href="${pageContext.request.contextPath}/productos" class="enlace-accion">&larr; Volver al catálogo principal</a>
                </div>
            </div>
        </section>
    </main>

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