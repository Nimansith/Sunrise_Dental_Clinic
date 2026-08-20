package controllers;

import dao.DentistDAO;
import models.Dentist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DentistServlet")
public class DentistServlet extends HttpServlet {

    private final DentistDAO dentistDAO = new DentistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            deleteDentist(request, response);
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
            case "add":
                registerDentist(request, response);
                break;
            case "update":
                updateDentist(request, response);
                break;
            case "delete":
                deleteDentist(request, response);
                break;
            default:
                response.sendRedirect("Staff_Dashboard.html?status=error");
                break;
        }
    }

    // 1. Register Dentist
    private void registerDentist(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String dentistName = request.getParameter("dentistName");
            String specialization = request.getParameter("specialization");
            String contactNumber = request.getParameter("contactNumber");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (dentistName != null && !dentistName.trim().isEmpty() && 
                username != null && !username.trim().isEmpty() && 
                password != null && !password.trim().isEmpty()) {
                
                Dentist dentist = new Dentist();
                dentist.setDentistName(dentistName.trim());
                dentist.setSpecialization(specialization != null ? specialization.trim() : "");
                dentist.setContactNumber(contactNumber != null ? contactNumber.trim() : "");
                dentist.setEmail(email != null ? email.trim() : "");
                dentist.setUsername(username.trim());
                dentist.setPassword(password.trim());

                boolean success = dentistDAO.addDentist(dentist);

                if (success) {
                    response.sendRedirect("Staff_Dashboard.html?status=doctor_added");
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

    // 2. Update Dentist
    private void updateDentist(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String dentistIdStr = request.getParameter("dentistId");
            String dentistName = request.getParameter("dentistName");
            String specialization = request.getParameter("specialization");
            String contactNumber = request.getParameter("contactNumber");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (dentistIdStr != null && !dentistIdStr.trim().isEmpty()) {
                int dentistId = Integer.parseInt(dentistIdStr.trim());

                Dentist dentist = new Dentist();
                dentist.setDentistId(dentistId);
                dentist.setDentistName(dentistName);
                dentist.setSpecialization(specialization);
                dentist.setContactNumber(contactNumber);
                dentist.setEmail(email);
                dentist.setUsername(username);
                dentist.setPassword(password);

                boolean success = dentistDAO.updateDentist(dentist);

                if (success) {
                    response.sendRedirect("Staff_Dashboard.html?status=doctor_updated");
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

    // 3. Delete Dentist
    private void deleteDentist(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String dentistIdStr = request.getParameter("dentistId");

            if (dentistIdStr != null && !dentistIdStr.trim().isEmpty()) {
                int dentistId = Integer.parseInt(dentistIdStr.trim());
                boolean success = dentistDAO.deleteDentist(dentistId);

                if (success) {
                    response.sendRedirect("Staff_Dashboard.html?status=doctor_deleted");
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