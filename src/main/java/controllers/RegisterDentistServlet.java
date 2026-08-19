package controllers;

import dao.DentistDAO;
import models.Dentist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterDentistServlet")
public class RegisterDentistServlet extends HttpServlet {

    private final DentistDAO dentistDAO = new DentistDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        try {
            String dentistName = request.getParameter("dentistName");
            String specialization = request.getParameter("specialization");
            String contactNumber = request.getParameter("contactNumber");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            dentistName = (dentistName != null) ? dentistName.trim() : "";
            specialization = (specialization != null) ? specialization.trim() : "";
            contactNumber = (contactNumber != null) ? contactNumber.trim() : "";
            email = (email != null) ? email.trim() : "";
            username = (username != null) ? username.trim() : "";
            password = (password != null) ? password.trim() : "";

            if (!dentistName.isEmpty() && !username.isEmpty() && !password.isEmpty()) {
                Dentist dentist = new Dentist(dentistName, specialization, contactNumber, email, username, password);

                boolean success = dentistDAO.addDentist(dentist);

                if (success) {
                    response.sendRedirect("Staff_Dashboard.html?status=doctor_added");
                } else {
                    response.sendRedirect("Staff_Dashboard.html?status=doctor_add_failed");
                }
            } else {
                response.sendRedirect("Staff_Dashboard.html?status=missing_fields");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Staff_Dashboard.html?status=error");
        }
    }
}