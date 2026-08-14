<%-- 
    Document   : appointmentDetails
    Created on : Aug 13, 2026, 11:17:55 PM
    Author     : Rusanda Nimansith
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Appointment Details - Sunrise Dental Clinic</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f7f6;
            margin: 0;
        }

        .navbar {
            background: #114232;
            color: white;
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }

        .container {
            max-width: 850px;
            margin: 40px auto;
        }

        .search-box,
        .details-box {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.10);
            margin-bottom: 25px;
        }

        h2 {
            color: #114232;
        }

        input {
            width: 70%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        button {
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            background: #114232;
            color: white;
            cursor: pointer;
        }

        .details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
        }

        .item {
            padding: 15px;
            background: #f4f7f6;
            border-radius: 6px;
        }

        .item strong {
            display: block;
            color: #114232;
            margin-bottom: 5px;
        }

        @media(max-width: 700px) {
            .details {
                grid-template-columns: 1fr;
            }

            input {
                width: 100%;
                box-sizing: border-box;
                margin-bottom: 10px;
            }
        }
    </style>
</head>

<body>

<div class="navbar">
    <strong>🦷 Sunrise Dental Clinic</strong>

    <div>
        <a href="index.jsp">Home</a>
        <a href="adminDashboard.jsp">Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<div class="container">

    <div class="search-box">

        <h2>Search Appointment</h2>

        <form action="${pageContext.request.contextPath}/appointment"
              method="GET">

            <input type="text"
                   name="appointmentNumber"
                   placeholder="Enter appointment number"
                   required>

            <button type="submit">
                Search
            </button>

        </form>

    </div>

    <div class="details-box">

        <h2>Appointment Details</h2>

        <div class="details">

            <div class="item">
                <strong>Appointment Number</strong>
                <span>-</span>
            </div>

            <div class="item">
                <strong>Patient Name</strong>
                <span>-</span>
            </div>

            <div class="item">
                <strong>Address</strong>
                <span>-</span>
            </div>

            <div class="item">
                <strong>Contact Number</strong>
                <span>-</span>
            </div>

            <div class="item">
                <strong>Dentist</strong>
                <span>-</span>
            </div>

            <div class="item">
                <strong>Treatment</strong>
                <span>-</span>
            </div>

            <div class="item">
                <strong>Appointment Date</strong>
                <span>-</span>
            </div>

            <div class="item">
                <strong>Appointment Time</strong>
                <span>-</span>
            </div>

        </div>

    </div>

</div>

</body>
</html>
