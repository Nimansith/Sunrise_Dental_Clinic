package dao;

import Models.Bill;
import Utils.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    // 1. Bill එකක් Database එකට එකතු කිරීම
    public boolean addBill(Bill bill) {
        String sql = "INSERT INTO bills (appointment_id, consultation_fee, treatment_cost, total_amount) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bill.getAppointmentId());
            ps.setDouble(2, bill.getConsultationFee());
            ps.setDouble(3, bill.getTreatmentCost());
            
            // Total amount එක 0 ට වඩා වැඩි නම් ඒක ගනී, නැත්නම් fee දෙක එකතු කර ගණනය කරයි
            double total = bill.getTotalAmount() > 0 
                    ? bill.getTotalAmount() 
                    : (bill.getConsultationFee() + bill.getTreatmentCost());
            
            ps.setDouble(4, total);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. සියලුම Bills සටහන් Patient name සහ Treatment Type සමග ලබාගැනීම (JOIN Query)
    public List<Bill> getAllBills() {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT b.bill_id, b.appointment_id, b.consultation_fee, b.treatment_cost, " +
                     "b.total_amount, b.bill_date, a.patient_name, a.treatment_type " +
                     "FROM bills b " +
                     "JOIN appointments a ON b.appointment_id = a.appointment_id " +
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

    // 3. Bill ID එක මගින් Specific Bill එකක් JOIN විස්තර සමඟ ලබා ගැනීම
    public Bill getBillById(int billId) {
        Bill bill = null;
        String sql = "SELECT b.bill_id, b.appointment_id, b.consultation_fee, b.treatment_cost, " +
                     "b.total_amount, b.bill_date, a.patient_name, a.treatment_type " +
                     "FROM bills b " +
                     "JOIN appointments a ON b.appointment_id = a.appointment_id " +
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

    // 4. Bill එකක් Delete කිරීම
    public boolean deleteBill(int billId) {
        String sql = "DELETE FROM bills WHERE bill_id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, billId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper Method - Code Duplication අවම කිරීමට
    private Bill mapResultSetToBill(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(rs.getInt("bill_id"));
        bill.setAppointmentId(rs.getInt("appointment_id"));
        bill.setConsultationFee(rs.getDouble("consultation_fee"));
        bill.setTreatmentCost(rs.getDouble("treatment_cost"));
        bill.setTotalAmount(rs.getDouble("total_amount"));
        bill.setBillDate(rs.getTimestamp("bill_date"));
        bill.setPatientName(rs.getString("patient_name"));
        bill.setTreatmentType(rs.getString("treatment_type"));
        return bill;
    }
}