/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sunrise_dental_clinic.resources;

import dao.AppointmentDAO;
import Models.Appointment;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/appointments")
public class AppointmentResource {

    private final AppointmentDAO appointmentDAO = new AppointmentDAO();

    // 1. GET: සියලුම Appointments ලැයිස්තුව ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/appointments
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllAppointments() {
        List<Appointment> list = appointmentDAO.getAllAppointments();
        return Response.ok(list).build();
    }

    // 2. GET: ID එක මගින් එක් Appointment එකක් සෙවීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/appointments/1
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAppointmentById(@PathParam("id") int id) {
        Appointment appt = appointmentDAO.getAppointmentById(id);
        if (appt != null) {
            return Response.ok(appt).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                       .entity("{\"error\": \"Appointment not found\"}").build();
    }

    // 3. POST: නව Appointment එකක් ඇතුළත් කිරීම (Create)
    // Postman: POST http://localhost:8080/sunrise_dental_clinic/api/appointments
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response createAppointment(Appointment appointment) {
        if (appointment == null || appointment.getPatientName() == null || appointment.getDentistName() == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Patient Name and Dentist Name are required fields.\"}").build();
        }

        boolean success = appointmentDAO.addAppointment(appointment);
        if (success) {
            return Response.status(Response.Status.CREATED)
                           .entity("{\"message\": \"Appointment booked successfully!\"}").build();
        }
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                       .entity("{\"error\": \"Failed to book appointment\"}").build();
    }

    // 4. PUT: පවතින Appointment එකක් Update කිරීම
    // Postman: PUT http://localhost:8080/sunrise_dental_clinic/api/appointments
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateAppointment(Appointment appointment) {
        if (appointment == null || appointment.getAppointmentId() <= 0) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Valid Appointment ID is required for update.\"}").build();
        }

        boolean success = appointmentDAO.updateAppointment(appointment);
        if (success) {
            return Response.ok("{\"message\": \"Appointment updated successfully!\"}").build();
        }
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                       .entity("{\"error\": \"Failed to update appointment\"}").build();
    }

    // 5. DELETE: Appointment එකක් ඉවත් කිරීම
    // Postman: DELETE http://localhost:8080/sunrise_dental_clinic/api/appointments/1
    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteAppointment(@PathParam("id") int id) {
        boolean success = appointmentDAO.deleteAppointment(id);
        if (success) {
            return Response.ok("{\"message\": \"Appointment deleted successfully!\"}").build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                       .entity("{\"error\": \"Appointment not found or failed to delete\"}").build();
    }
}
