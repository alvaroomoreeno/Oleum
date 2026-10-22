package es.uah.oleum.controller;

import es.uah.oleum.model.LineaPedido;
import es.uah.oleum.model.Pedido;
import es.uah.oleum.model.Producto;
import es.uah.oleum.model.Usuario;
import es.uah.oleum.service.PedidoService;
import es.uah.oleum.service.ProductoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "HistorialPedidosServlet", urlPatterns = {"/mis-pedidos"})
public class HistorialPedidosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

        // Si intenta entrar sin sesión, se le expulsa al login
        if (usuarioLogueado == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idPedido = request.getParameter("id");
        PedidoService pedidoService = new PedidoService();
        
        if (idPedido != null && !idPedido.isEmpty()) {
            // Lógica de factura individual
            int id = Integer.parseInt(idPedido);
            Pedido pedido = pedidoService.obtenerDetallePedido(id);
            
            // Seguridad: Comprobar que el pedido pertenece al usuario logueado
            if (pedido == null || pedido.getUsuarioId() != usuarioLogueado.getId()) {
                response.sendRedirect(request.getContextPath() + "/mis-pedidos");
                return;
            }

            List<LineaPedido> lineas = pedidoService.obtenerLineasDePedido(id);
            ProductoService productoService = new ProductoService();
            Map<Integer, String> nombresProductos = new HashMap<>();
            
            for (LineaPedido linea : lineas) {
                Producto p = productoService.obtenerDetalleProducto(linea.getProductoId());
                if (p != null) {
                    nombresProductos.put(p.getId(), p.getNombre());
                }
            }
            
            request.setAttribute("facturaPedido", pedido);
            request.setAttribute("facturaLineas", lineas);
            request.setAttribute("nombresProductos", nombresProductos);
            request.getRequestDispatcher("/WEB-INF/views/factura.jsp").forward(request, response);
            
        } else {
            // LECTURA DINÁMICA: Cargamos el historial exclusivo del ID del usuario conectado
            List<Pedido> misPedidos = pedidoService.obtenerMisPedidos(usuarioLogueado.getId());
            request.setAttribute("pedidos", misPedidos);
            request.getRequestDispatcher("/WEB-INF/views/historial-pedidos.jsp").forward(request, response);
        }
    }
}