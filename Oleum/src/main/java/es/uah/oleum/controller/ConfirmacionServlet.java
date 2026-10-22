package es.uah.oleum.controller;

import es.uah.oleum.model.LineaPedido;
import es.uah.oleum.model.Pedido;
import es.uah.oleum.model.Producto;
import es.uah.oleum.service.ProductoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ConfirmacionServlet", urlPatterns = {"/pedidos/confirmar"})
public class ConfirmacionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String datosCarrito = request.getParameter("datosCarrito");

        if (datosCarrito == null || datosCarrito.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carrito");
            return;
        }

        ProductoService productoService = new ProductoService();
        List<LineaPedido> lineas = new ArrayList<>();
        Map<Integer, String> nombresProductos = new HashMap<>(); // Para pasar los nombres a la vista
        double subtotal = 0.0;

        String[] items = datosCarrito.split(",");
        for (String item : items) {
            String[] partes = item.split(":");
            if (partes.length == 2) {
                try {
                    int prodId = Integer.parseInt(partes[0].trim());
                    int cantidad = Integer.parseInt(partes[1].trim());

                    Producto p = productoService.obtenerDetalleProducto(prodId);
                    
                    if (p != null && p.getStock() >= cantidad && p.isActivo()) { 
                        LineaPedido linea = new LineaPedido();
                        linea.setProductoId(p.getId());
                        linea.setCantidad(cantidad);
                        linea.setPrecioUnitario(p.getPrecio()); 
                        lineas.add(linea);
                        nombresProductos.put(p.getId(), p.getNombre()); // Guardar nombre
                        subtotal += (p.getPrecio() * cantidad);
                    }
                } catch (NumberFormatException e) {
                    // Evita errores
                }
            }
        }

        if (lineas.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/carrito?error=bd_vacia_o_sin_stock");
            return;
        }

        double gastosEnvio = 4.99;
        double total = subtotal + gastosEnvio;

        Pedido pedidoTemp = new Pedido();
        pedidoTemp.setTotal(total);

        HttpSession session = request.getSession();
        session.setAttribute("lineasPedido", lineas);
        session.setAttribute("nombresProductos", nombresProductos); // Pasamos los nombres a sesión
        session.setAttribute("pedidoProceso", pedidoTemp);
        session.setAttribute("subtotalPedido", subtotal);

        request.getRequestDispatcher("/WEB-INF/views/confirmacion.jsp").forward(request, response);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/carrito");
    }
}