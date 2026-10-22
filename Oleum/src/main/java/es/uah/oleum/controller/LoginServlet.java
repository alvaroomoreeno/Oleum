package es.uah.oleum.controller;

import es.uah.oleum.model.Usuario;
import es.uah.oleum.service.UsuarioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        UsuarioService service = new UsuarioService();
        Usuario usuario = service.autenticarUsuario(email, password);
        
        if (usuario != null) {
            // Se crea la sesión y se guarda el objeto del usuario completo
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogueado", usuario);
            
            // REDIRECCIÓN DINÁMICA: Evaluamos el rol del usuario para enviarlo a su área correspondiente
            if ("ADMIN".equals(usuario.getRol())) {
                response.sendRedirect(request.getContextPath() + "/admin/productos");
            } else {
                // Si es un cliente estándar, le redirigimos a su perfil personal en lugar del catálogo
                response.sendRedirect(request.getContextPath() + "/perfil");
            }
        } else {
            request.setAttribute("errorLogin", "Credenciales incorrectas.");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }
}