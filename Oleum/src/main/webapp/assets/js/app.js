// 1. INICIALIZACIÓN DE ESTADO
// Intenta recuperar el carrito guardado en el navegador (localStorage). Si no existe, crea un array vacío.
let carrito = JSON.parse(localStorage.getItem('oleum_carrito')) || [];

// 2. PERSISTENCIA DE DATOS
// Sobrescribe el almacenamiento local del navegador con el estado actual del array 'carrito'.
function guardarCarrito() {
    localStorage.setItem('oleum_carrito', JSON.stringify(carrito));
}

// 3. ENRUTAMIENTO DINÁMICO FRONT-END
// Obtiene la ruta base del proyecto (Context Path) para evitar errores 404 estáticos al cargar imágenes.
function obtenerContextPath() {
    const enlaceLogo = document.querySelector('header .logo a');
    return enlaceLogo ? enlaceLogo.getAttribute('href').replace('/productos', '') : '';
}

// 4. ACTUALIZACIÓN VISUAL (CABECERA)
// Suma las cantidades y actualiza el texto del carrito en el menú superior.
function actualizarContadorHeader() {
    const enlaceCarrito = document.querySelector('nav ul li a[href$="/carrito"]');
    if (enlaceCarrito) {
        const total = carrito.reduce((sum, item) => sum + item.cantidad, 0);
        enlaceCarrito.textContent = `Carrito (${total})`;
    }
}

// 5. LÓGICA DE AGREGACIÓN
// Añade un producto al carrito o incrementa la cantidad si ya existe, y guarda los cambios.
function agregarAlCarrito(id, nombre, precio, cantidad) {
    const index = carrito.findIndex(i => i.id === id);
    if (index !== -1) carrito[index].cantidad += cantidad;
    else carrito.push({ id, nombre, precio: parseFloat(precio), cantidad: parseInt(cantidad) });
    guardarCarrito();
    actualizarContadorHeader();
}

