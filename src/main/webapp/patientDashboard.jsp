<%-- 
    Document   : patientDashboard
    Created on : Aug 14, 2026
    Author     : Rusanda Nimansith
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Libraries.User"%>
<%
    // Session Verification Guard
    User user = (User) session.getAttribute("user");
    if (user == null || !"PATIENT".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Portal - Sunrise Dental Clinic</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #334155;
        }

        .navbar-brand-custom {
            font-weight: 700;
            color: #0284c7 !important;
            font-size: 1.35rem;
        }

        .card-custom {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }

        .stat-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid #e2e8f0;
            padding: 20px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.08);
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
        }

        .bg-sky-light { background-color: #e0f2fe; color: #0284c7; }
        .bg-green-light { background-color: #dcfce7; color: #16a34a; }
        .bg-amber-light { background-color: #fef3c7; color: #d97706; }

        .btn-primary-custom {
            background-color: #0284c7;
            border: none;
            color: white;
            font-weight: 600;
            border-radius: 10px;
            padding: 10px 18px;
            transition: all 0.2s;
        }

        .btn-primary-custom:hover {
            background-color: #0369a1;
            color: white;
        }

        .table-custom {
            background: white;
            border-radius: 12px;
            overflow: hidden;
        }

        .table-custom thead {
            background-color: #f1f5f9;
            color: #475569;
            font-weight: 600;
        }

        .badge-scheduled { background-color: #e0f2fe; color: #0369a1; }
        .badge-completed { background-color: #dcfce7; color: #15803d; }
        .badge-cancelled { background-color: #fee2e2; color: #b91c1c; }
        .badge-pending { background-color: #fef3c7; color: #b45309; }
    </style>
</head>
<body>

<!-- Top Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom sticky-top py-3">
    <div class="container-fluid px-4">
        <a class="navbar-brand navbar-brand-custom d-flex align-items-center" href="#">
            <i class="fa-solid fa-tooth me-2"></i> Sunrise Dental - Patient Portal
        </a>
        
        <div class="d-flex align-items-center gap-3">
            <div class="d-none d-sm-block text-end">
                <span class="d-block fw-bold text-dark">Welcome, <%= user.getUsername() %></span>
                <small class="text-muted"><%= user.getRole() %></small>
            </div>
            <a href="LogoutServlet" class="btn btn-outline-danger btn-sm rounded-3">
                <i class="fa-solid fa-right-from-bracket me-1"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 py-4">

    <!-- Action Alerts -->
    <% if ("booked".equals(request.getParameter("status"))) { %>
        <div class="alert alert-success alert-dismissible fade show rounded-3 mb-4" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i> Your appointment request has been submitted successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("error".equals(request.getParameter("status"))) { %>
        <div class="alert alert-danger alert-dismissible fade show rounded-3 mb-4" role="alert">
            <i class="fa-solid fa-circle-exclamation me-2"></i> Could not request appointment. Please try again.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <!-- Welcome Header & Quick Action -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
        <div>
            <h3 class="fw-bold mb-1">My Health Dashboard</h3>
            <p class="text-muted mb-0">Track your dental appointments, prescriptions, and billing invoices.</p>
        </div>
        <div>
            <button class="btn btn-primary-custom shadow-sm" data-bs-toggle="modal" data-bs-target="#requestAppointmentModal">
                <i class="fa-solid fa-calendar-plus me-1"></i> Request New Appointment
            </button>
        </div>
    </div>

    <!-- Quick Overview Stats -->
    <div class="row g-3 mb-4">
        <div class="col-12 col-md-4">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Next Scheduled Visit</span>
                    <h5 class="fw-bold text-primary mb-0">Aug 20, 2026 - 10:00 AM</h5>
                </div>
                <div class="stat-icon bg-sky-light">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-4">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Completed Treatments</span>
                    <h3 class="fw-bold mb-0">4</h3>
                </div>
                <div class="stat-icon bg-green-light">
                    <i class="fa-solid fa-teeth-open"></i>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-4">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Pending Balance</span>
                    <h3 class="fw-bold mb-0">Rs. 0.00</h3>
                </div>
                <div class="stat-icon bg-amber-light">
                    <i class="fa-solid fa-file-invoice"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Navigation Tabs -->
    <ul class="nav nav-pills mb-4" id="patientTabs" role="tablist">
        <li class="nav-item">
            <button class="nav-link active" id="my-appointments-tab" data-bs-toggle="pill" data-bs-target="#my-appointments" type="button">
                <i class="fa-regular fa-calendar-days me-2"></i> My Appointments
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" id="my-records-tab" data-bs-toggle="pill" data-bs-target="#my-records" type="button">
                <i class="fa-solid fa-file-medical me-2"></i> Treatment History
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" id="my-invoices-tab" data-bs-toggle="pill" data-bs-target="#my-invoices" type="button">
                <i class="fa-solid fa-receipt me-2"></i> Invoices & Receipts
            </button>
        </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content" id="patientTabContent">

        <!-- Tab 1: My Appointments -->
        <div class="tab-pane fade show active" id="my-appointments" role="tabpanel">
            <div class="card card-custom p-3 border-0">
                <div class="table-responsive">
                    <table class="table table-hover table-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Appt No</th>
                                <th>Dentist Name</th>
                                <th>Treatment</th>
                                <th>Date & Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>#APT-205</strong></td>
                                <td>Dr. Nishan Silva</td>
                                <td>Dental Scaling & Polishing</td>
                                <td>Aug 20, 2026 - 10:00 AM</td>
                                <td><span class="badge badge-scheduled px-3 py-2 rounded-pill">Scheduled</span></td>
                            </tr>
                            <tr>
                                <td><strong>#APT-101</strong></td>
                                <td>Dr. Keshani Perera</td>
                                <td>Routine Checkup</td>
                                <td>Jul 10, 2026 - 02:30 PM</td>
                                <td><span class="badge badge-completed px-3 py-2 rounded-pill">Completed</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tab 2: Medical History -->
        <div class="tab-pane fade" id="my-records" role="tabpanel">
            <div class="card card-custom p-3 border-0">
                <div class="table-responsive">
                    <table class="table table-hover table-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Dentist</th>
                                <th>Diagnosis</th>
                                <th>Treatment Done</th>
                                <th>Prescription</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>2026-07-10</td>
                                <td>Dr. Keshani Perera</td>
                                <td>Minor Cavity Lower Left Premolar</td>
                                <td>Composite Filling Done</td>
                                <td>Paracetamol 500mg as needed</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tab 3: Invoices & Receipts -->
        <div class="tab-pane fade" id="my-invoices" role="tabpanel">
            <div class="card card-custom p-3 border-0">
                <div class="table-responsive">
                    <table class="table table-hover table-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Invoice ID</th>
                                <th>Appt No</th>
                                <th>Date</th>
                                <th>Total Amount (LKR)</th>
                                <th>Payment Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>#INV-302</strong></td>
                                <td>#APT-101</td>
                                <td>2026-07-10</td>
                                <td>4,500.00</td>
                                <td><span class="badge badge-completed px-3 py-2 rounded-pill">PAID</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Modal: Request New Appointment -->
<div class="modal fade" id="requestAppointmentModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-calendar-plus text-primary me-2"></i>Book an Appointment</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="AppointmentServlet" method="POST">
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Select Treatment Service</label>
                        <select name="treatmentId" class="form-select rounded-3" required>
                            <option value="">-- Choose Treatment --</option>
                            <option value="1">Routine Checkup</option>
                            <option value="2">Teeth Cleaning / Scaling</option>
                            <option value="3">Root Canal Treatment</option>
                            <option value="4">Tooth Extraction</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Preferred Dentist</label>
                        <select name="dentistId" class="form-select rounded-3" required>
                            <option value="">-- Choose Dentist --</option>
                            <option value="1">Dr. Nishan Silva</option>
                            <option value="2">Dr. Keshani Perera</option>
                        </select>
                    </div>

                    <div class="row g-2 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Preferred Date</label>
                            <input type="date" name="appointmentDate" class="form-control rounded-3" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Preferred Time</label>
                            <input type="time" name="appointmentTime" class="form-control rounded-3" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Reason / Symptoms (Optional)</label>
                        <textarea name="reason" class="form-control rounded-3" rows="2" placeholder="Briefly describe your tooth issue..."></textarea>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary-custom">Submit Appointment Request</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>