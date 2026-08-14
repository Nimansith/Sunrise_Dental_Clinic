package com.mycompany.sunrise_dental_clinic;

import Libraries.AuthService;
import Libraries.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = authService.login(username, password);

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("role", user.getRole());

            switch (user.getRole().toUpperCase()) {

                case "ADMIN":
                    response.sendRedirect("adminDashboard.jsp");
                    break;

                case "RECEPTIONIST":
                    response.sendRedirect("receptionistDashboard.jsp");
                    break;

                case "DENTIST":
                    response.sendRedirect("dentistDashboard.jsp");
                    break;

                case "PATIENT":
                    response.sendRedirect("patientDashboard.jsp");
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