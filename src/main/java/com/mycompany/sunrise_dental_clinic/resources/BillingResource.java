/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sunrise_dental_clinic.resources;

import dao.BillDAO;
import Models.Bill;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/billing")
public class BillingResource {

    private final BillDAO billDAO = new BillDAO();

    // 1. GET: සියලුම Bills, Patient Details ද සමඟ ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/billing
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllBills() {
        List<Bill> list = billDAO.getAllBills();
        return Response.ok(list).build();
    }

    // 2. GET: ID එක මගින් Specific Bill එකක් ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/billing/1
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getBillById(@PathParam("id") int id) {
        Bill bill = billDAO.getBillById(id);
        if (bill != null) {
            return Response.ok(bill).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                       .entity("{\"error\": \"Bill not found\"}").build();
    }

    // 3. POST: නව Bill එකක් Create කිරීම
    // Postman: POST http://localhost:8080/sunrise_dental_clinic/api/billing
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response createBill(Bill bill) {
        if (bill == null || bill.getAppointmentId() <= 0) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Valid Appointment ID is required\"}").build();
        }

        boolean success = billDAO.addBill(bill);
        if (success) {
            return Response.status(Response.Status.CREATED)
                           .entity("{\"message\": \"Bill created successfully!\"}").build();
        }
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                       .entity("{\"error\": \"Failed to create bill. Ensure the appointment ID exists.\"}").build();
    }

    // 4. DELETE: Bill එකක් Delete කිරීම
    // Postman: DELETE http://localhost:8080/sunrise_dental_clinic/api/billing/1
    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteBill(@PathParam("id") int id) {
        boolean success = billDAO.deleteBill(id);
        if (success) {
            return Response.ok("{\"message\": \"Bill deleted successfully!\"}").build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                       .entity("{\"error\": \"Bill not found or failed to delete\"}").build();
    }
}
