package dao;

import Models.Dentist;
import Utils.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DentistDAO {

    // 1. Dentist කෙනෙක් Database එකට ඇතුළත් කිරීම (Create)
    public boolean registerDentist(Dentist dentist) {
        String sql = "INSERT INTO dentists (dentist_name, specialization, contact_number, email) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dentist.getDentistName());
            ps.setString(2, dentist.getSpecialization());
            ps.setString(3, dentist.getContactNumber());
            ps.setString(4, dentist.getEmail());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. සියලුම Dentists ලාගේ ලැයිස්තුව ලබා ගැනීම (Read All)
    public List<Dentist> getAllDentists() {
        List<Dentist> dentistList = new ArrayList<>();
        String sql = "SELECT * FROM dentists ORDER BY dentist_name ASC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Dentist dentist = new Dentist();
                dentist.setDentistId(rs.getInt("dentist_id"));
                dentist.setDentistName(rs.getString("dentist_name"));
                dentist.setSpecialization(rs.getString("specialization"));
                dentist.setContactNumber(rs.getString("contact_number"));
                dentist.setEmail(rs.getString("email"));

                dentistList.add(dentist);
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
                    dentist = new Dentist();
                    dentist.setDentistId(rs.getInt("dentist_id"));
                    dentist.setDentistName(rs.getString("dentist_name"));
                    dentist.setSpecialization(rs.getString("specialization"));
                    dentist.setContactNumber(rs.getString("contact_number"));
                    dentist.setEmail(rs.getString("email"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dentist;
    }

    // 4. Dentist කෙනෙකුගේ තොරතුරු Update කිරීම (Update)
    public boolean updateDentist(Dentist dentist) {
        String sql = "UPDATE dentists SET dentist_name = ?, specialization = ?, contact_number = ?, email = ? WHERE dentist_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, dentist.getDentistName());
            ps.setString(2, dentist.getSpecialization());
            ps.setString(3, dentist.getContactNumber());
            ps.setString(4, dentist.getEmail());
            ps.setInt(5, dentist.getDentistId());

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
}