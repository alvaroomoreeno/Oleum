package es.uah.oleum.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    
    // Ruta de conexión indicando el puerto 3306 y la base de datos oleum_db
    private static final String URL = "jdbc:mysql://localhost:3306/oleum_db?useSSL=false&serverTimezone=UTC";
    private static final String USUARIO = "root";
    private static final String PASSWORD = "Admin11"; 

    /**
     * Establece y devuelve una conexión con la base de datos.
     */
    public static Connection obtenerConexion() throws SQLException {
        try {
            // Carga dinámica del driver JDBC de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Error crítico: Driver JDBC no encontrado en el proyecto.", e);
        }
        
        // Retorna la conexión física abierta
        return DriverManager.getConnection(URL, USUARIO, PASSWORD);
    }
}