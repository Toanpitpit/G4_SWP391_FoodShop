<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Account Details - Healthy Food</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet" integrity="sha512-TTA5b2Q2cJqrzmJ2t7FzTCS+IMuO2S6+3Q5r7t8w8oMLn3mG+0n0GwuQMEkvgp6dQ3Z4P//lYZX5A37sK8oN0Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet" integrity="sha512-YFENbnqHbCRmJt5d+9lHimyEMt8LKSNTMLSaHjvsclztKM3UA0CWQQiPfpiXq2Sd3MwUQSvUpSf3X1xXvJmaaFg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        :root {
            --sidebar-width: 280px;
            --sidebar-collapsed-width: 70px;
            --header-height: 90px; /* Increased to match Nutri's height */
            --primary-green: #47B77B;
            --sidebar-bg: #E6F4EA;
            --sidebar-text: #3A3A3A;
            --sidebar-hover: #FBBF24;
            --border-color: #B7E28B;
            --content-bg: #f8fafc;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: var(--content-bg);
            overflow-x: hidden;
        }

        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: var(--sidebar-width);
            height: 100vh;
            background: var(--sidebar-bg);
            z-index: 1000;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            overflow-y: auto;
            overflow-x: hidden;
            border-right: 1px solid var(--border-color);
        }

        .sidebar.collapsed {
            width: var(--sidebar-collapsed-width);
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
            min-height: 80px;
        }

        .sidebar-brand {
            display: flex;
            align-items: center;
            text-decoration: none;
            color: #1e293b;
            font-weight: 700;
            font-size: 20px;
            transition: all 0.3s ease;
        }

        .brand-icon {
            width: 40px;
            height: 40px;
            background: linear-gradient(135deg, #e0fff4, #a7fcd9);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 12px;
            font-size: 18px;
            color: var(--primary-green);
            flex-shrink: 0;
        }

        .brand-text {
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .sidebar.collapsed .brand-text {
            opacity: 0;
            width: 0;
            overflow: hidden;
        }

        .sidebar-toggle {
            background: none;
            border: none;
            color: var(--sidebar-text);
            font-size: 20px;
            cursor: pointer;
            padding: 8px;
            border-radius: 6px;
            transition: all 0.2s ease;
        }

        .sidebar-toggle:hover {
            background: var(--sidebar-hover);
            color: white;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-section-title {
            padding: 0 20px 12px;
            font-size: 12px;
            font-weight: 600;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }

        .menu-item {
            margin: 0 12px 4px;
        }

        .menu-link {
            display: flex;
            align-items: center;
            padding: 12px 16px;
            color: var(--sidebar-text);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.2s ease;
            font-size: 14px;
            font-weight: 500;
            position: relative;
            cursor: pointer;
        }

        .menu-link:hover {
            background: linear-gradient(135deg, var(--primary-green), #3b82f6);
            color: white;
            transform: translateX(2px);
        }

        .menu-link.active {
            background: linear-gradient(135deg, var(--primary-green), #3b82f6);
            color: white;
            box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
        }

        .menu-icon {
            width: 20px;
            height: 20px;
            margin-right: 14px;
            font-size: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .menu-text {
            flex: 1;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .sidebar.collapsed .menu-text {
            opacity: 0;
            width: 0;
            overflow: hidden;
        }

        /* Main Header Styles */
        .main-header {
            position: fixed;
            top: 0;
            left: var(--sidebar-width);
            right: 0;
            height: var(--header-height);
            background: linear-gradient(#d0f0c0, #ffffff);
            border-bottom: 1px solid #e2e8f0;
            z-index: 999;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            padding-left: 130px;
        }

        .main-header.collapsed {
            left: var(--sidebar-collapsed-width);
        }

        .header-content {
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 24px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .mobile-toggle {
            background: none;
            border: none;
            font-size: 20px;
            color: #64748b;
            cursor: pointer;
            padding: 8px;
            border-radius: 6px;
            display: none;
            transition: all 0.2s ease;
        }

        .mobile-toggle:hover {
            background: #f1f5f9;
            color: #1e293b;
        }

        .search-container {
            position: relative;
            width: 400px;
        }

        .search-input {
            width: 100%;
            padding: 12px 16px 12px 45px;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            font-size: 14px;
            background: #f8fafc;
            transition: all 0.2s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-green);
            box-shadow: 0 0 0 3px rgba(71, 183, 123, 0.1);
            background: white;
        }

        .search-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #64748b;
            font-size: 16px;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .header-action {
            position: relative;
            padding: 10px;
            border-radius: 8px;
            color: #64748b;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 18px;
        }

        .header-action:hover {
            background: #f1f5f9;
            color: #1e293b;
        }

        .notification-count {
            position: absolute;
            top: 2px;
            right: 2px;
            background: #ef4444;
            color: white;
            font-size: 10px;
            padding: 2px 5px;
            border-radius: 10px;
            min-width: 16px;
            text-align: center;
            font-weight: 600;
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 6px 12px;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-left: 8px;
        }

        .user-profile:hover {
            background: #f1f5f9;
        }

        .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-green), #3b82f6);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 14px;
        }

        .user-info {
            display: flex;
            flex-direction: column;
        }

        .user-name {
            font-size: 14px;
            font-weight: 600;
            color: #1e293b;
            line-height: 1.2;
        }

        .user-role {
            font-size: 12px;
            color: #64748b;
            line-height: 1.2;
        }

        .dropdown-arrow {
            color: #64738b;
            font-size: 12px;
            margin-left: 4px;
        }

        /* User Dropdown */
        .account-dropdown {
            position: absolute;
            top: 60px;
            right: 0;
            width: 220px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            display: none;
            z-index: 999;
        }

        .account-dropdown ul {
            list-style: none;
            margin: 0;
            padding: 10px 0;
        }

        .account-dropdown li a {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 20px;
            color: #1e293b;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.2s ease;
        }

        .account-dropdown li a i {
            font-size: 18px;
            color: #64748b;
        }

        .account-dropdown li a:hover {
            background-color: #f1f5f9;
            color: #0f172a;
        }

        /* Main Content Styles */
        .main-content {
            margin-left: var(--sidebar-width);
            margin-top: var(--header-height);
            padding: 0;
            min-height: calc(100vh - var(--header-height));
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: var(--content-bg);
        }

        .main-content.collapsed {
            margin-left: var(--sidebar-collapsed-width);
        }

        .breadcrumb-section {
            background: white;
            padding: 20px 24px;
            border-bottom: 1px solid #e2e8f0;
        }

        .breadcrumb-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .page-title {
            font-size: 24px;
            font-weight: 700;
            color: #1e293b;
            margin: 0;
        }

        .breadcrumb-nav {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
        }

        .breadcrumb-item {
            color: #64748b;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .breadcrumb-item:hover {
            color: var(--primary-green);
        }

        .breadcrumb-item.active {
            color: #1e293b;
            font-weight: 500;
        }

        .breadcrumb-separator {
            color: #cbd5e1;
            font-size: 12px;
        }

        .content-wrapper {
            padding: 24px;
        }

        .content-card {
            background: white;
            border-radius: 12px;
            padding: 32px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            border: 1px solid #e2e8f0;
            min-height: 600px;
        }

        .detail-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            border: 1px solid #e2e8f0;
        }

        .detail-box p {
            margin-bottom: 15px;
            font-size: 14px;
        }

        .detail-box p strong {
            display: inline-block;
            width: 150px;
            color: #1e293b;
            font-weight: 500;
        }

        .action-buttons {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }

        .action-btn {
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 8px;
            font-size: 14px;
            transition: background-color 0.3s;
            color: #fff;
            border: none;
            cursor: pointer;
            flex: 1;
            text-align: center;
        }

        .edit-btn {
            background-color: var(--primary-green);
        }

        .edit-btn:hover {
            background-color: #3b9d67;
        }

        .back-btn {
            background-color: #6c757d;
        }

        .back-btn:hover {
            background-color: #5a6268;
        }

        @media (max-width: 768px) {
            .sidebar { transform: translateX(-100%); }
            .sidebar.show { transform: translateX(0); }
            .main-header { left: 0; }
            .main-content { margin-left: 0; }
            .mobile-toggle { display: block; }
            .search-container { width: 250px; }
            .user-info { display: none; }
            .breadcrumb-container { flex-direction: column; align-items: flex-start; gap: 12px; }
            .content-wrapper { padding: 16px; }
            .content-card { padding: 20px; }
            .action-buttons { flex-direction: column; }
            .action-btn { width: 100%; }
        }

        @media (max-width: 576px) {
            .search-container { width: 200px; }
            .header-content { padding: 0 16px; }
            .content-wrapper { padding: 12px; }
            .breadcrumb-section { padding: 16px; }
            .page-title { font-size: 20px; }
            .content-card { padding: 16px; }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <nav class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <a href="#" class="sidebar-brand">
                <div class="brand-icon">
                    <i class="bi bi-grid-3x3-gap-fill"></i>
                </div>
                <span class="brand-text">Healthy Food</span>
            </a>
            <button class="sidebar-toggle" onclick="toggleSidebar()">
                <i class="bi bi-list"></i>
            </button>
        </div>
        <div class="sidebar-menu">
            <div class="menu-section">
                <div class="menu-section-title">Main Home</div>
                <div class="menu-item">
                    <a href="${pageContext.request.contextPath}/adminDashboard" class="menu-link" data-tooltip="Dashboard">
                        <div class="menu-icon">
                            <i class="bi bi-grid"></i>
                        </div>
                        <span class="menu-text">Dashboard</span>
                    </a>
                </div>
            </div>
            <div class="menu-section">
                <div class="menu-section-title">Management</div>
                <div class="menu-item">
                    <a href="${pageContext.request.contextPath}/adminDashboard?action=detail&id=${account.id}" class="menu-link active" data-tooltip="Account Details">
                        <div class="menu-icon">
                            <i class="bi bi-person"></i>
                        </div>
                        <span class="menu-text">Account Details</span>
                    </a>
                </div>
                <div class="menu-item">
                    <a href="${pageContext.request.contextPath}/addAccount.jsp" class="menu-link" data-tooltip="Add Account">
                        <div class="menu-icon">
                            <i class="bi bi-person-plus"></i>
                        </div>
                        <span class="menu-text">Add Account</span>
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Header -->
    <header class="main-header" id="mainHeader">
        <div class="header-content">
            <div class="header-left">
                <button class="mobile-toggle" onclick="toggleSidebar()">
                    <i class="bi bi-list"></i>
                </button>
                <div class="search-container">
                    <i class="bi bi-search search-icon"></i>
                    <input type="text" class="search-input" placeholder="Search accounts..." id="searchInput">
                </div>
            </div>
            <div class="header-right">
                <div class="header-action" title="Notifications">
                    <i class="bi bi-bell"></i>
                    <span class="notification-count">3</span>
                </div>
                <div class="user-profile" id="user-account">
                    <div class="user-avatar">A</div>
                    <div class="user-info">
                        <div class="user-name">Admin</div>
                        <div class="user-role">Administrator</div>
                    </div>
                    <i class="dropdown-arrow bi bi-chevron-down"></i>
                </div>
                <div class="account-dropdown" id="account-dropdown">
                    <ul>
                        <li><a href="/account"><i class="bi bi-person"></i> Account</a></li>
                        <li><a href="/setting"><i class="bi bi-gear"></i> Setting</a></li>
                        <li><a href="/logout"><i class="bi bi-box-arrow-right"></i> Log out</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-content" id="mainContent">
        <!-- Breadcrumb Section -->
        <div class="breadcrumb-section">
            <div class="breadcrumb-container">
                <h1 class="page-title">Account Details</h1>
                <nav class="breadcrumb-nav">
                    <a href="${pageContext.request.contextPath}/adminDashboard" class="breadcrumb-item">Home</a>
                    <span class="breadcrumb-separator">
                        <i class="bi bi-chevron-right"></i>
                    </span>
                    <span class="breadcrumb-item active">Account Details</span>
                </nav>
            </div>
        </div>

        <!-- Content Wrapper -->
        <div class="content-wrapper">
            <div class="content-card">
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
        </div>

        <!-- Footer -->
        <footer class="main-footer">
            <div class="footer-content">
                <div class="footer-left">
                    <span>© 2025 Healthy Food. All rights reserved.</span>
                    <span>•</span>
                    <a href="#" class="footer-link">Privacy Policy</a>
                    <span>•</span>
                    <a href="#" class="footer-link">Terms of Service</a>
                </div>
                <div class="footer-right">
                    <span>Version 1.0.0</span>
                </div>
            </div>
        </footer>
    </main>

    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            const mainHeader = document.getElementById('mainHeader');
            const mainContent = document.getElementById('mainContent');

            if (window.innerWidth > 768) {
                sidebar.classList.toggle('collapsed');
                mainHeader.classList.toggle('collapsed');
                mainContent.classList.toggle('collapsed');
            } else {
                sidebar.classList.toggle('show');
            }
        }

        document.addEventListener('click', function (event) {
            if (window.innerWidth <= 768) {
                const sidebar = document.getElementById('sidebar');
                const toggleBtn = document.querySelector('.mobile-toggle');

                if (!sidebar.contains(event.target) && !toggleBtn.contains(event.target)) {
                    sidebar.classList.remove('show');
                }
            }
        });

        window.addEventListener('resize', function () {
            const sidebar = document.getElementById('sidebar');
            const mainHeader = document.getElementById('mainHeader');
            const mainContent = document.getElementById('mainContent');

            if (window.innerWidth > 768) {
                sidebar.classList.remove('show');
            } else {
                sidebar.classList.remove('collapsed');
                mainHeader.classList.remove('collapsed');
                mainContent.classList.remove('collapsed');
            }
        });

        // User Dropdown Toggle
        const userBtn = document.getElementById("user-account");
        const dropdown = document.getElementById("account-dropdown");

        userBtn.addEventListener("click", () => {
            dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
        });

        document.addEventListener("click", function (e) {
            if (!userBtn.contains(e.target) && !dropdown.contains(e.target)) {
                dropdown.style.display = "none";
            }
        });
    </script>
</body>
</html>