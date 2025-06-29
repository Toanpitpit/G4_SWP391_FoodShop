<%-- 
    Document   : DashBoard
    Created on : Jun 13, 2025, 9:00:38 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <a href="viewFoodList" class="menu-link">Food List </a>
                    <a href="foodDetail.jsp" class="menu-link">Food Detail</a>
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
                    🍽️ Welcome to <strong>Healthy Food</strong> 🥗 Saler management 💪 Eat Well, Live Better! 🥦
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
                    <h1 class="page-title">Dashboard</h1>
                    <nav class="breadcrumb-nav">
                        <a href="#" class="breadcrumb-item">Home</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <a href="#" class="breadcrumb-item">Pages</a>
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
                    <div class="row mb-4">
                        <div class="col-12">
                            <h2 class="mb-3">Welcome to Saler Dashboard</h2>
                            <p class="text-muted">Manage your eCommerce store with powerful tools and analytics.</p>
                        </div>
                    </div>

                    <!-- Stats Cards Row -->
                    <div class="row mb-4">
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <div class="bg-primary bg-gradient text-white rounded-3 p-3">
                                                <i class="bi bi-cart-fill fs-4"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="text-muted mb-1">Total Orders</h6>
                                            <h3 class="mb-0">1,234</h3>
                                            <small class="text-success">
                                                <i class="bi bi-arrow-up"></i> +12% from last month
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <div class="bg-success bg-gradient text-white rounded-3 p-3">
                                                <i class="bi bi-currency-dollar fs-4"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="text-muted mb-1">Revenue</h6>
                                            <h3 class="mb-0">$45,678</h3>
                                            <small class="text-success">
                                                <i class="bi bi-arrow-up"></i> +8% from last month
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <div class="bg-info bg-gradient text-white rounded-3 p-3">
                                                <i class="bi bi-people-fill fs-4"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="text-muted mb-1">Customers</h6>
                                            <h3 class="mb-0">892</h3>
                                            <small class="text-success">
                                                <i class="bi bi-arrow-up"></i> +15% from last month
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <div class="bg-warning bg-gradient text-white rounded-3 p-3">
                                                <i class="bi bi-box-seam fs-4"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="text-muted mb-1">Products</h6>
                                            <h3 class="mb-0">567</h3>
                                            <small class="text-danger">
                                                <i class="bi bi-arrow-down"></i> -3% from last month
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                 <!-- Thay thế placeholder bằng Order Management Section -->
        <div class="order-management-section">
            <!-- Search Form -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">Order Management</h5>
                </div>
                <div class="card-body">
   <!-- Form tìm kiếm -->
