package Controllers;

import DAO.AppointmentDAO;
import Models.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/AppointmentServlet")
public class AppointmentServlet extends HttpServlet {

    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
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
            
            // Validation: dentistId සහ treatmentId 0 ට වැඩි විය යුතුය
            if (dentistId <= 0 || treatmentId <= 0) {
                System.err.println("Invalid Dentist ID or Treatment ID provided.");
                response.sendRedirect("receptionistDashboard.jsp?status=error");
                return;
            }

            // status (Default to "PENDING" if not provided)
            String status = request.getParameter("status");
            if (status == null || status.trim().isEmpty()) {
                status = "PENDING";
            }

            String dateTimeStr = request.getParameter("appointmentDateTime"); // HTML input: datetime-local

            // Input Validation & Timestamp Conversion
            Timestamp appointmentDateTime = null;
            if (dateTimeStr != null && !dateTimeStr.trim().isEmpty()) {
                String formattedDate = dateTimeStr.replace("T", " ");
                if (formattedDate.length() == 16) {
                    formattedDate += ":00";
                }
                appointmentDateTime = Timestamp.valueOf(formattedDate);
            }

            // Create Appointment Object with updated fields
            Appointment appt = new Appointment(patientName, address, contactNumber, dentistId, treatmentId, appointmentDateTime, status);

            // Save to DB
            boolean success = appointmentDAO.addAppointment(appt);

            if (success) {
                response.sendRedirect("receptionistDashboard.jsp?status=success");
            } else {
                response.sendRedirect("receptionistDashboard.jsp?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("receptionistDashboard.jsp?status=error");
        }
    }
}