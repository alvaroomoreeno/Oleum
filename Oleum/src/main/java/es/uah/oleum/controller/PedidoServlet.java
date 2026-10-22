package es.uah.oleum.controller;

import es.uah.oleum.model.LineaPedido;
import es.uah.oleum.model.Pedido;
import es.uah.oleum.model.Usuario;
import es.uah.oleum.service.PedidoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PedidoServlet", urlPatterns = {"/pedidos"})
public class PedidoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Pedido pedido = (Pedido) session.getAttribute("pedidoProceso");
        List<LineaPedido> lineas = (List<LineaPedido>) session.getAttribute("lineasPedido");

        // Obtenemos el usuario que está actualmente logueado
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");

        // Validaciones de seguridad: Si no hay pedido, no hay carrito o la sesión expiró
        if (pedido == null || lineas == null || lineas.isEmpty() || usuarioLogueado == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String direccionCompleta = request.getParameter("direccion") + ", " + 
                                   request.getParameter("ciudad") + ", " + 
                                   request.getParameter("cp");
        pedido.setDireccionEnvio(direccionCompleta);
        
        // ASIGNACIÓN REAL: El pedido queda vinculado al ID del cliente en sesión
        pedido.setUsuarioId(usuarioLogueado.getId()); 

        PedidoService pedidoService = new PedidoService();
        boolean exito = pedidoService.procesarCompra(pedido, lineas);

        if (exito) {
            session.removeAttribute("pedidoProceso");
            session.removeAttribute("lineasPedido");
            session.removeAttribute("nombresProductos");
            response.sendRedirect(request.getContextPath() + "/mis-pedidos?compra=ok");
        } else {
            response.sendRedirect(request.getContextPath() + "/carrito?error=stock");
        }
    }
}