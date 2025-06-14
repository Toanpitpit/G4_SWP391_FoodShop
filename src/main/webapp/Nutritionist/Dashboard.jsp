
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                                                <a href="listblog" class="">
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
                                <div class="dashboardCardBox">
                                    <a href="listblog">
                                        <div class="dashboardCard">
                                            <div>
                                                <div class="dashboardNumbers">${totalBlog}</div>
                                                <div class="dashboardCardName">Total Blogs</div>
                                            </div>
                                            <div class="dashboardIconBx">
                                                <ion-icon name="document-text-outline"></ion-icon>
                                            </div>
                                        </div>
                                    </a>
                                    <a href="">
                                        <div class="dashboardCard">
                                            <div>
                                                <div class="dashboardNumbers">${totalFdrf}</div>
                                                <div class="dashboardCardName">Your Food draft</div>
                                            </div> 
                                            <div class="dashboardIconBx">
                                                <ion-icon name="create-outline"></ion-icon>
                                            </div>
                                        </div>
                                    </a>
                                    <a href="">
                                        <div class="dashboardCard">
                                            <div>
                                                <div class="dashboardNumbers">${totalRequest}</div>
                                                <div class="dashboardCardName">Your Request</div>
                                            </div>
                                            <div class="dashboardIconBx">
                                                <ion-icon name="paper-plane-outline"></ion-icon>
                                            </div>
                                        </div>
                                    </a>
                                    <a href="">
                                        <div class="dashboardCard">
                                            <div>
                                                <div class="dashboardNumbers">${totalNotify}</div>
                                                <div class="dashboardCardName">Notify</div>
                                            </div>
                                            <div class="dashboardIconBx">
                                                <ion-icon name="notifications-outline"></ion-icon>
                                            </div>
                                        </div> 
                                    </a>
                                </div>

                                <div class="charts-grid">
                                    <div class="chart-card">
                                        <h3>Request Status</h3>
                                        <div class="chart-container">
                                            <canvas id="pieChart"
                                                    data-labels='${pieChart_data_labelsJson}'
                                                    data-counts='${pieChart_data_totalsJson}'>
                                            </canvas>
                                            <div class="status-legend">
                                                <h3>Thống kê theo trạng thái</h3>
                                                <ul class="legend-list">
                                                    <c:set var="backgroundColors" value="${['rgba(255, 205, 86, 0.8)', 'rgba(75, 192, 192, 0.8)', 'rgba(255, 99, 132, 0.8)', 'rgba(153, 102, 255, 0.8)']}" />

                                                    <c:forEach var="i" begin="0" end="${fn:length(pieChart_data_lables) - 1}">
                                                        <li>
                                                            <span class="legend-color-box" style="background-color: ${backgroundColors[i]};"></span>
                                                            <span class="legend-label">${pieChart_data_lables[i]}</span>
                                                            <span class="legend-value">${pieChart_data_totals[i]}</span>
                                                        </li>
                                                    </c:forEach>

                                                    <li>
                                                        <span class="legend-color-box" style="background-color: #6B21A8;;"></span>
                                                        <span class="legend-label">Total</span>
                                                        <span class="legend-value">${totalRequest}</span>
                                                    </li>
                                                </ul>
                                                <div class="chart-name">Biểu đồ: Số Requests theo trạng thái</div>
                                            </div>
                                        </div>
                                    </div>
                                    <script>
                                        window.contextPath = '${pageContext.request.contextPath}';
                                    </script>

                                    <div class="chart-card">
                                        <div class="custom-chart-header">
                                            <h3>Blogs Per Month</h3>
                                            

                                            <select class="custom-chart-header-select" id="yearDropdown" name="year">
                                                <label class="custom-chart-header-label"  for="yearDropdown">Select Year:</label>
                                                <c:forEach var="year" items="${years}">
                                                    <option value="${year}" ${year == selectedYear ? 'selected' : ''}>${year}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="chart-container">
                                            <canvas id="barChart"
                                                    data-labels='${barChart_data_lablesJson}'
                                                    data-counts='${barChart_data_totalsJson}'>
                                            </canvas>
                                        </div>
                                    </div>

                                </div>

                                <!-- ================= New Customers ================ -->
                                <div class="charts-grid-bottom">
                                    <div class="chart-card">
                                        <h3>Food Draft Trend</h3>
                                        <div class="chart-container">
                                            <canvas id="lineChart"
                                                    data-labels='["Week 1", "Week 2", "Week 3", "Week 4"]'
                                                    data-counts='[2, 4, 5, 3]'>
                                            </canvas>
                                        </div>
                                    </div>
                                    <!-- Recent Notifications -->
                                    <div class="notifications">
                                        <h3>Recent Notifications</h3>
                                        <div class="notification-item">
                                            <div class="notification-icon success">
                                                <ion-icon name="checkmark-circle-outline"></ion-icon>
                                            </div>
                                            <div class="notification-text">
                                                <p>Request #102 was approved</p>
                                                <small>5 mins ago</small>
                                            </div>
                                        </div>
                                    </div>
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
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

</body>


<!-- Mirrored from themesflat.co/html/remos/index.html by HTTrack Website Copier/3.x [XR&CO'2014], Mon, 26 May 2025 09:44:12 GMT -->
</html>

