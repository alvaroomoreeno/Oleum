<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Pedidos - Admin Oleum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/estilos.css">
</head>
<body>

    <!-- CABECERA -->
    <header>
        <div class="logo">
            <h1><a href="${pageContext.request.contextPath}/productos">Oleum <span style="font-size: 0.8rem; color: var(--color-acento);">[ADMIN]</span></a></h1>
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

    <!-- CONTENIDO PRINCIPAL: Panel de Administración -->
    <main class="contenedor-panel">
        
        <!-- Menú Lateral del Administrador -->
        <aside class="menu-panel">
            <h2>Administración</h2>
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/productos">Catálogo de Productos</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/pedidos" class="activo">Gestión de Pedidos</a></li>
                <li>
                    <form action="${pageContext.request.contextPath}/logout" method="POST">
                        <button type="submit" class="btn-logout-menu texto-peligro">Cerrar Sesión</button>
                    </form>
                </li>
            </ul>
        </aside>

        <!-- Área de Contenido: Tabla de Pedidos -->
        <section class="contenido-panel">
            <h3>Gestión de Pedidos</h3>
            <p class="subtitulo-panel">Revisa las compras de los clientes y actualiza su estado de envío.</p>

            <div class="tabla-responsiva">
                <table class="tabla-datos">
                    <thead>
                        <tr>
                            <th>Nº Pedido</th>
                            <th>Cliente</th>
                            <th>Fecha</th>
                            <th>Total</th>
                            <th>Estado Actual</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>#OL-9045</strong></td>
                            <td>Juan Pérez</td>
                            <td>24/09/2026</td>
                            <td>34,00 €</td>
                            <td colspan="2">
                                <form action="${pageContext.request.contextPath}/admin/pedidos/estado" method="POST" style="display: flex; align-items: center; gap: 1rem;">
                                    <input type="hidden" name="pedidoId" value="9045">
                                    <select name="estado" class="select-estado">
                                        <option value="RECIBIDO">Recibido</option>
                                        <option value="EN_PREPARACION" selected>En preparación</option>
                                        <option value="ENVIADO">Enviado</option>
                                        <option value="ENTREGADO">Entregado</option>
                                        <option value="CANCELADO">Cancelado</option>
                                    </select>
                                    <button type="submit" class="btn-enlace-accion">Actualizar / Guardar</button>
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td><strong>#OL-9021</strong></td>
                            <td>María López</td>
                            <td>15/09/2026</td>
                            <td>17,49 €</td>
                            <td>
                                <select class="select-estado" disabled>
                                    <option value="ENTREGADO" selected>Entregado</option>
                                </select>
                            </td>
                            <td><a href="${pageContext.request.contextPath}/admin/pedidos?id=9021" class="enlace-accion">Ver factura</a></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </section>

    </main>

    <!-- PIE DE PÁGINA -->
    <footer>
        <div class="footer-contenido">
            <p>&copy; 2026 Oleum - Proyecto de Arquitectura y Diseño Web</p>
        </div>
    </footer>

</body>
</html>