<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mi Perfil - Oleum</title>
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

    <!-- CONTENIDO PRINCIPAL: Panel de Usuario -->
    <main class="contenedor-panel">
        
        <!-- Menú Lateral del Cliente -->
        <aside class="menu-panel">
            <h2>Mi Cuenta</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/perfil" class="activo">Mis Datos Personales</a></li>
                <li><a href="${pageContext.request.contextPath}/mis-pedidos">Historial de Pedidos</a></li>
                <li>
                    <form action="${pageContext.request.contextPath}/logout" method="POST">
                        <button type="submit" class="btn-logout-menu texto-peligro">Cerrar Sesión</button>
                    </form>
                </li>
            </ul>
        </aside>

        <!-- Área de Contenido: Formulario de Perfil -->
        <section class="contenido-panel">
            <h3>Mis Datos Personales</h3>
            <p class="subtitulo-panel">Actualiza tu información de contacto y dirección de envío por defecto.</p>

            <form action="${pageContext.request.contextPath}/perfil" method="POST" class="formulario-perfil">
                <div class="grupo-form">
                    <label for="nombre">Nombre completo:</label>
                    <!-- Inyección dinámica del nombre del usuario logueado -->
                    <input type="text" id="nombre" name="nombre" value="${sessionScope.usuarioLogueado.nombre}" required>
                </div>

                <div class="grupo-form">
                    <label for="email">Correo electrónico:</label>
                    <input type="email" id="email" value="${sessionScope.usuarioLogueado.email}" readonly class="input-deshabilitado">
                    <small>El correo no se puede modificar.</small>
                </div>

                <div class="grupo-form">
                    <label for="direccion">Dirección de envío predeterminada:</label>
                    <input type="text" id="direccion" name="direccion" value="${sessionScope.usuarioLogueado.direccion}" required>
                </div>

                <button type="submit" class="btn-primario">Guardar Cambios</button>
            </form>
        </section>

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