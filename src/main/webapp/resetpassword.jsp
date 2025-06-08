<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow-x: hidden;
        }

        /* Animated background particles */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: 
                radial-gradient(circle at 25% 25%, rgba(255, 255, 255, 0.1) 2px, transparent 2px),
                radial-gradient(circle at 75% 75%, rgba(255, 255, 255, 0.1) 2px, transparent 2px);
            background-size: 50px 50px;
            animation: float 20s ease-in-out infinite;
            pointer-events: none;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            50% { transform: translateY(-20px) rotate(180deg); }
        }

        .reset-password-container {
            max-width: 450px;
            width: 90%;
            margin: 20px;
            padding: 40px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 
                0 25px 45px rgba(0, 0, 0, 0.1),
                0 0 0 1px rgba(255, 255, 255, 0.2);
            position: relative;
            animation: slideUp 0.6s ease-out;
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

        .reset-password-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #3fb918, #51cf66, #3fb918);
            border-radius: 20px 20px 0 0;
            background-size: 200% 100%;
            animation: shimmer 3s ease-in-out infinite;
        }

        @keyframes shimmer {
            0%, 100% { background-position: 200% 0; }
            50% { background-position: -200% 0; }
        }

        .form-header {
            text-align: center;
            margin-bottom: 35px;
        }

        .form-header i {
            font-size: 3rem;
            background: linear-gradient(135deg, #3fb918, #51cf66);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 15px;
            display: block;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .form-header h2 {
            color: #2c3e50;
            font-weight: 700;
            font-size: 1.8rem;
            margin-bottom: 8px;
        }

        .form-header p {
            color: #6c757d;
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-label {
            font-weight: 600;
            color: #34495e;
            margin-bottom: 8px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-label i {
            color: #3fb918;
        }

        .form-control {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
        }

        .form-control:focus {
            border-color: #3fb918;
            box-shadow: 0 0 0 3px rgba(63, 185, 24, 0.1);
            background: white;
            transform: translateY(-2px);
        }

        .form-control:hover {
            border-color: #cbd5e0;
            transform: translateY(-1px);
        }

        .btn-primary {
            background: #3fb918;
            border: none;
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .btn-primary::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .btn-primary:hover::before {
            left: 100%;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(63, 185, 24, 0.3);
            background: linear-gradient(135deg, #51cf66 0%, #40c057 100%);
        }

        .btn-primary:active {
            transform: translateY(0);
        }

        .alert {
            border: none;
            border-radius: 12px;
            padding: 12px 16px;
            margin-bottom: 20px;
            font-weight: 500;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .alert-danger {
            background: linear-gradient(135deg, #ff6b6b, #ee5a52);
            color: white;
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.3);
        }

        .alert-success {
            background: linear-gradient(135deg, #51cf66, #40c057);
            color: white;
            box-shadow: 0 8px 25px rgba(81, 207, 102, 0.3);
        }

        .back-link {
            text-align: center;
            margin-top: 25px;
        }

        .back-link a {
            color: #3fb918;
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            padding: 8px 16px;
            border-radius: 8px;
        }

        .back-link a:hover {
            color: #224abe;
            background: rgba(63, 185, 24, 0.1);
            transform: translateX(-5px);
        }

        .password-strength {
            margin-top: 8px;
            font-size: 0.8rem;
        }

        .strength-bar {
            height: 4px;
            background: #e2e8f0;
            border-radius: 2px;
            overflow: hidden;
            margin-top: 4px;
        }

        .strength-fill {
            height: 100%;
            transition: all 0.3s ease;
            border-radius: 2px;
        }

        .floating-shapes {
            position: absolute;
            width: 100%;
            height: 100%;
            overflow: hidden;
            pointer-events: none;
        }

        .shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            animation: float-shapes 15s infinite linear;
        }

        .shape:nth-child(1) {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            top: 20%;
            left: 10%;
            animation-delay: 0s;
        }

        .shape:nth-child(2) {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            top: 60%;
            right: 10%;
            animation-delay: 5s;
        }

        .shape:nth-child(3) {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            top: 80%;
            left: 20%;
            animation-delay: 10s;
        }

        @keyframes float-shapes {
            0% { transform: translateY(0px) rotate(0deg); opacity: 0.7; }
            50% { transform: translateY(-100px) rotate(180deg); opacity: 0.3; }
            100% { transform: translateY(0px) rotate(360deg); opacity: 0.7; }
        }

        @media (max-width: 768px) {
            .reset-password-container {
                padding: 30px 25px;
                margin: 10px;
            }
            
            .form-header h2 {
                font-size: 1.6rem;
            }
        }
    </style>
</head>
<body>
    <div class="floating-shapes">
        <div class="shape"></div>
        <div class="shape"></div>
        <div class="shape"></div>
    </div>

    <div class="reset-password-container">
        <div class="form-header">
            <i class="fas fa-key"></i>
            <h2>Đặt Lại Mật Khẩu</h2>
            <p>Nhập mã xác nhận và mật khẩu mới của bạn</p>
        </div>

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

        <form action="${pageContext.request.contextPath}/ResetPasswordController" method="post">
            <div class="form-group">
                <label for="code" class="form-label">
                    <i class="fas fa-shield-alt"></i>
                    Mã Xác Nhận
                </label>
                <input type="text" class="form-control" id="code" name="code" required 
                       placeholder="Nhập mã xác nhận từ email" maxlength="10" autocomplete="off">
            </div>

            <div class="form-group">
                <label for="newPassword" class="form-label">
                    <i class="fas fa-lock"></i>
                    Mật Khẩu Mới
                </label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" required 
                       placeholder="Nhập mật khẩu mới (tối thiểu 6 ký tự)" minlength="6" onkeyup="checkPasswordStrength(this.value)">
                <div class="password-strength" id="passwordStrength" style="display: none;">
                    <div class="strength-bar">
                        <div class="strength-fill" id="strengthFill"></div>
                    </div>
                    <span id="strengthText"></span>
                </div>
            </div>

            <input type="hidden" name="email" value="${email}">
            
            <button type="submit" class="btn btn-primary w-100">
                <i class="fas fa-sync-alt me-2"></i>
                Đặt Lại Mật Khẩu
            </button>
        </form>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/ForgotPasswordController">
                <i class="fas fa-arrow-left"></i>
                Quay lại
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function checkPasswordStrength(password) {
            const strengthDiv = document.getElementById('passwordStrength');
            const strengthFill = document.getElementById('strengthFill');
            const strengthText = document.getElementById('strengthText');
            
            if (password.length === 0) {
                strengthDiv.style.display = 'none';
                return;
            }
            
            strengthDiv.style.display = 'block';
            
            let strength = 0;
            let text = '';
            let color = '';
            
            // Check password criteria
            if (password.length >= 8) strength++;
            if (/[a-z]/.test(password)) strength++;
            if (/[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[^A-Za-z0-9]/.test(password)) strength++;
            
            switch (strength) {
                case 0:
                case 1:
                    text = 'Rất yếu';
                    color = '#e53e3e';
                    break;
                case 2:
                    text = 'Yếu';
                    color = '#dd6b20';
                    break;
                case 3:
                    text = 'Trung bình';
                    color = '#d69e2e';
                    break;
                case 4:
                    text = 'Mạnh';
                    color = '#38a169';
                    break;
                case 5:
                    text = 'Rất mạnh';
                    color = '#2f855a';
                    break;
            }
            
            strengthText.textContent = text;
            strengthText.style.color = color;
            strengthFill.style.width = (strength * 20) + '%';
            strengthFill.style.background = color;
        }

        // Add input animation effects
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });
            
            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });

        // Add form submission animation and validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const code = document.getElementById('code').value.trim();
            const password = document.getElementById('newPassword').value;
            
            // Basic validation
            if (code.length === 0) {
                e.preventDefault();
                alert('Vui lòng nhập mã xác nhận!');
                return;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                alert('Mật khẩu phải có ít nhất 6 ký tự!');
                return;
            }
            
            const button = this.querySelector('.btn-primary');
            button.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Đang xử lý...';
            button.disabled = true;
        });
    </script>
</body>
</html>
