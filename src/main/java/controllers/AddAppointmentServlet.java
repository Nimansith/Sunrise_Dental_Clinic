package controllers;

import dao.AppointmentDAO;
import models.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Timestamp;

@WebServlet("/AddAppointmentServlet")
public class AddAppointmentServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        try {
            // Patient details parsing
            String patientIdStr = request.getParameter("patientId");
            Integer patientId = (patientIdStr != null && !patientIdStr.trim().isEmpty()) ? Integer.parseInt(patientIdStr.trim()) : null;

            String patientName = request.getParameter("patientName");
            String address = request.getParameter("address");
            String contactNumber = request.getParameter("contactNumber");

            // Dentist details parsing
            String dentistIdStr = request.getParameter("dentistId");
            int dentistId = (dentistIdStr != null && !dentistIdStr.trim().isEmpty()) ? Integer.parseInt(dentistIdStr.trim()) : 0;
            String dentistName = request.getParameter("dentistName"); // Dentist Name ලබා ගැනීම

            // Treatment Foreign Keys validation
            String treatmentIdStr = request.getParameter("treatmentId");
            int treatmentId = (treatmentIdStr != null && !treatmentIdStr.trim().isEmpty()) ? Integer.parseInt(treatmentIdStr.trim()) : 0;

            String dateTimeStr = request.getParameter("appointmentDateTime");

            // Basic Input Checking
            if (dentistId <= 0 || treatmentId <= 0 || dateTimeStr == null || dateTimeStr.trim().isEmpty()) {
                response.sendRedirect("Staff_Dashboard.html?status=error");
                return;
            }

            String status = request.getParameter("status");
            if (status == null || status.trim().isEmpty()) {
                status = "PENDING";
            }

            // Convert HTML5 datetime-local string to Timestamp
            String formattedDate = dateTimeStr.replace("T", " ");
            if (formattedDate.length() == 16) {
                formattedDate += ":00";
            }
            Timestamp appointmentDateTime = Timestamp.valueOf(formattedDate);

            // Updated constructor call with dentistName
            Appointment appt = new Appointment(patientId, patientName, address, contactNumber, dentistId, dentistName, treatmentId, appointmentDateTime, status);
            boolean success = appointmentDAO.addAppointment(appt);

            if (success) {
                response.sendRedirect("Staff_Dashboard.html?status=success");
            } else {
                response.sendRedirect("Staff_Dashboard.html?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Staff_Dashboard.html?status=error");
        }
    }
}