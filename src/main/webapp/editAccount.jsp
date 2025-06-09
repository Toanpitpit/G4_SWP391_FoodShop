<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Edit Account - Healthy Food</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .navbar {
            background-color: #28a745;
            padding: 15px 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .navbar .container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar .logo {
            color: #fff;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
        }

        .navbar .nav-links a {
            color: #fff;
            margin-left: 20px;
            text-decoration: none;
            font-size: 16px;
        }

        .navbar .nav-links a:hover {
            color: #f1f1f1;
        }

        .user-menu {
            position: relative;
            display: inline-block;
        }

        .user-btn {
            background-color: #fff;
            color: #28a745;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 20px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .user-btn:hover {
            background-color: #f1f1f1;
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            top: 50px;
            right: 0;
            background-color: #fff;
            min-width: 150px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            z-index: 1;
        }

        .dropdown-menu a {
            display: block;
            padding: 10px 15px;
            color: #333;
            text-decoration: none;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .dropdown-menu a:hover {
            background-color: #f1f1f1;
            color: #28a745;
        }

        .dropdown-menu.show {
            display: block;
        }

        .container {
            max-width: 600px;
            margin: 30px auto;
            padding: 0 15px;
        }

        h1 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #28a745;
            text-align: center;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="date"],
        select,
        input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus,
        input[type="date"]:focus,
        select:focus,
        input[type="file"]:focus {
            border-color: #28a745;
            outline: none;
            box-shadow: 0 0 5px rgba(40, 167, 69, 0.3);
        }

        input[readonly] {
            background-color: #f1f1f1;
            cursor: not-allowed;
        }

        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            background-color: #218838;
        }

        .back-link {
            display: inline-block;
            margin-top: 15px;
            text-decoration: none;
            color: #28a745;
            font-size: 16px;
        }

        .back-link:hover {
            color: #218838;
        }

        @media (max-width: 768px) {
            .navbar .container {
                flex-direction: column;
                text-align: center;
            }

            .navbar .nav-links {
                margin-top: 10px;
            }

            .navbar .nav-links a {
                margin: 0 10px;
            }

            .user-menu {
                margin-top: 10px;
            }

            .dropdown-menu {
                top: 60px;
                right: 10px;
            }

            .container {
                padding: 0 10px;
            }

            form {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="container">
            <a href="${pageContext.request.contextPath}/" class="logo">Healthy Food</a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/">Home</a>
                <a href="${pageContext.request.contextPath}/about">About Us</a>
                <a href="${pageContext.request.contextPath}/products">Products</a>
                <a href="${pageContext.request.contextPath}/contact">Contact Us</a>
            </div>
            <div class="user-menu">
                <div class="user-btn" onclick="toggleDropdown()">👤</div>
                <div class="dropdown-menu" id="userDropdown">
                    <a href="${pageContext.request.contextPath}/profile">View Profile</a>
                    <a href="${pageContext.request.contextPath}/logout">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <h1>Edit Account</h1>
        <c:if test="${not empty error}">
            <p style="color: red; margin-bottom: 15px;">${error}</p>
        </c:if>
        <form action="${pageContext.request.contextPath}/adminDashboard" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="${user.id}">
            <div class="form-group">
                <label for="username">Tên đăng nhập:</label>
                <input type="text" id="username" name="username" value="${user.username}" required>
            </div>
            <div class="form-group">
                <label for="pass">Mật khẩu:</label>
                <input type="password" id="pass" name="pass" placeholder="Để trống để giữ mật khẩu hiện tại">
            </div>
            <div class="form-group">
                <label for="name">Họ tên:</label>
                <input type="text" id="name" name="name" value="${user.name}" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${user.email}" required>
            </div>
            <div class="form-group">
                <label for="phone">Số điện thoại:</label>
                <input type="text" id="phone" name="phone" value="${user.phone}" required>
            </div>
            <div class="form-group">
                <label for="gender">Giới tính:</label>
                <select id="gender" name="gender" required>
                    <option value="">Chọn giới tính</option>
                    <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                    <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                </select>
            </div>
            <div class="form-group">
                <label for="birthDate">Ngày sinh:</label>
                <input type="date" id="birthDate" name="birthDate" value="${user.birthDate}" required>
            </div>
            <div class="form-group">
                <label for="role">Vai trò:</label>
                <input type="text" id="role" name="role" value="${user.role}" required readonly>
            </div>
            <div class="form-group">
                <label for="status">Trạng thái:</label>
                <input type="text" id="status" name="status" value="${user.status}" readonly>
            </div>
            <div class="form-group">
                <label for="currentImage">Hình ảnh hiện tại:</label>
                <input type="text" id="currentImage" name="currentImage" value="${user.image}" readonly>
                <c:if test="${not empty user.image}">
                    <img src="${pageContext.request.contextPath}/${user.image}" alt="Current Avatar" style="max-width: 100px; margin-top: 10px;">
                </c:if>
            </div>
            <div class="form-group">
                <label for="image">Tải lên ảnh mới:</label>
                <input type="file" id="image" name="image" accept="image/jpeg,image/png,image/jpg">
            </div>
            <button type="submit">Cập nhật tài khoản</button>
        </form>
        <a href="${pageContext.request.contextPath}/adminDashboard" class="back-link">Quay lại Dashboard</a>
    </div>

    <script>
        function toggleDropdown() {
            document.getElementById("userDropdown").classList.toggle("show");
        }

        window.onclick = function(event) {
            if (!event.target.matches('.user-btn')) {
                var dropdowns = document.getElementsByClassName("dropdown-menu");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }

        document.addEventListener("DOMContentLoaded", function() {
            const today = new Date();
            today.setDate(today.getDate() - 1);
            const maxDate = today.toISOString().split("T")[0];
            document.getElementById("birthDate").setAttribute("max", maxDate);
        });
    </script>
</body>
</html>
