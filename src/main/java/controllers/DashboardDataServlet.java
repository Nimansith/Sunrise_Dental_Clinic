package controllers;

import dao.AppointmentDAO;
import dao.BillDAO;
import dao.DentistDAO;
import dao.TreatmentDAO;
import models.Appointment;
import models.Bill;
import models.Dentist;
import models.Treatment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/dashboard-data")
public class DashboardDataServlet extends HttpServlet {

    private final DentistDAO dentistDAO = new DentistDAO();
    private final AppointmentDAO appointmentDAO = new AppointmentDAO();
    private final BillDAO billDAO = new BillDAO();
    private final TreatmentDAO treatmentDAO = new TreatmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            List<Dentist> dentists = dentistDAO.getAllDentists();
            List<Appointment> appointments = appointmentDAO.getAllAppointments();
            List<Bill> bills = billDAO.getAllBills();
            List<Treatment> treatments = treatmentDAO.getAllTreatments();

            StringBuilder json = new StringBuilder();
            json.append("{");

            // 1. Dentists JSON
            json.append("\"dentistList\":[");
            if (dentists != null) {
                for (int i = 0; i < dentists.size(); i++) {
                    Dentist d = dentists.get(i);
                    json.append(String.format(
                        "{\"dentistId\":%d, \"dentistName\":\"%s\", \"specialization\":\"%s\", \"contactNumber\":\"%s\", \"email\":\"%s\", \"username\":\"%s\"}",
                        d.getDentistId(), escapeJson(d.getDentistName()), escapeJson(d.getSpecialization()), 
                        escapeJson(d.getContactNumber()), escapeJson(d.getEmail()), escapeJson(d.getUsername())
                    ));
                    if (i < dentists.size() - 1) json.append(",");
                }
            }
            json.append("],");

            // 2. Appointments JSON
            json.append("\"appointmentList\":[");
            if (appointments != null) {
                for (int i = 0; i < appointments.size(); i++) {
                    Appointment a = appointments.get(i);
                    json.append(String.format(
                        "{\"appointmentId\":%d, \"patientName\":\"%s\", \"address\":\"%s\", \"contactNumber\":\"%s\", \"dentistId\":%d, \"treatmentId\":%d, \"appointmentDateTime\":\"%s\", \"status\":\"%s\"}",
                        a.getAppointmentId(), escapeJson(a.getPatientName()), escapeJson(a.getAddress()), 
                        escapeJson(a.getContactNumber()), a.getDentistId(), a.getTreatmentId(), 
                        a.getAppointmentDateTime() != null ? a.getAppointmentDateTime().toString() : "", escapeJson(a.getStatus())
                    ));
                    if (i < appointments.size() - 1) json.append(",");
                }
            }
            json.append("],");

            // 3. Bills JSON
            json.append("\"billList\":[");
            if (bills != null) {
                for (int i = 0; i < bills.size(); i++) {
                    Bill b = bills.get(i);
                    json.append(String.format(
                        "{\"billId\":%d, \"appointmentId\":%d, \"patientName\":\"%s\", \"treatmentName\":\"%s\", \"consultationFee\":%.2f, \"treatmentCost\":%.2f, \"totalAmount\":%.2f, \"billDate\":\"%s\"}",
                        b.getBillId(), b.getAppointmentId(), escapeJson(b.getPatientName()), 
                        escapeJson(b.getTreatmentName()), b.getConsultationFee(), b.getTreatmentCost(), 
                        b.getTotalAmount(), b.getBillDate() != null ? b.getBillDate().toString() : ""
                    ));
                    if (i < bills.size() - 1) json.append(",");
                }
            }
            json.append("],");

            // 4. Treatments JSON
            json.append("\"treatmentList\":[");
            if (treatments != null) {
                for (int i = 0; i < treatments.size(); i++) {
                    Treatment t = treatments.get(i);
                    json.append(String.format(
                        "{\"treatmentId\":%d, \"treatmentName\":\"%s\"}",
                        t.getTreatmentId(), escapeJson(t.getTreatmentName())
                    ));
                    if (i < treatments.size() - 1) json.append(",");
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