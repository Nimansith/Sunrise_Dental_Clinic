package Controllers;

import DAO.BillDAO;
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
        request.setCharacterEncoding("UTF-8");

        try {
            String apptIdStr = request.getParameter("appointmentId");
            String feeStr = request.getParameter("consultationFee");
            String costStr = request.getParameter("treatmentCost");
            String paymentStatus = request.getParameter("paymentStatus");

            // Input Validation Check
            if (apptIdStr != null && !apptIdStr.trim().isEmpty() &&
                feeStr != null && !feeStr.trim().isEmpty() &&
                costStr != null && !costStr.trim().isEmpty()) {

                int appointmentId = Integer.parseInt(apptIdStr.trim());
                double consultationFee = Double.parseDouble(feeStr.trim());
                double treatmentCost = Double.parseDouble(costStr.trim());

                // Total calculate කිරීම
                double totalAmount = consultationFee + treatmentCost;

                // Status එක ලබා දී නොමැති නම් Default ලෙස "UNPAID" හෝ "PAID" යොදයි
                if (paymentStatus == null || paymentStatus.trim().isEmpty()) {
                    paymentStatus = "UNPAID";
                }

                // Bill Model එකට අනුව Object එක සාදයි (Constructor එක Model එකට අනුව ගැලපේ)
                Bill bill = new Bill(appointmentId, consultationFee, treatmentCost, totalAmount, paymentStatus);
                
                boolean success = billDAO.addBill(bill);

                if (success) {
                    response.sendRedirect("receptionistDashboard.jsp?status=bill_created");
                } else {
                    response.sendRedirect("receptionistDashboard.jsp?status=bill_failed");
                }
            } else {
                response.sendRedirect("receptionistDashboard.jsp?status=invalid_input");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("receptionistDashboard.jsp?status=invalid_input");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("receptionistDashboard.jsp?status=error");
        }
    }
}