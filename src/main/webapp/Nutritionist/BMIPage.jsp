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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/common.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">
        <style>
            /* CSS Variables */
            :root {
                --primary-green: #47B77B;
                --gradient-hover: linear-gradient(135deg, var(--primary-green), #3b82f6);
                --green: #2ecc71;
                --black1: #1e1e1e;
                --black2: #666;
                --white: #ffffff;
            }
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                flex-wrap: wrap;
            }

            .pagination a,
            .pagination span {
                padding: 5px 8px;
                border-radius: 8px;
                text-decoration: none;
                color: var(--white);
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
                border: 1px solid #e9ecef;
                transition: all 0.3s ease;
                font-weight: 300;
            }

            .pagination a:hover {
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
                color: var(--white);
                transform: translateY(-2px);
            }

            .pagination .current {
                background: var(--green);
                color: var(--white);
                border-color: var(--green);
            }

            .pagination .ellipsis {
                border: none;
                background: transparent;
                color: var(--black2);
            }
            .pagination a, .pagination span {
                border: 1px solid #ddd;
                text-decoration: none;
                color: #333;
            }

            .pagination a:hover {
                background-color: #f5f5f5;
            }

            .pagination .current {
                background-color: #4CAF50;
                color: white;
                border-color: #4CAF50;
            }
            /* Container chính */
            .tab-pane {
                background: #ffffff;
                border-radius: 12px;
                padding: 0;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
                margin: 1rem 0;
                overflow: hidden;
            }

            /* Header với tiêu đề */
            .sub-title {
                font-size: 1.4rem;
                font-weight: 600;
                color: #2d3748;
                margin: 0;
                padding: 1.5rem 2rem;
                background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
                border-bottom: 1px solid #e2e8f0;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .sub-title .f-right {
                color: #718096;
                font-size: 1.1rem;
                text-decoration: none;
                padding: 0.5rem;
                border-radius: 6px;
                transition: all 0.2s ease;
            }

            .sub-title .f-right:hover {
                color: #4a5568;
                background: rgba(113, 128, 150, 0.1);
            }

            /* Content area */
            .tab-content {
                padding: 2rem;
            }

            /* Controls section */
            .content-controls {
                margin-bottom: 2rem;
            }

            .search-filter-container {
                display: flex;
                flex-wrap: wrap;
                gap: 0.75rem;
                align-items: center;
                background: #f8fafc;
                padding: 1.25rem;
                border-radius: 10px;
                border: 1px solid #e2e8f0;
            }

            /* Search box với tooltip - compact version */
            .search-box-with-tip {
                flex: 1;
                min-width: 280px;
                max-width: 400px;
            }

            .search-box {
                display: flex;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }

            .search-input {
                flex: 1;
                padding: 0.625rem 0.875rem;
                border: 2px solid #e2e8f0;
                border-right: none;
                font-size: 0.875rem;
                outline: none;
                background: #ffffff;
                transition: border-color 0.2s ease;
            }

            .search-input:focus {
                border-color: var(--primary-green);
            }

            .search-button {
                padding: 0.625rem 1rem;
                background: var(--primary-green);
                border: 2px solid var(--primary-green);
                color: white;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .search-button i {
                color:  #fcf3f3;
            }



            .tooltip-text {
                color: #718096;
                font-size: 0.7rem;
                line-height: 1.3;
                display: block;
                margin-top: 0.25rem;
                position: absolute;
                background: #2d3748;
                color: white;
                padding: 0.5rem;
                border-radius: 6px;
                font-size: 0.75rem;
                opacity: 0;
                visibility: hidden;
                transition: all 0.2s ease;
                z-index: 10;
                max-width: 280px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            }

            .search-box-with-tip:hover .tooltip-text {
                opacity: 1;
                visibility: visible;
                transform: translateY(5px);
            }

            /* Filters - compact size */
            .filter-select,
            .filter-input {
                padding: 0.625rem 0.75rem;
                border: 2px solid #e2e8f0;
                border-radius: 8px;
                font-size: 0.85rem;
                outline: none;
                background: #ffffff;
                transition: all 0.3s ease;
                color: #4a5568;
                min-width: 120px;
            }

            .filter-select:focus,
            .filter-input:focus {
                border-color: var(--primary-green);
                box-shadow: 0 0 0 3px rgba(71, 183, 123, 0.1);
            }

            .filter-select:hover,
            .filter-input:hover {
                border-color: var(--primary-green);
            }

            .filter-input {
                width: 80px;
            }

            /* Filter button - compact */
            .filter-button {
                padding: 0.625rem 1.25rem;
                background: var(--primary-green);
                border: none;
                border-radius: 8px;
                color: white;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 0.375rem;
                white-space: nowrap;
                font-size: 0.85rem;
            }

            .filter-button:hover {
                background: var(--gradient-hover);
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(71, 183, 123, 0.3);
            }

            .filter-button i {
                font-size: 0.8rem;
            }

            /* Reset button - compact */
            .reset-button {
                padding: 0.625rem 1rem;
                background: #e2e8f0;
                border: none;
                border-radius: 8px;
                color: #4a5568;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                font-size: 0.85rem;
            }

            .reset-button:hover {
                background: var(--gradient-hover);
                color: white;
                transform: translateY(-1px);
            }

            /* Table styling */
            .table {
                background: #ffffff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                border: 1px solid #e2e8f0;
                margin: 0;
            }

            .table thead {
                background: linear-gradient(135deg, #4a5568 0%, #2d3748 100%);
            }

            .table thead th {
                color:#160404;
                font-weight: 600;
                padding: 1rem 1.25rem;
                border: none;
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                white-space: nowrap;
            }

            .table tbody tr {
                transition: all 0.15s ease;
                border-bottom: 1px solid #f7fafc;
            }

            .table tbody tr:hover {
                background: #f8fafc;
            }

            .table tbody tr:last-child {
                border-bottom: none;
            }

            .table tbody td {
                padding: 1rem 1.25rem;
                vertical-align: middle;
                border: none;
                color: #4a5568;
                font-size: 0.9rem;
            }

            .table tbody td:first-child {
                font-weight: 600;
                color: #2d3748;
                background: rgba(247, 250, 252, 0.5);
            }

            /* Action buttons trong table */
            .action-buttons {
                display: flex;
                gap: 0.375rem;
            }

            .btn-action {
                padding: 0.25rem 0.5rem;
                border: none;
                border-radius: 6px;
                font-size: 0.75rem;
                cursor: pointer;
                transition: all 0.3s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
            }

            .btn-edit {
                background: var(--primary-green);
                color: white;
            }

            .btn-edit:hover {
                background: var(--gradient-hover);
                transform: translateY(-1px);
                box-shadow: 0 2px 8px rgba(71, 183, 123, 0.3);
            }

            .btn-delete {
                background: #f56565;
                color: white;
            }

            .btn-delete:hover {
                background: linear-gradient(135deg, #f56565, #e53e3e);
                transform: translateY(-1px);
                box-shadow: 0 2px 8px rgba(245, 101, 101, 0.3);
            }

            /* Responsive design - optimized for single row */
            @media (max-width: 1400px) {
                .search-filter-container {
                    gap: 0.5rem;
                }

                .filter-input {
                    width: 70px;
                }

                .filter-select {
                    min-width: 100px;
                }
            }

            @media (max-width: 1200px) {
                .search-filter-container {
                    flex-wrap: wrap;
                }

                .search-box-with-tip {
                    min-width: 250px;
                    flex: 1;
                }

                .filter-input {
                    width: 65px;
                }

                .filter-select {
                    min-width: 90px;
                }
            }

            @media (max-width: 992px) {
                .search-filter-container {
                    display: grid;
                    grid-template-columns: 1fr 1fr;
                    gap: 0.75rem;
                }

                .search-box-with-tip {
                    grid-column: 1 / -1;
                    min-width: 100%;
                }

                .filter-button,
                .reset-button {
                    grid-column: 1 / -1;
                    justify-content: center;
                }
            }

            @media (max-width: 768px) {
                .tab-content {
                    padding: 1rem;
                }

                .sub-title {
                    padding: 1rem 1.5rem;
                    font-size: 1.2rem;
                }

                .search-filter-container {
                    grid-template-columns: 1fr;
                    padding: 1rem;
                }

                .search-box-with-tip,
                .filter-select,
                .filter-input,
                .filter-button,
                .reset-button {
                    grid-column: 1;
                }

                .table {
                    font-size: 0.8rem;
                }

                .table thead th,
                .table tbody td {
                    padding: 0.75rem 0.5rem;
                }

                .action-buttons {
                    flex-direction: column;
                    gap: 0.25rem;
                }
            }

            /* Loading state */
            .loading {
                opacity: 0.6;
                pointer-events: none;
                position: relative;
            }

            .loading::after {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 20px;
                height: 20px;
                margin: -10px 0 0 -10px;
                border: 2px solid #e2e8f0;
                border-top-color: #4299e1;
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                to {
                    transform: rotate(360deg);
                }
            }

            /* Empty state */
            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                background: #ffffff;
                border: 1px solid #e2e8f0;
                border-radius: 10px;
                margin-top: 1rem;
            }

            .empty-state-icon {
                font-size: 4rem;
                margin-bottom: 1.5rem;
                color: #cbd5e0;
                display: block;
            }

            .empty-state-title {
                font-size: 1.25rem;
                font-weight: 600;
                margin-bottom: 0.75rem;
                color: #4a5568;
            }

            .empty-state-description {
                font-size: 0.95rem;
                color: #718096;
                margin-bottom: 2rem;
                line-height: 1.5;
            }

            .empty-state-actions {
                display: flex;
                gap: 1rem;
                justify-content: center;
                flex-wrap: wrap;
            }

            .empty-state-btn {
                padding: 0.75rem 1.5rem;
                border-radius: 8px;
                font-weight: 500;
                text-decoration: none;
                transition: all 0.2s ease;
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
            }

            .empty-state-btn-primary {
                background: var(--primary-green);
                color: white;
                border: 2px solid var(--primary-green);
            }

            .empty-state-btn-primary:hover {
                background: var(--gradient-hover);
                border-image: var(--gradient-hover) 1;
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(71, 183, 123, 0.3);
            }

            .empty-state-btn-secondary {
                background: transparent;
                color: #4a5568;
                border: 2px solid #e2e8f0;
            }

            .empty-state-btn-secondary:hover {
                background: #f8fafc;
                border-color: #cbd5e0;
            }

            /* Animation cho empty state */
            .empty-state {
                animation: fadeInUp 0.5s ease-out;
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Responsive cho empty state */
            @media (max-width: 768px) {
                .empty-state {
                    padding: 3rem 1.5rem;
                }

                .empty-state-icon {
                    font-size: 3rem;
                    margin-bottom: 1rem;
                }

                .empty-state-title {
                    font-size: 1.1rem;
                }

                .empty-state-actions {
                    flex-direction: column;
                    align-items: center;
                }

                .empty-state-btn {
                    width: 100%;
                    max-width: 200px;
                    justify-content: center;
                }
            }

            /* Pagination */
            .pagination-wrapper {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem 2rem;
                background: #f8fafc;
                border-top: 1px solid #e2e8f0;
                border-radius: 0 0 12px 12px;
            }

            .pagination-info {
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
                color: #718096;
                font-size: 0.9rem;
            }

            .pagination {
                display: flex;
                gap: 0.25rem;
            }

            .pagination .page-link {
                padding: 0.5rem 0.75rem;
                border: 1px solid #e2e8f0;
                border-radius: 6px;
                color: #4a5568;
                text-decoration: none;
                transition: all 0.2s ease;
            }


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
                    <h1 class="page-title" style="padding-left: 32px">BMI Management – Danh Mục chuyên sâu</h1>
                    <nav class="breadcrumb-nav">
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Home</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=displayblog" class="breadcrumb-item">BMI</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <span class="breadcrumb-item active">BMI</span>
                    </nav>
                </div>
            </div>
            <div class="content-wrapper">
                <ul class="nav nav-tabs" id="myTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="list-tab" data-toggle="tab" href="#list" role="tab">Danh sách</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="create-tab" data-toggle="tab" href="#create" role="tab">Thêm mới</a>
                    </li>
                </ul>
                <!--                    <div class="tab-pane fade show active" id="list" role="tabpanel">
                                        <div class="sub-title mt-3">
                                            Danh sách BMI
                                            <a href="#" class="f-right" data-toggle="modal" data-target="#default-tab-Modal">
                                                <i class="icofont icofont-code-alt"></i>
                                            </a>
                                        </div>
                                        <div class="tab-content" id="myTabContent">
                                        <div class="content-controls">
                                            <form name="sort" id="searchFilterForm">
                                                <div class="search-filter-container">
                                                     Tìm kiếm 
                                                    <div class="search-box-with-tip">
                                                        <div class="search-box">
                                                            <input type="text" name="input_search"
                                                                   class="search-input" 
                                                                   placeholder="Tìm kiếm..." 
                                                                   id="searchInput"
                                                                   value="">
                                                            <button type="submit" class="search-button">
                                                                <i class="fas fa-search"></i>
                                                            </button>
                                                        </div>
                                                        <small class="tooltip-text">
                                                            Dùng <strong>#</strong> để tìm theo ID, <strong>%</strong> theo Classification.<br>
                                                            Mặc định tìm theo Taget Audience. Cú pháp vd #12 , %Béo , Người gầy lưu ý viết liền
                                                        </small>
                                                    </div>
                                                    <select class="filter-select" id="statusFilter" name="status">
                                                        <option value="">Tất cả trạng thái</option>
                                                    </select>
                                                    <select class="filter-select" id="BmitypeFilter" name="typebmi">
                                                        <option value="">Tất cả loại BMI</option>
                                                    </select>
                                                    <input type="number" name="id_from" class="filter-input" placeholder="ID từ">
                                                    <input type="number" name="id_to" class="filter-input" placeholder="ID đến">
                                                    <select class="filter-select" name="sortOrder">
                                                        <option value="">Sắp xếp theo ID</option>
                                                        <option value="asc">Tăng dần</option>
                                                        <option value="desc">Giảm dần</option>
                                                    </select>
                                                </div>
                                            </form>
                                        </div>
                                            
                                        <table class="table table-bordered mt-3">
                                            <thead>
                                                <tr>
                                                    <th>#
                                                    <th>ID</th>
                                                    <th>Classification</th>
                                                    <th>Rank</th>
                                                    <th>Decription</th>
                                                    <th>Taget Audience</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                <c:forEach var="bi" items="${lstsBMI}" varStatus="loop">
                    <tr>
                        <td>#${loop.index + 1}</td> 
                        <td>${bi.bmiID}</td> 
                        <td>${bi.classification}</td>
                        <td>${bi.bmiRange}</td>
                        <td>${bi.decription}</td>
                        <td>${bi.tagetAudience}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
            
        </div>
    </div>-->
                <div class="tab-pane fade show active" id="list" role="tabpanel">
                    <div class="sub-title mt-3">
                        Danh sách BMI
                        <a href="#" class="f-right" data-toggle="modal" data-target="#default-tab-Modal">
                            <i class="icofont icofont-code-alt"></i>
                        </a>
                    </div>
                    <div class="tab-content" id="myTabContent">
                        <div class="content-controls">
                            <form name="sort" id="searchFilterForm" method="get" action="nutricontrol">
                                <input type="hidden" name="action" value="displayBMI"/>
                                <input type="hidden" name="page" id="pageInput" value="${currentPage}"/>
                                <div class="search-filter-container">
                                    <!-- Giới hạn mỗi trang -->
                                    <select class="filter-select" name="limitpage">
                                        <option value="5" ${param.limitpage == '5' ? 'selected' : ''}>5</option>
                                        <option value="10" ${param.limitpage == '10' ? 'selected' : ''}>10</option>
                                        <option value="20" ${param.limitpage == '20' ? 'selected' : ''}>20</option>
                                    </select>

                                    <!-- Ô tìm kiếm -->
                                    <input type="text" name="search" class="search-input"
                                           placeholder="Tìm kiếm..."
                                           value="${search}"/>

                                    <!-- Sort theo Target -->
                                    <select class="filter-select" name="sortOrderTarget">
                                        <option value="" ${empty sortOrderTarget ? 'selected' : ''}>Sắp xếp theo Target</option>
                                        <option value="asc" ${sortOrderTarget == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                        <option value="desc" ${sortOrderTarget == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                    </select>

                                    <!-- Sort theo ID -->
                                    <select class="filter-select" name="sortOrderID">
                                        <option value="" ${empty sortOrderID ? 'selected' : ''}>Sắp xếp theo ID</option>
                                        <option value="asc" ${sortOrderID == 'asc' ? 'selected' : ''}>Tăng dần</option>
                                        <option value="desc" ${sortOrderID == 'desc' ? 'selected' : ''}>Giảm dần</option>
                                    </select>

                                    <button type="submit" class="filter-button">
                                        <i class="fas fa-filter"></i> Lọc
                                    </button>
                                    <button type="button" class="reset-button" onclick="window.location.href = 'nutricontrol?action=displayBMI'">
                                        <i class="fas fa-undo"></i> Reset
                                    </button>
                                </div>
                            </form>


                        </div>
                        <c:choose>
                            <c:when test="${not empty lstBMI}">
                                <table class="table table-bordered mt-3">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>ID</th>
                                            <th>Classification</th>
                                            <th>Range</th>
                                            <th>Description</th>
                                            <th>Target Audience</th>
                                            <!--                                            <th>Actions</th>-->
                                        </tr>
                                    </thead>
                                    <tbody id="blogTableBody">
                                        <c:forEach var="bi" items="${lstBMI}" varStatus="loop">
                                            <tr>
                                                <td>#${loop.index + 1}</td> 
                                                <td>${bi.bmiID}</td> 
                                                <td>${bi.classification}</td>
                                                <td>${bi.bmiRange}</td>
                                                <td>${bi.decription}</td>
                                                <td>${bi.tagetAudience}</td>
                                                <!--                                                <td>
                                                                                                    <div class="action-buttons">
                                                                                                        <a href="#" class="btn-action btn-edit" onclick="editBMI(${bi.bmiID})">
                                                                                                            <i class="fas fa-edit"></i> Sửa * 
                                                                                                        </a>
                                                                                                        <button class="btn-action btn-delete" onclick="deleteBMI(${bi.bmiID})">
                                                                                                            <i class="fas fa-trash"></i> Xóa * 
                                                                                                        </button>
                                                                                                    </div>
                                                                                                </td>-->
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <c:if test="${totalPages >= 1}">
                                    <div class="pagination">
                                        <c:if test="${currentPage > 1}">
                                            <a href="#" onclick="goToPage(${currentPage - 1})">&laquo; Trước</a>
                                        </c:if>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <c:choose>
                                                <c:when test="${i == currentPage}">
                                                    <span class="current">${i}</span>
                                                </c:when>
                                                <c:when test="${i <= currentPage + 2 && i >= currentPage - 2}">
                                                    <a href="#" onclick="goToPage(${i})">${i}</a>
                                                </c:when>
                                                <c:when test="${i == currentPage - 3 || i == currentPage + 3}">
                                                    <span class="ellipsis">...</span>
                                                </c:when>
                                            </c:choose>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <a href="#" onclick="goToPage(${currentPage + 1})">Sau &raquo;</a>
                                        </c:if>
                                    </div>
                                </c:if>

                                <script>
                                    function goToPage(page) {
                                        document.getElementById("pageInput").value = page;
                                        document.getElementById("searchFilterForm").submit();
                                    }
                                </script>

                            </c:when>
                            <c:otherwise>
                                <!-- Empty State - Hiển thị khi không có dữ liệu -->
                                <div class="empty-state">
                                    <i class="fas fa-inbox empty-state-icon"></i>
                                    <h3 class="empty-state-title">Không có dữ liệu BMI</h3>
                                    <p class="empty-state-description">
                                        Hiện tại chưa có thông tin BMI nào trong hệ thống.<br>
                                        Hãy thêm mới hoặc kiểm tra lại điều kiện lọc của bạn.
                                    </p>
                                    <div class="empty-state-actions">
                                        <a href="#" class="empty-state-btn empty-state-btn-primary" onclick="showAddModal()">
                                            <i class="fas fa-plus"></i> Thêm BMI mới
                                        </a>
                                        <button class="empty-state-btn empty-state-btn-secondary" onclick="resetAllFilters()">
                                            <i class="fas fa-refresh"></i> Làm mới dữ liệu
                                        </button>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="tab-pane fade" id="create" role="tabpanel">
                    <div class="sub-title mt-3">
                        Thêm mới BMI
                        <a href="#" class="f-right" data-toggle="modal" data-target="#default-tab-Modal">
                            <i class="icofont icofont-code-alt"></i>
                        </a>
                    </div>

                    <!-- Form Create -->
                    <form class="mt-3">
                        <div class="form-group">
                            <label for="classification">Classification</label>
                            <input type="text" class="form-control" id="classification" placeholder="Nhập classification">
                        </div>
                        <div class="form-group">
                            <label for="rank">Rank</label>
                            <input type="number" class="form-control" id="rank" placeholder="Nhập rank">
                        </div>
                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea class="form-control" id="description" rows="3" placeholder="Mô tả"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Tạo mới</button>
                    </form>
                </div>
            </div>

            <jsp:include page="/Nutritionist/footer.jsp"/>  
        </main>


        <script>
            window.contextPath = '${pageContext.request.contextPath}';
        </script>
        <script src="../JS/Nutritionist/common.js"></script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/BMI.js"></script>
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>

    </body>
</html>
