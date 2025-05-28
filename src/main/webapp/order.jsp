<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <title>Manage Order</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
</head>
<body>
    <style>
   .order-header {
    background: linear-gradient(to right, #6AAF70, #5DA463);
    color: white;
    padding: 30px 50px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    margin: 20px;
    position: relative;  /* Thêm để dùng position absolute cho tiêu đề */
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
    margin-left: auto;  /* Giữ nút về bên phải */
    display: flex;
    gap: 10px;
}


    .order-buttons button {
        background-color: white;
        color: #56ab2f;
        border: 2px solid #56ab2f;
        padding: 10px 20px;
        font-size: 16px;
        border-radius: 8px;
        cursor: pointer;
        margin-left: 10px;
        transition: all 0.3s ease;
    }

    .order-buttons button:hover {
        background-color: #56ab2f;
        color: white;
    }
    .nav-button {
    background-color: white;
    color: #56ab2f;
    border: 2px solid #56ab2f;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 8px;
    cursor: pointer;
    margin-left: 10px;
    transition: all 0.3s ease;
    text-decoration: none; /* bỏ gạch chân */
    display: inline-block;
    text-align: center;
}

.nav-button:hover {
    background-color: #56ab2f;
    color: white;
}

</style>


<div class="order-header">
    <a href="home.jsp">
    <img src="${pageContext.request.contextPath}/img/logo/logo.png" alt="Logo" width="100">
    </a>
    <h2>Manage Order</h2>
    <div class="order-buttons">
    <a href="invoice.jsp" class="nav-button">Invoice</a>
    <a href="profile.jsp" class="nav-button">Profile</a>
    <a href="Homedemo.jsp" class="nav-button">Home</a>
</div>
</div>

    <table border="1" width="100%" style="margin-top:20px; text-align:center;">
        <tr>
            <th style=" background-color: violet;width: 70px">OrderID</th>
            <th style=" background-color: violet;width: 200px">Name customer</th>
            <th style=" background-color: violet;width: 260px">Address</th>
            <th style=" background-color: violet;width: 200px">Phone number</th>
            <th style=" background-color: violet;width: 260px">Order food</th>
            <th style=" background-color: violet;width: 50px">Quantity</th>
            <th style=" background-color: violet;width: 200px">Price</th>
            <th style=" background-color: violet;width: 260px">Actions</th>
        </tr>

        <c:forEach var="order" items="${requestScope.orderList}">
            <tr>
                <td>${order.id}</td>
                <td>${order.customerName}</td>
                <td>${order.address}</td>
                <td>${order.phone}</td>
                <td>${order.food}</td>
                <td>${order.quantity}</td>
                <td>${order.price} vnd</td>
                <td>
                    <form action="ManageOrderAction" method="post">
                        <input type="hidden" name="orderId" value="${order.id}" />
                        <button name="action" value="accept">Accept</button>
                        <button name="action" value="reject">Reject</button>
                        <button name="action" value="cancel">Cancel</button>
                        <button name="action" value="status">Status</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
