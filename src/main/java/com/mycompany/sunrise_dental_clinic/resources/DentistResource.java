package com.mycompany.sunrise_dental_clinic.resources;

import DAO.DentistDAO;
import Models.Dentist;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/dentists")
public class DentistResource {

    private DentistDAO dentistDAO = new DentistDAO();

    // 1. GET: සියලුම Dentists ලාගේ ලැයිස්තුව ලබා ගැනීම
    // Postman URL: GET http://localhost:8080/sunrise_dental_clinic/api/dentists
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllDentists() {
        List<Dentist> list = dentistDAO.getAllDentists();
        return Response.ok(list).build();
    }

    // 2. GET: ID එක මගින් එක් Dentist කෙනෙකුගේ තොරතුරු ලබා ගැනීම
    // Postman URL: GET http://localhost:8080/sunrise_dental_clinic/api/dentists/1
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getDentistById(@PathParam("id") int id) {
        Dentist dentist = dentistDAO.getDentistById(id);
        if (dentist != null) {
            return Response.ok(dentist).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Dentist not found\"}").build();
        }
    }

    // 3. POST: නව Dentist කෙනෙකු Register කිරීම (username & password ඇතුළත්ව)
    // Postman URL: POST http://localhost:8080/sunrise_dental_clinic/api/dentists
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response registerDentist(Dentist dentist) {
        if (dentist == null || dentist.getDentistName() == null || dentist.getUsername() == null || dentist.getPassword() == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Invalid Dentist details. Username and Password are required.\"}").build();
        }

        boolean success = dentistDAO.registerDentist(dentist);
        if (success) {
            return Response.status(Response.Status.CREATED)
                           .entity("{\"message\": \"Dentist registered successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to register dentist\"}").build();
        }
    }

    // 4. PUT: Dentist කෙනෙකුගේ තොරතුරු Update කිරීම
    // Postman URL: PUT http://localhost:8080/sunrise_dental_clinic/api/dentists
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateDentist(Dentist dentist) {
        boolean success = dentistDAO.updateDentist(dentist);
        if (success) {
            return Response.ok("{\"message\": \"Dentist updated successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to update dentist\"}").build();
        }
    }

    // 5. DELETE: Dentist කෙනෙකුව Delete කිරීම
    // Postman URL: DELETE http://localhost:8080/sunrise_dental_clinic/api/dentists/1
    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteDentist(@PathParam("id") int id) {
        boolean success = dentistDAO.deleteDentist(id);
        if (success) {
            return Response.ok("{\"message\": \"Dentist deleted successfully!\"}").build();
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Dentist not found or failed to delete\"}").build();
        }
    }
}