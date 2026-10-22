<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aceite Picual Premium - Oleum</title>
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
            <span>Aceite Picual Premium</span>
        </nav>

        <section class="detalle-grid">
            <div class="detalle-imagen">
                <img src="${pageContext.request.contextPath}/assets/img/botella1.jpg" alt="Botella de Aceite Picual Premium 500ml">
            </div>

            <div class="detalle-info">
                <h2>Aceite Picual Premium</h2>
                <p class="productor">Por <strong>Finca La Torre</strong></p>
                <p class="precio-grande">12,50 €</p>
                
                <div class="descripcion-larga">
                    <p>Aceite de oliva virgen extra de extracción en frío. Presenta un frutado intenso de aceituna verde, con notas de hierba recién cortada, tomatera y almendra verde. Ideal para tomar en crudo, en tostadas o ensaladas.</p>
                </div>

                <ul class="lista-caracteristicas">
                    <li><strong>Variedad:</strong> Picual</li>
                    <li><strong>Origen:</strong> Jaén, Andalucía</li>
                    <li><strong>Formato:</strong> Botella de vidrio 500 ml</li>
                    <li class="stock-ok"><strong>Disponibilidad:</strong> 24 unidades en stock</li>
                </ul>

                <div class="formulario-compra">
                    <label for="cantidad">Cantidad:</label>
                    <input type="number" id="cantidad" name="cantidad" value="1" min="1" max="24">
                    <button type="button" class="btn-primario btn-grande btn-agregar"
                            data-id="PROD-001" 
                            data-nombre="Aceite Picual Premium" 
                            data-precio="12.50">Añadir al carrito</button>
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