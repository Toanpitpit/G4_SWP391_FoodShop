<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Food List</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            margin: 0;
            background: #f4f6f9;
        }

        .header {
            background-color: #4CAF50;
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 30px;
        }

        .logo img {
            height: 40px;
        }

        .title {
            flex-grow: 1;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }

        .back-button {
            text-decoration: none;
            color: #4CAF50;
            background-color: white;
            border: 2px solid white;
            padding: 8px 16px;
            border-radius: 6px;
            transition: all 0.3s;
        }

        .back-button:hover {
            background-color: #ffffff;
            color: #388E3C;
        }

        .search-bar {
            margin: 20px auto;
            width: 90%;
            background-color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }

        .search-bar input[type="text"],
        .search-bar input[type="number"],
        .search-bar select {
            padding: 8px 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        .search-bar button {
            background-color: #4CAF50;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .search-bar button:hover {
            background-color: #45a049;
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .food-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 6px;
        }
    </style>
</head>
<body>

<!-- Thanh tiêu đề -->
<div class="header">
    <div class="logo">
        <img src="img/logo/logo.png" alt="Logo">
    </div>
    <div class="title">Food List</div>
    <a href="ManageFoodsServlet" class="back-button">Back</a>
</div>

<!-- Thanh tìm kiếm -->
<form action="SearchFoodServlet" method="get" class="search-bar">
    <input type="text" name="searchID" placeholder="🔍 ID">
    <input type="text" name="searchName" placeholder="🍽️ Name">
    
    <select name="priceRange">
        <option value="">💲 All Prices</option>
        <option value="1">🔽 Dưới 30,000đ</option>
        <option value="2">💰 30,000–50,000đ</option>
        <option value="3">💵 50,000–100,000đ</option>
        <option value="4">💎 Trên 100,000đ</option>
    </select>

    <select name="searchCategory">
        <option value="">📂 All Categories</option>
        <option value="Đồ uống">🥤 Đồ uống</option>
        <option value="Healthy Food">🥗 Healthy Food</option>
        <option value="Món Chính">🍛 Món Chính</option>
        <option value="Món Khai Vị">🥟 Món Khai Vị</option>
        <option value="Món Tráng Miệng">🍰 Món Tráng Miệng</option>
    </select>
    <button type="submit">🔍 Search</button>
</form>

<!-- Bảng danh sách thực phẩm -->
<table>
    <tr>
        <th>ID</th>
        <th>Food Name</th>
        <th>Image</th>
        <th>Category</th>
        <th>Price</th>
        <th>Status</th>
        <th>Detail</th>
    </tr>
    <c:forEach var="food" items="${foodList}">
        <tr>
            <td>${food.id}</td>
            <td>${food.name}</td>
            <td>
                <img src="${food.image}" alt="Food Image" class="food-image">
            </td>
            <td>${food.category}</td>
            <td>$${food.price}</td>
            <td>${food.status}</td>
            <td><a href="FoodDetailServlet?id=${food.id}" style="color: #4CAF50;">View Detail</a></td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
