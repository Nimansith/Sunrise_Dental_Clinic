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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("Staff_Dashboard.html");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        try {
            String patientName = request.getParameter("patientName");
            String address = request.getParameter("address");
            String contactNumber = request.getParameter("contactNumber");

            String dentistIdStr = request.getParameter("dentistId");
            int dentistId = 0;
            if (dentistIdStr != null && !dentistIdStr.trim().isEmpty()) {
                dentistId = Integer.parseInt(dentistIdStr.trim());
            }

            String treatmentIdStr = request.getParameter("treatmentId");
            int treatmentId = 0;
            if (treatmentIdStr != null && !treatmentIdStr.trim().isEmpty()) {
                treatmentId = Integer.parseInt(treatmentIdStr.trim());
            }

            String dateTimeStr = request.getParameter("appointmentDateTime");

            if (dentistId <= 0 || treatmentId <= 0 || dateTimeStr == null || dateTimeStr.trim().isEmpty()) {
                response.sendRedirect("Staff_Dashboard.html?status=error");
                return;
            }

            String status = request.getParameter("status");
            if (status == null || status.trim().isEmpty()) {
                status = "PENDING";
            }

            String formattedDate = dateTimeStr.replace("T", " ");
            if (formattedDate.length() == 16) {
                formattedDate += ":00";
            }
            Timestamp appointmentDateTime = Timestamp.valueOf(formattedDate);

            Appointment appt = new Appointment(patientName, address, contactNumber, dentistId, treatmentId, appointmentDateTime, status);
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
