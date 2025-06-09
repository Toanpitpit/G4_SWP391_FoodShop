<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>View Foods</title>
    <style>
        body { font-family: "Segoe UI", sans-serif; padding: 20px; background: #f9f9f9; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th, td { padding: 12px; border: 1px solid #ccc; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        h2 { color: #4CAF50; }
    </style>
</head>
<body>
    <h2>Food List</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Food Name</th>
            <th>Food image</th>
            <th>Category</th>
            <th>Price</th>
            <th>Status</th>
        </tr>
        <!-- Loop dữ liệu -->
        <c:forEach var="food" items="${foodList}">
            <tr>
                <td>${food.id}</td>
                <td>${food.name}</td>
                <td>${food.category}</td>
                <td>${food.price}</td>
                <td>${food.status}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
