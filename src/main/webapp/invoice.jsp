<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    
    String orderId = "INV-" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
    String orderDate = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date());
    
// Get data from request parameters
    String customerName = request.getParameter("customerName");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");
    String food = request.getParameter("food");
    String category = request.getParameter("category");
    String status = request.getParameter("status");
    String image = request.getParameter("image");
    
    // Parse numeric values with null checks
    int quantity = 0;
    double price = 0.0;
    double totalPrice = 0.0;
    
    try {
        if (request.getParameter("quantity") != null) {
            quantity = Integer.parseInt(request.getParameter("quantity"));
        }
        if (request.getParameter("price") != null) {
            price = Double.parseDouble(request.getParameter("price"));
        }
        if (request.getParameter("totalPrice") != null) {
            totalPrice = Double.parseDouble(request.getParameter("totalPrice"));
        }
    } catch (NumberFormatException e) {
        // Handle parsing errors gracefully
        quantity = 1;
        price = 0.0;
        totalPrice = 0.0;
    }
    
    // Calculate invoice totals
    double subtotal = totalPrice;
    double tax = subtotal * 0.08;
    double shipping = 30000.0;
    double grandTotal = subtotal + shipping + tax;
    
    // Set default values for null parameters
    if (customerName == null) customerName = "";
    if (address == null) address = "";
    if (phone == null) phone = "";
    if (food == null) food = "";
    if (category == null) category = "";
    if (status == null) status = "Pending";
    if (image == null) image = "";
