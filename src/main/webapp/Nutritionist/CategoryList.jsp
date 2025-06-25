<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/foodlist.css">
        <style>
            /* =================================================================
   CATEGORY CONTENT & PAGE LAYOUT
   ================================================================= */

            .category-content {
                padding: 24px;
                background-color: #f4f7f9; /* A light, neutral background for the content area */
            }

            /* Page Header with Breadcrumbs */
            .category-content .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 24px;
                flex-wrap: wrap; /* Allow wrapping on smaller screens */
                gap: 16px; /* Space between title and breadcrumbs if they wrap */
            }

            .category-content .page-header .page-title {
                margin: 0;
                font-size: 1.75rem; /* 28px */
                font-weight: 700;
                color: #2c3e50; /* Darker, professional blue-gray */
            }

            .category-content .page-header .breadcrumb {
                list-style: none;
                padding: 8px 16px;
                margin: 0;
                background-color: #ffffff;
                border-radius: 6px;
                font-size: 0.9rem;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            }

            .category-content .page-header .breadcrumb li {
                display: inline;
            }

            .category-content .page-header .breadcrumb li a {
                color: #3498db; /* A friendly blue for links */
                text-decoration: none;
                transition: color 0.2s ease;
            }

            .category-content .page-header .breadcrumb li a:hover {
                color: #2980b9;
            }

            .category-content .page-header .breadcrumb li::after {
                content: '›'; /* Use a more elegant separator */
                margin: 0 8px;
                color: #95a5a6; /* Muted separator color */
            }

            .category-content .page-header .breadcrumb li:last-child::after {
                content: ''; /* Remove separator from the last item */
            }

            /* =================================================================
               MAIN CARD STYLING
               ================================================================= */

            .card {
                border: 1px solid #e0e5ec;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
                overflow: hidden; /* Ensures child elements respect the border radius */
                background-color: #ffffff;
            }

            .card-header {
                background-color: #f8f9fa;
                padding: 1rem 1.5rem;
                border-bottom: 1px solid #e0e5ec;
                display: flex;
                align-items: center;
            }

            .card-header .card-title {
                margin: 0;
                font-size: 1.15rem; /* 18px */
                font-weight: 600;
                color: #34495e; /* A strong, dark color */
            }

            .card-header .card-title .fas {
                margin-right: 10px;
                color: #3498db;
            }

            .card-body {
                padding: 1.5rem;
            }

            /* =================================================================
               FILTER AND SEARCH FORM
               ================================================================= */

            #filterForm {
                margin-bottom: 2rem;
            }

            .filter-controls {
                display: flex;
                flex-wrap: wrap;
                gap: 1rem;
                align-items: center;
                margin-bottom: 1rem;
            }


            .input-group {
                display: flex;
                align-items: center;
                background-color: #f5f6fa;
                border: 1px solid #ccc;
                border-radius: 8px;
                padding: 8px 12px;
                min-width: 360px;
                flex-wrap: nowrap;
            }

            .input-group i {
                color: #999;
                font-size: 16px;
                margin-right: 10px;
            }

            .input-group input[type="text"] {
                border: none;
                outline: none;
                background-color: transparent;
                font-size: 14px;
                width: 100%;
                color: #333;
            }

            .create-btn {
                display: inline-flex;
                align-items: center;
                gap: 6px;

                padding: 6px 14px; /* nhỏ lại so với bản to */
                border: none;
                border-radius: 30px;

                background: linear-gradient(135deg, #4cd964, #007aff);
                color: white;
                font-size: 14px;
                font-weight: 500;
                text-decoration: none;
                cursor: pointer;
                transition: opacity 0.2s ease;
                height: 38px; /* chuẩn với input thông thường */
                line-height: 1;
            }

            .create-btn i {
                font-size: 14px;
            }

            .create-btn:hover {
                opacity: 0.9;
            }



            /* =================================================================
               DATA TABLE STYLING
               ================================================================= */
            .table-container {
                overflow-x: auto; /* Makes table scrollable on small screens */
                border: 1px solid #e0e5ec;
                border-radius: 8px;
            }

            table {
                width: 100%;
                border-collapse: collapse; /* Cleaner look */
                font-size: 0.9rem;
            }
            thead {
              border-radius: 10px;    
            }
            thead th {
                background-color: #E3F2FD;
                padding: 1rem;
                text-align: left;
                font-weight: 600;
                color: black;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border-bottom: 2px solid #ced4da;
            }

            tbody tr {
                transition: background-color 0.15s ease-in-out;
            }

            tbody tr:nth-of-type(even) {
                background-color: #f8f9fa;
            }

            tbody tr:hover {
                background-color: #e9ecef; /* Subtle hover effect */
            }

            tbody td {
                padding: 0.9rem 1rem;
                vertical-align: middle;
                border-bottom: 1px solid #e9ecef;
                color: #34495e;
            }

            tbody td strong {
                font-weight: 600;
                color: #3498db;
            }

            /* Empty table message */
            tbody tr td[colspan="8"] {
                font-size: 1rem;
                color: #7f8c8d;
                font-style: italic;
                padding: 40px 0;
            }




            .table-actions {
                display: flex;
                justify-content: center;
                gap: 8px;
            }

            .action-btn {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 34px;
                height: 34px;
                border: none;
                border-radius: 50%; /* Circular buttons */
                font-size: 14px;
                color: white;
                text-decoration: none;
                transition: all 0.2s ease;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .action-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
            }

            .action-btn.edit-btn {
                background-color: #f39c12; /* A warm orange for edit */
            }
            .action-btn.edit-btn:hover {
                background-color: #e67e22;
            }

            .action-btn.remove-btn {
                background-color: #e74c3c; /* A strong red for delete */
            }
            .action-btn.remove-btn:hover {
                background-color: #c0392b;
            }

            /* =================================================================
               PAGINATION STYLING
               ================================================================= */
            .pagination-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                padding: 1rem 1.5rem;
                border-top: 1px solid #e0e5ec;
                background-color: #f8f9fa;
                margin-top: -1px; /* Overlap with card-body bottom margin */
            }

            .pagination-container > div:first-child {
                color: #6c757d;
                font-size: 0.9rem;
            }

            .pagination a, .pagination span {
                color: #3498db;
                padding: 8px 14px;
                text-decoration: none;
                transition: background-color .3s;
                border: 1px solid #ddd;
                margin: 0 2px;
                border-radius: 4px;
            }

            .pagination a:hover {
                background-color: #e9ecef;
            }

            .pagination span.current {
                background-color: #3498db;
                color: white;
                border-color: #3498db;
                font-weight: bold;
            }

            .pagination span.ellipsis {
                padding: 8px 14px;
                border: 1px solid transparent; /* Keep spacing consistent */
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .category-content .page-header {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .filter-controls {
                    flex-direction: column;
                    align-items: stretch;
                }

                .filter-actions {
                    flex-direction: column;
                }
                .filter-actions .btn {
                    width: 100%;
                }

                .pagination-container {
                    flex-direction: column;
                    gap: 1rem;
                }
            }
            
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
        <jsp:include page="/Nutritionist/nav.jsp"/>  
        <jsp:include page="/Nutritionist/main-header.jsp"/>  

        <main class="main-content" id="mainContent">
            <div class="breadcrumb-section">
                <div class="breadcrumb-container">
                    <h1 class="page-title" style="padding-left: 32px">Category List</h1>
                    <nav class="breadcrumb-nav">
                        <a href="/nutricorol?action=dashboard" class="breadcrumb-item">Home</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <span class="breadcrumb-item active">Dashboard</span>
                    </nav>
                </div>
            </div>
            <div class="content-wrapper">
                <div class="category-content">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title"><i class="fas fa-list-ul"></i>Danh sách đồ ăn</h3>
                        </div>
                        <div class="card-body">
                            <div class="card-control" style="display: flex; justify-content: space-between">
                                <form action="${pageContext.request.contextPath}/nutricontrol?action=dashboard" method="GET" >
                                    <div class="filter-controls" style="display: flex; align-items: center; gap: 16px; flex-wrap: wrap;">

                                        <div class="input-group">
                                            <i class="fas fa-search"></i>
                                            <input type="text" name="searchKey" placeholder="Tìm theo tên category..." value="${param.searchKey}">
                                        </div>
                                        <div class="input-group">
                                            <i class="fas fa-search"></i>
                                            <input type="text" name="searchKeyDe" placeholder="Tìm theo tên decription..." value="${param.searchKeyDe}">
                                        </div>
                                        <div class="select-group">
                                            <select name="sortCreate" id="sortCreate">
                                                <option value="">--Sort by Create at --</option>
                                                <option value="asc" ${param.sortCreate == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                                <option value="desc" ${param.sortCreate == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                            </select>
                                        </div>
                                        <div class="select-group">
                                            <select name="sortUpdate" id="sortUpdate">
                                                <option value="">-- Sort by Update at --</option>
                                                <option value="asc" ${param.sortUpdate == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                                <option value="desc" ${param.sortUpdate == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-filter"></i> Lọc
                                        </button>
                                    </div>
                                </form>

<!--                                <a href="nutricontrol?action=showcreatecategory" class="create-btn">
                                    <i class="fas fa-plus"></i>
                                    Add new
                                </a> -->
                            </div> 
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
                                        <c:choose>
                                            <c:when test="${empty lstC}">
                                                <tr>
                                                    <td colspan="8" style="text-align: center; margin: 30px;">
                                                        Không tìm thấy loạinào phù hợp.
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
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
                                                           href="nutricontrol?action=showeditfooddraft&id=${cat.catID}">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <a class="action-btn remove-btn" id="confirmDeleteBtn" title="Xóa" style="background-color:red; color:white"
                                                           href="#" onclick="showDeletePopup('nutricontrol?action=delete&id=${cat.catID}', '${cat.caName}'); return false;"
                                                           >
                                                            <i class="fas fa-trash" ></i>
                                                        </a>   
                                                    </div>
                                                </td>
                                                </tr>
                                            </c:forEach>
                                        </c:otherwise>
                                    </c:choose>
                                    </tbody>
                                </table>
                                <div  id="paginationWrapper" class="pagination-container" style="display: flex; justify-content: space-between; padding: 10px;">
                                    <div style="padding: 10px">Show ${lstC.size()} of ${totalCategory} items</div>
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
        </main>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/common.js"></script>
    </body>
</html>
