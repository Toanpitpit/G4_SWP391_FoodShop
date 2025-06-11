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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../CSS/Ncss/Homed.css">
        <link rel="stylesheet" href="../CSS/Ncss/common.css">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    </head>

    <body>
        <!-- =============== Navigation ================ -->
        <div class="container">
            <jsp:include page="/Nutritionist/Common.jsp"/>
            <!-- ========================= Main ==================== -->
            <div class="main">
                <jsp:include page="/Nutritionist/topbar.jsp"/>  

                <!-- ======================= Cards ================== -->
                <div class="cardBox">
                    <a href="listblog">
                        <div class="card">
                            <div>
                                <div class="numbers">${totalBlog}</div>
                                <div class="cardName">Total Blogs</div>
                            </div>

                            <div class="iconBx">
                                <ion-icon name="document-text-outline"></ion-icon>
                            </div>
                        </div>
                    </a>

                    <a href="">
                        <div class="card">
                            <div>
                                <div class="numbers">${totalFdrf}</div>
                                <div class="cardName">Your Food draft</div>
                            </div> 

                            <div class="iconBx">
                                <ion-icon name="create-outline"></ion-icon>
                            </div>
                        </div>
                    </a>

                    <a href="">
                        <div class="card">
                            <div>
                                <div class="numbers">${totalRequest}</div>
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
                                <div class="numbers">${totalNotify}</div>
                                <div class="cardName">Notify</div>
                            </div>

                            <div class="iconBx">
                                <ion-icon name="notifications-outline"></ion-icon>
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
                        <div class="chart-header" style="display: flex; justify-content: space-between; align-items: center;">
                            <h3>Blogs Per Month</h3>
                            <label for="yearDropdown">Select Year:</label>

                            <select id="yearDropdown" name="year">
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
                <jsp:include page="/Nutritionist/footer.jsp"/>  
            </div>
        </div>
    </div>

     <script>
        document.addEventListener('DOMContentLoaded', function() {
            const navigation = document.getElementById('navigation');
            const toggle = document.getElementById('toggle');
            const submenuItems = document.querySelectorAll('.li_has_submenu');
            
            submenuItems.forEach(item => {
                const menuItem = item.querySelector('.menu-item');
                
                menuItem.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    
                    item.classList.toggle('active');

                    submenuItems.forEach(otherItem => {
                        if (otherItem !== item) {
                            otherItem.classList.remove('active');
                        }
                    });
                });
            });
            
            const regularMenuItems = document.querySelectorAll('.navigation ul li:not(.li_has_submenu) a');
            regularMenuItems.forEach(item => {
                item.addEventListener('click', function() {
                    submenuItems.forEach(submenuItem => {
                        submenuItem.classList.remove('active');
                    });
                });
            });
            
            // Handle submenu item clicks
            const submenuLinks = document.querySelectorAll('.li_has_submenu ul li a');
            submenuLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    // Remove active class from all submenu items
                    submenuLinks.forEach(l => l.parentElement.classList.remove('active'));
                    // Add active class to clicked item
                    this.parentElement.classList.add('active');
                });
            });
            
            // Close submenus when clicking outside
            document.addEventListener('click', function(e) {
                if (!e.target.closest('.navigation')) {
                    submenuItems.forEach(item => {
                        item.classList.remove('active');
                    });
                }
            });
            
            // Mobile responsive handling
            function handleResize() {
                if (window.innerWidth <= 1024) {
                    navigation.classList.add('active');
                } else {
                    navigation.classList.remove('active');
                }
            }
            
            window.addEventListener('resize', handleResize);
            handleResize(); // Initial check
        });
    </script>


    <!-- =========== Scripts =========  -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="../JS/Nutritionist/home.js"></script>

    <!-- ====== ionicons ======= -->
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>

</html>
