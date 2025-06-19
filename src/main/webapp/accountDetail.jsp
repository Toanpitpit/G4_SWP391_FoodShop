<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Account Details - Healthy Food</title>
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
            max-width: 800px;
            margin: 30px auto;
            padding: 0 15px;
        }

        h1 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #28a745;
            text-align: center;
        }

        .detail-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .detail-box p {
            margin-bottom: 10px;
            font-size: 16px;
        }

        .detail-box p strong {
            display: inline-block;
            width: 120px;
        }

        .action-buttons {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        .action-btn {
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background-color 0.3s;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        .edit-btn {
            background-color: #007bff;
        }

        .edit-btn:hover {
            background-color: #0056b3;
        }

        .delete-btn {
            background-color: #dc3545;
        }

        .delete-btn:hover {
            background-color: #c82333;
        }

        .back-btn {
            background-color: #6c757d;
        }

        .back-btn:hover {
            background-color: #5a6268;
        }

        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            max-width: 400px;
            width: 90%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .modal-content p {
            margin-bottom: 20px;
            font-size: 16px;
        }

        .modal-buttons {
            display: flex;
            justify-content: space-around;
        }

        .modal-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .confirm-btn {
            background-color: #dc3545;
            color: #fff;
        }

        .confirm-btn:hover {
            background-color: #c82333;
        }

        .cancel-btn {
            background-color: #6c757d;
            color: #fff;
        }

        .cancel-btn:hover {
            background-color: #5a6268;
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

            .detail-box {
                padding: 15px;
            }

            .action-buttons {
                flex-direction: column;
                gap: 10px;
            }

            .modal-content {
                width: 95%;
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
        <h1>Account Details</h1>
        <div class="detail-box">
            <p><strong>ID:</strong> ${account.id}</p>
            <p><strong>Username:</strong> ${account.username}</p>
            <p><strong>Name:</strong> ${account.name}</p>
            <p><strong>Email:</strong> ${account.email}</p>
            <p><strong>Phone:</strong> ${account.phone}</p>
            <p><strong>Gender:</strong> ${account.gender}</p>
            <p><strong>Birth Date:</strong> ${account.birthDate}</p>
            <p><strong>Role:</strong> ${account.role}</p>
            <p><strong>Status:</strong> ${account.status}</p>
            <p><strong>Image:</strong> ${account.image != null ? account.image : 'No image'}</p>
            <p><strong>Created At:</strong> ${account.create_at}</p>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/adminDashboard?action=update&id=${account.id}" class="action-btn edit-btn">Edit</a>
                <a href="${pageContext.request.contextPath}/adminDashboard" class="action-btn back-btn">Back</a>
            </div>
        </div>
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
    </script>
</body>
</html>