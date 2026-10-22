package es.uah.oleum.dao;

import es.uah.oleum.model.Producto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {

    /**
     * Obtiene TODOS los productos de la base de datos (Activos e Inactivos).
     * Este método es exclusivo para el PANEL DE ADMINISTRADOR.
     */
    public List<Producto> obtenerTodosLosProductos() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM producto ORDER BY id DESC";

        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearProducto(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener todos los productos: " + e.getMessage());
        }
        return lista;
    }

    /**
     * Obtiene SOLO los productos activos.
     * Este método es para el CATÁLOGO PÚBLICO del cliente.
     */
    public List<Producto> obtenerProductosActivos() {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM producto WHERE activo = 1 ORDER BY id DESC";

        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearProducto(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener productos activos: " + e.getMessage());
        }
        return lista;
    }

    /**
     * Obtiene los detalles de un producto específico por su ID.
     */
    public Producto obtenerDetalleProducto(int id) {
        String sql = "SELECT * FROM producto WHERE id = ?";
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapearProducto(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener detalle del producto: " + e.getMessage());
        }
        return null;
    }

    /**
     * CRUD: Crear un nuevo producto.
     */
    public boolean crearProducto(Producto p) {
        String sql = "INSERT INTO producto (categoria_id, nombre, productor, origen, variedad, formato_ml, precio, stock, imagen, activo) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, p.getCategoriaId());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getProductor());
            ps.setString(4, p.getOrigen());
            ps.setString(5, p.getVariedad());
            ps.setInt(6, p.getFormatoMl());
            ps.setDouble(7, p.getPrecio());
            ps.setInt(8, p.getStock());
            ps.setString(9, p.getImagen());
            ps.setBoolean(10, true); // Siempre activo al crear
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al crear producto: " + e.getMessage());
            return false;
        }
    }

    /**
     * CRUD: Actualizar un producto existente.
     */
    public boolean actualizarProducto(Producto p) {
        String sql = "UPDATE producto SET categoria_id=?, nombre=?, productor=?, origen=?, variedad=?, formato_ml=?, precio=?, stock=?, imagen=? WHERE id=?";
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, p.getCategoriaId());
            ps.setString(2, p.getNombre());
            ps.setString(3, p.getProductor());
            ps.setString(4, p.getOrigen());
            ps.setString(5, p.getVariedad());
            ps.setInt(6, p.getFormatoMl());
            ps.setDouble(7, p.getPrecio());
            ps.setInt(8, p.getStock());
            ps.setString(9, p.getImagen());
            ps.setInt(10, p.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar producto: " + e.getMessage());
            return false;
        }
    }

    /**
     * CRUD: BAJA LÓGICA exigida por la rúbrica.
     * En lugar de hacer un DELETE que rompería el historial de compras pasadas, 
     * actualizamos la bandera 'activo' a false.
     */
    public boolean darDeBajaLogica(int id) {
        String sql = "UPDATE producto SET activo = 0 WHERE id = ?";
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
             
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al aplicar baja lógica: " + e.getMessage());
            return false;
        }
    }

    // Método auxiliar privado para evitar código duplicado al leer ResultSets
    private Producto mapearProducto(ResultSet rs) throws SQLException {
        Producto p = new Producto();
        p.setId(rs.getInt("id"));
        p.setCategoriaId(rs.getInt("categoria_id"));
        p.setNombre(rs.getString("nombre"));
        p.setProductor(rs.getString("productor"));
        p.setOrigen(rs.getString("origen"));
        p.setVariedad(rs.getString("variedad"));
        p.setFormatoMl(rs.getInt("formato_ml"));
        p.setPrecio(rs.getDouble("precio"));
        p.setStock(rs.getInt("stock"));
        p.setImagen(rs.getString("imagen"));
        p.setActivo(rs.getBoolean("activo"));
        return p;
    }
}