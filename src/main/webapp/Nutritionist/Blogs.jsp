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


    </head>

    <body>
        <div class="container">
            <!-- Navigation -->
            <div class="navigation active">
                <ul>
                    <li>
                        <a href="${pageContext.request.contextPath}"/dashboadnutri">
                            <span class="icon"></span>
                            <span class="title">Healthy Foods</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}"/dashboadnutri">
                            <span class="icon">
                                <ion-icon name="home-outline"></ion-icon>
                            </span>
                            <span class="title">Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}"/listfood">
                            <span class="icon">
                                <ion-icon name="restaurant-outline"></ion-icon>
                            </span>
                            <span class="title">Foods</span>
                        </a>
                    </li>
                    <li class="hovered">
                        <a href="listblog">
                            <span class="icon">
                                <ion-icon name="chatbubble-outline"></ion-icon>
                            </span>
                            <span class="title">Blogs</span>
                        </a>
                    </li>
                    <li>
                        <a href="notify">
                            <span class="icon">
                                <ion-icon name="notifications-outline"></ion-icon>
                            </span>
                            <span class="title">Notification</span>
                        </a>
                    </li>
                    <li>
                        <a href="profile">
                            <span class="icon">
                                <ion-icon name="settings-outline"></ion-icon>
                            </span>
                            <span class="title">Settings</span>
                        </a>
                    </li>
                    <li>
                        <a href="changePassword">
                            <span class="icon">
                                <ion-icon name="lock-closed-outline"></ion-icon>
                            </span>
                            <span class="title">Password</span>
                        </a>
                    </li>
                    <li>
                        <a href="logout">
                            <span class="icon">
                                <ion-icon name="log-out-outline"></ion-icon>
                            </span>
                            <span class="title">Sign Out</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Main Content -->
            <div class="main active">
                <!-- Top Bar -->
                <div class="topbar">
                    <div class="toggle">
                        <ion-icon name="menu-outline"></ion-icon>
                    </div>
                    <div class="page-header">
                        <h1 class="page-title">Blog Management</h1>
                        <p class="page-subtitle">Manage and organize your blog posts</p>
                    </div>
                    <div class="user">
                        <img src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&h=100&fit=crop&crop=face" alt="User">
                    </div>
                </div>

                <!-- Content -->
                <div class="content-wrapper">
                    <!-- Success/Error Messages -->
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

                    <!-- Content Controls -->
                    <div class="content-controls">
                        <a href="createblog" class="create-btn">
                            <i class="fas fa-plus"></i>
                            Create New Blog
                        </a>
                        <form name="sort" action="listblog" method="POST">
                            <div class="search-filter-container">
                                <div class="search-box">
                                    <i class="fas fa-search search-icon"></i>
                                    <input type="text" 
                                           class="search-input" 
                                           placeholder="Tìm kiếm theo tiêu đề blog..." 
                                           id="searchInput"
                                           oninput="this.form.submit()">
                                </div>
                                <script>
                                    let typingTimer;
                                    function debouncedSubmit() {
                                        clearTimeout(typingTimer);
                                        typingTimer = setTimeout(() => {
                                            document.getElementById('searchInput').form.submit();
                                        }, 1000);
                                    }
                                </script>

                                <select class="filter-select" id="statusFilter" onchange="this.form.submit()">
                                    <option name="status" value="all" ${ status == null ? 'selected' : ''}>Tất cả trạng thái</option>
                                    <c:forEach var="st" items="${statusList}">
                                        <option name="status" value="${st}"  ${ status == st ? 'selected' : ''} >${st}</option>
                                    </c:forEach>
                                </select>

                                <select class="filter-select" id="sortFilter" onchange="this.form.submit()">
                                    <option value="newest">Mới nhất</option>
                                    <option value="oldest">Cũ nhất</option>
                                    <option value="title_asc">Tiêu đề A-Z</option>
                                    <option value="title_desc">Tiêu đề Z-A</option>
                                </select>
                            </div>
                        </form>
                    </div>
                    <div class="table-container">
                        <c:choose>
                            <c:when test="${not empty lstB}">
                                <table class="blog-table">
                                    <thead>
                                        <tr>
                                            <th colspan="3">Image</th>
                                            <th >ID</th>
                                            <th>Tiêu đề</th>
                                            <th>Trạng thái</th>
                                            <th>Cập nhật gần nhất</th>
                                            <th style="text-align: center;" colspan="3">Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="blog" items="${lstB}" >
                                            <tr>
                                                <td colspan="3"><img src="${blog.imageUlr}" name="imageUlr" value="${blog.imageUlr}" alt="Anh blog" style="width: 80px; height: 44px;"></img></td>
                                                <td class="blog-id">${blog.bID}</td>
                                                <td class="blog-title">${blog.title}</td>
                                                <td>
                                                    <span class="status status-${blog.status}">
                                                        ${blog.status}
                                                    </span>
                                                </td>
                                                <td class="date-time">
                                                    <fmt:formatDate
                                                        value="${blog.update_at}"
                                                        pattern="yyyy-MM-dd HH:mm:ss" />
                                                </td>
                                                <td class="action-cell" style="text-align: center;">
                                                    <a href="blogdetail?id=${blog.bID}" title="View">
                                                        <ion-icon name="eye-outline"></ion-icon>
                                                    </a>
                                                    <a href="editBlog.do?id=${blog.bID}" title="Edit">
                                                        <ion-icon name="pencil-outline"></ion-icon>
                                                    </a>
                                                    <a href="deleteblog?id=${blog.bID}"
                                                       title="Delete"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này?');">
                                                        <ion-icon name="trash-outline" style="color: red"></ion-icon>
                                                    </a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </c:when>
                                <c:otherwise>
                                    <p style="text-align: center; font-style: italic; color: #555;">
                                        Không có bài viết nào.
                                    </p>
                                </c:otherwise>
                            </c:choose>
                        </table>
                    </div>
                    <!-- pagnent -->
                    <div style="display: flex ; justify-content: space-between ; padding: 10px">
                        <div style="margin: 30px 0 20px">Show 10 of 12 items</div>
                        <c:if test="${totalPages > 1}">
                            <div class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <a href="?page=${currentPage - 1}" class="prev">&laquo; Previous</a>
                                </c:if>
                                <c:forEach var="i" begin="1" end="${totalPages}" varStatus="status">
                                    <c:choose>
                                        <c:when test="${i == currentPage}">
                                            <span class="current">${i}</span>
                                        </c:when>
                                        <c:when test="${i <= currentPage + 2 && i >= currentPage - 2}">
                                            <a href="listblog?index=${i}">${i}</a>
                                        </c:when>
                                        <c:when test="${i == currentPage - 3 || i == currentPage + 3}">
                                            <span class="ellipsis">...</span>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                                <c:if test="${currentPage < totalPages}">
                                    <a href="listblog?index=${currentPage + 1}" class="next">Next &raquo;</a>
                                </c:if>
                            </div>

                        </c:if>
                    </div>
                </div>
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
