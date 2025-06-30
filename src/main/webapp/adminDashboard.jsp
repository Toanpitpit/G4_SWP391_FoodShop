<%-- 
    Document   : DashBoard
    Created on : Jun 13, 2025, 9:00:38 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Admin Dashboard - Healthy Food</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
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

        /* ============ SIDEBAR STYLES ============ */
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

        .sidebar::-webkit-scrollbar {
            width: 4px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: transparent;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: #475569;
            border-radius: 2px;
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: space-between;
            min-height: 80px;
        }

        .sidebar.collapsed .sidebar-header {
            justify-content: center;
            padding: 20px 10px;
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

        .sidebar.collapsed .brand-icon {
            margin-right: 0;
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

        .sidebar.collapsed .sidebar-toggle {
            display: none;
        }

        .sidebar-menu {
            padding: 20px 0;
        }

        .menu-section {
            margin-bottom: 30px;
        }

        .menu-section:last-child {
            margin-bottom: 0;
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

        .sidebar.collapsed .menu-section-title {
            opacity: 0;
            height: 0;
            padding: 0;
            overflow: hidden;
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

        .sidebar.collapsed .menu-icon {
            margin-right: 0;
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

        .menu-arrow {
            margin-left: auto;
            font-size: 12px;
            transition: all 0.3s ease;
        }

        .sidebar.collapsed .menu-arrow {
            display: none;
        }

        .menu-badge {
            margin-left: auto;
            background: #ef4444;
            color: white;
            font-size: 11px;
            padding: 2px 6px;
            border-radius: 10px;
            min-width: 18px;
            text-align: center;
            font-weight: 600;
        }

        .sidebar.collapsed .menu-badge {
            display: none;
        }

        .submenu {
            max-height: 0;
            overflow: hidden;
            transition: all 0.3s ease;
            margin-top: 4px;
        }

        .submenu.active {
            max-height: 300px;
        }

        .sidebar.collapsed .submenu {
            display: none;
        }

        .submenu .menu-link {
            padding: 8px 16px 8px 50px;
            font-size: 13px;
            font-weight: 400;
            margin: 2px 0;
        }

        .submenu .menu-link:hover {
            transform: translateX(4px);
        }

        .sidebar.collapsed .menu-link::after {
            content: attr(data-tooltip);
            position: absolute;
            left: calc(100% + 15px);
            top: 50%;
            transform: translateY(-50%);
            background: #1e293b;
            color: white;
            padding: 8px 12px;
            border-radius: 6px;
            font-size: 12px;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: all 0.2s ease;
            z-index: 1001;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        }

        .sidebar.collapsed .menu-link::before {
            content: '';
            position: absolute;
            left: calc(100% + 9px);
            top: 50%;
            transform: translateY(-50%);
            border: 6px solid transparent;
            border-right-color: #1e293b;
            opacity: 0;
            visibility: hidden;
            transition: all 0.2s ease;
            z-index: 1001;
        }

        .sidebar.collapsed .menu-link:hover::after,
        .sidebar.collapsed .menu-link:hover::before {
            opacity: 1;
            visibility: visible;
        }

        /* ============ HEADER STYLES ============ */
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

        .notification-dot {
            position: absolute;
            top: 6px;
            right: 6px;
            width: 8px;
            height: 8px;
            background: #ef4444;
            border-radius: 50%;
            border: 2px solid white;
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

        /* ============ MAIN CONTENT STYLES ============ */
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
            background-color: var(--primary-green);
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search-filter button:hover {
            background-color: #3b9d67;
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
            background-color: var(--primary-green);
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
            background-color: var(--primary-green);
            color: #fff;
        }

        .active-btn:hover {
            background-color: #3b9d67;
        }

        .inactive-btn {
            background-color: #dc3545;
            color: #fff;
        }

        .inactive-btn:hover {
            background-color: #c82333;
        }

        .error-message {
            display: none;
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        .error-message.show {
            display: block;
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
            color: var(--primary-green);
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
            background-color: var(--primary-green);
            color: #fff;
        }

        .modal-buttons .confirm-btn:hover {
            background-color: #3b9d67;
        }

        .modal-buttons .cancel-btn {
            background-color: #dc3545;
            color: #fff;
        }

        .modal-buttons .cancel-btn:hover {
            background-color: #c82333;
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .main-header {
                left: 0;
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .mobile-toggle {
                display: block;
            }
            
            .search-container {
                width: 250px;
            }
            
            .user-info {
                display: none;
            }

            .breadcrumb-container {
                flex-direction: column;
                align-items: flex-start;
                gap: 12px;
            }

            .content-wrapper {
                padding: 16px;
            }

            .content-card {
                padding: 20px;
            }
        }

        @media (max-width: 576px) {
            .search-container {
                width: 200px;
            }
            
            .header-content {
                padding: 0 16px;
            }
            
            .content-wrapper {
                padding: 12px;
            }

            .breadcrumb-section {
                padding: 16px;
            }

            .page-title {
                font-size: 20px;
            }

            .content-card {
                padding: 16px;
            }
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
                    <a href="${pageContext.request.contextPath}/adminDashboard" class="menu-link active" data-tooltip="Dashboard" onclick="toggleSubmenu(this)">
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
                    <a href="${pageContext.request.contextPath}/adminDashboard?action=detail&id=${account.id}" class="menu-link" data-tooltip="Account Details">
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
                    <input type="text" class="search-input" placeholder="Search accounts..." id="searchInput" value="${search}">
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
                <h1 class="page-title">Admin Dashboard</h1>
                <nav class="breadcrumb-nav">
                    <a href="${pageContext.request.contextPath}/adminDashboard" class="breadcrumb-item">Home</a>
                    <span class="breadcrumb-separator">
                        <i class="bi bi-chevron-right"></i>
                    </span>
                    <span class="breadcrumb-item active">Dashboard</span>
                </nav>
            </div>
        </div>

        <!-- Content Wrapper -->
        <div class="content-wrapper">
            <div class="content-card">
                <div class="search-filter">
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

                <!-- Hiển thị thông báo lỗi -->
                <c:if test="${not empty param.error}">
                    <div class="error-message ${param.error == 'CannotModifyAdminStatus' ? 'show' : ''}">
                        <c:choose>
                            <c:when test="${param.error == 'CannotModifyAdminStatus'}">
                                Không thể thay đổi trạng thái của tài khoản Admin!
                            </c:when>
                            <c:otherwise>
                                ${param.error}
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>

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
        // Toggle Sidebar Function
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

        // Expand sidebar when clicked while collapsed
        function expandSidebarOnClick() {
            const sidebar = document.getElementById('sidebar');
            const mainHeader = document.getElementById('mainHeader');
            const mainContent = document.getElementById('mainContent');

            if (sidebar.classList.contains('collapsed')) {
                sidebar.classList.remove('collapsed');
                mainHeader.classList.remove('collapsed');
                mainContent.classList.remove('collapsed');
            }
        }

        // Toggle Submenu Function (không cần vì không có submenu ở đây)
        function toggleSubmenu(element) {
            // Không cần thực hiện vì không có submenu trong menu hiện tại
        }

        // Filter Accounts
        function filterAccounts() {
            var search = document.getElementById("searchInput").value;
            var role = document.getElementById("roleFilter").value;
            var status = document.getElementById("statusFilter").value;
            window.location.href = "${pageContext.request.contextPath}/adminDashboard?search=" + encodeURIComponent(search) + "&role=" + encodeURIComponent(role) + "&status=" + encodeURIComponent(status);
        }

        // Modal Functions
        let currentActionUrl = '';
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

        // Close sidebar on mobile when clicking outside
        document.addEventListener('click', function (event) {
            if (window.innerWidth <= 768) {
                const sidebar = document.getElementById('sidebar');
                const toggleBtn = document.querySelector('.mobile-toggle');

                if (!sidebar.contains(event.target) && !toggleBtn.contains(event.target)) {
                    sidebar.classList.remove('show');
                }
            }
        });

        // Handle window resize
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

        // Active menu item handling
        document.querySelectorAll('.menu-link').forEach(link => {
            link.addEventListener('click', function (e) {
                document.querySelectorAll('.menu-link').forEach(item => {
                    item.classList.remove('active');
                });
                this.classList.add('active');
            });
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
