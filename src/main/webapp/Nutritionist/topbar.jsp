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
    <div class="user">
        <img src="{sessionScope.Account.imageUrl}" alt="">
    </div>
</div>
