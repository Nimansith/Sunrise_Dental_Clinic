package com.mycompany.sunrise_dental_clinic.resources;

import DAO.TreatmentDAO;
import Models.Treatment;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/treatments")
public class TreatmentResource {

    private TreatmentDAO treatmentDAO = new TreatmentDAO();

    // 1. GET: සියලුම Treatments ලැයිස්තුව ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/treatments
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllTreatments() {
        List<Treatment> list = treatmentDAO.getAllTreatments();
        return Response.ok(list).build();
    }

    // 2. GET: ID එක මගින් Treatment එකක් ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/treatments/1
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getTreatmentById(@PathParam("id") int id) {
        Treatment treatment = treatmentDAO.getTreatmentById(id);
        if (treatment != null) {
            return Response.ok(treatment).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Treatment not found\"}").build();
        }
    }

    // 3. POST: අලුත් Treatment එකක් එකතු කිරීම
    // Postman: POST http://localhost:8080/sunrise_dental_clinic/api/treatments
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addTreatment(Treatment treatment) {
        if (treatment == null || treatment.getTreatmentName() == null || treatment.getCost() <= 0) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Invalid Treatment details or cost\"}").build();
        }

        boolean success = treatmentDAO.addTreatment(treatment);
        if (success) {
            return Response.status(Response.Status.CREATED)
                           .entity("{\"message\": \"Treatment added successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to add treatment\"}").build();
        }
    }

    // 4. PUT: Treatment එකක් Update කිරීම
    // Postman: PUT http://localhost:8080/sunrise_dental_clinic/api/treatments
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateTreatment(Treatment treatment) {
        boolean success = treatmentDAO.updateTreatment(treatment);
        if (success) {
            return Response.ok("{\"message\": \"Treatment updated successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to update treatment\"}").build();
        }
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
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Treatment not found or failed to delete\"}").build();
        }
    }
}