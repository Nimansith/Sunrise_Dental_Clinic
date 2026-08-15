/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL = 
            "jdbc:mysql://localhost:3306/sunrise_dental?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

    private static final String USERNAME = "root";
    private static final String PASSWORD = "Sipsara123@#";

    public static Connection getConnection() throws SQLException {
        try {
            // MySQL Driver එක මෙතැනදීම handle කර ගන්නවා
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("MySQL Driver not found: " + e.getMessage());
        }

        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}


