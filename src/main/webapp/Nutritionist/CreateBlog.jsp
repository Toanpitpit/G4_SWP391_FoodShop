<%-- 
    Document   : CreateBlog
    Created on : May 27, 2025, 1:57:42 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html><head>
    <title>Tạo Bài Viết Mới</title>
    <link rel="stylesheet" href="/CSS/Nutritionist/createblog.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>

<h2 style="text-align: center;">📝 Tạo Blog Mới</h2>

<form action="createBlog" method="post" enctype="multipart/form-data" class="blog-form">
    <div>
        <label for="title">Tiêu đề bài viết:</label>
        <input type="text" id="title" name="title" required="">
    </div>

    <div>
        <label for="typeBMI">Loại BMI:</label>
        <select id="typeBMI" name="typeBMI" required="">
            <option value="">-- Chọn loại BMI --</option>
            <option value="1">Thiếu cân</option>
            <option value="2">Bình thường</option>
            <option value="3">Thừa cân</option>
            <option value="4">Béo phì</option>
        </select>
    </div>

    <div>
        <label for="image">Ảnh minh họa:</label>
        <input type="file" id="image" name="image" accept="image/*" required="">
    </div>

    <div>
        <label for="content">Nội dung bài viết:</label>
        <textarea id="content" name="content" rows="8" required=""></textarea>
    </div>

    <div style="text-align: center;">
        <button type="submit"><i class="fas fa-paper-plane"></i> Đăng bài</button>
    </div>
</form> 




</body></html>
