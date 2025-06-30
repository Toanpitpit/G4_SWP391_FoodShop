<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Food</title>
    <style>
        body { font-family: "Segoe UI", sans-serif; background: #f0f0f0; padding: 40px; }
        form { background: white; padding: 30px; border-radius: 10px; width: 400px; margin: auto; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        label, input, select { display: block; width: 100%; margin-bottom: 15px; }
        input, select { padding: 10px; border: 1px solid #ccc; border-radius: 5px; }
        button { padding: 10px 20px; background: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #45a049; }
    </style>
</head>
<body>
    <form action="AddFoodServlet" method="post">
        <h2>Add New Food</h2>
        <label>Food Name:</label>
        <input type="text" name="name" required>

        <label>Category:</label>
        <input type="text" name="category">

        <label>Price:</label>
        <input type="number" step="0.01" name="price" required>

        <label>Status:</label>
        <select name="status">
            <option value="Available">Available</option>
            <option value="Out of Stock">Out of Stock</option>
        </select>

        <button type="submit">Add Food</button>
    </form>
</body>
</html>
