package Controllers;

import DAO.AppointmentDAO;
import Models.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/ManageAppointmentServlet")
public class ManageAppointmentServlet extends HttpServlet {

    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("appointmentId"));
                String patientName = request.getParameter("patientName");
                String address = request.getParameter("address");
                String contactNumber = request.getParameter("contactNumber");
                
                // dentistId (int)
                String dentistIdStr = request.getParameter("dentistId");
                int dentistId = 0;
                if (dentistIdStr != null && !dentistIdStr.trim().isEmpty()) {
                    dentistId = Integer.parseInt(dentistIdStr);
                }

                // treatmentId (int)
                String treatmentIdStr = request.getParameter("treatmentId");
                int treatmentId = 0;
                if (treatmentIdStr != null && !treatmentIdStr.trim().isEmpty()) {
                    treatmentId = Integer.parseInt(treatmentIdStr);
                }

                // status
                String status = request.getParameter("status");
                if (status == null || status.trim().isEmpty()) {
                    status = "PENDING";
                }

                String dateTimeStr = request.getParameter("appointmentDateTime");

                Timestamp appointmentDateTime = null;
                if (dateTimeStr != null && !dateTimeStr.trim().isEmpty()) {
                    String formattedDate = dateTimeStr.replace("T", " ");
                    if (formattedDate.length() == 16) {
                        formattedDate += ":00";
                    }
                    appointmentDateTime = Timestamp.valueOf(formattedDate);
                }

                // Updated Constructor Call with appointmentId
                Appointment appt = new Appointment(id, patientName, address, contactNumber, dentistId, treatmentId, appointmentDateTime, status);

                boolean success = appointmentDAO.updateAppointment(appt);
                response.sendRedirect("receptionistDashboard.jsp?status=" + (success ? "updated" : "error"));

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("appointmentId"));
                boolean success = appointmentDAO.deleteAppointment(id);
                response.sendRedirect("receptionistDashboard.jsp?status=" + (success ? "deleted" : "error"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("receptionistDashboard.jsp?status=error");
        }
    }
}