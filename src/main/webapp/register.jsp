<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #28a745 0%, #20c997 50%, #4fd69c 100%);
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                position: relative;
                overflow-x: hidden;
                padding: 20px;
            }

            /* Animated background elements */
            body::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: 
                    radial-gradient(circle at 20% 80%, rgba(40, 167, 69, 0.3) 0%, transparent 50%),
                    radial-gradient(circle at 80% 20%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                    radial-gradient(circle at 40% 40%, rgba(32, 201, 151, 0.2) 0%, transparent 50%);
                animation: float 6s ease-in-out infinite;
                z-index: -1;
            }

            @keyframes float {
                0%, 100% { transform: translateY(0px) rotate(0deg); }
                50% { transform: translateY(-20px) rotate(1deg); }
            }

            /* Main container with two columns */
            .register-wrapper {
                display: flex;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(20px);
                border-radius: 20px;
                box-shadow: 
                    0 20px 40px rgba(0, 0, 0, 0.1),
                    0 0 0 1px rgba(255, 255, 255, 0.2);
                width: 100%;
                max-width: 1000px;
                height: 750px;
                position: relative;
                transform: translateY(0);
                transition: all 0.3s ease;
                overflow: hidden;
            }

            .register-wrapper:hover {
                transform: translateY(-5px);
                box-shadow: 
                    0 30px 60px rgba(0, 0, 0, 0.15),
                    0 0 0 1px rgba(255, 255, 255, 0.3);
            }

            /* Left sidebar */
            .register-sidebar {
                flex: 1;
                background: linear-gradient(135deg, #e8f5e8 0%, #f0f9f0 100%);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 40px 30px;
                position: relative;
            }

            .register-sidebar::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: 
                    radial-gradient(circle at 30% 20%, rgba(40, 167, 69, 0.1) 0%, transparent 50%),
                    radial-gradient(circle at 70% 80%, rgba(32, 201, 151, 0.1) 0%, transparent 50%);
                z-index: 1;
            }

            .sidebar-content {
                position: relative;
                z-index: 2;
                text-align: center;
            }

            .sidebar-brand {
                font-size: 1.5rem;
                font-weight: 700;
                color: #28a745;
                margin-bottom: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

            .sidebar-title {
                font-size: 2.5rem;
                font-weight: 700;
                color: #28a745;
                margin-bottom: 20px;
                background: linear-gradient(135deg, #28a745, #20c997);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                animation: slideUp 0.8s ease-out;
            }

            @keyframes slideUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .sidebar-text {
                color: #666;
                font-size: 1.1rem;
                line-height: 1.6;
                margin-bottom: 30px;
                max-width: 300px;
            }

            .signin-btn {
                background: transparent;
                border: 2px solid #28a745;
                color: #28a745;
                padding: 15px 40px;
                border-radius: 25px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                cursor: pointer;
                font-size: 1rem;
                text-decoration: none;
                display: inline-block;
            }

            .signin-btn:hover {
                background: #28a745;
                color: white;
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(40, 167, 69, 0.3);
            }

            .sidebar-features {
                display: flex;
                justify-content: space-around;
                margin-top: 30px;
                width: 100%;
                max-width: 300px;
            }

            .feature-item {
                text-align: center;
                color: #28a745;
            }

            .feature-item i {
                font-size: 1.5rem;
                margin-bottom: 8px;
                display: block;
            }

            .feature-item span {
                font-size: 0.8rem;
                font-weight: 500;
            }

            /* Right form container */
            .register-container {
                flex: 1.2;
                padding: 30px 40px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                height: 100%;
                overflow-y: auto;
            }

            .register-header {
                text-align: center;
                margin-bottom: 25px;
            }

            .register-header h2 {
                color: #333;
                font-weight: 700;
                font-size: 2rem;
                margin-bottom: 10px;
                background: linear-gradient(135deg, #28a745, #20c997);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .register-header p {
                color: #666;
                font-size: 0.9rem;
            }

            .form-group {
                margin-bottom: 16px;
            }

            .form-control, .form-select {
                border: 2px solid #e9ecef;
                border-radius: 12px;
                padding: 12px 18px;
                font-size: 0.95rem;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.8);
                color: #333;
            }

            .form-control:focus, .form-select:focus {
                border-color: #28a745;
                box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
                background: rgba(255, 255, 255, 1);
                outline: none;
            }

            .form-control::placeholder {
                color: #999;
                font-size: 1rem;
            }

            .date-gender-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
                margin-bottom: 16px;
            }

            .signup-btn {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                border: none;
                border-radius: 12px;
                padding: 14px;
                font-size: 1rem;
                font-weight: 600;
                color: white;
                width: 100%;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
                margin-top: 8px;
            }

            .signup-btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: left 0.5s;
            }

            .signup-btn:hover::before {
                left: 100%;
            }

            .signup-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(40, 167, 69, 0.4);
            }

            .alert {
                border-radius: 12px;
                border: none;
                margin-bottom: 16px;
                backdrop-filter: blur(10px);
                padding: 12px 16px;
                font-size: 0.9rem;
            }

            .alert-danger {
                background: rgba(220, 53, 69, 0.1);
                color: #721c24;
                border-left: 4px solid #dc3545;
            }

            .alert-success {
                background: rgba(25, 135, 84, 0.1);
                color: #0f5132;
                border-left: 4px solid #198754;
            }

            /* Input icons */
            .input-group {
                position: relative;
            }

            .input-group i {
                position: absolute;
                left: 16px;
                top: 50%;
                transform: translateY(-50%);
                color: #666;
                z-index: 10;
                font-size: 0.9rem;
            }

            .input-group .form-control {
                padding-left: 45px;
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .register-wrapper {
                    flex-direction: column;
                    max-width: 500px;
                    margin: 20px;
                }
                
                .register-sidebar {
                    min-height: 250px;
                    padding: 30px 25px;
                }
                
                .sidebar-title {
                    font-size: 2rem;
                    margin-bottom: 15px;
                }
                
                .register-container {
                    padding: 30px 25px;
                    max-height: none;
                    overflow-y: visible;
                }
                
                .register-header h2 {
                    font-size: 1.6rem;
                }
                
                .date-gender-row {
                    grid-template-columns: 1fr;
                    gap: 0;
                }
            }

            /* Loading animation */
            .signup-btn.loading {
                pointer-events: none;
            }

            .signup-btn.loading::after {
                content: '';
                position: absolute;
                width: 20px;
                height: 20px;
                border: 2px solid transparent;
                border-top: 2px solid white;
                border-radius: 50%;
                animation: spin 1s linear infinite;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
            }

            @keyframes spin {
                0% { transform: translate(-50%, -50%) rotate(0deg); }
                100% { transform: translate(-50%, -50%) rotate(360deg); }
            }

            /* Custom scrollbar for form container */
            .register-container::-webkit-scrollbar {
                width: 6px;
            }

            .register-container::-webkit-scrollbar-track {
                background: rgba(0, 0, 0, 0.1);
                border-radius: 3px;
            }

            .register-container::-webkit-scrollbar-thumb {
                background: #28a745;
                border-radius: 3px;
            }

            .register-container::-webkit-scrollbar-thumb:hover {
                background: #20c997;
            }
        </style>
    </head>
    <body>
        <div class="register-wrapper">
            <!-- Left Sidebar -->
            <div class="register-sidebar">
                <div class="sidebar-content">
                    <div class="sidebar-brand">
                        <i class="fas fa-leaf"></i>
                        Fresh & Healthy
                    </div>
                    
                    <div class="sidebar-title">
                        Welcome Back!
                    </div>
                    
                    <div class="sidebar-text">
                        Already have an account? Sign in and continue your journey with us.
                    </div>
                    
                    <a href="login.jsp" class="signin-btn">
                        <i class="fas fa-sign-in-alt me-2"></i>Sign In
                    </a>
                    
                    <div class="sidebar-features">
                        <div class="feature-item">
                            <i class="fas fa-shield-alt"></i>
                            <span>Secure</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-users"></i>
                            <span>Trusted</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-heart"></i>
                            <span>Loved</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Right Form Container -->
            <div class="register-container">
                <div class="register-header">
                    <h2>Create Account</h2>
                    <p>Join millions of users who trust our platform</p>
                </div>
                
                <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i><%= request.getAttribute("error") %>
                </div>
                <% } %>
                <% if (request.getParameter("success") != null) { %>
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i><%= request.getParameter("success") %>
                </div>
                <% } %>
                
                <form action="register" method="post" id="registerForm">
                    <div class="form-group">
                        <div class="input-group">
                            <i class="fas fa-user"></i>
                            <input type="text"  value= ${username} class="form-control" id="username" name="username" placeholder="Username" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="input-group">
                            <i class="fas fa-lock"></i>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="input-group">
                            <i class="fas fa-id-card"></i>
                            <input type="text" value= ${fullName} class="form-control" id="fullName" name="fullName" placeholder="Full Name">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="input-group">
                            <i class="fas fa-envelope"></i>
                            <input type="email" value= ${email} class="form-control" id="email" name="email" placeholder="Email Address">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <div class="input-group">
                            <i class="fas fa-phone"></i>
                            <input type="text" value= ${phone} class="form-control" id="phone" name="phone" placeholder="Phone Number">
                        </div>
                    </div>
                    
                    <div class="date-gender-row">
                        <div class="form-group">
                            <select class="form-select" id="gender" name="gender">
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <input type="date" class="form-control" id="birthDate" name="birthDate">
                        </div>
                    </div>
                    
                    <button type="submit" class="signup-btn" id="signupBtn">
                        <span><i class="fas fa-user-plus me-2"></i>Create Account</span>
                    </button>
                </form>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Add loading animation on form submit
            document.getElementById('registerForm').addEventListener('submit', function() {
                const btn = document.getElementById('signupBtn');
                btn.classList.add('loading');
                btn.innerHTML = '';
            });

            // Password strength indicator
            document.getElementById('password').addEventListener('input', function() {
                // Add password strength logic here if needed
            });

            // Confirm password validation
            document.getElementById('confirmPassword').addEventListener('input', function() {
                const password = document.getElementById('password').value;
                const confirmPassword = this.value;
                
                if (password !== confirmPassword && confirmPassword !== '') {
                    this.setCustomValidity('Passwords do not match');
                } else {
                    this.setCustomValidity('');
                }
            });

            // Add focus effects
            document.querySelectorAll('.form-control, .form-select').forEach(input => {
                input.addEventListener('focus', function() {
                    this.parentElement.classList.add('focused');
                });
                
                input.addEventListener('blur', function() {
                    if (this.value === '') {
                        this.parentElement.classList.remove('focused');
                    }
                });
            });
        </script>
    </body>
</html>
