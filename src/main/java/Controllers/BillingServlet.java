/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import dao.BillDAO;
import Models.Bill;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/BillingServlet")
public class BillingServlet extends HttpServlet {

    private BillDAO billDAO = new BillDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
            double consultationFee = Double.parseDouble(request.getParameter("consultationFee"));
            double treatmentCost = Double.parseDouble(request.getParameter("treatmentCost"));

            // Total calculate කිරීම
            double totalAmount = consultationFee + treatmentCost;

            Bill bill = new Bill(appointmentId, consultationFee, treatmentCost, totalAmount);
            boolean success = billDAO.addBill(bill);

            if (success) {
                response.sendRedirect("receptionistDashboard.jsp?status=bill_created");
            } else {
                response.sendRedirect("receptionistDashboard.jsp?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("receptionistDashboard.jsp?status=error");
        }
    }
}