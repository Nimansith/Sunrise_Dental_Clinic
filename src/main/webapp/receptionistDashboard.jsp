<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Models.User" %>
<%@ page import="Models.Appointment" %>
<%@ page import="Models.Bill" %>
<%@ page import="Models.Dentist" %>
<%@ page import="Models.Treatment" %>
<%@ page import="DAO.AppointmentDAO" %>
<%@ page import="DAO.BillDAO" %>
<%@ page import="DAO.DentistDAO" %>
<%@ page import="DAO.TreatmentDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    // Session Verification Guard
    String role = (String) session.getAttribute("role");
    String username = (String) session.getAttribute("username");

    if (role == null || !"RECEPTIONIST".equalsIgnoreCase(role)) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }

    // DAO Initialization
    AppointmentDAO appointmentDAO = new AppointmentDAO();
    BillDAO billDAO = new BillDAO();
    DentistDAO dentistDAO = new DentistDAO();
    TreatmentDAO treatmentDAO = new TreatmentDAO();

    // Fetch Data
    List<Appointment> appointmentList = appointmentDAO.getAllAppointments();
    List<Bill> billList = billDAO.getAllBills();
    List<Dentist> dentistList = dentistDAO.getAllDentists();
    List<Treatment> treatmentList = treatmentDAO.getAllTreatments();

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

    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
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
                <span class="d-block fw-bold text-dark"><%= role %></span>
                <small class="text-muted"><%= username %></small>
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
            <p class="text-muted mb-0">Manage appointments, doctors, and billing operations.</p>
        </div>
        <div class="d-flex gap-2 flex-wrap">
            <button class="btn btn-info text-white rounded-3 font-weight-semibold shadow-sm" data-bs-toggle="modal" data-bs-target="#registerDoctorModal">
                <i class="fa-solid fa-user-doctor me-1"></i> Register Doctor
            </button>
            <button class="btn btn-dark rounded-3 font-weight-semibold shadow-sm" data-bs-toggle="modal" data-bs-target="#bookAppointmentModal">
                <i class="fa-solid fa-calendar-plus me-1"></i> Book Appointment
            </button>
            <button class="btn btn-success rounded-3 font-weight-semibold shadow-sm" data-bs-toggle="modal" data-bs-target="#createBillModal">
                <i class="fa-solid fa-file-invoice-dollar me-1"></i> Create Bill
            </button>
        </div>
    </div>

    <!-- Alert Messages -->
    <% 
        String status = request.getParameter("status");
        if ("success".equals(status)) {
    %>
        <div class="alert alert-success alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i> Appointment booked successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("updated".equals(status)) { %>
        <div class="alert alert-info alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-pen-to-square me-2"></i> Appointment details updated successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("deleted".equals(status)) { %>
        <div class="alert alert-warning alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-trash-can me-2"></i> Appointment has been cancelled.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("bill_created".equals(status)) { %>
        <div class="alert alert-success alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-file-circle-check me-2"></i> Invoice generated successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("doctor_added".equals(status)) { %>
        <div class="alert alert-success alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-user-plus me-2"></i> Doctor registered successfully.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("error".equals(status)) { %>
        <div class="alert alert-danger alert-dismissible fade show rounded-3 border-0 shadow-sm mb-4" role="alert">
            <i class="fa-solid fa-circle-exclamation me-2"></i> An operation failed. Please check inputs and try again.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <!-- Quick Stats Overview Cards -->
    <div class="row g-3 mb-4">
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Total Appointments</span>
                    <h3 class="fw-bold mb-0"><%= (appointmentList != null) ? appointmentList.size() : 0 %></h3>
                </div>
                <div class="stat-icon bg-sky-light"><i class="fa-solid fa-calendar-check"></i></div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Registered Dentists</span>
                    <h3 class="fw-bold mb-0"><%= (dentistList != null) ? dentistList.size() : 0 %></h3>
                </div>
                <div class="stat-icon bg-teal-light"><i class="fa-solid fa-user-doctor"></i></div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Total Bills Generated</span>
                    <h3 class="fw-bold mb-0"><%= (billList != null) ? billList.size() : 0 %></h3>
                </div>
                <div class="stat-icon bg-amber-light"><i class="fa-solid fa-receipt"></i></div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Active System Status</span>
                    <h3 class="fw-bold mb-0 text-success">Online</h3>
                </div>
                <div class="stat-icon bg-purple-light"><i class="fa-solid fa-circle-nodes"></i></div>
            </div>
        </div>
    </div>

    <!-- Operations Tabs (Dentists List1st & Active) -->
    <ul class="nav nav-pills mb-4" id="dashboardTabs" role="tablist">
        <li class="nav-item">
            <button class="nav-link active" id="dentists-tab" data-bs-toggle="pill" data-bs-target="#dentists" type="button">
                <i class="fa-solid fa-user-doctor me-2"></i> Dentists List
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" id="appointments-tab" data-bs-toggle="pill" data-bs-target="#appointments" type="button">
                <i class="fa-regular fa-calendar-days me-2"></i> List Appointments
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
        
        <!-- Tab 1: Dentists List Table (Active Tab) -->
        <div class="tab-pane fade show active" id="dentists" role="tabpanel">
            <div class="card sidebar-card border-0 p-3">
                <div class="table-responsive">
                    <table class="table table-hover table-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Dentist ID</th>
                                <th>Doctor Name</th>
                                <th>Specialization</th>
                                <th>Contact Number</th>
                                <th>Email Address</th>
                                <th>Username</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                if (dentistList == null || dentistList.isEmpty()) { 
                            %>
                                <tr>
                                    <td colspan="7" class="text-center text-muted py-4">No dentists registered yet.</td>
                                </tr>
                            <% 
                                } else {
                                    int dentistIndex = 1; 
                                    for (Dentist d : dentistList) { 
                            %>
                                <tr>
                                    <td><strong>DOC-<%= dentistIndex++ %></strong></td>
                                    <td><strong><%= d.getDentistName() %></strong></td>
                                    <td><span class="badge bg-info text-white px-2 py-1"><%= d.getSpecialization() %></span></td>
                                    <td><%= d.getContactNumber() %></td>
                                    <td><a href="mailto:<%= d.getEmail() %>" class="text-decoration-none text-muted"><%= d.getEmail() %></a></td>
                                    <td><span class="badge bg-light text-dark border"><%= (d.getUsername() != null && !d.getUsername().isEmpty()) ? d.getUsername() : "N/A" %></span></td>
                                    <td class="text-end">
                                        <button class="btn btn-sm btn-outline-primary rounded-2 me-1" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#editDoctorModal<%= d.getDentistId() %>" title="Edit">
                                            <i class="fa-solid fa-pen-to-square"></i>
                                        </button>
                                        
                                        <form action="ManageDentistServlet" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to remove this dentist?');">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="dentistId" value="<%= d.getDentistId() %>">
                                            <button type="submit" class="btn btn-sm btn-outline-danger rounded-2" title="Delete">
                                                <i class="fa-solid fa-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>

                                <!-- Edit Doctor Modal -->
                                <div class="modal fade" id="editDoctorModal<%= d.getDentistId() %>" tabindex="-1">
                                    <div class="modal-dialog modal-dialog-centered modal-lg">
                                        <div class="modal-content rounded-4 border-0">
                                            <div class="modal-header border-0 pb-0">
                                                <h5 class="modal-header-title fw-bold">
                                                    <i class="fa-solid fa-user-doctor text-info me-2"></i>Edit Doctor Details
                                                </h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                            </div>
                                            <form action="ManageDentistServlet" method="POST" autocomplete="off">
                                                <input type="hidden" name="action" value="update">
                                                <input type="hidden" name="dentistId" value="<%= d.getDentistId() %>">
                                                
                                                <div class="modal-body py-4">
                                                    <div class="row g-3">
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Doctor Name</label>
                                                            <input type="text" name="dentistName" class="form-control rounded-3" value="<%= d.getDentistName() %>" required>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Specialization</label>
                                                            <input type="text" name="specialization" class="form-control rounded-3" value="<%= d.getSpecialization() %>" required>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Contact Number</label>
                                                            <input type="tel" name="contactNumber" class="form-control rounded-3" value="<%= d.getContactNumber() %>" required>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Email Address</label>
                                                            <input type="email" name="email" class="form-control rounded-3" value="<%= d.getEmail() %>" required>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">Username</label>
                                                            <input type="text" name="username" class="form-control rounded-3" value="<%= d.getUsername() %>" required>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <label class="form-label fw-semibold">New Password (Optional)</label>
                                                            <input type="password" name="password" class="form-control rounded-3" placeholder="Leave blank to keep current" autocomplete="new-password">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="modal-footer border-0 pt-0">
                                                    <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Cancel</button>
                                                    <button type="submit" class="btn btn-info text-white rounded-3 fw-semibold">Update Doctor</button>
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

        <!-- Tab 2: Appointments List -->
<div class="tab-pane fade" id="appointments" role="tabpanel">
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
                        <th>Status</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        if (appointmentList == null || appointmentList.isEmpty()) { 
                    %>
                        <tr>
                            <td colspan="8" class="text-center text-muted py-4">No appointments booked yet.</td>
                        </tr>
                    <% 
                        } else {
                            for (Appointment a : appointmentList) { 
                                String rawDate = (a.getAppointmentDateTime() != null) ? a.getAppointmentDateTime().toString().replace(" ", "T").substring(0, 16) : "";
                                
                                String dName = "Doctor #" + a.getDentistId();
                                if (dentistList != null) {
                                    for (Dentist d : dentistList) {
                                        if (d.getDentistId() == a.getDentistId()) {
                                            dName = d.getDentistName();
                                            break;
                                        }
                                    }
                                }

                                String tName = "Treatment #" + a.getTreatmentId();
                                if (treatmentList != null) {
                                    for (Treatment t : treatmentList) {
                                        if (t.getTreatmentId() == a.getTreatmentId()) {
                                            tName = t.getTreatmentName();
                                            break;
                                        }
                                    }
                                }

                                // Status Badge Styling Logic
                                String statusBadge = "bg-secondary";
                                String currentStatus = (a.getStatus() != null) ? a.getStatus().toUpperCase() : "PENDING";
                                
                                if ("ACCEPTED".equals(currentStatus)) {
                                    statusBadge = "bg-primary";
                                } else if ("COMPLETED".equals(currentStatus)) {
                                    statusBadge = "bg-success";
                                } else if ("CANCELLED".equals(currentStatus)) {
                                    statusBadge = "bg-danger";
                                } else if ("PENDING".equals(currentStatus)) {
                                    statusBadge = "bg-warning text-dark";
                                }
                    %>
                        <tr>
                            <td><strong>APT-<%= a.getAppointmentId() %></strong></td>
                            <td>
                                <strong><%= a.getPatientName() %></strong><br>
                                <small class="text-muted"><%= a.getAddress() %></small>
                            </td>
                            <td><%= a.getContactNumber() %></td>
                            <td><%= dName %></td>
                            <td><span class="badge bg-light text-dark border px-2 py-1"><%= tName %></span></td>
                            <td><%= (a.getAppointmentDateTime() != null) ? dateFormat.format(a.getAppointmentDateTime()) : "N/A" %></td>
                            <td><span class="badge <%= statusBadge %> px-2 py-1"><%= currentStatus %></span></td>
                            
                            <td class="text-end">
                                <button class="btn btn-sm btn-outline-primary rounded-2 me-1" 
                                        data-bs-toggle="modal" 
                                        data-bs-target="#editModal<%= a.getAppointmentId() %>" title="Edit">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </button>
                                
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
                                        <h5 class="modal-header-title fw-bold"><i class="fa-solid fa-pen-to-square text-primary me-2"></i>Edit Appointment APT-<%= a.getAppointmentId() %></h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <form action="ManageAppointmentServlet" method="POST" class="needs-validation" novalidate>
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="appointmentId" value="<%= a.getAppointmentId() %>">
                                        <div class="modal-body py-4">
                                            <div class="row g-3">
                                                <div class="col-md-6">
                                                    <label class="form-label fw-semibold">Patient Name</label>
                                                    <input type="text" name="patientName" class="form-control rounded-3" value="<%= a.getPatientName() %>" minlength="3" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label fw-semibold">Contact Number</label>
                                                    <input type="tel" name="contactNumber" class="form-control rounded-3" value="<%= a.getContactNumber() %>" pattern="0[0-9]{9}" maxlength="10" required>
                                                </div>
                                                <div class="col-12">
                                                    <label class="form-label fw-semibold">Address</label>
                                                    <input type="text" name="address" class="form-control rounded-3" value="<%= a.getAddress() %>" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label fw-semibold">Assigned Dentist</label>
                                                    <select name="dentistId" class="form-select rounded-3" required>
                                                        <% 
                                                            if (dentistList != null && !dentistList.isEmpty()) {
                                                                for (Dentist d : dentistList) {
                                                        %>
                                                            <option value="<%= d.getDentistId() %>" <%= (d.getDentistId() == a.getDentistId()) ? "selected" : "" %>><%= d.getDentistName() %></option>
                                                        <% 
                                                                }
                                                            } 
                                                        %>
                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label fw-semibold">Treatment</label>
                                                    <select name="treatmentId" class="form-select rounded-3" required>
                                                        <% 
                                                            if (treatmentList != null && !treatmentList.isEmpty()) {
                                                                for (Treatment t : treatmentList) {
                                                        %>
                                                            <option value="<%= t.getTreatmentId() %>" <%= (t.getTreatmentId() == a.getTreatmentId()) ? "selected" : "" %>><%= t.getTreatmentName() %></option>
                                                        <% 
                                                                }
                                                            } 
                                                        %>
                                                    </select>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label fw-semibold">Date & Time</label>
                                                    <input type="datetime-local" name="appointmentDateTime" class="form-control rounded-3 datetime-picker" value="<%= rawDate %>" required>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="form-label fw-semibold">Appointment Status</label>
                                                    <select name="status" class="form-select rounded-3" required>
                                                        <option value="PENDING" <%= "PENDING".equals(currentStatus) ? "selected" : "" %>>PENDING</option>
                                                        <option value="ACCEPTED" <%= "ACCEPTED".equals(currentStatus) ? "selected" : "" %>>ACCEPTED</option>
                                                        <option value="COMPLETED" <%= "COMPLETED".equals(currentStatus) ? "selected" : "" %>>COMPLETED</option>
                                                        <option value="CANCELLED" <%= "CANCELLED".equals(currentStatus) ? "selected" : "" %>>CANCELLED</option>
                                                    </select>
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

        <!-- Tab 3: Billing & Payments List -->
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
                                    <td><span class="badge bg-light text-dark border"><%= b.getTreatmentName() %></span></td>
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

<!-- Modal 0: Register Doctor Modal -->
<div class="modal fade" id="registerDoctorModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-header-title fw-bold"><i class="fa-solid fa-user-doctor text-info me-2"></i>Register New Doctor</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            
            <form action="RegisterDentistServlet" method="POST" class="needs-validation" autocomplete="off" novalidate>
                <input type="text" style="display:none" aria-hidden="true">
                <input type="password" style="display:none" aria-hidden="true">

                <div class="modal-body py-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Doctor Name</label>
                            <input type="text" name="dentistName" class="form-control rounded-3" placeholder="e.g. Dr. Nimal Perera" minlength="3" required>
                            <div class="invalid-feedback">Please enter doctor's name (at least 3 characters).</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Specialization</label>
                            <input type="text" name="specialization" class="form-control rounded-3" placeholder="e.g. Orthodontics, Cosmetic" required>
                            <div class="invalid-feedback">Specialization is required.</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Contact Number</label>
                            <input type="tel" name="contactNumber" class="form-control rounded-3" placeholder="07XXXXXXXX" pattern="0[0-9]{9}" maxlength="10" required>
                            <div class="invalid-feedback">Must be a valid 10-digit phone number.</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Email Address</label>
                            <input type="email" name="email" class="form-control rounded-3" placeholder="doctor@example.com" required>
                            <div class="invalid-feedback">Please provide a valid email address.</div>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Login Username</label>
                            <input type="text" name="username" class="form-control rounded-3" placeholder="e.g. drnimal" autocomplete="new-password" required>
                            <div class="invalid-feedback">Username is required for doctor login.</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Login Password</label>
                            <input type="password" name="password" class="form-control rounded-3" placeholder="••••••••" minlength="4" autocomplete="new-password" required>
                            <div class="invalid-feedback">Password must be at least 4 characters.</div>
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
            <form action="AppointmentServlet" method="POST" class="needs-validation" novalidate>
                <div class="modal-body py-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Patient Name</label>
                            <input type="text" name="patientName" class="form-control rounded-3" placeholder="Full Name" minlength="3" required>
                            <div class="invalid-feedback">Patient name must contain at least 3 characters.</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Contact Number</label>
                            <input type="tel" name="contactNumber" class="form-control rounded-3" placeholder="07XXXXXXXX" pattern="0[0-9]{9}" maxlength="10" required>
                            <div class="invalid-feedback">Must be a valid 10-digit number.</div>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Address</label>
                            <input type="text" name="address" class="form-control rounded-3" placeholder="Patient Address" required>
                            <div class="invalid-feedback">Address is required.</div>
                        </div>
                        
                        <!-- Assigned Dentist Select -->
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Assigned Dentist</label>
                            <select name="dentistId" id="bookingDentistSelect" class="form-select rounded-3" required>
                                <option value="" data-specialization="">-- Select Dentist --</option>
                                <% 
                                    if (dentistList != null && !dentistList.isEmpty()) {
                                        for (Dentist d : dentistList) {
                                %>
                                    <option value="<%= d.getDentistId() %>" data-specialization="<%= d.getSpecialization() != null ? d.getSpecialization().toLowerCase().trim() : "" %>">
                                        <%= d.getDentistName() %> (<%= d.getSpecialization() %>)
                                    </option>
                                <% 
                                        }
                                    } 
                                %>
                            </select>
                            <div class="invalid-feedback">Please choose a dentist.</div>
                        </div>
                        
                        <!-- Treatment Type Select -->
<div class="col-md-6">
    <label class="form-label fw-semibold">Treatment Type</label>
    <select name="treatmentId" id="bookingTreatmentSelect" class="form-select rounded-3" required>
        <option value="">-- Select Treatment --</option>
        <% 
            if (treatmentList != null && !treatmentList.isEmpty()) {
                for (Treatment t : treatmentList) {
        %>
            <option value="<%= t.getTreatmentId() %>">
                <%= t.getTreatmentName() %>
            </option>
        <% 
                }
            } 
        %>
    </select>
    <div class="invalid-feedback">Please choose a treatment.</div>
</div>
                        
                        <div class="col-12">
                            <label class="form-label fw-semibold">Date & Time</label>
                            <input type="datetime-local" name="appointmentDateTime" class="form-control rounded-3 datetime-picker" required>
                            <div class="invalid-feedback">Please select a valid date and time.</div>
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
            <form action="BillingServlet" method="POST" class="needs-validation" novalidate>
                <div class="modal-body py-4">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Appointment ID <span class="text-danger">*</span></label>
                        <input type="number" name="appointmentId" class="form-control rounded-3" min="1" required placeholder="e.g. 1">
                        <div class="invalid-feedback">Enter a valid positive Appointment ID.</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Consultation Fee (LKR) <span class="text-danger">*</span></label>
                        <input type="number" step="0.01" min="0" name="consultationFee" class="form-control rounded-3" required placeholder="1000.00">
                        <div class="invalid-feedback">Consultation fee cannot be negative.</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Treatment Cost (LKR) <span class="text-danger">*</span></label>
                        <input type="number" step="0.01" min="0" name="treatmentCost" class="form-control rounded-3" required placeholder="3500.00">
                        <div class="invalid-feedback">Treatment cost cannot be negative.</div>
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

<!-- Scripts -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Date & Time Picker Validation
        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const day = String(now.getDate()).padStart(2, '0');
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const currentDateTime = `${year}-${month}-${day}T${hours}:${minutes}`;

        document.querySelectorAll('.datetime-picker').forEach(input => {
            input.min = currentDateTime;
        });

        // Form Validation
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    });

    // Clean URL query parameters after alert display
    if (window.history.replaceState) {
        const url = new URL(window.location.href);
        if (url.searchParams.has('status')) {
            url.searchParams.delete('status');
            window.history.replaceState({}, document.title, url.pathname);
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const day = String(now.getDate()).padStart(2, '0');
        const hours = String(now.getHours()).padStart(2, '0');
        const minutes = String(now.getMinutes()).padStart(2, '0');
        const currentDateTime = `${year}-${month}-${day}T${hours}:${minutes}`;

        document.querySelectorAll('.datetime-picker').forEach(input => {
            input.min = currentDateTime;
        });

        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    });

    if (window.history.replaceState) {
        const url = new URL(window.location.href);
        if (url.searchParams.has('status')) {
            url.searchParams.delete('status');
            window.history.replaceState({}, document.title, url.pathname);
        }
    }
</script>

</body>
</html>