<form method="get" action="order" class="search-form">
    <div class="row g-3">
        <!-- Các trường tìm kiếm -->
        <div class="col-md-6 col-lg-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-hash"></i></span>
                <input type="text" name="orderId" class="form-control" 
                       placeholder="Order ID" value="${searchOrderId}" />
            </div>
        </div>
        
        <div class="col-md-6 col-lg-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person"></i></span>
                <input type="text" name="customerName" class="form-control" 
                       placeholder="Customer Name" value="${searchCustomerName}" />
            </div>
        </div>
        
        <!-- Sửa lại dropdown category -->
        <div class="col-md-6 col-lg-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-folder"></i></span>
                <select name="category" class="form-select">
                    <option value="">All Categories</option>
                    <option value="Đồ uống" ${searchCategory == 'Đồ uống' ? 'selected' : ''}>🥤 Đồ uống</option>
                    <option value="Healthy Food" ${searchCategory == 'Healthy Food' ? 'selected' : ''}>🥗 Healthy Food</option>
                    <option value="Món Chính" ${searchCategory == 'Món Chính' ? 'selected' : ''}>🍛 Món Chính</option>
                    <option value="Món Khai Vị" ${searchCategory == 'Món Khai Vị' ? 'selected' : ''}>🥟 Món Khai Vị</option>
                    <option value="Món Tráng Miệng" ${searchCategory == 'Món Tráng Miệng' ? 'selected' : ''}>🍰 Món Tráng Miệng</option>
                </select>
            </div>
        </div>
        
        <div class="col-md-6 col-lg-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-telephone"></i></span>
                <input type="text" name="phone" class="form-control" 
                       placeholder="Phone Number" value="${searchPhone}" />
            </div>
        </div>
        
        <div class="col-md-6 col-lg-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-basket"></i></span>
                <input type="text" name="food" class="form-control" 
                       placeholder="Food Name" value="${searchFood}" />
            </div>
        </div>
        
        <!-- Sửa lại dropdown status -->
        <div class="col-md-6 col-lg-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-info-circle"></i></span>
                <select name="status" class="form-select">
                    <option value="">All Statuses</option>
                    <option value="Pending" ${searchStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                    <option value="Accepted" ${searchStatus == 'Accepted' ? 'selected' : ''}>Accepted</option>
                    <option value="Rejected" ${searchStatus == 'Rejected' ? 'selected' : ''}>Rejected</option>
                    <option value="Cancelled" ${searchStatus == 'Cancelled' ? 'selected' : ''}>Cancelled</option>
                </select>
            </div>
        </div>
        
        <!-- Nút tìm kiếm và reset -->
        <div class="col-md-6 col-lg-3">
            <button type="submit" class="btn btn-primary w-100">
                <i class="bi bi-search me-2"></i> Search
            </button>
        </div>
        
        <div class="col-md-6 col-lg-3">
            <a href="${pageContext.request.contextPath}/order" class="btn btn-outline-secondary w-100">
                <i class="bi bi-arrow-counterclockwise me-2"></i> Reset
            </a>
        </div>
    </div>
</form>
</div>
            </div>

            <!-- Order Table -->

            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Name Customer</th>
                                    <th>Address</th>
                                    <th>Phone Number</th>
                                    <th>Order Food</th>
                                    <th>Image</th> <!-- Thêm cột ảnh -->
                                    <th>Category</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Total Price</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
    <c:choose>
        <c:when test="${not empty orderList}">
            <c:forEach var="order" items="${orderList}">
                <tr>
                    <td>${order.id}</td>
                    <td>${order.customerName}</td>
                    <td>${order.address}</td>
                    <td>${order.phone}</td>
                    <td>${order.food}</td>
                      <!-- THÊM ĐOẠN CODE HIỂN THỊ ẢNH TẠI ĐÂY -->
                <td>
                    <c:choose>
                        <c:when test="${not empty order.image}">
                            <img src="${pageContext.request.contextPath}/${order.image}" 
                                 alt="${order.food}" 
                                 class="food-image"
                                 style="width: 50px; height: 50px; object-fit: cover;"
                                 onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/${order.image}'">
                        </c:when>
                        <c:otherwise>
                            <div class="no-image-placeholder">
                                <i class="bi bi-image"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </td>
                <!-- KẾT THÚC PHẦN HIỂN THỊ ẢNH -->
                    <td>${order.category}</td>
                    <td>${order.quantity}</td>
                    <td>${order.price}</td>
                    <td>${order.getTotalPrice()}</td>
                    <td>
                        <span class="badge 
                            ${order.status == 'Pending' ? 'bg-warning' : 
                              order.status == 'Accepted' ? 'bg-success' : 
                              order.status == 'Rejected' ? 'bg-danger' : 
                              order.status == 'Cancelled' ? 'bg-secondary' : 'bg-info'}">
                            ${order.status}
                        </span>
                    </td>
                    <td>
                        <div class="d-flex gap-1">
                            <!-- Form cho các nút chức năng -->
                            <form method="post" action="order" class="d-flex gap-1">
                                <input type="hidden" name="orderId" value="${order.id}" />

                                <!-- Truyền các tham số tìm kiếm hiện tại -->
                                <input type="hidden" name="searchOrderId" value="${param.orderId}" />
                                <input type="hidden" name="searchCustomerName" value="${param.customerName}" />
                                <input type="hidden" name="searchCategory" value="${param.category}" />
                                <input type="hidden" name="searchPhone" value="${param.phone}" />
                                <input type="hidden" name="searchFood" value="${param.food}" />
                                <input type="hidden" name="searchStatus" value="${param.status}" />

                                <button type="submit" class="btn btn-success btn-sm" name="action" value="accept"
                                        onclick="return confirm('Accept order ${order.id}?');">
                                    <i class="bi bi-check-circle"></i>
                                </button>
                                <button type="submit" class="btn btn-danger btn-sm" name="action" value="reject"
                                        onclick="return confirm('Reject order ${order.id}?');">
                                    <i class="bi bi-x-circle"></i>
                                </button>
                                <button type="submit" class="btn btn-secondary btn-sm" name="action" value="cancel"
                                        onclick="return confirm('Cancel order ${order.id}?');">
                                    <i class="bi bi-slash-circle"></i>
                                </button>
                            </form>

                            <!-- Nút Track riêng biệt -->
                            <c:url var="trackUrl" value="ordertracking.jsp">
                                <c:param name="orderId" value="${order.id}"/>
                                <c:param name="food" value="${order.food}"/>
                                <c:param name="category" value="${order.category}"/>
                                <c:param name="quantity" value="${order.quantity}"/>
                                <c:param name="customerName" value="${order.customerName}"/>
                                <c:param name="phone" value="${order.phone}"/>
                                <c:param name="address" value="${order.address}"/>
                                <c:param name="image" value="${order.image}"/> <!-- Thêm dòng này -->
                            </c:url>
                            <a href="${trackUrl}" class="btn btn-info btn-sm">
                                <i class="bi bi-truck"></i> Track
                            </a>
                                <!-- Thêm nút View Invoice -->
        <c:url var="invoiceUrl" value="invoice.jsp">
            <c:param name="orderId" value="${order.id}"/>
            <c:param name="customerName" value="${order.customerName}"/>
            <c:param name="address" value="${order.address}"/>
            <c:param name="phone" value="${order.phone}"/>
            <c:param name="food" value="${order.food}"/>
            <c:param name="category" value="${order.category}"/>
            <c:param name="quantity" value="${order.quantity}"/>
            <c:param name="price" value="${order.price}"/>
            <c:param name="totalPrice" value="${order.getTotalPrice()}"/>
            <c:param name="status" value="${order.status}"/>
            <c:param name="image" value="${order.image}"/>
        </c:url>
        <a href="${invoiceUrl}" class="btn btn-primary btn-sm">
            <i class="bi bi-receipt"></i> Invoice
        </a>
                        </div>
                    </td>
                </tr>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <tr>
                <td colspan="11" class="text-center text-muted py-4">
                    <i class="bi bi-search me-2"></i>Không tìm thấy đơn hàng nào
                </td>
            </tr>
        </c:otherwise>
    </c:choose>
</tbody>
                        </table>
                    </div>
                </div>
            </div>
            <!-- Pagination -->
                <nav class="mt-4">
                    <ul class="pagination justify-content-center">
                        <li class="page-item disabled">
                            <a class="page-link" href="#" tabindex="-1">Previous</a>
                        </li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item">
                            <a class="page-link" href="#">Next</a>
                        </li>
                    </ul>
                </nav>
        </div>
        <!-- End of Order Management Section -->

    </div>
</div>

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
