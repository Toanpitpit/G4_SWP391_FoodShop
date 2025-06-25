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
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
    
    /* ORDER TRACK IMAGE - GẤP ĐÔI KÍCH THƯỚC BAN ĐẦU */
    .order-track {
        display: flex;
        gap: 30px;
        align-items: flex-start; /* Căn nội dung lên đầu */
    }
    
    .order-track .image {
        flex: 0 0 400px; /* Gấp đôi 200px ban đầu */
        height: 300px; /* Tỉ lệ 4:3 */
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        border-radius: 12px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }
    
    .order-track .image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 12px;
        transition: transform 0.3s ease;
    }
    
    /* Đảm bảo đủ không gian cho ảnh lớn */
    .wg-box.mb-20 {
        min-height: 350px;
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
    
    /* RESPONSIVE - TỐI ƯU CHO ẢNH LỚN */
    @media (max-width: 1200px) {
        .order-track .image {
            flex: 0 0 350px;
            height: 260px;
        }
    }
    
    @media (max-width: 992px) {
        .order-track {
            flex-direction: column;
        }
        
        .order-track .image {
            flex: 0 0 100%;
            height: 300px;
            margin-bottom: 20px;
        }
        
        .wg-box.mb-20 {
            min-height: auto;
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
        
        .order-track .image {
            height: 250px;
        }
        
        .main-content-inner {
            padding: 20px;
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
                <i class="fas fa-leaf"></i>
            </div>
            <span class="brand-text">Feash & Heathy</span>
        </a>
        <button class="sidebar-toggle" onclick="toggleSidebar()">
            <i class="bi bi-list"></i>
        </button>
    </div>

    <div class="sidebar-menu">
        <div class="menu-section">
            <div class="menu-section-title">Main Home</div>
            <div class="menu-item">
                <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="menu-link active" data-tooltip="Dashboard"">
                    <div class="menu-icon">
                        <i class="bi bi-grid"></i>
                    </div>
                    <span class="menu-text">Dashboard</span>
                </a>
            </div>
        </div>

        <div class="menu-section">
            <div class="menu-section-title">All Pages</div>

            

            

            <div class="menu-item">
                <a href="#" class="menu-link" data-tooltip="All Food item from shop" onclick="toggleSubmenu(this)">
                    <div class="menu-icon">
                        <i class="bi bi-egg-fried"></i>
                    </div>
                    <span class="menu-text">Food</span>
                    <i class="menu-arrow bi bi-chevron-right"></i>
                </a>
                <div class="submenu">
                    <a href="viewFoods.jsp" class="menu-link">Food List </a>
                    <a href="${pageContext.request.contextPath}/nutricontrol?action=showfood" class="menu-link">Food Detail</a>
                </div>
            </div>
            <div class="menu-item">
                <a href="#" class="menu-link" data-tooltip="Sugess Food" onclick="toggleSubmenu(this)">
                    <div class="menu-icon">
                       <i class="bi bi-lightbulb-fill fs-4"></i>
                    </div>
                    <span class="menu-text">Food Suggestion</span>
                    <i class="menu-arrow bi bi-chevron-right"></i>
                </a>
                <div class="submenu">
                    <a href="#" class="menu-link">List Food Suggestion</a>
                    <a href="#" class="menu-link">Create new Suggestion</a>
                    <a href="#" class="menu-link">Detail</a>
                </div>
            </div>
            <div class="menu-item">
                <a href="#" class="menu-link" data-tooltip="Request" onclick="toggleSubmenu(this)">
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
                    <a href="invoice.jsp" class="menu-link">Invoice</a>
                </div>
            </div>

           
            
             <div class="menu-item">
                <a href="#" class="menu-link" data-tooltip="Users" onclick="toggleSubmenu(this)">
                    <div class="menu-icon">
                        <i class="bi bi-people"></i>
                    </div>
                    <span class="menu-text">Account</span>
                    <i class="menu-arrow bi bi-chevron-right"></i>
                </a>
                <div class="submenu">
                    <a href="#" class="menu-link">Setting</a>
                    <a href="#" class="menu-link">Change Password</a>
                    <a href="#" class="menu-link">Log out</a>
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

            <div class="marquee-container">
                <div class="marquee-text">
                    🍽️ Welcome to <strong>Healthy Food</strong> 🥗 Saler Management 💪 Eat Well, Live Better! 🥦
                </div>
            </div>
        </div>

        <div class="header-right">
            <div class="header-action" title="Notifications" id="notificationBtn">
                <i class="bi bi-bell"></i>
                <span class="notification-count">3</span>
            </div> 
            <div class="notification-dropdown" id="notificationDropdown">
                <div class="dropdown-header">Message</div>
                <ul class="notification-list">
                    <li>
                        <img src="avatar1.jpg" alt="Avatar">
                        <div class="text">
                            <strong>Cameron Williamson</strong>
                            <p>Hello?</p>
                        </div>
                        <span class="time">10:13 PM</span>
                    </li>
                </ul>
                <div class="view-all">
                    <a href="${pageContext.request.contextPath}/nutricontrol?action=show_messages">View all</a>
                </div>
            </div>

            <div class="header-action" title="Messages">
                <i class="bi bi-chat-dots"></i>
                <span class="notification-dot"></span>
            </div>

            <div class="header-action" title="Fullscreen">
                <i class="bi bi-arrows-fullscreen"></i>
            </div>



            <div class="user-profile" id ="user-account">
                <div class="user-avatar"><img src="${sessionScope.Account.image}" alt="Avatar" class="avatar-img"></div>
                <div class="user-info">
                    <div class="user-name">${sessionScope.Account.name}</div>
                    <div class="user-role">${sessionScope.Account.role}</div>
                </div>
                <i class="dropdown-arrow bi bi-chevron-down"></i>
            </div>
        </div>  
        <div class="account-dropdown" id="account-dropdown">
            <ul>
                <li><a href="/account"><i class="bi bi-person"></i> Account</a></li>
                <li><a href="/setting"><i class="bi bi-gear"></i> Setting</a></li>
                <li><a href="/support"><i class="bi bi-headset"></i> Support</a></li>
                <li><a href="/logout"><i class="bi bi-box-arrow-right"></i> Log out</a></li>
            </ul>
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
                                        <a href="order"><div class="text-tiny">Order</div></a>
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
const notifBtn = document.getElementById("notificationBtn");
const notifDropdown = document.getElementById("notificationDropdown");

notifBtn.addEventListener("click", () => {
    notifDropdown.style.display = notifDropdown.style.display === "block" ? "none" : "block";
});

document.addEventListener("click", (e) => {
    if (!notifBtn.contains(e.target) && !notifDropdown.contains(e.target)) {
        notifDropdown.style.display = "none";
    }
});
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


class AlertNotification {
    constructor() {
        this.container = null;
        this.alerts = [];
        this.init();
    }

    init() {
        if (!document.querySelector('.alert-container')) {
            this.container = document.createElement('div');
            this.container.className = 'alert-container';
            document.body.appendChild(this.container);
        } else {
            this.container = document.querySelector('.alert-container');
        }
    }

    show(message, type = 'danger', duration = 5000) {
        const alert = this.createAlert(message, type, duration);
        this.container.appendChild(alert);
        this.alerts.push(alert);

        // Trigger animation
        setTimeout(() => {
            alert.classList.add('show');
        }, 100);

        // Auto hide
        if (duration > 0) {
            this.startProgressBar(alert, duration);
            setTimeout(() => {
                this.hide(alert);
            }, duration);
        }

        return alert;
    }

    createAlert(message, type, duration) {
        const alert = document.createElement('div');
        alert.className = `custom-alert alert-${type}`;

        const icons = {
            danger: 'fas fa-exclamation-circle',
            success: 'fas fa-check-circle',
            warning: 'fas fa-exclamation-triangle',
            info: 'fas fa-info-circle'
        };

  alert.innerHTML = `
    <div class="alert-content">
        <i class="${icons[type]} alert-icon"></i>
        <div class="alert-message">${message}</div>
        <button class="alert-close">&times;</button>
    </div>
    ${duration > 0 ? '<div class="alert-progress"></div>' : ''}
`;
    alert.querySelector('.alert-close').addEventListener('click', () => {
    this.hide(alert);
});
        return alert;
    }



    startProgressBar(alert, duration) {
        const progressBar = alert.querySelector('.alert-progress');
        if (progressBar) {
            progressBar.style.width = '100%';
            setTimeout(() => {
                progressBar.style.width = '0%';
                progressBar.style.transition = `width ${duration}ms linear`;
            }, 50);
        }
    }

    hide(alert) {
        if (!alert || !alert.classList.contains('custom-alert'))
            return;

        alert.classList.remove('show');
        alert.classList.add('hide');

        setTimeout(() => {
            if (alert.parentNode) {
                alert.parentNode.removeChild(alert);
            }
            // Remove from alerts array
            const index = this.alerts.indexOf(alert);
            if (index > -1) {
                this.alerts.splice(index, 1);
            }
        }, 500);
    }

    hideAll() {
        this.alerts.forEach(alert => {
            this.hide(alert);
        });
    }

    // Convenience methods
    success(message, duration = 4000) {
        return this.show(message, 'success', duration);
    }

    error(message, duration = 6000) {
        return this.show(message, 'danger', duration);
    }

    warning(message, duration = 5000) {
        return this.show(message, 'warning', duration);
    }

    info(message, duration = 4000) {
        return this.show(message, 'info', duration);
    }
}

// Initialize global alert system
const alertSystem = new AlertNotification();

// Auto-detect existing alerts and convert them
document.addEventListener('DOMContentLoaded', function () {
    // Tìm các alert cũ và chuyển đổi
    const existingAlerts = document.querySelectorAll('.alert');
    existingAlerts.forEach(alert => {
        const message = alert.textContent.trim();
        let type = 'info';

        if (alert.classList.contains('alert-danger'))
            type = 'danger';
        else if (alert.classList.contains('alert-success'))
            type = 'success';
        else if (alert.classList.contains('alert-warning'))
            type = 'warning';

        // Ẩn alert cũ
        alert.style.display = 'none';

        // Hiển thị alert mới
        setTimeout(() => {
            alertSystem.show(message, type);
        }, 300);
    });
});


function showAlert(message, type = 'danger', duration = 5000) {
    return alertSystem.show(message, type, duration);
}

function showSuccess(message, duration = 4000) {
    return alertSystem.success(message, duration);
}

function showError(message, duration = 6000) {
    return alertSystem.error(message, duration);
}

function showWarning(message, duration = 5000) {
    return alertSystem.warning(message, duration);
}

function showInfo(message, duration = 4000) {
    return alertSystem.info(message, duration);
}

        </script>
    </body>
</html>