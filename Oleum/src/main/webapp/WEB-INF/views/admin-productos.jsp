<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administración de Catálogo - Oleum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/estilos.css">
</head>
<body>
    <header>
        <div class="logo">
            <h1><a href="${pageContext.request.contextPath}/admin/productos">Oleum Admin</a></h1>
        </div>
        <nav aria-label="Navegación principal">
            <ul>
                <li><a href="${pageContext.request.contextPath}/productos">Ver Tienda</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/productos" class="activo">Catálogo</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/pedidos">Pedidos</a></li>
                <li>
                    <form action="${pageContext.request.contextPath}/logout" method="POST" style="display:inline;">
                        <button type="submit" class="btn-enlace">Cerrar Sesión</button>
                    </form>
                </li>
            </ul>
        </nav>
    </header>

    <main class="contenedor-panel">
        <section style="width: 100%;">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
                <h2>Gestión de Productos</h2>
                <a href="${pageContext.request.contextPath}/admin/productos/nuevo" class="btn-primario">Añadir Nuevo Producto</a>
            </div>

            <table class="tabla-datos">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Stock</th>
                        <th>Precio</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="producto" items="${productosAdmin}">
                        <tr>
                            <td>${producto.id}</td>
                            <td><strong>${producto.nombre}</strong></td>
                            <td style="text-align: center;">
                                <span class="${producto.stock == 0 ? 'texto-peligro' : ''}">${producto.stock}</span>
                            </td>
                            <td><fmt:formatNumber value="${producto.precio}" type="currency" currencySymbol="€"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${producto.activo}">
                                        <span class="etiqueta estado-completado">Activo</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="etiqueta estado-cancelado">Baja Lógica</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/productos/editar?id=${producto.id}" class="enlace-accion">Editar</a> | 
                                <form action="${pageContext.request.contextPath}/admin/productos/baja" method="POST" style="display:inline;">
                                    <input type="hidden" name="id" value="${producto.id}">
                                    <button type="submit" class="btn-enlace texto-peligro" onclick="return confirm('¿Aplicar baja lógica a este producto?');">Dar de baja</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </section>
    </main>
</body>
</html>