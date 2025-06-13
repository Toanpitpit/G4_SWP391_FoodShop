<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý bài viết</title>
        <!-- ======= Styles ====== -->
        <link rel="stylesheet" href="../CSS/Ncss/common.css">
        <link rel="stylesheet" href="../CSS/Ncss/blogs.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

        <style>
            /* CSS cho popup xóa */
            .popup-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                justify-content: center;
                align-items: center;
            }

            .popup-overlay.show {
                display: flex;
            }

            .popup-container {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
                width: 400px;
                max-width: 90%;
                overflow: hidden;
            }

            .popup-header {
                background-color: #f8f9fa;
                padding: 20px;
                text-align: center;
                border-bottom: 1px solid #e9ecef;
            }

            .popup-icon {
                font-size: 48px;
                color: #dc3545;
                margin-bottom: 10px;
            }

            .popup-title {
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 5px;
            }

            .popup-subtitle {
                color: #6c757d;
                font-size: 14px;
            }

            .popup-body {
                padding: 20px;
                text-align: center;
            }

            .popup-message {
                margin-bottom: 15px;
                font-size: 16px;
                line-height: 1.5;
            }

            .popup-warning {
                background-color: #fff8f9;
                border-radius: 4px;
                padding: 10px;
                color: #dc3545;
                font-size: 14px;
                margin-top: 15px;
            }

            .popup-actions {
                display: flex;
                justify-content: center;
                padding: 20px;
                background-color: #f8f9fa;
                border-top: 1px solid #e9ecef;
            }

            .popup-btn {
                padding: 10px 20px;
                border-radius: 4px;
                font-weight: 500;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s;
                margin: 0 10px;
            }

            .popup-btn i {
                margin-right: 8px;
            }

            .popup-btn-cancel {
                background-color: #e9ecef;
                color: #495057;
                border: 1px solid #ced4da;
            }

            .popup-btn-cancel:hover {
                background-color: #dee2e6;
            }

            .popup-btn-delete {
                background-color: #dc3545;
                color: white;
                border: 1px solid #dc3545;
            }

            .popup-btn-delete:hover {
                background-color: #c82333;
                border-color: #bd2130;
            }
        </style>

        <script>
            window.contextPath = '${pageContext.request.contextPath}';
        </script>
    </head>

    <body>
        <jsp:include page="/Nutritionist/topbar.jsp"/> 
        <div class="container">
            <jsp:include page="/Nutritionist/Common.jsp"/>            <!-- Main Content -->
            <div class="main">
                <!-- Top Bar -->

                <!-- Breadcrumb -->

                <div class="breadcrumb-section">
                    <div class="page-header">

                        <nav class="breadcrumb-nav">
                            <a href="${pageContext.request.contextPath}/dashboadnutri" class="breadcrumb-link">Trang chủ</a>
                            <span class="separator">/</span>
                            <a href="${pageContext.request.contextPath}/listblog" class="breadcrumb-link">Blog</a>
                            <span class="separator">/</span>
                            <span class="breadcrumb-current">Quản lý bài viết</span>
                        </nav>
                    </div>
                </div>

                <c:if test="${not empty mess}">
                    <div class="create-success-alert success">
                        ${mess}
                    </div>
                    <c:remove var="mess" scope="session" />
                </c:if>

                <c:if test="${empty mess and not empty Errmess}">
                    <div class="create-success-alert error">
                        ${Errmess}
                    </div>
                    <c:remove var="Errmess" scope="session" />
                </c:if>


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
                        <a href="nutricontrol?action=createblog" class="create-btn">
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
                                                    <a href="nutricontrol?action=displayblogdetail?id=${blog.bID}" title="View">
                                                        <ion-icon name="eye-outline"></ion-icon>
                                                    </a>
                                                    <a href="nutricontrol?action=updateblog&id=${blog.bID}" title="Edit">
                                                        <ion-icon name="pencil-outline"></ion-icon>
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

                    <!-- Pagination Container -->
                    <div  id="paginationWrapper" class="pagination-container" style="display: flex; justify-content: space-between; padding: 10px;">
                        <div style="padding: 10px">Show ${lstB.size()} of ${totalBlog} items</div>
                        <c:if test="${totalPages > 1}">
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
            </div>
        </div>

        <!-- =========== Scripts =========  -->
        <script src="../JS/Nutritionist/home.js"></script>
        <script src="../JS/Nutritionist/blog.js"></script>

        <!-- ====== ionicons ======= -->
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
        <script>
                    let deleteUrl = '';
                    let blogTitle = '';

                    // Function to show delete popup
                    function showDeletePopup(url, title = '') {
                        deleteUrl = url;
                        blogTitle = title;

                        // Update popup content
                        const messageElement = document.getElementById('popupMessage');
                        if (title) {
                            messageElement.innerHTML = `Bạn có chắc chắn muốn xóa bài viết:<br><strong>"${title}"</strong>?`;
                        } else {
                            messageElement.innerHTML = 'Bạn có chắc chắn muốn xóa bài viết này?';
                        }

                        // Show popup with animation
                        const popup = document.getElementById('deletePopup');
                        popup.classList.add('show');

                        // Prevent body scrolling
                        document.body.style.overflow = 'hidden';
                    }

                    // Function to handle delete action
                    function handleDelete() {
                        if (deleteUrl) {
                            window.location.href = deleteUrl;
                        } else {
                            console.error("Delete URL is not set");
                            closeDeletePopup();
                        }
                    }

                    // Function to close delete popup
                    function closeDeletePopup() {
                        const popup = document.getElementById('deletePopup');
                        popup.classList.remove('show');
                        document.body.style.overflow = 'auto';
                        deleteUrl = '';
                        blogTitle = '';
                    }

                    // Close popup when clicking outside
                    document.getElementById('deletePopup').addEventListener('click', function (e) {
                        if (e.target === this) {
                            closeDeletePopup();
                        }
                    });

                    // Close popup with Escape key
                    document.addEventListener('keydown', function (e) {
                        if (e.key === 'Escape') {
                            closeDeletePopup();
                        }
                    });

                    // Prevent popup from closing when clicking inside
                    document.querySelector('.popup-container').addEventListener('click', function (e) {
                        e.stopPropagation();
                    });
        </script>
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
                    <button class="popup-btn popup-btn-delete" onclick="handleDelete()">
                        <i class="fas fa-trash-alt"></i>
                        Xóa ngay
                    </button>
                </div>
            </div>
        </div>
    </body>

</html>
