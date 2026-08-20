package controllers;

import dao.StaffDAO;
import models.Staff;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/StaffServlet")
public class StaffServlet extends HttpServlet {

    private final StaffDAO staffDAO = new StaffDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            deleteStaff(request, response);
        } else {
            response.sendRedirect("Staff_Dashboard.html?status=error");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if (action == null || action.trim().isEmpty()) {
            response.sendRedirect("Staff_Dashboard.html?status=error");
            return;
        }

        switch (action.toLowerCase().trim()) {
            case "register":
            case "add":
                registerStaff(request, response);
                break;
            case "update":
                updateStaff(request, response);
                break;
            case "delete":
                deleteStaff(request, response);
                break;
            default:
                response.sendRedirect("Staff_Dashboard.html?status=error");
                break;
        }
    }

    // 1. Register Staff
    private void registerStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String staffName = request.getParameter("staffName");
            String role = request.getParameter("role");
            String contactNumber = request.getParameter("contactNumber");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (staffName != null && !staffName.trim().isEmpty() && 
                username != null && !username.trim().isEmpty() && 
                password != null && !password.trim().isEmpty()) {
                
                Staff staff = new Staff();
                staff.setStaffName(staffName.trim());
                staff.setRole(role != null ? role.trim() : "RECEPTIONIST");
                staff.setContactNumber(contactNumber != null ? contactNumber.trim() : "");
                staff.setEmail(email != null ? email.trim() : "");
                staff.setUsername(username.trim());
                staff.setPassword(password.trim());

                boolean success = staffDAO.registerStaff(staff);

                if (success) {
                    response.sendRedirect("Staff_Dashboard.html?status=staff_added");
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

    // 2. Update Staff (Fixed Validation & Safe Data Handling)
    private void updateStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String staffIdStr = request.getParameter("staffId");
            String staffName = request.getParameter("staffName");
            String role = request.getParameter("role");
            String contactNumber = request.getParameter("contactNumber");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (staffIdStr != null && !staffIdStr.trim().isEmpty()) {
                int staffId = Integer.parseInt(staffIdStr.trim());

                Staff staff = new Staff();
                staff.setStaffId(staffId);
                staff.setStaffName(staffName != null ? staffName.trim() : "");
                staff.setRole(role != null ? role.trim() : "RECEPTIONIST");
                staff.setContactNumber(contactNumber != null ? contactNumber.trim() : "");
                staff.setEmail(email != null ? email.trim() : "");
                staff.setUsername(username != null ? username.trim() : "");
                staff.setPassword(password != null ? password.trim() : "");

                boolean success = staffDAO.updateStaff(staff);

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

    // 3. Delete Staff
    private void deleteStaff(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            String staffIdStr = request.getParameter("staffId");

            if (staffIdStr != null && !staffIdStr.trim().isEmpty()) {
                int staffId = Integer.parseInt(staffIdStr.trim());
                boolean success = staffDAO.deleteStaff(staffId);

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