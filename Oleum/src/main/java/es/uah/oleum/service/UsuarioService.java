package es.uah.oleum.service;

import es.uah.oleum.dao.UsuarioDAO;
import es.uah.oleum.model.Usuario;
import org.mindrot.jbcrypt.BCrypt;

public class UsuarioService {
    
    private UsuarioDAO usuarioDAO;

    public UsuarioService() {
        this.usuarioDAO = new UsuarioDAO();
    }

    public boolean registrarNuevoUsuario(Usuario u) {
        // Regla: Evitar correos duplicados
        if (usuarioDAO.buscarPorEmail(u.getEmail()) != null) {
            return false; 
        }
        
        // HASH ADAPTATIVO CON SAL: Ciframos la contraseña antes de guardarla[cite: 20, 21]
        String hash = BCrypt.hashpw(u.getHashPassword(), BCrypt.gensalt(12));
        u.setHashPassword(hash);
        
        return usuarioDAO.registrar(u);
    }

    public Usuario autenticarUsuario(String email, String passwordPlano) {
        Usuario u = usuarioDAO.buscarPorEmail(email);
        
        // Si el usuario existe, verificamos la contraseña plana contra el hash almacenado
        if (u != null && BCrypt.checkpw(passwordPlano, u.getHashPassword())) {
            return u;
        }
        return null; // Credenciales incorrectas o usuario no encontrado
    }
}