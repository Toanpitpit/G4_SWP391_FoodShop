<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Food</title>
    <style>
        body { font-family: "Segoe UI", sans-serif; padding: 40px; background: #fff7f7; }
        form { background: white; padding: 30px; border-radius: 10px; width: 400px; margin: auto; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        select { width: 100%; padding: 10px; margin-bottom: 20px; border-radius: 5px; border: 1px solid #ccc; }
        button { background: #f44336; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; }
        button:hover { background: #d32f2f; }
    </style>
</head>
<body>
    <form action="DeleteFoodServlet" method="post">
        <h2>Delete Food</h2>

        <label>Select Food to Delete:</label>
        <select name="id">
            <!-- Replace with actual food list -->
            <c:forEach var="food" items="${foodList}">
                <option value="${food.id}">${food.name}</option>
            </c:forEach>
        </select>

        <button type="submit">Delete</button>
    </form>
</body>
</html>
