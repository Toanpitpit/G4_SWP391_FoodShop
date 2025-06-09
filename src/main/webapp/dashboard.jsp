<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/style.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
    body {
        margin: 0;
        padding: 0;
        font-family: "Segoe UI", sans-serif;
        background-image: url('${pageContext.request.contextPath}/img/avar/carousel-2.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        min-height: 100vh;
    }

    .overlay {
        background-color: rgba(255, 255, 255, 0.7);
        min-height: 100vh;
        width: 100%;
        position: relative;
    }

    .dashboard-header {
        background: linear-gradient(to right, #4CAF50, #45A049);
        color: white;
        padding: 30px 50px;
        display: flex;
        align-items: center;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        width: 100%;
        border-radius: 0;
        box-sizing: border-box;
        margin: 0 auto;
        position: relative;
    }

    .dashboard-header h2 {
        font-size: 32px;
        font-weight: bold;
        margin: 0 auto;
    }

    .circle-container {
        width: 400px;
        height: 400px;
        border-radius: 50%;
        background: rgba(255, 255, 255, 0.5);
        backdrop-filter: blur(10px);
        margin: 60px auto;
        position: relative;
        box-shadow: 0 0 30px rgba(0,0,0,0.08);
        border: 2px solid #4CAF50;
    }

    .circle-button {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        border: none;
        background: white;
        color: #4CAF50;
        font-size: 15px;
        font-weight: bold;
        text-align: center;
        line-height: 1.2;
        position: absolute;
        text-decoration: none;
        transition: 0.3s ease;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 10px;
    }

    .circle-button i {
        font-size: 24px;
        margin-bottom: 6px;
    }

    .circle-button:hover {
        background-color: #4CAF50;
        color: white;
        transform: scale(1.05);
    }

    .top { top: 0; left: 50%; transform: translate(-50%, -50%); }
    .bottom { bottom: 0; left: 50%; transform: translate(-50%, 50%); }
    .left { left: 0; top: 50%; transform: translate(-50%, -50%); }
    .right { right: 0; top: 50%; transform: translate(50%, -50%); }

    @media screen and (max-width: 500px) {
        .circle-container {
            width: 300px;
            height: 300px;
        }
        .circle-button {
            width: 90px;
            height: 90px;
            font-size: 13px;
        }
        .circle-button i {
            font-size: 18px;
        }
    }

    .center-image {
        width: 120px;
        height: 120px;
        object-fit: contain;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 1;
        pointer-events: none;
    }
    
    .dashboard-header {
    position: relative;
    justify-content: space-between;
}

.home-button {
    position: absolute;
    right: 30px;
    top: 50%;
    transform: translateY(-50%);
    background-color: white;
    color: #4CAF50;
    padding: 10px 18px;
    border-radius: 20px;
    font-weight: bold;
    text-decoration: none;
    transition: 0.3s ease;
    box-shadow: 0 2px 6px rgba(0,0,0,0.15);
    display: flex;
    align-items: center;
    gap: 8px;
}

.home-button:hover {
    background-color: #4CAF50;
    color: white;
}

</style>

</head>
<body>

<div class="overlay">

    <div class="dashboard-header">
        <a href="Homedemo.jsp">
            <img src="${pageContext.request.contextPath}/img/logo/logo.png" alt="Logo" width="80">
        </a>
        <h2>Dashboard Saler</h2>
        <a href="Homedemo.jsp" class="home-button">
            <i class="fas fa-home"></i> Home
        </a>
    </div>

   <div class="circle-container">
    <img src="${pageContext.request.contextPath}/img/logo/icon-1.png" alt="Center" class="center-image">

    <a href="order.jsp" class="circle-button top">
        <i class="fas fa-clipboard-list"></i>
        Order
    </a>
    <a href="manageFoods.jsp" class="circle-button bottom">
        <i class="fas fa-carrot"></i>
        Foods
    </a>
    <a href="profile.jsp" class="circle-button left">
        <i class="fas fa-user-circle"></i>
        Profile
    </a>
    <a href="notification.jsp" class="circle-button right">
        <i class="fas fa-bell"></i>
        Notify
    </a>
</div>


</div>

</body>
</html>
