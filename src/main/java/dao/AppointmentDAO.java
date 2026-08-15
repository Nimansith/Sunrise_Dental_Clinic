package dao;

import Models.Appointment;
import Utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

    // 1. Insert New Appointment (Create)
    public boolean addAppointment(Appointment appt) {
        String sql = "INSERT INTO appointments (patient_name, address, contact_number, dentist_name, treatment_type, appointment_date_time) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, appt.getPatientName());
            stmt.setString(2, appt.getAddress());
            stmt.setString(3, appt.getContactNumber());
            stmt.setString(4, appt.getDentistName());
            stmt.setString(5, appt.getTreatmentType());
            stmt.setTimestamp(6, appt.getAppointmentDateTime());

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

    // 4. Update Appointment (Update)
    public boolean updateAppointment(Appointment appt) {
        // column name එක appointment_date_time ලෙස නිවැරදි කර ඇත
        String sql = "UPDATE appointments SET patient_name=?, address=?, contact_number=?, dentist_name=?, treatment_type=?, appointment_date_time=? WHERE appointment_id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, appt.getPatientName());
            ps.setString(2, appt.getAddress());
            ps.setString(3, appt.getContactNumber());
            ps.setString(4, appt.getDentistName());
            ps.setString(5, appt.getTreatmentType());
            ps.setTimestamp(6, appt.getAppointmentDateTime());
            ps.setInt(7, appt.getAppointmentId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5. Delete Appointment (Delete)
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

    // Code duplication අවම කිරීම සඳහා සාදන ලද Helper Method එකක්
    private Appointment mapResultSetToAppointment(ResultSet rs) throws SQLException {
        Appointment appt = new Appointment();
        appt.setAppointmentId(rs.getInt("appointment_id"));
        appt.setPatientName(rs.getString("patient_name"));
        appt.setAddress(rs.getString("address"));
        appt.setContactNumber(rs.getString("contact_number"));
        appt.setDentistName(rs.getString("dentist_name"));
        appt.setTreatmentType(rs.getString("treatment_type"));
        appt.setAppointmentDateTime(rs.getTimestamp("appointment_date_time"));
        return appt;
    }
}