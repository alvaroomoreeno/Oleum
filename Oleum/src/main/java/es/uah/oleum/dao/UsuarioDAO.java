package es.uah.oleum.dao;

import es.uah.oleum.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    public boolean registrar(Usuario u) {
        String sql = "INSERT INTO usuario (nombre, email, hash_password, direccion, rol, activo) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getHashPassword()); // Ya llegará cifrada desde el Servicio
            ps.setString(4, u.getDireccion());
            ps.setString(5, u.getRol() != null ? u.getRol() : "CLIENTE"); // Por defecto es cliente
            ps.setBoolean(6, true); // Activo por defecto
            
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al registrar usuario: " + e.getMessage());
            return false;
        }
    }

    public Usuario buscarPorEmail(String email) {
        String sql = "SELECT * FROM usuario WHERE email = ? AND activo = 1";
        
        try (Connection conn = ConexionBD.obtenerConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setId(rs.getInt("id"));
                    u.setNombre(rs.getString("nombre"));
                    u.setEmail(rs.getString("email"));
                    u.setHashPassword(rs.getString("hash_password"));
                    u.setDireccion(rs.getString("direccion"));
                    u.setRol(rs.getString("rol"));
                    u.setActivo(rs.getBoolean("activo"));
                    return u;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al buscar usuario: " + e.getMessage());
        }
        return null;
    }
}