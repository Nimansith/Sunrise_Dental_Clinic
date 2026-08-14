<%-- 
    Document   : receptionist
    Created on : Aug 12, 2026, 5:53:10 PM
    Author     : Rusanda Nimansith
--%>

<%-- 
    Document   : receptionistDashboard
    Created on : Aug 14, 2026
    Author     : Rusanda Nimansith
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Libraries.User"%>
<%
    // Session Verification Guard
    User user = (User) session.getAttribute("user");
    if (user == null || !"RECEPTIONIST".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Receptionist Dashboard - Sunrise Dental Clinic</title>
    
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

        .sidebar-card {
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
        .bg-purple-light { background-color: #f3e8ff; color: #9333ea; }

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

        .nav-pills .nav-link {
            color: #64748b;
            font-weight: 600;
            border-radius: 10px;
            padding: 10px 18px;
            margin-right: 8px;
        }

        .nav-pills .nav-link.active {
            background-color: #0284c7;
            color: #ffffff;
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
    </style>
</head>
<body>

<!-- Top Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom sticky-top py-3">
    <div class="container-fluid px-4">
        <a class="navbar-brand navbar-brand-custom d-flex align-items-center" href="#">
            <i class="fa-solid fa-tooth me-2"></i> Sunrise Dental Portal
        </a>
        
        <div class="d-flex align-items-center gap-3">
            <div class="d-none d-sm-block text-end">
                <span class="d-block fw-bold text-dark"><%= user.getRole() %></span>
                <small class="text-muted"><%= user.getUsername() %></small>
            </div>
            <a href="LogoutServlet" class="btn btn-outline-danger btn-sm rounded-3">
                <i class="fa-solid fa-right-from-bracket me-1"></i> Logout
            </a>
        </div>
    </div>
</nav>

<div class="container-fluid px-4 py-4">

    <!-- Action Alerts -->
    <% if ("success".equals(request.getParameter("status"))) { %>
        <div class="alert alert-success alert-dismissible fade show rounded-3 mb-4" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i> Operation completed successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("error".equals(request.getParameter("status"))) { %>
        <div class="alert alert-danger alert-dismissible fade show rounded-3 mb-4" role="alert">
            <i class="fa-solid fa-circle-exclamation me-2"></i> An error occurred. Please try again.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <!-- Header Actions & Quick Buttons -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
        <div>
            <h3 class="fw-bold mb-1">Receptionist Dashboard</h3>
            <p class="text-muted mb-0">Manage patients, appointments, and billing operations.</p>
        </div>
        <div class="d-flex gap-2 flex-wrap">
            <button class="btn btn-primary-custom shadow-sm" data-bs-toggle="modal" data-bs-target="#addPatientModal">
                <i class="fa-solid fa-user-plus me-1"></i> Add Patient
            </button>
            <button class="btn btn-dark rounded-3 font-weight-semibold shadow-sm" data-bs-toggle="modal" data-bs-target="#bookAppointmentModal">
                <i class="fa-solid fa-calendar-plus me-1"></i> Book Appointment
            </button>
            <button class="btn btn-success rounded-3 font-weight-semibold shadow-sm" data-bs-toggle="modal" data-bs-target="#createBillModal">
                <i class="fa-solid fa-file-invoice-dollar me-1"></i> Create Bill
            </button>
        </div>
    </div>

    <!-- Quick Stats Overview Cards -->
    <div class="row g-3 mb-4">
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Today's Appointments</span>
                    <h3 class="fw-bold mb-0">12</h3>
                </div>
                <div class="stat-icon bg-sky-light">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Total Patients</span>
                    <h3 class="fw-bold mb-0">148</h3>
                </div>
                <div class="stat-icon bg-green-light">
                    <i class="fa-solid fa-users"></i>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Pending Payments</span>
                    <h3 class="fw-bold mb-0">Rs. 24,500</h3>
                </div>
                <div class="stat-icon bg-amber-light">
                    <i class="fa-solid fa-clock-rotate-left"></i>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Active Dentists</span>
                    <h3 class="fw-bold mb-0">4</h3>
                </div>
                <div class="stat-icon bg-purple-light">
                    <i class="fa-solid fa-user-doctor"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Navigation Tabs for Operations -->
    <ul class="nav nav-pills mb-4" id="dashboardTabs" role="tablist">
        <li class="nav-item">
            <button class="nav-link active" id="appointments-tab" data-bs-toggle="pill" data-bs-target="#appointments" type="button">
                <i class="fa-regular fa-calendar-days me-2"></i> Appointments
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" id="patients-tab" data-bs-toggle="pill" data-bs-target="#patients" type="button">
                <i class="fa-solid fa-hospital-user me-2"></i> Patient Directory
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" id="billing-tab" data-bs-toggle="pill" data-bs-target="#billing" type="button">
                <i class="fa-solid fa-receipt me-2"></i> Billing & Payments
            </button>
        </li>
    </ul>

    <!-- Tab Content Area -->
    <div class="tab-content" id="dashboardTabContent">
        
        <!-- Tab 1: Appointments -->
        <div class="tab-pane fade show active" id="appointments" role="tabpanel">
            <div class="card sidebar-card border-0 p-3">
                <div class="table-responsive">
                    <table class="table table-hover table-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Appt ID</th>
                                <th>Patient Name</th>
                                <th>Assigned Dentist</th>
                                <th>Date & Time</th>
                                <th>Status</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>#APT-101</strong></td>
                                <td>Kamal Perera</td>
                                <td>Dr. Nishan Silva</td>
                                <td>Aug 14, 2026 - 10:30 AM</td>
                                <td><span class="badge badge-scheduled px-3 py-2 rounded-pill">Scheduled</span></td>
                                <td class="text-end">
                                    <button class="btn btn-sm btn-outline-success rounded-2 me-1" title="Mark Completed"><i class="fa-solid fa-check"></i></button>
                                    <button class="btn btn-sm btn-outline-danger rounded-2" title="Cancel Appointment"><i class="fa-solid fa-xmark"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#APT-102</strong></td>
                                <td>Nimali Fernando</td>
                                <td>Dr. Keshani Perera</td>
                                <td>Aug 14, 2026 - 11:15 AM</td>
                                <td><span class="badge badge-completed px-3 py-2 rounded-pill">Completed</span></td>
                                <td class="text-end">
                                    <button class="btn btn-sm btn-outline-primary rounded-2" title="View Details"><i class="fa-solid fa-eye"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tab 2: Patients Directory -->
        <div class="tab-pane fade" id="patients" role="tabpanel">
            <div class="card sidebar-card border-0 p-3">
                <div class="d-flex justify-content-between mb-3">
                    <input type="text" class="form-control w-25" placeholder="Search Patient by name or phone...">
                </div>
                <div class="table-responsive">
                    <table class="table table-hover table-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Patient ID</th>
                                <th>Full Name</th>
                                <th>Phone Number</th>
                                <th>Email</th>
                                <th>Address</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>#P-001</strong></td>
                                <td>Saman Jayasinghe</td>
                                <td>0771234567</td>
                                <td>saman@gmail.com</td>
                                <td>Colombo 03</td>
                                <td class="text-end">
                                    <button class="btn btn-sm btn-outline-primary rounded-2 me-1"><i class="fa-solid fa-pen-to-square"></i> Edit</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tab 3: Billing & Payments -->
        <div class="tab-pane fade" id="billing" role="tabpanel">
            <div class="card sidebar-card border-0 p-3">
                <div class="table-responsive">
                    <table class="table table-hover table-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Invoice ID</th>
                                <th>Patient</th>
                                <th>Treatment</th>
                                <th>Amount (LKR)</th>
                                <th>Payment Status</th>
                                <th class="text-end">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>#INV-501</strong></td>
                                <td>Kamal Perera</td>
                                <td>Teeth Cleaning & Scaling</td>
                                <td>5,500.00</td>
                                <td><span class="badge bg-warning text-dark px-3 py-2 rounded-pill">Pending</span></td>
                                <td class="text-end">
                                    <button class="btn btn-sm btn-success rounded-2"><i class="fa-solid fa-dollar-sign"></i> Collect Payment</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Modal 1: Add Patient -->
<div class="modal fade" id="addPatientModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-header-title fw-bold"><i class="fa-solid fa-user-plus text-primary me-2"></i>Add New Patient</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="PatientServlet" method="POST">
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Full Name</label>
                        <input type="text" name="name" class="form-control rounded-3" required placeholder="e.g. Sunimal Silva">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Phone Number</label>
                        <input type="text" name="phone" class="form-control rounded-3" required placeholder="07X XXXXXXX">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email Address</label>
                        <input type="email" name="email" class="form-control rounded-3" placeholder="name@example.com">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Address</label>
                        <textarea name="address" class="form-control rounded-3" rows="2" placeholder="City or Address"></textarea>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary-custom">Save Patient</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal 2: Book Appointment -->
<div class="modal fade" id="bookAppointmentModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-header-title fw-bold"><i class="fa-solid fa-calendar-plus text-primary me-2"></i>Schedule Appointment</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="AppointmentServlet" method="POST">
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Patient ID</label>
                        <input type="number" name="patientId" class="form-control rounded-3" required placeholder="Enter Registered Patient ID">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Select Dentist</label>
                        <select name="dentistId" class="form-select rounded-3" required>
                            <option value="">-- Choose Dentist --</option>
                            <option value="1">Dr. Nishan Silva</option>
                            <option value="2">Dr. Keshani Perera</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Date & Time</label>
                        <input type="datetime-local" name="appointmentDate" class="form-control rounded-3" required>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary-custom">Confirm Booking</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal 3: Create Bill -->
<div class="modal fade" id="createBillModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-header-title fw-bold"><i class="fa-solid fa-file-invoice-dollar text-primary me-2"></i>Generate Bill</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="BillingServlet" method="POST">
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Appointment ID</label>
                        <input type="number" name="appointmentId" class="form-control rounded-3" required placeholder="Enter Appointment ID">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Total Amount (LKR)</label>
                        <input type="number" step="0.01" name="amount" class="form-control rounded-3" required placeholder="0.00">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Payment Status</label>
                        <select name="status" class="form-select rounded-3">
                            <option value="PENDING">Pending</option>
                            <option value="PAID">Paid</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success rounded-3">Generate Invoice</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>