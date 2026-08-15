<%-- 
    Document   : receptionistDashboard
    Created on : Aug 15, 2026
    Author     : Rusanda Nimansith
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.User" %>
<%@ page import="Models.Appointment" %>
<%@ page import="Models.Bill" %>
<%@ page import="dao.AppointmentDAO" %>
<%@ page import="dao.BillDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Session Verification Guard
    User user = (User) session.getAttribute("user");
    if (user == null || !"RECEPTIONIST".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    // DAO Initialization
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    BillDAO billDAO = new BillDAO();

    // Fetch Data
    List<Appointment> appointmentList = appointmentDAO.getAllAppointments();
    List<Bill> billList = billDAO.getAllBills();

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
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
    </style>
</head>
<body>

<!-- Navigation Bar -->
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

    <!-- Header Actions & Quick Buttons -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 gap-3">
        <div>
            <h3 class="fw-bold mb-1">Receptionist Dashboard</h3>
            <p class="text-muted mb-0">Manage appointments and billing operations.</p>
        </div>
        <div class="d-flex gap-2 flex-wrap">
            <!-- Register Doctor Button (Book Appointment එකට වම් පසින්) -->
            <button class="btn btn-info text-white rounded-3 font-weight-semibold shadow-sm" data-bs-toggle="modal" data-bs-target="#registerDoctorModal">
                <i class="fa-solid fa-user-doctor me-1"></i> Register Doctor
            </button>
            
            <!-- Book Appointment Button -->
            <button class="btn btn-dark rounded-3 font-weight-semibold shadow-sm" data-bs-toggle="modal" data-bs-target="#bookAppointmentModal">
                <i class="fa-solid fa-calendar-plus me-1"></i> Book Appointment
            </button>
            
            <!-- Create Bill Button -->
            <button class="btn btn-success rounded-3 font-weight-semibold shadow-sm" data-bs-toggle="modal" data-bs-target="#createBillModal">
                <i class="fa-solid fa-file-invoice-dollar me-1"></i> Create Bill
            </button>
        </div>
    </div>

    <!-- Alert Messages (Notifications) -->
    <% 
        String status = request.getParameter("status");
        if ("success".equals(status)) {
    %>
        <div class="alert alert-success alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i> <strong>Success!</strong> Appointment booked successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("updated".equals(status)) { %>
        <div class="alert alert-info alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-pen-to-square me-2"></i> <strong>Updated!</strong> Appointment details updated successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("deleted".equals(status)) { %>
        <div class="alert alert-warning alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-trash-can me-2"></i> <strong>Cancelled!</strong> Appointment has been cancelled.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("bill_created".equals(status)) { %>
        <div class="alert alert-success alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-file-circle-check me-2"></i> <strong>Success!</strong> Invoice generated successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("doctor_added".equals(status)) { %>
        <div class="alert alert-success alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-user-plus me-2"></i> <strong>Success!</strong> Doctor registered successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("error".equals(status)) { %>
        <div class="alert alert-danger alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-circle-exclamation me-2"></i> <strong>Error!</strong> An operation failed. Please check inputs and try again.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <!-- Quick Stats Overview Cards -->
    <div class="row g-3 mb-4">
        <div class="col-12 col-sm-6 col-xl-4">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Total Appointments</span>
                    <h3 class="fw-bold mb-0"><%= (appointmentList != null) ? appointmentList.size() : 0 %></h3>
                </div>
                <div class="stat-icon bg-sky-light">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-4">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Total Bills Generated</span>
                    <h3 class="fw-bold mb-0"><%= (billList != null) ? billList.size() : 0 %></h3>
                </div>
                <div class="stat-icon bg-amber-light">
                    <i class="fa-solid fa-receipt"></i>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-4">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Active System Status</span>
                    <h3 class="fw-bold mb-0 text-success">Online</h3>
                </div>
                <div class="stat-icon bg-purple-light">
                    <i class="fa-solid fa-circle-nodes"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Operations Tabs -->
    <ul class="nav nav-pills mb-4" id="dashboardTabs" role="tablist">
        <li class="nav-item">
            <button class="nav-link active" id="appointments-tab" data-bs-toggle="pill" data-bs-target="#appointments" type="button">
                <i class="fa-regular fa-calendar-days me-2"></i> Appointments
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" id="billing-tab" data-bs-toggle="pill" data-bs-target="#billing" type="button">
                <i class="fa-solid fa-receipt me-2"></i> Billing & Payments
            </button>
        </li>
    </ul>

    <!-- Tab Content -->
    <div class="tab-content" id="dashboardTabContent">
        
        <!-- Tab 1: Appointments List -->
        <div class="tab-pane fade show active" id="appointments" role="tabpanel">
            <div class="card sidebar-card border-0 p-3">
                <div class="table-responsive">
                    <table class="table table-hover table-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Appt ID</th>
                                <th>Patient Name</th>
                                <th>Contact</th>
                                <th>Dentist Name</th>
                                <th>Treatment</th>
                                <th>Date & Time</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                if (appointmentList == null || appointmentList.isEmpty()) { 
                            %>
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">No appointments booked yet.</td>
                                </tr>
                            <% 
                                } else {
                                    for (Appointment a : appointmentList) { 
                                        String rawDate = (a.getAppointmentDateTime() != null) ? a.getAppointmentDateTime().toString().replace(" ", "T").substring(0, 16) : "";
                            %>
                                <tr>
                                    <td><strong>#APT-<%= a.getAppointmentId() %></strong></td>
                                    <td>
                                        <strong><%= a.getPatientName() %></strong><br>
                                        <small class="text-muted"><%= a.getAddress() %></small>
                                    </td>
                                    <td><%= a.getContactNumber() %></td>
                                    <td><%= a.getDentistName() %></td>
                                    <td><span class="badge bg-light text-dark border px-2 py-1"><%= a.getTreatmentType() %></span></td>
                                    <td><%= (a.getAppointmentDateTime() != null) ? dateFormat.format(a.getAppointmentDateTime()) : "N/A" %></td>
                                    <td class="text-end">
                                        <!-- Edit Button -->
                                        <button class="btn btn-sm btn-outline-primary rounded-2 me-1" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#editModal<%= a.getAppointmentId() %>" title="Edit">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </button>
                                        
                                        <!-- Cancel/Delete Form -->
                                        <form action="ManageAppointmentServlet" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to cancel this appointment?');">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="appointmentId" value="<%= a.getAppointmentId() %>">
                                            <button type="submit" class="btn btn-sm btn-outline-danger rounded-2" title="Cancel">
                                                <i class="fa-solid fa-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>

                                <!-- Edit Appointment Modal -->
                                <div class="modal fade" id="editModal<%= a.getAppointmentId() %>" tabindex="-1">
                                    <div class="modal-dialog modal-dialog-centered modal-lg">
                                        <div class="modal-content rounded-4 border-0">
                                            <div class="modal-header border-0 pb-0">
                                                <h5 class="modal-header-title fw-bold"><i class="fa-solid fa-pen-to-square text-primary me-2"></i>Edit Appointment #APT-<%= a.getAppointmentId() %></h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <form action="ManageAppointmentServlet" method="POST">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="appointmentId" value="<%= a.getAppointmentId() %>">
                                                <div class="modal-body py-4">
                                                    <div class="row g-3">
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Patient Name</label>
                                                            <input type="text" name="patientName" class="form-control rounded-3" value="<%= a.getPatientName() %>" required>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Contact Number</label>
                                                            <input type="text" name="contactNumber" class="form-control rounded-3" value="<%= a.getContactNumber() %>" required>
                                                        </div>
                                                        <div class="col-12">
                                                            <label class="form-label fw-semibold">Address</label>
                                                            <input type="text" name="address" class="form-control rounded-3" value="<%= a.getAddress() %>" required>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Assigned Dentist</label>
                                                            <select name="dentistName" class="form-select rounded-3" required>
                                                                <option value="Dr. Nishan Silva" <%= "Dr. Nishan Silva".equals(a.getDentistName()) ? "selected" : "" %>>Dr. Nishan Silva</option>
                                                                <option value="Dr. Keshani Perera" <%= "Dr. Keshani Perera".equals(a.getDentistName()) ? "selected" : "" %>>Dr. Keshani Perera</option>
                                                                <option value="Dr. Amal Fernando" <%= "Dr. Amal Fernando".equals(a.getDentistName()) ? "selected" : "" %>>Dr. Amal Fernando</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Treatment Type</label>
                                                            <input type="text" name="treatmentType" class="form-control rounded-3" value="<%= a.getTreatmentType() %>" required>
                                                        </div>
                                                        <div class="col-12">
                                                            <label class="form-label fw-semibold">Date & Time</label>
                                                            <input type="datetime-local" name="appointmentDateTime" class="form-control rounded-3" value="<%= rawDate %>" required>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer border-0 pt-0">
                                                    <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Cancel</button>
                                                    <button type="submit" class="btn btn-primary-custom">Save Changes</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            <%  
                                    }
                                } 
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tab 2: Billing & Payments List -->
        <div class="tab-pane fade" id="billing" role="tabpanel">
            <div class="card sidebar-card border-0 p-3">
                <div class="table-responsive">
                    <table class="table table-hover table-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Bill ID</th>
                                <th>Appointment</th>
                                <th>Patient Name</th>
                                <th>Treatment</th>
                                <th>Consultation Fee</th>
                                <th>Treatment Cost</th>
                                <th>Total Amount</th>
                                <th>Bill Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                if (billList == null || billList.isEmpty()) { 
                            %>
                                <tr>
                                    <td colspan="8" class="text-center text-muted py-4">No bills created yet.</td>
                                </tr>
                            <% 
                                } else {
                                    for (Bill b : billList) { 
                            %>
                                <tr>
                                    <td><strong>#BILL-<%= b.getBillId() %></strong></td>
                                    <td>#APT-<%= b.getAppointmentId() %></td>
                                    <td><strong><%= b.getPatientName() %></strong></td>
                                    <td><span class="badge bg-light text-dark border"><%= b.getTreatmentType() %></span></td>
                                    <td>Rs. <%= String.format("%.2f", b.getConsultationFee()) %></td>
                                    <td>Rs. <%= String.format("%.2f", b.getTreatmentCost()) %></td>
                                    <td><strong class="text-success">Rs. <%= String.format("%.2f", b.getTotalAmount()) %></strong></td>
                                    <td><small class="text-muted"><%= b.getBillDate() %></small></td>
                                </tr>
                            <% 
                                    }
                                } 
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Modal 0: Register Doctor Modal (නව Modal එක) -->
<div class="modal fade" id="registerDoctorModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-header-title fw-bold"><i class="fa-solid fa-user-doctor text-info me-2"></i>Register New Doctor</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="DoctorServlet" method="POST">
                <div class="modal-body py-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Doctor Name <span class="text-danger">*</span></label>
                            <input type="text" name="dentistName" class="form-control rounded-3" placeholder="e.g. Dr. Nimal Perera" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Specialization <span class="text-danger">*</span></label>
                            <input type="text" name="specialization" class="form-control rounded-3" placeholder="e.g. Orthodontics, Cosmetic" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Contact Number <span class="text-danger">*</span></label>
                            <input type="text" name="contactNumber" class="form-control rounded-3" placeholder="07XXXXXXXX" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Email Address <span class="text-danger">*</span></label>
                            <input type="email" name="email" class="form-control rounded-3" placeholder="doctor@example.com" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-info text-white rounded-3 fw-semibold">Register Doctor</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Modal 1: Book Appointment -->
<div class="modal fade" id="bookAppointmentModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-header-title fw-bold"><i class="fa-solid fa-calendar-plus text-primary me-2"></i>Schedule Appointment</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="AppointmentServlet" method="POST">
                <div class="modal-body py-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Patient Name <span class="text-danger">*</span></label>
                            <input type="text" name="patientName" class="form-control rounded-3" placeholder="Full Name" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Contact Number <span class="text-danger">*</span></label>
                            <input type="text" name="contactNumber" class="form-control rounded-3" placeholder="07XXXXXXXX" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Address <span class="text-danger">*</span></label>
                            <input type="text" name="address" class="form-control rounded-3" placeholder="Patient Address" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Assigned Dentist <span class="text-danger">*</span></label>
                            <select name="dentistName" class="form-select rounded-3" required>
                                <option value="">-- Select Dentist --</option>
                                <option value="Dr. Nishan Silva">Dr. Nishan Silva</option>
                                <option value="Dr. Keshani Perera">Dr. Keshani Perera</option>
                                <option value="Dr. Amal Fernando">Dr. Amal Fernando</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Treatment Type <span class="text-danger">*</span></label>
                            <input type="text" name="treatmentType" class="form-control rounded-3" placeholder="e.g. Scaling, Root Canal, Checkup" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Date & Time <span class="text-danger">*</span></label>
                            <input type="datetime-local" name="appointmentDateTime" class="form-control rounded-3" required>
                        </div>
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

<!-- Modal 2: Create Bill -->
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
                        <label class="form-label fw-semibold">Appointment ID <span class="text-danger">*</span></label>
                        <input type="number" name="appointmentId" class="form-control rounded-3" required placeholder="e.g. 1">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Consultation Fee (LKR) <span class="text-danger">*</span></label>
                        <input type="number" step="0.01" name="consultationFee" class="form-control rounded-3" required placeholder="1000.00">
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Treatment Cost (LKR) <span class="text-danger">*</span></label>
                        <input type="number" step="0.01" name="treatmentCost" class="form-control rounded-3" required placeholder="3500.00">
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success rounded-3">Generate Bill</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>