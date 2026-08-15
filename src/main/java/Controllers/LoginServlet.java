package Controllers;

import Models.User;
import dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // UserResource වෙනුවට UserDAO භාවිතා කරයි
    private final UserDAO userDAO = new UserDAO();

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

        // UserDAO එකේ authenticateUser method එක කැඳවීම
        User user = userDAO.authenticateUser(username, password);

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("role", user.getRole());

            // User Role එක අනුව Dashboard එකට Redirect කිරීම
            switch (user.getRole().toUpperCase()) {

                case "RECEPTIONIST":
                    response.sendRedirect("receptionistDashboard.jsp"); 
                    break;

                case "DENTIST":
                    response.sendRedirect("dentistDashboard.jsp");
                    break;

                default:
                    response.sendRedirect("login.jsp?error=invalidrole");
                    break;
            }

        } else {
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}