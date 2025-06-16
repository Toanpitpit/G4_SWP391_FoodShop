<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                overflow: visible;
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
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
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

            .blog-image-wrapper {
                position: relative;
                width: 100%;
                height: 400px;
            }

            .blog-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }

            .image-placeholder {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: #f2f2f2;
                border: 2px dashed #ccc;
                color: #666;
                display: none;
                align-items: center;
                justify-content: center;
                font-size: 16px;
                text-align: center;
                padding: 20px;
                box-sizing: border-box;
                cursor: not-allowed;
                transition: border-color 0.3s;
            }

            .image-placeholder:hover {
                border-color: #999;
            }


            .blog-content {
                padding: 30px;
                max-height: 1200px;
                overflow: hidden;
                position: relative;
                transition: max-height 0.3s ease;
            }

            .blog-content::after {
                content: "";
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 60px;
                background: linear-gradient(to bottom, rgba(255,255,255,0), white);
                pointer-events: none;
            }

            .blog-content.expanded {
                max-height: none;
            }

            .blog-content.expanded::after {
                display: none;
            }

            .blog-content.collapsed {
                max-height: 500px;
                overflow: hidden;
                position: relative;
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
                position: sticky;
                top: 130px;
                z-index: 10;
                /* Thêm khả năng cuộn khi nội dung quá cao */
                max-height: calc(100vh - 150px);
                overflow-y: auto;
                overflow-x: hidden;
                scroll-behavior: smooth;
                /* Custom scrollbar */
                scrollbar-width: thin;
                scrollbar-color: rgba(0,0,0,0.2) transparent;
            }

            /* Custom scrollbar cho webkit browsers */
            .sidebar-right::-webkit-scrollbar {
                width: 6px;
            }
            .sidebar-right::-webkit-scrollbar-track {
                background: transparent;
                border-radius: 10px;
            }
            .sidebar-right::-webkit-scrollbar-thumb {
                background: rgba(0,0,0,0.2);
                border-radius: 10px;
                transition: background 0.3s ease;
            }
            .sidebar-right::-webkit-scrollbar-thumb:hover {
                background: rgba(0,0,0,0.4);
            }

            .sidebar-right-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #667eea;
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
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
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
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
                color: white;
            }

            #toggleContentBtn:hover {
                background: linear-gradient(135deg, var(--primary-green), #3b82f6) !important;
                padding: 10px !important;
                border-radius: 10px !important;
                color: white !important;
            }

            #status-meta i {
                font-size: 12px;
            }

            #status-meta span {
                color: white;
                padding: 4px 8px;
                border-radius: 18px;
                font-size: 12px;
                font-weight: 500;
            }

            /* Private - Đỏ */
            #status-meta span[data-status="Private"] {
                background-color: #dc3545;
            }

            #status-meta span[data-status="Private"] + i,
            #status-meta:has(span[data-status="Private"]) i {
                color: #dc3545;
            }

            /* Public - Xanh lá */
            #status-meta span[data-status="Public"] {
                background-color: #28a745;
            }

            #status-meta span[data-status="Public"] + i,
            #status-meta:has(span[data-status="Public"]) i {
                color: #28a745;
            }

            /* Draft - Vàng */
            #status-meta span[data-status="Draft"] {
                background-color: #ffc107;
            }

            #status-meta span[data-status="Draft"] + i,
            #status-meta:has(span[data-status="Draft"]) i {
                color: #ffc107;
            }

            #bmi-info-section {
                background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
                border: 1px solid #dee2e6;
                border-radius: 12px;
                padding: 24px;
                margin-top: 20px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
            }

            #bmi-info-section:hover {
                box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
                transform: translateY(-2px);
            }

            #bmi-info-section .sidebar-right-title {
                color: #2c3e50;
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 20px;
                padding-bottom: 12px;
                border-bottom: 2px solid #3498db;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            #bmi-info-section .sidebar-right-title i {
                color: #3498db;
                font-size: 20px;
            }

            #bmi-info-section .list-unstyled {
                margin-bottom: 0;
            }

            #bmi-info-section .list-unstyled li {
                padding: 12px 0;
                border-bottom: 1px solid rgba(222, 226, 230, 0.5);
                display: flex;
                align-items: flex-start;
                line-height: 1.6;
            }

            #bmi-info-section .list-unstyled li:last-child {
                border-bottom: none;
                padding-bottom: 0;
            }

            #bmi-info-section .list-unstyled li strong {
                color: #495057;
                font-weight: 600;
                min-width: 140px;
                flex-shrink: 0;
                font-size: 14px;
            }

            #bmi-info-section .list-unstyled li:not(:has(strong)) {
                color: #6c757d;
                font-size: 14px;
                margin-left: 140px;
                padding-left: 0;
            }

            /* Animation cho icon */
            @keyframes pulse {
                0% {
                    transform: scale(1);
                }
                50% {
                    transform: scale(1.05);
                }
                100% {
                    transform: scale(1);
                }
            }

            #bmi-info-section .sidebar-right-title i:hover {
                animation: pulse 0.6s ease-in-out;
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

                #bmi-info-section {
                    padding: 16px;
                    margin-top: 16px;
                }

                #bmi-info-section .sidebar-right-title {
                    font-size: 16px;
                }

                #bmi-info-section .list-unstyled li {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 4px;
                }

                #bmi-info-section .list-unstyled li strong {
                    min-width: auto;
                }

                #bmi-info-section .list-unstyled li:not(:has(strong)) {
                    margin-left: 0;
                }
            }

            @media (max-width: 991px) {
                .sidebar-right {
                    position: static !important;
                    top: auto !important;
                    margin-top: 30px;
                    max-height: none !important;
                    overflow-y: visible !important;
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
                    <h1 class="page-title" style="padding-left: 32px">Blog Posts</h1>
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
                                            <div class="blog-tags">
                                                <div class="tag">${bmi.classification}</div>
                                            </div>
                                            <div class="meta-item" id="status-meta"> 
                                                <i class="fas fa-circle"></i>
                                                <span data-status="${blog.status}">${blog.status}</span>
                                            </div>
                                            <!--                            <div class="meta-item">
                                                                                <i class="fas fa-eye"></i>
                                                                            <span>1.2M lượt xem</span>
                                                                        </div>-->
                                            <!--                                    <div class="meta-item">
                                                                                    <i class="fas fa-comment"></i>
                                                                                    <span>06 bình luận</span>
                                                                                </div>-->
                                        </div>                       

                                    </div>

                                    <!-- Featured Image -->
                                    <div class="blog-image-wrapper">
                                        <img 
                                            src="${blog.imageUlr}" 
                                            alt="Blog Image" 
                                            class="blog-image" 
                                            onerror="handleImageError(this)">
                                        <div class="image-placeholder">Không thể tải ảnh</div>
                                    </div>

                                    <!-- Blog Content -->
                                    <div class="blog-content collapsed" id="blogContent">
                                        ${blog.content}
                                    </div>
                                    <div class="text-center mt-3">
                                        <button id="toggleContentBtn" class="btn btn-outline-primary" style="display: none">Xem thêm</button>
                                    </div>

                                </article>
                            </div>

                            <!-- Sidebar -->
                            <div class="col-lg-4">
                                <aside class="sidebar-right">
                                    <!-- Popular Posts -->
                                    <c:choose>
                                        <c:when test="${empty relblog}">
                                            <div class="popular-posts" style="height: 400px; background: #f8f9fa; border: 1px solid #e9ecef; border-radius: 8px; padding: 20px;">
                                                <div style="display: flex; align-items: center; margin-bottom: 15px;">
                                                    <span style="background: #6c757d; color: white; border-radius: 50%; width: 24px; height: 24px; display: flex; align-items: center; justify-content: center; margin-right: 10px; font-size: 14px; font-weight: bold;">📝</span>
                                                    <h3 class="sidebar-right-title">Bài viết liên quan</h3>
                                                </div>
                                                <div style="display: flex; align-items: center; justify-content: center; height: calc(100% - 60px); color: #6c757d; font-size: 16px;">
                                                    Không có bài viết liên quan nào
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="popular-posts">
                                                <h3 class="sidebar-right-title">Bài viết liên quan</h3>
                                                <c:forEach var="post" items="${relblog}" varStatus="loop">
                                                    <div class="popular-post">
                                                        <img src="${post.imageUlr}" alt="Popular Post">
                                                        <div class="popular-post-content">
                                                            <h6><a href="nutricontrol?action=showdetail&id=${post.bID}">${post.title}</a></h6>
                                                            <div class="post-time" data-created="${post.update_at}"></div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- BMI ìnomation -->
                                    <div id="bmi-info-section" class="bmi-detail mt-4 p-3 rounded bg-light border">
                                        <h3 class="sidebar-right-title">
                                            <i class="fas fa-info-circle"></i> 
                                            Thông tin BMI
                                        </h3>
                                        <ul class="list-unstyled mb-0">
                                            <li><strong>Phân loại:</strong> ${bmi.classification}</li>
                                            <li><strong>Rank:</strong> 
                                                <fmt:formatNumber value="${bmi.min_bmi}" type="number" maxFractionDigits="1"/> –
                                                <fmt:formatNumber value="${bmi.max_bmi}" type="number" maxFractionDigits="1"/>
                                            </li>
                                            <li><strong>Mô tả:</strong> ${bmi.decription}</li>
                                            <li><strong>Đối tượng phù hợp:</strong> ${bmi.tagetAudience}</li>
                                        </ul>
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
                    document.addEventListener('DOMContentLoaded', function () {
                        const content = document.getElementById('blogContent');
                        const button = document.getElementById('toggleContentBtn');

                        // Chỉ hiển thị nút nếu nội dung vượt quá 500px
                        if (content.scrollHeight > 500) {
                            button.style.display = 'inline-block'; // hoặc 'block' tùy thiết kế
                        }

                        button.addEventListener('click', function () {
                            content.classList.toggle('expanded');
                            content.classList.toggle('collapsed');
                            this.textContent = content.classList.contains('expanded') ? 'Thu gọn' : 'Xem thêm';
                        });
                    });
                    function handleImageError(imgElement) {
                        imgElement.style.display = "none";
                        const placeholder = imgElement.nextElementSibling;
                        if (placeholder && placeholder.classList.contains("image-placeholder")) {
                            placeholder.style.display = "flex";
                        }
                    }
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
