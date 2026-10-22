package es.uah.oleum.service;

import es.uah.oleum.dao.PedidoDAO;
import es.uah.oleum.model.Pedido;
import es.uah.oleum.model.LineaPedido;
import java.util.List;

public class PedidoService {

    private PedidoDAO pedidoDAO;

    public PedidoService() {
        // Se instancia el DAO correspondiente para delegar el acceso a datos
        this.pedidoDAO = new PedidoDAO();
    }

    /**
     * Procesa la compra verificando previamente las reglas de negocio.
     * Un pedido no puede ser tramitado si no contiene ninguna línea de artículos.
     */
    public boolean procesarCompra(Pedido pedido, List<LineaPedido> lineas) {
        // Regla de negocio: Rechazar pedidos vacíos antes de contactar con la base de datos
        if (lineas == null || lineas.isEmpty()) {
            return false;
        }
        
        // Si la validación es correcta, se delega la ejecución transaccional al DAO
        return pedidoDAO.tramitarPedido(pedido, lineas);
    }

    /**
     * Solicita al DAO el listado completo de pedidos asociados al usuario que ha iniciado sesión.
     */
    public List<Pedido> obtenerMisPedidos(int usuarioId) {
        return pedidoDAO.obtenerPedidosPorUsuario(usuarioId);
    }

    /**
     * Solicita al DAO la información de cabecera de una factura específica.
     */
    public Pedido obtenerDetallePedido(int id) {
        // Validaciones de seguridad (ej. comprobar que el pedido pertenece al usuario logueado) 
        // podrían implementarse en este nivel en un futuro.
        return pedidoDAO.obtenerPedidoPorId(id);
    }

    /**
     * Solicita al DAO el desglose de productos adquiridos en una factura específica.
     */
    public List<LineaPedido> obtenerLineasDePedido(int pedidoId) {
        return pedidoDAO.obtenerLineasPorPedido(pedidoId);
    }
}