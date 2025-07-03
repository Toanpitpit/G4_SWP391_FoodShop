<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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

        .reset-password-container {
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

        .reset-password-container:hover {
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

        .reset-password-container::before {
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

        .resend-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 10px;
            padding: 12px 15px;
            background: rgba(40, 167, 69, 0.1);
            border-radius: 10px;
            border-left: 4px solid #28a745;
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .resend-text {
            font-size: 0.85rem;
            color: #28a745;
            margin: 0;
            font-weight: 500;
        }

        .countdown {
            font-weight: 700;
            color: #dc3545;
            font-size: 0.9rem;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .countdown i {
            animation: tick 1s ease-in-out infinite;
        }

        @keyframes tick {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.2); }
        }

        .resend-btn-container {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .resend-btn {
            background: #28a745;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            color: white;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .resend-btn:hover {
            background: #20c997;
            transform: translateY(-1px);
        }

        .resend-btn:disabled {
            background: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
        }

        /* Pulse animation for when countdown is running */
        .countdown-active {
            animation: countdownPulse 1s ease-in-out infinite;
        }

        @keyframes countdownPulse {
            0%, 100% { 
                background: rgba(40, 167, 69, 0.1);
                border-left-color: #28a745;
                transform: scale(1);
            }
            50% { 
                background: rgba(220, 53, 69, 0.1);
                border-left-color: #dc3545;
                transform: scale(1.02);
            }
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

        .alert-info {
            background: rgba(23, 162, 184, 0.1);
            color: #0c5460;
            border-left: 4px solid #17a2b8;
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

        .password-strength {
            margin-top: 10px;
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
            .reset-password-container {
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

            .resend-section {
                flex-direction: column;
                gap: 10px;
                text-align: center;
                padding: 15px;
            }

            .resend-btn-container {
                justify-content: center;
            }
        }

        /* Focus trap styling */
        .reset-password-container:focus-within {
            box-shadow: 
                0 30px 60px rgba(0, 0, 0, 0.2),
                0 0 0 1px rgba(40, 167, 69, 0.3);
        }
        
        /* THÊM CSS CHO ICON CON MẮT */
        #togglePasswordIcon {
            transition: all 0.3s ease;
        }

        #togglePasswordIcon:hover {
            color: #28a745 !important;
            transform: translateY(-50%) scale(1.1);
        }

        .input-group {
            position: relative;
        }

        /* Đảm bảo icon không bị che bởi các element khác */
        .form-control:focus + .input-icon + #togglePasswordIcon {
            color: #28a745;
        }
    </style>
</head>
<body>
    <div class="reset-password-container">
        <div class="header-section">
            <div class="lock-icon">
                <i class="fas fa-key"></i>
            </div>
            <h2 class="main-title">Reset password</h2>
            <p class="subtitle">Enter your verification code and new password to complete the password reset.</p>
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

            <c:if test="${not empty info}">
                <div class="alert alert-info" role="alert">
                    <i class="fas fa-info-circle me-2"></i>${info}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/ResetPasswordController" method="post" id="resetPasswordForm">
                <div class="form-group">
                    <label for="code" class="form-label">Verification code</label>
                    <div class="input-group">
                        <input type="text" class="form-control" id="code" name="code" required 
                               placeholder="Enter verification code from email" maxlength="10" autocomplete="off">
                        <i class="fas fa-shield-alt input-icon"></i>
                    </div>
                    
                    <!-- Resend Code Section -->
                    <div class="resend-section" id="resendSection">
                        <div>
                            <p class="resend-text">
                                Didn't receive the code?
                            </p>
                            <div id="countdownDisplay" class="countdown">
                                <i class="fas fa-clock"></i>
                                <span id="countdownText">Resend in <span id="timeRemaining">60</span>s</span>
                            </div>
                        </div>
                        <div class="resend-btn-container">
                            <button type="button" class="resend-btn" id="resendBtn" onclick="resendCode()" style="display: none;">
                                <i class="fas fa-paper-plane"></i>
                                Resend code
                            </button>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="newPassword" class="form-label">New password</label>
                    <div class="input-group">
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required 
                               placeholder="Enter a new password" minlength="8" onkeyup="checkPasswordStrength(this.value)">
                        <i class="fas fa-lock input-icon"></i>
                        <i class="fas fa-eye" id="togglePasswordIcon" onclick="togglePasswordVisibility()" 
                           style="position: absolute; 
                                  right: 20px; 
                                  top: 50%; 
                                  transform: translateY(-50%); 
                                  cursor: pointer; 
                                  z-index: 5; 
                                  color: #6c757d; 
                                  font-size: 16px;"></i>
                    </div>
                    
                    <div class="password-strength" id="passwordStrength" style="display: none;">
                        <div class="strength-bar">
                            <div class="strength-fill" id="strengthFill"></div>
                        </div>
                        <span id="strengthText"></span>
                    </div>
                    
                    <div class="password-requirements" style="margin-top: 10px; margin-bottom: 20px; font-size: 0.85rem; color: #6c757d;">
                        <p style="margin-bottom: 8px; font-weight: 600;">Password must contain:</p>
                        <ul style="margin: 0; padding-left: 20px;">
                            <li>At least 8 characters</li>
                            <li>One lowercase letter (a-z)</li>
                            <li>One uppercase letter (A-Z)</li>
                            <li>One number (0-9)</li>
                            <li>One special character (@#$%^&+=!)</li>
                        </ul>
                    </div>
                </div>
                
                <input type="hidden" name="email" value="${email}">
                
                <button type="submit" class="btn btn-primary" id="submitBtn">
                    <i class="fas fa-sync-alt me-2"></i>
                    Reset password
                </button>
            </form>

            <div class="back-link">
                <a href="${pageContext.request.contextPath}/ForgotPasswordController">
                    <i class="fas fa-arrow-left"></i>
                    Back to forgot password
                </a>
            </div>
        </div>
    </div>

    <!-- Resend Code Response Modal -->
    <div class="modal fade" id="resendModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resendModalTitle">Successfully</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="resendModalBody">
                    <!-- Response content will be inserted here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function togglePasswordVisibility() {
        const passwordInput = document.getElementById('newPassword');
        const toggleIcon = document.getElementById('togglePasswordIcon');

        if (passwordInput.type === 'password') {
            // Hiện password
            passwordInput.type = 'text';
            toggleIcon.classList.remove('fa-eye');
            toggleIcon.classList.add('fa-eye-slash');
            toggleIcon.style.color = '#28a745';
        } else {
            // Ẩn password
            passwordInput.type = 'password';
            toggleIcon.classList.remove('fa-eye-slash');
            toggleIcon.classList.add('fa-eye');
            toggleIcon.style.color = '#6c757d';
        }
    }

        let countdownTimer;
        let countdownSeconds = 60;
        const COUNTDOWN_KEY = 'resetPasswordCountdown';
        const EMAIL_KEY = 'resetPasswordEmail';

        // Lấy email hiện tại
        function getCurrentEmail() {
            return document.querySelector('input[name="email"]').value || 
                   localStorage.getItem(EMAIL_KEY) || '';
        }

        // Lưu thông tin countdown vào localStorage
        function saveCountdownToStorage(seconds, email) {
            const countdownData = {
                remainingTime: seconds,
                startTime: Date.now(),
                email: email
            };
            localStorage.setItem(COUNTDOWN_KEY, JSON.stringify(countdownData));
            localStorage.setItem(EMAIL_KEY, email);
        }

        // Lấy thông tin countdown từ localStorage
        function getCountdownFromStorage() {
            const data = localStorage.getItem(COUNTDOWN_KEY);
            if (!data) return null;

            try {
                const countdownData = JSON.parse(data);
                const currentEmail = getCurrentEmail();

                // Kiểm tra xem có phải cùng email không
                if (countdownData.email !== currentEmail) {
                    clearCountdownStorage();
                    return null;
                }

                // Tính thời gian đã trôi qua
                const elapsedTime = Math.floor((Date.now() - countdownData.startTime) / 1000);
                const remainingTime = Math.max(0, countdownData.remainingTime - elapsedTime);

                return remainingTime;
            } catch (e) {
                clearCountdownStorage();
                return null;
            }
        }

        // Xóa countdown storage
        function clearCountdownStorage() {
            localStorage.removeItem(COUNTDOWN_KEY);
            localStorage.removeItem(EMAIL_KEY);
        }

        // Khởi tạo countdown khi trang load
        window.addEventListener('load', function() {
            const currentEmail = getCurrentEmail();
            if (!currentEmail) return;

            // Kiểm tra xem có countdown đang chạy không
            const savedCountdown = getCountdownFromStorage();

            if (savedCountdown !== null && savedCountdown > 0) {
                // Tiếp tục countdown từ thời điểm đã lưu
                startCountdown(savedCountdown);
            } else {
                // Bắt đầu countdown mới nếu có thông báo success
                const hasSuccess = document.querySelector('.alert-success') !== null;
                if (hasSuccess) {
                    startCountdown(60);
                } else {
                    // Hiển thị nút resend ngay lập tức
                    showResendButton();
                }
            }
        });

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

            // Kiểm tra các tiêu chí mật khẩu mạnh (CẬP NHẬT THEO TIÊU CHÍ MỚI)
            if (password.length >= 8) strength++;
            if (/[a-z]/.test(password)) strength++;
            if (/[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[@#$%^&+=!]/.test(password)) strength++;

            switch (strength) {
                case 0:
                case 1:
                case 2:
                    text = 'Weak - Need all requirements';
                    color = '#e53e3e';
                    break;
                case 3:
                    text = 'Fair - Missing some requirements';
                    color = '#dd6b20';
                    break;
                case 4:
                    text = 'Good - Almost there';
                    color = '#d69e2e';
                    break;
                case 5:
                    text = 'Strong - Perfect!';
                    color = '#38a169';
                    break;
            }

            strengthText.textContent = text;
            strengthText.style.color = color;
            strengthFill.style.width = (strength * 20) + '%';
            strengthFill.style.background = color;
        }

        function resendCode() {
            const email = getCurrentEmail();
            const resendBtn = document.getElementById('resendBtn');

            if (!email) {
                showModal('Error', 'Email not found!', 'danger');
                return;
            }

            // Disable button and show loading
            resendBtn.disabled = true;
            resendBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i> Sending...';

            // Create AJAX request
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '${pageContext.request.contextPath}/ForgotPasswordController', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        const response = xhr.responseText.trim();

                        if (response.includes('The verification code has been sent')) {
                            showModal('Successfully', response, 'success');
                            startCountdown(60); // Bắt đầu countdown mới
                        } else {
                            showModal('Error', response, 'danger');
                            showResendButton();
                        }
                    } else {
                        showModal('Error', 'Errors occurred while sending the request!', 'danger');
                        showResendButton();
                    }
                }
            };

            xhr.send('email=' + encodeURIComponent(email) + '&action=resend');
        }

        function showModal(title, message, type) {
            const modal = new bootstrap.Modal(document.getElementById('resendModal'));
            const titleEl = document.getElementById('resendModalTitle');
            const bodyEl = document.getElementById('resendModalBody');

            titleEl.textContent = title;

            let iconClass = '';
            let colorClass = '';

            switch(type) {
                case 'success':
                    iconClass = 'fas fa-check-circle text-success';
                    colorClass = 'text-success';
                    break;
                case 'danger':
                    iconClass = 'fas fa-exclamation-triangle text-danger';
                    colorClass = 'text-danger';
                    break;
                default:
                    iconClass = 'fas fa-info-circle text-info';
                    colorClass = 'text-info';
            }

            bodyEl.innerHTML = `<div class="d-flex align-items-center">
                <i class="${iconClass} me-2 fs-4"></i>
                <span class="${colorClass}">${message}</span>
            </div>`;

            modal.show();
        }

        function startCountdown(seconds) {
            countdownSeconds = seconds;
            const currentEmail = getCurrentEmail();
            const resendBtn = document.getElementById('resendBtn');
            const countdownDisplay = document.getElementById('countdownDisplay');
            const timeRemaining = document.getElementById('timeRemaining');
            const resendSection = document.getElementById('resendSection');

            // Lưu countdown vào localStorage
            saveCountdownToStorage(seconds, currentEmail);

            // Hide resend button and show countdown
            resendBtn.style.display = 'none';
            countdownDisplay.style.display = 'flex';
            resendSection.classList.add('countdown-active');

            // Clear any existing timer
            if (countdownTimer) {
                clearInterval(countdownTimer);
            }

            countdownTimer = setInterval(function() {
                timeRemaining.textContent = countdownSeconds;

                countdownSeconds--;

                // Cập nhật localStorage mỗi giây
                if (countdownSeconds >= 0) {
                    saveCountdownToStorage(countdownSeconds, currentEmail);
                }

                if (countdownSeconds < 0) {
                    clearInterval(countdownTimer);
                    clearCountdownStorage(); // Xóa storage khi hết thời gian
                    showResendButton();
                }
            }, 1000);
        }

        function showResendButton() {
            const resendBtn = document.getElementById('resendBtn');
            const countdownDisplay = document.getElementById('countdownDisplay');
            const resendSection = document.getElementById('resendSection');

            // Reset button state
            resendBtn.disabled = false;
            resendBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Resend code';

            // Show button and hide countdown
            resendBtn.style.display = 'inline-block';
            countdownDisplay.style.display = 'none';
            resendSection.classList.remove('countdown-active');

            // Clear timer and storage
            if (countdownTimer) {
                clearInterval(countdownTimer);
            }
            clearCountdownStorage();
        }

        // Enhanced focus effects
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.style.transform = 'scale(1.02)';
            });

            input.addEventListener('blur', function() {
                this.parentElement.style.transform = 'scale(1)';
            });
        });

        // Form submission với validation mật khẩu mạnh
        document.getElementById('resetPasswordForm').addEventListener('submit', function(e) {
            const code = document.getElementById('code').value.trim();
            const password = document.getElementById('newPassword').value;

            // Basic validation
            if (code.length === 0) {
                e.preventDefault();
                alert('Please enter the verification code!');
                return;
            }

            // VALIDATION MẬT KHẨU MẠNH
            if (password.length < 8) {
                e.preventDefault();
                alert('Password must be at least 8 characters long!');
                return;
            }

            if (!/[a-z]/.test(password)) {
                e.preventDefault();
                alert('Password must contain at least one lowercase letter!');
                return;
            }

            if (!/[A-Z]/.test(password)) {
                e.preventDefault();
                alert('Password must contain at least one uppercase letter!');
                return;
            }

            if (!/[0-9]/.test(password)) {
                e.preventDefault();
                alert('Password must contain at least one number!');
                return;
            }

            if (!/[@#$%^&+=!]/.test(password)) {
                e.preventDefault();
                alert('Password must contain at least one special character (@#$%^&+=!)!');
                return;
            }

            // Nếu validation pass, xóa countdown storage
            clearCountdownStorage();

            const submitBtn = document.getElementById('submitBtn');
            submitBtn.classList.add('btn-loading');
            submitBtn.innerHTML = 'Sending...';
            submitBtn.disabled = true;
        });

        // Auto-hide existing alerts after 5 seconds
        const alerts = document.querySelectorAll('.alert:not(#resendSuccessAlert)');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.animation = 'alertSlide 0.5s ease-out reverse';
                setTimeout(() => {
                    alert.style.display = 'none';
                }, 500);
            }, 5000);
        });

        // Add floating animation to container
        const container = document.querySelector('.reset-password-container');
        container.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px) scale(1.02)';
        });

        container.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });

        // Cleanup khi trang unload
        window.addEventListener('beforeunload', function() {
            if (countdownTimer) {
                clearInterval(countdownTimer);
            }
        });

        // Xử lý khi user chuyển tab (visibility change)
        document.addEventListener('visibilitychange', function() {
            if (!document.hidden) {
                // Khi user quay lại tab, kiểm tra countdown
                const savedCountdown = getCountdownFromStorage();
                if (savedCountdown !== null && savedCountdown > 0) {
                    startCountdown(savedCountdown);
                } else if (savedCountdown === 0) {
                    showResendButton();
                }
            }
        });
    </script>

</body>
</html>
