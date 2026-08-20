package controllers;

import dao.AppointmentDAO;
import models.Appointment;
import models.Dentist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/dentist-dashboard-data")
public class DentistDashboardDataServlet extends HttpServlet {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Dentist dentist = (session != null) ? (Dentist) session.getAttribute("loggedUser") : null;
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        Integer dentistIdObj = (session != null) ? (Integer) session.getAttribute("dentistId") : null;

        if (session == null || role == null || !"DENTIST".equalsIgnoreCase(role) || dentist == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().print("{\"error\":\"unauthorized\"}");
            return;
        }

        int dentistId = (dentistIdObj != null) ? dentistIdObj : dentist.getDentistId();

        try (PrintWriter out = response.getWriter()) {
            List<Appointment> todayAppointments = appointmentDAO.getTodayAppointmentsByDentistId(dentistId);
            List<Appointment> allAppointments = appointmentDAO.getAppointmentsByDentistId(dentistId);

            StringBuilder json = new StringBuilder();
            json.append("{");
            
            // Profile Modal එකට අවශ්‍ය Dentist Details එකතු කර ඇත
            json.append("\"dentistId\":").append(dentist.getDentistId()).append(",");
            json.append("\"dentistName\":\"").append(escapeJson(dentist.getDentistName())).append("\",");
            json.append("\"specialization\":\"").append(escapeJson(dentist.getSpecialization())).append("\",");
            json.append("\"contactNumber\":\"").append(escapeJson(dentist.getContactNumber())).append("\",");
            json.append("\"email\":\"").append(escapeJson(dentist.getEmail())).append("\",");
            json.append("\"role\":\"").append(escapeJson(role)).append("\",");

            // Today's Appointments
            json.append("\"todayAppointments\":[");
            if (todayAppointments != null) {
                for (int i = 0; i < todayAppointments.size(); i++) {
                    Appointment a = todayAppointments.get(i);
                    json.append(String.format(
                        "{\"appointmentId\":%d, \"patientName\":\"%s\", \"contactNumber\":\"%s\", \"appointmentDateTime\":\"%s\", \"status\":\"%s\"}",
                        a.getAppointmentId(), escapeJson(a.getPatientName()), escapeJson(a.getContactNumber()),
                        a.getAppointmentDateTime() != null ? a.getAppointmentDateTime().toString() : "", escapeJson(a.getStatus())
                    ));
                    if (i < todayAppointments.size() - 1) json.append(",");
                }
            }
            json.append("],");

            // All Appointments
            json.append("\"allAppointments\":[");
            if (allAppointments != null) {
                for (int i = 0; i < allAppointments.size(); i++) {
                    Appointment a = allAppointments.get(i);
                    json.append(String.format(
                        "{\"appointmentId\":%d, \"patientName\":\"%s\", \"contactNumber\":\"%s\", \"appointmentDateTime\":\"%s\", \"status\":\"%s\"}",
                        a.getAppointmentId(), escapeJson(a.getPatientName()), escapeJson(a.getContactNumber()),
                        a.getAppointmentDateTime() != null ? a.getAppointmentDateTime().toString() : "", escapeJson(a.getStatus())
                    ));
                    if (i < allAppointments.size() - 1) json.append(",");
                }
            }
            json.append("]");

            json.append("}");
            out.print(json.toString());
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }
}