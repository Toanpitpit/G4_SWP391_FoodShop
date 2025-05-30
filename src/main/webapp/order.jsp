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

<div style="background: white;">
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
</div>

</div>

    <table border="1" style="
    width: 95%;
    margin: 30px auto;
    text-align: center;
    border-collapse: separate;
    border-spacing: 0;
    border-radius: 12px;
    overflow: hidden;
">
    <tr style="background-color: #28a745; color: white; font-weight: bold;">
        <th style="width: 70px; padding: 10px; border-top-left-radius: 12px;">OrderID</th>
        <th style="width: 200px; padding: 10px;">Name customer</th>
        <th style="width: 260px; padding: 10px;">Address</th>
        <th style="width: 200px; padding: 10px;">Phone number</th>
        <th style="width: 260px; padding: 10px;">Order food</th>
        <th style="width: 50px; padding: 10px;">Quantity</th>
        <th style="width: 200px; padding: 10px;">Price</th>
        <th style="width: 260px; padding: 10px; border-top-right-radius: 12px;">Actions</th>
    </tr>
</table>


        <c:forEach var="order" items="${orderList}">
            <tr>
                <td>${order.id}</td>
                <td>${order.customerName}</td>
                <td>${order.address}</td>
                <td>${order.phone}</td>
                <td>${order.food}</td>
                <td>${order.quantity}</td>
                <td>${order.price} vnd</td>
                <td>
                    <form action="order" method="post">
                        <input type="hidden" name="orderId" value="${order.id}" />
                        <button type="submit" name="action" value="accept">Accept</button>
                        <button type="submit" name="action" value="reject">Reject</button>
                        <button type="submit" name="action" value="cancel">Cancel</button>
                        <button type="submit" name="action" value="status">Status</button>
                    </form>

                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
