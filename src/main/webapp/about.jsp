<%-- 
    Document   : about
    Created on : Aug 13, 2026, 12:14:33?PM
    Author     : Rusanda Nimansith
--%>

<%
    Object currentUser = session.getAttribute("user");
    String dashboardLink = "login.jsp";

    if (currentUser != null) {
        String role = (String) session.getAttribute("role");

        if ("ADMIN".equals(role)) {
            dashboardLink = "adminDashboard.jsp";
        } else if ("RECEPTIONIST".equals(role)) {
            dashboardLink = "receptionistDashboard.jsp";
        } else if ("DENTIST".equals(role)) {
            dashboardLink = "dentistDashboard.jsp";
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Sunrise Dental Clinic</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            color: #2b3940;
            overflow-x: hidden;
        }

        .top-bar {
            background-color: #0b3c5d;
            font-size: 0.875rem;
        }

        .navbar {
            transition: all 0.3s ease;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }
        .navbar-brand {
            font-weight: 700;
            letter-spacing: -0.5px;
            color: #0284c7 !important;
        }
        .nav-link {
            font-weight: 500;
            color: #475569 !important;
            margin: 0 4px;
        }
        .nav-link:hover, .nav-link.active {
            color: #0284c7 !important;
        }

        .page-header {
            background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
            color: white;
            padding: 60px 0;
        }

        .feature-card {
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            background: #ffffff;
            transition: all 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            border-color: #bae6fd;
        }

        .icon-box {
            width: 56px;
            height: 56px;
            border-radius: 12px;
            background: #f0f9ff;
            color: #0284c7;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .team-card {
            border-radius: 16px;
            overflow: hidden;
            border: 1px solid #e2e8f0;
            background: #fff;
            transition: all 0.3s ease;
        }
        .team-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.08);
        }

        .footer {
            background-color: #0f172a;
            color: #94a3b8;
        }
        .footer h5 {
            color: #ffffff;
            font-weight: 600;
        }
        .footer-link {
            color: #94a3b8;
            text-decoration: none;
            transition: all 0.2s ease;
            display: inline-block;
            margin-bottom: 8px;
        }
        .footer-link:hover {
            color: #38bdf8;
            transform: translateX(4px);
        }
        .social-icon {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: rgba(255,255,255,0.08);
            color: #fff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: 0.2s ease;
            text-decoration: none;
        }
        .social-icon:hover {
            background: #0284c7;
            color: #fff;
        }
    </style>
