/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controllers;

import DAO.DentistDAO;
import Models.Dentist;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/ManageDentistServlet")
public class ManageDentistServlet extends HttpServlet {

    private final DentistDAO dentistDAO = new DentistDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("dentistId"));
                String dentistName = request.getParameter("dentistName");
                String specialization = request.getParameter("specialization");
                String contactNumber = request.getParameter("contactNumber");
                String email = request.getParameter("email");
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                // Password එක වෙනස් කළේ නැත්නම් DB එකේ දැනට තියෙන Password එක ලබා ගැනීම
                if (password == null || password.trim().isEmpty()) {
                    Dentist existingDentist = dentistDAO.getDentistById(id);
                    if (existingDentist != null) {
                        password = existingDentist.getPassword();
                    }
                }

                Dentist dentist = new Dentist(id, username, password, dentistName, specialization, contactNumber, email);

                boolean success = dentistDAO.updateDentist(dentist);
                response.sendRedirect("receptionistDashboard.jsp?status=" + (success ? "updated" : "error"));

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("dentistId"));
                boolean success = dentistDAO.deleteDentist(id);
                response.sendRedirect("receptionistDashboard.jsp?status=" + (success ? "deleted" : "error"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("receptionistDashboard.jsp?status=error");
        }
    }
}
