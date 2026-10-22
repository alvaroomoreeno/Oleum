<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Etiqueta obligatoria para iterar dinámicamente sin código Java sucio -->
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Pedidos - Oleum</title>
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

    <main class="contenedor-panel">
        <aside class="menu-panel">
            <h2>Mi Cuenta</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/perfil">Mis Datos Personales</a></li>
                <li><a href="${pageContext.request.contextPath}/mis-pedidos" class="activo">Historial de Pedidos</a></li>
                <li>
                    <form action="${pageContext.request.contextPath}/logout" method="POST">
                        <button type="submit" class="btn-logout-menu texto-peligro">Cerrar Sesión</button>
                    </form>
                </li>
            </ul>
        </aside>

        <section class="contenido-panel">
            <h3>Historial de Pedidos</h3>
            <p class="subtitulo-panel">Consulta el estado de tus compras anteriores.</p>

            <div class="tabla-responsiva">
                <table class="tabla-datos">
                    <thead>
                        <tr>
                            <th>Nº Pedido</th>
                            <th>Fecha</th>
                            <th>Total</th>
                            <th>Estado</th>
                            <th>Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Bucle JSTL que itera sobre la lista 'pedidos' que manda el Servlet -->
                        <c:forEach var="pedido" items="${pedidos}">
                            <tr>
                                <td><strong>#OL-${pedido.id}</strong></td>
                                <!-- Formateamos la fecha Timestamp a formato legible europeo -->
                                <td><fmt:formatDate value="${pedido.fecha}" pattern="dd/MM/yyyy HH:mm" timeZone="Europe/Madrid"/></td>
                                <td><fmt:formatNumber value="${pedido.total}" type="currency" currencySymbol="€" maxFractionDigits="2"/></td>
                                <td>
                                    <!-- Cambio de color dinámico según el estado de la BD -->
                                    <c:choose>
                                        <c:when test="${pedido.estado == 'RECIBIDO'}">
                                            <span class="etiqueta estado-proceso">Recibido</span>
                                        </c:when>
                                        <c:when test="${pedido.estado == 'ENTREGADO'}">
                                            <span class="etiqueta estado-completado">Entregado</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="etiqueta">${pedido.estado}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><a href="${pageContext.request.contextPath}/mis-pedidos?id=${pedido.id}" class="enlace-accion">Ver factura</a></td>
                            </tr>
                        </c:forEach>
                        
                        <!-- Mensaje por defecto si la base de datos devuelve 0 compras -->
                        <c:if test="${empty pedidos}">
                            <tr>
                                <td colspan="5" style="text-align: center; padding: 2rem;">Aún no has realizado ninguna compra en Oleum.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>