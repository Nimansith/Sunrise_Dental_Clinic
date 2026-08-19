/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Treatment;
import utils.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TreatmentDAO {

    // 1. නව Treatment එකක් එකතු කිරීම (Create)
    public boolean addTreatment(Treatment treatment) {
        String sql = "INSERT INTO treatments (treatment_name, description, cost) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, treatment.getTreatmentName());
            ps.setString(2, treatment.getDescription());
            ps.setDouble(3, treatment.getCost());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. සියලුම Treatments ලබා ගැනීම (Read All)
    public List<Treatment> getAllTreatments() {
        List<Treatment> list = new ArrayList<>();
        String sql = "SELECT * FROM treatments ORDER BY treatment_id DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapResultSetToTreatment(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. ID එක මගින් Specific Treatment එකක් සෙවීම (Read Single)
    public Treatment getTreatmentById(int treatmentId) {
        Treatment treatment = null;
        String sql = "SELECT * FROM treatments WHERE treatment_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, treatmentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    treatment = mapResultSetToTreatment(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return treatment;
    }

    // 4. Treatment එකක තොරතුරු Update කිරීම (Update)
    public boolean updateTreatment(Treatment treatment) {
        String sql = "UPDATE treatments SET treatment_name = ?, description = ?, cost = ? WHERE treatment_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, treatment.getTreatmentName());
            ps.setString(2, treatment.getDescription());
            ps.setDouble(3, treatment.getCost());
            ps.setInt(4, treatment.getTreatmentId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5. Treatment එකක් Delete කිරීම (Delete)
    public boolean deleteTreatment(int treatmentId) {
        String sql = "DELETE FROM treatments WHERE treatment_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, treatmentId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper Method
    private Treatment mapResultSetToTreatment(ResultSet rs) throws SQLException {
        Treatment t = new Treatment();
        t.setTreatmentId(rs.getInt("treatment_id"));
        t.setTreatmentName(rs.getString("treatment_name"));
        t.setDescription(rs.getString("description"));
        t.setCost(rs.getDouble("cost"));
        return t;
    }
}
