package Controlador;

import java.sql.*;

public class Conexion {

    public static Connection getConexion() {
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://DESKTOP-04UAUJC\\MSSQLSERVER:1433;databaseName=BDTiendaMascotas;trustServerCertificate=true";
            String usr = "sa";
            String psw = "saVictor";
            con = DriverManager.getConnection(url, usr, psw);
            System.out.println("Conexion correcta");
        } catch (ClassNotFoundException ex) {
            System.out.println("No hay Driver!!");
        } catch (SQLException ex) {
            System.out.println("Error con la BD");
        }
        return con;
    }
    
    public static void main(String[] args) {
        Conexion.getConexion();
    }
}
