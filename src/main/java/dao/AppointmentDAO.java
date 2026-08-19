package dao;

import models.Appointment;
import utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    // 1. Insert New Appointment (Create)
    public boolean addAppointment(Appointment appt) {
        String sql = "INSERT INTO appointments (patient_name, address, contact_number, dentist_id, treatment_id, appointment_date_time, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, appt.getPatientName());
            stmt.setString(2, appt.getAddress());
            stmt.setString(3, appt.getContactNumber());
            stmt.setInt(4, appt.getDentistId());
            stmt.setInt(5, appt.getTreatmentId());
            stmt.setTimestamp(6, appt.getAppointmentDateTime());
            stmt.setString(7, (appt.getStatus() != null && !appt.getStatus().isEmpty()) ? appt.getStatus() : "PENDING");

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. Fetch All Appointments (Read - All)
    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments ORDER BY appointment_date_time DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToAppointment(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Fetch Single Appointment by ID (Read - Single)
    public Appointment getAppointmentById(int id) {
        Appointment appt = null;
        String sql = "SELECT * FROM appointments WHERE appointment_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    appt = mapResultSetToAppointment(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return appt;
    }

    // 4. Update Full Appointment Details (Update)
    public boolean updateAppointment(Appointment appt) {
        String sql = "UPDATE appointments SET patient_name=?, address=?, contact_number=?, dentist_id=?, treatment_id=?, appointment_date_time=?, status=? WHERE appointment_id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, appt.getPatientName());
            ps.setString(2, appt.getAddress());
            ps.setString(3, appt.getContactNumber());
            ps.setInt(4, appt.getDentistId());
            ps.setInt(5, appt.getTreatmentId());
            ps.setTimestamp(6, appt.getAppointmentDateTime());
            ps.setString(7, appt.getStatus());
            ps.setInt(8, appt.getAppointmentId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5. Update ONLY Appointment Status (New Method for Dentist Action)
    public boolean updateAppointmentStatus(int appointmentId, String status) {
        String sql = "UPDATE appointments SET status = ? WHERE appointment_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, appointmentId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 6. Delete Appointment (Delete)
    public boolean deleteAppointment(int appointmentId) {
        String sql = "DELETE FROM appointments WHERE appointment_id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, appointmentId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 7. Dentist කෙනෙකුගේ සියලුම Appointments ලබා ගැනීම
    public List<Appointment> getAppointmentsByDentistId(int dentistId) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE dentist_id = ? ORDER BY appointment_date_time DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, dentistId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToAppointment(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 8. Dentist කෙනෙකුගේ අද දිනට අදාළ Appointments ලබා ගැනීම
    public List<Appointment> getTodayAppointmentsByDentistId(int dentistId) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT * FROM appointments WHERE dentist_id = ? AND DATE(appointment_date_time) = CURDATE() ORDER BY appointment_date_time ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, dentistId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToAppointment(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper Method for ResultSet Mapping
    private Appointment mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointment appt = new Appointment();
        appt.setAppointmentId(rs.getInt("appointment_id"));
        appt.setPatientName(rs.getString("patient_name"));
        appt.setAddress(rs.getString("address"));
        appt.setContactNumber(rs.getString("contact_number"));
        appt.setDentistId(rs.getInt("dentist_id"));
        appt.setTreatmentId(rs.getInt("treatment_id"));
        appt.setAppointmentDateTime(rs.getTimestamp("appointment_date_time"));
        appt.setStatus(rs.getString("status"));
        return appt;
    }
}