// 6. MOTOR DE RENDERIZADO DEL CARRITO (VISTA)
// Limpia y regenera dinámicamente la tabla del carrito en base a los datos actuales.
function renderizarCarrito() {
    const tbody = document.querySelector('.carrito-lista tbody');
    if (!tbody) return; 

    const resumenSubtotal = document.querySelector('.resumen-linea:nth-child(2) span:last-child');
    const resumenTotal = document.querySelector('.resumen-total span:last-child');
    const basePath = obtenerContextPath();

    tbody.innerHTML = ''; 
    let subtotalCompra = 0;

    if (carrito.length === 0) {
        tbody.innerHTML = '<tr><td colspan="5" style="text-align: center; padding: 2rem;">Tu carrito está vacío.</td></tr>';
        if (resumenSubtotal) resumenSubtotal.textContent = '0,00 €';
        if (resumenTotal) resumenTotal.textContent = '0,00 €';
        return;
    }

    carrito.forEach((item, index) => {
        subtotalCompra += item.precio * item.cantidad;
        let imgFile = 'botella1.jpg';
        if (item.id.includes('002') || item.id === '2') imgFile = 'botella2.jpg';
        if (item.id.includes('003') || item.id === '3') imgFile = 'botella3.jpg';

        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td class="col-producto">
                <img src="${basePath}/assets/img/${imgFile}" alt="${item.nombre}">
                <span>${item.nombre}</span>
            </td>
            <td>${item.precio.toFixed(2).replace('.', ',')} €</td>
            <td>
                <input type="number" value="${item.cantidad}" min="1" max="24" class="input-cantidad" data-index="${index}">
            </td>
            <td><strong>${(item.precio * item.cantidad).toFixed(2).replace('.', ',')} €</strong></td>
            <td>
                <button type="button" class="btn-eliminar" data-index="${index}">Eliminar</button>
            </td>
        `;
        tbody.appendChild(tr);
    });

    if (resumenSubtotal) resumenSubtotal.textContent = `${subtotalCompra.toFixed(2).replace('.', ',')} €`;
    if (resumenTotal) resumenTotal.textContent = `${(subtotalCompra + 4.99).toFixed(2).replace('.', ',')} €`;

    asignarEventosModificacion();
}

// 7. LISTENERS DE MODIFICACIÓN DEL CARRITO
// Activa las funciones de eliminar producto o cambiar cantidades en los elementos recién generados.
function asignarEventosModificacion() {
    document.querySelectorAll('.btn-eliminar').forEach(btn => {
        btn.addEventListener('click', e => {
            carrito.splice(e.target.getAttribute('data-index'), 1);
            guardarCarrito();         
            renderizarCarrito();
            actualizarContadorHeader(); 
        });
    });

    document.querySelectorAll('.input-cantidad').forEach(input => {
        input.addEventListener('change', e => {
            const nuevaCantidad = parseInt(e.target.value);
            if (nuevaCantidad > 0) {
                carrito[e.target.getAttribute('data-index')].cantidad = nuevaCantidad;
                guardarCarrito();
                renderizarCarrito(); 
                actualizarContadorHeader(); 
            }
        });
    });
}

// 8. FILTROS DEL CATÁLOGO
// Oculta o muestra productos en el catálogo según el texto de búsqueda, variedad y rango de precio.
function inicializarFiltros() {
    const btnFiltrar = document.querySelector('.btn-filtrar');
    if (!btnFiltrar) return; 

    btnFiltrar.addEventListener('click', () => {
        const textoBusqueda = document.getElementById('buscar').value.toLowerCase().trim();
        const variedadSeleccionada = document.getElementById('variedad').value.toLowerCase();
        const precioMin = parseFloat(document.querySelector('input[name="precio_min"]').value) || 0;
        const precioMax = parseFloat(document.querySelector('input[name="precio_max"]').value) || Infinity;

        document.querySelectorAll('.producto-card').forEach(producto => {
            const nombre = producto.querySelector('h3').textContent.toLowerCase();
            const textoVariedad = producto.querySelector('.variedad').textContent.toLowerCase();
            const precio = parseFloat(producto.querySelector('.precio').textContent.replace(',', '.').replace(' €', ''));

            const cumple = nombre.includes(textoBusqueda) && 
                           (variedadSeleccionada === "" || textoVariedad.includes(variedadSeleccionada)) && 
                           (precio >= precioMin && precio <= precioMax);

            producto.style.display = cumple ? 'flex' : 'none';
        });
    });
}

// 9. VALIDACIÓN DE FORMULARIOS FRONT-END (Registro, Login, Perfil)
function inicializarValidacionFormularios() {
    const formularios = document.querySelectorAll('form.formulario-auth, form.formulario-perfil, .formulario-envio form');
    formularios.forEach(form => {
        form.addEventListener('submit', (e) => {
            let valid = true;
            form.querySelectorAll('.mensaje-error').forEach(err => err.remove());

            const email = form.querySelector('input[type="email"]');
            const password = form.querySelector('input[type="password"]');
            const nombre = form.querySelector('input[name="nombre"]');

            if (email && !email.readOnly && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value.trim())) {
                valid = false;
                mostrarError(email, 'Introduce un correo electrónico válido (ej: usuario@correo.com).');
            }
            if (password && password.value.length < 8) {
                valid = false;
                mostrarError(password, 'La contraseña debe tener al menos 8 caracteres por seguridad.');
            }
            if (nombre && nombre.value.trim().length === 0) {
                valid = false;
                mostrarError(nombre, 'El nombre completo es obligatorio.');
            }
            if (!valid) e.preventDefault(); 
        });
    });
}

function mostrarError(input, mensaje) {
    const error = document.createElement('span');
    error.className = 'mensaje-error';
    error.style.color = '#d9534f';
    error.style.fontSize = '0.85rem';
    error.style.display = 'block';
    error.style.marginTop = '0.4rem';
    error.style.fontWeight = '600';
    error.textContent = mensaje;
    input.parentNode.appendChild(error);
    input.style.borderColor = '#d9534f';
    input.addEventListener('input', function() {
        input.style.borderColor = 'var(--color-borde)';
        if (error.parentNode) error.remove();
    }, {once: true});
}

// 10. SERIALIZACIÓN DE PEDIDOS AL SERVIDOR
// Evita el envío si el carrito está vacío y agrupa los IDs y cantidades para procesarlos en ConfirmacionServlet.
function inicializarFormularioCarrito() {
    const formTramitar = document.getElementById('form-tramitar');
    if (formTramitar) {
        formTramitar.addEventListener('submit', function(e) {
            if (carrito.length === 0) {
                e.preventDefault();
                alert("El carrito está vacío. Añade productos antes de tramitar.");
                return;
            }
            const datos = carrito.map(item => {
                const idNum = item.id.toString().replace(/\D/g, ''); 
                return `${idNum}:${item.cantidad}`;
            }).join(',');
            document.getElementById('datosCarrito').value = datos;
        });
    }
}

// 11. MOTOR DE EVENTOS Y ARRANQUE
document.addEventListener('DOMContentLoaded', () => {
    // Vaciar carrito automáticamente si venimos de un pago exitoso
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('compra') === 'ok') {
        carrito = []; 
        guardarCarrito(); 
        alert("¡Pedido realizado con éxito!");
        window.history.replaceState({}, document.title, window.location.pathname);
    }

    actualizarContadorHeader();
    renderizarCarrito();
    inicializarFiltros();
    inicializarValidacionFormularios(); 
    inicializarFormularioCarrito();

    document.querySelectorAll('.btn-agregar').forEach(boton => {
        boton.addEventListener('click', (evento) => {
            evento.preventDefault(); 
            const id = boton.getAttribute('data-id');
            const nombre = boton.getAttribute('data-nombre');
            const precio = boton.getAttribute('data-precio');
            
            const inputCant = document.getElementById('cantidad');
            const cant = inputCant ? parseInt(inputCant.value) : 1;
            
            agregarAlCarrito(id, nombre, precio, cant);
            alert(`¡Se han añadido ${cant} unidad(es) de ${nombre} al carrito!`);
        });
    });
});