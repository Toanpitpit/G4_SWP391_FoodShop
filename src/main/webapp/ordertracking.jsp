<%-- 
    Document   : DashBoard
    Created on : Jun 13, 2025, 9:00:38 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String orderId = request.getParameter("orderId");
    // Xử lý dữ liệu tương ứng...
%>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
// Lấy thời gian hiện tại
Date now = new Date();
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
%>

<c:set var="currentDate" value="<%= dateFormat.format(now) %>" />
<c:set var="currentTime" value="<%= timeFormat.format(now) %>" />
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nutritionist Dashboard</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="CSS/defauld.css">
<style>
    /* CSS chung */
    .main-content {
        padding: 20px;
        margin-left: 280px;
        transition: margin-left 0.3s ease;
    }
    
    .collapsed ~ .main-content {
        margin-left: 80px;
    }
    
    .breadcrumb-section {
        margin-bottom: 20px;
    }
    
    .breadcrumb-container {
        display: flex;
        flex-direction: column;
    }
    
    .page-title {
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 10px;
    }
    
    .breadcrumb-nav {
        display: flex;
        align-items: center;
        color: #6c757d;
        font-size: 14px;
    }
    
    .breadcrumb-item {
        color: #6c757d;
        text-decoration: none;
    }
    
    .breadcrumb-item:hover {
        color: #0d6efd;
        text-decoration: underline;
    }
    
    .breadcrumb-item.active {
        color: #495057;
        font-weight: 500;
    }
    
    .breadcrumb-separator {
        margin: 0 8px;
        color: #adb5bd;
    }
    
    /* CSS cho breadcrumb trong nội dung */
    .main-content-wrap .breadcrumbs {
        display: flex;
        align-items: center;
        flex-wrap: wrap;
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .main-content-wrap .breadcrumbs li {
        display: flex;
        align-items: center;
    }
    
    .main-content-wrap .breadcrumbs .text-tiny {
        font-size: 14px;
        color: #6c757d;
    }
    
    .main-content-wrap .breadcrumbs a .text-tiny {
        color: #6c757d;
        text-decoration: none;
    }
    
    .main-content-wrap .breadcrumbs a:hover .text-tiny {
        color: #0d6efd;
        text-decoration: underline;
    }
    
    .main-content-wrap .breadcrumbs .icon-chevron-right {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        margin: 0 10px;
        color: #adb5bd;
        font-size: 12px;
    }
    
    /* Sử dụng biểu tượng từ Bootstrap Icons cho dấu phân cách */
    .main-content-wrap .breadcrumbs .icon-chevron-right::before {
        content: "\f285"; /* Mã Unicode của biểu tượng chevron-right trong Bootstrap Icons */
        font-family: "bootstrap-icons";
    }
    
    /* Track Order Page */
    .track-order-page {
        background-color: #f8f9fa;
        border-radius: 12px;
        padding: 25px;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
    }
    
    .track-order-content {
        max-width: 1200px;
        margin: 0 auto;
    }
    
    .main-content-inner {
        background: white;
        border-radius: 12px;
        padding: 25px;
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.05);
    }
    
    .flex {
        display: flex;
    }
    
    .items-center {
        align-items: center;
    }
    
    .flex-wrap {
        flex-wrap: wrap;
    }
    
    .justify-between {
        justify-content: space-between;
    }
    
    .gap20 {
        gap: 20px;
    }
    
    .gap10 {
        gap: 10px;
    }
    
    .mb-27 {
        margin-bottom: 27px;
    }
    
    .wg-box {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        margin-bottom: 25px;
    }
    
    .order-track {
        display: flex;
        gap: 30px;
        align-items: center;
    }
    
    .order-track .image {
        flex: 0 0 200px;
    }
    
    .order-track .image img {
        width: 100%;
        border-radius: 8px;
        box-shadow: 0 0.125rem 0.5rem rgba(0, 0, 0, 0.1);
    }
    
    .order-track .content {
        flex: 1;
    }
    
    .order-track .content h5 {
        font-size: 22px;
        font-weight: 600;
        color: #212529;
        margin-bottom: 20px;
    }
    
    .infor {
        display: flex;
        justify-content: space-between;
        padding: 8px 0;
        border-bottom: 1px solid #e9ecef;
    }
    
    .infor:last-child {
        border-bottom: none;
    }
    
    .body-text {
        font-size: 15px;
        color: #6c757d;
    }
    
    .body-title-2 {
        font-size: 16px;
        font-weight: 500;
        color: #212529;
    }
    
    .tf-button {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        padding: 10px 20px;
        border-radius: 6px;
        font-weight: 500;
        transition: all 0.3s ease;
        text-decoration: none;
        font-size: 15px;
    }
    
    .tf-button.style-1 {
        background-color: #6c757d;
        color: white;
        border: none;
    }
    
    .tf-button.style-1:hover {
        background-color: #5c636a;
    }
    
    .tf-button {
        background-color: #0d6efd;
        color: white;
        border: none;
    }
    
    .tf-button:hover {
        background-color: #0b5ed7;
    }
    
    .w230 {
        width: 230px;
    }
    
    /* Road Map */
    .road-map {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 15px;
        margin-top: 30px;
        position: relative;
    }
    
    .road-map::before {
        content: '';
        position: absolute;
        top: 30px;
        left: 0;
        right: 0;
        height: 2px;
        background-color: #e9ecef;
        z-index: 1;
    }
    
    .road-map-item {
        position: relative;
        z-index: 2;
        text-align: center;
        padding: 0 10px;
    }
    
    .road-map-item .icon {
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background-color: #f1f2f6;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 15px;
        font-size: 24px;
        color: #adb5bd;
    }
    
    .road-map-item.active .icon {
        background-color: #0d6efd;
        color: white;
    }
    
    .road-map-item h6 {
        font-size: 16px;
        font-weight: 500;
        margin-bottom: 8px;
        color: #212529;
    }
    
    /* Table */
    .table-title {
        display: flex;
        background-color: #f8f9fa;
        padding: 15px 20px;
        border-radius: 8px;
        margin-bottom: 15px;
    }
    
    .table-title li {
        flex: 1;
        font-weight: 600;
        color: #495057;
    }
    
    .cart-totals-item {
        display: flex;
        padding: 15px 20px;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        margin-bottom: 10px;
        transition: transform 0.2s;
    }
    
    .cart-totals-item:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    
    .cart-totals-item > div {
        flex: 1;
        font-size: 14px;
        color: #495057;
    }
    
    .divider {
        height: 1px;
        background-color: #e9ecef;
        margin: 10px 0;
    }
    
    /* Responsive */
    @media (max-width: 992px) {
        .order-track {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .order-track .image {
            width: 100%;
            margin-bottom: 20px;
        }
        
        .road-map {
            grid-template-columns: 1fr;
            gap: 30px;
        }
        
        .road-map::before {
            display: none;
        }
        
        .road-map-item {
            display: flex;
            align-items: center;
            text-align: left;
        }
        
        .road-map-item .icon {
            margin: 0 15px 0 0;
        }
        
        .table-title {
            display: none;
        }
        
        .cart-totals-item {
            flex-direction: column;
            gap: 10px;
        }
        
        .cart-totals-item > div {
            display: flex;
            justify-content: space-between;
        }
        
        .cart-totals-item > div::before {
            content: attr(data-label);
            font-weight: 600;
            color: #495057;
        }
    }
    
    @media (max-width: 768px) {
        .main-content {
            margin-left: 0;
        }
        
        .collapsed ~ .main-content {
            margin-left: 0;
        }
        
        .flex.items-center.flex-wrap.justify-between.gap20.mb-27 {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .tf-button {
            width: 100%;
            margin-bottom: 10px;
        }
        
        .main-content-wrap .breadcrumbs {
            flex-direction: column;
            align-items: flex-start;
        }
        
        .main-content-wrap .breadcrumbs .icon-chevron-right {
            transform: rotate(90deg);
            margin: 5px 0;
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
                    <span class="brand-text">Feash & Healthy</span>
                </a>
                <button class="sidebar-toggle" onclick="toggleSidebar()">
                    <i class="bi bi-list"></i>
                </button>
            </div>

            <div class="sidebar-menu">
                <div class="menu-section">
                    <div class="menu-section-title">Main Home</div>
                    <div class="menu-item">
                        <a href="#" class="menu-link active" data-tooltip="Dashboard" onclick="toggleSubmenu(this)">
                            <div class="menu-icon">
                                <i class="bi bi-grid"></i>
                            </div>
                            <span class="menu-text">Dashboard</span>
                            <i class="menu-arrow bi bi-chevron-right"></i>
                        </a>
                        <div class="submenu" id="dashboard-submenu">
                            <a href="#" class="menu-link">Home 01</a>
                            <a href="#" class="menu-link">Home 02</a>
                            <a href="#" class="menu-link">Home 03</a>
                            <a href="#" class="menu-link">Home 04</a>
                        </div>
                    </div>
                </div>

                <div class="menu-section">
                    <div class="menu-section-title">All Pages</div>

                    <div class="menu-item">
                        <a href="#" class="menu-link" data-tooltip="Ecommerce" onclick="toggleSubmenu(this)">
                            <div class="menu-icon">
                                <i class="bi bi-cart"></i>
                            </div>
                            <span class="menu-text">Ecommerce</span>
                            <i class="menu-arrow bi bi-chevron-right"></i>
                        </a>
                        <div class="submenu">
                            <a href="#" class="menu-link">Add Product</a>
                            <a href="#" class="menu-link">Product List</a>
                            <a href="#" class="menu-link">Product Detail</a>
                            <a href="#" class="menu-link">Product Categories</a>
                        </div>
                    </div>

                    <div class="menu-item">
                        <a href="#" class="menu-link" data-tooltip="Category" onclick="toggleSubmenu(this)">
                            <div class="menu-icon">
                                <i class="bi bi-layers"></i>
                            </div>
                            <span class="menu-text">Category</span>
                            <i class="menu-arrow bi bi-chevron-right"></i>
                        </a>
                        <div class="submenu">
                            <a href="#" class="menu-link">Category List</a>
                            <a href="#" class="menu-link">New Category</a>
                            <a href="#" class="menu-link">Category Analytics</a>
                        </div>
                    </div>

                    <div class="menu-item">
                        <a href="#" class="menu-link" data-tooltip="Attributes">
                            <div class="menu-icon">
                                <i class="bi bi-box"></i>
                            </div>
                            <span class="menu-text">Attributes</span>
                        </a>
                    </div>

                    <div class="menu-item">
                        <a href="#" class="menu-link" data-tooltip="Order" onclick="toggleSubmenu(this)">
                            <div class="menu-icon">
                                <i class="bi bi-file-earmark-plus"></i>
                            </div>
                            <span class="menu-text">Order</span>
                            <span class="menu-badge">12</span>
                            <i class="menu-arrow bi bi-chevron-right"></i>
                        </a>
                        <div class="submenu">
                            <a href="order" class="menu-link">Order List</a>
                            <a href="#" class="menu-link">Order Detail</a>
                            <a href="ordertracking.jsp" class="menu-link">Order Tracking</a>
                            <a href="#" class="menu-link">Order Reports</a>
                        </div>
                    </div>

                    <div class="menu-item">
                        <a href="#" class="menu-link" data-tooltip="Users" onclick="toggleSubmenu(this)">
                            <div class="menu-icon">
                                <i class="bi bi-people"></i>
                            </div>
                            <span class="menu-text">Users</span>
                            <i class="menu-arrow bi bi-chevron-right"></i>
                        </a>
                        <div class="submenu">
                            <a href="#" class="menu-link">All Users</a>
                            <a href="#" class="menu-link">Add New User</a>
                            <a href="#" class="menu-link">User Roles</a>
                            <a href="#" class="menu-link">Permissions</a>
                        </div>
                    </div>

                    <div class="menu-item">
                        <a href="#" class="menu-link" data-tooltip="Analytics">
                            <div class="menu-icon">
                                <i class="bi bi-graph-up"></i>
                            </div>
                            <span class="menu-text">Analytics</span>
                        </a>
                    </div>

                    <div class="menu-item">
                        <a href="#" class="menu-link" data-tooltip="Reports" onclick="toggleSubmenu(this)">
                            <div class="menu-icon">
                                <i class="bi bi-file-text"></i>
                            </div>
                            <span class="menu-text">Reports</span>
                            <i class="menu-arrow bi bi-chevron-right"></i>
                        </a>
                        <div class="submenu">
                            <a href="#" class="menu-link">Sales Report</a>
                            <a href="#" class="menu-link">User Report</a>
                            <a href="#" class="menu-link">Product Report</a>
                        </div>
                    </div>
                </div>

                <div class="menu-section">
                    <div class="menu-section-title">Settings</div>

                    <div class="menu-item">
                        <a href="#" class="menu-link" data-tooltip="Settings" onclick="toggleSubmenu(this)">
                            <div class="menu-icon">
                                <i class="bi bi-gear"></i>
                            </div>
                            <span class="menu-text">Settings</span>
                            <i class="menu-arrow bi bi-chevron-right"></i>
                        </a>
                        <div class="submenu">
                            <a href="#" class="menu-link">General Settings</a>
                            <a href="#" class="menu-link">Email Settings</a>
                            <a href="#" class="menu-link">Payment Settings</a>
                        </div>
                    </div>

                    <div class="menu-item">
                        <a href="#" class="menu-link" data-tooltip="Pages">
                            <div class="menu-icon">
                                <i class="bi bi-file-earmark-text"></i>
                            </div>
                            <span class="menu-text">Pages</span>
                        </a>
                    </div>

                    <div class="menu-item">
                        <a href="#" class="menu-link" data-tooltip="Support">
                            <div class="menu-icon">
                                <i class="bi bi-question-circle"></i>
                            </div>
                            <span class="menu-text">Support</span>
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
                        <input type="text" class="search-input" placeholder="Search products, orders, customers...">
                    </div>
                </div>

                <div class="header-right">
                    <div class="header-action" title="Notifications">
                        <i class="bi bi-bell"></i>
                        <span class="notification-count">3</span>
                    </div>

                    <div class="header-action" title="Messages">
                        <i class="bi bi-chat-dots"></i>
                        <span class="notification-dot"></span>
                    </div>

                    <div class="header-action" title="Fullscreen">
                        <i class="bi bi-arrows-fullscreen"></i>
                    </div>

                    <div class="header-action" title="Apps">
                        <i class="bi bi-grid-3x3-gap"></i>
                    </div>

                    <div class="user-profile">
                        <div class="user-avatar">KW</div>
                        <div class="user-info">
                            <div class="user-name">Kristin Watson</div>
                            <div class="user-role">Administrator</div>
                        </div>
                        <i class="dropdown-arrow bi bi-chevron-down"></i>
                    </div>
                </div>
            </div>
        </header>

        <!-- Main Content -->
        <main class="main-content" id="mainContent">
            <!-- Breadcrumb Section -->
            <div class="breadcrumb-section">
                <div class="breadcrumb-container">
                    <h1 class="page-title">Track Order</h1>
                    <nav class="breadcrumb-nav">
                        <a href="#" class="breadcrumb-item">Home</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <a href="#" class="breadcrumb-item">Order</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <span class="breadcrumb-item active">Track Order</span>
                    </nav>
                </div>
            </div>

            <!-- Full Width Track Order Section -->
            <div class="full-width-container track-order-page">
                <div class="track-order-content">
                    <div class="main-content-inner">
                        <div class="main-content-wrap">
                            <div class="flex items-center flex-wrap justify-between gap20 mb-27">
                                <h3>Track Order</h3>
                                <ul class="breadcrumbs flex items-center flex-wrap justify-start gap10">
                                    <li>
                                        <a href="index.html"><div class="text-tiny">Dashboard</div></a>
                                    </li>
                                    <li>
                                        <i class="icon-chevron-right"></i>
                                    </li>
                                    <li>
                                        <a href="#"><div class="text-tiny">Order</div></a>
                                    </li>
                                    <li>
                                        <i class="icon-chevron-right"></i>
                                    </li>
                                    <li>
                                        <div class="text-tiny">Track Order</div>
                                    </li>
                                </ul>
                            </div>
                            
                           
<!-- Order Track Section -->
<div class="wg-box mb-20">
    <div class="order-track">
        <div class="image">
            <c:choose>
                <c:when test="${not empty param.image}">
                    <img src="${pageContext.request.contextPath}/${param.image}" 
                         alt="${param.food}" 
                         class="food-image">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/default-food.png" 
                         alt="Default food image">
                </c:otherwise>
            </c:choose>
        </div>
        <div class="content">
            <h5 class="mb-20">${param.food}</h5>
            <div class="infor mb-10">
                <div class="body-text">Order ID</div>
                <div class="body-title-2">#${param.orderId}</div>
            </div>
            <div class="infor mb-10">
                <div class="body-text">Category:</div>
                <div class="body-title-2">${param.category}</div>
            </div>
            <div class="infor mb-10">
                <div class="body-text">Order Placed:</div>
                <div class="body-title-2">${param.address}</div>
            </div>
            <div class="infor mb-20">
                <div class="body-text">Quantity:</div>
                <div class="body-title-2">${param.quantity}</div>
            </div>
            <div class="flex gap10 flex-wrap">
                <a class="tf-button style-1 w230" href="product-list.html">View shop</a>
                <a class="tf-button w230" href="product-list.html">View product</a>
            </div>
        </div>
    </div>
</div>
<!-- /order-track -->

<!-- Full width detail section -->
<div class="full-width-section">
    <div class="inner-container">
        <div class="wg-box">
            <div>
                <h6 class="mb-10">Detail</h6>
                <div class="body-text">Your items is on the way. Tracking information will be available within 24 hours.</div>
            </div>
            <div class="road-map">
                <div class="road-map-item active">
                    <div class="icon"><i class="bi bi-check-lg"></i></div>
                    <h6>Receiving orders</h6>
                    <div class="body-text">${currentDate} ${currentTime}</div>
                </div>
                <div class="road-map-item">
                    <div class="icon"><i class="bi bi-check-lg"></i></div>
                    <h6>Order processing</h6>
                    <div class="body-text">Processing</div>
                </div>
                <div class="road-map-item">
                    <div class="icon"><i class="bi bi-check-lg"></i></div>
                    <h6>Being delivered</h6>
                    <div class="body-text">Pending</div>
                </div>
                <div class="road-map-item">
                    <div class="icon"><i class="bi bi-check-lg"></i></div>
                    <h6>Delivered</h6>
                    <div class="body-text">Pending</div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /detail -->

<!-- Full width table section -->
<div class="full-width-section">
    <div class="inner-container">
        <div class="wg-box">
            <div class="wg-table table-order-track">
                <ul class="table-title flex mb-24 gap20">
                    <li>
                        <div class="body-title">Date</div>
                    </li>    
                    <li>
                        <div class="body-title">Time</div>
                    </li>    
                    <li>
                        <div class="body-title">Customer Name</div>
                    </li>   
                    <li>
                        <div class="body-title">Phone Number</div>
                    </li>   
                    <li>
                        <div class="body-title">Location</div>
                    </li>   
                </ul>
                <ul class="flex flex-column gap14">
                    <li class="cart-totals-item">
                        <div class="body-text">${currentDate}</div>
                        <div class="body-text">${currentTime}</div>
                        <div class="body-text">${param.customerName}</div>
                        <div class="body-text">${param.phone}</div>
                        <div class="body-text">${param.address}</div>
                    </li>
                    <li class="divider"></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<!-- /table -->

            <!-- Footer -->
            <footer class="main-footer">
                <div class="footer-content">
                    <div class="footer-left">
                        <span>© 2024 Remos Dashboard. All rights reserved.</span>
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

        <!-- Bootstrap JS -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
                        // Toggle Sidebar Function
                        function toggleSidebar() {
                            const sidebar = document.getElementById('sidebar');
                            const mainHeader = document.getElementById('mainHeader');
                            const mainContent = document.getElementById('mainContent');

                            if (window.innerWidth > 768) {
                                // Desktop: collapse/expand sidebar
                                sidebar.classList.toggle('collapsed');
                                mainHeader.classList.toggle('collapsed');
                                mainContent.classList.toggle('collapsed');

                                // Close all submenus when collapsing
                                if (sidebar.classList.contains('collapsed')) {
                                    const submenus = document.querySelectorAll('.submenu');
                                    submenus.forEach(submenu => {
                                        submenu.classList.remove('active');
                                    });

                                    const arrows = document.querySelectorAll('.menu-arrow');
                                    arrows.forEach(arrow => {
                                        arrow.style.transform = 'rotate(0deg)';
                                    });
                                }
                            } else {
                                // Mobile: show/hide sidebar
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

                        // Toggle Submenu Function
                        function toggleSubmenu(element) {
                            const submenu = element.parentElement.querySelector('.submenu');
                            const arrow = element.querySelector('.menu-arrow');
                            const sidebar = document.getElementById('sidebar');

                            if (submenu && !sidebar.classList.contains('collapsed')) {
                                event.preventDefault();

                                // Close other submenus
                                const allSubmenus = document.querySelectorAll('.submenu');
                                const allArrows = document.querySelectorAll('.menu-arrow');

                                allSubmenus.forEach(sub => {
                                    if (sub !== submenu) {
                                        sub.classList.remove('active');
                                    }
                                });

                                allArrows.forEach(arr => {
                                    if (arr !== arrow) {
                                        arr.style.transform = 'rotate(0deg)';
                                    }
                                });

                                // Toggle current submenu
                                submenu.classList.toggle('active');

                                if (submenu.classList.contains('active')) {
                                    arrow.style.transform = 'rotate(90deg)';
                                } else {
                                    arrow.style.transform = 'rotate(0deg)';
                                }
                            }
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
                                // Don't prevent default for items with submenus
                                const hasSubmenu = this.parentElement.querySelector('.submenu');
                                if (!hasSubmenu) {
                                    // Remove active class from all menu items
                                    document.querySelectorAll('.menu-link').forEach(item => {
                                        item.classList.remove('active');
                                    });

                                    // Add active class to clicked item
                                    this.classList.add('active');
                                }
                            });
                        });

                        // Search functionality (basic)
                        document.querySelector('.search-input').addEventListener('input', function (e) {
                            const searchTerm = e.target.value.toLowerCase();
                            console.log('Searching for:', searchTerm);
                            // Add your search logic here
                        });

                        // Fullscreen toggle
                        document.querySelector('[title="Fullscreen"]').addEventListener('click', function () {
                            if (!document.fullscreenElement) {
                                document.documentElement.requestFullscreen();
                                this.innerHTML = '<i class="bi bi-fullscreen-exit"></i>';
                            } else {
                                document.exitFullscreen();
                                this.innerHTML = '<i class="bi bi-arrows-fullscreen"></i>';
                            }
                        });

                        // Initialize tooltips for collapsed sidebar
                        function initTooltips() {
                            const sidebar = document.getElementById('sidebar');
                            const menuLinks = document.querySelectorAll('.menu-link[data-tooltip]');

                            menuLinks.forEach(link => {
                                link.addEventListener('mouseenter', function () {
                                    if (sidebar.classList.contains('collapsed')) {
                                        // Tooltip is handled by CSS
                                    }
                                });
                            });
                        }

                        // Initialize on page load
                        document.addEventListener('DOMContentLoaded', function () {
                            initTooltips();

                            // Set initial submenu state for active dashboard
                            const dashboardSubmenu = document.getElementById('dashboard-submenu');
                            if (dashboardSubmenu) {
                                dashboardSubmenu.classList.add('active');
                                const dashboardArrow = document.querySelector('.menu-link.active .menu-arrow');
                                if (dashboardArrow) {
                                    dashboardArrow.style.transform = 'rotate(90deg)';
                                }
                            }

                            // Add click listener to sidebar for expanding when collapsed
                            const sidebar = document.getElementById('sidebar');
                            if (sidebar) {
                                sidebar.addEventListener('click', function (e) {
                                    // Only expand if sidebar is collapsed and we're on desktop
                                    if (sidebar.classList.contains('collapsed') && window.innerWidth > 768) {
                                        // Check if click is not on toggle button or submenu elements
                                        const isToggleButton = e.target.closest('.mobile-toggle') || e.target.closest('[onclick*="toggleSidebar"]');
                                        const isSubmenuClick = e.target.closest('.submenu');

                                        if (!isToggleButton && !isSubmenuClick) {
                                            expandSidebarOnClick();
                                        }
                                    }
                                });
                            }
                        });

                        // Smooth scrolling for internal links
                        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                            anchor.addEventListener('click', function (e) {
                                e.preventDefault();
                                const target = document.querySelector(this.getAttribute('href'));
                                if (target) {
                                    target.scrollIntoView({
                                        behavior: 'smooth',
                                        block: 'start'
                                    });
                                }
                            });
                        });
        </script>
    </body>
</html>