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
            <div class="navigation">
                <ul>
                    <li>
                        <a href="../dashboadnutri">
                            <!-- them ảnh  log hay icon cua web-->
                            <span class="icon">
                            </span>
                            <span class="title">Heathy Foods</span>
                        </a>
                    </li>

                    <li>
                        <a href="../dashboadnutri">
                            <span class="icon">
                                <ion-icon name="home-outline"></ion-icon>
                            </span>
                            <span class="title">Dashboard</span>
                        </a>
                    </li>

                    <li>
                        <a href="listfood">
                            <span class="icon">
                                <ion-icon name="people-outline"></ion-icon>
                            </span>
                            <span class="title">Foods</span>
                        </a>
                    </li>

                    <li>
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
                                <ion-icon name="help-outline"></ion-icon>
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

            <!-- ========================= Main ==================== -->

            <div class="main">
                <div class="topbar">
                    <div class="toggle">
                        <ion-icon name="menu-outline"></ion-icon>
                    </div>
                    <div class="user">
                        <img src="assets/imgs/customer01.jpg" alt="">
                    </div>
                </div>
                <!-- ===========================================Main content =================================================-->
                <div class="overview-container">
                    <div class="status-overview">
                        <div class="status-chart">
                            <canvas id="statusChart"
                                    data-public="${publicCount}"
                                    data-draft="${draftCount}"
                                    data-private="${privateCount}">
                            </canvas>
                        </div>
                        <div class="status-legend">
                            <h3>Thống kê theo trạng thái</h3>
                            <ul class="legend-list">
                                <li>
                                    <span class="legend-color-box" style="background-color: rgba(75, 192, 192, 0.8);"></span>
                                    <span class="legend-label">Public</span>
                                    <span class="legend-value">${publicCount}</span>
                                </li>
                                <li>
                                    <span class="legend-color-box" style="background-color: rgba(255, 205, 86, 0.8);"></span>
                                    <span class="legend-label">Draft</span>
                                    <span class="legend-value">${draftCount}</span>
                                </li>
                                <li>
                                    <span class="legend-color-box" style="background-color: rgba(255, 99, 132, 0.8);"></span>
                                    <span class="legend-label">Private</span>
                                    <span class="legend-value">${privateCount}</span>
                                </li>
                                <li>
                                    <span class="legend-color-box" style="background-color: #6B21A8;;"></span>
                                    <span class="legend-label">Total</span>
                                    <span class="legend-value">${privateCount + draftCount+ publicCount}</span>
                                </li>
                            </ul>
                            <div class="chart-name">Biểu đồ: Số bài Blog theo trạng thái</div>
                        </div>
                    </div>

                    <div class="bmi-overview">
                        <div class="bmi-chart">
                            <canvas id="bmiChart"
                                    data-labels='[
                                    <c:forEach var="lbl" items="${typeLabels}" varStatus="st">
                                        "${lbl}"<c:if test="${!st.last}">,</c:if>
                                    </c:forEach>
                                    ]'
                                    data-counts='[
                                    <c:forEach var="cnt" items="${typeCounts}" varStatus="st">
                                        ${cnt}<c:if test="${!st.last}">,</c:if>
                                    </c:forEach>
                                    ]'>
                            </canvas>
                        </div>
                        <div class="bmi-legend">
                            <h3>Thống kê theo loại BMI</h3>
                            <ul class="legend-list">
                                <c:forEach var="i" begin="0" end="${fn:length(typeLabels) - 1}">
                                    <c:set var="colorIdx" value="${i % 6}" />
                                    <li>
                                        <span class="legend-color-box"
                                              style="background-color: var(--bmi-color-${colorIdx});"></span>
                                        <span class="legend-label">${typeLabels[i]}</span>
                                        <span class="legend-value">${typeCounts[i]}</span>
                                    </li>
                                </c:forEach>

                            </ul>
                            <div class="chart-name">Biểu đồ: Số bài Blog theo loại BMI</div>
                        </div>
                    </div>
                </div>
                <hr>                              
                <!--=======================List Blog contentner ==============================-->                           
                <div class="button-message-container">
                    <a href="createblog" class="button-form">
                        <button type="submit" class="create-button">
                            + Create Blog
                        </button>
                    </a>
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
                
                <div class="Blog_box">
                    <div class="blog-list-container">
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
                                    <tbody>
                                        <c:forEach var="blog" items="${lstB}" varStatus="loop" >
                                            <tr>
                                                <td colspan="3"><img src="${blog.imageUlr}" alt="Anh blog" style="width: 80px; height: 44px;"></img></td>
                                                <td>${loop.index + 1}</td>
                                                <td>${blog.title}</td>
                                                <td>
                                                    <span class="status status-${blog.status}">
                                                        ${blog.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <fmt:formatDate
                                                        value="${blog.update_at}"
                                                        pattern="yyyy-MM-dd HH:mm:ss" />
                                                </td>
                                                <td class="action-cell" style="text-align: center;">
                                                    <a href="viewBlog.do?id=${blog.bID}" title="View">
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
                        <!--================================================= End table list blog =========================================-->
                        <!--================================ Start pagination ================================-->
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
                        <!--================================ End  pagination ================================-->
                        <!-- Phần search / filter -->
                        <div class="search-filter">
                            <label>
                                <input
                                    type="text"
                                    placeholder="Search here"
                                    id="blogSearchInput"
                                    />
                                <ion-icon name="search-outline"></ion-icon>
                            </label>

                            <select id="filterStatus" name="status">
                                <c:forEach var="status" items="${statusList}">
                                    <option value="${status}" <c:if test="${status == status}">selected</c:if>>${status}</option>
                                </c:forEach>
                            </select>
                            <div class="form-group">
                                <label>BMI Category</label>
                                <div class="bmi-list">
                                    <c:forEach var="bmi" items="${lstBMI}">
                                        <label class="bmi-item">
                                            <div class="bmi-item <c:if test='${bmi.bmiID == selectedBmiId}'>selected</c:if>'" 
                                                 data-id="${bmi.bmiID}">
                                                ${bmi.classification}
                                            </div>
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                
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
