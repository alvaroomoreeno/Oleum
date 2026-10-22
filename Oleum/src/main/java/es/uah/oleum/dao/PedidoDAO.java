package es.uah.oleum.dao;

import es.uah.oleum.model.Pedido;
import es.uah.oleum.model.LineaPedido;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class PedidoDAO {

    /**
     * Persiste un nuevo pedido y sus líneas correspondientes.
     * Se ejecuta como una transacción atómica: si falla el registro de una línea
     * o no hay stock suficiente, se deshacen todos los cambios (rollback).
     */
    public boolean tramitarPedido(Pedido pedido, List<LineaPedido> lineas) {
        String sqlPedido = "INSERT INTO pedido (usuario_id, estado, direccion_envio, total) VALUES (?, ?, ?, ?)";
        String sqlLinea = "INSERT INTO linea_pedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES (?, ?, ?, ?)";
        String sqlStock = "UPDATE producto SET stock = stock - ? WHERE id = ? AND stock >= ?";

        Connection conn = null;

        try {
            conn = ConexionBD.obtenerConexion();
            // Desactivamos el autocommit para iniciar la transacción manual
            conn.setAutoCommit(false); 

            int pedidoId = -1;
            
            // 1. Inserción del registro principal del Pedido
            // Utilizamos Statement.RETURN_GENERATED_KEYS para recuperar el ID autoincremental generado por MySQL
            try (PreparedStatement psPedido = conn.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS)) {
                psPedido.setInt(1, pedido.getUsuarioId());
                psPedido.setString(2, "RECIBIDO");
                psPedido.setString(3, pedido.getDireccionEnvio());
                psPedido.setDouble(4, pedido.getTotal());
                psPedido.executeUpdate();

                try (ResultSet rsKeys = psPedido.getGeneratedKeys()) {
                    if (rsKeys.next()) {
                        pedidoId = rsKeys.getInt(1);
                    }
                }
            }

            // 2. Inserción de las Líneas de Pedido y Actualización de Stock
            try (PreparedStatement psLinea = conn.prepareStatement(sqlLinea);
                 PreparedStatement psStock = conn.prepareStatement(sqlStock)) {
                
                for (LineaPedido linea : lineas) {
                    // Preparamos y ejecutamos la inserción de la línea
                    psLinea.setInt(1, pedidoId);
                    psLinea.setInt(2, linea.getProductoId());
                    psLinea.setInt(3, linea.getCantidad());
                    psLinea.setDouble(4, linea.getPrecioUnitario());
                    psLinea.executeUpdate();

                    // Preparamos y ejecutamos la reducción de stock
                    psStock.setInt(1, linea.getCantidad());
                    psStock.setInt(2, linea.getProductoId());
                    psStock.setInt(3, linea.getCantidad());
                    int filasAfectadas = psStock.executeUpdate();

                    // Si el UPDATE devuelve 0 filas afectadas, significa que no se cumplió "stock >= cantidad"
                    if (filasAfectadas == 0) {
                        throw new SQLException("Falta de stock para el producto ID: " + linea.getProductoId());
                    }
                }
            }
            
            // 3. Confirmación de la transacción si todas las operaciones fueron exitosas
            conn.commit();
            return true;

        } catch (SQLException e) {
            System.err.println("Error en transacción de pedido: " + e.getMessage());
            // En caso de cualquier error (ej. falta de stock), revertimos los cambios en la base de datos
            if (conn != null) {
                try { 
                    conn.rollback(); 
                } catch (SQLException ex) { 
                    ex.printStackTrace(); 
                }
            }
            return false;
        } finally {
            // Aseguramos el cierre de la conexión y restauramos el comportamiento por defecto
            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) { 
                    e.printStackTrace(); 
                }
            }
        }
    }

    /**
     * Recupera el historial dinámico de compras de un cliente específico,
     * ordenando los resultados desde el más reciente al más antiguo.
     */
    public List<Pedido> obtenerPedidosPorUsuario(int usuarioId) {
        List<Pedido> lista = new ArrayList<>();
        String sql = "SELECT * FROM pedido WHERE usuario_id = ? ORDER BY fecha DESC";

        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, usuarioId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Pedido p = new Pedido();
                    p.setId(rs.getInt("id"));
                    p.setUsuarioId(rs.getInt("usuario_id"));
                    p.setFecha(rs.getTimestamp("fecha"));
                    p.setEstado(rs.getString("estado"));
                    p.setDireccionEnvio(rs.getString("direccion_envio"));
                    p.setTotal(rs.getDouble("total"));
                    lista.add(p);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener historial: " + e.getMessage());
        }
        return lista;
    }

    /**
     * Busca los datos generales de un pedido concreto a partir de su ID.
     * Utilizado para renderizar la cabecera de la factura.
     */
    public Pedido obtenerPedidoPorId(int id) {
        Pedido p = null;
        String sql = "SELECT * FROM pedido WHERE id = ?";
        
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Pedido();
                    p.setId(rs.getInt("id"));
                    p.setUsuarioId(rs.getInt("usuario_id"));
                    p.setFecha(rs.getTimestamp("fecha"));
                    p.setEstado(rs.getString("estado"));
                    p.setDireccionEnvio(rs.getString("direccion_envio"));
                    p.setTotal(rs.getDouble("total"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener pedido: " + e.getMessage());
        }
        return p;
    }

    /**
     * Extrae el desglose de artículos (líneas) asociados a un número de pedido.
     * Utilizado para renderizar la tabla de productos dentro de la factura.
     */
    public List<LineaPedido> obtenerLineasPorPedido(int pedidoId) {
        List<LineaPedido> lista = new ArrayList<>();
        String sql = "SELECT * FROM linea_pedido WHERE pedido_id = ?";
        
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, pedidoId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LineaPedido lp = new LineaPedido();
                    lp.setPedidoId(rs.getInt("pedido_id"));
                    lp.setProductoId(rs.getInt("producto_id"));
                    lp.setCantidad(rs.getInt("cantidad"));
                    lp.setPrecioUnitario(rs.getDouble("precio_unitario"));
                    lista.add(lp);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener líneas: " + e.getMessage());
        }
        return lista;
    }
}