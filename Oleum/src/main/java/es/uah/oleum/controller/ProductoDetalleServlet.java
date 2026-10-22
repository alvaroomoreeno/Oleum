package es.uah.oleum.controller;

import es.uah.oleum.model.Producto;
import es.uah.oleum.service.ProductoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "ProductoDetalleServlet", urlPatterns = {"/productos/detalle"})
public class ProductoDetalleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.isEmpty()) {
            ProductoService service = new ProductoService();
            Producto p = service.obtenerDetalleProducto(Integer.parseInt(idParam));
            request.setAttribute("producto", p);
            
            // Redirige al JSP específico según el ID (1: Picual, 2: Arbequina, 3: Hojiblanca)
            if ("1".equals(idParam)) {
                request.getRequestDispatcher("/WEB-INF/views/detalle-picual.jsp").forward(request, response);
            } else if ("2".equals(idParam)) {
                request.getRequestDispatcher("/WEB-INF/views/detalle-arbequina.jsp").forward(request, response);
            } else if ("3".equals(idParam)) {
                request.getRequestDispatcher("/WEB-INF/views/detalle-hojiblanca.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/productos");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/productos");
        }
    }
}