package dao;

import models.Staff;
import utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StaffDAO {

    public Staff authenticateStaff(String username, String password) {
        String query = "SELECT * FROM staff WHERE username = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, username);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractStaffFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Staff> getAllStaff() {
        List<Staff> staffList = new ArrayList<>();
        String query = "SELECT * FROM staff";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                staffList.add(extractStaffFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return staffList;
    }

    public Staff getStaffById(int id) {
        String query = "SELECT * FROM staff WHERE staff_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractStaffFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean registerStaff(Staff staff) {
        String query = "INSERT INTO staff (username, password, staff_name, role, email, contact_number) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, staff.getUsername());
            pstmt.setString(2, staff.getPassword());
            pstmt.setString(3, staff.getStaffName());
            pstmt.setString(4, staff.getRole());
            pstmt.setString(5, staff.getEmail());
            pstmt.setString(6, staff.getContactNumber());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStaff(Staff staff) {
        String query = "UPDATE staff SET username = ?, password = ?, staff_name = ?, role = ?, email = ?, contact_number = ? WHERE staff_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, staff.getUsername());
            pstmt.setString(2, staff.getPassword());
            pstmt.setString(3, staff.getStaffName());
            pstmt.setString(4, staff.getRole());
            pstmt.setString(5, staff.getEmail());
            pstmt.setString(6, staff.getContactNumber());
            pstmt.setInt(7, staff.getStaffId());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteStaff(int id) {
        String query = "DELETE FROM staff WHERE staff_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Staff extractStaffFromResultSet(ResultSet rs) throws SQLException {
        return new Staff(
            rs.getInt("staff_id"),
            rs.getString("username"),
            rs.getString("password"),
            rs.getString("staff_name"),
            rs.getString("role"),
            rs.getString("email"),
            rs.getString("contact_number")
        );
    }
}