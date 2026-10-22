<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aceite Hojiblanca Ecológico - Oleum</title>
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
            <span>Aceite Hojiblanca Ecológico</span>
        </nav>

        <section class="detalle-grid">
            <div class="detalle-imagen">
                <img src="${pageContext.request.contextPath}/assets/img/botella3.jpg" alt="Botella de Aceite Hojiblanca Ecológico 750ml">
            </div>

            <div class="detalle-info">
                <h2>Aceite Hojiblanca Ecológico</h2>
                <p class="productor">Por <strong>Almazara Bio</strong></p>
                <p class="precio-grande">18,20 €</p>
                
                <div class="descripcion-larga">
                    <p>Producción 100% ecológica. Un aceite muy versátil con un equilibrio perfecto entre picante y amargo, destacando sus notas de hierba fresca y almendra. Perfecto para guisos y conservación de alimentos.</p>
                </div>

                <ul class="lista-caracteristicas">
                    <li><strong>Variedad:</strong> Hojiblanca</li>
                    <li><strong>Origen:</strong> Córdoba, Andalucía</li>
                    <li><strong>Formato:</strong> Botella de vidrio 750 ml</li>
                    <li class="stock-out"><strong>Disponibilidad:</strong> Sin stock</li>
                </ul>

                <div class="formulario-compra">
                    <label for="cantidad">Cantidad:</label>
                    <input type="number" id="cantidad" name="cantidad" value="0" disabled>
                    <button type="button" class="btn-primario btn-grande btn-agregar" disabled
                            data-id="PROD-003" 
                            data-nombre="Aceite Hojiblanca Ecológico" 
                            data-precio="18.20">Agotado</button>
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