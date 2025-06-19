<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<%
    String orderId = "INV-" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
    String orderDate = new SimpleDateFormat("dd/MM/yyyy HH:mm").format(new Date());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Invoice</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #4CAF50; /* màu xanh lá cây */
            border-bottom: 1px solid #ddd;
            padding: 10px 30px;
            border-radius: 10px; /* bo góc 4 phía */
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .navbar-logo {
            font-weight: bold;
            font-size: 20px;
            color: #ffffff;
        }

        .navbar-links a {
            margin-left: 15px;
            text-decoration: none;
            color: #4CAF50;
            font-weight: 600;
            background-color: #ffffff;
            padding: 6px 14px;
            border-radius: 12px;
            border: 2px solid #ffffff;
            transition: background-color 0.2s, color 0.2s;
        }

        .navbar-links a:hover {
            background-color: #e0f2e9;
            color: #388e3c;
        }

        .container {
            padding: 30px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="navbar-logo">
            <img src="img/logo/logo.png" alt="Logo" style="height: 30px; vertical-align: middle; margin-right: 10px;">
            <span>Invoice</span>
        </div>
        <div class="navbar-links">
            <a href="Homedemo.jsp">Home</a>
            <a href="order.jsp">Orders</a>
        </div>
    </div>
</body>
</html>



<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Invoice</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 0;
        }

        .invoice-box {
            max-width: 900px;
            margin: 40px auto;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }

        /* === HEADER / TITLE BAR === */
        .invoice-title-bar {
            background-color: #4CAF50;
            color: white;
            padding: 20px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .invoice-title-bar h1 {
            font-size: 26px;
            margin: 0;
            display: flex;
            align-items: center;
        }

        .invoice-title-bar h1 i {
            font-style: normal;
            font-weight: bold;
            font-size: 28px;
            margin-right: 10px;
            display: inline-block;
        }

        .invoice-info {
            text-align: right;
            font-size: 15px;
        }

        .invoice-info div {
            line-height: 1.6;
        }

        .content {
            padding: 30px;
        }

        /* === Placeholder === */
        .content h2 {
            margin-top: 0;
            color: #333;
        }
    </style>
</head>
<body>

<div class="invoice-box">

    <!-- Thanh tiêu đề -->
    <div class="invoice-title-bar">
        <h1><i>🧾</i> Invoice</h1>
        <div class="invoice-info">
            <div><strong>Order ID:</strong> <%= orderId %></div>
            <div><strong>Date:</strong> <%= orderDate %></div>
        </div>
    </div>

    <!-- Nội dung chính -->
    <div class="content">
        <h2>Thông tin hóa đơn</h2>
        <p>Phần nội dung chi tiết sẽ hiển thị ở đây...</p>
    </div>

</div>

</body>
</html>
