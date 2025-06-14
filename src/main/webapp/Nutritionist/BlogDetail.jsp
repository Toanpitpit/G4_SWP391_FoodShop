<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Blog Detail</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&family=Rubik:wght@500&family=Nunito:wght@600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/dashboard.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">
        <style>
            .blog-container {
                margin: 10px;
                padding: 20px;
            }
            .blog-post {
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                overflow: hidden;
                margin-bottom: 30px;
            }

            .blog-header {
                padding: 30px;
                border-bottom: 1px solid #eee;
            }

            .blog-title {
                font-size: 2.5rem;
                font-weight: 700;
                color: #2c3e50;
                margin-bottom: 20px;
                line-height: 1.2;
            }

            .blog-meta {
                display: flex;
                align-items: center;
                gap: 20px;
                flex-wrap: wrap;
                margin-bottom: 20px;
            }

            .meta-item {
                display: flex;
                align-items: center;
                gap: 8px;
                color: #6c757d;
                font-size: 0.9rem;
            }

            .meta-item i {
                color: #667eea;
            }

            .blog-tags {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .tag {
                background: linear-gradient(135deg, #667eea, #764ba2);
                color: white;
                padding: 5px 15px;
                border-radius: 20px;
                font-size: 0.8rem;
                text-decoration: none;
                transition: transform 0.2s;
            }

            .tag:hover {
                transform: translateY(-2px);
                color: white;
            }

            .blog-image {
                width: 100%;
                height: 400px;
                object-fit: cover;
            }

            .blog-content {
                padding: 30px;
            }

            .blog-content p {
                line-height: 1.8;
                color: #495057;
                margin-bottom: 20px;
                font-size: 1.1rem;
            }

            .blog-quote {
                background: #f8f9fa;
                border-left: 4px solid #667eea;
                padding: 20px;
                margin: 30px 0;
                font-style: italic;
                font-size: 1.2rem;
                color: #495057;
            }

            .blog-images {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
                margin: 30px 0;
            }

            .blog-images img {
                width: 100%;
                height: 250px;
                object-fit: cover;
                border-radius: 10px;
            }

            .sidebar-right {
                background: white;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                padding: 30px;
                height: fit-content;
            }

            .sidebar-right-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #667eea;
            }

            .author-widget {
                text-align: center;
                margin-bottom: 30px;
            }

            .author-avatar {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                margin: 0 auto 15px;
                background: linear-gradient(135deg, #667eea, #764ba2);
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.5rem;
                font-weight: 600;
            }

            .author-name {
                font-size: 1.2rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 5px;
            }

            .author-role {
                color: #6c757d;
                margin-bottom: 15px;
            }

            .social-links {
                display: flex;
                justify-content: center;
                gap: 10px;
                margin-bottom: 15px;
            }

            .social-links a {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: #f8f9fa;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #667eea;
                text-decoration: none;
                transition: all 0.3s;
            }

            .social-links a:hover {
                background: #667eea;
                color: white;
                transform: translateY(-2px);
            }

            .popular-posts {
                margin-bottom: 30px;
            }

            .popular-post {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
                padding-bottom: 20px;
                border-bottom: 1px solid #eee;
            }

            .popular-post:last-child {
                border-bottom: none;
                margin-bottom: 0;
                padding-bottom: 0;
            }

            .popular-post img {
                width: 80px;
                height: 60px;
                object-fit: cover;
                border-radius: 8px;
            }

            .popular-post-content h6 {
                font-size: 0.9rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 5px;
                line-height: 1.3;
            }

            .popular-post-content h6 a {
                color: #2c3e50;
                text-decoration: none;
            }

            .popular-post-content h6 a:hover {
                color: #667eea;
            }

            .post-time {
                font-size: 0.8rem;
                color: #6c757d;
            }

            .categories {
                margin-bottom: 30px;
            }

            .category-list {
                list-style: none;
                padding: 0;
            }

            .category-list li {
                margin-bottom: 10px;
            }

            .category-list a {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 10px 15px;
                background: #f8f9fa;
                border-radius: 8px;
                text-decoration: none;
                color: #495057;
                transition: all 0.3s;
            }

            .category-list a:hover {
                background: #667eea;
                color: white;
            }

            .category-count {
                background: white;
                color: #667eea;
                padding: 2px 8px;
                border-radius: 12px;
                font-size: 0.8rem;
                font-weight: 600;
            }

            .tag-cloud {
                display: flex;
                flex-wrap: wrap;
                gap: 8px;
            }

            .tag-cloud a {
                background: #f8f9fa;
                color: #495057;
                padding: 8px 15px;
                border-radius: 20px;
                text-decoration: none;
                font-size: 0.9rem;
                transition: all 0.3s;
            }

            .tag-cloud a:hover {
                background: #667eea;
                color: white;
            }

            @media (max-width: 768px) {
                .blog-title {
                    font-size: 2rem;
                }

                .blog-meta {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .blog-images {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <jsp:include page="/Nutritionist/nav.jsp"/>  
        <!-- Main Header -->
        <jsp:include page="/Nutritionist/main-header.jsp"/>  
        <!-- Main Content -->
        <main class="main-content" id="mainContent">

            <div class="breadcrumb-section">
                <div class="breadcrumb-container">
                    <h1 class="page-title" style="padding-left: 32px">Welcome to Nutritionist Admin Dashboard</h1>
                    <nav class="breadcrumb-nav">
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item"> 
                            <i class="fas fa-home"></i>Home
                        </a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=displayblog" class="new-breadcrumb-link">
                            Blog
                        </a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <span class="breadcrumb-item active">Blog detail</span>
                    </nav>
                </div>
            </div>
            <div class="blog-container">
                <c:choose>
                    <c:when test="${not empty blog}">
                        <div class="row">
                    <!-- Blog Post -->
                    <div class="col-lg-8">
                        <article class="blog-post">
                            <!-- Blog Header -->
                            <div class="blog-header">
                                <h1 class="blog-title">${blog.title}</h1>
                                <div class="blog-meta">
                                    <div class="meta-item">
                                        <i class="fas fa-user"></i>
                                        <span>${blog.authorName}</span>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fas fa-calendar"></i>
                                        <span><fmt:formatDate
                                                value="${blog.update_at}"
                                                pattern="yyyy-MM-dd HH:mm:ss" />
                                        </span>
                                    </div>
                                    <!--                            <div class="meta-item">
                                                                    <i class="fas fa-eye"></i>
                                                                    <span>1.2M lượt xem</span>
                                                                </div>-->
                                    <div class="meta-item">
                                        <i class="fas fa-comment"></i>
                                        <span>06 bình luận</span>
                                    </div>
                                </div>                       
                                <div class="blog-tags">
                                    <a href="#" class="tag">Thực phẩm</a>
                                </div>
                            </div>

                            <!-- Featured Image -->
                            <img src="${blog.imageUlr}" alt="Blog Image" class="blog-image">

                            <!-- Blog Content -->
                            <div class="blog-content">
                                ${blog.content}
                            </div>
                        </article>
                    </div>

                    <!-- Sidebar -->
                    <div class="col-lg-4">
                        <aside class="sidebar-right">
                            <!-- Author Widget -->
                            <div class="author-widget">
                                <div class="author-avatar">CB</div>
                                <div class="author-name">Charlie Barber</div>
                                <div class="author-role">Senior blog writer</div>
                                <div class="social-links">
                                    <a href="#"><i class="fab fa-facebook"></i></a>
                                    <a href="#"><i class="fab fa-twitter"></i></a>
                                    <a href="#"><i class="fab fa-github"></i></a>
                                    <a href="#"><i class="fab fa-behance"></i></a>
                                </div>
                                <p class="text-muted">Boot camps có những người ủng hộ và những người phản đối. Một số người không hiểu tại sao bạn phải chi tiền cho boot camp khi bạn có thể tự học.</p>
                            </div>
                            <!-- Popular Posts -->
                            <div class="popular-posts">
                                <h3 class="sidebar-right-title">Bài viết phổ biến</h3>
                                <c:forEach var="post" items="${relblog}">
                                    <div class="popular-post">
                                        <img src="${post.imageUlr}" alt="Popular Post">
                                        <div class="popular-post-content">
                                            <h6><a href="#">${post.title}</a></h6>
                                            <div class="post-time" data-created="${post.Update_at}"></div>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>

                            <!-- Categories -->
                            <div class="categories">
                                <h3 class="sidebar-title">Danh mục bài viết</h3>
                                <ul class="category-list">
                                    <li><a href="#">Công nghệ <span class="category-count">37</span></a></li>
                                    <li><a href="#">Phong cách sống <span class="category-count">24</span></a></li>
                                    <li><a href="#">Thời trang <span class="category-count">59</span></a></li>
                                    <li><a href="#">Nghệ thuật <span class="category-count">29</span></a></li>
                                    <li><a href="#">Thực phẩm <span class="category-count">15</span></a></li>
                                    <li><a href="#">Kiến trúc <span class="category-count">09</span></a></li>
                                    <li><a href="#">Phiêu lưu <span class="category-count">44</span></a></li>
                                </ul>
                            </div>

                            <!-- Tag Cloud -->
                            <div class="tag-cloud-section">
                                <h3 class="sidebar-title">Thẻ tag</h3>
                                <div class="tag-cloud">
                                    <a href="#">Công nghệ</a>
                                    <a href="#">Thời trang</a>
                                    <a href="#">Kiến trúc</a>
                                    <a href="#">Thực phẩm</a>
                                    <a href="#">Phong cách sống</a>
                                    <a href="#">Nghệ thuật</a>
                                    <a href="#">Phiêu lưu</a>
                                </div>
                            </div>
                        </aside>
                    </div>
                </div>
                    </c:when>
                    <c:otherwise>
                         <c:otherwise>
                            <p style="text-align: center; font-style: italic; color: #555; padding: 40px;">
                                Không có bài viết nào.
                            </p>
                        </c:otherwise>
                    </c:otherwise>
                </c:choose>

                <script>
                    // Function để tính thời gian "time ago"
                    function timeAgo(dateString) {
                        const now = new Date();
                        const postDate = new Date(dateString);
                        const diffInMilliseconds = now - postDate;

                        const seconds = Math.floor(diffInMilliseconds / 1000);
                        const minutes = Math.floor(seconds / 60);
                        const hours = Math.floor(minutes / 60);
                        const days = Math.floor(hours / 24);
                        const months = Math.floor(days / 30);
                        const years = Math.floor(months / 12);

                        if (years > 0)
                            return years + ' năm trước';
                        if (months > 0)
                            return months + ' tháng trước';
                        if (days > 0)
                            return days + ' ngày trước';
                        if (hours > 0)
                            return hours + ' giờ trước';
                        if (minutes > 0)
                            return minutes + ' phút trước';
                        return 'Vừa xong';
                    }

                    // Cập nhật tất cả thời gian khi trang load
                    document.addEventListener('DOMContentLoaded', function () {
                        const timeElements = document.querySelectorAll('.post-time[data-created]');

                        timeElements.forEach(function (element) {
                            const createdDate = element.getAttribute('data-created');
                            element.textContent = timeAgo(createdDate);
                        });

                        // Cập nhật thời gian mỗi phút
                        setInterval(function () {
                            timeElements.forEach(function (element) {
                                const createdDate = element.getAttribute('data-created');
                                element.textContent = timeAgo(createdDate);
                            });
                        }, 60000); // 60 giây
                    });
                </script>


                <jsp:include page="/Nutritionist/footer.jsp"/>  
        
        
        </main>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
        <script src="../JS/Nutritionist/home.js"></script>
        <script src="../JS/Nutritionist/common.js"></script>
    </body>
</html>
