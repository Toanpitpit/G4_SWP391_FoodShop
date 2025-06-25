
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/cssdung.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/foodlist.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">
        <style>
            .pagination-link{
                border-radius: 10px: 
                
            }
            .pagination a, .pagination span {
                padding: 8px 12px;
                border: 1px solid #ddd;
                text-decoration: none;
                color: #333;
            }

            .pagination a:hover {
                background:linear-gradient(135deg, var(--primary-green), #3b82f6) !important;
            }

            .pagination .current {
                background:linear-gradient(135deg, var(--primary-green), #3b82f6) !important;
                color: white;
                border-color: #4CAF50;
                border-radius: 10px;
            }
        </style>


    </head>
    <body>
        <!-- Sidebar -->
        <jsp:include page="/Nutritionist/nav.jsp"/>  
        <!-- Main Header -->
        <jsp:include page="/Nutritionist/main-header.jsp"/>  
          <c:if test="${not empty Errmess}">
            <div class="alert alert-danger" style="display: none;">${Errmess}</div>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success" style="display: none;">${successMessage}</div>
        </c:if>

        <c:if test="${not empty warningMessage}">
            <div class="alert alert-warning" style="display: none;">${warningMessage}</div>
        </c:if>

        <c:if test="${not empty infoMessage}">
            <div class="alert alert-info" style="display: none;">${infoMessage}</div>
        </c:if>
        <!-- Main Content -->
        <main class="main-content" id="mainContent">
            <div class="seller-content">
                <div class="page-header">
                    <h1 class="page-title">Danh sách món ăn</h1>
                    <ul class="breadcrumb">
                        <li><a href="nutricontrol?action=dashboard">Trang chủ</a></li>
                        <li><a href="nutricontrol?action=showfoodlist">Food</a></li>
                        <li>Danh sách đồ ăn</li>
                    </ul>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title"><i class="fas fa-list-ul"></i>Danh sách đồ ăn</h3>
                    </div>
                    <div class="card-body">

                        <form action="${pageContext.request.contextPath}/nutricontrol?action=displaysortfood" method="GET" id="filterForm">
                            <div class="filter-controls">
                                <div class="input-group" style="flex-grow: 1;">
                                    <i class="fas fa-search"></i>
                                    <input type="text" name="searchKey" placeholder="Tìm theo tên sản phẩm..." value="${param.searchKey}">
                                </div>
                                <div class="input-group" style="flex-grow: 1;">
                                    <i class="fas fa-search"></i>
                                    <input type="number" id="searchPrice" name="searchPrice" min="0" step="any" placeholder="Giới hạn giá cao nhất" value="${param.searchPrice}">
                                </div>
                                <div class="select-group">
                                    <select name="status">
                                        <option value="">Tất cả trạng thái</option>
                                        <option value="Active" ${param.status == 'Active' ? 'selected' : ''}>Active</option>
                                        <option value="Hine" ${param.status == 'Hine' ? 'selected' : ''}>Hine</option>
                                    </select>
                                </div>
                                <div class="select-group">
                                    <select name="bmiId" id="bmiId">
                                        <option value="">-- Chọn danh mục BMI --</option>
                                        <c:forEach var="bmi" items="${lstBMI}">
                                            <option value="${bmi.bmiID}" ${bmi.bmiID == param.bmiId ? 'selected' : ''}>${bmi.classification}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="select-group">
                                    <select name="category" id="category">
                                        <option value="">-- Loại món ăn --</option>
                                        <c:forEach var="c" items="${lstC}">
                                            <option value="${c.catID}" ${c.catID == param.category ? 'selected' : ''}>${c.caName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <button type="button" class="btn btn-outline" onclick="toggleAdvancedFilters()">
                                    <i class="fas fa-sliders-h"></i> Sort
                                </button>
                            </div>

                            <c:set var="isAdvancedFilterActive" value="${not empty param.priceRank or not empty param.sortID or not empty param.sortTime or not empty param.sortPrice}" />
                            <div class="advanced-filters-container" id="advancedFilters" style="${isAdvancedFilterActive ? 'display: block;' : 'display: none;'} margin-bottom: 15px;">
                                <div class="advanced-filters-grid">
                                    <div class="select-group">
                                        <select name="priceRank" id="priceRank">
                                            <option value="" ${empty param.priceRank ? 'selected' : ''}>-- Mức giá --</option>
                                            <option value="0-50000" ${param.priceRank == '0-50000' ? 'selected' : ''}>Dưới 50.000</option>
                                            <option value="50000-100000" ${param.priceRank == '50000-100000' ? 'selected' : ''}>Từ 50.000 - 100.000</option>
                                            <option value="100000-200000" ${param.priceRank == '100000-200000' ? 'selected' : ''}>Từ 100.000 - 200.000</option>
                                            <option value="200000+" ${param.priceRank == '200000+' ? 'selected' : ''}>Trên 200.000</option>         
                                        </select>
                                    </div>

                                    <div class="select-group">
                                        <select name="sortTime">
                                            <option value="">Thời gian cập nhật</option>
                                            <option value="asc" ${param.sortTime == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                            <option value="desc" ${param.sortTime == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                        </select>
                                    </div>

                                    <div class="select-group">
                                        <select name="sortID">
                                            <option value="">Sort by Id</option>
                                            <option value="asc" ${param.sortID == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                            <option value="desc" ${param.sortID == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                        </select>
                                    </div>

                                    <div class="select-group">
                                        <select name="sortPrice">
                                            <option value="">Sort by Price</option>
                                            <option value="asc" ${param.sortPrice == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                            <option value="desc" ${param.sortPrice == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="action" value="displaysortfood" />
                            <input type="hidden" name="page" id="pageInput" value="${param.page != null ? param.page : 1}" />
                            <div class="filter-actions">
                                <button type="button" class="btn btn-outline" onclick="location.href = '${pageContext.request.contextPath}/nutricontrol?action=showfood'">
                                    <i class="fas fa-times"></i> Xóa bộ lọc
                                </button>
                                <button type="submit" class="btn btn-primary" name="filterSubmit" value="true"><i class="fas fa-filter"></i> Lọc</button>
                            </div>
                        </form>

                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Ảnh</th>
                                        <th>Mã Food</th>
                                        <th>Tên Món Ăn</th>  
                                        <th>Category</th>
                                        <th>Giá</th>
                                        <th>Trạng Thái</th>
                                        <th>Cập Nhật Gần Nhất</th>
                                        <th style="width: 5%;">Thao Tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${lstFood}" var="food">
                                        <tr>
                                            <td>
                                                <img src="${food.image}" alt="anh food" class="table-avatar"/>
                                            </td>
                                            <td><strong>#${food.foodId}</strong></td>
                                            <td>${food.foodname}</td>
                                            <td>${food.category}</td>
                                            <td>
                                                <span class="price-value">
                                                    <fmt:formatNumber value="${food.price}" type="number" groupingUsed="true" /> <small>₫</small>

                                                </span>
                                            </td>
                                            <td>
                                                <span class="status-badge status-active">${food.status}</span> 
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${food.update_at}" pattern="dd/MM/yyyy HH:mm:ss" />
                                            </td>
                                            <td>
                                                <div class="table-actions">
                                                    <a class="action-btn view-btn" title="Xem chi tiết" href="nutricontrol?action=showfooddetail&id=${food.foodId}">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a class="action-btn edit-btn" title="Tạo Bản sao" href="nutricontrol?action=copyfood&id=${food.foodId}">
                                                        <i class="fas fa-clone"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty lstFood}">
                                        <tr>
                                            <td colspan="8" style="text-align: center; padding: 30px;">
                                                Không tìm thấy món ăn nào phù hợp.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                            <div  id="paginationWrapper" class="pagination-container" style="display: flex; justify-content: space-between; padding: 10px;">
                                <div style="padding: 10px">Show ${lstFood.size()} of ${totalFood} items</div>
                                <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
                                <c:if test="${totalPages >= 1}">
                                    <div class="pagination">
                                        <c:if test="${currentPage > 1}">
                                            <a href="#" class="prev pagination-link" data-page="${currentPage - 1}">&laquo; Previous</a>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${totalPages}" varStatus="status">
                                            <c:choose>
                                                <c:when test="${i == currentPage}">
                                                    <span class="current">${i}</span>
                                                </c:when>
                                                <c:when test="${i <= currentPage + 2 && i >= currentPage - 2}">
                                                    <a href="#" class="pagination-link" data-page="${i}">${i}</a>
                                                </c:when>
                                                <c:when test="${i == currentPage - 3 || i == currentPage + 3}">
                                                    <span class="ellipsis">...</span>
                                                </c:when>
                                            </c:choose>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <a href="#" class="next pagination-link" data-page="${currentPage + 1}">Next &raquo;</a>
                                        </c:if>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="/Nutritionist/footer.jsp"/>  
        </main>
        <script src="../JS/Nutritionist/common.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<!--        <script src="${pageContext.request.contextPath}/JS/Nutritionist/common.js"></script>-->
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
        </script>

    </body>
</html>