</head>
<body class="bg-light">

    <!-- Top Utility Bar -->
    <div class="top-bar text-white py-2 d-none d-md-block">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center gap-4">
                    <span><i class="fa-solid fa-phone me-2 text-info"></i>+94 (0)11 234 5678</span>
                    <span><i class="fa-solid fa-envelope me-2 text-info"></i>info@sunrisedental.lk</span>
                    <span><i class="fa-solid fa-clock me-2 text-info"></i>Mon - Sat: 8:30 AM - 7:00 PM</span>
                </div>
                <div>
                    <span class="badge bg-danger"><i class="fa-solid fa-truck-medical me-1"></i> Emergency: 24/7</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
        <div class="container">
            <a class="navbar-brand fs-3" href="index.jsp">
                <i class="fa-solid fa-tooth me-2"></i>Sunrise Dental
            </a>
            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto me-4 mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link active" href="about.jsp">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="contact.jsp">Contact Us</a></li>
                </ul>

                <% if (currentUser == null) { %>
                    <a href="login.jsp" class="btn btn-outline-primary px-4 rounded-pill fw-semibold">
                        <i class="fa-solid fa-right-to-bracket me-2"></i>Login
                    </a>
                <% } else { %>
                    <a href="<%= dashboardLink %>" class="btn btn-primary text-white fw-semibold px-4 rounded-pill shadow-sm">
                        <i class="fa-solid fa-gauge me-2"></i>My Dashboard
                    </a>
                <% } %>
            </div>
        </div>
    </nav>

    <!-- Page Header -->
    <section class="page-header text-center">
        <div class="container">
            <h1 class="fw-bold display-5 mb-2">About Sunrise Dental</h1>
            <p class="lead opacity-90 mb-0">Dedicated to delivering painless, gentle, and modern dental solutions.</p>
        </div>
    </section>

    <!-- Our Story Section -->
    <section class="py-5">
        <div class="container py-4">
            <div class="row align-items-center gy-4">
                <div class="col-lg-6">
                    <span class="badge bg-primary-subtle text-primary fw-bold px-3 py-2 rounded-pill mb-3">WHO WE ARE</span>
                    <h2 class="fw-bold text-dark mb-3">Providing Compassionate Care Since 2011</h2>
                    <p class="text-muted leading-relaxed">
                        At Sunrise Dental Clinic, we believe every patient deserves a healthy, radiant smile. Over the past decade, we have established ourselves as a premier dental care facility in Sri Lanka, combining clinical expertise with state-of-the-art technology.
                    </p>
                    <p class="text-muted leading-relaxed mb-4">
                        Our modern clinic environment is engineered to eliminate dental anxiety. Whether you visit for a routine checkup or specialized oral surgery, our team ensures personalized treatment tailored to your comfort and health goals.
                    </p>
                    <a href="<%= dashboardLink %>" class="btn btn-primary px-4 py-2 rounded-pill fw-semibold shadow-sm">
                        Book Your Visit
                    </a>
                </div>
                <div class="col-lg-6">
                    <div class="bg-white p-4 rounded-4 shadow-sm border text-center">
                        <i class="fa-solid fa-hospital-user display-1 text-primary mb-3"></i>
                        <h4 class="fw-bold text-dark mb-2">Patient-Centred Philosophy</h4>
                        <p class="text-muted small">We prioritize patient education, transparent consultations, and long-term preventive dental care strategies.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Core Values -->
    <section class="py-5 bg-white border-top border-bottom">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold text-dark">Why Choose Us</h2>
                <p class="text-muted">The key principles that set our dental practice apart.</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card p-4 h-100 text-center">
                        <div class="icon-box mb-3 mx-auto">
                            <i class="fa-solid fa-microscope"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Modern Technology</h5>
                        <p class="text-muted small mb-0">Equipped with 3D digital imaging, intraoral scanners, and low-radiation digital X-rays.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card p-4 h-100 text-center">
                        <div class="icon-box mb-3 mx-auto">
                            <i class="fa-solid fa-hand-holding-heart"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Painless Treatments</h5>
                        <p class="text-muted small mb-0">Advanced gentle dental techniques and sedation options designed for maximum patient comfort.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card p-4 h-100 text-center">
                        <div class="icon-box mb-3 mx-auto">
                            <i class="fa-solid fa-shield-virus"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Strict Sterilization</h5>
                        <p class="text-muted small mb-0">Adhering strictly to international hygiene standards and hospital-grade autoclave sterilization.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Dental Team Preview -->
    <section class="py-5">
        <div class="container py-4">
            <div class="text-center mb-5">
                <h2 class="fw-bold text-dark">Meet Our Dental Specialists</h2>
                <p class="text-muted">Highly qualified professionals dedicated to your oral wellness.</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="team-card text-center p-4">
                        <div class="icon-box mb-3 mx-auto" style="width:72px; height:72px; font-size:2rem;">
                            <i class="fa-solid fa-user-doctor"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-1">Dr. Nishan Silva</h5>
                        <span class="text-primary small fw-semibold d-block mb-3">Senior Dental Surgeon (BDS)</span>
                        <p class="text-muted small mb-0">15+ years of experience in restorative and cosmetic dentistry.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="team-card text-center p-4">
                        <div class="icon-box mb-3 mx-auto" style="width:72px; height:72px; font-size:2rem;">
                            <i class="fa-solid fa-user-doctor"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-1">Dr. Keshani Perera</h5>
                        <span class="text-primary small fw-semibold d-block mb-3">Orthodontist Specialist</span>
                        <p class="text-muted small mb-0">Expert in adult and pediatric teeth alignment, braces, and aligners.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="team-card text-center p-4">
                        <div class="icon-box mb-3 mx-auto" style="width:72px; height:72px; font-size:2rem;">
                            <i class="fa-solid fa-user-doctor"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-1">Dr. Ruwan Fernando</h5>
                        <span class="text-primary small fw-semibold d-block mb-3">Oral Surgeon</span>
                        <p class="text-muted small mb-0">Specializes in painless tooth extractions and complex dental implants.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer pt-5 pb-4">
        <div class="container">
            <div class="row g-4 mb-5">
                <div class="col-lg-4 col-md-6">
                    <a class="navbar-brand text-white fs-4 d-block mb-3" href="index.jsp">
                        <i class="fa-solid fa-tooth text-info me-2"></i>Sunrise Dental
                    </a>
                    <p class="small text-muted mb-4">
                        Delivering exceptional, gentle, and reliable dental healthcare using modern technologies and clinical excellence across Sri Lanka.
                    </p>
                    <div class="d-flex gap-2">
                        <a href="#" class="social-icon"><i class="fa-brands fa-facebook-f"></i></a>
                        <a href="#" class="social-icon"><i class="fa-brands fa-instagram"></i></a>
                        <a href="#" class="social-icon"><i class="fa-brands fa-twitter"></i></a>
                        <a href="#" class="social-icon"><i class="fa-brands fa-linkedin-in"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6">
                    <h5 class="mb-3">Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="index.jsp" class="footer-link">Home</a></li>
                        <li><a href="about.jsp" class="footer-link">About Us</a></li>
                        <li><a href="services.jsp" class="footer-link">Services</a></li>
                        <li><a href="contact.jsp" class="footer-link">Contact Us</a></li>
                        <li><a href="login.jsp" class="footer-link">Patient Portal</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="mb-3">Our Services</h5>
                    <ul class="list-unstyled">
                        <li><a href="services.jsp" class="footer-link">General Checkups</a></li>
                        <li><a href="services.jsp" class="footer-link">Teeth Whitening</a></li>
                        <li><a href="services.jsp" class="footer-link">Dental Implants</a></li>
                        <li><a href="services.jsp" class="footer-link">Orthodontics (Braces)</a></li>
                        <li><a href="services.jsp" class="footer-link">Pediatric Dentistry</a></li>
                    </ul>
                </div>
                <div class="col-lg-3 col-md-6">
                    <h5 class="mb-3">Contact Info</h5>
                    <ul class="list-unstyled small">
                        <li class="mb-2"><i class="fa-solid fa-location-dot me-2 text-info"></i>123 Main Street, Colombo, Sri Lanka</li>
                        <li class="mb-2"><i class="fa-solid fa-phone me-2 text-info"></i>+94 (0)11 234 5678</li>
                        <li class="mb-2"><i class="fa-solid fa-envelope me-2 text-info"></i>info@sunrisedental.lk</li>
                    </ul>
                    <h6 class="text-white mt-3 mb-2 small fw-bold">Opening Hours</h6>
                    <p class="small mb-0">Mon - Sat: 8:30 AM - 7:00 PM<br>Sunday: Closed</p>
                </div>
            </div>
            <hr class="border-secondary opacity-25">
            <div class="row align-items-center small">
                <div class="col-md-6 text-center text-md-start">
                    <p class="mb-0">&copy; 2026 Sunrise Dental Clinic. All Rights Reserved.</p>
                </div>
                <div class="col-md-6 text-center text-md-end mt-2 mt-md-0">
                    <a href="#" class="text-muted text-decoration-none me-3">Privacy Policy</a>
                    <a href="#" class="text-muted text-decoration-none">Terms of Service</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>