<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Foods</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            margin: 0;
            padding: 0;
            background: #f5f5f5;
        }

        .header {
            background: linear-gradient(to right, #4CAF50, #45A049);
            color: white;
            padding: 20px 40px;
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            align-items: center;
            position: relative;
        }

        .logo {
            width: 50px;
            height: 50px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            grid-column: 2; /* cột giữa */
        }

        .back-btn-container {
            display: flex;
            justify-content: flex-end;
        }

        .back-btn {
            background-color: white;
            color: #4CAF50;
            padding: 10px 15px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: bold;
            display: inline-flex;
            align-items: center;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .back-btn i {
            margin-right: 8px;
        }

        .back-btn:hover {
            background-color: #e8f5e9;
            transform: scale(1.05);
        }

        .button-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            padding: 50px;
            max-width: 900px;
            margin: 0 auto;
        }

        .manage-btn {
            padding: 30px 20px;
            font-size: 18px;
            background-color: white;
            border: 2px solid #4CAF50;
            color: #4CAF50;
            text-align: center;
            text-decoration: none;
            border-radius: 12px;
            font-weight: bold;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .manage-btn i {
            font-size: 28px;
            margin-bottom: 10px;
            display: block;
        }

        .manage-btn:hover {
            background-color: #4CAF50;
            color: white;
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<div class="header">
    <!-- Cột trái -->
    <div class="header-left">
        <img src="${pageContext.request.contextPath}/img/logo/logo.png" alt="Logo" class="logo">
    </div>

    <!-- Cột giữa -->
    <div class="header-title">Manage Foods</div>

    <!-- Cột phải -->
    <div class="back-btn-container">
        <a href="dashboard.jsp" class="back-btn">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</div>

<div class="button-container">
    <a href="viewFoods.jsp" class="manage-btn">
        <i class="fas fa-list"></i>
        View Foods
    </a>
    <a href="addFoods.jsp" class="manage-btn">
        <i class="fas fa-plus-circle"></i>
        Add Food
    </a>
    <a href="updateFood.jsp" class="manage-btn">
        <i class="fas fa-edit"></i>
        Update Food
    </a>
    <a href="deleteFood.jsp" class="manage-btn">
        <i class="fas fa-trash"></i>
        Delete Food
    </a>
</div>

</body>
</html>
