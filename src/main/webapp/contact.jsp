<%-- 
    Document   : contact_us
    Created on : Aug 13, 2026, 12:14:45?PM
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
    <title>Contact Us - Sunrise Dental Clinic</title>
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

        /* Navbar */
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

        /* Header Hero Banner */
        .page-header {
            background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
            color: white;
            padding: 60px 0;
        }

        /* Contact Cards */
        .contact-card {
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            background: #ffffff;
            transition: all 0.3s ease;
        }
        .contact-card:hover {
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

        /* Form Customization */
        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px 16px;
            border: 1px solid #cbd5e1;
        }
        .form-control:focus, .form-select:focus {
            border-color: #0284c7;
            box-shadow: 0 0 0 4px rgba(2, 132, 199, 0.15);
        }

        /* Map Embed Container */
        .map-container {
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            border: 1px solid #e2e8f0;
        }

        /* Footer */
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
                    <li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
                    <li class="nav-item"><a class="nav-link active" href="contact.jsp">Contact Us</a></li>
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

    <!-- Page Header Banner -->
    <section class="page-header text-center">
        <div class="container">
            <h1 class="fw-bold display-5 mb-2">Get In Touch</h1>
            <p class="lead opacity-90 mb-0">We are here to answer your questions and schedule your dental care.</p>
        </div>
    </section>

    <!-- Contact Info Cards -->
    <section class="py-5">
        <div class="container">
            <div class="row g-4 mb-5">
                <div class="col-lg-3 col-md-6">
                    <div class="contact-card p-4 h-100 text-center">
                        <div class="icon-box mb-3 mx-auto">
                            <i class="fa-solid fa-location-dot"></i>
                        </div>
                        <h6 class="fw-bold text-dark mb-2">Our Location</h6>
                        <p class="text-muted small mb-0">123 Main Street, Galle Road,<br>Colombo 03, Sri Lanka</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="contact-card p-4 h-100 text-center">
                        <div class="icon-box mb-3 mx-auto">
                            <i class="fa-solid fa-phone"></i>
                        </div>
                        <h6 class="fw-bold text-dark mb-2">Phone Numbers</h6>
                        <p class="text-muted small mb-0">+94 (0)11 234 5678<br>+94 (0)77 123 4567</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="contact-card p-4 h-100 text-center">
                        <div class="icon-box mb-3 mx-auto">
                            <i class="fa-solid fa-envelope"></i>
                        </div>
                        <h6 class="fw-bold text-dark mb-2">Email Address</h6>
                        <p class="text-muted small mb-0">info@sunrisedental.lk<br>appointments@sunrisedental.lk</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="contact-card p-4 h-100 text-center">
                        <div class="icon-box mb-3 mx-auto">
                            <i class="fa-solid fa-clock"></i>
                        </div>
                        <h6 class="fw-bold text-dark mb-2">Working Hours</h6>
                        <p class="text-muted small mb-0">Mon - Sat: 8:30 AM - 7:00 PM<br><span class="text-danger fw-semibold">Sunday: Closed</span></p>
                    </div>
                </div>
            </div>

            <!-- Contact Form & Map Row -->
            <div class="row g-4">
                <!-- Form Column -->
                <div class="col-lg-7">
                    <div class="bg-white p-4 p-md-5 rounded-4 shadow-sm border">
                        <h3 class="fw-bold text-dark mb-2">Send Us a Message</h3>
                        <p class="text-muted small mb-4">Fill out the form below and our dental team will respond within 24 hours.</p>

                        <form action="ContactServlet" method="POST">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Your Name</label>
                                    <input type="text" name="name" class="form-control" placeholder="John Doe" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Email Address</label>
                                    <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Phone Number</label>
                                    <input type="tel" name="phone" class="form-control" placeholder="+94 7X XXX XXXX">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold small">Subject</label>
                                    <select name="subject" class="form-select">
                                        <option value="General Inquiry">General Inquiry</option>
                                        <option value="Appointment Help">Appointment Help</option>
                                        <option value="Treatment Questions">Treatment Questions</option>
                                        <option value="Feedback">Feedback</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label fw-semibold small">Message</label>
                                    <textarea name="message" rows="5" class="form-control" placeholder="How can we help you?" required></textarea>
                                </div>
                                <div class="col-12 mt-4">
                                    <button type="submit" class="btn btn-primary btn-lg px-4 rounded-pill fw-semibold shadow-sm">
                                        <i class="fa-solid fa-paper-plane me-2"></i>Send Message
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Google Map Embed Column -->
                <div class="col-lg-5">
                    <div class="map-container h-100 min-vh-300">
                        <iframe 
                            src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d63371.8039230889!2d79.82118587399818!3d6.92183864455209!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae2593cf65a1e9d%3A0xe13da4b400e2d38c!2sColombo!5e0!3m2!1sen!2slk!4v1700000000000!5m2!1sen!2slk" 
                            width="100%" 
                            height="100%" 
                            style="border:0; min-height: 400px;" 
                            allowfullscreen="" 
                            loading="lazy" 
                            referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
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
