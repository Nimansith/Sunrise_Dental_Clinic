<%-- 
    Document   : services
    Created on : Aug 13, 2026, 12:15:17?PM
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
    <title>Dental Services - Sunrise Dental Clinic</title>
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

        .service-detail-card {
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            background: #ffffff;
            transition: all 0.3s ease;
        }
        .service-detail-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.08);
            border-color: #bae6fd;
        }

        .icon-box {
            width: 60px;
            height: 60px;
            border-radius: 14px;
            background: #f0f9ff;
            color: #0284c7;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.75rem;
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
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
                    <li class="nav-item"><a class="nav-link active" href="services.jsp">Services</a></li>
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
            <h1 class="fw-bold display-5 mb-2">Our Dental Treatments</h1>
            <p class="lead opacity-90 mb-0">High-quality, specialized oral care using state-of-the-art procedures.</p>
        </div>
    </section>

    <!-- Services Grid -->
    <section class="py-5">
        <div class="container py-4">
            <div class="row g-4">
                
                <!-- Service 1 -->
                <div class="col-lg-4 col-md-6">
                    <div class="service-detail-card p-4 h-100 d-flex flex-column">
                        <div class="icon-box mb-3">
                            <i class="fa-solid fa-teeth-open"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">General Checkup & Scaling</h5>
                        <p class="text-muted small mb-4">Routine oral examinations, professional cleaning, tartar removal, and cavity prevention to maintain long-term gum health.</p>
                        <a href="<%= dashboardLink %>" class="btn btn-outline-primary rounded-pill mt-auto fw-semibold">
                            Book Service
                        </a>
                    </div>
                </div>

                <!-- Service 2 -->
                <div class="col-lg-4 col-md-6">
                    <div class="service-detail-card p-4 h-100 d-flex flex-column">
                        <div class="icon-box mb-3">
                            <i class="fa-solid fa-wand-magic-sparkles"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Laser Teeth Whitening</h5>
                        <p class="text-muted small mb-4">Safe, painless clinical laser whitening treatments that brighten your natural smile by several shades in a single session.</p>
                        <a href="<%= dashboardLink %>" class="btn btn-outline-primary rounded-pill mt-auto fw-semibold">
                            Book Service
                        </a>
                    </div>
                </div>

                <!-- Service 3 -->
                <div class="col-lg-4 col-md-6">
                    <div class="service-detail-card p-4 h-100 d-flex flex-column">
                        <div class="icon-box mb-3">
                            <i class="fa-solid fa-teeth"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Orthodontics & Aligners</h5>
                        <p class="text-muted small mb-4">Correct misaligned teeth using traditional ceramic braces or modern invisible clear aligners custom-made for comfort.</p>
                        <a href="<%= dashboardLink %>" class="btn btn-outline-primary rounded-pill mt-auto fw-semibold">
                            Book Service
                        </a>
                    </div>
                </div>

                <!-- Service 4 -->
                <div class="col-lg-4 col-md-6">
                    <div class="service-detail-card p-4 h-100 d-flex flex-column">
                        <div class="icon-box mb-3">
                            <i class="fa-solid fa-microscope"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Root Canal Therapy</h5>
                        <p class="text-muted small mb-4">Painless endodontic therapy to save severely damaged or infected teeth without requiring extraction.</p>
                        <a href="<%= dashboardLink %>" class="btn btn-outline-primary rounded-pill mt-auto fw-semibold">
                            Book Service
                        </a>
                    </div>
                </div>

                <!-- Service 5 -->
                <div class="col-lg-4 col-md-6">
                    <div class="service-detail-card p-4 h-100 d-flex flex-column">
                        <div class="icon-box mb-3">
                            <i class="fa-solid fa-tooth"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Dental Implants & Crowns</h5>
                        <p class="text-muted small mb-4">Permanent, natural-looking replacement solutions for missing teeth using titanium implants and durable porcelain crowns.</p>
                        <a href="<%= dashboardLink %>" class="btn btn-outline-primary rounded-pill mt-auto fw-semibold">
                            Book Service
                        </a>
                    </div>
                </div>

                <!-- Service 6 -->
                <div class="col-lg-4 col-md-6">
                    <div class="service-detail-card p-4 h-100 d-flex flex-column">
                        <div class="icon-box mb-3">
                            <i class="fa-solid fa-child"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Pediatric Dentistry</h5>
                        <p class="text-muted small mb-4">Friendly and gentle dental care specifically designed for children to build positive oral habits early in life.</p>
                        <a href="<%= dashboardLink %>" class="btn btn-outline-primary rounded-pill mt-auto fw-semibold">
                            Book Service
                        </a>
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
