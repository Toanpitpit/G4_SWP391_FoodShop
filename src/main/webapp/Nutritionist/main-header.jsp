<%-- 
    Document   : main-header
    Created on : Jun 13, 2025, 9:58:39 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header class="main-header" id="mainHeader">
    <div class="header-content">
        <div class="header-left">
            <button class="mobile-toggle" onclick="toggleSidebar()">
                <i class="bi bi-list"></i>
            </button>

            <div class="marquee-container">
                <div class="marquee-text">
                    🍽️ Welcome to <strong>Healthy Food</strong> 🥗 Nutritionist Management 💪 Eat Well, Live Better! 🥦
                </div>
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

            <div class="user-profile" id ="user-account">
                <div class="user-avatar"><img src="${sessionScope.Account.image}" alt="Avatar" class="avatar-img"></div>
                <div class="user-info">
                    <div class="user-name">${sesion.Scope.Account.name}</div>
                    <div class="user-role">${sesion.Scope.Account.role}</div>
                </div>
                <i class="dropdown-arrow bi bi-chevron-down"></i>
            </div>
        </div>
    </div>
</header>
