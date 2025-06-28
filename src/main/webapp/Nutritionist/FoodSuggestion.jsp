
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

        .popup-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(4px);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .popup-overlay.show {
            display: flex;
            opacity: 1;
        }

        /* Popup Container */
        .popup-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            max-width: 420px;
            width: 90%;
            margin: 20px;
            transform: scale(0.7) translateY(-50px);
            transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            overflow: hidden;
        }

        .popup-overlay.show .popup-container {
            transform: scale(1) translateY(0);
        }

        /* Popup Header */
        .popup-header {
            background: rgba(144, 238, 144, 0.5);
            color: #004d40;
            padding: 24px;
            text-align: center;
            position: relative;
        }

        .popup-icon {
            width: 60px;
            height: 60px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            font-size: 24px;
        }

        .popup-title {
            font-size: 22px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .popup-subtitle {
            font-size: 14px;
            opacity: 0.9;
        }

        /* Popup Body */
        .popup-body {
            padding: 24px;
            text-align: center;
        }

        .popup-message {
            font-size: 16px;
            color: #555;
            line-height: 1.5;
            margin-bottom: 8px;
        }

        .popup-warning {
            font-size: 14px;
            color: #888;
            font-style: italic;
        }

        /* Popup Actions */
        .popup-actions {
            padding: 0 24px 24px;
            display: flex;
            gap: 12px;
            flex-direction: column;
        }

        .popup-btn {
            padding: 14px 24px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }

        .popup-btn-delete {
            background: linear-gradient(135deg, #ff4757, #ff3742);
            color: white;
        }

        .popup-btn-delete:hover {
            background: linear-gradient(135deg, #ff3742, #ff2d3a);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 71, 87, 0.3);
        }

        .popup-btn-cancel {
            background: #f8f9fa;
            color: #555;
            border: 2px solid #e9ecef;
        }

        .popup-btn-cancel:hover {
            background: #e9ecef;
            border-color: #dee2e6;
        }

        /* Demo styling */
        .demo-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 40px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .demo-title {
            font-size: 28px;
            color: #333;
            margin-bottom: 16px;
        }

        .demo-description {
            color: #666;
            margin-bottom: 32px;
            line-height: 1.6;
        }

        .delete-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            background: linear-gradient(135deg, #ff4757, #ff3742);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.2s ease;
            font-weight: 500;
        }

        .delete-link:hover {
            background: linear-gradient(135deg, #ff3742, #ff2d3a);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 71, 87, 0.3);
        }

        /* Responsive Design */
        @media (min-width: 480px) {
            .popup-actions {
                flex-direction: row;
            }
            
            .popup-btn {
                flex: 1;
            }
        }

        @media (max-width: 479px) {
            .popup-container {
                width: 95%;
                margin: 10px;
            }
            
            .popup-header {
                padding: 20px;
            }
            
            .popup-icon {
                width: 50px;
                height: 50px;
                font-size: 20px;
            }
            
            .popup-title {
                font-size: 20px;
            }
            
            .popup-body {
                padding: 20px;
            }
            
            .popup-actions {
                padding: 0 20px 20px;
            }
            
            .popup-btn {
                padding: 12px 16px;
                font-size: 15px;
            }
        }}
        </style>

    </head>
    <body>
 
        <jsp:include page="/Nutritionist/nav.jsp"/>  

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

            <main class="main-content" id="mainContent">
                <div class="seller-content">
                    <div class="page-header">
                        <h1 class="page-title">Danh sách món ăn</h1>
                        <ul class="breadcrumb">
                            <li><a href="nutricontrol?action=dashboard">Trang chủ</a></li>
                            <li><a href="nutricontrol?action=showfooddraft">Food Suggestion</a></li>
                            <li>Danh sách đồ ăn gợi ý</li>
                        </ul>
                    </div>

                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title"><i class="fas fa-list-ul"></i>Danh sách đồ ăn gơi ý </h3>
                            <div class="card-tools">
                            </div>
                        </div>
                        <div class="card-body">

                            <form action="${pageContext.request.contextPath}/nutricontrol?action=displaysortfooddraft" method="GET" id="filterForm">
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
                                            <c:choose>
                                                <c:when test="${not empty lstBMI}">
                                                    <c:forEach var="bmi" items="${lstBMI}">
                                                        <c:choose>
                                                            <c:when test="${bmi.bmiID == param.bmiId}">
                                                                <option value="${bmi.bmiID}" selected>${bmi.classification}</option>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <option value="${bmi.bmiID}">${bmi.classification}</option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </c:when>  
                                                <c:otherwise>
                                                    <option disabled>Không có danh mục BMI nào</option>
                                                </c:otherwise>
                                            </c:choose>
                                        </select>

                                    </div>
                                    <div class="select-group">
                                        <select name="category" id="category">
                                            <option value="">-- Loại món ăn --</option>
                                            <c:choose>
                                                <c:when test="${not empty lstC}">
                                                    <c:forEach var="c" items="${lstC}">
                                                        <c:choose>
                                                            <c:when test="${c.catID == param.category}">
                                                                <option value="${c.catID}" selected>${c.caName}</option>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <option value="${c.catID}">${c.caName}</option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <option disabled>Không có loại món ăn nào</option>
                                                </c:otherwise>
                                            </c:choose>
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
                                <input type="hidden" name="action" value="displaysortfooddraft" />
                                <input type="hidden" name="page" id="pageInput" value="${param.page != null ? param.page : 1}" />
                                <div class="filter-actions">
                                    <button type="button" class="btn btn-outline" onclick="location.href = '${pageContext.request.contextPath}/nutricontrol/displaysortfooddraft'">
                                        <i class="fas fa-times"></i> Xóa bộ lọc
                                    </button>
                                    <button type="submit" class="btn btn-primary" name="filterSubmit" value="true"><i class="fas fa-filter"></i> Lọc</button>
                                </div>
                            </form>

                            <div class="table-container">
                                <table>
                                    <thead>
                                        <tr>
                                            <th style="width: 10%;" >Ảnh</th>
                                            <th>ID</th>
                                            <th>Origin ID</th>
                                            <th>Tên Món Ăn</th>  
                                            <th>Category</th>
                                            <th>Giá</th>
                                            <th>Trạng Thái</th>
                                            <th>Cập Nhật Gần Nhất</th>
                                            <th style="width: 8%;">Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${not empty lstFoodDr}">
                                                <c:forEach items="${lstFoodDr}" var="food">
                                                    <tr>
                                                        <td>
                                                            <img src="${food.imageUlr}" alt="ảnh food" class="table-avatar" />
                                                        </td>
                                                        <td><strong>#${food.fdrID}</strong></td>
                                                        <td><strong><c:choose>
                                                                    <c:when test="${food.originID > 0}">
                                                                        #${food.originID}
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        Tạo mới
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </strong></td>
                                                        <td>${food.foodName}</td>
                                                        <td>${food.catName}</td>
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
                                                                <a class="action-btn view-btn" title="Xem chi tiết" href="nutricontrol?action=showfooddraftdetail&id=${food.fdrID}">
                                                                    <i class="fas fa-eye"></i>
                                                                </a>
                                                                <c:if test="${food.status eq 'DRAFT'}">
                                                                    <a class="action-btn edit-btn" title="Chỉnh sửa"
                                                                       href="nutricontrol?action=showeditfooddraft&id=${food.fdrID}">
                                                                        <i class="fas fa-edit"></i>
                                                                    </a>

                                                                    <a class="action-btn remove-btn" id="confirmDeleteBtn" title="Xóa" style="background-color:red; color:white"
                                                                       href="#" onclick="showDeletePopup('nutricontrol?action=deletefooddraft&id=${food.fdrID}', '${food.foodName}'); return false;">
                                                                        <i class="fas fa-trash"></i>
                                                                    </a>
                                                                </c:if>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            <div id="deletePopup" class="popup-overlay">
                                                <div class="popup-container">
                                                    <div class="popup-header">
                                                        <div class="popup-icon">
                                                            <i class="fas fa-exclamation-triangle"></i>
                                                        </div>
                                                        <div class="popup-title">Xác nhận xóa</div>
                                                        <div class="popup-subtitle">Thao tác này không thể hoàn tác</div>
                                                    </div>

                                                    <div class="popup-body">
                                                        <div class="popup-message" id="popupMessage">
                                                            Bạn có chắc chắn muốn xóa sản phẩm này?
                                                        </div>
                                                        <div class="popup-warning">
                                                            Dữ liệu sẽ bị xóa vĩnh viễn và không thể khôi phục.
                                                        </div>
                                                    </div>

                                                    <div class="popup-actions">
                                                        <button class="popup-btn popup-btn-cancel" onclick="closeDeletePopup()">
                                                            <i class="fas fa-times"></i>
                                                            Hủy bỏ
                                                        </button>
                                                        <a id="confirmDeleteBtn" href="nutricontrol?action=deletefooddraft&id=${food.fdrID}" class="popup-btn popup-btn-delete">
                                                            <i class="fas fa-trash-alt"></i>
                                                            Xóa ngay
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>

                                        <c:otherwise>
                                            <tr>
                                                <td colspan="8" style="text-align: center; padding: 30px;">
                                                    Không tìm thấy món ăn nào phù hợp.
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>

                                    </tbody>
                                </table>
                                <div  id="paginationWrapper" class="pagination-container" style="display: flex; justify-content: space-between; padding: 10px;">
                                    <div style="padding: 10px">Show ${lstFoodDr.size()} of ${total} items</div>
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
    
                <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
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
         <script>
     let deleteUrl = '';
     let blogTitle = '';

    
     function showDeletePopup(url, title = '') {
         deleteUrl = url;
         blogTitle = title;
            
     
         const messageElement = document.getElementById('popupMessage');
         if (title) {
             messageElement.innerHTML = `Bạn có chắc chắn muốn xóa Sản phẩm :<br><strong>"${title}"</strong>?`;
         } else {
             messageElement.innerHTML = 'Bạn có chắc chắn muốn xóa bài viết này?';
         }
            
         document.getElementById('confirmDeleteBtn').href = deleteUrl;
            
        
         const popup = document.getElementById('deletePopup');
         popup.classList.add('show');
            
        
         document.body.style.overflow = 'hidden';
     }

    
     function closeDeletePopup() {
         const popup = document.getElementById('deletePopup');
         popup.classList.remove('show');
            
       
         document.body.style.overflow = 'auto';
            
       
         deleteUrl = '';
         blogTitle = '';
     }

    
     document.getElementById('deletePopup').addEventListener('click', function(e) {
         if (e.target === this) {
             closeDeletePopup();
         }
     });

    
     document.addEventListener('keydown', function(e) {
         if (e.key === 'Escape') {
             closeDeletePopup();
         }
     });

     
     document.querySelector('.popup-container').addEventListener('click', function(e) {
         e.stopPropagation();
     });
        </script>

    </body>
</html>




