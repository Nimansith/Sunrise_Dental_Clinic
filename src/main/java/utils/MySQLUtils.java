/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MySQLUtils {

    // Execute SELECT queries
    public static ResultSet executeQuery(String sql, Object... parameters)
            throws SQLException {

        Connection connection = DatabaseConnection.getConnection();

        PreparedStatement statement = connection.prepareStatement(sql);

        setParameters(statement, parameters);

        return statement.executeQuery();
    }

    // Execute INSERT, UPDATE and DELETE queries
    public static int executeUpdate(String sql, Object... parameters)
            throws SQLException {

        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            setParameters(statement, parameters);

            return statement.executeUpdate();
        }
    }

    // Set parameters to PreparedStatement
    private static void setParameters(PreparedStatement statement,
                                       Object... parameters)
            throws SQLException {

        if (parameters == null) {
            return;
        }

        for (int i = 0; i < parameters.length; i++) {
            statement.setObject(i + 1, parameters[i]);
        }
    }
}

