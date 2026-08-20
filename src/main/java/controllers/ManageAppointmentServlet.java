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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equalsIgnoreCase(action)) {
            deleteAppointment(request, response);
        } else {
            response.sendRedirect("Staff_Dashboard.html");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");

        if ("update".equalsIgnoreCase(action)) {
            updateAppointment(request, response);
        } else if ("updateStatus".equalsIgnoreCase(action)) {
            updateAppointmentStatus(request, response);
        } else if ("delete".equalsIgnoreCase(action)) {
            deleteAppointment(request, response);
        } else {
            response.sendRedirect("Staff_Dashboard.html?status=error");
        }
    }

    private void updateAppointment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String idStr = request.getParameter("appointmentId");
            if (idStr == null || idStr.trim().isEmpty()) {
                response.sendRedirect("Staff_Dashboard.html?status=error");
                return;
            }
            int id = Integer.parseInt(idStr.trim());

            String patientName = request.getParameter("patientName");
            String address = request.getParameter("address");
            String contactNumber = request.getParameter("contactNumber");

            String dentistIdStr = request.getParameter("dentistId");
            int dentistId = (dentistIdStr != null && !dentistIdStr.trim().isEmpty()) ? Integer.parseInt(dentistIdStr.trim()) : 0;
            String dentistName = request.getParameter("dentistName"); // Dentist Name එක Form එකෙන් ලබාගැනීම

            String treatmentIdStr = request.getParameter("treatmentId");
            int treatmentId = (treatmentIdStr != null && !treatmentIdStr.trim().isEmpty()) ? Integer.parseInt(treatmentIdStr.trim()) : 0;

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

            String patientIdStr = request.getParameter("patientId");
            Integer patientId = (patientIdStr != null && !patientIdStr.trim().isEmpty()) ? Integer.parseInt(patientIdStr.trim()) : null;

            // Updated Model Object (10 Arguments)
            Appointment appt = new Appointment(id, patientId, patientName, address, contactNumber, dentistId, dentistName, treatmentId, appointmentDateTime, status);
            boolean success = appointmentDAO.updateAppointment(appt);

            response.sendRedirect("Staff_Dashboard.html?status=" + (success ? "updated" : "error"));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Staff_Dashboard.html?status=error");
        }
    }

    private void updateAppointmentStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String idStr = request.getParameter("appointmentId");
            if (idStr == null || idStr.trim().isEmpty()) {
                response.sendRedirect("Dentist_Dashboard.html?status=error");
                return;
            }
            int id = Integer.parseInt(idStr.trim());
            String status = request.getParameter("status");

            boolean success = appointmentDAO.updateAppointmentStatus(id, status);
            response.sendRedirect("Dentist_Dashboard.html?status=" + (success ? "success" : "error"));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Dentist_Dashboard.html?status=error");
        }
    }

    private void deleteAppointment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String idStr = request.getParameter("appointmentId");
            if (idStr == null || idStr.trim().isEmpty()) {
                response.sendRedirect("Staff_Dashboard.html?status=error");
                return;
            }
            int id = Integer.parseInt(idStr.trim());
            boolean success = appointmentDAO.deleteAppointment(id);

            response.sendRedirect("Staff_Dashboard.html?status=" + (success ? "deleted" : "error"));

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Staff_Dashboard.html?status=error");
        }
    }
}