package dao;

import models.Dentist;
import utils.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DentistDAO {

    // 0. Dentist Authenticate කිරීම (Login සඳහා)
    public Dentist authenticateDentist(String username, String password) {
        Dentist dentist = null;
        String sql = "SELECT * FROM dentists WHERE username = ? AND password = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    dentist = mapResultSetToDentist(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dentist;
    }

    // 1. Dentist කෙනෙක් Database එකට ඇතුළත් කිරීම (Create)
    public boolean addDentist(Dentist dentist) {
        String sql = "INSERT INTO dentists (username, password, dentist_name, specialization, contact_number, email) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dentist.getUsername());
            ps.setString(2, dentist.getPassword());
            ps.setString(3, dentist.getDentistName());
            ps.setString(4, dentist.getSpecialization());
            ps.setString(5, dentist.getContactNumber());
            ps.setString(6, dentist.getEmail());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean registerDentist(Dentist dentist) {
        return addDentist(dentist);
    }

    // 2. සියලුම Dentists ලාගේ ලැයිස්තුව ලබා ගැනීම (Read All)
    public List<Dentist> getAllDentists() {
        List<Dentist> dentistList = new ArrayList<>();
        String sql = "SELECT * FROM dentists ORDER BY dentist_name ASC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                dentistList.add(mapResultSetToDentist(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dentistList;
    }

    // 3. ID එක මගින් එක් Dentist කෙනෙකුගේ තොරතුරු ලබා ගැනීම (Read One)
    public Dentist getDentistById(int dentistId) {
        Dentist dentist = null;
        String sql = "SELECT * FROM dentists WHERE dentist_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, dentistId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    dentist = mapResultSetToDentist(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dentist;
    }

    // 4. Dentist කෙනෙකුගේ තොරතුරු Update කිරීම (Update)
    public boolean updateDentist(Dentist dentist) {
        String sql = "UPDATE dentists SET username = ?, password = ?, dentist_name = ?, specialization = ?, contact_number = ?, email = ? WHERE dentist_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dentist.getUsername());
            ps.setString(2, dentist.getPassword());
            ps.setString(3, dentist.getDentistName());
            ps.setString(4, dentist.getSpecialization());
            ps.setString(5, dentist.getContactNumber());
            ps.setString(6, dentist.getEmail());
            ps.setInt(7, dentist.getDentistId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5. Dentist කෙනෙකුව Delete කිරීම (Delete)
    public boolean deleteDentist(int dentistId) {
        String sql = "DELETE FROM dentists WHERE dentist_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, dentistId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper Method - ResultSet එක Model එකට Map කිරීමට
    private Dentist mapResultSetToDentist(ResultSet rs) throws SQLException {
        Dentist dentist = new Dentist();
        dentist.setDentistId(rs.getInt("dentist_id"));
        dentist.setUsername(rs.getString("username"));
        dentist.setPassword(rs.getString("password"));
        dentist.setDentistName(rs.getString("dentist_name"));
        dentist.setSpecialization(rs.getString("specialization"));
        dentist.setContactNumber(rs.getString("contact_number"));
        dentist.setEmail(rs.getString("email"));
        return dentist;
    }
}