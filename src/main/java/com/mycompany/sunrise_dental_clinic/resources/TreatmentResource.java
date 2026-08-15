/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sunrise_dental_clinic.resources;

import dao.TreatmentDAO;
import Models.Treatment;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/treatments")
public class TreatmentResource {

    private final TreatmentDAO treatmentDAO = new TreatmentDAO();

    // 1. GET: සියලුම Treatments ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/treatments
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllTreatments() {
        List<Treatment> list = treatmentDAO.getAllTreatments();
        return Response.ok(list).build();
    }

    // 2. GET: ID එක මගින් Treatment එකක් සෙවීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/treatments/1
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getTreatmentById(@PathParam("id") int id) {
        Treatment treatment = treatmentDAO.getTreatmentById(id);
        if (treatment != null) {
            return Response.ok(treatment).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                       .entity("{\"error\": \"Treatment not found\"}").build();
    }

    // 3. POST: නව Treatment එකක් ඇතුළත් කිරීම
    // Postman: POST http://localhost:8080/sunrise_dental_clinic/api/treatments
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response createTreatment(Treatment treatment) {
        if (treatment == null || treatment.getTreatmentName() == null || treatment.getTreatmentName().trim().isEmpty()) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Treatment Name is required\"}").build();
        }

        boolean success = treatmentDAO.addTreatment(treatment);
        if (success) {
            return Response.status(Response.Status.CREATED)
                           .entity("{\"message\": \"Treatment created successfully!\"}").build();
        }
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                       .entity("{\"error\": \"Failed to create treatment\"}").build();
    }

    // 4. PUT: පවතින Treatment එකක් Update කිරීම
    // Postman: PUT http://localhost:8080/sunrise_dental_clinic/api/treatments
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateTreatment(Treatment treatment) {
        if (treatment == null || treatment.getTreatmentId() <= 0) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Valid Treatment ID is required for update\"}").build();
        }

        boolean success = treatmentDAO.updateTreatment(treatment);
        if (success) {
            return Response.ok("{\"message\": \"Treatment updated successfully!\"}").build();
        }
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                       .entity("{\"error\": \"Failed to update treatment\"}").build();
    }

    // 5. DELETE: Treatment එකක් Delete කිරීම
    // Postman: DELETE http://localhost:8080/sunrise_dental_clinic/api/treatments/1
    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteTreatment(@PathParam("id") int id) {
        boolean success = treatmentDAO.deleteTreatment(id);
        if (success) {
            return Response.ok("{\"message\": \"Treatment deleted successfully!\"}").build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                       .entity("{\"error\": \"Treatment not found or failed to delete\"}").build();
    }
}