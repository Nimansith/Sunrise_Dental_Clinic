package Controllers;

import Models.Staff;
import Models.Dentist;
import DAO.StaffDAO;
import DAO.DentistDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final StaffDAO staffDAO = new StaffDAO();
    private final DentistDAO dentistDAO = new DentistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 1. Staff Table එක හරහා Authenticate කිරීම (Receptionist / Admin)
        Staff staff = staffDAO.authenticateStaff(username, password);

        if (staff != null) {
            HttpSession session = request.getSession();

            session.setAttribute("loggedUser", staff);
            session.setAttribute("staffId", staff.getStaffId());
            session.setAttribute("username", staff.getUsername());
            session.setAttribute("fullName", staff.getFullName());
            session.setAttribute("role", "RECEPTIONIST");

            response.sendRedirect("receptionistDashboard.jsp");
            return;
        }

        // 2. Staff එකේ නැත්නම් Dentists Table එක හරහා Authenticate කිරීම
        Dentist dentist = dentistDAO.authenticateDentist(username, password);

        if (dentist != null) {
            HttpSession session = request.getSession();

            session.setAttribute("loggedUser", dentist);
            session.setAttribute("dentistId", dentist.getDentistId());
            session.setAttribute("username", dentist.getUsername());
            session.setAttribute("fullName", dentist.getDentistName());
            session.setAttribute("role", "DENTIST");

            response.sendRedirect("dentistDashboard.jsp");
            return;
        }

        // 3. Tables දෙකෙන්ම User නොලැබුණු විට Error එකක් සමඟ Redirect කිරීම
        response.sendRedirect("login.jsp?error=invalid");
    }
}