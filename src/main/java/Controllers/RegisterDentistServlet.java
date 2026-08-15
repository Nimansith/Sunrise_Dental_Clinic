package Controllers;

import dao.DentistDAO;
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
        
        // Form එකෙන් එන Request Character Encoding එක UTF-8 කිරීම
        request.setCharacterEncoding("UTF-8");

        try {
            // JSP Form එකෙන් එන Data ලබා ගැනීම
            String dentistName = request.getParameter("dentistName");
            String specialization = request.getParameter("specialization");
            String contactNumber = request.getParameter("contactNumber");
            String email = request.getParameter("email");

            // Simple Validation - Dentist Name එක හිස් නොවේ නම් පමණක් Insert කිරීම
            if (dentistName != null && !dentistName.trim().isEmpty()) {
                
                // Model එක සාදා ගැනීම
                Dentist dentist = new Dentist(dentistName, specialization, contactNumber, email);
                
                // DAO එක හරහා Database එකට Save කිරීම
                boolean success = dentistDAO.registerDentist(dentist);

                if (success) {
                    // සාර්ථක වූ විට Reception Dashboard එකට Redirect කිරීම
                    response.sendRedirect("receptionDashboard.jsp?doctorStatus=success");
                } else {
                    response.sendRedirect("receptionDashboard.jsp?doctorStatus=error");
                }
            } else {
                // Form Fields හිස්ව පැමිණි විට
                response.sendRedirect("receptionDashboard.jsp?doctorStatus=empty");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("receptionDashboard.jsp?doctorStatus=error");
        }
    }
}