<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Importación de JSTL -->
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!-- Etiqueta fn para proteger contra ataques XSS al repintar campos -->
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - Oleum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/estilos.css">
    <style>
        .alerta-error { background-color: #f8d7da; color: #721c24; padding: 1rem; border-radius: 5px; margin-bottom: 1.5rem; text-align: center; border: 1px solid #f5c6cb; }
    </style>
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

    <main class="contenedor-panel">
        <section class="formulario-auth-contenedor" style="max-width: 500px; margin: 3rem auto; background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
            <h2 style="text-align: center; margin-bottom: 1.5rem; color: var(--color-primario);">Crear una Cuenta</h2>

            <!-- JSTL: Mensaje de error inyectado por RegistroServlet (ej. Email duplicado) -->
            <c:if test="${not empty errorRegistro}">
                <div class="alerta-error">
                    ${errorRegistro}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/registro" method="POST" class="formulario-auth">
                <div class="grupo-form" style="margin-bottom: 1rem;">
                    <label for="nombre" style="display: block; margin-bottom: 0.5rem; font-weight: bold;">Nombre Completo</label>
                    <!-- fn:escapeXml previene la inyección de código (XSS) al repintar lo que introdujo el usuario -->
                    <input type="text" id="nombre" name="nombre" required 
                           value="${fn:escapeXml(param.nombre)}" 
                           placeholder="Ej. Juan Pérez" style="width: 100%; padding: 0.8rem; border: 1px solid #ccc; border-radius: 4px;">
                </div>

                <div class="grupo-form" style="margin-bottom: 1rem;">
                    <label for="email" style="display: block; margin-bottom: 0.5rem; font-weight: bold;">Correo Electrónico</label>
                    <input type="email" id="email" name="email" required 
                           value="${fn:escapeXml(param.email)}" 
                           placeholder="tu@email.com" style="width: 100%; padding: 0.8rem; border: 1px solid #ccc; border-radius: 4px;">
                </div>
                
                <div class="grupo-form" style="margin-bottom: 1rem;">
                    <label for="password" style="display: block; margin-bottom: 0.5rem; font-weight: bold;">Contraseña</label>
                    <!-- Por seguridad, las contraseñas NUNCA se repintan en el value -->
                    <input type="password" id="password" name="password" required minlength="8" 
                           placeholder="Mínimo 8 caracteres" style="width: 100%; padding: 0.8rem; border: 1px solid #ccc; border-radius: 4px;">
                </div>

                <div class="grupo-form" style="margin-bottom: 1.5rem;">
                    <label for="direccion" style="display: block; margin-bottom: 0.5rem; font-weight: bold;">Dirección de Envío Principal</label>
                    <input type="text" id="direccion" name="direccion" required 
                           value="${fn:escapeXml(param.direccion)}" 
                           placeholder="Calle, Número, Ciudad, CP" style="width: 100%; padding: 0.8rem; border: 1px solid #ccc; border-radius: 4px;">
                </div>
                
                <button type="submit" class="btn-primario btn-block" style="width: 100%;">Registrarme</button>
            </form>
            
            <p style="text-align: center; margin-top: 1.5rem;">
                ¿Ya tienes una cuenta? <a href="${pageContext.request.contextPath}/login" style="color: var(--color-primario); font-weight: bold;">Inicia sesión</a>
            </p>
        </section>
    </main>

    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>