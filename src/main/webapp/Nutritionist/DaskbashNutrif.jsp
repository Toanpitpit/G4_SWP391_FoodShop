<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dash Board</title>
        <!-- ======= Styles ====== -->
        <link rel="stylesheet" href="../CSS/Ncss/Homed.css">
        <link rel="stylesheet" href="../CSS/Ncss/common.css">
    </head>

    <body>
        <!-- =============== Navigation ================ -->
        <div class="container">
            <div class="navigation">
                <ul>
                    <li>
                        <a href="dashboadnutri">
                            <span class="icon">
                            </span>
                            <span class="title">Heathy Foods</span>
                        </a>
                    </li>

                    <li>
                        <a href="dashboadnutri">
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

                    <div class="search">
                        <label>
                            <input type="text" placeholder="Search here">
                            <ion-icon name="search-outline"></ion-icon>
                        </label>
                    </div>

                    <div class="user">
                        <img src="assets/imgs/customer01.jpg" alt="">
                    </div>
                </div>
                  
            <!-- ======================= Cards ================== -->
            <div class="cardBox">
                <a href="abc">
                    <div class="card">
                        <div>
                            <div class="numbers">${lstF.size()}  0</div>
                            <div class="cardName">Total Foods</div>
                        </div>
               
                        <div class="iconBx">
                            <ion-icon name="nutrition-outline"></ion-icon>
                        </div>
                    </div>
                </a>
                    
                <a href="">
                    <div class="card">
                        <div>
                            <div class="numbers">${lstFd.size()} 0 </div>
                            <div class="cardName">Your Fooddraft</div>
                        </div> 

                        <div class="iconBx">
                            <ion-icon name="create-outline"></ion-icon>
                </div>
            </div>
                </a>

                <a href="">
                    <div class="card">
                        <div>
                            <div class="numbers">${lstR.size()}0</div>
                            <div class="cardName">Your Request</div>
        </div>

                        <div class="iconBx">
                            <ion-icon name="paper-plane-outline"></ion-icon>
                        </div>
                    </div>
                </a>


                <a href="">
                    <div class="card">
                        <div>
                            <div class="numbers">${lstB.size()}0</div>
                            <div class="cardName">Your Blogs</div>
                        </div>

                        <div class="iconBx">
                            <ion-icon name="document-text-outline"></ion-icon>
                        </div>
                    </div> 
                </a>
            </div>

            <!-- ================ Request Newest List ================= -->
            <div class="charts-grid">
                <div class="chart-card">
                    <h3>Request Status</h3>
                    <div class="chart-container">
                        <canvas id="pieChart"
                                data-labels='["Pending","Approved","Rejected" ,"Complete"]'
                                data-counts='[6,12,3,4]'>
                        </canvas>
                        <div class="status-legend">
                            <h3>Thống kê theo trạng thái</h3>
                            <ul class="legend-list">
                                <li>
                                    <span class="legend-color-box" style="background-color: rgba(75, 192, 192, 0.8);"></span>
                                    <span class="legend-label">Pending</span>
                                    <span class="legend-value">${publicCount}4</span>
                                </li>
                                <li>
                                    <span class="legend-color-box" style="background-color: rgba(255, 205, 86, 0.8);"></span>
                                    <span class="legend-label">Draft</span>
                                    <span class="legend-value">${Approved}3</span>
                                </li>
                                <li>
                                    <span class="legend-color-box" style="background-color: rgba(255, 99, 132, 0.8);"></span>
                                    <span class="legend-label">Private</span>
                                    <span class="legend-value">${Rejected}3</span>
                                </li>
                                <li>
                                    <span class="legend-color-box" style="background-color: #6B21A8;;"></span>
                                    <span class="legend-label">Total</span>
                                    <span class="legend-value">${privateCount + draftCount+ publicCount}10</span>
                                </li>
                            </ul>
                            <div class="chart-name">Biểu đồ: Số bài Blog theo trạng thái</div>
                        </div>
                    </div>
                    </div>
                    <div class="chart-card">
                        <h3>Blogs Per Month</h3>
                        <div class="chart-container">
                            <canvas id="barChart"
                                    data-labels='["Jan", "Feb", "Mar", "Apr", "May"]'
                                    data-counts='[2, 4, 3, 5, 1]'>
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
        </div>
    </div>




        <!-- =========== Scripts =========  -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="../JS/Nutritionist/home.js"></script>

        <!-- ====== ionicons ======= -->
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    </body>

</html>
