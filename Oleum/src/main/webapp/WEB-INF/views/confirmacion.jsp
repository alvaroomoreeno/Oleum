<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmar Pedido - Oleum</title>
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

    <!-- CONTENIDO PRINCIPAL: Confirmación y Pago -->
    <main class="contenedor-proceso-pago">
        <nav aria-label="Migas de pan" class="migas-de-pan">
            <a href="${pageContext.request.contextPath}/carrito">Carrito</a> &gt; 
            <span>Confirmación y Pago</span>
        </nav>

        <h2>Confirmación del Pedido</h2>

        <div class="carrito-layout">
            <!-- Formulario de envío y pago (Simulado) -->
            <section class="formulario-envio">
                <form action="${pageContext.request.contextPath}/pedidos" method="POST" class="form-grid">
                    
                    <h3>1. Dirección de Envío</h3>
                    <div class="grupo-input col-completa">
                        <label for="direccion">Dirección completa:</label>
                        <input type="text" id="direccion" name="direccion" required placeholder="Calle, Número, Puerta...">
                    </div>
                    <div class="grupo-input">
                        <label for="ciudad">Ciudad:</label>
                        <input type="text" id="ciudad" name="ciudad" required>
                    </div>
                    <div class="grupo-input">
                        <label for="cp">Código Postal:</label>
                        <input type="text" id="cp" name="cp" required>
                    </div>

                    <h3 class="separador-form">2. Método de Pago (Entorno de Prueba)</h3>
                    <div class="grupo-input col-completa">
                        <label for="metodo-pago">Selecciona una opción de simulación:</label>
                        <select id="metodo-pago" name="metodo-pago" required>
                            <option value="" disabled selected>Seleccione un método de pago</option>
                            <option value="tarjeta-fake">Pago Simulado con Tarjeta (Demo)</option>
                            <option value="transferencia">Transferencia Bancaria (Manual)</option>
                        </select>
                        <p class="nota-pago">Nota: Esta es una pasarela de pago ficticia. No se procesarán cobros reales.</p>
                    </div>

                    <div class="col-completa">
                        <button type="submit" class="btn-primario btn-block btn-pagar">Confirmar y Pagar ${sessionScope.pedidoProceso.total} €</button>
                    </div>
                </form>
            </section>

            <!-- Panel lateral de resumen (Solo lectura) -->
            <aside class="carrito-resumen">
                <h3>Resumen Final</h3>
                <ul class="lista-resumen-final">
                    <c:forEach var="linea" items="${sessionScope.lineasPedido}">
                        <li>${sessionScope.nombresProductos[linea.productoId]} - Cantidad: ${linea.cantidad} - Precio Unidad: ${linea.precioUnitario} €</li>
                    </c:forEach>
                    <li>Gastos de envío - 4.99 €</li>
                </ul>
                <div class="resumen-total">
                    <span>Total a pagar:</span>
                    <span>${sessionScope.pedidoProceso.total} €</span>
                </div>
            </aside>
        </div>
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