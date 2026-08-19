package dao;

import models.Bill;
import utils.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    // 1. Bill එකක් Database එකට එකතු කිරීම (Create)
    public boolean addBill(Bill bill) {
        String sql = "INSERT INTO bills (appointment_id, consultation_fee, treatment_cost, total_amount, payment_status) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bill.getAppointmentId());
            ps.setDouble(2, bill.getConsultationFee());
            ps.setDouble(3, bill.getTreatmentCost());

            double total = bill.getTotalAmount() > 0 
                    ? bill.getTotalAmount() 
                    : (bill.getConsultationFee() + bill.getTreatmentCost());

            ps.setDouble(4, total);
            ps.setString(5, (bill.getPaymentStatus() != null && !bill.getPaymentStatus().isEmpty()) ? bill.getPaymentStatus() : "UNPAID");

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. සියලුම Bills සටහන් Patient Name සහ Treatment Name සමඟ ලබාගැනීම (Read All)
    public List<Bill> getAllBills() {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT b.bill_id, b.appointment_id, b.consultation_fee, b.treatment_cost, " +
                     "b.total_amount, b.bill_date, b.payment_status, a.patient_name, t.treatment_name AS treatment_type " +
                     "FROM bills b " +
                     "JOIN appointments a ON b.appointment_id = a.appointment_id " +
                     "LEFT JOIN treatments t ON a.treatment_id = t.treatment_id " +
                     "ORDER BY b.bill_id DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToBill(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Bill ID එක මගින් Specific Bill එකක් ලබා ගැනීම (Read Single)
    public Bill getBillById(int billId) {
        Bill bill = null;
        String sql = "SELECT b.bill_id, b.appointment_id, b.consultation_fee, b.treatment_cost, " +
                     "b.total_amount, b.bill_date, b.payment_status, a.patient_name, t.treatment_name AS treatment_type " +
                     "FROM bills b " +
                     "JOIN appointments a ON b.appointment_id = a.appointment_id " +
                     "LEFT JOIN treatments t ON a.treatment_id = t.treatment_id " +
                     "WHERE b.bill_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    bill = mapResultSetToBill(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bill;
    }

    // 4. Payment Status එක Update කිරීම (PAID / UNPAID)
    public boolean updatePaymentStatus(int billId, String status) {
        String sql = "UPDATE bills SET payment_status = ? WHERE bill_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, billId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5. Bill එකක් Delete කිරීම
    public boolean deleteBill(int billId) {
        String sql = "DELETE FROM bills WHERE bill_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper Method
    private Bill mapResultSetToBill(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(rs.getInt("bill_id"));
        bill.setAppointmentId(rs.getInt("appointment_id"));
        bill.setConsultationFee(rs.getDouble("consultation_fee"));
        bill.setTreatmentCost(rs.getDouble("treatment_cost"));
        bill.setTotalAmount(rs.getDouble("total_amount"));
        bill.setBillDate(rs.getTimestamp("bill_date"));
        bill.setPaymentStatus(rs.getString("payment_status"));
        bill.setPatientName(rs.getString("patient_name"));
        bill.setTreatmentType(rs.getString("treatment_type"));
        return bill;
    }
}