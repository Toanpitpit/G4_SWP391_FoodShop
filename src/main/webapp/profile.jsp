<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Profile</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
        <style>
            body {
                background: white;
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                padding: 20px 0;
            }

            .profile-container {
                max-width: 1200px;
                margin: 0 auto;
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .profile-header {
                background: #3fb918;
                color: white;
                text-align: center;
                padding: 40px 20px;
                position: relative;
            }

            .profile-header h1 {
                font-size: 2.5rem;
                font-weight: 700;
                margin: 0;
                text-shadow: 0 2px 4px rgba(0,0,0,0.2);
            }

            .profile-content {
                display: flex;
                min-height: 600px;
            }

            .profile-sidebar {
                flex: 0 0 350px;
                background: #f8f9fc;
                padding: 40px 30px;
                border-right: 1px solid #e3e6f0;
            }

            .profile-picture-section {
                text-align: center;
                margin-bottom: 30px;
            }

            .profile-picture {
                width: 150px;
                height: 150px;
                border-radius: 50%;
                border: 5px solid white;
                box-shadow: 0 8px 20px rgba(0,0,0,0.15);
                margin-bottom: 20px;
                object-fit: cover;
            }

            .upload-btn {
                background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
                border: none;
                color: white;
                padding: 12px 24px;
                border-radius: 25px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .upload-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(78, 115, 223, 0.3);
            }

            .upload-btn:disabled {
                opacity: 0.6;
                cursor: not-allowed;
                transform: none;
            }

            .profile-form-section {
                flex: 1;
                padding: 40px;
            }

            .section-title {
                font-size: 1.5rem;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 30px;
                padding-bottom: 10px;
                border-bottom: 2px solid #e3e6f0;
            }

            .form-row {
                display: flex;
                gap: 20px;
                margin-bottom: 25px;
            }

            .form-group {
                flex: 1;
                margin-bottom: 25px;
            }

            .form-label {
                font-weight: 600;
                color: #34495e;
                margin-bottom: 8px;
                display: block;
            }

            .form-control {
                border: 2px solid #e3e6f0;
                border-radius: 10px;
                padding: 12px 16px;
                font-size: 14px;
                transition: all 0.3s ease;
                width: 100%;
            }

            .form-control:focus {
                border-color: #4e73df;
                box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.1);
                outline: none;
            }

            .form-control:disabled {
                background-color: #f8f9fa;
                opacity: 0.8;
            }

            .form-select {
                border: 2px solid #e3e6f0;
                border-radius: 10px;
                padding: 12px 16px;
                font-size: 14px;
                transition: all 0.3s ease;
                width: 100%;
                background-color: white;
            }

            .form-select:focus {
                border-color: #4e73df;
                box-shadow: 0 0 0 3px rgba(78, 115, 223, 0.1);
                outline: none;
            }

            .form-select:disabled {
                background-color: #f8f9fa;
                opacity: 0.8;
            }

            .btn-group {
                display: flex;
                gap: 15px;
                justify-content: space-between;
                margin-top: 40px;
                flex-wrap: wrap;
            }

            .btn-primary {
                background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
                border: none;
                color: white;
                padding: 12px 30px;
                border-radius: 25px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                cursor: pointer;
                min-width: 150px;
            }

            .btn-primary:hover:not(:disabled) {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(78, 115, 223, 0.3);
            }

            .btn-primary:disabled {
                opacity: 0.6;
                cursor: not-allowed;
                transform: none;
            }

            .btn-warning {
                background: linear-gradient(135deg, #f6c23e 0%, #dda20a 100%);
                border: none;
                color: white;
                padding: 12px 30px;
                border-radius: 25px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                cursor: pointer;
                min-width: 150px;
                text-decoration: none;
            }

            .btn-warning:hover:not(:disabled) {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(246, 194, 62, 0.3);
                color: white;
            }

            .btn-warning:disabled {
                opacity: 0.6;
                cursor: not-allowed;
                transform: none;
            }

            .btn-danger {
                background: linear-gradient(135deg, #e74a3b 0%, #c0392b 100%);
                border: none;
                color: white;
                padding: 12px 30px;
                border-radius: 25px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                cursor: pointer;
                min-width: 150px;
                text-decoration: none;
            }

            .btn-danger:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 20px rgba(231, 74, 59, 0.3);
                color: white;
            }

            .file-upload-info {
                font-size: 12px;
                color: #6c757d;
                margin-top: 10px;
                text-align: center;
            }

            .alert {
                border-radius: 15px;
                margin-bottom: 20px;
            }

            .oauth-notice {
                background: linear-gradient(135deg, #17a2b8 0%, #138496 100%);
                color: white;
                padding: 15px 20px;
                border-radius: 15px;
                margin-bottom: 20px;
                text-align: center;
            }

            .modal-content {
                border-radius: 15px;
                border: none;
                box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            }

            .modal-header {
                background: linear-gradient(135deg, #4e73df 0%, #224abe 100%);
                border-radius: 15px 15px 0 0;
            }

            .btn-secondary {
                background: #6c757d;
                border: none;
                color: white;
                padding: 10px 20px;
                border-radius: 20px;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-secondary:hover {
                background: #5a6268;
                transform: translateY(-1px);
            }

            @media (max-width: 768px) {
                .profile-content {
                    flex-direction: column;
                }

                .profile-sidebar {
                    flex: none;
                    border-right: none;
                    border-bottom: 1px solid #e3e6f0;
                }

                .form-row {
                    flex-direction: column;
                }

                .btn-group {
                    justify-content: center;
                    gap: 10px;
                }

                .btn-primary,
                .btn-warning,
                .btn-danger {
                    width: 100%;
                    max-width: 300px;
                }
            }
        </style>
    </head>
    <body>
        <div class="profile-container">
            <div class="profile-header">
                <h1>User Profile</h1>
            </div>

            <div class="profile-content">
                <c:if test="${empty sessionScope.Account}">
                    <div class="p-4 w-100">
                        <div class="alert alert-danger text-center" role="alert">
                            <i class="fas fa-exclamation-triangle"></i>
                            User session not found. Please <a href="login.jsp" class="alert-link">log in</a>.
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty sessionScope.Account}">
                    <c:choose>
                        <c:when test="${sessionScope.Account.role == 'USER_OAUTH'}">
                            <!-- OAuth User - Read Only -->
                            <div class="profile-sidebar">
                                <div class="oauth-notice">
                                    <i class="fas fa-info-circle"></i>
                                    OAuth users cannot edit profile information.
                                </div>
                                <div class="profile-picture-section">
                                    <img src="${not empty sessionScope.Account.image ? sessionScope.Account.image : 'img/avar/default-avatar.png'}?t=${System.currentTimeMillis()}" 
                                         alt="Profile Picture" class="profile-picture">
                                    <div>
                                        <button class="upload-btn" disabled>
                                            <i class="fas fa-camera"></i> Upload Disabled
                                        </button>
                                        <div class="file-upload-info">
                                            Image upload not available for OAuth users
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="profile-form-section">
                                <!-- Success/Error Messages for OAuth users -->
                                <c:if test="${not empty param.success}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle"></i> ${param.success}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty param.changePasswordSuccess}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle"></i> ${param.changePasswordSuccess}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty requestScope.error}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="fas fa-exclamation-triangle"></i> ${requestScope.error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <h2 class="section-title">Account Details</h2>

                                <form>
                                    <div class="form-group">
                                        <label for="username" class="form-label">Username</label>
                                        <input type="text" class="form-control" id="username" value="${sessionScope.Account.username}" disabled>
                                    </div>

                                    <div class="form-group">
                                        <label for="name" class="form-label">Full Name</label>
                                        <input type="text" class="form-control" id="name" value="${sessionScope.Account.name}" disabled>
                                    </div>

                                    <div class="form-group">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" value="${sessionScope.Account.email}" disabled>
                                    </div>

                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="phone" class="form-label">Phone</label>
                                            <input type="tel" class="form-control" id="phone" value="${sessionScope.Account.phone}" disabled>
                                        </div>

                                        <div class="form-group">
                                            <label for="gender" class="form-label">Gender</label>
                                            <select class="form-select" id="gender" disabled>
                                                <option value="" ${empty sessionScope.Account.gender ? 'selected' : ''}>Select Gender</option>
                                                <option value="Male" ${sessionScope.Account.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                <option value="Female" ${sessionScope.Account.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                <option value="Other" ${sessionScope.Account.gender == 'Other' ? 'selected' : ''}>Other</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="birthDate" class="form-label">Birth Date</label>
                                        <input type="date" class="form-control" id="birthDate" value="${sessionScope.Account.birthDate}" disabled>
                                    </div>

                                    <div class="btn-group">
                                        <button type="button" class="btn-primary" disabled>
                                            <i class="fas fa-save"></i> Update Profile
                                        </button>
                                        <a href="logout" class="btn-danger">
                                            <i class="fas fa-sign-out-alt"></i> Logout
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </c:when>
                            
                        <c:otherwise>
                            <!-- Regular User - Editable -->
                            <div class="profile-sidebar">
                                <div class="profile-picture-section">
                                    <img src="${not empty sessionScope.Account.image ? sessionScope.Account.image : 'img/avar/default-avatar.png'}?t=${System.currentTimeMillis()}" 
                                         alt="Profile Picture" class="profile-picture" id="profileImg">
                                    <div>
                                        <button class="upload-btn" onclick="document.getElementById('fileInput').click()">
                                            <i class="fas fa-camera"></i> Upload New Image
                                        </button>
                                        <div class="file-upload-info">
                                            JPG or PNG no larger than 5 MB
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="profile-form-section">
                                <!-- Success/Error Messages for regular users -->
                                <c:if test="${not empty param.success}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle"></i> ${param.success}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty param.changePasswordSuccess}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle"></i> ${param.changePasswordSuccess}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty requestScope.error}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="fas fa-exclamation-triangle"></i> ${requestScope.error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <h2 class="section-title">Account Details</h2>

                                <form action="profile" method="post" enctype="multipart/form-data">
                                    <input type="file" id="fileInput" name="image" accept="image/*" style="display: none;" onchange="previewImage(event)">

                                    <div class="form-group">
                                        <label for="username" class="form-label">Username</label>
                                        <input type="text" class="form-control" id="username" value="${sessionScope.Account.username}" disabled>
                                    </div>

                                    <div class="form-group">
                                        <label for="name" class="form-label">Full Name</label>
                                        <input type="text" class="form-control" id="name" name="name" value="${sessionScope.Account.name}">
                                    </div>

                                    <div class="form-group">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email" value="${sessionScope.Account.email}" required disabled>
                                    </div>

                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="phone" class="form-label">Phone</label>
                                            <input type="tel" class="form-control" id="phone" name="phone" value="${sessionScope.Account.phone}">
                                        </div>

                                        <div class="form-group">
                                            <label for="gender" class="form-label">Gender</label>
                                            <select class="form-select" id="gender" name="gender">
                                                <option value="" ${empty sessionScope.Account.gender ? 'selected' : ''}>Select Gender</option>
                                                <option value="Male" ${sessionScope.Account.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                <option value="Female" ${sessionScope.Account.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                <option value="Other" ${sessionScope.Account.gender == 'Other' ? 'selected' : ''}>Other</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="birthDate" class="form-label">Birth Date</label>
                                        <input type="date" class="form-control" id="birthDate" name="birthDate" value="${sessionScope.Account.birthDate}">
                                    </div>

                                    <div class="btn-group">
                                        <button type="submit" class="btn-primary">
                                            <i class="fas fa-save"></i> Update Profile
                                        </button>
                                        <button type="button" class="btn-warning" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                                            <i class="fas fa-key"></i> Change Password
                                        </button>
                                        <a href="logout" class="btn-danger">
                                            <i class="fas fa-sign-out-alt"></i> Logout
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>
        </div>

        <!-- Change Password Modal -->
        <c:if test="${sessionScope.user.role != 'USER_OAUTH'}">
            <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title text-white" id="changePasswordModalLabel">
                                <i class="fas fa-key"></i> Change Password
                            </h5>
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
                                    <button type="submit" class="btn-warning">
                                        <i class="fas fa-key"></i> Change Password
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                        function previewImage(event) {
                                            const file = event.target.files[0];
                                            if (file) {
                                                const reader = new FileReader();
                                                reader.onload = function (e) {
                                                    document.getElementById('profileImg').src = e.target.result;
                                                };
                                                reader.readAsDataURL(file);
                                            }
                                        }

                                        // Show change password modal if URL parameter exists
                                        const urlParams = new URLSearchParams(window.location.search);
                                        if (urlParams.get('showChangePassword') === 'true') {
                                            const changePasswordModal = new bootstrap.Modal(document.getElementById('changePasswordModal'));
                                            changePasswordModal?.show();
                                        }
        </script>
    </body>
</html>
