package Controllers;

import DAO.DentistDAO;
import Models.Dentist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterDentistServlet")
public class RegisterDentistServlet extends HttpServlet {

    private DentistDAO dentistDAO = new DentistDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        try {
            // Form එකෙන් Input ලබාගැනීම
            String dentistName = request.getParameter("dentistName");
            String specialization = request.getParameter("specialization");
            String contactNumber = request.getParameter("contactNumber");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Null Safety Wrappers
            dentistName = (dentistName != null) ? dentistName.trim() : "";
            specialization = (specialization != null) ? specialization.trim() : "";
            contactNumber = (contactNumber != null) ? contactNumber.trim() : "";
            email = (email != null) ? email.trim() : "";
            username = (username != null) ? username.trim() : "";
            password = (password != null) ? password.trim() : "";

            // Validations - අත්‍යවශ්‍ය Inputs පරීක්ෂාව
            if (!dentistName.isEmpty() && !username.isEmpty() && !password.isEmpty()) {
                
                // Dentist Model එකේ Constructor එකට අනුව Parameters 6ම ලබා දීම:
                // Dentist(name, specialization, contactNumber, email, username, password)
                Dentist dentist = new Dentist(dentistName, specialization, contactNumber, email, username, password);

                // DentistDAO හි පවතින addDentist method එක භාවිතා කිරීම
                boolean success = dentistDAO.addDentist(dentist);

                if (success) {
                    response.sendRedirect("receptionistDashboard.jsp?status=doctor_added");
                } else {
                    response.sendRedirect("receptionistDashboard.jsp?status=doctor_add_failed");
                }
            } else {
                response.sendRedirect("receptionistDashboard.jsp?status=missing_fields");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("receptionistDashboard.jsp?status=error");
        }
    }
}