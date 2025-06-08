<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin Dashboard - Healthy Food</title>
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

        /* Main Content */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 15px;
        }

        h1 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #28a745;
            text-align: center;
        }

        .add-account {
            display: inline-block;
            padding: 10px 20px;
            background-color: #28a745;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            margin-bottom: 20px;
            transition: background-color 0.3s;
        }

        .add-account:hover {
            background-color: #218838;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #28a745;
            color: #fff;
            font-weight: 600;
        }

        tr:hover {
            background-color: #f1f1f1;
        }
        .action-btn {
            padding: 8px 15px;
            margin-right: 10px;
            text-decoration: none;
            border-radius: 5px;
            font-size: 14px;
            transition: background-color 0.3s;
        }

        .detail-btn {
            background-color: #17a2b8;
            color: #fff;
        }

        .detail-btn:hover {
            background-color: #138496;
        }

        .edit-btn {
            background-color: #007bff;
            color: #fff;
        }

        .edit-btn:hover {
            background-color: #0056b3;
        }

        .active-btn {
            background-color: #28a745;
            color: #fff;
        }

        .active-btn:hover {
            background-color: #218838;
        }

        .inactive-btn {
            background-color: #dc3545;
            color: #fff;
        }

        .inactive-btn:hover {
            background-color: #c82333;
        }
        .search-filter {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .search-filter input, .search-filter select {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .search-filter button {
            padding: 8px 15px;
            background-color: #28a745;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-filter button:hover {
            background-color: #218838;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); 
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 400px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .modal-content h3 {
            margin-bottom: 15px;
            color: #28a745;
            font-size: 20px;
        }

        .modal-content p {
            margin-bottom: 20px;
            font-size: 16px;
            color: #333;
        }

        .modal-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .modal-buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .modal-buttons .confirm-btn {
            background-color: #28a745;
            color: #fff;
        }

        .modal-buttons .confirm-btn:hover {
            background-color: #218838;
        }

        .modal-buttons .cancel-btn {
            background-color: #dc3545;
            color: #fff;
        }

        .modal-buttons .cancel-btn:hover {
            background-color: #c82333;
        }

        /* Responsive Design */
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

            table {
                font-size: 14px;
            }

            th, td {
                padding: 10px;
            }

            .search-filter {
                flex-direction: column;
                gap: 5px;
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
        <h1>Admin Dashboard - Manage Accounts</h1>
        <a href="${pageContext.request.contextPath}/addAccount.jsp" class="add-account">Add New Account</a>

        <div class="search-filter">
            <input type="text" id="searchInput" placeholder="Search by name or email" value="${search}">
            <select id="roleFilter" name="role">
                <option value="">All Roles</option>
                <option value="Admin" ${role == 'Admin' ? 'selected' : ''}>Admin</option>
                <option value="Member" ${role == 'Member' ? 'selected' : ''}>Member</option>
            </select>
            <select id="statusFilter" name="status">
                <option value="">All Statuses</option>
                <option value="Active" ${status == 'Active' ? 'selected' : ''}>Active</option>
                <option value="Inactive" ${status == 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select>
            <button onclick="filterAccounts()">Filter</button>
        </div>

        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="account" items="${accounts}">
                <tr>
                    <td>${account.id}</td>
                    <td>${account.username}</td>
                    <td>${account.name}</td>
                    <td>${account.email}</td>
                    <td>${account.role}</td>
                    <td>${account.status}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/adminDashboard?action=detail&id=${account.id}" class="action-btn detail-btn">Detail</a>
                        <a href="${pageContext.request.contextPath}/adminDashboard?action=update&id=${account.id}" class="action-btn edit-btn">Edit</a>
                        <c:choose>
                            <c:when test="${account.status == 'Active'}">
                                <a href="#" class="action-btn inactive-btn" onclick="showModal(${account.id}, 'deactivate', 'Are you sure you want to deactivate this account?')">Inactive</a>
                            </c:when>
                            <c:otherwise>
                                <a href="#" class="action-btn active-btn" onclick="showModal(${account.id}, 'activate', 'Are you sure you want to activate this account?')">Active</a>
                            </c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div id="confirmModal" class="modal">
        <div class="modal-content">
            <h3>Confirmation</h3>
            <p id="modalMessage"></p>
            <div class="modal-buttons">
                <button class="confirm-btn" onclick="confirmAction()">Yes</button>
                <button class="cancel-btn" onclick="closeModal()">No</button>
            </div>
        </div>
    </div>

    <script>
        let currentActionUrl = '';

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

        function filterAccounts() {
            var search = document.getElementById("searchInput").value;
            var role = document.getElementById("roleFilter").value;
            var status = document.getElementById("statusFilter").value;
            window.location.href = "${pageContext.request.contextPath}/adminDashboard?search=" + encodeURIComponent(search) + "&role=" + encodeURIComponent(role) + "&status=" + encodeURIComponent(status);
        }

        function showModal(accountId, action, message) {
            const modal = document.getElementById("confirmModal");
            const modalMessage = document.getElementById("modalMessage");
            modalMessage.textContent = message;
            currentActionUrl = "${pageContext.request.contextPath}/adminDashboard?action=" + action + "&id=" + accountId;
            modal.style.display = "flex";
        }

        function closeModal() {
            const modal = document.getElementById("confirmModal");
            modal.style.display = "none";
        }

        function confirmAction() {
            if (currentActionUrl) {
                window.location.href = currentActionUrl;
            }
            closeModal();
        }
        
        window.onclick = function(event) {
            const modal = document.getElementById("confirmModal");
            if (event.target === modal) {
                closeModal();
            }
            if (!event.target.matches('.user-btn')) {
                var dropdowns = document.getElementsByClassName("dropdown-menu");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        };
    </script>
</body>
</html>