
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="../CSS/Ncss/request.css">
        <link rel="stylesheet" href="../CSS/Ncss/common.css">
        
         <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
    </head>
    <body> 
        <div class="container">
            <div class="navigation">
                <ul>
                    <li>
                        <a href="/dashboadnutri">
                            <span class="icon">
                            </span>
                            <span class="title">Heathy Foods</span>
                        </a>
                    </li>

                    <li>
                        <a href="/dashboadnutri">
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
                        <a href="/listblog">
                            <span class="icon">
                                <ion-icon name="chatbubble-outline"></ion-icon>
                            </span>
                            <span class="title">My Blogs</span>
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
                <div class="dashboard-content">
                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>Draft Foods</h3>
                            <div class="number">12</div>
                        </div>
                        <div class="stat-icon">
                            <ion-icon name="document-outline"></ion-icon>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>Requests</h3>
                            <div class="number">18</div>
                        </div>
                        <div class="stat-icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>Blogs</h3>
                            <div class="number">9</div>
                        </div>
                        <div class="stat-icon">
                            <ion-icon name="library-outline"></ion-icon>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-info">
                            <h3>Notifications</h3>
                            <div class="number">3</div>
                        </div>
                        <div class="stat-icon">
                            <ion-icon name="notifications-outline"></ion-icon>
                        </div>
                    </div>
                </div>

                <!-- Charts -->
                <div class="charts-grid">
                    <div class="chart-card">
                        <h3>Request Status</h3>
                        <div class="chart-container">
                            <canvas id="pieChart"></canvas>
                        </div>
                    </div>
                    <div class="chart-card">
                        <h3>Blogs Per Month</h3>
                        <div class="chart-container">
                            <canvas id="barChart"></canvas>
                        </div>
                    </div>
                    <div class="chart-card">
                        <h3>Food Draft Trend</h3>
                        <div class="chart-container">
                            <canvas id="lineChart"></canvas>
                        </div>
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
                    <div class="notification-item">
                        <div class="notification-icon error">
                            <ion-icon name="close-circle-outline"></ion-icon>
                        </div>
                        <div class="notification-text">
                            <p>Request #99 was rejected</p>
                            <small>15 mins ago</small>
                        </div>
                    </div>
                    <div class="notification-item">
                        <div class="notification-icon warning">
                            <ion-icon name="warning-outline"></ion-icon>
                        </div>
                        <div class="notification-text">
                            <p>Blog "Healthy Eating" is pending review</p>
                            <small>1 hour ago</small>
                        </div>
                    </div>
                </div>
            </div>
                <script>
        // Toggle Navigation
        function toggleNavigation() {
            const navigation = document.getElementById('navigation');
            navigation.classList.toggle('collapsed');
        }

        // Initialize Charts
        document.addEventListener('DOMContentLoaded', function() {
            // Pie Chart - Request Status
            const pieCtx = document.getElementById('pieChart').getContext('2d');
            new Chart(pieCtx, {
                type: 'doughnut',
                data: {
                    labels: ['Pending', 'Approved', 'Rejected'],
                    datasets: [{
                        data: [45, 35, 20],
                        backgroundColor: ['#FF9800', '#4CAF50', '#F44336'],
                        borderWidth: 0
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom'
                        }
                    }
                }
            });

            // Bar Chart - Blogs Per Month
            const barCtx = document.getElementById('barChart').getContext('2d');
            new Chart(barCtx, {
                type: 'bar',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May'],
                    datasets: [{
                        label: 'Blogs',
                        data: [1, 2, 3, 1, 2],
                        backgroundColor: '#2196F3',
                        borderRadius: 5
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 4
                        }
                    }
                }
            });

            // Line Chart - Food Draft Trend
            const lineCtx = document.getElementById('lineChart').getContext('2d');
            new Chart(lineCtx, {
                type: 'line',
                data: {
                    labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
                    datasets: [{
                        label: 'Drafts',
                        data: [3, 5, 4, 6],
                        borderColor: '#4CAF50',
                        backgroundColor: 'rgba(76, 175, 80, 0.1)',
                        fill: true,
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    </script>
            </div>
            <div>
                <script src="../JS/Nutritionist/home.js"></script>
                </body>
                </html>
