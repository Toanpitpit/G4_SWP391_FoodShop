<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
       body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #28a745 0%, #20c997 50%, #4fd69c 100%);
    min-height: 100vh;
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

.profile-container {
    max-width: 1000px;
    margin: 40px auto;
    padding: 0 20px;
}

.card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    border: none;
    border-radius: 20px;
    box-shadow: 
        0 20px 40px rgba(0, 0, 0, 0.1),
        0 0 0 1px rgba(255, 255, 255, 0.2);
    overflow: hidden;
    transform: translateY(0);
    transition: all 0.3s ease;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 
        0 30px 60px rgba(0, 0, 0, 0.15),
        0 0 0 1px rgba(255, 255, 255, 0.3);
}

.card-header {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%) !important;
    border: none;
    padding: 30px;
    position: relative;
    overflow: hidden;
}

.card-header::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
    animation: shimmer 3s ease-in-out infinite;
}

@keyframes shimmer {
    0% { left: -100%; }
    50% { left: 100%; }
    100% { left: 100%; }
}

.card-header h3 {
    font-weight: 700;
    font-size: 2rem;
    margin: 0;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.card-body {
    padding: 40px !important;
    background: rgba(255, 255, 255, 0.8);
}

.avatar-container {
    position: relative;
    display: inline-block;
    margin-bottom: 20px;
}

.avatar-img {
    width: 150px;
    height: 150px;
    object-fit: cover;
    border-radius: 50%;
    border: 4px solid #fff;
    box-shadow: 
        0 8px 25px rgba(40, 167, 69, 0.3),
        0 0 0 3px rgba(40, 167, 69, 0.1);
    transition: all 0.3s ease;
}

.avatar-img:hover {
    transform: scale(1.05);
    box-shadow: 
        0 12px 35px rgba(40, 167, 69, 0.4),
        0 0 0 3px rgba(40, 167, 69, 0.2);
}

.avatar-label {
    position: absolute;
    bottom: 10px;
    right: 10px;
    background: linear-gradient(135deg, #28a745, #20c997);
    color: white;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.4);
}

.avatar-label:hover {
    transform: scale(1.1);
    box-shadow: 0 6px 20px rgba(40, 167, 69, 0.6);
}

.avatar-input {
    display: none;
}

.form-section {
    padding: 20px;
}

.form-label {
    color: #333;
    font-weight: 600;
    margin-bottom: 8px;
    font-size: 0.95rem;
}

.form-control, .form-select {
    border: 2px solid #e9ecef;
    border-radius: 12px;
    padding: 12px 16px;
    font-size: 1rem;
    transition: all 0.3s ease;
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
}

.form-control:focus, .form-select:focus {
    border-color: #28a745;
    box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
    background: rgba(255, 255, 255, 1);
}

.form-control:disabled, .form-select:disabled {
    background-color: rgba(248, 249, 250, 0.8);
    border-color: #dee2e6;
    color: #6c757d;
}

.btn {
    border-radius: 12px;
    padding: 12px 24px;
    font-weight: 600;
    font-size: 1rem;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.btn-primary {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    border: none;
    color: white;
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
    background: linear-gradient(135deg, #218838 0%, #1ea080 100%);
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(40, 167, 69, 0.4);
}

.btn-primary:disabled {
    background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
    opacity: 0.6;
}

.btn-warning {
    background: linear-gradient(135deg, #ffc107 0%, #ff8c00 100%);
    border: none;
    color: #333;
}

.btn-warning:hover {
    background: linear-gradient(135deg, #e0a800 0%, #e67e00 100%);
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(255, 193, 7, 0.4);
    color: #333;
}

.btn-danger {
    background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
    border: none;
    color: white;
}

.btn-danger:hover {
    background: linear-gradient(135deg, #c82333 0%, #a71e2a 100%);
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(220, 53, 69, 0.4);
}

.btn-secondary {
    background: linear-gradient(135deg, #6c757d 0%, #5a6268 100%);
    border: none;
    color: white;
}

.btn-secondary:hover {
    background: linear-gradient(135deg, #5a6268 0%, #495057 100%);
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(108, 117, 125, 0.4);
}

.alert {
    border-radius: 12px;
    border: none;
    padding: 16px 20px;
    margin-bottom: 20px;
    backdrop-filter: blur(10px);
    font-weight: 500;
}

.alert-success {
    background: rgba(25, 135, 84, 0.1);
    color: #0f5132;
    border-left: 4px solid #198754;
}

.alert-danger {
    background: rgba(220, 53, 69, 0.1);
    color: #721c24;
    border-left: 4px solid #dc3545;
}

.alert-info {
    background: rgba(13, 110, 253, 0.1);
    color: #055160;
    border-left: 4px solid #0dcaf0;
}

.modal-content {
    border-radius: 20px;
    border: none;
    backdrop-filter: blur(20px);
    background: rgba(255, 255, 255, 0.95);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
}

.modal-header {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%) !important;
    border: none;
    border-top-left-radius: 20px;
    border-top-right-radius: 20px;
    padding: 20px 30px;
}

.modal-header h5 {
    font-weight: 700;
    margin: 0;
}

.modal-body {
    padding: 30px;
}

.btn-close-white {
    filter: brightness(0) invert(1);
}

/* Loading animation */
.btn.loading {
    pointer-events: none;
}

.btn.loading::after {
    content: '';
    position: absolute;
    width: 20px;
    height: 20px;
    border: 2px solid transparent;
    border-top: 2px solid currentColor;
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

/* Responsive design */
@media (max-width: 768px) {
    .profile-container {
        margin: 20px auto;
        padding: 0 15px;
    }
    
    .card-body {
        padding: 20px !important;
    }
    
    .form-section {
        padding: 15px;
    }
    
    .avatar-img {
        width: 120px;
        height: 120px;
    }
    
    .card-header h3 {
        font-size: 1.5rem;
    }
    
    .d-flex.justify-content-between {
        flex-direction: column;
        gap: 10px;
    }
    
    .btn {
        width: 100%;
    }
}

@media (max-width: 576px) {
    .row {
        flex-direction: column;
    }
    
    .col-md-4, .col-md-8 {
        flex: 0 0 auto;
        width: 100%;
    }
    
    .text-center {
        margin-bottom: 20px;
    }
}
    </style>
</head>
<body>
<div class="profile-container">
    <div class="card">
        <div class="card-header bg-primary text-white text-center py-4">
            <h3 class="mb-0">User Profile</h3>
        </div>
        <div class="card-body p-4">
            <c:if test="${empty sessionScope.Account}">
                <div class="alert alert-danger" role="alert">
                    User session not found. Please <a href="login.jsp" class="alert-link">log in</a>.
                </div>
            </c:if>
            <c:if test="${not empty sessionScope.Account}">
                <c:if test="${not empty param.success}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        ${param.success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${not empty requestScope.error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${requestScope.error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${sessionScope.Account.role == 'USER_OAUTH'}">
                        <div class="alert alert-info" role="alert">
                            OAuth users cannot edit profile information.
                        </div>
                        <form>
                            <div class="row">
                                <div class="col-md-4 text-center form-section">
                                    <div class="avatar-container">
                                        <img src="${not empty sessionScope.Account.image ? sessionScope.user.image : 'img/avar/default-avatar.png'}?t=${System.currentTimeMillis()}" alt="Avatar" class="avatar-img">
                                    </div>
                                </div>
                                <div class="col-md-8 form-section">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Username</label>
                                        <input type="text" class="form-control" id="username" value="${sessionScope.Account.username}" disabled>
                                    </div>
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Full Name</label>
                                        <input type="text" class="form-control" id="name" value="${sessionScope.Account.name}" disabled>
                                    </div>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" value="${sessionScope.Account.email}" disabled>
                                    </div>
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Phone</label>
                                        <input type="text" class="form-control" id="phone" value="${sessionScope.Account.phone}" disabled>
                                    </div>
                                    <div class="mb-3">
                                        <label for="gender" class="form-label">Gender</label>
                                        <select class="form-select" id="gender" disabled>
                                            <option value="" ${empty sessionScope.Account.gender ? 'selected' : ''}>Select Gender</option>
                                            <option value="Male" ${sessionScope.Account.gender == 'Male' ? 'selected' : ''}>Male</option>
                                            <option value="Female" ${sessionScope.Account.gender == 'Female' ? 'selected' : ''}>Female</option>
                                            <option value="Other" ${sessionScope.Account.gender == 'Other' ? 'selected' : ''}>Other</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="birthDate" class="form-label">Birth Date</label>
                                        <input type="date" class="form-control" id="birthDate" value="${sessionScope.Account.birthDate}" disabled>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between flex-wrap gap-2 p-3">
                                <button type="button" class="btn btn-primary" disabled>Update Profile</button>
                                <a href="logout" class="btn btn-danger">Logout</a>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form action="profile" method="post" enctype="multipart/form-data">
                            <div class="row">
                                <div class="col-md-4 text-center form-section">
                                    <div class="avatar-container">
                                        <img src="${not empty sessionScope.Account.image ? sessionScope.Account.image : 'img/avar/default-avatar.png'}?t=${System.currentTimeMillis()}" alt="Avatar" class="avatar-img">
                                        <label for="image" class="avatar-label"><i class="fas fa-camera"></i></label>
                                        <input type="file" class="avatar-input" id="image" name="image" accept="image/*">
                                    </div>
                                </div>
                                <div class="col-md-8 form-section">
                                    <div class="mb-3">
                                        <label for="username" class="form-label">Username</label>
                                        <input type="text" class="form-control" id="username" value="${sessionScope.Account.username}" disabled>
                                    </div>
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Full Name</label>
                                        <input type="text" class="form-control" id="name" name="name" value="${sessionScope.Account.name}">
                                    </div>
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" value="${sessionScope.Account.email}" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Phone</label>
                                        <input type="text" class="form-control" id="phone" name="phone" value="${sessionScope.Account.phone}">
                                    </div>
                                    <div class="mb-3">
                                        <label for="gender" class="form-label">Gender</label>
                                        <select class="form-select" id="gender" name="gender">
                                            <option value="" ${empty sessionScope.Account.gender ? 'selected' : ''}>Select Gender</option>
                                            <option value="Male" ${sessionScope.Account.gender == 'Male' ? 'selected' : ''}>Male</option>
                                            <option value="Female" ${sessionScope.Account.gender == 'Female' ? 'selected' : ''}>Female</option>
                                            <option value="Other" ${sessionScope.Account.gender == 'Other' ? 'selected' : ''}>Other</option>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label for="birthDate" class="form-label">Birth Date</label>
                                        <input type="date" class="form-control" id="birthDate" name="birthDate" value="${sessionScope.Account.birthDate}">
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between flex-wrap gap-2 p-3">
                                <button type="submit" class="btn btn-primary">Update Profile</button>
                                <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#changePasswordModal">Change Password</button>
                                <a href="logout" class="btn btn-danger">Logout</a>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>
    </div>
</div>

<!-- Change Password Modal (Chỉ hiển thị nếu không phải USER_OAUTH) -->
<c:if test="${sessionScope.Account.role != 'USER_OAUTH'}">
    <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" ariainità

-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="changePasswordModalLabel">Change Password</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="changePassword" method="post">
                        <div class="mb-3">
                            <label for="oldPassword" class="form-label">Old Password</label>
                            <input type="password" class="form-control" id="oldPassword" name="oldPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm New Password</label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        </div>
                        <div class="d-flex justify-content-end gap-2">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-warning">Change Password</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</c:if>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('image')?.addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                document.querySelector('.avatar-img').src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });

    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('showChangePassword') === 'true') {
        const changePasswordModal = new bootstrap.Modal(document.getElementById('changePasswordModal'));
        changePasswordModal?.show();
    }
</script>
</body>
</html>
