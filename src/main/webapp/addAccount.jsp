<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Add Account - Healthy Food</title>
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

        /* Navbar */
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

        /* Main Content */
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

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
        }

        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="date"],
        select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        input[type="text"]:focus,
        input[type="password"]:focus,
        input[type="email"]:focus,
        input[type="date"]:focus,
        select:focus {
            border-color: #28a745;
            outline: none;
            box-shadow: 0 0 5px rgba(40, 167, 69, 0.3);
        }

        input[readonly] {
            background-color: #f1f1f1;
            cursor: not-allowed;
        }

        button[type="submit"] {
            display: block;
            width: 100%;
            padding: 12px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
            margin-top: 20px;
        }

        button[type="submit"]:hover {
            background-color: #218838;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
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
        <h1>Thêm tài khoản mới</h1>
        <c:if test="${not empty error}">
            <p style="color: red; margin-bottom: 15px;">${error}</p>
        </c:if>
        <form action="${pageContext.request.contextPath}/adminDashboard" method="post">
            <input type="hidden" name="action" value="add">
            <label>Tên đăng nhập: <input type="text" name="username" required></label>
            <label>Mật khẩu: <input type="password" name="pass" required></label>
            <label>Họ tên: <input type="text" name="name" required></label>
            <label>Email: <input type="email" name="email" required></label>
            <label>Số điện thoại: <input type="text" name="phone" required></label>
            <label>Giới tính:
                <select name="gender" required>
                    <option value="">Chọn giới tính</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                </select>
            </label>
            <label>Ngày sinh: <input type="date" name="birthDate" required></label>
            <label>Vai trò: <input type="text" name="role" value="Member" required></label>
            <label>Trạng thái: <input type="text" name="status" value="Active" readonly></label>
            <label>Hình ảnh: <input type="text" name="image" required></label>
            <button type="submit">Thêm tài khoản</button>
        </form>
        <a href="${pageContext.request.contextPath}/adminDashboard" class="back-link">Quay lại Dashboard</a>
    </div>

    <script>
        function toggleDropdown() {
            document.getElementById("userDropdown").classList.toggle("show");
        }

        // Close dropdown when clicking outside
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

        // Set max date to yesterday 
        document.addEventListener("DOMContentLoaded", function() {
            const today = new Date();
            today.setDate(today.getDate() - 1); // Set to yesterday
            const maxDate = today.toISOString().split("T")[0];
            document.querySelector("input[name='birthDate']").setAttribute("max", maxDate);
        });
    </script>
</body>
</html>