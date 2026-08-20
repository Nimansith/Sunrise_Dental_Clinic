package controllers;

import dao.PatientDAO;
import models.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/PatientServlet")
public class PatientServlet extends HttpServlet {

    private final PatientDAO patientDAO = new PatientDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            deletePatient(request, response);
        } else {
            response.sendRedirect("Staff_Dashboard.html?status=error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("Staff_Dashboard.html?status=error");
            return;
        }

        switch (action.toLowerCase()) {
            case "register":
                registerPatient(request, response);
                break;
            case "update":
                updatePatient(request, response);
                break;
            case "delete":
                deletePatient(request, response);
                break;
            default:
                response.sendRedirect("Staff_Dashboard.html?status=error");
                break;
        }
    }

    // 1. Register Patient
    private void registerPatient(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String patientName = request.getParameter("patientName");
            String email = request.getParameter("email");
            String contactNumber = request.getParameter("contactNumber");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");

            if (patientName != null && !patientName.trim().isEmpty() && 
                contactNumber != null && !contactNumber.trim().isEmpty()) {
                
                Patient patient = new Patient(patientName.trim(), email != null ? email.trim() : "", 
                                              contactNumber.trim(), gender, address);
                boolean success = patientDAO.addPatient(patient);

                if (success) {
                    response.sendRedirect("Staff_Dashboard.html?status=patient_added");
                } else {
                    response.sendRedirect("Staff_Dashboard.html?status=error");
                }
            } else {
                response.sendRedirect("Staff_Dashboard.html?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Staff_Dashboard.html?status=error");
        }
    }

    // 2. Update Patient
    private void updatePatient(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String patientIdStr = request.getParameter("patientId");
            String patientName = request.getParameter("patientName");
            String email = request.getParameter("email");
            String contactNumber = request.getParameter("contactNumber");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");

            if (patientIdStr != null && !patientIdStr.isEmpty()) {
                int patientId = Integer.parseInt(patientIdStr);
                Patient patient = new Patient(patientName, email, contactNumber, gender, address);
                patient.setPatientId(patientId);

                boolean success = patientDAO.updatePatient(patient);

                if (success) {
                    response.sendRedirect("Staff_Dashboard.html?status=updated");
                } else {
                    response.sendRedirect("Staff_Dashboard.html?status=error");
                }
            } else {
                response.sendRedirect("Staff_Dashboard.html?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Staff_Dashboard.html?status=error");
        }
    }

    // 3. Delete Patient
    private void deletePatient(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String patientIdStr = request.getParameter("patientId");

            if (patientIdStr != null && !patientIdStr.isEmpty()) {
                int patientId = Integer.parseInt(patientIdStr);
                boolean success = patientDAO.deletePatient(patientId);

                if (success) {
                    response.sendRedirect("Staff_Dashboard.html?status=deleted");
                } else {
                    response.sendRedirect("Staff_Dashboard.html?status=error");
                }
            } else {
                response.sendRedirect("Staff_Dashboard.html?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Staff_Dashboard.html?status=error");
        }
    }
}