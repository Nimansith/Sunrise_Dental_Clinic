<%-- 
    Document   : dentistDashboard
    Created on : Aug 14, 2026
    Author     : Rusanda Nimansith
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.User"%>
<%
    // Session Verification Guard
    User user = (User) session.getAttribute("user");
    if (user == null || !"DENTIST".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp?error=unauthorized");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dentist Portal - Sunrise Dental Clinic</title>
    
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
            padding: 8px 16px;
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
    </style>
</head>
<body>

<!-- Top Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom sticky-top py-3">
    <div class="container-fluid px-4">
        <a class="navbar-brand navbar-brand-custom d-flex align-items-center" href="#">
            <i class="fa-solid fa-tooth me-2"></i> Sunrise Dental - Dentist Portal
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
    <% if ("record_saved".equals(request.getParameter("status"))) { %>
        <div class="alert alert-success alert-dismissible fade show rounded-3 mb-4" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i> Treatment record saved successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } else if ("error".equals(request.getParameter("status"))) { %>
        <div class="alert alert-danger alert-dismissible fade show rounded-3 mb-4" role="alert">
            <i class="fa-solid fa-circle-exclamation me-2"></i> An error occurred while processing the record.
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    <% } %>

    <!-- Header Summary -->
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4">
        <div>
            <h3 class="fw-bold mb-1">Doctor's Workbench</h3>
            <p class="text-muted mb-0">View scheduled appointments and record patient treatment details.</p>
        </div>
    </div>

    <!-- Quick Stats Cards -->
    <div class="row g-3 mb-4">
        <div class="col-12 col-md-4">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Today's Appointments</span>
                    <h3 class="fw-bold mb-0">8</h3>
                </div>
                <div class="stat-icon bg-sky-light">
                    <i class="fa-solid fa-calendar-day"></i>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-4">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Completed Today</span>
                    <h3 class="fw-bold mb-0">3</h3>
                </div>
                <div class="stat-icon bg-green-light">
                    <i class="fa-solid fa-check-double"></i>
                </div>
            </div>
        </div>
        <div class="col-12 col-md-4">
            <div class="stat-card d-flex align-items-center justify-content-between">
                <div>
                    <span class="text-muted small fw-semibold d-block mb-1">Pending Patients</span>
                    <h3 class="fw-bold mb-0">5</h3>
                </div>
                <div class="stat-icon bg-amber-light">
                    <i class="fa-solid fa-user-clock"></i>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content Tabs -->
    <ul class="nav nav-pills mb-4" id="dentistTabs" role="tablist">
        <li class="nav-item">
            <button class="nav-link active" id="today-tab" data-bs-toggle="pill" data-bs-target="#today" type="button">
                <i class="fa-solid fa-list-check me-2"></i> Today's Schedule
            </button>
        </li>
        <li class="nav-item">
            <button class="nav-link" id="records-tab" data-bs-toggle="pill" data-bs-target="#records" type="button">
                <i class="fa-solid fa-notes-medical me-2"></i> Treatment History
            </button>
        </li>
    </ul>

    <div class="tab-content" id="dentistTabContent">

        <!-- Tab 1: Today's Appointments Schedule -->
        <div class="tab-pane fade show active" id="today" role="tabpanel">
            <div class="card card-custom p-3 border-0">
                <div class="table-responsive">
                    <table class="table table-hover table-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Appt No</th>
                                <th>Patient Name</th>
                                <th>Requested Treatment</th>
                                <th>Time</th>
                                <th>Status</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>#APT-101</strong></td>
                                <td>Kamal Perera</td>
                                <td>Root Canal Treatment</td>
                                <td>10:30 AM</td>
                                <td><span class="badge badge-scheduled px-3 py-2 rounded-pill">Scheduled</span></td>
                                <td class="text-end">
                                    <button class="btn btn-sm btn-primary-custom shadow-sm me-1 btn-add-record" 
                                            data-bs-toggle="modal" 
                                            data-bs-target="#addRecordModal"
                                            data-appt-id="101"
                                            data-patient-id="1"
                                            data-patient-name="Kamal Perera">
                                        <i class="fa-solid fa-notes-medical me-1"></i> Add Record
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>#APT-102</strong></td>
                                <td>Nimali Fernando</td>
                                <td>Teeth Whitening</td>
                                <td>11:15 AM</td>
                                <td><span class="badge badge-completed px-3 py-2 rounded-pill">Completed</span></td>
                                <td class="text-end">
                                    <button class="btn btn-sm btn-outline-secondary rounded-2">
                                        <i class="fa-solid fa-eye me-1"></i> View Record
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Tab 2: Treatment Records History -->
        <div class="tab-pane fade" id="records" role="tabpanel">
            <div class="card card-custom p-3 border-0">
                <div class="d-flex justify-content-between mb-3">
                    <input type="text" id="searchInput" class="form-control w-25" placeholder="Search by Patient name or Appt ID...">
                </div>
                <div class="table-responsive">
                    <table class="table table-hover table-custom align-middle mb-0">
                        <thead>
                            <tr>
                                <th>Record ID</th>
                                <th>Appt No</th>
                                <th>Patient Name</th>
                                <th>Diagnosis</th>
                                <th>Follow-up Date</th>
                                <th class="text-end">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><strong>#REC-301</strong></td>
                                <td>#APT-102</td>
                                <td>Nimali Fernando</td>
                                <td>Mild Enamel Staining</td>
                                <td>2026-09-15</td>
                                <td class="text-end">
                                    <button class="btn btn-sm btn-outline-primary rounded-2" 
        onclick="openPrintModal('APT-102', 'Nimali Fernando', 'Mild Enamel Staining', 'Amoxicillin 500mg - 1bd x 5 days')">
    <i class="fa-solid fa-print"></i> Print Prescription
</button>
                                    
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Modal: Add Treatment Record -->
<div class="modal fade" id="addRecordModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title fw-bold"><i class="fa-solid fa-notes-medical text-primary me-2"></i>Add Patient Treatment Record</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="TreatmentRecordServlet" method="POST">
                <div class="modal-body py-4">
                    <input type="hidden" name="appointmentId" id="modalApptId">
                    <input type="hidden" name="patientId" id="modalPatientId">
                    <input type="hidden" name="dentistId" value="<%= user.getUserId() != 0 ? user.getUserId() : 1 %>">

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Patient Name</label>
                            <input type="text" id="modalPatientName" class="form-control bg-light rounded-3" readonly>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Follow-up Date (Optional)</label>
                            <input type="date" name="followUpDate" class="form-control rounded-3">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Diagnosis / Observations</label>
                        <textarea name="diagnosis" class="form-control rounded-3" rows="2" placeholder="e.g. Tooth cavity in upper right molar..." required></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Notes</label>
                        <textarea name="treatmentNotes" class="form-control rounded-3" rows="3" placeholder="e.g. Performed composite filling and scaling..." required></textarea>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Medication Details</label>
                        <textarea name="prescription" class="form-control rounded-3" rows="2" placeholder="e.g. Amoxicillin 500mg - 1bd x 5 days..."></textarea>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary-custom"><i class="fa-solid fa-floppy-disk me-1"></i> Save Medical Record</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Populate modal inputs dynamically when clicking "Add Record"
    document.addEventListener('DOMContentLoaded', function () {
        const addRecordModal = document.getElementById('addRecordModal');
        addRecordModal.addEventListener('show.bs.modal', function (event) {
            const button = event.relatedTarget;
            
            const apptId = button.getAttribute('data-appt-id');
            const patientId = button.getAttribute('data-patient-id');
            const patientName = button.getAttribute('data-patient-name');

            document.getElementById('modalApptId').value = apptId;
            document.getElementById('modalPatientId').value = patientId;
            document.getElementById('modalPatientName').value = patientName;
        });
    });
</script>
<!-- Modal: View & Print Prescription -->
<div class="modal fade" id="viewPrescriptionModal" tabindex="-1">
    <div class="modal-dialog modal-md modal-dialog-centered">
        <div class="modal-content rounded-4 border-0">
            <div class="modal-body p-4" id="printablePrescription">
                <!-- Prescription Header -->
                <div class="text-center border-bottom pb-3 mb-3">
                    <h4 class="fw-bold text-primary mb-1"><i class="fa-solid fa-tooth me-2"></i>Sunrise Dental Clinic</h4>
                    <p class="text-muted small mb-0">Medical Prescription & Treatment Summary</p>
                </div>

                <!-- Details -->
                <div class="row g-2 mb-3 small">
                    <div class="col-6"><strong>Patient:</strong> <span id="pName">-</span></div>
                    <div class="col-6 text-end"><strong>Appt ID:</strong> #<span id="pApptId">-</span></div>
                    <div class="col-6"><strong>Date:</strong> <span id="pDate"><%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %></span></div>
                    <div class="col-6 text-end"><strong>Doctor ID:</strong> <span id="pDoctor"><%= user.getUserId() %></span></div>
                </div>

                <div class="border rounded-3 p-3 bg-light mb-3">
                    <h6 class="fw-bold text-dark mb-1">Diagnosis</h6>
                    <p class="small text-muted mb-0" id="pDiagnosis">-</p>
                </div>

                <div class="border rounded-3 p-3 bg-light mb-3">
                    <h6 class="fw-bold text-dark mb-1">Prescription / Medication</h6>
                    <p class="small text-muted mb-0" id="pPrescription">-</p>
                </div>

                <div class="text-center pt-2">
                    <small class="text-muted">Thank you for visiting Sunrise Dental Clinic!</small>
                </div>
            </div>
            
            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-light rounded-3" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary-custom" onclick="printPrescription()"><i class="fa-solid fa-print me-1"></i> Print / Save as PDF</button>
            </div>
        </div>
    </div>
</div>

<script>
    // Populate View/Print Modal
    function openPrintModal(apptId, patientName, diagnosis, prescription) {
        document.getElementById('pApptId').innerText = apptId;
        document.getElementById('pName').innerText = patientName;
        document.getElementById('pDiagnosis').innerText = diagnosis || 'N/A';
        document.getElementById('pPrescription').innerText = prescription || 'No medication prescribed.';

        var modal = new bootstrap.Modal(document.getElementById('viewPrescriptionModal'));
        modal.show();
    }

    // Print functionality
    function printPrescription() {
        var printContents = document.getElementById('printablePrescription').innerHTML;
        var originalContents = document.body.innerHTML;

        document.body.innerHTML = '<div style="padding: 40px;">' + printContents + '</div>';
        window.print();
        document.body.innerHTML = originalContents;
        location.reload(); // Reload to restore UI state
    }
</script>
</body>
</html>