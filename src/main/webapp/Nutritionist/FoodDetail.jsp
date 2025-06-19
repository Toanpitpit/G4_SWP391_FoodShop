
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
            .breadcrumb-section {
                background: white;
                padding: 20px 24px;
                border-bottom: 1px solid #e2e8f0;
            }

            .breadcrumb-container {
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .page-title {
                font-size: 24px;
                font-weight: 700;
                color: #1e293b;
                margin: 0;
            }

            .breadcrumb-nav {
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 14px;
            }

            .breadcrumb-item {
                color: #64748b;
                text-decoration: none;
                transition: color 0.2s ease;
            }

            .breadcrumb-item:hover {
                color: var(--primary-blue);
            }

            .breadcrumb-item.active {
                color: #1e293b;
                font-weight: 500;
            }

            .breadcrumb-separator {
                color: #cbd5e1;
                font-size: 12px;
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
            <div class="container py-4">
                <!-- Breadcrumb -->
                <div class="breadcrumb-container mb-3">
                    <nav class="breadcrumb-nav">
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Trang chủ</a>
                        <span class="breadcrumb-separator">/</span>
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=showfoodlist" class="breadcrumb-item">Danh sách thực phẩm</a>
                        <span class="breadcrumb-separator">/</span>
                        <span class="breadcrumb-item active">Chi tiết sản phẩm</span>
                    </nav>
                </div>

                <!-- Detail Card -->
                <div class="card shadow-sm rounded-3">
                    <div class="row g-0">
                        <!-- Image -->
                        <div class="col-md-4 text-center p-3">
                            <img src="${food.image}" alt="${food.name}" class="img-fluid rounded" style="max-height: 250px; object-fit: contain;">
                        </div>

                        <!-- Info -->
                        <div class="col-md-8">
                            <div class="card-body">
                                <h2 class="card-title">${food.name}</h2>
                                <p class="card-text"><strong>Giá:</strong> <fmt:formatNumber value="${food.price}" type="currency" currencySymbol="₫"/></p>
                                <p class="card-text"><strong>Loại:</strong> ${food.category.name}</p>
                                <p class="card-text"><strong>Trạng thái:</strong>
                                    <span class="badge ${food.status == 'Active' ? 'bg-success' : 'bg-danger'}">
                                        ${food.status}
                                    </span>
                                </p>
                                <p class="card-text"><strong>Mô tả:</strong> ${food.description}</p>

                                <!-- Nutritional Info -->
                                <div class="mt-3">
                                    <h5>Thông tin dinh dưỡng (trên 100g):</h5>
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item">Calories: ${food.calories} kcal</li>
                                        <li class="list-group-item">Protein: ${food.protein} g</li>
                                        <li class="list-group-item">Fat: ${food.fat} g</li>
                                        <li class="list-group-item">Carbs: ${food.carbs} g</li>
                                    </ul>
                                </div>

                                <!-- Actions -->
                                <div class="mt-4">
                                    <a href="nutricontrol?action=editfood&id=${food.id}" class="btn btn-warning me-2">
                                        <i class="fas fa-edit"></i> Chỉnh sửa
                                    </a>
                                    <a href="nutricontrol?action=deletefood&id=${food.id}" class="btn btn-danger"
                                       onclick="return confirm('Bạn có chắc chắn muốn xoá sản phẩm này không?')">
                                        <i class="fas fa-trash-alt"></i> Xoá
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Back Button -->
            <div class="text-center mt-4">
                <a href="nutricontrol?action=showfoodlist" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Quay lại danh sách
                </a>
            </div>
        </main>




        <script src="../JS/Nutritionist/common.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js"></script>
        <script>
                                           function toggleAdvancedFilters() {
                                               const advancedFilters = document.getElementById('advancedFilters');
                                               if (window.getComputedStyle(advancedFilters).display === 'none') {
                                                   advancedFilters.style.display = 'block';
                                               } else {
                                                   advancedFilters.style.display = 'none';
                                               }
                                           }
                                           const input = document.getElementById("searchPrice");
                                           const select = document.getElementById("priceRank");

                                           select.addEventListener("change", function () {
                                               if (select.value !== "") {
                                                   input.value = "";
                                                   input.disabled = true;
                                               } else {
                                                   input.disabled = false;
                                               }
                                           });

                                           input.addEventListener("input", function () {
                                               if (input.value !== "") {
                                                   select.value = "";
                                                   select.disabled = true;
                                               } else {
                                                   select.disabled = false;
                                               }
                                           });
                                           input.addEventListener('input', function () {
                                               if (parseFloat(input.value) < 0) {
                                                   showAlert("Khôg được nhập giá trị âm", 'danger', 100000);
                                                   input.value = 0;
                                               }
                                           });


                                           input.addEventListener('keydown', function (e) {
                                               if (e.key === 'ArrowUp') {
                                                   e.preventDefault();
                                                   input.value = parseInt(input.value || 0) + 10000;
                                               } else if (e.key === 'ArrowDown') {
                                                   e.preventDefault();
                                                   let newVal = parseInt(input.value || 0) - 10000;

                                               }
                                           });
                                           document.querySelectorAll('.pagination-link').forEach(link => {
                                               link.addEventListener('click', function (e) {
                                                   e.preventDefault();
                                                   const selectedPage = this.dataset.page;
                                                   document.getElementById('pageInput').value = selectedPage;
                                                   document.getElementById('filterForm').submit();
                                               });
                                           });
                                           function showTab(tabId) {
                                               const tabs = document.querySelectorAll(".tab-pane");
                                               const buttons = document.querySelectorAll(".custom-tab");

                                               tabs.forEach(tab => tab.classList.remove("active"));
                                               buttons.forEach(btn => btn.classList.remove("active"));

                                               document.getElementById(tabId).classList.add("active");
                                               document.querySelector(`[onclick="showTab('${tabId}')"]`).classList.add("active");
                                           }

// Optional: Set default tab on page load
                                           window.addEventListener("DOMContentLoaded", () => {
                                               showTab("ingredients");
                                           });

        </script>

    </body>
</html>




