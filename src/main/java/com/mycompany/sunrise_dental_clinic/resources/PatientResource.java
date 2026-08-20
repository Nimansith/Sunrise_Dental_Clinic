package com.mycompany.sunrise_dental_clinic.resources;

import dao.PatientDAO;
import models.Patient;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/patients")
public class PatientResource {

    private PatientDAO patientDAO = new PatientDAO();

    // 1. GET: සියලුම Patients ලගේ ලැයිස්තුව ලබා ගැනීම
    // Postman URL: GET http://localhost:8080/sunrise_dental_clinic/api/patients
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllPatients() {
        List<Patient> list = patientDAO.getAllPatients();
        return Response.ok(list).build();
    }

    // 2. GET: ID එක මගින් Patient කෙනෙකුගේ තොරතුරු ලබා ගැනීම
    // Postman URL: GET http://localhost:8080/sunrise_dental_clinic/api/patients/1
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getPatientById(@PathParam("id") int id) {
        Patient patient = patientDAO.getPatientById(id);
        if (patient != null) {
            return Response.ok(patient).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Patient not found\"}").build();
        }
    }

    // 3. POST: නව Patient කෙනෙකු Register කිරීම
    // Postman URL: POST http://localhost:8080/sunrise_dental_clinic/api/patients
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addPatient(Patient patient) {
        if (patient == null || patient.getPatientName() == null || patient.getContactNumber() == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Invalid patient details. Name and Contact Number are required.\"}").build();
        }

        boolean success = patientDAO.addPatient(patient);
        if (success) {
            return Response.status(Response.Status.CREATED)
                           .entity("{\"message\": \"Patient registered successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to register patient\"}").build();
        }
    }

    // 4. PUT: Patient කෙනෙකුගේ තොරතුරු Update කිරීම
    // Postman URL: PUT http://localhost:8080/sunrise_dental_clinic/api/patients
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updatePatient(Patient patient) {
        boolean success = patientDAO.updatePatient(patient);
        if (success) {
            return Response.ok("{\"message\": \"Patient updated successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to update patient\"}").build();
        }
    }

    // 5. DELETE: Patient කෙනෙකුව Delete කිරීම
    // Postman URL: DELETE http://localhost:8080/sunrise_dental_clinic/api/patients/1
    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deletePatient(@PathParam("id") int id) {
        boolean success = patientDAO.deletePatient(id);
        if (success) {
            return Response.ok("{\"message\": \"Patient deleted successfully!\"}").build();
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Patient not found or failed to delete\"}").build();
        }
    }
}