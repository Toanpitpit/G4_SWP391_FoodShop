
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" type="text/css" href="../css/animate.min.css">
    <link rel="stylesheet" type="text/css" href="../css/animation.css">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/bootstrap-select.min.css">
    <link rel="stylesheet" type="text/css" href="../css/style.css">
    <link rel="stylesheet" type="text/css" href="../customdesign/Ncss/commonnav.css">
    <link rel="stylesheet" href="../customdesign/Ncss/Homed.css">
    <link rel="stylesheet" href="../customdesign/Ncss/blogs.css">

    <!-- Font -->
    <link rel="stylesheet" href="../font/fonts.css">

    <!-- Icon -->
    <link rel="stylesheet" href="../icon/style.css">

    <!-- Favicon and Touch Icons  -->
    <link rel="shortcut icon" href="../images/favicon.png">
    <link rel="apple-touch-icon-precomposed" href="../images/favicon.png">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

</head>

<body class="body">

    <!-- #wrapper -->
    <div id="wrapper">
        <!-- #page -->
        <div id="page" class="">
            <!-- layout-wrap -->
            <div class="layout-wrap">
                <!-- preload -->
                <div id="preload" class="preload-container">
                    <div class="preloading">
                        <span></span>
                    </div>
                </div>
                <!-- /preload -->
                <!-- section-menu-left -->
                <div class="section-menu-left" style="background-color: : #d0f0c0 !important; ">
                    <div class="box-logo">
                        <a href="index.html" id="site-logo-inner">
                            <img class="" id="logo_header" alt="chua có" src="${pageContext.request.contextPath}/img/logo/logo12.png" data-light="${pageContext.request.contextPath}/img/logo/logo12.png" data-dark="${pageContext.request.contextPath}/img/logo/logo12.png"  style="width: 154px;height:52px;">
                        </a>
                        <div class="button-show-hide">
                            <i class="icon-menu-left"></i>
                        </div>
                    </div>
                    <div class="section-menu-left-wrap">
                        <div class="center">
                            <div class="center-item">
                                <div class="center-heading">Main Home</div>
                                <ul class="menu-list">
                                    <li class="menu-item">
                                        <!--thay dổi link ở đây -->
                                        <a href="javascript:void(0);" class="menu-item-button">
                                            <div class="icon"><i class="icon-grid"></i></div>
                                            <div class="text">Dashboard</div>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="center-item">
                                <div class="center-heading">All page</div>
                                <ul class="menu-list">
                                    <li class="menu-item has-children">
                                        <a href="javascript:void(0);" class="menu-item-button">
                                            <div class="icon"><i class="icon-shopping-cart"></i></div>
                                            <div class="text">Food Draft</div>
                                        </a>
                                        <ul class="sub-menu">
                                            <li class="sub-menu-item">
                                                <a href="add-product.html" class="">
                                                    <div class="text">Add Food Draft</div>
                                                </a>
                                            </li>
                                            <li class="sub-menu-item">
                                                <a href="product-list.html" class="">
                                                    <div class="text">Food Draft List</div>
                                                </a>
                                            </li>
                                            <li class="sub-menu-item">
                                                <a href="product-detail-1.html" class="">
                                                    <div class="text">Food Draft Detail</div>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="menu-item has-children">
                                        <a href="javascript:void(0);" class="menu-item-button">
                                            <div class="icon"><i class="icon-edit"></i></div>
                                            <div class="text">Blog page</div>
                                        </a>
                                        <ul class="sub-menu">
                                            <li class="sub-menu-item">
                                                <a href="list-page.html" class="">
                                                    <div class="text">List Blog</div>
                                                </a>
                                            </li>
                                            <li class="sub-menu-item">
                                                <a href="new-page.html" class="">
                                                    <div class="text">New Blog</div>
                                                </a>
                                            </li>
                                            <li class="sub-menu-item">
                                                <a href="edit-page.html" class="">
                                                    <div class="text">Edit Blogs</div>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="menu-item has-children">
                                        <a href="javascript:void(0);" class="menu-item-button">
                                            <div class="icon"><i class="icon-layers"></i></div>
                                            <div class="text">BMI type</div>
                                        </a>
                                        <ul class="sub-menu">
                                            <li class="sub-menu-item">
                                                <a href="category-list.html" class="">
                                                    <div class="text">BMI type list</div>
                                                </a>
                                            </li>
                                            <li class="sub-menu-item">
                                                <a href="new-category.html" class="">
                                                    <div class="text">New BMI type</div>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="menu-item has-children">
                                        <a href="javascript:void(0);" class="menu-item-button">
                                            <div class="icon"><i class="icon-box"></i></div>
                                            <div class="text">Food Category</div>
                                        </a>
                                        <ul class="sub-menu">
                                            <li class="sub-menu-item">
                                                <a href="attributes.html" class="">
                                                    <div class="text">Categorys</div>
                                                </a>
                                            </li>
                                            <li class="sub-menu-item">
                                                <a href="add-attributes.html" class="">
                                                    <div class="text">Add New Category</div>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                    <li class="menu-item has-children">
                                        <a href="javascript:void(0);" class="menu-item-button">
                                            <div class="icon"><i class="icon-file-plus"></i></div>
                                            <div class="text">Your request</div>
                                        </a>
                                        <ul class="sub-menu">
                                            <li class="sub-menu-item">
                                                <a href="oder-list.html" class="">
                                                    <div class="text">Request list</div>
                                                </a>
                                            </li>
                                            <li class="sub-menu-item">
                                                <a href="oder-tracking.html" class="">
                                                    <div class="text">Create new Request</div>
                                                </a>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </div>
                            <div class="center-item">
                                <div class="center-heading">Setting</div>
                                <ul class="menu-list">
                                    <li class="menu-item">
                                        <a href="setting.html" class="">
                                            <div class="icon"><i class="icon-settings"></i></div>
                                            <div class="text">Setting</div>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="center-item">
                                <div class="center-heading">Components</div>
                                <ul class="menu-list">
                                    <li class="menu-item">
                                        <a href="components.html" class="">
                                            <div class="icon"><i class="icon-database"></i></div>
                                            <div class="text">Components</div>
                                        </a>
                                    </li>
                                </ul>
                            </div> 
                        </div>
                    </div>
                </div>
                <!-- /section-menu-left -->
                <!-- section-content-right -->
                <div class="section-content-right">
                    <!-- header-dashboard -->
                    <div class="header-dashboard">
                        <div class="wrap">
                            <div class="header-left">
                                <a href="index.html">
                                    <img class="" id="logo_header_mobile" alt="" src="images/logo/logo.png" data-light="images/logo/logo.png" data-dark="images/logo/logo-dark.png" data-width="154px" data-height="52px" data-retina="images/logo/logo@2x.png">
                                </a>
                                <div class="button-show-hide">
                                    <i class="icon-menu-left"></i>
                                </div>
                                <div style="padding-left: 60px;">
                                    <h4>Actor management</h4>
                                </div>  
                            </div>
                            <div class="header-grid">
                                <div class="header-item button-dark-light">
                                    <i class="icon-moon"></i>
                                </div>
                                <div class="popup-wrap noti type-header">
                                    <div class="dropdown">
                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                            <span class="header-item">
                                                <span class="text-tiny">1</span>
                                                <i class="icon-bell"></i>
                                            </span>
                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-end has-content" aria-labelledby="dropdownMenuButton1" >
                                            <li>
                                                <h6>Message</h6>
                                            </li>
                                            <li>
                                                <div class="noti-item w-full wg-user active">
                                                    <div class="image">
                                                        <img src="images/avatar/user-12.png" alt="">
                                                    </div>
                                                    <div class="flex-grow">
                                                        <div class="flex items-center justify-between">
                                                            <a href="#" class="body-title">Ralph Edwards</a>
                                                            <div class="time">10:13 PM</div>
                                                        </div>
                                                        <div class="text-tiny">Are you there?  interested i this...</div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li><a href="#" class="tf-button w-full">View all</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="popup-wrap message type-header">
                                    <div class="dropdown">
                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton2" data-bs-toggle="dropdown" aria-expanded="false">
                                            <span class="header-item">
                                                <span class="text-tiny">1</span>
                                                <i class="icon-message-square"></i>
                                            </span>
                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-end has-content" aria-labelledby="dropdownMenuButton2" >
                                            <li>
                                                <h6>Notifications</h6>
                                            </li>
                                            <li>
                                                <div class="message-item item-1">
                                                    <div class="image">
                                                        <i class="icon-noti-1"></i>
                                                    </div>
                                                    <div>
                                                        <div class="body-title-2">Discount available</div>
                                                        <div class="text-tiny">Morbi sapien massa, ultricies at rhoncus at, ullamcorper nec diam</div>
                                                    </div>
                                                </div>
                                            </li>
                                            <li><a href="#" class="tf-button w-full">View all</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="header-item button-zoom-maximize">
                                    <div class="">
                                        <i class="icon-maximize"></i>
                                    </div>
                                </div>
                                <div class="popup-wrap user type-header">
                                    <div class="dropdown">
                                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton3" data-bs-toggle="dropdown" aria-expanded="false">
                                            <span class="header-user wg-user">
                                                <!--Thêm ảnh sesion vào đây nè-->
                                                <span class="image">
                                                    <img src="images/avatar/user-1.png" alt="">
                                                </span>
                                                <span class="flex flex-column">
                                                    <span class="body-title mb-2">Food Heathy Shop</span>
                                                    <span class="text-tiny">Admin</span>
                                                </span>
                                            </span>
                                        </button>
                                        <ul class="dropdown-menu dropdown-menu-end has-content" aria-labelledby="dropdownMenuButton3" >
                                            <li>
                                                <a href="#" class="user-item">
                                                    <div class="icon">
                                                        <i class="icon-user"></i>
                                                    </div>
                                                    <div class="body-title-2">Account</div>
                                                </a>
                                            </li>
                                            <li>
                                                <a href="#" class="user-item">
                                                    <div class="icon">
                                                        <i class="icon-mail"></i>
                                                    </div>
                                                    <div class="body-title-2">Inbox</div>
                                                    <div class="number">27</div>
                                                </a>
                                            </li>

                                            <li>
                                                <a href="setting.html" class="user-item">
                                                    <div class="icon">
                                                        <i class="icon-settings"></i>
                                                    </div>
                                                    <div class="body-title-2">Setting</div>
                                                </a>
                                            </li>

                                            <li>
                                                <a href="login.html" class="user-item">
                                                    <div class="icon">
                                                        <i class="icon-log-out"></i>
                                                    </div>
                                                    <div class="body-title-2">Log out</div>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- /header-dashboard -->
                    <!-- main-content -->
                    <div class="main-content">
                        <!-- main-content-wrap -->
                        <div class="main-content-inner">
                            <!-- main-content-wrap -->
                            <div class="main-content-wrap">
                                <div class="flex items-center flex-wrap justify-between gap20 mb-27">
                                    <h3>Blog Page</h3>
                                    <ul class="breadcrumbs flex items-center flex-wrap justify-start gap10">
                                        <li>
                                            <a href="index.html"><div class="text-tiny">Dashboard</div></a>
                                        </li>
                                        <li>
                                            <i class="icon-chevron-right"></i>
                                        </li>
                                        <li>
                                            <a href="#"><div class="text-tiny">Blog Page</div></a>
                                        </li>
                                        <li>
                                            <i class="icon-chevron-right"></i>
                                        </li>
                                        <li>
                                            <div class="text-tiny">List Blog Page</div>
                                        </li>
                                    </ul>
                                </div>
                                <!-- product-list -->
                                
                                
                                <div class="wg-box">
                                    <div class="title-box">
                                        <i class="icon-coffee"></i>
                                        <div class="body-text">Tip search by Product ID: Each product is provided with a unique ID, which you can rely on to find the exact product you need.</div>
                                    </div>
                                    <div class="flex items-center justify-between gap10 flex-wrap">
                                        <form name="sort" id="searchFilterForm">
                                            <div class="wg-filter flex-grow">

                                                <div class="show">
                                                    <div class="text-tiny">Showing</div>
                                                    <div class="select">
                                                        <select class="">
                                                            <option>10</option>
                                                            <option>20</option>
                                                            <option>30</option>
                                                        </select>
                                                    </div>
                                                    <div class="text-tiny">entries</div>
                                                </div>
                                                <div class="flex gap10">
                                                    <div class="select w200">
                                                        <select class="filter-select" id="statusFilter" name="status">
                                                            <option value="" ${param.status == null || param.status == 'all' ? 'selected' : ''}>Tất cả trạng thái</option>
                                                            <c:forEach var="st" items="${statusList}">
                                                                <option value="${st}" ${param.status == st ? 'selected' : ''}>${st}</option>
                                                            </c:forEach>
                                                        </select> 
                                                    </div>
                                                </div>
                                                <div class="flex gap10">
                                                    <div class="select w200">
                                                        <select class="filter-select" id="BmitypeFilter" name="typebmi">
                                                            <option value="" ${param.bmiID == null ? 'selected' : ''}>All</option>
                                                            <c:forEach var="st" items="${lstBMItype}">
                                                                <option value="${st.bmiID}" ${param.bmiId == st.bmiID ? 'selected' : ''}>${st.classification}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                                <fieldset class="name">
                                                    <input  id="searchInput" type="text" placeholder="Tìm kiếm theo tiêu đề blog..." class="" name="input_search" tabindex="2" value="${param.input_search != null ? param.input_search : ''}" aria-required="true" required="">
                                                </fieldset>
                                                <div class="button-submit">
                                                    <button class="" type="submit"><i class="icon-search"></i></button>
                                                </div>

                                            </div>
                                        </form>
                                        <a class="tf-button style-1 w208" href="createblog"><i class="icon-plus"></i>Add new</a>
                                    </div>
                                    <div class="wg-table table-blog-list">
                                        <!-- Table Header -->
                                        <ul class="table-title mb-14">
                                            <li class="header-row items-center justify-between gap20 flex-grow">
                                                <div class="body-title">Image</div>
                                                <div class="body-title">Blog ID</div>
                                                <div class="body-title">Tiêu đề</div>
                                                <div class="body-title">Trạng thái</div>
                                                <div class="body-title">Cập nhật gần nhất</div>
                                                <div class="body-title">Action</div>
                                            </li>
                                        </ul>

                                        <ul class="table-body">
                                            <!-- Blog Item 1 -->
                                            <c:forEach var="blog" items="${lstB}">
                                                <li class="blog-item items-center justify-between gap20 flex-grow">
                                                    <div class="image no-bg">
                                                        <img src="${blog.imageUlr}" alt="Ảnh blog" style="width: 80px; height: 44px; object-fit: cover;">
                                                    </div>
                                                    <!--                                                    <div class="flex items-center justify-between gap20 flex-grow">-->
                                                    <div class="body-text">${blog.bID}</div>
                                                    <div class="body-text">${blog.title}</div>
                                                    <div>
                                                        <div class="status status-${blog.status}">${blog.status}</div>
                                                    </div>
                                                    <div class="body-text"><fmt:formatDate value="${blog.update_at}" pattern="yyyy-MM-dd HH:mm:ss" /></div>
                                                    <div class="list-icon-function">
                                                        <div class="item eye">
                                                            <a href="blogdetail?id=${blog.bID}" title="View">
                                                                <i class="icon-eye"></i>
                                                            </a>
                                                        </div>
                                                        <div class="item edit">
                                                            <a href="editBlog.do?id=${blog.bID}" title="Edit">
                                                                <i class="icon-edit-3"></i>
                                                            </a>
                                                        </div>
                                                        <div class="item trash">
                                                            <a href="#" title="Delete"
                                                               onclick="showDeletePopup('deleteblog?id=${blog.bID}', '${blog.title}'); return false;">
                                                                <i class="icon-trash-2" style="color: red"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                    <!--                                                    </div>-->
                                                </li>
                                            </c:forEach>

                                        </ul> 

                                        <!-- Table Body -->

                                    </div>

                                    <div class="divider"></div>

                                    <div class="flex items-center justify-between flex-wrap gap10" style="padding: 10px;">
                                        <div class="text-tiny">Show ${lstB.size()} of ${totalBlog} items</div>

                                        <c:if test="${totalPages > 1}">
                                            <ul class="wg-pagination flex items-center gap5">

                                                <c:if test="${currentPage > 1}">
                                                    <li>
                                                        <a href="#" class="pagination-link" data-page="${currentPage - 1}">
                                                            <i class="icon-chevron-left"></i>
                                                        </a>
                                                    </li>
                                                </c:if>


                                                <c:forEach var="i" begin="1" end="${totalPages}" varStatus="status">
                                                    <c:choose>

                                                        <c:when test="${i == currentPage}">
                                                            <li class="active">
                                                                <a href="#" class="pagination-link" data-page="${i}">${i}</a>
                                                            </li>
                                                        </c:when>


                                                        <c:when test="${i <= currentPage + 2 && i >= currentPage - 2}">
                                                            <li>
                                                                <a href="#" class="pagination-link" data-page="${i}">${i}</a>
                                                            </li>
                                                        </c:when>


                                                        <c:when test="${i == currentPage - 3 || i == currentPage + 3}">
                                                            <li><span class="ellipsis">...</span></li>
                                                            </c:when>
                                                        </c:choose>
                                                    </c:forEach>


                                                <c:if test="${currentPage < totalPages}">
                                                    <li>
                                                        <a href="#" class="pagination-link" data-page="${currentPage + 1}">
                                                            <i class="icon-chevron-right"></i>
                                                        </a>
                                                    </li>
                                                </c:if>
                                            </ul>
                                        </c:if>
                                    </div>

                                </div>
                                        
                                <!-- /product-list -->
                            </div>
                            <!-- /countries -->
                        </div>
                    </div>
                    <!-- /main-content-wrap -->
                </div>
                <!-- /main-content-wrap -->
                <!-- bottom-page -->
                <div class="bottom-page">
                    <div class="body-text">Copyright © 2025 Heathy Food Dev Team. Design with</div>
                    <i class="icon-heart"></i>
                    <div class="body-text">by G4_SE1921</a> All rights reserved.</div>
                </div>
                <!-- /bottom-page -->
            </div>
            <!-- /main-content -->
        </div>
        <!-- /section-content-right -->
    </div>
    <!-- /layout-wrap -->
</div>
<!-- /#page -->
</div>
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
<!-- /#wrapper -->
<!-- Javascript -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/bootstrap-select.min.js"></script>
<script src="../js/zoom.js"></script>
<script src="../js/apexcharts/apexcharts.js"></script>
<script src="../js/apexcharts/line-chart-1.js"></script>
<script src="../js/apexcharts/line-chart-2.js"></script>
<script src="../js/apexcharts/line-chart-3.js"></script>
<script src="../js/apexcharts/line-chart-4.js"></script>
<script src="../js/apexcharts/line-chart-5.js"></script>
<script src="../js/apexcharts/line-chart-6.js"></script>
<script src="../js/switcher.js"></script>
<script src="../js/theme-settings.js"></script>
<script src="../js/main.js"></script>
<script src="../js/Nutritionist/home.js"></script>
<script src="../js/Nutritionist/blog.js"></script>
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
<script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

</body>


<!-- Mirrored from themesflat.co/html/remos/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 26 May 2025 09:44:12 GMT -->
</html>

