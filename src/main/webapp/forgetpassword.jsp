<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
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
            padding: 20px;
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

        .forgot-password-container {
            max-width: 480px;
            width: 100%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 50px 40px;
            box-shadow: 
                0 20px 40px rgba(0, 0, 0, 0.1),
                0 0 0 1px rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: hidden;
            animation: slideUp 0.8s ease-out;
            transition: all 0.3s ease;
        }

        .forgot-password-container:hover {
            transform: translateY(-5px);
            box-shadow: 
                0 30px 60px rgba(0, 0, 0, 0.15),
                0 0 0 1px rgba(255, 255, 255, 0.3);
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .forgot-password-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            animation: shimmer 3s infinite;
        }

        @keyframes shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        .header-section {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
            z-index: 2;
        }

        .lock-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #28a745, #20c997);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            box-shadow: 0 10px 30px rgba(40, 167, 69, 0.3);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { 
                transform: scale(1); 
                box-shadow: 0 10px 30px rgba(40, 167, 69, 0.3); 
            }
            50% { 
                transform: scale(1.05); 
                box-shadow: 0 15px 40px rgba(40, 167, 69, 0.4); 
            }
        }

        .lock-icon i {
            color: white;
            font-size: 32px;
        }

        .main-title {
            font-size: 28px;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #28a745, #20c997);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .subtitle {
            color: #6c757d;
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 0;
        }

        .form-section {
            position: relative;
            z-index: 2;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 600;
            color: #34495e;
            margin-bottom: 10px;
            display: block;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .input-group {
            position: relative;
        }

        .form-control {
            height: 55px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 0 20px 0 55px;
            font-size: 16px;
            background: rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .form-control:focus {
            border-color: #28a745;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
            outline: none;
            background: rgba(255, 255, 255, 0.95);
            transform: translateY(-2px);
        }

        .input-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-size: 18px;
            z-index: 3;
            transition: color 0.3s ease;
        }

        .form-control:focus + .input-icon {
            color: #28a745;
        }

        .btn-primary {
            width: 100%;
            height: 55px;
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: white;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-bottom: 25px;
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s ease;
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(40, 167, 69, 0.4);
        }

        .btn-primary:active {
            transform: translateY(-1px);
        }

        .alert {
            border-radius: 12px;
            border: none;
            padding: 15px 20px;
            margin-bottom: 25px;
            font-weight: 500;
            animation: alertSlide 0.5s ease-out;
            backdrop-filter: blur(10px);
        }

        @keyframes alertSlide {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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

        .back-link {
            text-align: center;
            margin-top: 20px;
        }

        .back-link a {
            color: #28a745;
            text-decoration: none;
            font-weight: 600;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: 25px;
            background: rgba(40, 167, 69, 0.1);
            transition: all 0.3s ease;
        }

        .back-link a:hover {
            background: rgba(40, 167, 69, 0.2);
            transform: translateX(-5px);
            color: #20c997;
        }

        /* Loading animation for button */
        .btn-loading {
            pointer-events: none;
            opacity: 0.8;
        }

        .btn-loading::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 20px;
            height: 20px;
            margin: -10px 0 0 -10px;
            border: 2px solid transparent;
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Mobile responsiveness */
        @media (max-width: 768px) {
            .forgot-password-container {
                margin: 20px;
                padding: 30px 25px;
                border-radius: 16px;
            }

            .main-title {
                font-size: 24px;
            }

            .lock-icon {
                width: 60px;
                height: 60px;
                margin-bottom: 20px;
            }

            .lock-icon i {
                font-size: 24px;
            }

            .form-control {
                height: 50px;
                padding: 0 15px 0 45px;
            }

            .btn-primary {
                height: 50px;
                font-size: 14px;
            }
        }

        /* Focus trap styling */
        .forgot-password-container:focus-within {
            box-shadow: 
                0 30px 60px rgba(0, 0, 0, 0.2),
                0 0 0 1px rgba(40, 167, 69, 0.3);
        }

        /* Additional visual enhancements */
        .form-group {
            position: relative;
        }

        .form-group::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg, transparent, rgba(40, 167, 69, 0.3), transparent);
            border-radius: 1px;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .form-group:focus-within::before {
            opacity: 1;
        }
    </style>
</head>
<body>
    <div class="forgot-password-container">
        <div class="header-section">
            <div class="lock-icon">
                <i class="fas fa-lock"></i>
            </div>
            <h2 class="main-title">Forgot Password?</h2>
            <p class="subtitle">Don't worry! Enter your email address and we'll send you a verification code to reset your password.</p>
        </div>

        <div class="form-section">
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>${error}
                </div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>${success}
                </div>
            </c:if>

            <form action="ForgotPasswordController" method="post" id="forgotPasswordForm">
                <div class="form-group">
                    <label for="email" class="form-label">Email Address</label>
                    <div class="input-group">
                        <input type="email" class="form-control" id="email" name="email" 
                               placeholder="Enter your email address" required>
                        <i class="fas fa-envelope input-icon"></i>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary" id="submitBtn">
                    <i class="fas fa-paper-plane me-2"></i>
                    Send Verification Code
                </button>
            </form>

            <div class="back-link">
                <a href="login.jsp">
                    <i class="fas fa-arrow-left"></i>
                    Back to Login
                </a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form submission with loading state
        document.getElementById('forgotPasswordForm').addEventListener('submit', function() {
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.classList.add('btn-loading');
            submitBtn.innerHTML = 'Sending...';
        });

        // Auto-hide alerts after 5 seconds
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.animation = 'alertSlide 0.5s ease-out reverse';
                setTimeout(() => {
                    alert.style.display = 'none';
                }, 500);
            }, 5000);
        });

        // Enhanced focus effects
        const formControl = document.getElementById('email');
        formControl.addEventListener('focus', function() {
            this.parentElement.style.transform = 'scale(1.02)';
        });
        
        formControl.addEventListener('blur', function() {
            this.parentElement.style.transform = 'scale(1)';
        });

        // Add floating animation to container
        const container = document.querySelector('.forgot-password-container');
        container.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px) scale(1.02)';
        });
        
        container.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    </script>
</body>
</html>
