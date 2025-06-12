<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Order</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f6f6f6;
        }

        .order-header {
            background: linear-gradient(to right, #6AAF70, #5DA463);
            color: white;
            padding: 30px 50px;
            display: flex;
            align-items: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            border-radius: 20px;
            box-sizing: border-box;
            margin: 20px auto;
            position: relative;
            overflow: hidden;
        }

        .order-header h2 {
            font-size: 32px;
            font-weight: bold;
            margin: 0;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }

        .order-buttons {
            margin-left: auto;
            display: flex;
            gap: 10px;
        }

        .nav-button {
            background-color: white;
            color: #56ab2f;
            border: 2px solid #56ab2f;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
            transition: all 0.3s ease;
        }

        .nav-button:hover {
            background-color: #56ab2f;
            color: white;
        }

        .search-form {
            width: 95%;
            margin: 20px auto;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            align-items: center;
            justify-content: center;
        }

        .search-form input {
            padding: 10px;
            width: 180px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        .search-form button {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        table {
            width: 95%;
            margin: 30px auto;
            text-align: center;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 12px;
            overflow: hidden;
            background: white;
        }

        th {
            background-color: #28a745;
            color: white;
            font-weight: bold;
            padding: 10px;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .action-button {
            padding: 6px 10px;
            border: none;
            border-radius: 6px;
            margin: 2px;
            cursor: pointer;
        }

        .accept { background-color: #4CAF50; color: white; }
        .reject { background-color: #f44336; color: white; }
        .cancel { background-color: #ff9800; color: white; }

        .action-button:hover {
            opacity: 0.8;
        }
        .form-group {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    align-items: center;
}

.input-icon {
    position: relative;
    display: flex;
    align-items: center;
}

.input-icon i {
    position: absolute;
    left: 10px;
    color: #888;
    z-index: 1;
}

.input-icon input,
.input-icon select {
    padding: 8px 12px 8px 35px;
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 14px;
    width: 200px;
    box-sizing: border-box;
    appearance: none;
}

    </style>
</head>
<body>

<!-- HEADER -->
<div class="order-header">
    <a href="salerDashboard.jsp">
        <img src="${pageContext.request.contextPath}/img/logo/logo.png" alt="Logo" width="100">
    </a>
    <h2><i class="fas fa-leaf"></i> Manage Order</h2>
    <div class="order-buttons">
        <a href="invoice.jsp" class="nav-button"><i class="fa-solid fa-receipt"></i> Invoice</a>
        <a href="profile.jsp" class="nav-button"><i class="fa-solid fa-user"></i> Profile</a>
        <a href="Homedemo.jsp" class="nav-button"><i class="fa-solid fa-house"></i> Home</a>
    </div>
</div>

<!-- SEARCH FORM -->
<form method="get" action="ManageOrderServlet" class="search-form">
    <div class="form-group">
        <div class="input-icon">
            
            <input type="text" name="orderId" placeholder="🔢  Order ID" value="${param.orderId}" />
        </div>

        <div class="input-icon">
            
            <input type="text" name="customerName" placeholder="👤  Customer Name" value="${param.customerName}" />
        </div>

        <div class="input-icon">
         
            <select name="category">
                <option value="">📂 All Categories</option>
                <option value="Đồ uống" ${param.category == 'Đồ uống' ? 'selected' : ''}>🥤 Đồ uống</option>
                <option value="Healthy Food" ${param.category == 'Healthy Food' ? 'selected' : ''}>🥗 Healthy Food</option>
                <option value="Món Chính" ${param.category == 'Món Chính' ? 'selected' : ''}>🍛 Món Chính</option>
                <option value="Món Khai Vị" ${param.category == 'Món Khai Vị' ? 'selected' : ''}>🥟 Món Khai Vị</option>
                <option value="Món Tráng Miệng" ${param.category == 'Món Tráng Miệng' ? 'selected' : ''}>🍰 Món Tráng Miệng</option>
            </select>
        </div>

        <div class="input-icon">
      
            <input type="text" name="phone" placeholder="📞  Phone Number" value="${param.phone}" />
        </div>

        <div class="input-icon">
           
            <input type="text" name="food" placeholder="🍽️  Food Name" value="${param.food}" />
        </div>

        <button type="submit">
            <i class="fas fa-search" style="margin-right: 5px;"></i> Search
        </button>
    </div>
</form>


<!-- ORDER TABLE -->
<table>
    <tr>
        <th>Order ID</th>
        <th>Name Customer</th>
        <th>Address</th>
        <th>Phone Number</th>
        <th>Order Food</th>
        <th>Category</th>
        <th>Quantity</th>
        <th>Price</th>
        <th>Total Price</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>

    <c:forEach var="order" items="${orderList}">
        <tr>
            <td>${order.id}</td>
            <td>${order.customerName}</td>
            <td>${order.address}</td>
            <td>${order.phone}</td>
            <td>${order.food}</td>
            <td>${order.category}</td>
            <td>${order.quantity}</td>
            <td>${order.price}</td>
            <td>${order.totalPrice}</td>
            <td>${order.status}</td>
            <td>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="orderId" value="${order.id}" />
                    <button type="submit" class="action-button accept" name="action" value="accept"
                            onclick="return confirm('Accept order ${order.id}?');">Accept</button>
                    <button type="submit" class="action-button reject" name="action" value="reject"
                            onclick="return confirm('Reject order ${order.id}?');">Reject</button>
                    <button type="submit" class="action-button cancel" name="action" value="cancel"
                            onclick="return confirm('Cancel order ${order.id}?');">Cancel</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
