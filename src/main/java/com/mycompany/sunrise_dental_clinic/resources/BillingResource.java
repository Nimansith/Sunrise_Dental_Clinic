package com.mycompany.sunrise_dental_clinic.resources;

import dao.BillDAO;
import models.Bill;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/bills")
public class BillingResource {

    private BillDAO billDAO = new BillDAO();

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllBills() {
        List<Bill> list = billDAO.getAllBills();
        return Response.ok(list).build();
    }

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getBillById(@PathParam("id") int id) {
        Bill bill = billDAO.getBillById(id);
        if (bill != null) {
            return Response.ok(bill).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Bill not found\"}").build();
        }
    }

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addBill(Bill bill) {
        if (bill == null || bill.getAppointmentId() <= 0) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Invalid bill details. appointmentId is required.\"}").build();
        }

        boolean success = billDAO.addBill(bill);
        if (success) {
            return Response.status(Response.Status.CREATED)
                           .entity("{\"message\": \"Bill generated successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to generate bill\"}").build();
        }
    }

    // Payment Status එක Update කිරීම සදහා ( e.g., PUT /api/bills/1/pay )
    @PUT
    @Path("/{id}/pay")
    @Produces(MediaType.APPLICATION_JSON)
    public Response markAsPaid(@PathParam("id") int id) {
        boolean success = billDAO.updatePaymentStatus(id, "PAID");
        if (success) {
            return Response.ok("{\"message\": \"Bill status updated to PAID successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to update payment status\"}").build();
        }
    }

    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteBill(@PathParam("id") int id) {
        boolean success = billDAO.deleteBill(id);
        if (success) {
            return Response.ok("{\"message\": \"Bill deleted successfully!\"}").build();
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Bill not found or failed to delete\"}").build();
        }
    }
}