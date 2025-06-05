<%-- 
    Document   : FoodDetail
    Created on : May 31, 2025, 11:35:20 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background-color: #f8fafc;
            color: #334155;
        }

        .blog-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 24px;
        }

        /* Header Section */
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 16px;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .search-container {
            position: relative;
            display: flex;
            align-items: center;
        }

        .search-input {
            padding: 10px 16px 10px 40px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            width: 280px;
            font-size: 14px;
            transition: all 0.2s;
            background: white;
        }

        .search-input:focus {
            outline: none;
            border-color: #3b82f6;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 12px;
            color: #94a3b8;
            font-size: 16px;
        }

        .view-toggle {
            display: flex;
            align-items: center;
            gap: 8px;
            background: white;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            padding: 8px 12px;
            font-size: 14px;
            color: #64748b;
        }

        .header-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 10px 16px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-primary {
            background: #3b82f6;
            color: white;
        }

        .btn-primary:hover {
            background: #2563eb;
            transform: translateY(-1px);
        }

        .btn-secondary {
            background: white;
            color: #64748b;
            border: 2px solid #e2e8f0;
        }

        .btn-secondary:hover {
            background: #f8fafc;
        }

        .filter-btn {
            background: white;
            color: #64748b;
            border: 2px solid #e2e8f0;
            padding: 10px;
            min-width: 80px;
        }

        /* Table Styles */
        .table-container {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            margin-bottom: 24px;
        }

        .blog-table {
            width: 100%;
            border-collapse: collapse;
        }

        .blog-table thead {
            background: #f8fafc;
        }

        .blog-table th {
            padding: 16px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            color: #475569;
            border-bottom: 1px solid #e2e8f0;
        }

        .blog-table td {
            padding: 16px;
            border-bottom: 1px solid #f1f5f9;
            vertical-align: middle;
        }

        .blog-table tbody tr {
            transition: background-color 0.2s;
        }

        .blog-table tbody tr:hover {
            background-color: #f8fafc;
        }

        /* Avatar Styles */
        .client-cell {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 14px;
            color: white;
        }

        .avatar-1 { background: #3b82f6; }
        .avatar-2 { background: #ef4444; }
        .avatar-3 { background: #10b981; }
        .avatar-4 { background: #f59e0b; }
        .avatar-5 { background: #8b5cf6; }
        .avatar-6 { background: #06b6d4; }
        .avatar-7 { background: #f97316; }
        .avatar-8 { background: #84cc16; }

        .client-name {
            font-weight: 500;
            color: #1e293b;
        }

        /* Blog Image */
        .blog-image {
            width: 60px;
            height: 36px;
            border-radius: 6px;
            object-fit: cover;
            border: 1px solid #e2e8f0;
        }

        /* Status Badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-recent {
            background: #dcfce7;
            color: #166534;
        }

        .status-overdue {
            background: #fee2e2;
            color: #991b1b;
        }

        .status-remaining {
            background: #fef3c7;
            color: #92400e;
        }

        .status-responded {
            background: #dbeafe;
            color: #1e40af;
        }

        .status-closed {
            background: #f1f5f9;
            color: #475569;
        }

        /* Priority Indicators */
        .priority-indicator {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
            font-weight: 500;
        }

        .priority-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
        }

        .priority-urgent .priority-dot { background: #ef4444; }
        .priority-high .priority-dot { background: #f97316; }
        .priority-medium .priority-dot { background: #3b82f6; }
        .priority-low .priority-dot { background: #10b981; }

        /* Actions */
        .actions-cell {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .action-btn {
            padding: 8px;
            border: none;
            background: none;
            color: #64748b;
            cursor: pointer;
            border-radius: 6px;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .action-btn:hover {
            background: #f1f5f9;
            color: #1e293b;
        }

        .action-btn.delete:hover {
            background: #fee2e2;
            color: #dc2626;
        }

        /* Agent Dropdown */
        .agent-select {
            background: none;
            border: none;
            color: #64748b;
            cursor: pointer;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 14px;
        }

        .agent-select:hover {
            background: #f1f5f9;
        }

        /* Pagination */
        .pagination {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-top: 24px;
        }

        .pagination a,
        .pagination span {
            display: flex;
            align-items: center;
            justify-content: center;
            min-width: 36px;
            height: 36px;
            padding: 0 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.2s;
        }

        .pagination a {
            color: #64748b;
            border: 1px solid #e2e8f0;
            background: white;
        }

        .pagination a:hover {
            background: #f8fafc;
            border-color: #cbd5e1;
        }

        .pagination .current {
            background: #3b82f6;
            color: white;
            border: 1px solid #3b82f6;
        }

        .pagination .ellipsis {
            color: #94a3b8;
            border: none;
            background: none;
        }

        /* Sidebar Filter */
        .main-content {
            display: flex;
            gap: 24px;
        }

        .content-area {
            flex: 1;
        }

        .filter-sidebar {
            width: 280px;
            background: white;
            border-radius: 12px;
            padding: 24px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            height: fit-content;
        }

        .filter-title {
            font-size: 18px;
            font-weight: 600;
            color: #1e293b;
            margin-bottom: 20px;
        }

        .filter-group {
            margin-bottom: 24px;
        }

        .filter-label {
            display: block;
            font-size: 14px;
            font-weight: 500;
            color: #374151;
            margin-bottom: 8px;
        }

        .filter-select {
            width: 100%;
            padding: 10px 12px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 14px;
            background: white;
            color: #374151;
        }

        .filter-select:focus {
            outline: none;
            border-color: #3b82f6;
        }

        .update-btn {
            width: 100%;
            background: #3b82f6;
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.2s;
        }

        .update-btn:hover {
            background: #2563eb;
        }

        .no-data {
            text-align: center;
            padding: 48px 24px;
            color: #64748b;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .header-section {
                flex-direction: column;
                align-items: stretch;
            }

            .main-content {
                flex-direction: column;
            }

            .filter-sidebar {
                width: 100%;
            }

            .search-input {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="blog-container">
        <!-- Header Section -->
        <div class="header-section">
            <div class="header-left">
                <h2 style="color: #1e293b; font-size: 20px; font-weight: 600;">All tickets</h2>
                <div class="search-container">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="search-input" placeholder="Search by name" id="blogSearchInput">
                </div>
                <div class="view-toggle">
                    <span>Table View</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
            </div>
            <div class="header-right">
                <a href="#" class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    New
                </a>
                <a href="#" class="btn btn-secondary">
                    <i class="fas fa-download"></i>
                    Export
                </a>
                <button class="btn filter-btn">
                    <i class="fas fa-ellipsis-h"></i>
                </button>
            </div>
        </div>

        <div class="main-content">
            <!-- Main Content Area -->
            <div class="content-area">
                <div class="table-container">
                    <!-- JSP Logic preserved -->
                    <c:choose>
                        <c:when test="${not empty lstB}">
                            <table class="blog-table">
                                <thead>
                                    <tr>
                                        <th style="width: 40px;">
                                            <input type="checkbox" style="width: 16px; height: 16px;">
                                        </th>
                                        <th>Client</th>
                                        <th>Subject</th>
                                        <th>Status</th>
                                        <th>Priority</th>
                                        <th>Agent</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="blog" items="${lstB}" varStatus="loop">
                                        <tr>
                                            <td>
                                                <input type="checkbox" style="width: 16px; height: 16px;">
                                            </td>
                                            <td>
                                                <div class="client-cell">
                                                    <div class="avatar avatar-${(loop.index % 8) + 1}">
                                                        ${blog.title.substring(0, 1).toUpperCase()}
                                                    </div>
                                                    <img src="${blog.imageUlr}" alt="Blog image" class="blog-image">
                                                </div>
                                            </td>
                                            <td>
                                                <div style="font-weight: 500; color: #3b82f6; cursor: pointer;">
                                                    ${blog.title}
                                                </div>
                                            </td>
                                            <td>
                                                <span class="status-badge status-${blog.status.toLowerCase()}">
                                                    ${blog.status}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="priority-indicator priority-${blog.status.toLowerCase()}">
                                                    <div class="priority-dot"></div>
                                                    ${blog.status}
                                                </div>
                                            </td>
                                            <td>
                                                <select class="agent-select">
                                                    <option>Select Agent</option>
                                                    <option>Anindya</option>
                                                    <option>Nowrin</option>
                                                    <option>Khalid</option>
                                                </select>
                                                <div class="actions-cell" style="display: inline-flex; margin-left: 12px;">
                                                    <a href="viewBlog.do?id=${blog.bID}" class="action-btn" title="View">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="editBlog.do?id=${blog.bID}" class="action-btn" title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <a href="deleteblog?id=${blog.bID}" class="action-btn delete" title="Delete"
                                                       onclick="return confirm('Bạn có chắc chắn muốn xóa bài viết này?');">
                                                        <i class="fas fa-trash"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="no-data">
                                Không có bài viết nào.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Pagination preserved -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="?page=${currentPage - 1}" class="prev">
                                <i class="fas fa-chevron-left"></i>
                            </a>
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
                            <a href="listblog?index=${currentPage + 1}" class="next">
                                <i class="fas fa-chevron-right"></i>
                            </a>
                        </c:if>
                    </div>
                </c:if>
            </div>

            <!-- Filter Sidebar -->
            <div class="filter-sidebar">
                <h3 class="filter-title">Filter</h3>
                
                <div class="filter-group">
                    <label class="filter-label">Priority</label>
                    <select class="filter-select">
                        <option>High</option>
                        <option>Medium</option>
                        <option>Low</option>
                        <option>Urgent</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">Source</label>
                    <select class="filter-select">
                        <option>Facebook</option>
                        <option>Email</option>
                        <option>Phone</option>
                        <option>Website</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">Status</label>
                    <select class="filter-select" id="filterStatus" name="status">
                        <option>None</option>
                        <c:forEach var="status" items="${statusList}">
                            <option value="${status}" <c:if test="${status == status}">selected</c:if>>${status}</option>
                        </c:forEach>   
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">Group</label>
                    <select class="filter-select">
                        <option>My Group</option>
                        <option>Support</option>
                        <option>Sales</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">Agent</label>
                    <select class="filter-select">
                        <option>Khalid</option>
                        <option>Anindya</option>
                        <option>Nowrin</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">Type</label>
                    <select class="filter-select">
                        <option>None</option>
                        <option>Bug</option>
                        <option>Feature</option>
                        <option>Support</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">Category</label>
                    <select class="filter-select">
                        <option>Engineering</option>
                        <option>Marketing</option>
                        <option>Sales</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">Tags</label>
                    <select class="filter-select">
                        <option>Complaint</option>
                        <option>Feature Request</option>
                        <option>Bug Report</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label class="filter-label">Subscription</label>
                    <select class="filter-select">
                        <option>Active</option>
                        <option>Inactive</option>
                        <option>Suspended</option>
                    </select>
                </div>

                <!-- BMI Category preserved -->
                <div class="filter-group">
                    <label class="filter-label">BMI Category</label>
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

                <button class="update-btn">Update</button>
            </div>
        </div>
    </div>

    <script>
        // Preserve original search functionality
        document.getElementById('blogSearchInput').addEventListener('input', function() {
            // Add your search logic here
            console.log('Search:', this.value);
        });

        // Filter functionality
        document.getElementById('filterStatus').addEventListener('change', function() {
            // Add your filter logic here
            console.log('Filter status:', this.value);
        });
    </script>
</body>
</html>
