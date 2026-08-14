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

@Path("/dentists")
public class DentistResource {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getDentists() {

        return Response.ok(
                "{\"message\":\"Dentist REST service is working\"}"
        ).build();
    }
}