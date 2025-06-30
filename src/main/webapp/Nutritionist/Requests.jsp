<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&family=Rubik:wght@500&family=Nunito:wght@600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/foodlist.css">
         <style>
            .request-content {
                padding: 24px;
                background-color: #f4f7f9; 
            }

            .request-content .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 24px;
                flex-wrap: wrap; 
                gap: 16px;
            }

            .request-content .page-header .page-title {
                margin: 0;
                font-size: 1.75rem; 
                font-weight: 700;
                color: #2c3e50; 
            }

            .request-content .page-header .breadcrumb {
                list-style: none;
                padding: 8px 16px;
                margin: 0;
                background-color: #ffffff;
                border-radius: 6px;
                font-size: 0.9rem;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            }

            .request-content .page-header .breadcrumb li {
                display: inline;
            }

            .request-content .page-header .breadcrumb li a {
                color: #3498db; 
                text-decoration: none;
                transition: color 0.2s ease;
            }

            .request-content .page-header .breadcrumb li a:hover {
                color: #2980b9;
            }

            .request-content .page-header .breadcrumb li::after {
                content: '›'; 
                margin: 0 8px;
                color: #95a5a6;
            }

            .request-content .page-header .breadcrumb li:last-child::after {
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
            .action-btn.cancel-btn {
                background-color: #6c757d; 
            }
.action-btn.edit-btn:hover {
    background-color: #e67e22;
}
.action-btn.cancel-btn:hover {
                background-color: #6c757e;
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
                .request-content .page-header {
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
            .status-pending {
                background-color: rgba(241, 196, 15, 0.15);
                color: #f1c40f;
            }

            .status-approved {
                background-color: rgba(46, 204, 113, 0.15);
                color: #2ecc71;
            }

            .status-rejected {
                background-color: rgba(231, 76, 60, 0.15);
                color: #e74c3c;
            }
        </style>  
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
                    <h1 class="page-title" style="padding-left: 32px">Welcome to ... Dashboard</h1>
                    <nav class="breadcrumb-nav">
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Home</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <span class="breadcrumb-item active">Dashboard</span>
                    </nav>
                </div>
            </div>

           
            <div class="content-wrapper">
                <div class="request-content">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title"><i class="fas fa-list-ul"></i>Danh sách request</h3>
                        </div>
                        <div class="card-body">
                            <div class="card-control" style="display: flex; justify-content: space-between">
                                <form id="filterForm" action="${pageContext.request.contextPath}/nutricontrol" method="GET">
                                    <input type="hidden" name="action" value="showrequestlistsort">
                                    <div class="filter-controls" style="display: flex; align-items: center; gap: 16px; flex-wrap: wrap;">

                                        <div class="input-group">
                                            <i class="fas fa-search"></i>
                                            <input type="text" name="searchKey" placeholder="Tìm theo tên request..." value="${param.searchKey}">
                                        </div> 
                                        <div class="select-group">
                                            <select name="sortCreate" id="sortCreate">
                                                <option value="">--Sort by Update at --</option>
                                                <option value="asc" ${param.sortCreate == 'asc' ? 'selected' : ''}>Mới nhất</option>
                                                <option value="desc" ${param.sortCreate == 'desc' ? 'selected' : ''}>Cũ nhất</option>
                                            </select>
                                        </div>
                                        <div class="select-group">
                                            <select name="sortType" id="sortType">
                                                <option value="">--Sort by Type --</option>
                                                <option value="New Food" ${param.sortType == 'New Food' ? 'selected' : ''}>New Food</option>
                                                <option value="Update" ${param.sortType == 'Update' ? 'selected' : ''}>Update</option>
                                                <option value="Remove" ${param.sortType == 'Remove' ? 'selected' : ''}>Remove</option>
                                            </select>
                                        </div>
                                        <div class="select-group">
                                            <select name="sortStatus" id="sortStatus">
                                                <option value="">-- Sort by Status --</option>
                                                <option value="Pending" ${param.sortStatus == 'Pending' ? 'selected' : ''}>Pending</option>
                                                <option value="Approved" ${param.sortStatus == 'Approved' ? 'selected' : ''}>Approved</option>
                                                <option value="Rejected" ${param.sortStatus == 'Rejected' ? 'selected' : ''}>Rejected</option>
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
                                            <th>Title</th>  
                                            <th>Food Name</th>
                                            <th>Type</th>
                                            <th>Last Update</th>
                                            <th>Status</th>
                                             <th>Handle</th>
                                            <th style="width: 5%;">Thao Tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty lstR}">
                                                <tr>
                                                    <td colspan="8" style="text-align: center; margin: 30px;">
                                                        Không tìm thấy request nào.
                                                    </td>
                                                </tr>
                                            </c:when>
                                                
                                          
                                            <c:otherwise>
                                                <c:forEach items="${lstR}" var="re">
                                                    <tr>
                                                        <td><strong>#${re.rID}</strong></td>
                                                        <td>${re.title}</td>
                                                        <td class="ellipsis" title="${re.foodName}">${re.foodName}</td>
                                                        <td><span class="type-badge type-${fn:toLowerCase(re.type)}">${re.type}</span></td>
                                                        <td>
                                                            <fmt:formatDate value="${re.update_at}" pattern="dd/MM/yyyy HH:mm:ss" />
                                                        </td>
                                                        <td>
                                                            <span class="status-badge status-${fn:toLowerCase(re.status)}">${re.status}</span> 
                                                        </td>
                                                        <td>${empty re.handleBY ? 'Chưa có' : re.handleBY}</td>                                                        <td>
                                                            <div class="table-actions">
                                                               <a class="action-btn view-btn" title="Xem chi tiết" href="nutricontrol?action=showfooddraftdetail&id=${re.rID}">
                                                                    <i class="fas fa-eye"></i>
                                                                </a>
                                                                <c:if test="${re.status eq 'Pending'}">


                                                                    <a class="action-btn edit-btn" title="Chỉnh sửa"
                                                                       href="nutricontrol?action=&id=${re.rID}">
                                                                        <i class="fas fa-edit"></i>
                                                                    </a>

                                                                    <a class="action-btn remove-btn" id="confirmDeleteBtn" title="Xóa" style="background-color:red; color:white"
                                                                       href="#" onclick="showDeletePopup('nutricontrol?action=&id=${re.rID}', '${re.title}'); return false;">
                                                                        <i class="fas fa-trash"></i>
                                                                    </a>
                                                                    <a class="action-btn cancel-btn" title="Hủy"
                                                                       href="nutricontrol?action=&id=${re.rID}">
                                                                        <i class="fas fa-times"></i>
                                                                    </a>
                                                                </c:if>  
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                                    
                                        </c:choose>
                                    </tbody>
                                </table>
                                <div  id="paginationWrapper" class="pagination-container" style="display: flex; justify-content: space-between; padding: 10px;">
                                    <div style="padding: 10px">Show ${lstR.size()} of ${totalRequest} items</div>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0"></script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/common.js"></script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/request.js"></script>
    </body>
</html>
