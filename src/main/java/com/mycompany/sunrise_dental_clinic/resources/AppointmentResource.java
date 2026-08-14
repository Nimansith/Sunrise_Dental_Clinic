/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sunrise_dental_clinic.resources;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/appointments")
public class AppointmentResource {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAppointments() {

        return Response.ok(
                "{\"message\":\"Appointment REST service is working\"}"
        ).build();
    }
}