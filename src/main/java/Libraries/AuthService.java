package Libraries;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AuthService {

    public User login(String username, String password) {

        // 1. Validation Checks (Input හිස්දැයි පරීක්ෂා කිරීම)
        if (username == null || username.trim().isEmpty() || password == null || password.isEmpty()) {
            return null;
        }

        // 2. Database එකෙන් කෙළින්ම MySQLUtils හරහා User ව සෙවීම (DAO නැතුව)
        String sql = "SELECT user_id, username, password, full_name, "
                   + "email, role, is_active, created_at "
                   + "FROM users WHERE username = ?";

        try {
            ResultSet resultSet = MySQLUtils.executeQuery(sql, username.trim());

            if (resultSet != null && resultSet.next()) {

                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setUsername(resultSet.getString("username"));
                user.setPassword(resultSet.getString("password"));
                user.setFullName(resultSet.getString("full_name"));
                user.setEmail(resultSet.getString("email"));
                user.setRole(resultSet.getString("role"));
                user.setActive(resultSet.getBoolean("is_active"));
                user.setCreatedAt(resultSet.getTimestamp("created_at"));

                // Resources Close කිරීම
                Statement stmt = resultSet.getStatement();
                if (stmt != null) {
                    if (stmt.getConnection() != null) {
                        stmt.getConnection().close();
                    }
                    stmt.close();
                }
                resultSet.close();

                // Account එක Active නැත්නම් Login වෙන්න දෙන්න එපා
                if (!user.isActive()) {
                    return null;
                }

                // Password එක සමාන නම් User ව Return කරන්න
                if (user.getPassword().equals(password)) {
                    return user;
                }
            }

            // User හමු නොවුණොත් Resources Close කිරීම
            if (resultSet != null) {
                Statement stmt = resultSet.getStatement();
                if (stmt != null) {
                    if (stmt.getConnection() != null) {
                        stmt.getConnection().close();
                    }
                    stmt.close();
                }
                resultSet.close();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null; // Login අසාර්ථකයි නම් null Return වේ
    }
}