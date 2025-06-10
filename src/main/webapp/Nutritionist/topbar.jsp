<%-- 
    Document   : topbar
    Created on : Jun 7, 2025, 7:55:30 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="topbar">
    <div class="toggle">
        <ion-icon name="menu-outline"></ion-icon>
    </div>
    <div class="sidebar-brand">
        <i class="fas fa-leaf"></i>
        Fresh & Healthy
    </div>
    <div class="user">
        <c:choose>
            <c:when test="${not empty sessionScope.Account}">
                <img src="${sessionScope.Account.image}" alt="">
            </c:when>
            <c:otherwise>
                <img src="${pageContext.request.contextPath}/default-avatar.png" alt="avt">
            </c:otherwise>
        </c:choose>
    </div>
</div>
