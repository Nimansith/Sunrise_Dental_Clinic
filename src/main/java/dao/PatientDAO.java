package dao;

import models.Patient;
import utils.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PatientDAO {

    public List<Patient> getAllPatients() {
        List<Patient> patientList = new ArrayList<>();
        String query = "SELECT * FROM patients";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                patientList.add(extractPatientFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return patientList;
    }

    public Patient getPatientById(int id) {
        String query = "SELECT * FROM patients WHERE patient_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return extractPatientFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addPatient(Patient patient) {
        String query = "INSERT INTO patients (patient_name, email, contact_number, gender, address) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, patient.getPatientName());
            pstmt.setString(2, patient.getEmail());
            pstmt.setString(3, patient.getContactNumber());
            pstmt.setString(4, patient.getGender());
            pstmt.setString(5, patient.getAddress());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePatient(Patient patient) {
        String query = "UPDATE patients SET patient_name = ?, email = ?, contact_number = ?, gender = ?, address = ? WHERE patient_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setString(1, patient.getPatientName());
            pstmt.setString(2, patient.getEmail());
            pstmt.setString(3, patient.getContactNumber());
            pstmt.setString(4, patient.getGender());
            pstmt.setString(5, patient.getAddress());
            pstmt.setInt(6, patient.getPatientId());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deletePatient(int id) {
        String query = "DELETE FROM patients WHERE patient_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, id);

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Patient extractPatientFromResultSet(ResultSet rs) throws SQLException {
        return new Patient(
            rs.getInt("patient_id"),
            rs.getString("patient_name"),
            rs.getString("email"),
            rs.getString("contact_number"),
            rs.getString("gender"),
            rs.getString("address"),
            rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toString() : null
        );
    }
}