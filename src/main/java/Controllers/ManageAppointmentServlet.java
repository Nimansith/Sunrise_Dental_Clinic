/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import dao.AppointmentDAO;
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
                String dentistName = request.getParameter("dentistName");
                String treatmentType = request.getParameter("treatmentType");
                String dateTimeStr = request.getParameter("appointmentDateTime");

                Timestamp appointmentDateTime = null;
                if (dateTimeStr != null && !dateTimeStr.trim().isEmpty()) {
                    String formattedDate = dateTimeStr.replace("T", " ");
                    if (formattedDate.length() == 16) {
                        formattedDate += ":00";
                    }
                    appointmentDateTime = Timestamp.valueOf(formattedDate);
                }

                Appointment appt = new Appointment(patientName, address, contactNumber, dentistName, treatmentType, appointmentDateTime);
                appt.setAppointmentId(id);

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
