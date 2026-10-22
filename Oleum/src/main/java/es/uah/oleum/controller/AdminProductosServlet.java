package es.uah.oleum.controller;

import es.uah.oleum.service.ProductoService;
import es.uah.oleum.model.Producto;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// El asterisco permite capturar cualquier subruta de administración de productos
// (ej. /admin/productos, /admin/productos/nuevo, /admin/productos/editar)
@WebServlet("/admin/productos/*") 
public class AdminProductosServlet extends HttpServlet {

    private ProductoService productoService;

    @Override
    public void init() throws ServletException {
        // Instanciamos el servicio una sola vez al inicializar el Servlet
        this.productoService = new ProductoService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // La validación del rol "ADMIN" ya la realiza el AdminFilter. 
        // El controlador se centra exclusivamente en orquestar el Modelo y la Vista.
        List<Producto> todosLosProductos = productoService.obtenerTodosLosProductos();
        
        request.setAttribute("productos", todosLosProductos);
        request.getRequestDispatcher("/WEB-INF/views/admin-productos.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Estructura preparada para cumplir con el contrato HTTP de "Mantener producto"[cite: 57]
        // Aquí procesarás las altas, modificaciones y bajas lógicas.
        
        String pathInfo = request.getPathInfo();
        
        // Lógica de ruteo interno basada en la URL (ej. si termina en /guardar o /baja)
        // Tras procesar la escritura en base de datos mediante productoService, 
        // aplica el patrón Post/Redirect/Get para evitar reenvíos de formulario[cite: 57].
        
        response.sendRedirect(request.getContextPath() + "/admin/productos");
    }
}