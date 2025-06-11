<%-- 
    Document   : topbar
    Created on : Jun 7, 2025, 7:55:30 PM
    Author     : Admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="topbar">
    <div> </div>
    <div class="topbar-actions">
        <button class="action-btn" onclick="toggleTheme()">
            <i class="fas fa-sun"></i>
        </button>
        <button class="action-btn" onclick="toggleNotifications()">
            <i class="fas fa-bell"></i>
            <span class="notification-badge">3</span>
        </button>
    </div>
    <div class="user">
        <c:choose>
            <c:when test="${not empty sessionScope.Account}">
                <img src="${sessionScope.Account.image}" alt="">
            </c:when>
            <c:otherwise>
                <img src="${pageContext.request.contextPath}/" alt="avt">
            </c:otherwise>
        </c:choose>
    </div>
</div>
