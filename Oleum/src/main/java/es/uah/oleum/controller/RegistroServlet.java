package es.uah.oleum.controller;

import es.uah.oleum.model.Usuario;
import es.uah.oleum.service.UsuarioService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/registro"})
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/registro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        Usuario u = new Usuario();
        u.setNombre(request.getParameter("nombre"));
        u.setEmail(request.getParameter("email"));
        u.setHashPassword(request.getParameter("password")); // Llega en texto plano, el Service lo cifrará
        u.setDireccion(request.getParameter("direccion"));
        u.setRol("CLIENTE"); 
        
        UsuarioService service = new UsuarioService();
        if (service.registrarNuevoUsuario(u)) {
            // Alta válida -> redirección a login
            response.sendRedirect(request.getContextPath() + "/login?registro=exito");
        } else {
            request.setAttribute("errorRegistro", "El correo electrónico ya está en uso.");
            request.getRequestDispatcher("/WEB-INF/views/registro.jsp").forward(request, response);
        }
    }
}