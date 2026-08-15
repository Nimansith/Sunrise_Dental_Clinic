<%
    Object currentUser = session.getAttribute("user");
    String dashboardLink = "login.jsp";

    if (currentUser != null) {
        String role = (String) session.getAttribute("role");

        if ("RECEPTIONIST".equals(role)) {
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
    <title>Sunrise Dental Clinic - Modern & Gentle Dental Care</title>
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

        /* Top Header */
        .top-bar {
            background-color: #0b3c5d;
            font-size: 0.875rem;
        }

        /* Navbar Customization */
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
            transition: color 0.2s ease;
        }
        .nav-link:hover, .nav-link.active {
            color: #0284c7 !important;
        }

        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            padding: 90px 0;
            position: relative;
        }
        .hero-badge {
            background: rgba(2, 132, 199, 0.1);
            color: #0284c7;
            font-size: 0.875rem;
            letter-spacing: 0.5px;
        }

        /* Service Cards */
        .card-service {
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: #ffffff;
        }
        .card-service:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.08), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
            border-color: #bae6fd;
        }
        .icon-box {
            width: 64px;
            height: 64px;
            border-radius: 14px;
            background: #f0f9ff;
            color: #0284c7;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.75rem;
        }

        /* CTA Section */
        .cta-banner {
            background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
            border-radius: 24px;
        }

        /* Footer */
        .footer {
            background-color: #0f172a;
            color: #94a3b8;
        }
        .footer h5 {
            color: #ffffff;
            font-weight: 600;
            font-size: 1.1rem;
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
                    <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
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

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center gy-5">
                <div class="col-lg-7 text-center text-lg-start">
                    <span class="badge hero-badge fw-bold px-3 py-2 rounded-pill mb-3 text-uppercase">
                        <i class="fa-solid fa-sparkles me-2"></i>Trusted Dental Care
                    </span>
                    <h1 class="display-4 fw-bold text-dark lh-sm mb-3">
                        Creating Healthy Smiles <br class="d-none d-md-inline">For a Lifetime
                    </h1>
                    <p class="lead text-muted mb-4 pe-lg-4">
                        Experience gentle, modern, and personalized oral healthcare. From routine checkups to advanced cosmetic procedures, we are here for your entire family.
                    </p>
                    <div class="d-flex flex-column flex-sm-row justify-content-center justify-content-lg-start gap-3">
                        <a href="<%= dashboardLink %>" class="btn btn-primary btn-lg px-4 py-3 rounded-pill shadow-sm fw-semibold">
                            <i class="fa-solid fa-calendar-check me-2"></i>Book Appointment
                        </a>
                        <a href="services.jsp" class="btn btn-white btn-lg px-4 py-3 rounded-pill border fw-semibold text-secondary">
                            Explore Services
                        </a>
                    </div>
                </div>
                <div class="col-lg-5 text-center">
                    <div class="p-4 bg-white rounded-4 shadow-lg text-center position-relative">
                        <div class="icon-box mb-3 mx-auto" style="width: 80px; height: 80px; font-size: 2.2rem;">
                            <i class="fa-solid fa-user-doctor"></i>
                        </div>
                        <h4 class="fw-bold text-dark mb-2">Expert Specialists</h4>
                        <p class="text-muted small mb-4">Board-certified dentists dedicated to painless treatment techniques.</p>
                        <div class="row g-2 text-start pt-3 border-top">
                            <div class="col-6">
                                <span class="d-block fw-bold fs-4 text-primary">15+</span>
                                <small class="text-muted">Years Experience</small>
                            </div>
                            <div class="col-6">
                                <span class="d-block fw-bold fs-4 text-primary">10k+</span>
                                <small class="text-muted">Happy Patients</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Overview Section -->
    <section class="py-5">
        <div class="container py-4">
            <div class="text-center max-w-2xl mx-auto mb-5">
                <h2 class="fw-bold text-dark mb-2">Comprehensive Dental Services</h2>
                <p class="text-muted">High-quality care tailored to meet your unique oral health needs.</p>
            </div>

            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card card-service h-100 p-4 border-0">
                        <div class="icon-box mb-4">
                            <i class="fa-solid fa-teeth-open"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">General Dentistry</h5>
                        <p class="text-muted small mb-4">Preventive checkups, deep scaling, root canals, and tooth fillings for overall wellness.</p>
                        <a href="services.jsp" class="text-primary text-decoration-none fw-semibold small mt-auto">
                            Learn More <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card card-service h-100 p-4 border-0">
                        <div class="icon-box mb-4">
                            <i class="fa-solid fa-wand-magic-sparkles"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Cosmetic Dentistry</h5>
                        <p class="text-muted small mb-4">Laser tooth whitening, porcelain veneers, and smile design to restore confidence.</p>
                        <a href="services.jsp" class="text-primary text-decoration-none fw-semibold small mt-auto">
                            Learn More <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card card-service h-100 p-4 border-0">
                        <div class="icon-box mb-4">
                            <i class="fa-solid fa-teeth"></i>
                        </div>
                        <h5 class="fw-bold text-dark mb-2">Orthodonics & Braces</h5>
                        <p class="text-muted small mb-4">Clear aligners, traditional braces, and retainers to align teeth for all age groups.</p>
                        <a href="services.jsp" class="text-primary text-decoration-none fw-semibold small mt-auto">
                            Learn More <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-5">
                <a href="services.jsp" class="btn btn-outline-primary px-4 py-2 rounded-pill fw-semibold">View All Services</a>
            </div>
        </div>
    </section>

    <!-- Call to Action Banner -->
    <section class="container mb-5">
        <div class="cta-banner text-white p-5 text-center text-lg-start shadow">
            <div class="row align-items-center gy-4">
                <div class="col-lg-8">
                    <h3 class="fw-bold mb-2">Ready to smile with confidence again?</h3>
                    <p class="mb-0 text-white-50">Schedule your consultation today or access your patient portal online.</p>
                </div>
                <div class="col-lg-4 text-lg-end">
                    <a href="<%= dashboardLink %>" class="btn btn-light text-primary btn-lg px-4 py-3 rounded-pill fw-bold shadow-sm">
                        Make Appointment
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Main Footer -->
    <footer class="footer pt-5 pb-4">
        <div class="container">
            <div class="row g-4 mb-5">
                <!-- Brand Info -->
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

                <!-- Quick Links -->
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

                <!-- Services Link -->
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

                <!-- Contact & Working Hours -->
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