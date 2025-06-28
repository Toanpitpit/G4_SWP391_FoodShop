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
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&family=Rubik:wght@500&family=Nunito:wght@600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/dashboard.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">
    </head>
    <body>
        <!-- Sidebar -->
        <jsp:include page="/Nutritionist/nav.jsp"/>  
        <!-- Main Header -->
        <jsp:include page="/Nutritionist/main-header.jsp"/>  

        <!-- Main Content -->
        <main class="main-content" id="mainContent">
            <!-- Breadcrumb Section -->
            <div class="breadcrumb-section">
                <div class="breadcrumb-container">
                    <h1 class="page-title" style="padding-left: 32px">Welcome to Nutritionist Admin Dashboard</h1>
                    <nav class="breadcrumb-nav">
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Home</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <span class="breadcrumb-item active">Dashboard</span>
                    </nav>
                </div>
            </div>

            <!-- Content Wrapper -->
            <div class="content-wrapper">
                <div class="content-card">
                    <div class="row mb-4">
                        <div class="col-12">
                            <p class="text-muted">Manage your task store with powerful tools and analytics.</p>
                        </div>
                    </div>

                    <!-- Stats Cards -->
                    <div class="row mb-4">
                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body">
                                    <a href="${pageContext.request.contextPath}/nutricontrol?action=showfooddraft">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0">
                                                <div class="bg-primary bg-gradient text-white rounded-3 p-3">
                                                    <i class="bi bi-lightbulb-fill fs-4"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h6 class="text-muted mb-1">Food Suggestion</h6>
                                                <h3 class="mb-0">${totalFdrf}</h3>
                                                <small class="text-success">
                                                    <i class="bi bi-arrow-up"></i> +12% from last month
                                                </small>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body">
                                    <a href="${pageContext.request.contextPath}/nutricontrol?action=displayblog">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0">
                                                <div class="bg-success bg-gradient text-white rounded-3 p-3">
                                                    <i class="bi bi-journal-text"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h6 class="text-muted mb-1">Blogs Post</h6>
                                                <h3 class="mb-0">${totalBlog}</h3>
                                                <small class="text-success">+3 new from last month</small>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <div class="bg-info bg-gradient text-white rounded-3 p-3">
                                                <i class="bi bi-envelope-paper-fill fs-4"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="text-muted mb-1">Your Request</h6>
                                            <h3 class="mb-0">${totalRequest}</h3>
                                            <small class="text-success">
                                                <i class="bi bi-arrow-up"></i> +3 from last week
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-3 col-md-6 mb-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body">
                                    <div class="d-flex align-items-center">
                                        <div class="flex-shrink-0">
                                            <div class="bg-warning bg-gradient text-white rounded-3 p-3">
                                                <i class="bi bi-box-seam fs-4"></i>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1 ms-3">
                                            <h6 class="text-muted mb-1">Products</h6>
                                            <h3 class="mb-0">${totalFood}</h3>
                                            <small class="text-danger">
                                                <i class="bi bi-arrow-up"></i> 3 new from last month
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>                          
                <!-- Charts Section -->
                <div class="container-fluid">
                    <!-- Row 1 -->
                    <div class="row mb-4 flex-nowrap overflow-auto " style="height: 400px;">
                        <!-- Cột 1 -->
                        <div class="col-md-6">
                            <div class="h-100 border rounded p-3">
                                <div class="d-flex" style="height: 100%;">
                                    <!-- Biểu đồ -->
                                    <div class="flex-fill me-3">
                                        <canvas id="pieChart"
                                                data-labels='${pieChart_data_labelsJson}'
                                                data-counts='${pieChart_data_totalsJson}'
                                                style="max-height: 300px; width: 300px;">
                                        </canvas>
                                    </div>

                                    <!-- Thống kê -->
                                    <div class="flex-fill overflow-auto">
                                        <h5>Thống kê theo trạng thái</h5>
                                        <ul class="legend-list">
                                            <c:set var="colorString" value="rgba(255,205,86,0.8)|rgba(75,192,192,0.8)|rgba(255,99,132,0.8)|rgba(153,102,255,0.8)" />
                                            <c:set var="backgroundColors" value="${fn:split(colorString, '|')}" />
                                            <c:forEach var="i" begin="0" end="${fn:length(pieChart_data_labels) - 1}">
                                                <li>
                                                    <span class="legend-color-box" style="background-color: ${backgroundColors[i]};"></span>
                                                    <span class="legend-label">${pieChart_data_labels[i]}</span>
                                                    <span class="legend-value">${pieChart_data_totals[i]}</span>
                                                </li>
                                            </c:forEach>
                                            <li>
                                                <span class="legend-color-box" style="background-color: #6B21A8;"></span>
                                                <span class="legend-label">Total</span>
                                                <span class="legend-value">${totalRequest}</span>
                                            </li>
                                        </ul>
                                         <div class="chart-name">Biểu đồ: Số Requests theo trạng thái</div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Cột 2 -->
                        <div class="col-md-6">
                            <div class="h-100 border rounded p-3">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h5 class="mb-0">Blogs Per Month</h5>
                                    <div class="d-flex align-items-center">
                                        <label for="yearDropdown" class="me-2 mb-0">Year:</label>
                                        <select id="yearDropdown" name="year" class="form-select form-select-sm w-auto">
                                            <c:forEach var="year" items="${years}">
                                                <option value="${year}" ${year == selectedYear ? 'selected' : ''}>${year}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <canvas id="barChart"
                                        data-labels='${barChart_data_labelsJson}'
                                        data-counts='${barChart_data_totalsJson}'
                                        height="300px" with="500px">
                                </canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Row 2 -->
                    <div class="row" style="height: 400px;">
                        <div class="col-md-6">
                            <div class="h-100 border rounded p-3">
                                <!-- Nội dung cột 1 hàng 2 -->
                                <h5>Biểu đồ / Số lượng Food_Sugesstion theo tháng</h5>
                                <canvas id="foodDraftLineChart"></canvas>
                                
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="h-100 border rounded p-3">
                                <!-- Nội dung cột 2 hàng 2 -->
                                <h5>Biểu đồ / Nội dung 4</h5>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <jsp:include page="/Nutritionist/footer.jsp"/>  
        </main>


        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0"></script>
  
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/common.js"></script>
       
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/home.js"></script>
<!--        <script>
            console.log('Page loaded, checking data availability...');
            console.log(document.getElementById('pieChart')); // phải != null
console.log(document.getElementById('barChart')); // phải != null

            console.log('Pie chart labels:', '${pieChart_data_labelsJson}');
            console.log('Pie chart totals:', '${pieChart_data_totalsJson}');
            console.log('Bar chart labels:', '${barChart_data_labelsJson}');
            console.log('Bar chart totals:', '${barChart_data_totalsJson}');
        </script>-->
    </body>
    

</html>
