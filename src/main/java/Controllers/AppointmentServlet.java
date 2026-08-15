package Controllers;

import dao.AppointmentDAO;
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
            String dentistName = request.getParameter("dentistName");
            String treatmentType = request.getParameter("treatmentType");
            String dateTimeStr = request.getParameter("appointmentDateTime"); // HTML input: datetime-local

            // Input Validation & Timestamp Conversion
            Timestamp appointmentDateTime = null;
            if (dateTimeStr != null && !dateTimeStr.trim().isEmpty()) {
                // HTML datetime-local format ("YYYY-MM-DDTHH:mm") -> MySQL Timestamp format ("YYYY-MM-DD HH:mm:00")
                String formattedDate = dateTimeStr.replace("T", " ") + ":00";
                appointmentDateTime = Timestamp.valueOf(formattedDate);
            }

            // Create Appointment Object
            Appointment appt = new Appointment(patientName, address, contactNumber, dentistName, treatmentType, appointmentDateTime);

            // Save to DB
            boolean success = appointmentDAO.addAppointment(appt);

            if (success) {
                // JSP එක බලන status=success එකට Redirect කිරීම
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