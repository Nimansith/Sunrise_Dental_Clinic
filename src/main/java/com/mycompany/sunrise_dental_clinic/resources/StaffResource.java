package com.mycompany.sunrise_dental_clinic.resources;

import dao.StaffDAO;
import models.Staff;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/staff")
public class StaffResource {

    private StaffDAO staffDAO = new StaffDAO();

    // 1. GET: සියලුම Staff உறுப்பினයන්ගේ ලැයිස්තුව ලබා ගැනීම
    // Postman URL: GET http://localhost:8080/sunrise_dental_clinic/api/staff
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllStaff() {
        List<Staff> list = staffDAO.getAllStaff();
        return Response.ok(list).build();
    }

    // 2. GET: ID එක මගින් Staff සාමාජිකයෙකුගේ තොරතුරු ලබා ගැනීම
    // Postman URL: GET http://localhost:8080/sunrise_dental_clinic/api/staff/1
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getStaffById(@PathParam("id") int id) {
        Staff staff = staffDAO.getStaffById(id);
        if (staff != null) {
            return Response.ok(staff).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Staff member not found\"}").build();
        }
    }

    // 3. POST: නව Staff කෙනෙකු Register කිරීම
    // Postman URL: POST http://localhost:8080/sunrise_dental_clinic/api/staff
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response registerStaff(Staff staff) {
        if (staff == null || staff.getUsername() == null || staff.getPassword() == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Invalid Staff details. Username and Password are required.\"}").build();
        }

        boolean success = staffDAO.registerStaff(staff);
        if (success) {
            return Response.status(Response.Status.CREATED)
                           .entity("{\"message\": \"Staff registered successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to register staff\"}").build();
        }
    }

    // 4. PUT: Staff කෙනෙකුගේ තොරතුරු Update කිරීම
    // Postman URL: PUT http://localhost:8080/sunrise_dental_clinic/api/staff
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateStaff(Staff staff) {
        boolean success = staffDAO.updateStaff(staff);
        if (success) {
            return Response.ok("{\"message\": \"Staff updated successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to update staff\"}").build();
        }
    }

    // 5. DELETE: Staff කෙනෙකුව Delete කිරීම
    // Postman URL: DELETE http://localhost:8080/sunrise_dental_clinic/api/staff/1
    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteStaff(@PathParam("id") int id) {
        boolean success = staffDAO.deleteStaff(id);
        if (success) {
            return Response.ok("{\"message\": \"Staff deleted successfully!\"}").build();
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Staff member not found or failed to delete\"}").build();
        }
    }
}