<%-- 
    Document   : login
    Created on : Aug 12, 2026, 5:51:54 PM
    Author     : Rusanda Nimansith
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sunrise Dental Clinic - Login</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0;
            padding: 20px;
        }

        .login-card {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(2, 132, 199, 0.1);
            border: 1px solid #bae6fd;
            width: 100%;
            max-width: 420px;
            overflow: hidden;
        }

        .brand-header {
            background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
            padding: 35px 25px;
            text-align: center;
            color: #ffffff;
        }

        .brand-logo {
            font-size: 2.5rem;
            margin-bottom: 8px;
        }

        .brand-title {
            font-weight: 700;
            font-size: 1.5rem;
            margin: 0;
            letter-spacing: -0.5px;
        }

        .login-body {
            padding: 35px 30px;
        }

        .form-label {
            font-weight: 600;
            color: #334155;
            font-size: 0.9rem;
        }

        .form-control {
            border-radius: 10px;
            padding: 12px 16px;
            border: 1px solid #cbd5e1;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            border-color: #0284c7;
            box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.15);
        }

        .btn-login {
            background-color: #0284c7;
            border: none;
            color: #ffffff;
            font-weight: 600;
            padding: 12px;
            border-radius: 10px;
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-login:hover {
            background-color: #0369a1;
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(2, 132, 199, 0.25);
        }

        .back-home {
            color: #64748b;
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .back-home:hover {
            color: #0284c7;
        }
    </style>
</head>
<body>

<div class="login-card">
    <!-- Clinic Brand Header -->
    <div class="brand-header">
        <div class="brand-logo">
            <i class="fa-solid fa-tooth"></i>
        </div>
        <h2 class="brand-title">Sunrise Dental</h2>
        <p class="small text-white-50 mb-0 mt-1">Staff & Patient Portal Access</p>
    </div>

    <div class="login-body">
        <!-- Error Handling Alerts -->
        <%
            String error = request.getParameter("error");

            if ("invalid".equals(error)) {
        %>
            <div class="alert alert-danger d-flex align-items-center rounded-3 mb-4 p-3" role="alert">
                <i class="fa-solid fa-circle-exclamation me-2 fs-5"></i>
                <div class="small fw-semibold">
                    Invalid username or password.
                </div>
            </div>
        <%
            } else if ("invalidrole".equals(error)) {
        %>
            <div class="alert alert-warning d-flex align-items-center rounded-3 mb-4 p-3" role="alert">
                <i class="fa-solid fa-triangle-exclamation me-2 fs-5"></i>
                <div class="small fw-semibold">
                    Invalid user role assigned.
                </div>
            </div>
        <%
            }
        %>

        <!-- Login Form -->
        <form action="login" method="POST">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <div class="input-group">
                    <span class="input-group-text bg-light text-muted border-end-0 rounded-start-3">
                        <i class="fa-solid fa-user"></i>
                    </span>
                    <input 
                        type="text" 
                        id="username"
                        name="username" 
                        class="form-control border-start-0 rounded-end-3" 
                        placeholder="Enter username" 
                        required
                    >
                </div>
            </div>

            <div class="mb-4">
                <label for="password" class="form-label">Password</label>
                <div class="input-group">
                    <span class="input-group-text bg-light text-muted border-end-0 rounded-start-3">
                        <i class="fa-solid fa-lock"></i>
                    </span>
                    <input 
                        type="password" 
                        id="password"
                        name="password" 
                        class="form-control border-start-0 rounded-end-3" 
                        placeholder="Enter password" 
                        required
                    >
                </div>
            </div>

            <button type="submit" class="btn btn-login mb-3 shadow-sm">
                <i class="fa-solid fa-right-to-bracket me-2"></i>Login
            </button>
        </form>

        <div class="text-center mt-4">
            <a href="index.jsp" class="back-home">
                <i class="fa-solid fa-arrow-left me-1"></i> Back to Homepage
            </a>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>