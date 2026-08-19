package com.mycompany.sunrise_dental_clinic.resources;

import dao.AppointmentDAO;
import models.Appointment;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/appointments")
public class AppointmentResource {

    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    // 1. GET: සියලුම Appointments ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/appointments
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllAppointments() {
        List<Appointment> list = appointmentDAO.getAllAppointments();
        return Response.ok(list).build();
    }

    // 2. GET: ID එක මගින් Appointment එකක් ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/appointments/1
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAppointmentById(@PathParam("id") int id) {
        Appointment appt = appointmentDAO.getAppointmentById(id);
        if (appt != null) {
            return Response.ok(appt).build();
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Appointment not found\"}").build();
        }
    }

    // 3. GET: ඩොක්ටර්ගේ ID එක මගින් සියලුම Appointments ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/appointments/dentist/2
    @GET
    @Path("/dentist/{dentistId}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAppointmentsByDentistId(@PathParam("dentistId") int dentistId) {
        List<Appointment> list = appointmentDAO.getAppointmentsByDentistId(dentistId);
        return Response.ok(list).build();
    }

    // 4. GET: ඩොක්ටර්ගේ ID එක මගින් අද දිනට (Today) අදාළ Appointments ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/appointments/dentist/2/today
    @GET
    @Path("/dentist/{dentistId}/today")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getTodayAppointmentsByDentistId(@PathParam("dentistId") int dentistId) {
        List<Appointment> list = appointmentDAO.getTodayAppointmentsByDentistId(dentistId);
        return Response.ok(list).build();
    }

    // 5. POST: අලුත් Appointment එකක් එකතු කිරීම
    // Postman: POST http://localhost:8080/sunrise_dental_clinic/api/appointments
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response addAppointment(Appointment appointment) {
        if (appointment == null || appointment.getPatientName() == null || 
            appointment.getDentistId() <= 0 || appointment.getTreatmentId() <= 0) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Invalid appointment details. Patient name, dentistId, and treatmentId are required.\"}").build();
        }

        boolean success = appointmentDAO.addAppointment(appointment);
        if (success) {
            return Response.status(Response.Status.CREATED)
                           .entity("{\"message\": \"Appointment booked successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to book appointment\"}").build();
        }
    }

    // 6. PUT: Appointment එකක් Update කිරීම
    // Postman: PUT http://localhost:8080/sunrise_dental_clinic/api/appointments
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateAppointment(Appointment appointment) {
        boolean success = appointmentDAO.updateAppointment(appointment);
        if (success) {
            return Response.ok("{\"message\": \"Appointment updated successfully!\"}").build();
        } else {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                           .entity("{\"error\": \"Failed to update appointment\"}").build();
        }
    }

    // 7. DELETE: Appointment එකක් Delete කිරීම
    // Postman: DELETE http://localhost:8080/sunrise_dental_clinic/api/appointments/1
    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteAppointment(@PathParam("id") int id) {
        boolean success = appointmentDAO.deleteAppointment(id);
        if (success) {
            return Response.ok("{\"message\": \"Appointment deleted successfully!\"}").build();
        } else {
            return Response.status(Response.Status.NOT_FOUND)
                           .entity("{\"error\": \"Appointment not found or failed to delete\"}").build();
        }
    }
}