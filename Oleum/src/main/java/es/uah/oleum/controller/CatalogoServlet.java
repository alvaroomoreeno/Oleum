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

// Ruta exacta exigida por el contrato de acciones HTTP de la práctica[cite: 57]
@WebServlet("/productos")
public class CatalogoServlet extends HttpServlet {

    private ProductoService productoService;

    @Override
    public void init() throws ServletException {
        this.productoService = new ProductoService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Solicitamos al Modelo únicamente los productos activos para el público general
        List<Producto> catalogoActivo = productoService.obtenerCatalogoPublico();
        
        request.setAttribute("catalogo", catalogoActivo);
        
        // Ocultar las vistas JSP dentro de WEB-INF evita el acceso directo saltándose el controlador[cite: 57].
        request.getRequestDispatcher("/WEB-INF/views/catalogo.jsp").forward(request, response);
    }
}