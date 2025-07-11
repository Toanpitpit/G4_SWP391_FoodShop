<%-- 
    Document   : DashBoard
    Created on : Jun 13, 2025, 9:00:38 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
                            <a href="#" class="menu-link">Order Tracking</a>
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
                            <h2 class="mb-3">Welcome to Remos Admin Dashboard</h2>
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

                    <!-- Main Content Area -->
                    <div class="placeholder-content">
                        <div class="placeholder-icon">
                            <i class="bi bi-plus-circle-dotted"></i>
                        </div>
                        <div class="placeholder-title">Add Your Custom Content Here</div>
                        <div class="placeholder-text">This is where you can add charts, tables, forms, or any other content for your dashboard.</div>
                    </div>
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
