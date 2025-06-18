
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

            .main-content {
                margin-left: 250px;
                padding: 20px;
                background-color: #f8f9fa;
                min-height: 100vh;
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
                background: white;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .product-image {
                background: #f8f9fa;
                padding: 10px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .product-image img {
                max-width: 100%;
                max-height: 400px;
                object-fit: contain;
                border-radius: 8px;
            }

            .product-info {
                padding: 30px;
            }

            .product-title {
                font-size: 24px;
                font-weight: 600;
                color: #333;
                margin-bottom: 20px;
            }

            .product-price {
                font-size: 28px;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 15px;
            }

            .product-meta {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                margin-bottom: 20px;
            }

            .meta-item {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .meta-label {
                font-size: 12px;
                color: var(--secondary-color);
                text-transform: uppercase;
                font-weight: 500;
            }

            .meta-value {
                font-size: 14px;
                color: #333;
                font-weight: 500;
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

            .nav-tabs .nav-link:hover {
                color: var(--primary-color);
                background-color: #f8f9fa;
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

            .btn-delete {
                background-color: var(--danger-color);
                color: white;
            }

            .btn-delete:hover {
                background-color: #c82333;
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
        <style>
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
            }

            .status-badge {
                display: inline-block;
                padding: 2px 8px;
                background-color: #28a745;
                color: white;
                border-radius: 8px;
                font-size: 0.85rem;
            }

            #toggleDescBtn {
                color: #007bff;
                cursor: pointer;
                font-size: 0.9rem;
            }

            #toggleDescBtn:hover {
                text-decoration: underline;
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
                <!-- Breadcrumb -->
                <div class="breadcrumb-container mb-4">
                    <nav class="breadcrumb-nav">
                        <a href="${pageContext.request.contextPath}/nutricotrol?action=dashboard" class="breadcrumb-item">Trang chủ</a>
                        <span class="breadcrumb-separator">/</span>
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=showfood" class="breadcrumb-item">Danh sách thực phẩm</a>
                        <span class="breadcrumb-separator">/</span>
                        <span class="breadcrumb-item active">Chi tiết sản phẩm</span>
                    </nav>
                </div>

                <div class="product-card">
                    <div class="row g-0">
                        <!-- Product Image -->
                        <div class="col-lg-5">
                            <div class="product-image">
                                <img src="${pageContext.request.contextPath}/${food.image}" alt="" id="productImage">
                            </div>
                        </div>

                        <div class="col-lg-7">
                            <div class="product-info">
                                <!-- Title -->
                                <h1 class="product-title" id="productName">
                                    ${food.name}
                                </h1>
                                <div class="product-price" id="productPrice"> $ ${food.price}</div>
                                <div class="product-meta" style="display: flex; flex-direction: column; justify-content: left; gap: 5px;">
                                    <div class="meta-row" style="display: flex; align-items: center; gap: 20px; flex-wrap: wrap;">
                                        <div class="meta-item">
                                            <span class="meta-label">ID</span>
                                            <span class="meta-value" id="productSku"> <i class="fas fa-id"></i>$food.id}</span>
                                        </div>
                                        <div class="meta-item">
                                            <span class="meta-label">Trạng thái</span>
                                            <span class="status-badge status-active" id="productStatus">${food.status}</span>
                                        </div> 
                                    </div>
                                    <div class="meta-item">
                                        <span class="meta-label">Danh mục</span>
                                        <i class="fas fa-calendar"></i>
                                                <span><fmt:formatDate
                                                        value="${food.create_at}"
                                                        pattern="yyyy-MM-dd HH:mm:ss" />
                                                </span>
                                    </div>    
                                    <div class="meta-item">
                                        <span class="meta-label">Danh mục</span>
                                        <span class="meta-value" id="productCategory">${food.caName}</span>
                                    </div>
                                    <div class="meta-item">
                                        <span class="meta-label">Tags</span>
                                        <span class="meta-value" id="productTags">
                                            <c:forEach var="re" items="${recommendation}">
                                                <span class="sub-tag">
                                                   ${re}
                                                </span>
                                            </c:forEach>
                                        </span>
                                    </div>
                                    <div class="meta-item">
                                        <span class="meta-label">Mô tả tag</span>
                                        <div id="tagDescriptions" class="collapsed-text">
                                            <c:forEach var="tag_info" items="${subdetailforBMI}">
                                                ${tag_info}
                                            </c:forEach>
                                        </div>
                                        <a href="javascript:void(0);" id="toggleDescBtn" class = "bmi-taget-info" onclick="toggleTagDesc()>Hiển thị thêm</a>
                                    </div>
                                </div>
                                <div class="action-buttons mt-3">
                                    <a href="nutricontol?action=copyfood" class="btn-custom btn-edit" id="editBtn">
                                        <i class="fas fa-edit"></i> Tạo bản sao
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Product Tabs -->
                    <div class="product-tabs" style="margin-left: 30px">
                        <ul class="nav nav-tabs" id="productTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="description-tab" data-bs-toggle="tab" data-bs-target="#description" type="button" role="tab">
                                    Mô tả
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="specification-tab" data-bs-toggle="tab" data-bs-target="#specification" type="button" role="tab">
                                    Thông số kỹ thuật
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
                               ${detailfood.decription}
                            </div>
                            <div class="tab-pane fade" id="specification" role="tabpanel">
                                <h6 class="mt-4 mb-3">Thông tin chi tiết:</h6>
                                ${fooddetail.ingeraction}
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
        </main>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
                                            function toggleTagDesc() {
                                                const desc = document.getElementById("tagDescriptions");
                                                const btn = document.getElementById("toggleDescBtn");

                                                if (desc.classList.contains("expanded")) {
                                                    desc.classList.remove("expanded");
                                                    btn.innerText = "Hiển thị thêm";
                                                } else {
                                                    desc.classList.add("expanded");
                                                    btn.innerText = "Thu gọn";
                                                }
                                            }
        </script>
        <script src="../JS/Nutritionist/common.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
    </body>
</html>




