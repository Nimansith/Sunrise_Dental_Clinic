package controllers;

import dao.AppointmentDAO;
import dao.BillDAO;
import dao.DentistDAO;
import dao.PatientDAO;
import dao.StaffDAO;
import dao.TreatmentDAO;
import models.Appointment;
import models.Bill;
import models.Dentist;
import models.Patient;
import models.Staff;
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
    private final PatientDAO patientDAO = new PatientDAO();
    private final StaffDAO staffDAO = new StaffDAO();

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
            List<Patient> patients = patientDAO.getAllPatients();
            List<Staff> staffMembers = staffDAO.getAllStaff();

            StringBuilder json = new StringBuilder();
            json.append("{");

            // 1. Dentists JSON
            json.append("\"dentistList\":[");
            if (dentists != null) {
                for (int i = 0; i < dentists.size(); i++) {
                    Dentist d = dentists.get(i);
                    json.append("{")
                        .append("\"dentistId\":").append(d.getDentistId()).append(",")
                        .append("\"dentistName\":\"").append(escapeJson(d.getDentistName())).append("\",")
                        .append("\"specialization\":\"").append(escapeJson(d.getSpecialization())).append("\",")
                        .append("\"contactNumber\":\"").append(escapeJson(d.getContactNumber())).append("\",")
                        .append("\"email\":\"").append(escapeJson(d.getEmail())).append("\",")
                        .append("\"username\":\"").append(escapeJson(d.getUsername())).append("\"")
                        .append("}");
                    if (i < dentists.size() - 1) json.append(",");
                }
            }
            json.append("],");

            // 2. Appointments JSON (dentistName එකතු කර ඇත)
            json.append("\"appointmentList\":[");
            if (appointments != null) {
                for (int i = 0; i < appointments.size(); i++) {
                    Appointment a = appointments.get(i);
                    String apptDateTime = a.getAppointmentDateTime() != null ? a.getAppointmentDateTime().toString() : "";
                    json.append("{")
                        .append("\"appointmentId\":").append(a.getAppointmentId()).append(",")
                        .append("\"patientName\":\"").append(escapeJson(a.getPatientName())).append("\",")
                        .append("\"address\":\"").append(escapeJson(a.getAddress())).append("\",")
                        .append("\"contactNumber\":\"").append(escapeJson(a.getContactNumber())).append("\",")
                        .append("\"dentistId\":").append(a.getDentistId()).append(",")
                        .append("\"dentistName\":\"").append(escapeJson(a.getDentistName())).append("\",") // FIX: Dentist Name එකතු කළා
                        .append("\"treatmentId\":").append(a.getTreatmentId()).append(",")
                        .append("\"appointmentDateTime\":\"").append(escapeJson(apptDateTime)).append("\",")
                        .append("\"status\":\"").append(escapeJson(a.getStatus())).append("\"")
                        .append("}");
                    if (i < appointments.size() - 1) json.append(",");
                }
            }
            json.append("],");

            // 3. Bills JSON
            json.append("\"billList\":[");
            if (bills != null) {
                for (int i = 0; i < bills.size(); i++) {
                    Bill b = bills.get(i);
                    String billDate = b.getBillDate() != null ? b.getBillDate().toString() : "";
                    json.append("{")
                        .append("\"billId\":").append(b.getBillId()).append(",")
                        .append("\"appointmentId\":").append(b.getAppointmentId()).append(",")
                        .append("\"patientName\":\"").append(escapeJson(b.getPatientName())).append("\",")
                        .append("\"treatmentName\":\"").append(escapeJson(b.getTreatmentName())).append("\",")
                        .append("\"consultationFee\":").append(b.getConsultationFee()).append(",")
                        .append("\"treatmentCost\":").append(b.getTreatmentCost()).append(",")
                        .append("\"totalAmount\":").append(b.getTotalAmount()).append(",")
                        .append("\"billDate\":\"").append(escapeJson(billDate)).append("\"")
                        .append("}");
                    if (i < bills.size() - 1) json.append(",");
                }
            }
            json.append("],");

            // 4. Treatments JSON
            json.append("\"treatmentList\":[");
            if (treatments != null) {
                for (int i = 0; i < treatments.size(); i++) {
                    Treatment t = treatments.get(i);
                    json.append("{")
                        .append("\"treatmentId\":").append(t.getTreatmentId()).append(",")
                        .append("\"treatmentName\":\"").append(escapeJson(t.getTreatmentName())).append("\"")
                        .append("}");
                    if (i < treatments.size() - 1) json.append(",");
                }
            }
            json.append("],");

            // 5. Patients JSON
            json.append("\"patientList\":[");
            if (patients != null) {
                for (int i = 0; i < patients.size(); i++) {
                    Patient p = patients.get(i);
                    json.append("{")
                        .append("\"patientId\":").append(p.getPatientId()).append(",")
                        .append("\"patientName\":\"").append(escapeJson(p.getPatientName())).append("\",")
                        .append("\"contactNumber\":\"").append(escapeJson(p.getContactNumber())).append("\",")
                        .append("\"email\":\"").append(escapeJson(p.getEmail())).append("\",")
                        .append("\"gender\":\"").append(escapeJson(p.getGender())).append("\",")
                        .append("\"address\":\"").append(escapeJson(p.getAddress())).append("\"")
                        .append("}");
                    if (i < patients.size() - 1) json.append(",");
                }
            }
            json.append("],");

            // 6. Staff JSON
            json.append("\"staffList\":[");
            if (staffMembers != null) {
                for (int i = 0; i < staffMembers.size(); i++) {
                    Staff s = staffMembers.get(i);
                    json.append("{")
                        .append("\"staffId\":").append(s.getStaffId()).append(",")
                        .append("\"staffName\":\"").append(escapeJson(s.getStaffName())).append("\",")
                        .append("\"role\":\"").append(escapeJson(s.getRole())).append("\",")
                        .append("\"contactNumber\":\"").append(escapeJson(s.getContactNumber())).append("\",")
                        .append("\"email\":\"").append(escapeJson(s.getEmail())).append("\",")
                        .append("\"username\":\"").append(escapeJson(s.getUsername())).append("\"")
                        .append("}");
                    if (i < staffMembers.size() - 1) json.append(",");
                }
            }
            json.append("]");

            json.append("}");
            
            out.print(json.toString());
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }
}