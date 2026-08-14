<%-- 
    Document   : bill
    Created on : Aug 13, 2026, 11:18:58 PM
    Author     : Rusanda Nimansith
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Bill - Sunrise Dental Clinic</title>

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

        .bill-container {
            max-width: 700px;
            margin: 40px auto;
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.10);
        }

        .clinic-header {
            text-align: center;
            border-bottom: 2px solid #114232;
            padding-bottom: 20px;
            margin-bottom: 25px;
        }

        .clinic-header h1 {
            color: #114232;
        }

        .patient-info {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-bottom: 25px;
        }

        .info {
            padding: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background: #114232;
            color: white;
        }

        .total {
            text-align: right;
            font-size: 20px;
            font-weight: bold;
            color: #114232;
            margin-top: 25px;
        }

        .buttons {
            text-align: center;
            margin-top: 30px;
        }

        button {
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            background: #114232;
            color: white;
            cursor: pointer;
            margin: 5px;
        }

        @media print {
            .navbar,
            .buttons {
                display: none;
            }

            .bill-container {
                box-shadow: none;
                margin: 0;
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

<div class="bill-container">

    <div class="clinic-header">
        <h1>Sunrise Dental Clinic</h1>
        <p>Patient Treatment Bill</p>
        <p>Colombo, Sri Lanka</p>
    </div>

    <div class="patient-info">

        <div class="info">
            <strong>Appointment No:</strong> -
        </div>

        <div class="info">
            <strong>Date:</strong> -
        </div>

        <div class="info">
            <strong>Patient Name:</strong> -
        </div>

        <div class="info">
            <strong>Contact:</strong> -
        </div>

    </div>

    <table>

        <thead>
            <tr>
                <th>Treatment</th>
                <th>Consultation Fee</th>
                <th>Treatment Cost</th>
                <th>Total</th>
            </tr>
        </thead>

        <tbody>

            <tr>
                <td>Sample Treatment</td>
                <td>Rs. 0.00</td>
                <td>Rs. 0.00</td>
                <td>Rs. 0.00</td>
            </tr>

        </tbody>

    </table>

    <div class="total">
        Grand Total: Rs. 0.00
    </div>

    <div class="buttons">

        <button onclick="window.print()">
            Print Bill
        </button>

        <button onclick="window.location.href='index.jsp'">
            Back to Home
        </button>

    </div>

</div>

</body>
</html>
