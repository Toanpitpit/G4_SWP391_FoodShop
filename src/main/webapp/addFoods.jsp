<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Food</title>

</head>
<body>
   <form action="addFood" method="post" enctype="multipart/form-data">
    <div class="mb-3">
        <label>Food Name:</label>
        <input type="text" name="name" required class="form-control" />
    </div>
    <div class="mb-3">
        <label>Image:</label>
        <input type="file" name="image" accept="image/*" class="form-control" />
    </div>
    <div class="mb-3">
        <label>Category:</label>
        <select name="category" class="form-control">
            <option value="Đồ uống">🥤 Drinks</option>
            <option value="Healthy Food">🥗 Healthy Food</option>
            <!-- Thêm các mục khác -->
        </select>
    </div>
    <div class="mb-3">
        <label>Price:</label>
        <input type="number" name="price" required class="form-control" />
    </div>
    <div class="mb-3">
        <label>Status:</label>
        <select name="status" class="form-control">
            <option value="Available">Available</option>
            <option value="Out of stock">Out of stock</option>
        </select>
    </div>
    <button type="submit" class="btn btn-success">Submit</button>
</form>

</body>
</html>