%>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nutritionist Dashboard</title>
        <title>Invoice - Order #<%= orderId %></title>
        <!-- Bootstrap CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="CSS/defauld.css">
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <!-- Các thẻ meta, title, stylesheets giữ nguyên -->
  <style>
        .invoice-container {
            width: 100% !important;
            max-width: 100% !important;
            margin-left: 0 !important;
            padding: 0 !important;
        }
        
        .invoice-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #eee;
        }
        
        .invoice-title {
            font-size: 2.5rem;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .invoice-meta {
            text-align: right;
        }
        
        .invoice-company {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .company-info, .customer-info {
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .invoice-table {
            width: 100%;
            margin-bottom: 30px;
            border-collapse: collapse;
        }
        
        .invoice-table th, .invoice-table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        .invoice-table th {
            background: #343a40;
            color: white;
            font-weight: 600;
        }
        
        .food-image {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
        }
        
        .no-image-placeholder {
            width: 60px;
            height: 60px;
            background: #f8f9fa;
            border: 2px dashed #ccc;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
        }
        
        .invoice-totals {
            margin-left: auto;
            width: 300px;
            margin-bottom: 30px;
        }
        
        .total-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }
        
        .total-row.final {
            font-weight: bold;
            font-size: 1.2rem;
            color: #2c3e50;
            border-bottom: 2px solid #2c3e50;
        }
        
        .payment-method, .notes {
            margin-bottom: 30px;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
        }
        
        .thank-you {
            text-align: center;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 8px;
            margin-bottom: 30px;
        }
        
        .invoice-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 30px;
        }
        
        .signature-area {
            text-align: center;
        }
        
        .signature-line {
            width: 250px;
            border-bottom: 1px solid #000;
            margin: 20px auto 10px;
        }
        
        .stamp {
            position: absolute;
            top: 50px;
            right: 50px;
            transform: rotate(-15deg);
            font-size: 40px;
            color: #4CAF50;
            font-weight: bold;
            opacity: 0.7;
        }
        
        .breadcrumb-section {
            background: #f8f9fa;
            padding: 20px 0;
            margin-bottom: 30px;
        }
        
        .breadcrumb-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        .page-title {
            font-size: 2rem;
            margin-bottom: 10px;
            color: #2c3e50;
        }
        
        .breadcrumb-nav {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .breadcrumb-item {
            color: #6c757d;
            text-decoration: none;
        }
        
        .breadcrumb-item:hover {
            color: #495057;
        }
        
        .breadcrumb-item.active {
            color: #495057;
            font-weight: 600;
        }
        
        .content-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        @media print {
            .invoice-actions, .breadcrumb-section {
                display: none;
            }
            
            .invoice-container {
                box-shadow: none;
                margin: 0;
                padding: 0;
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
                    <a href="viewFoodList" class="menu-link">Food List </a>
                    <a href="viewFoodDetail" class="menu-link">Food Detail</a>
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



    <!-- Main Content -->
    <main class="main-content" id="mainContent" style="margin-left: 20px;">
        <!-- Breadcrumb Section -->
        <div class="breadcrumb-section">
            <div class="breadcrumb-container">
                <h1 class="page-title">Invoice Details</h1>
                <nav class="breadcrumb-nav">
                    <a href="#" class="breadcrumb-item">Home</a>
                    <span class="breadcrumb-separator">
                        <i class="bi bi-chevron-right"></i>
                    </span>
                    <a href="order" class="breadcrumb-item">Orders</a>
                    <span class="breadcrumb-separator">
                        <i class="bi bi-chevron-right"></i>
                    </span>
                    <span class="breadcrumb-item active">Invoice #<%= orderId %></span>
                </nav>
            </div>
        </div>

        <!-- Invoice Container -->
        <div class="content-wrapper">
            <div class="invoice-container">
                <!-- Invoice Header -->
                <div class="invoice-header">
                    <div class="invoice-title">
                        <i class="bi bi-receipt"></i> INVOICE
                    </div>
                    <div class="invoice-meta">
                        <div><strong>Order ID:</strong> #<%= orderId %></div>
                        <div><strong>Date:</strong> <%= orderDate %></div>
                        <div><strong>Status:</strong> 
                            <span class="badge 
                                <%= status.equals("Pending") ? "bg-warning" : 
                                    status.equals("Accepted") ? "bg-success" : 
                                    status.equals("Rejected") ? "bg-danger" : 
                                    status.equals("Cancelled") ? "bg-secondary" : "bg-info" %>">
                                <%= status %>
                            </span>
                        </div>
                    </div>
                </div>
                
                <!-- Company and Customer Info -->
                <div class="invoice-company">
                    <div class="company-info">
                        <h5>BILL FROM</h5>
                        <p>
                            <strong>Fresh & Healthy Nutrition Co.</strong><br>
                            123 Nutrition Street, District 1<br>
                            Ho Chi Minh City, Vietnam<br>
                            Phone: (84) 123 456 789<br>
                            Email: info@freshhealthy.com
                        </p>
                    </div>
                    
                    <div class="customer-info">
                        <h5>BILL TO</h5>
                        <p>
                            <strong><%= customerName %></strong><br>
                            <%= address %><br>
                            Phone: <%= phone %><br>
                            <c:if test="${not empty sessionScope.Account}">
                                Email: ${sessionScope.Account.email}
                            </c:if>
                        </p>
                    </div>
                </div>
                
                <!-- Invoice Table -->
                <table class="invoice-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Image</th>
                            <th>Category</th>
                            <th>Unit Price</th>
                            <th>Quantity</th>
                            <th>Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><%= food %></td>
                            <td>
                                <% if (image != null && !image.isEmpty()) { %>
                                    <img src="${pageContext.request.contextPath}/<%= image %>" 
                                         alt="<%= food %>" 
                                         class="food-image">
                                <% } else { %>
                                    <div class="no-image-placeholder">
                                        <i class="bi bi-image"></i>
                                    </div>
                                <% } %>
                            </td>
                            <td><%= category %></td>
                            <td><%= String.format("%,.0f", price) %>₫</td>
                            <td><%= quantity %></td>
                            <td><%= String.format("%,.0f", totalPrice) %>₫</td>
                        </tr>
                    </tbody>
                </table>
                
                <!-- Invoice Totals -->
                <div class="invoice-totals">
                    <div class="total-row">
                        <span>Subtotal:</span>
                        <span><%= String.format("%,.0f", subtotal) %>₫</span>
                    </div>
                    <div class="total-row">
                        <span>Shipping:</span>
                        <span><%= String.format("%,.0f", shipping) %>₫</span>
                    </div>
                    <div class="total-row">
                        <span>Tax (8%):</span>
                        <span><%= String.format("%,.0f", tax) %>₫</span>
                    </div>
                    <div class="total-row final">
                        <span>Grand Total:</span>
                        <span><%= String.format("%,.0f", grandTotal) %>₫</span>
                    </div>
                </div>
                
                <!-- Payment Method -->
                <div class="payment-method">
                    <h5>PAYMENT METHOD</h5>
                    <div class="d-flex align-items-center mt-3">
                        <div class="bg-light p-3 rounded me-3">
                            <i class="bi bi-credit-card fs-2 text-primary"></i>
                        </div>
                        <div>
                            <p class="mb-0"><strong>Credit Card (Visa)</strong></p>
                            <p class="mb-0">Card ending in **** 1234</p>
                            <p class="mb-0">Authorization code: AB123XYZ</p>
                        </div>
                    </div>
                </div>
                
                <!-- Notes -->
                <div class="notes">
                    <h5>NOTES</h5>
                    <p>Thank you for your order. Products will be shipped within 2 business days. For any inquiries, please contact our support team.</p>
                </div>
                
                <!-- Thank You Message -->
                <div class="thank-you">
                    <p>Thank you for choosing <strong>Fresh & Healthy Nutrition Co.</strong> - Providing quality nutrition products and services since 2010</p>
                </div>
                
                <!-- Actions and Signature -->
                <div class="invoice-footer">
                    <div class="signature-area">
                        <p>Authorized Signature</p>
                        <div class="signature-line"></div>
                        <p>Nguyen Van A, Finance Manager</p>
                    </div>
                    
                    <div class="invoice-actions">
                        <button class="btn btn-primary" onclick="window.print()">
                            <i class="bi bi-printer me-2"></i> Print Invoice
                        </button>
                        <button class="btn btn-success" id="downloadPdf">
                            <i class="bi bi-download me-2"></i> Download PDF
                        </button>
                    </div>
                </div>
                
                <!-- Stamp -->
                <div class="stamp">
                    PAID
                </div>
            </div>
        </div>
    </main>

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
 // Thêm chức năng tải PDF
            document.getElementById('downloadPdf').addEventListener('click', function() {
                alert('PDF download functionality would be implemented here. In a real application, this would generate and download a PDF version of the invoice.');
                // Trong ứng dụng thực, bạn có thể sử dụng thư viện như jsPDF
                // để tạo và tải xuống PDF
            });
        </script>
    </body>
</html>
