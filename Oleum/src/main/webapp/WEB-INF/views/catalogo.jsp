<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo - Oleum</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/estilos.css">
</head>
<body>
    <header>
        <div class="logo">
            <h1><a href="${pageContext.request.contextPath}/productos">Oleum</a></h1>
        </div>
        <nav aria-label="Navegación principal">
            <ul>
                <li><a href="${pageContext.request.contextPath}/productos" class="activo">Catálogo</a></li>
                
                <c:choose>
                    <c:when test="${not empty sessionScope.usuarioLogueado}">
                        <li><a href="${pageContext.request.contextPath}/perfil">Hola, ${sessionScope.usuarioLogueado.nombre}</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="${pageContext.request.contextPath}/login">Mi Cuenta</a></li>
                    </c:otherwise>
                </c:choose>
                
                <li><a href="${pageContext.request.contextPath}/carrito">Carrito</a></li>
            </ul>
        </nav>
    </header>

    <main class="contenedor-panel">
        <h2 style="text-align: center; margin-bottom: 2rem;">Catálogo de Aceites</h2>
        
        <section class="catalogo-grid" style="display: flex; flex-wrap: wrap; gap: 2rem; justify-content: center;">
            
            <!-- Bucle dinámico que recorrerá los 12 productos de la base de datos -->
            <c:forEach var="p" items="${productos}">
                <div class="producto-card" style="border: 1px solid #ddd; padding: 1rem; border-radius: 8px; width: 300px; text-align: center;">
                    <img src="${pageContext.request.contextPath}/assets/img/${p.imagen}" alt="${p.nombre}" style="max-width: 100%; height: 250px; object-fit: cover;">
                    <h3 style="margin: 1rem 0;">${p.nombre}</h3>
                    <p class="variedad">Variedad: ${p.variedad}</p>
                    <p class="formato">Formato: ${p.formatoMl} ml</p>
                    
                    <!-- Lógica condicional para mostrar el stock o "Agotado" -->
                    <p class="disponibilidad">
                        Disponibilidad: 
                        <c:choose>
                            <c:when test="${p.stock > 0}">
                                <strong>${p.stock} uds.</strong>
                            </c:when>
                            <c:otherwise>
                                <span style="color: red; font-weight: bold;">Sin stock</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                    
                    <p class="precio" style="font-size: 1.25rem; font-weight: bold; margin: 1rem 0;">
                        <fmt:formatNumber value="${p.precio}" type="currency" currencySymbol="€"/>
                    </p>
                    
                    <!-- Si no hay stock, el botón se deshabilita -->
                    <c:choose>
                        <c:when test="${p.stock > 0}">
                            <button class="btn-agregar btn-primario" data-id="${p.id}" data-nombre="${p.nombre}" data-precio="${p.precio}">Añadir al carrito</button>
                        </c:when>
                        <c:otherwise>
                            <button class="btn-deshabilitado" disabled style="background: #ccc; cursor: not-allowed; padding: 0.8rem 1.5rem; border: none; border-radius: 4px; color: white;">Agotado</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:forEach>

            <c:if test="${empty productos}">
                <p>No hay productos disponibles en este momento.</p>
            </c:if>
            
        </section>
    </main>

    <script src="${pageContext.request.contextPath}/assets/js/app.js"></script>
</body>
</html>