package es.uah.oleum.controller.filter;

import es.uah.oleum.model.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// Intercepta las rutas exclusivas para clientes registrados
@WebFilter(urlPatterns = {"/mis-pedidos", "/pedidos", "/carrito/items/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("usuarioLogueado") != null);

        if (isLoggedIn) {
            chain.doFilter(request, response); // Permite el paso
        } else {
            res.sendRedirect(req.getContextPath() + "/login"); // Redirige si no está autenticado
        }
    }
}