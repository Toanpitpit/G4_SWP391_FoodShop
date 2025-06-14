<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
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
            .login-wrapper {
                display: flex;
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(20px);
                border-radius: 20px;
                box-shadow: 
                    0 20px 40px rgba(0, 0, 0, 0.1),
                    0 0 0 1px rgba(255, 255, 255, 0.2);
                width: 100%;
                max-width: 900px;
                min-height: 600px;
                position: relative;
                transform: translateY(0);
                transition: all 0.3s ease;
                overflow: hidden;
            }

            .login-wrapper:hover {
                transform: translateY(-5px);
                box-shadow: 
                    0 30px 60px rgba(0, 0, 0, 0.15),
                    0 0 0 1px rgba(255, 255, 255, 0.3);
            }

            /* Left sidebar */
            .login-sidebar {
                flex: 1;
                background: linear-gradient(135deg, #e8f5e8 0%, #f0f9f0 100%);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 40px 30px;
                position: relative;
            }

            .login-sidebar::before {
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

            .sidebar-illustration {
                width: 100%;
                max-width: 350px;
                height: 250px;
                margin: 20px 0;
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
                margin-top: 20px;
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
            .login-container {
                flex: 1;
                padding: 40px;
                display: flex;
                flex-direction: column;
                justify-content: center;
            }

            .login-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .login-header h2 {
                color: #333;
                font-weight: 700;
                font-size: 2rem;
                margin-bottom: 10px;
                background: linear-gradient(135deg, #28a745, #20c997);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
            }

            .login-header p {
                color: #666;
                font-size: 0.9rem;
            }

            .form-floating {
                margin-bottom: 20px;
            }

            .form-floating input {
                border: 2px solid #e9ecef;
                border-radius: 12px;
                padding: 1rem 0.75rem;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: rgba(255, 255, 255, 0.8);
            }

            .form-floating input:focus {
                border-color: #28a745;
                box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
                background: rgba(255, 255, 255, 1);
            }

            .form-floating label {
                color: #666;
                font-weight: 500;
            }

            .form-check {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .form-check-input {
                width: 18px;
                height: 18px;
                border: 2px solid #ddd;
                border-radius: 4px;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .form-check-input:checked {
                background-color: #28a745;
                border-color: #28a745;
                box-shadow: 0 2px 8px rgba(40, 167, 69, 0.3);
            }

            .form-check-input:focus {
                border-color: #28a745;
                box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
            }

            .form-check-label {
                color: #666;
                font-size: 0.95rem;
                font-weight: 500;
                cursor: pointer;
                user-select: none;
            }

            .btn-login {
                background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
                border: none;
                border-radius: 12px;
                padding: 15px;
                font-size: 1.1rem;
                font-weight: 600;
                color: white;
                width: 100%;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .btn-login::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: left 0.5s;
            }

            .btn-login:hover::before {
                left: 100%;
            }

            .btn-login:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 25px rgba(40, 167, 69, 0.4);
            }

            .divider {
                display: flex;
                align-items: center;
                margin: 30px 0;
                color: #666;
                font-size: 0.9rem;
            }

            .divider::before,
            .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background: linear-gradient(to right, transparent, #ddd, transparent);
            }

            .divider span {
                padding: 0 20px;
                background: rgba(255, 255, 255, 0.9);
            }

            .social-login .btn {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
                font-size: 1rem;
                font-weight: 500;
                padding: 12px;
                border-radius: 12px;
                margin-bottom: 12px;
                transition: all 0.3s ease;
                border: 2px solid transparent;
            }

            .btn-google {
                background: white;
                color: #333;
                border-color: #ddd;
            }

            .btn-google:hover {
                background: #f8f9fa;
                border-color: #28a745;
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            }

            .btn-github {
                background: #24292e;
                color: white;
            }

            .btn-github:hover {
                background: #1a1e22;
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(36, 41, 46, 0.3);
            }

            .alert {
                border-radius: 12px;
                border: none;
                margin-bottom: 20px;
                backdrop-filter: blur(10px);
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

            .login-footer {
                text-align: center;
                margin-top: 30px;
                color: #666;
            }

            .login-footer a {
                color: #28a745;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
            }

            .login-footer a:hover {
                color: #20c997;
                text-decoration: underline;
            }

            .login-footer p {
                margin-bottom: 8px;
                font-size: 0.9rem;
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .login-wrapper {
                    flex-direction: column;
                    max-width: 450px;
                    margin: 20px;
                }
                
                .login-sidebar {
                    min-height: 200px;
                    padding: 30px 25px;
                }
                
                .sidebar-illustration {
                    height: 150px;
                    margin: 10px 0;
                }
                
                .login-container {
                    padding: 30px 25px;
                }
                
                .login-header h2 {
                    font-size: 1.6rem;
                }
            }

            /* Loading animation */
            .btn-login.loading {
                pointer-events: none;
            }

            .btn-login.loading::after {
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
        </style>
    </head>
    <body>
        <div class="login-wrapper">
            <!-- Left Sidebar -->
            <div class="login-sidebar">
                <div class="sidebar-content">
                    <div class="sidebar-brand">
                        <i class="fas fa-leaf"></i>
                        Fresh & Healthy
                    </div>
                    
                    <div class="sidebar-illustration"></div>
                    
                    <div class="sidebar-text">
                        <strong>Connect with your team</strong><br>
                        Join millions of users worldwide who trust our platform for seamless collaboration
                    </div>
                    
                    <div class="sidebar-features">
                        <div class="feature-item">
                            <i class="fas fa-shield-alt"></i>
                            <span>Secure</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-users"></i>
                            <span>Collaborative</span>
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-rocket"></i>
                            <span>Fast</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Right Form Container -->
            <div class="login-container">
                <div class="login-header">
                    <h2>Welcome !</h2>
                    <p>Let's sign in to your account</p>
                </div>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                    </div>
                </c:if>
                
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${param.success}
                    </div>
                </c:if>
                
                <form action="login" method="post" id="loginForm">
                    <div class="form-floating">
                        <input type="text" class="form-control" id="username" name="username" placeholder="Your Email" value="${username}" required>
                        <label for="username"><i class="fas fa-user me-2"></i>Your Email</label>
                    </div>
                    
                    <div class="form-floating">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" value="${password}" required>
                        <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
                    </div>
                    
                    <div class="form-check mb-3">
                        <input class="form-check-input" value="true" type="checkbox" id="rememberMe" name="rememberMe" ${rememberMe ? 'checked' : ''}>
                        <label class="form-check-label" for="rememberMe">
                            <i class="fas fa-remember me-1"></i>Remember me
                        </label>
                    </div>
                    
                    <button type="submit" class="btn btn-login" id="loginBtn">
                        <span><i class="fas fa-sign-in-alt me-2"></i>Login</span>
                    </button>
                </form>
                
                <div class="divider">
                    <span>or login with</span>
                </div>
                
                <div class="social-login">
                    <a href="https://accounts.google.com/o/oauth2/v2/auth?client_id=595131855100-pe7h7bnm3ukanad9uu8027st616rb6ei.apps.googleusercontent.com&redirect_uri=http://localhost:8080/GoogleLoginServlet&response_type=code&scope=email%20profile" class="btn btn-google w-100">
                        <i class="fab fa-google" style="color: red;"></i>
                        <span>Sign in with Google</span>
                    </a>
                </div>
                
                <div class="login-footer">
                    <p>Do not have an account? <a href="register.jsp">Sign up</a></p>
                    <p>Forgot your password? <a href="forgetpassword.jsp">Reset Password</a></p>
                </div>
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Add loading animation on form submit
            document.getElementById('loginForm').addEventListener('submit', function() {
                const btn = document.getElementById('loginBtn');
                btn.classList.add('loading');
                btn.innerHTML = '';
            });

            // Add floating label animation
            document.querySelectorAll('.form-floating input').forEach(input => {
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


