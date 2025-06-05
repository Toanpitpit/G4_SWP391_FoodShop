<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Food Blogs</title>
    <style>
        /* Main container styling */
        .blog-container {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        
        /* Header section */
        .blog-header {
            margin-bottom: 30px;
        }
        
        .blog-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 10px;
        }
        
        .blog-intro {
            font-size: 16px;
            color: #555;
            line-height: 1.6;
            margin-bottom: 20px;
        }
        
        .continue-btn {
            display: inline-block;
            background-color: #ff6b6b;
            color: white;
            padding: 8px 20px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        
        .continue-btn:hover {
            background-color: #ff5252;
        }
        
        /* Blog list styling */
        .blog-section-title {
            font-size: 24px;
            color: #333;
            margin: 40px 0 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #eee;
        }
        
        .blog-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 25px;
        }
        
        .blog-item {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        
        .blog-item:hover {
            transform: translateY(-5px);
        }
        
        .blog-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }
        
        .blog-content {
            padding: 15px;
        }
        
        .blog-item-title {
            font-size: 18px;
            margin-bottom: 10px;
            color: #333;
        }
        
        .blog-meta {
            display: flex;
            justify-content: space-between;
            color: #777;
            font-size: 14px;
        }
        
        .blog-author {
            font-weight: bold;
        }
        
        .blog-date {
            color: #999;
        }
        
        /* Responsive adjustments */
        @media (max-width: 600px) {
            .blog-list {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="blog-container">
        <!-- Header Section -->
        
        
        <!-- Blog List Section -->
        <h2 class="blog-section-title">TOP 5 MẪU BALO DÀNH CHO HỌC SINH ĐƯỢC YÊU THÍCH NHẤT</h2>
        
        <div class="blog-list">
            <%-- JSTL forEach loop to display blogs --%>
            <c:forEach var="blog" items="${blogList}" begin="0" end="4">
                <div class="blog-item">
                    <%-- Blog image --%>
                    <img src="${blog.imageUrl}" alt="${blog.title}" class="blog-image">
                    
                    <div class="blog-content">
                        <%-- Blog title --%>
                        <h3 class="blog-item-title">${blog.title}</h3>
                        
                        <%-- Blog meta information --%>
                        <div class="blog-meta">
                            <span class="blog-author">${blog.author}</span>
                            <span class="blog-date">${blog.update_at}</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <%-- Static example (would be replaced by dynamic content in real app) --%>
            <div class="blog-item">
                <img src="https://via.placeholder.com/300x180" alt="Ananas backpack" class="blog-image">
                <div class="blog-content">
                    <h3 class="blog-item-title">Mẫu balo Ananas phong cách streetwear</h3>
                    <div class="blog-meta">
                        <span class="blog-author">Thanh Quý</span>
                        <span class="blog-date">2022-01-05</span>
                    </div>
                </div>
            </div>
            <div class="blog-header">
            <h1 class="blog-title">Mùa tựu trường sắp đến rồi</h1>
            <p class="blog-intro">
                Popài chuẩn bị sách vở, balo cũng cần "sắm sửa" cho mình vài em balo mới đi học 
                vừa bền vừa đẹp, dễ phối đồ nữa. Sau đây, Extrim sẽ gợi ý cho bạn 5 mẫu balo đi học 
                hot nhất 2022 đáp ứng đầy đủ các tiêu chí: trend, đẹp, dễ phối đồ, giá rẻ cực kỳ phù 
                hợp với học sinh - sinh viên nhé!
            </p>
            <a href="#" class="continue-btn">ĐỌC TIẾP</a>
        </div>
        </div>
    </div>
</body>
</html>
