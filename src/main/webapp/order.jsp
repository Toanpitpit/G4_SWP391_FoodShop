<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Order</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/order.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

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
