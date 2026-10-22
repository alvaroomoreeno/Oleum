package es.uah.oleum.service;

import es.uah.oleum.dao.ProductoDAO;
import es.uah.oleum.model.Producto;
import java.util.List;

public class ProductoService {

    private ProductoDAO productoDAO;

    public ProductoService() {
        this.productoDAO = new ProductoDAO();
    }

    /**
     * Retorna el catálogo público (solo productos activos y con stock, si se desea filtrar).
     */
    public List<Producto> obtenerCatalogoPublico() {
        return productoDAO.obtenerProductosActivos();
    }

    /**
     * Retorna el catálogo completo para el Panel de Administración.
     */
    public List<Producto> obtenerTodosLosProductos() {
        return productoDAO.obtenerTodosLosProductos();
    }

    /**
     * Devuelve la ficha completa de un producto.
     */
    public Producto obtenerDetalleProducto(int id) {
        return productoDAO.obtenerDetalleProducto(id);
    }

    /**
     * Procesa la creación o actualización de un producto.
     */
    public boolean guardarProducto(Producto p) {
        // Validaciones de negocio: precios negativos, nombres vacíos, etc.
        if (p.getPrecio() < 0 || p.getStock() < 0 || p.getNombre() == null || p.getNombre().isEmpty()) {
            return false;
        }

        // Si el producto no tiene ID, es una creación. Si lo tiene, es una actualización.
        if (p.getId() == 0) {
            return productoDAO.crearProducto(p);
        } else {
            return productoDAO.actualizarProducto(p);
        }
    }

    /**
     * Aplica la regla de negocio de Baja Lógica (inactiva el producto sin borrarlo).
     */
    public boolean darDeBajaProducto(int id) {
        if (id <= 0) {
            return false;
        }
        return productoDAO.darDeBajaLogica(id);
    }
}