package controllers;

import dao.AppointmentDAO;
import models.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/ManageAppointmentServlet")
public class ManageAppointmentServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("updateStatus".equals(action)) {
                // Dentist status update (COMPLETED / CANCELLED)
                int id = Integer.parseInt(request.getParameter("appointmentId"));
                String status = request.getParameter("status");

                boolean success = appointmentDAO.updateAppointmentStatus(id, status);
                response.sendRedirect("Dentist_Dashboard.html?status=" + (success ? "success" : "error"));

            } else if ("update".equals(action)) {
                // Receptionist full appointment update
                int id = Integer.parseInt(request.getParameter("appointmentId"));
                String patientName = request.getParameter("patientName");
                String address = request.getParameter("address");
                String contactNumber = request.getParameter("contactNumber");
                
                String dentistIdStr = request.getParameter("dentistId");
                int dentistId = (dentistIdStr != null && !dentistIdStr.trim().isEmpty()) ? Integer.parseInt(dentistIdStr) : 0;

                String treatmentIdStr = request.getParameter("treatmentId");
                int treatmentId = (treatmentIdStr != null && !treatmentIdStr.trim().isEmpty()) ? Integer.parseInt(treatmentIdStr) : 0;

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

                Appointment appt = new Appointment(id, patientName, address, contactNumber, dentistId, treatmentId, appointmentDateTime, status);
                boolean success = appointmentDAO.updateAppointment(appt);
                response.sendRedirect("Staff_Dashboard.html?status=" + (success ? "updated" : "error"));

            } else if ("delete".equals(action)) {
                // Receptionist delete appointment
                int id = Integer.parseInt(request.getParameter("appointmentId"));
                boolean success = appointmentDAO.deleteAppointment(id);
                response.sendRedirect("Staff_Dashboard.html?status=" + (success ? "deleted" : "error"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            // User Role එක (action එක) අනුව අදාළ Dashboard එකට Redirect කිරීම
            if ("updateStatus".equals(action)) {
                response.sendRedirect("Dentist_Dashboard.html?status=error");
            } else {
                response.sendRedirect("Staff_Dashboard.html?status=error");
            }
        }
    }
}