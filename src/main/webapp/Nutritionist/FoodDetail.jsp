<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Management Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Ubuntu:wght@300;400;500;700&display=swap");
        @import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap");

        * {
            font-family: "Ubuntu", sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --green: #2ecc71;
            --green-hover: #27ae60;
            --white: #fff;
            --gray: #f5f5f5;
            --black1: #222;
            --black2: #999;
            --primary: #4a90e2;
            --primary-hover: #357ab7;
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
            --info: #17a2b8;
            --light: #f8f9fa;
            --dark: #343a40;
            --shadow-light: rgba(0, 0, 0, 0.05);
            --shadow-medium: rgba(0, 0, 0, 0.1);
            --shadow-heavy: rgba(0, 0, 0, 0.15);
        }

        body {
            min-height: 100vh;
            overflow-x: hidden;
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        }

        .container {
            position: relative;
            width: 100%;
        }

        /* =============== Navigation ================ */
        .navigation {
            position: fixed;
            width: 300px;
            height: 100%;
            background: linear-gradient(180deg, var(--green) 0%, var(--green-hover) 100%);
            border-left: 10px solid var(--green);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
            z-index: 1000;
            box-shadow: 4px 0 20px var(--shadow-medium);
        }
        .navigation.active {
            width: 80px;
        }

        .navigation ul {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            padding-top: 20px;
        }

        .navigation ul li {
            position: relative;
            width: 100%;
            list-style: none;
            border-top-left-radius: 30px;
            border-bottom-left-radius: 30px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .navigation ul li:hover,
        .navigation ul li.hovered {
            background-color: var(--white);
            transform: translateX(5px);
        }

        .navigation ul li:nth-child(1) {
            margin-bottom: 40px;
            pointer-events: none;
        }

        .navigation ul li a {
            position: relative;
            display: block;
            width: 100%;
            display: flex;
            text-decoration: none;
            color: var(--white);
            transition: all 0.3s ease;
        }
        .navigation ul li:hover a,
        .navigation ul li.hovered a {
            color: var(--green);
        }

        .navigation ul li a .icon {
            position: relative;
            display: block;
            min-width: 60px;
            height: 60px;
            line-height: 75px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        .navigation ul li a .icon i {
            font-size: 1.75rem;
            transition: all 0.3s ease;
        }

        .navigation ul li:hover a .icon {
            transform: scale(1.1);
        }

        .navigation ul li a .title {
            position: relative;
            display: block;
            padding: 0 10px;
            height: 60px;
            line-height: 60px;
            text-align: start;
            white-space: nowrap;
            transition: all 0.3s ease;
        }

        /* ===================== Main ===================== */
        .main {
            position: absolute;
            width: calc(100% - 300px);
            left: 300px;
            min-height: 100vh;
            background: linear-gradient(135deg, var(--white) 0%, #f8f9fa 100%);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .main.active {
            width: calc(100% - 80px);
            left: 80px;
        }

        .topbar {
            width: 100%;
            height: 80px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
            background: var(--white);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px var(--shadow-light);
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 100;
            transition: all 0.3s ease;
        }

        .toggle {
            position: relative;
            width: 60px;
            height: 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 2.5rem;
            cursor: pointer;
            border-radius: 15px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            color: var(--black1);
        }

        .toggle:hover {
            background: var(--green);
            color: var(--white);
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(46, 204, 113, 0.3);
        }

        .search {
            position: relative;
            width: 400px;
            margin: 0 10px;
            transition: all 0.3s ease;
        }

        .search label {
            position: relative;
            width: 100%;
        }

        .search label input {
            width: 100%;
            height: 50px;
            border-radius: 25px;
            padding: 5px 20px;
            padding-left: 45px;
            font-size: 16px;
            outline: none;
            border: 2px solid transparent;
            background: var(--gray);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 2px 10px var(--shadow-light);
        }

        .search label input:focus {
            border-color: var(--green);
            background: var(--white);
            box-shadow: 0 4px 20px rgba(46, 204, 113, 0.2);
        }

        .search label i {
            position: absolute;
            top: 50%;
            left: 15px;
            transform: translateY(-50%);
            font-size: 1.3rem;
            color: var(--black2);
            transition: all 0.3s ease;
        }

        .user {
            position: relative;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            overflow: hidden;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: 3px solid transparent;
            box-shadow: 0 4px 15px var(--shadow-light);
            background: var(--green);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }

        .user:hover {
            transform: scale(1.1);
            border-color: var(--green);
            box-shadow: 0 6px 25px rgba(46, 204, 113, 0.3);
        }

        /* =============== Blog Management Content ================ */
        .blog-management {
            padding: 30px;
            min-height: calc(100vh - 80px);
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding: 25px 30px;
            background: linear-gradient(135deg, var(--white) 0%, #f8fafc 100%);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .page-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--dark);
            margin: 0;
            background: linear-gradient(135deg, var(--green), var(--primary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .create-blog-btn {
            background: linear-gradient(135deg, var(--green), var(--green-hover));
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 15px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 8px 25px rgba(46, 204, 113, 0.3);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .create-blog-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 35px rgba(46, 204, 113, 0.4);
        }

        /* Filter Section */
        .filters-section {
            background: var(--white);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .filters-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .filters-title {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .filters-row {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr auto;
            gap: 20px;
            align-items: end;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .filter-label {
            font-weight: 600;
            color: var(--dark);
            font-size: 14px;
        }

        .filter-input {
            height: 45px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 0 15px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: var(--white);
        }

        .filter-input:focus {
            outline: none;
            border-color: var(--green);
            box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
        }

        .filter-select {
            height: 45px;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 0 15px;
            font-size: 14px;
            transition: all 0.3s ease;
            background: var(--white);
            cursor: pointer;
        }

        .filter-select:focus {
            outline: none;
            border-color: var(--green);
            box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
        }

        .clear-filters-btn {
            height: 45px;
            background: linear-gradient(135deg, #fc8181, #f687b3);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 0 20px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .clear-filters-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(252, 129, 129, 0.3);
        }

        /* Blog Table */
        .blog-table-container {
            background: var(--white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
            border: 1px solid rgba(0, 0, 0, 0.05);
            margin-bottom: 25px;
        }

        .blog-table {
            width: 100%;
            border-collapse: collapse;
        }

        .blog-table thead {
            background: linear-gradient(135deg, var(--primary), var(--primary-hover));
        }

        .blog-table thead th {
            color: white;
            font-weight: 600;
            font-size: 14px;
            padding: 20px 15px;
            text-align: left;
            position: relative;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .blog-table thead th:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .blog-table thead th.sortable {
            padding-right: 35px;
        }

        .blog-table thead th .sort-icon {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            opacity: 0.6;
            transition: all 0.3s ease;
        }

        .blog-table thead th:hover .sort-icon {
            opacity: 1;
        }

        .blog-table thead th.sort-asc .sort-icon {
            opacity: 1;
            color: #ffd700;
        }

        .blog-table thead th.sort-desc .sort-icon {
            opacity: 1;
            color: #ffd700;
            transform: translateY(-50%) rotate(180deg);
        }

        .blog-table tbody tr {
            transition: all 0.3s ease;
            border-bottom: 1px solid #f1f5f9;
        }

        .blog-table tbody tr:hover {
            background: linear-gradient(135deg, #f8fafc, #e2e8f0);
            transform: scale(1.01);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .blog-table tbody td {
            padding: 18px 15px;
            font-size: 14px;
            color: var(--dark);
            vertical-align: middle;
        }

        .blog-id {
            font-weight: 600;
            color: var(--primary);
        }

        .blog-title {
            font-weight: 600;
            max-width: 250px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .blog-author {
            color: var(--black2);
        }

        .blog-date {
            color: var(--black2);
            font-size: 13px;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-public {
            background: rgba(40, 167, 69, 0.1);
            color: var(--success);
            border: 1px solid rgba(40, 167, 69, 0.2);
        }

        .status-draft {
            background: rgba(255, 193, 7, 0.1);
            color: #e6a800;
            border: 1px solid rgba(255, 193, 7, 0.2);
        }

        .status-private {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger);
            border: 1px solid rgba(220, 53, 69, 0.2);
        }

        .bmi-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 11px;
            font-weight: 600;
            background: rgba(74, 144, 226, 0.1);
            color: var(--primary);
            border: 1px solid rgba(74, 144, 226, 0.2);
        }

        .actions-cell {
            display: flex;
            gap: 8px;
            justify-content: center;
        }

        .action-btn {
            width: 35px;
            height: 35px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }

        .view-btn {
            background: rgba(23, 162, 184, 0.1);
            color: var(--info);
            border: 1px solid rgba(23, 162, 184, 0.2);
        }

        .edit-btn {
            background: rgba(255, 193, 7, 0.1);
            color: #e6a800;
            border: 1px solid rgba(255, 193, 7, 0.2);
        }

        .delete-btn {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger);
            border: 1px solid rgba(220, 53, 69, 0.2);
        }

        .action-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        /* Pagination */
        .pagination-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
        }

        .pagination {
            display: flex;
            gap: 5px;
            align-items: center;
        }

        .pagination-btn {
            min-width: 40px;
            height: 40px;
            border: 2px solid #e2e8f0;
            background: var(--white);
            color: var(--dark);
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            text-decoration: none;
        }

        .pagination-btn:hover {
            border-color: var(--green);
            background: var(--green);
            color: white;
            transform: translateY(-2px);
        }

        .pagination-btn.active {
            background: var(--green);
            border-color: var(--green);
            color: white;
        }

        .pagination-btn.disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .pagination-btn.disabled:hover {
            transform: none;
            border-color: #e2e8f0;
            background: var(--white);
            color: var(--dark);
        }

        /* Success Message */
        .success-message {
            position: fixed;
            top: 100px;
            right: 20px;
            background: linear-gradient(135deg, var(--success), #20c997);
            color: white;
            padding: 15px 25px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.3);
            z-index: 1001;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: slideInRight 0.5s ease, fadeOut 0.5s ease 4.5s forwards;
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes fadeOut {
            to {
                opacity: 0;
                visibility: hidden;
            }
        }

        /* Responsive */
        @media (max-width: 1200px) {
            .filters-row {
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }
            
            .filter-group:nth-child(3),
            .filter-group:nth-child(4) {
                grid-column: span 2;
            }
        }

        @media (max-width: 768px) {
            .main {
                width: 100%;
                left: 0;
            }
            
            .navigation {
                transform: translateX(-100%);
            }
            
            .navigation.active {
                transform: translateX(0);
                width: 100%;
            }
            
            .filters-row {
                grid-template-columns: 1fr;
            }
            
            .blog-table-container {
                overflow-x: auto;
            }
            
            .blog-table {
                min-width: 800px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Navigation -->
        <div class="navigation">
            <ul>
                <li>
                    <a href="#">
                        <span class="icon">
                            <i class="fas fa-utensils"></i>
                        </span>
                        <span class="title">NutriDash</span>
                    </a>
                </li>
                <li class="hovered">
                    <a href="#">
                        <span class="icon">
                            <i class="fas fa-home"></i>
                        </span>
                        <span class="title">Dashboard</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon">
                            <i class="fas fa-users"></i>
                        </span>
                        <span class="title">Customers</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon">
                            <i class="fas fa-blog"></i>
                        </span>
                        <span class="title">Blogs</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon">
                            <i class="fas fa-calculator"></i>
                        </span>
                        <span class="title">BMI Calculator</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon">
                            <i class="fas fa-chart-bar"></i>
                        </span>
                        <span class="title">Analytics</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon">
                            <i class="fas fa-cog"></i>
                        </span>
                        <span class="title">Settings</span>
                    </a>
                </li>
                <li>
                    <a href="#">
                        <span class="icon">
                            <i class="fas fa-sign-out-alt"></i>
                        </span>
                        <span class="title">Sign Out</span>
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="main">
            <!-- Topbar -->
            <div class="topbar">
                <div class="toggle">
                    <i class="fas fa-bars"></i>
                </div>
                <div class="search">
                    <label>
                        <input type="text" placeholder="Search here">
                        <i class="fas fa-search"></i>
                    </label>
                </div>
                <div class="user">
                    <i class="fas fa-user"></i>
                </div>
            </div>

            <!-- Blog Management Content -->
            <div class="blog-management">
                <!-- Page Header -->
                <div class="page-header">
                    <h1 class="page-title">Blog Management</h1>
                    <button class="create-blog-btn" onclick="createBlog()">
                        <i class="fas fa-plus"></i>
                        Create New Blog
                    </button>
                </div>

                <!-- Filters Section -->
                <div class="filters-section">
                    <div class="filters-header">
                        <h3 class="filters-title">
                            <i class="fas fa-filter"></i>
                            Filters & Search
                        </h3>
                    </div>
                    <div class="filters-row">
                        <div class="filter-group">
                            <label class="filter-label">Search by Title/Author</label>
                            <input type="text" class="filter-input" id="searchInput" placeholder="Enter title or author name..." onkeyup="filterBlogs()">
                        </div>
                        <div class="filter-group">
                            <label class="filter-label">Status</label>
                            <select class="filter-select" id="statusFilter" onchange="filterBlogs()">
                                <option value="">All Status</option>
                                <option value="Public">Public</option>
                                <option value="Draft">Draft</option>
                                <option value="Private">Private</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label class="filter-label">BMI Category</label>
                            <select class="filter-select" id="bmiFilter" onchange="filterBlogs()">
                                <option value="">All Categories</option>
                                <option value="Underweight">Underweight</option>
                                <option value="Normal">Normal Weight</option>
                                <option value="Overweight">Overweight</option>
                                <option value="Obese">Obese</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <button class="clear-filters-btn" onclick="clearFilters()">
                                <i class="fas fa-times"></i>
                                Clear
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Blog Table -->
                <div class="blog-table-container">
                    <table class="blog-table">
                        <thead>
                            <tr>
                                <th class="sortable" onclick="sortTable('id')">
                                    ID
                                    <i class="fas fa-sort sort-icon"></i>
                                </th>
                                <th class="sortable" onclick="sortTable('title')">
                                    Title
                                    <i class="fas fa-sort sort-icon"></i>
                                </th>
                                <th>Author</th>
                                <th>BMI Category</th>
                                <th class="sortable" onclick="sortTable('status')">
                                    Status
                                    <i class="fas fa-sort sort-icon"></i>
                                </th>
                                <th class="sortable" onclick="sortTable('date')">
                                    Last Updated
                                    <i class="fas fa-sort sort-icon"></i>
                                </th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="blogTableBody">
                            <tr>
                                <td class="blog-id">#001</td>
                                <td class="blog-title">Healthy Diet Plan for Weight Loss</td>
                                <td class="blog-author">Dr. Sarah Johnson</td>
                                <td><span class="bmi-badge">Overweight</span></td>
                                <td><span class="status-badge status-public">Public</span></td>
                                <td class="blog-date">2025-06-05</td>
                                <td class="actions-cell">
                                    <button class="action-btn view-btn" title="View">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="action-btn edit-btn" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="action-btn delete-btn" title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td class="blog-id">#002</td>
                                <td class="blog-title">BMI Calculator: Understanding Your Body</td>
                                <td class="blog-author">Dr. Mike Chen</td>
                                <td><span class="bmi-badge">Normal</span></td>
                                <td><span class="status-badge status-draft">Draft</span></td>
                                <td class="blog-date">2025
