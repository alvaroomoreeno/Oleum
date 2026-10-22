<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Factura de Pedido - Oleum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/estilos.css">
    <style>
        .ticket-factura {
            background: #fff;
            padding: 3rem;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            max-width: 800px;
            margin: 0 auto;
            border-top: 8px solid var(--color-primario);
        }
        .cabecera-factura {
            display: flex;
            justify-content: space-between;
            border-bottom: 2px solid var(--color-borde);
            padding-bottom: 1.5rem;
            margin-bottom: 2rem;
        }
        .datos-empresa h2 { color: var(--color-primario); font-size: 2rem; }
        
        /* Regla de impresión: oculta la web, muestra solo el ticket */
        @media print {
            body * { visibility: hidden; }
            .ticket-factura, .ticket-factura * { visibility: visible; }
            .ticket-factura {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                border: none;
                box-shadow: none;
                padding: 0;
            }
            .btn-imprimir, header, nav, footer { display: none !important; }
        }
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

    <main class="contenedor-panel" style="display: block;">
        <nav aria-label="Migas de pan" class="migas-de-pan" style="max-width: 800px; margin: 0 auto 1.5rem;">
            <a href="${pageContext.request.contextPath}/perfil">Mi Cuenta</a> &gt; 
            <a href="${pageContext.request.contextPath}/mis-pedidos">Historial de Pedidos</a> &gt; 
            <span>Factura #${facturaPedido.id}</span>
        </nav>

        <section class="ticket-factura">
            <div class="cabecera-factura">
                <div class="datos-empresa">
                    <h2>OLEUM</h2>
                    <p>C/ Colegios, 2<br>28801 Alcalá de Henares, Madrid<br>CIF: B-12345678</p>
                </div>
                <div class="datos-pedido" style="text-align: right;">
                    <h3 style="color: var(--color-texto-secundario);">FACTURA</h3>
                    <p><strong>Nº Pedido:</strong> #OL-${facturaPedido.id}</p>
                    <p><strong>Fecha:</strong> <fmt:formatDate value="${facturaPedido.fecha}" pattern="dd/MM/yyyy HH:mm" timeZone="Europe/Madrid"/></p>
                    <p><strong>Estado:</strong> <span class="etiqueta estado-completado">${facturaPedido.estado}</span></p>
                </div>
            </div>

            <div style="margin-bottom: 2rem;">
                <h4 style="margin-bottom: 0.5rem;">Datos de Envío:</h4>
                <p>${facturaPedido.direccionEnvio}</p>
            </div>

            <table class="tabla-datos" style="margin-bottom: 2rem;">
                <thead>
                    <tr>
                        <th>Descripción</th>
                        <th style="text-align: center;">Cantidad</th>
                        <th style="text-align: right;">Precio Ud.</th>
                        <th style="text-align: right;">Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="linea" items="${facturaLineas}">
                        <tr>
                            <td>${nombresProductos[linea.productoId]}</td>
                            <td style="text-align: center;">${linea.cantidad}</td>
                            <td style="text-align: right;"><fmt:formatNumber value="${linea.precioUnitario}" type="currency" currencySymbol="€"/></td>
                            <td style="text-align: right;"><strong><fmt:formatNumber value="${linea.cantidad * linea.precioUnitario}" type="currency" currencySymbol="€"/></strong></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div style="display: flex; justify-content: flex-end;">
                <div style="width: 300px;">
                    <div class="resumen-linea"><span>Gastos de envío:</span><span>4,99 €</span></div>
                    <div class="resumen-total" style="font-size: 1.5rem;">
                        <span>TOTAL:</span>
                        <span><fmt:formatNumber value="${facturaPedido.total}" type="currency" currencySymbol="€"/></span>
                    </div>
                </div>
            </div>
            
            <div style="text-align: center; margin-top: 3rem;">
                <button onclick="window.print()" class="btn-secundario btn-imprimir">Imprimir Factura</button>
            </div>
        </section>
    </main>
    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>