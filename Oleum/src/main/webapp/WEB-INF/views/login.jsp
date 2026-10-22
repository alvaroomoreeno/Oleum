<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Importación obligatoria de JSTL para lógica condicional sin código Java -->
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - Oleum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/estilos.css">
    <style>
        .alerta-error { background-color: #f8d7da; color: #721c24; padding: 1rem; border-radius: 5px; margin-bottom: 1.5rem; text-align: center; border: 1px solid #f5c6cb; }
        .alerta-exito { background-color: #d4edda; color: #155724; padding: 1rem; border-radius: 5px; margin-bottom: 1.5rem; text-align: center; border: 1px solid #c3e6cb; }
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
        <section class="formulario-auth-contenedor" style="max-width: 400px; margin: 3rem auto; background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05);">
            <h2 style="text-align: center; margin-bottom: 1.5rem; color: var(--color-primario);">Iniciar Sesión</h2>

            <!-- JSTL: Mensaje de éxito si viene de registrarse correctamente -->
            <c:if test="${param.registro == 'exito'}">
                <div class="alerta-exito">
                    ¡Registro completado con éxito! Ya puedes iniciar sesión.
                </div>
            </c:if>

            <!-- JSTL: Mensaje de error inyectado por LoginServlet si fallan las credenciales -->
            <c:if test="${not empty errorLogin}">
                <div class="alerta-error">
                    ${errorLogin}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="POST" class="formulario-auth">
                <div class="grupo-form" style="margin-bottom: 1rem;">
                    <label for="email" style="display: block; margin-bottom: 0.5rem; font-weight: bold;">Correo Electrónico</label>
                    <input type="email" id="email" name="email" required placeholder="tu@email.com" style="width: 100%; padding: 0.8rem; border: 1px solid #ccc; border-radius: 4px;">
                </div>
                
                <div class="grupo-form" style="margin-bottom: 1.5rem;">
                    <label for="password" style="display: block; margin-bottom: 0.5rem; font-weight: bold;">Contraseña</label>
                    <input type="password" id="password" name="password" required placeholder="********" style="width: 100%; padding: 0.8rem; border: 1px solid #ccc; border-radius: 4px;">
                </div>
                
                <button type="submit" class="btn-primario btn-block" style="width: 100%;">Entrar</button>
            </form>
            
            <p style="text-align: center; margin-top: 1.5rem;">
                ¿No tienes cuenta? <a href="${pageContext.request.contextPath}/registro" style="color: var(--color-primario); font-weight: bold;">Regístrate aquí</a>
            </p>
        </section>
    </main>

    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>