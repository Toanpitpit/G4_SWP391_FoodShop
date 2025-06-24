<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nutritionist Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">
    </head>
    <body>
        <jsp:include page="/Nutritionist/nav.jsp"/>  
        <jsp:include page="/Nutritionist/main-header.jsp"/>  

        <main class="main-content" id="mainContent">
            <div class="breadcrumb-section">
                <div class="breadcrumb-container">
                    <h1 class="page-title" style="padding-left: 32px">Category List</h1>
                    <nav class="breadcrumb-nav">
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Home</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <span class="breadcrumb-item active">Dashboard</span>
                    </nav>
                </div>
            </div>
            <div class="content-wrapper">
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
                                        <th>ID</th>
                                        <th>Category Name</th>  
                                        <th>Decription</th>
                                        <th>Create at</th>
                                        <th>Last Update</th>
                                        <th style="width: 5%;">Thao Tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${lstC}" var="cat">
                                        <tr>
                                            <td><strong>#${cat.catID}</strong></td>
                                            <td>${cat.caName}</td>
                                            <td>${cat.decription}</td>
                                            <td>
                                                <fmt:formatDate value="${cat.create_at}" pattern="dd/MM/yyyy HH:mm:ss" />
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${cat.update_at}" pattern="dd/MM/yyyy HH:mm:ss" />
                                            </td>
                                            <td>
                                                <div class="table-actions">

                                                    <a class="action-btn edit-btn" title="Chỉnh sửa"
                                                       href="nutricontrol?action=showeditfooddraft&id=${cat.fdrID}">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a class="action-btn remove-btn" id="confirmDeleteBtn" title="Xóa" style="background-color:red; color:white"
                                                       href="#" onclick="showDeletePopup('nutricontrol?action=delete&id=${food.fdrID}', '${food.foodName}'); return false;"
                                                       >
                                                        <i class="fas fa-trash" ></i>
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
            </div>

            <jsp:include page="/Nutritionist/footer.jsp"/>  
        </main
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/common.js"></script>
    </body>
</html>
