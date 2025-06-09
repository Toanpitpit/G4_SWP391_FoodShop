<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Food</title>
    <style>
        body { font-family: "Segoe UI", sans-serif; background: #eef; padding: 40px; }
        form { background: white; padding: 30px; border-radius: 10px; width: 400px; margin: auto; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        label, input, select { display: block; width: 100%; margin-bottom: 15px; }
        input, select { padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        button { padding: 10px 20px; background: #2196F3; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #0b7dda; }
    </style>
</head>
<body>
    <form action="UpdateFoodServlet" method="post">
        <h2>Update Food</h2>

        <label>Choose Food to Update:</label>
        <select name="id">
            <!-- Replace with actual food list -->
            <c:forEach var="food" items="${foodList}">
                <option value="${food.id}">${food.name}</option>
            </c:forEach>
        </select>

        <label>New Name:</label>
        <input type="text" name="name">

        <label>New Category:</label>
        <input type="text" name="category">

        <label>New Price:</label>
        <input type="number" step="0.01" name="price">

        <label>Status:</label>
        <select name="status">
            <option value="Available">Available</option>
            <option value="Out of Stock">Out of Stock</option>
        </select>

        <button type="submit">Update</button>
    </form>
</body>
</html>
