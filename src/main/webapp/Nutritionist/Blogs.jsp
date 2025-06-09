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
        <title></title>
        <!-- ======= Styles ====== -->
        <link rel="stylesheet" href="../CSS/Ncss/common.css">
        <link rel="stylesheet" href="../CSS/Ncss/blogs.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

        <!-- Thêm link thẻ <head> -->
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
        <script>
            window.contextPath = '${pageContext.request.contextPath}';
        </script>


    </head>

    <body>
        <div class="container">
            <!-- Navigation -->
            <jsp:include page="/Nutritionist/Common.jsp"/>

            <!-- Main Content -->
            <div class="main">
                <!-- Top Bar -->
                <jsp:include page="/Nutritionist/topbar.jsp"/> 


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
                    <!-- Content Controls -->
                    <div class="content-controls">
                        <form name="sort" id="searchFilterForm">
                            <div class="search-filter-container">
                                <div class="search-box"> 
                                    <input type="text" name="input_search"
                                           class="search-input" 
                                           placeholder="Tìm kiếm theo tiêu đề blog..." 
                                           id="searchInput"
                                           value="${param.input_search != null ? param.input_search : ''}">
                                    <div class="button-submit">
                                        <input type="submit" name="button" value="🔍"/>
                                    </div>
                                </div>
                                <select class="filter-select" id="statusFilter" name="status">
                                    <option value="all" ${param.status == null || param.status == 'all' ? 'selected' : ''}>Tất cả trạng thái</option>
                                    <c:forEach var="st" items="${statusList}">
                                        <option value="${st}" ${param.status == st ? 'selected' : ''}>${st}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </form>
                        <a href="createblog" class="create-btn">
                            <i class="fas fa-plus"></i>
                            Add new
                        </a>
                    </div>

                    <!-- Table Container -->
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
                                                    <a href="blogdetail?id=${blog.bID}" title="View">
                                                        <ion-icon name="eye-outline"></ion-icon>
                                                    </a>
                                                    <a href="editBlog.do?id=${blog.bID}" title="Edit">
                                                        <ion-icon name="pencil-outline"></ion-icon>
                                                    </a>
                                                    <a href="deleteblog?id=${blog.bID}" title="Delete"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này?');">
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
                    <div class="pagination-container" style="display: flex; justify-content: space-between; padding: 10px;">
                        <div style="margin: 30px 0 20px">Show ${lstB.size()} of ${totalBlog} items</div>
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

                <!-- Add this script tag before closing body tag -->
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

    </body>

</html>
