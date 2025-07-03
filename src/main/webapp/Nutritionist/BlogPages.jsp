<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nutritionist Dashboard</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&family=Rubik:wght@500&family=Nunito:wght@600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;600;700&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
        
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/dashboard.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/Blogs.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/common.css" >


        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">
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
        <!-- Sidebar -->
        <jsp:include page="/Nutritionist/nav.jsp"/>  
        <!-- Main Header -->
        <jsp:include page="/Nutritionist/main-header.jsp"/>  
        
        <c:if test="${not empty Errmess}">
            <div class="alert alert-danger" style="display: none;">${Errmess}</div>
             <c:remove var="Errmess" scope="request"/>
        </c:if>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-success" style="display: none;">${successMessage}</div>
             <c:remove var="successMessage" scope="request"/>
        </c:if>

        <c:if test="${not empty warningMessage}">
            <div class="alert alert-warning" style="display: none;">${warningMessage}</div>
              <c:remove var="warningMessage" scope="request"/>
        </c:if>

        <c:if test="${not empty infoMessage}">
            <div class="alert alert-info" style="display: none;">${infoMessage}</div>
              <c:remove var="infoMessage" scope="request"/>
        </c:if>
        <!-- Main Content -->
        <main class="main-content" id="mainContent">
            <!-- Breadcrumb Section -->
            <div class="breadcrumb-section">
                <div class="breadcrumb-container">
                    <nav class="breadcrumb-nav">
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Home</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=displayblog" class="breadcrumb-item">Blogs</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <span class="breadcrumb-item active">Blog List</span>
                    </nav>
                    <h1 class="page-title" style="padding-left: 32px">Blog Management – Kiến Thức Dinh Dưỡng</h1>
                </div>
            </div>
            <div class="content-wrapper">
                <div class="content-controls">
                    <form name="sort" id="searchFilterForm">
                        <div class="search-filter-container">
                            <div class="search-box"> 
                                <input type="text" name="input_search"
                                       class="search-input" 
                                       placeholder="Tìm kiếm theo tiêu đề blog..." 
                                       id="searchInput"
                                       value="${param.input_search != null ? param.input_search : ''}">
                                <button type="submit" class="search-button">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                            <select class="filter-select" id="statusFilter" name="status">
                                <option value="" ${param.status == null || param.status == 'all' ? 'selected' : ''}>Tất cả trạng thái</option>
                                <c:forEach var="st" items="${statusList}">
                                    <option value="${st}" ${param.status == st ? 'selected' : ''}>${st}</option>
                                </c:forEach>
                            </select> 
                            <select class="filter-select" id="BmitypeFilter" name="typebmi">
                                <option value="" ${param.bmiID == null ? 'selected' : ''}>All</option>
                                <c:forEach var="st" items="${lstBMItype}">
                                    <option value="${st.bmiID}" ${param.bmiId == st.bmiID ? 'selected' : ''}>${st.classification}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                    <a href="nutricontrol?action=displaycreateblog" class="create-btn">
                        <i class="fas fa-plus"></i>
                        Add new
                    </a>
                </div>


                <div class="table-container">
                    <c:choose>
                        <c:when test="${not empty lstB}">
                            <table class="blog-table">
                                <thead>
                                    <tr>
                                        <th colspan="3">Image</th>
                                        <th>ID</th>
                                        <th>Tiêu đề</th>
                                        <th>Trạng thái</th>
                                        <th>Cập nhật gần nhất</th>
                                        <th style="text-align: center;" colspan="3">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody id="blogTableBody">
                                    <c:forEach var="blog" items="${lstB}">
                                        <tr>
                                            <td colspan="3">
                                                <img src="${blog.imageUlr}" alt="Anh blog" style="width: 80px; height: 44px; object-fit: cover;">
                                            </td>
                                            <td class="blog-id">${blog.bID}</td>
                                            <td class="blog-title">${blog.title}</td>
                                            <td>
                                                <span class="status status-${blog.status}">
                                                    ${blog.status}
                                                </span>
                                            </td>
                                            <td class="date-time">
                                                <fmt:formatDate value="${blog.update_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                                            </td>
                                            <td class="action-cell" style="text-align: center;">
                                                <a href="nutricontrol?action=showdetail&id=${blog.bID}" title="View">
                                                    <ion-icon name="eye-outline"></ion-icon>
                                                </a>
                                                <a href="nutricontrol?action=editblog&id=${blog.bID}" title="Edit">
                                                    <ion-icon name="create-outline"></ion-icon>
                                                </a>
                                                <a href="#" title="Delete"
                                                       onclick="showDeletePopup('nutricontrol?action=deleteblog&id=${blog.bID}', '${blog.title}'); return false;">
                                                        <ion-icon name="trash-outline" style="color: red"></ion-icon>
                                               </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <p style="text-align: center; font-style: italic; color: #555; padding: 40px;">
                                Không có bài viết nào.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
                              
                <div  id="paginationWrapper" class="pagination-container" style="display: flex; justify-content: space-between; padding: 10px;">
                    <div style="padding: 10px">Show ${lstB.size()} of ${totalBlog} items</div>
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
        <script>
                window.contextPath = '${pageContext.request.contextPath}';
        </script>
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
                    <a id="confirmDeleteBtn" href="nutritionist?action=delete&id=blog.bID" class="popup-btn popup-btn-delete">
                        <i class="fas fa-trash-alt"></i>
                        Xóa ngay
                    </a>
                </div>
            </div>
        </div>

        <script>
            window.contextPath = '${pageContext.request.contextPath}';
        </script>
        <script src="../JS/Nutritionist/common.js"></script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/Blog.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2"></script>
         
        <script>
     let deleteUrl = '';
     let blogTitle = '';

    
     function showDeletePopup(url, title = '') {
         deleteUrl = url;
         blogTitle = title;
            
     
         const messageElement = document.getElementById('popupMessage');
         if (title) {
             messageElement.innerHTML = `Bạn có chắc chắn muốn xóa bài viết:<br><strong>"${title}"</strong>?`;
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
