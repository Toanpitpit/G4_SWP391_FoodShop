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
            .category-content {
                padding: 24px;
                background-color: #f4f7f9; 
            }

            .category-content .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 24px;
                flex-wrap: wrap; 
                gap: 16px;
            }

            .category-content .page-header .page-title {
                margin: 0;
                font-size: 1.75rem; 
                font-weight: 700;
                color: #2c3e50; 
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
                color: #3498db; 
                text-decoration: none;
                transition: color 0.2s ease;
            }

            .category-content .page-header .breadcrumb li a:hover {
                color: #2980b9;
            }

            .category-content .page-header .breadcrumb li::after {
                content: '›'; 
                margin: 0 8px;
                color: #95a5a6;
            }

            .category-content .page-header .breadcrumb li:last-child::after {
                content: ''; 
            }



            .card {
                border: 1px solid #e0e5ec;
                border-radius: 12px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.06);
                overflow: hidden; 
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
                font-size: 1.15rem; 
                font-weight: 600;
                color: #34495e;
            }

            .card-header .card-title .fas {
                margin-right: 10px;
                color: #3498db;
            }

            .card-body {
                padding: 1.5rem;
            }

          
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

                padding: 6px 14px; 
                border: none;
                border-radius: 30px;

                background: linear-gradient(135deg, #4cd964, #007aff);
                color: white;
                font-size: 14px;
                font-weight: 500;
                text-decoration: none;
                cursor: pointer;
                transition: opacity 0.2s ease;
                height: 38px; 
                line-height: 1;
            }

            .create-btn i {
                font-size: 14px;
            }

            .create-btn:hover {
                opacity: 0.9;
            }



         
            .table-container {
                overflow-x: auto; 
                border: 1px solid #e0e5ec;
                border-radius: 8px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
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
                background-color: #e9ecef;
            }

            tbody td {
                padding: 0.9rem 1rem;
                vertical-align: middle;
                border-bottom: 1px solid #e9ecef;
                color: #34495e;
            }
            .ellipsis {
                max-width: 300px;        
                white-space: nowrap;    
                overflow: hidden;       
                text-overflow: ellipsis; 
                display: inline-block;  
                vertical-align: middle;
            }

            tbody td strong {
                font-weight: 600;
                color: #3498db;
            }

            
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
                border-radius: 50%; 
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
                background-color: #f39c12; 
            }
            .action-btn.edit-btn:hover {
                background-color: #e67e22;
            }

            .action-btn.remove-btn {
                background-color: #e74c3c; 
            }
            .action-btn.remove-btn:hover {
                background-color: #c0392b;
            }
            .pagination-container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                flex-wrap: wrap;
                padding: 1rem 1.5rem;
                border-top: 1px solid #e0e5ec;
                background-color: #f8f9fa;
                margin-top: -1px; 
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
         <style>
       /* Popup Overlay */
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
            <div class="breadcrumb-section">
                <div class="breadcrumb-container">
                    <h1 class="page-title" style="padding-left: 32px">Category List</h1>
                    <nav class="breadcrumb-nav">
                        <a href="/nutricontrol?action=dashboard" class="breadcrumb-item">Home</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <a href="/nutricontrol?action=showcategory" class="breadcrumb-item">Category</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <span class="breadcrumb-item active">Category List</span>
                    </nav>
                </div>
            </div>
            <div class="content-wrapper">
                <div class="category-content">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title"><i class="fas fa-list-ul"></i>Danh sách danh mục đồ ăn</h3>
                        </div>
                        <div class="card-body">
                            <div class="card-control" style="display: flex; justify-content: space-between">
                                <form id="filterForm" action="${pageContext.request.contextPath}/nutricontrol" method="GET">
                                    <input type="hidden" name="action" value="displaysortcategory">
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

                                <a href="nutricontrol?action=showEditCategory" class="create-btn">
                                    <i class="fas fa-plus"></i>
                                    Add new
                                </a> 
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
                                                        Không tìm thấy loại nào phù hợp.
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach items="${lstC}" var="cat">
                                                    <tr>
                                                        <td><strong>#${cat.catID}</strong></td>
                                                        <td>${cat.caName}</td>
                                                        <td class="ellipsis" title="${cat.decription}">${cat.decription}</td>
                                                        <td>
                                                            <fmt:formatDate value="${cat.create_at}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                        </td>
                                                        <td>
                                                            <fmt:formatDate value="${cat.update_at}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                        </td>
                                                        <td>
                                                            <div class="table-actions">

                                                                <a class="action-btn edit-btn" title="Chỉnh sửa"
                                                                   href="nutricontrol?action=showEditCategory&id=${cat.catID}">
                                                                    <i class="fas fa-edit"></i>
                                                                </a>
                                                                <a class="action-btn remove-btn" id="confirmDeleteBtn" title="Xóa" style="background-color:red; color:white"
                                                                   href="#" onclick="showDeletePopup('nutricontrol?action=deleteCategory&id=${cat.catID}', '${cat.caName}'); return false;"
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
                        Bạn có chắc chắn muốn xóa bài viết này?
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
                    <a id="confirmDeleteBtn" href="nutricontrol?action=deleteCategory&id=${cat.catID}" class="popup-btn popup-btn-delete">
                        <i class="fas fa-trash-alt"></i>
                        Xóa ngay
                    </a>
                </div>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/common.js"></script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/Category.js"></script>
              <script>
     let deleteUrl = '';
     let categoryTitle = '';

    
     function showDeletePopup(url, title = '') {
         deleteUrl = url;
         categoryTitle = title;
            
     
         const messageElement = document.getElementById('popupMessage');
         if (title) {
             messageElement.innerHTML = `Bạn có chắc chắn muốn danh mục :<br><strong>"${title}"</strong>?`;
         } else {
             messageElement.innerHTML = 'Bạn có chắc chắn muốn xóa danh mục này?';
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
