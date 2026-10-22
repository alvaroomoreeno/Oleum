package es.uah.oleum.controller.filter;

import es.uah.oleum.model.Usuario;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// Intercepta TODAS las rutas que cuelguen de /admin/
@WebFilter(urlPatterns = {"/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuarioLogueado") : null;

        // Verifica que esté logueado y que su rol sea ADMIN
        if (usuario != null && "ADMIN".equals(usuario.getRol())) {
            chain.doFilter(request, response);
        } else {
            // Si es un cliente intentando entrar en /admin, da error de acceso no autorizado (HTTP 403)
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Acceso denegado. Se requieren permisos de administrador.");
        }
    }
}