<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/fooddetail.css">

        <style>
            :root {
                --primary-color: #28a745;
                --secondary-color: #6c757d;
                --success-color: #20c997;
                --warning-color: #ffc107;
                --danger-color: #dc3545;
            }

    

            .breadcrumb-container {
                background: white;
                padding: 15px 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .breadcrumb-nav {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .breadcrumb-item {
                color: var(--secondary-color);
                text-decoration: none;
                font-size: 14px;
            }

            .breadcrumb-item:hover {
                color: var(--primary-color);
            }

            .breadcrumb-item.active {
                color: var(--primary-color);
                font-weight: 500;
            }

            .breadcrumb-separator {
                color: var(--secondary-color);
            }

            .product-card {
                margin: 20px;
                padding: 10px;
                background: white;
                border-radius: 12px;
                box-shadow: 0 8px 25px rgba(0,0,0,0.15),
                            0 8px 25px rgba(0,0,0,0.15),
                            0 8px 25px rgba(0,0,0,0.15);
                overflow: hidden;
                position: relative;
                z-index: 10;
                transform: translateY(-5px);
                transition: all 0.3s ease;
            }

            .product-image {
                background: #f8f9fa;
                padding: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .product-image img {
                max-height: 100%;
                max-width: 100%;
                
                object-fit: contain;
                border-radius: 8px;
            }

            .product-info {
                padding: 30px;
            }

            .product-title {
                font-size: 30px;
                font-weight: bold;
                color: #1a1a1a;
                margin-bottom: 12px;
                border-bottom: 2px solid #ddd;
                margin-top: 30px;
                text-align: center;
                ;
            }

            .product-price {
                font-size: 28px;
                font-weight: 700;
                color: orange;
                margin-bottom: 15px;
            }

            .product-meta {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 15px;
                margin-bottom: 20px;
                padding: 20px;
                background: #f8f9fa;
                border-radius: 8px; 
               
            }
            .product-full {
                border: 2px solid #e0e0e0;     
                padding: 16px;
                border-radius: 12px;
                background-color: #ffffff;     
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05); 
                transition: all 0.3s ease;
            }

            .meta-item {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 10px;
                background: white;
                border-radius: 6px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
                transition: all 0.3s ease;
            }

            .meta-label {
                font-size: 11px;
                color: var(--secondary-color);
                text-transform: uppercase;
                font-weight: 600;
                min-width: 60px;
                display: flex;
                align-items: center;
                gap: 4px;
            }

            .meta-value {
                font-size: 14px;
                color: #333;
                font-weight: 500;
                flex: 1;
            }

            .meta-row {
                display: contents;
            }

            .status-badge {
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
            }

            .status-active {
                background-color: #d4edda;
                color: #155724;
            }

            .status-inactive {
                background-color: #f8d7da;
                color: #721c24;
            }

            .product-tabs {
                margin-top: 30px;
            }

            .nav-tabs {
                border-bottom: 2px solid #e9ecef;
            }

            .nav-tabs .nav-link {
                border: none;
                color: var(--secondary-color);
                font-weight: 500;
                padding: 15px 20px;
                margin-right: 10px;
                border-radius: 8px 8px 0 0;
                background: transparent;
            }

            .nav-tabs .nav-link.active {
                color: var(--primary-color);
                background-color: white;
                border-bottom: 2px solid var(--primary-color);
                margin-bottom: -2px;
            }

            .tab-content {
                background: white;
                padding: 30px;
                border-radius: 0 0 8px 8px;
            }

            .nutrition-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-top: 20px;
            }

            .nutrition-item {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                text-align: center;
                border: 1px solid #e9ecef;
            }

            .nutrition-value {
                font-size: 24px;
                font-weight: 700;
                color: var(--primary-color);
            }

            .nutrition-label {
                font-size: 14px;
                color: var(--secondary-color);
                margin-top: 5px;
            }

            .action-buttons {
                display: flex;
                gap: 15px;
                margin-top: 30px;
            }

            .btn-custom {
                padding: 12px 24px;
                border-radius: 8px;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
                border: none;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-edit {
                background-color: var(--warning-color);
                color: #212529;
            }

            .btn-edit:hover {
                background-color: #e0a800;
                transform: translateY(-2px);
            }
            .btn-back {
                background-color: var(--secondary-color);
                color: white;
            }

            .btn-back:hover {
                background-color: #5a6268;
                transform: translateY(-2px);
            }

            .back-button-container {
                text-align: center;
                margin-top: 30px;
            }

            .spec-table {
                width: 100%;
                border-collapse: collapse;
            }

            .spec-table tr {
                border-bottom: 1px solid #e9ecef;
            }

            .spec-table td {
                padding: 15px 0;
                vertical-align: top;
            }

            .spec-table td:first-child {
                font-weight: 500;
                color: var(--secondary-color);
                width: 150px;
            }

            .review-section {
                text-align: center;
                padding: 40px 0;
            }

            .review-section .fa-star {
                color: #ffc107;
                font-size: 20px;
                margin: 0 2px;
            }

            /* Fixed CSS for collapsed text */
            .collapsed-text {
                max-height: 100px;
                overflow: hidden;
                transition: max-height 0.3s ease;
                position: relative;
            }

            .collapsed-text.expanded {
                max-height: none;
            }

            .meta-label {
                font-weight: bold;
                margin-right: 8px;
                font-size: 15px;
            }

            .status-badge {
                display: inline-block;
                padding: 2px 8px;
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
                color: white;
                border-radius: 15px;
                font-size: 0.85rem;
            }

            #toggleDescBtn {
                color: #007bff;
                cursor: pointer;
                font-size: 0.9rem;
                background: none;
                border: none;
                padding: 0;
                margin-top: 10px;
            }

            #toggleDescBtn:hover {
                text-decoration: underline;
            }

            .sub-tag {
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
                display: inline-block;
                padding: 4px 12px;
                margin: 2px 4px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 500;
                border: 1px solid transparent;
            }

            .tag-description-section  {
                margin-top: 20px;
                padding: 20px;
                background: #f8f9fa;
                border-radius: 8px;
               
            }

            .section-title {
                color: var(--primary-color);
                font-size: 16px;
                font-weight: 600;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .tag-desc-item {
                margin-bottom: 12px;
                padding: 12px;
                background: white;
                border-radius: 6px;
                border-left: 3px solid background: linear-gradient(135deg, var(--primary-green), #3b82f6);;
            }

            .tag-name {
                color:#3b82f6);;
                font-weight: 600;
            }

            .tag-desc {
                color: #555;
                line-height: 1.5;
            }

            .no-desc {
                color: var(--secondary-color);
                font-style: italic;
                text-align: center;
                padding: 20px;
            }

            #toggleDescBtn {
                color: var(--primary-color);
                cursor: pointer;
                font-size: 0.9rem;
                background: none;
                border: none;
                padding: 8px 16px;
                margin-top: 10px;
                border-radius: 20px;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            #toggleDescBtn:hover {
                background-color: var(--primary-color);
                color: white;
                transform: translateY(-1px);
            }

            #toggleDescBtn i {
                transition: transform 0.3s ease;
            }

            .collapsed-text.expanded + #toggleDescBtn i {
                transform: rotate(180deg);
            }

            @media (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding: 15px;
                }

                .product-info {
                    padding: 20px;
                }

                .product-meta {
                    flex-direction: column;
                    gap: 15px;
                }

                .action-buttons {
                    flex-direction: column;
                }

                .nutrition-grid {
                    grid-template-columns: repeat(2, 1fr);
                    gap: 15px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <jsp:include page="/Nutritionist/nav.jsp"/>  
        <!-- Main Header -->
        <jsp:include page="/Nutritionist/main-header.jsp"/>  

        <main class="main-content" id="mainContent">
            <div class="container-fluid">

                <div class="breadcrumb-container mb-4">
                    <nav class="breadcrumb-nav">
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Trang chủ</a>
                        <span class="breadcrumb-separator">/</span>
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=showfood" class="breadcrumb-item">Danh sách thực phẩm</a>
                        <span class="breadcrumb-separator">/</span>
                        <span class="breadcrumb-item active">Chi tiết sản phẩm</span>
                    </nav>
                </div>

                <div class="product-card">
                    <div class="row g-0">
                      
                        <div class="col-lg-5 d-flex justify-content-center align-items-center">
                            <div class="product-image">
                                <c:choose>
                                    <c:when test="${not empty food.image}">
                                        <img src="${pageContext.request.contextPath}/img/logo/logo.png" alt="fad" id="productImage">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/img/logo/logo.png" alt="Không có hình ảnh" id="productImage">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="col-lg-7">
                            <div class="product-info">
                                <!-- Title -->
                                <h1 class="product-title" id="productName">
                                    ${food.foodname}
                                </h1>
                                <div class="product-full">
                                    <div class="product-price-box" style="margin-left: 30px; display: flex; align-items: center; padding: 10px; background-color: #fdf2f2;border-radius: 8px;">
                                        <div class="price-label" style="font-weight: bold; color: #555; font-size: 25px;">
                                            <i class="bi bi-currency-dollar" style="margin-right: 5px;"></i>Giá:
                                        </div>
                                        <div class="price-value" id="productPrice" style="color: #d9534f; font-size: 24px; font-weight: bold; margin-left: 10px;">
                                            ${food.price}vnđ
                                        </div>
                                    </div>


                                    <div class="product-meta">
                                        <!-- ID và Trạng thái -->
                                        <div class="meta-item">
                                            <span class="meta-label">
                                            <i class="fas fa-id-card"></i> ID
                                        </span>
                                        <span class="meta-value" id="productSku">${food.foodId}</span>
                                    </div>
                                    
                                    <div class="meta-item">
                                        <span class="meta-label">
                                            <i class="fas fa-toggle-on"></i> Trạng thái
                                        </span>
                                        <span class="status-badge status-active" id="productStatus">${food.status}</span>
                                    </div>
                                 
                                    <!-- Danh mục -->
                                    <div class="meta-item">
                                        <span class="meta-label">
                                            <i class="fas fa-tags"></i> Danh mục
                                        </span>
                                        <span class="meta-value" id="productCategory">${food.category}</span>
                                    </div>
                                    <div class="meta-item">
                                        <span class="meta-label">
                                            <i class="fas fa-calendar"></i> Ngày tạo
                                        </span>
                                        <span class="meta-value">
                                            <fmt:formatDate value="${food.create_at}" pattern="dd/MM/yyyy" />
                                        </span>
                                    </div>

                                    <!-- Tags -->
                                    <div class="meta-item" style="grid-column: 1 / -1;">
                                        <span class="meta-label">
                                            <i class="fas fa-bookmark"></i> Tags
                                        </span>
                                        <div class="meta-value" id="productTags">
                                            <c:choose>
                                                <c:when test="${not empty tagetaudience}">
                                                    <c:forEach var="ta" items="${tagetaudience}">
                                                        <span class="sub-tag" style="background-color: green; color: white">
                                                            ${ta.classification}
                                                        </span>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="sub-tag" style="background-color: gray; color: white">
                                                        Không có thông tin BMI phù hợp
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>

                                <!-- Tag Description Section -->
                                <div class="tag-description-section">
                                    <h6 class="section-title">
                                        <i class="fas fa-info-circle"></i> Mô tả chi tiết Tags
                                    </h6>
                                    <div class="collapsed-text" id="tagDescription">
                                        <c:choose>
                                            <c:when test="${not empty tagetaudience}">
                                                <c:forEach var="ta" items="${tagetaudience}" varStatus="status">
                                                    <div class="tag-desc-item">
                                                        <strong class="tag-name">${ta.decription}:</strong> 
                                                        <span class="tag-desc">
                                                            <c:choose>
                                                                <c:when test="${not empty ta.tagetAudience}">
                                                                    ${ta.tagetAudience}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Không có mô tả
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <p class="no-desc">Không có mô tả cho tag BMI.</p>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <button id="toggleDescBtn" onclick="toggleDescription()">
                                        <i class="fas fa-chevron-down"></i> Xem thêm
                                    </button>
                                </div>
                                </div>
                                <div class="action-buttons mt-3">
                                    <a href="nutricontrol?action=copyfood&id=${food.foodId}" class="btn-custom btn-edit" id="editBtn">
                                        <i class="fas fa-edit"></i> Tạo bản sao
                                    </a>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="product-tabs" style="margin-left: 30px">
                        <ul class="nav nav-tabs" id="productTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button" role="tab">
                                    Mô tả
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="specification-tab" data-bs-toggle="tab" data-bs-target="#specification" type="button" role="tab">
                                    Thông tin thành phần chi tiết
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="review-tab" data-bs-toggle="tab" data-bs-target="#review" type="button" role="tab">
                                    Đánh giá
                                </button>
                            </li>
                        </ul>

                        <div class="tab-content" id="productTabContent">
                            <div class="tab-pane fade show active" id="description" role="tabpanel">
                                <c:choose>
                                    <c:when test="${not empty fooddetail.description}">
                                        ${fooddetail.description}
                                    </c:when>
                                    <c:otherwise>
                                        <p>Chưa có mô tả chi tiết cho sản phẩm này.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="tab-pane fade" id="specification" role="tabpanel">
                                <h6 class="mt-4 mb-3">Thành phần:</h6>
                                <c:choose>
                                    <c:when test="${not empty fooddetail.ingredients}">
                                        ${fooddetail.ingredients}
                                    </c:when>
                                    <c:otherwise>
                                        <p>Chưa có thông tin thành phần chi tiết.</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="tab-pane fade" id="review" role="tabpanel">
                                <div class="review-section">
                                    <h5 class="mb-3">Đánh giá sản phẩm</h5>
                                    <div class="mb-3">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <span class="ms-2">5.0 (12 đánh giá)</span>
                                    </div>
                                    <p class="text-muted">
                                        Chức năng đánh giá sẽ được cập nhật trong phiên bản tiếp theo.
                                        Khách hàng có thể để lại nhận xét và đánh giá về chất lượng sản phẩm.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="/Nutritionist/footer.jsp"/>  
        </main>

        <!-- Fixed JavaScript loading -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
            // Toggle description function
            function toggleDescription() {
                const descElement = document.getElementById('tagDescription');
                const toggleBtn = document.getElementById('toggleDescBtn');
                
                if (descElement.classList.contains('expanded')) {
                    descElement.classList.remove('expanded');
                    toggleBtn.innerHTML = '<i class="fas fa-chevron-down"></i> Xem thêm';
                } else {
                    descElement.classList.add('expanded');
                    toggleBtn.innerHTML = '<i class="fas fa-chevron-up"></i> Thu gọn';
                }
            }

            // Initialize page
            document.addEventListener('DOMContentLoaded', function() {
                console.log('Page loaded successfully');
                
                // Initialize Bootstrap tabs
                var triggerTabList = [].slice.call(document.querySelectorAll('#productTabs button'));
                triggerTabList.forEach(function (triggerEl) {
                    var tabTrigger = new bootstrap.Tab(triggerEl);
                });
            });
        </script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/common.js"></script>
    </body>
</html>
