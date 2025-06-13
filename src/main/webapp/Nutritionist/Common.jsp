<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="navigation">
    <div class="nav-header">
        <div class="sidebar-brand">
            <span>NUTRITIONIST PANEL</span>
        </div>
    </div>

    <ul>
        <li>
            <a href="dashboadnutri">
                <span class="icon">
                    <ion-icon name="home-outline"></ion-icon>
                </span>
                <span class="title">Dashboard</span>
            </a>
        </li>
        <li>
            <a href="">
                <span class="icon">
                    <ion-icon name="restaurant-outline"></ion-icon>
                </span>
                <span class="title">Foods</span>
            </a>
        </li>
        <li class="has-submenu">
            <div class="menu-item" onclick="toggleSubmenu(this)">
                <span class="icon">
                    <ion-icon name="create-outline"></ion-icon>
                </span>
                <span class="title">Food Draft</span>
            </div>
            <ul>
                <li>
                    <a href="">
                        <span>Food draft List</span>
                    </a>
                </li>
                <li>
                    <a href="">
                        <span>New Food Draft</span>
                    </a>
                </li>
            </ul>
        </li>
        <li class="has-submenu">
            <div class="menu-item" onclick="toggleSubmenu(this)">
                <span class="icon">
                    <ion-icon name="document-text-outline"></ion-icon>
                </span>
                <span class="title">My Blogs</span>
            </div>
            <ul>
                <li>
                    <a href="nutricontrol?action=displayblog">
                        <span>Blogs List</span>
                    </a>
                </li>
                <li>
                    <a href="nutricontrol?action=createblog">
                        <span>New Blogs</span>
                    </a>
                </li>
            </ul>
        </li>
        <li>
            <a href="">
                <span class="icon">
                    <ion-icon name="notifications-outline"></ion-icon>
                </span>
                <span class="title">Notifications</span>
            </a>
        </li>
        <li>
            <a href="/ProfileController">
                <span class="icon">
                    <ion-icon name="settings-outline"></ion-icon>
                </span>
                <span class="title">Settings</span>
            </a>
        </li>
        <li>
            <a href="/LogoutController">
                <span class="icon">
                    <ion-icon name="log-out-outline"></ion-icon>
                </span>
                <span class="title">Sign Out</span>
            </a>
        </li>
    </ul>
</div>

