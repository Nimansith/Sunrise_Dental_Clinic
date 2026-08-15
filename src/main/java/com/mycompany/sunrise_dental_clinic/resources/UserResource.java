/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.sunrise_dental_clinic.resources;

import dao.UserDAO;
import Models.User;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import java.util.List;

@Path("/users")
public class UserResource {

    private final UserDAO userDAO = new UserDAO();

    // 1. POST: User Login (Authentication)
    // Postman: POST http://localhost:8080/sunrise_dental_clinic/api/users/login
    @POST
    @Path("/login")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response login(User credentials) {
        if (credentials == null || credentials.getUsername() == null || credentials.getPassword() == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Username and Password are required\"}").build();
        }

        User user = userDAO.authenticateUser(credentials.getUsername(), credentials.getPassword());
        if (user != null) {
            return Response.ok(user).build();
        }
        return Response.status(Response.Status.UNAUTHORIZED)
                       .entity("{\"error\": \"Invalid username or password\"}").build();
    }

    // 2. GET: සියලුම Users ලා ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/users
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response getAllUsers() {
        List<User> list = userDAO.getAllUsers();
        return Response.ok(list).build();
    }

    // 3. GET: ID එක මගින් User කෙනෙකු ලබා ගැනීම
    // Postman: GET http://localhost:8080/sunrise_dental_clinic/api/users/1
    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getUserById(@PathParam("id") int id) {
        User user = userDAO.getUserById(id);
        if (user != null) {
            return Response.ok(user).build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                       .entity("{\"error\": \"User not found\"}").build();
    }

    // 4. POST: අලුත් User කෙනෙක් එකතු කිරීම (Register User)
    // Postman: POST http://localhost:8080/sunrise_dental_clinic/api/users
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response createUser(User user) {
        if (user == null || user.getUsername() == null || user.getPassword() == null || user.getRole() == null) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Username, Password, and Role are required\"}").build();
        }

        boolean success = userDAO.addUser(user);
        if (success) {
            return Response.status(Response.Status.CREATED)
                           .entity("{\"message\": \"User created successfully!\"}").build();
        }
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                       .entity("{\"error\": \"Failed to create user. Username or Email might already exist.\"}").build();
    }

    // 5. PUT: User ගේ තොරතුරු Update කිරීම
    // Postman: PUT http://localhost:8080/sunrise_dental_clinic/api/users
    @PUT
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateUser(User user) {
        if (user == null || user.getUserId() <= 0) {
            return Response.status(Response.Status.BAD_REQUEST)
                           .entity("{\"error\": \"Valid User ID is required for update\"}").build();
        }

        boolean success = userDAO.updateUser(user);
        if (success) {
            return Response.ok("{\"message\": \"User updated successfully!\"}").build();
        }
        return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                       .entity("{\"error\": \"Failed to update user\"}").build();
    }

    // 6. DELETE: User කෙනෙකු Delete කිරීම
    // Postman: DELETE http://localhost:8080/sunrise_dental_clinic/api/users/1
    @DELETE
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Response deleteUser(@PathParam("id") int id) {
        boolean success = userDAO.deleteUser(id);
        if (success) {
            return Response.ok("{\"message\": \"User deleted successfully!\"}").build();
        }
        return Response.status(Response.Status.NOT_FOUND)
                       .entity("{\"error\": \"User not found or failed to delete\"}").build();
    }
}
