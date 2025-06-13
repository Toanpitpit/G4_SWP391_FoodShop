<%-- 
    Document   : nav
    Created on : Jun 13, 2025, 9:23:14 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                    <i class="menu-arrow bi bi-chevron-right"></i>
                </a>
            </div>
        </div>

        <div class="menu-section">
            <div class="menu-section-title">All Pages</div>

            <div class="menu-item">
                <a href="#" class="menu-link" data-tooltip="Blog Posts" onclick="toggleSubmenu(this)">
                    <div class="menu-icon">
                         <i class="bi bi-journal-text"></i>
                    </div>
                    <span class="menu-text">Blogs</span>
                    <i class="menu-arrow bi bi-chevron-right"></i>
                </a>
                <div class="submenu">
                    <a href="${pageContext.request.contextPath}/nutricontrol?action=createblog" class="menu-link">Design new Blog</a>
                    <a href="${pageContext.request.contextPath}/nutricontrol?action=displayblog" class="menu-link">Blogs List</a>
                    <a href="${pageContext.request.contextPath}/nutricontrol?action=blogdetail&id=null" class="menu-link">Blog Detail</a>
                </div>
            </div>

            <div class="menu-item">
                <a href="#" class="menu-link" data-tooltip="BMI type" onclick="toggleSubmenu(this)">
                    <div class="menu-icon">
                        <i class="bi bi-layers"></i>
                    </div>
                    <span class="menu-text">BMI type</span>
                    <i class="menu-arrow bi bi-chevron-right"></i>
                </a>
                <div class="submenu">
                    <a href="#" class="menu-link">BMI type List </a>
                    <a href="#" class="menu-link">New BMI type</a>
                </div>
            </div>

            <div class="menu-item">
                <a href="#" class="menu-link" data-tooltip="All Food item from shop" onclick="toggleSubmenu(this)">
                    <div class="menu-icon">
                        <i class="bi bi-egg-fried"></i>
                    </div>
                    <span class="menu-text">Food</span>
                    <i class="menu-arrow bi bi-chevron-right"></i>
                </a>
                <div class="submenu">
                    <a href="#" class="menu-link">Food List </a>
                    <a href="#" class="menu-link">Food Detail</a>
                </div>
            </div>
            <div class="menu-item">
                <a href="#" class="menu-link" data-tooltip="Sugess Food" onclick="toggleSubmenu(this)">
                    <div class="menu-icon">
                        <i class="bi bi-file-text"></i>
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
                    <span class="menu-text">Request</span>
                    <span class="menu-badge">12</span>
                    <i class="menu-arrow bi bi-chevron-right"></i>
                </a>
                <div class="submenu">
                    <a href="#" class="menu-link">Request List</a>
                    <a href="#" class="menu-link">Request Detail</a>
                    <a href="#" class="menu-link">Request Tracking</a>
                </div>
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
