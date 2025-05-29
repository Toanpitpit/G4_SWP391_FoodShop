<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <!-- ======= Styles ====== -->
    <link rel="stylesheet" href="../CSS/Ncss/Homed.css">
</head>

<body>
    <!-- =============== Navigation ================ -->
    <div class="container">
        <div class="navigation">
            <ul>
                <li>
                    <a href="#">
                        <span class="icon">
<!--                            <ion-icon name="logo-apple"></ion-icon>-->
                        </span>
                        <span class="title">Heathy Foods</span>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="home-outline"></ion-icon>
                        </span>
                        <span class="title">Dashboard</span>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="people-outline"></ion-icon>
                        </span>
                        <span class="title">Foods</span>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="chatbubble-outline"></ion-icon>
                        </span>
                        <span class="title">Blogs</span>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="help-outline"></ion-icon>
                        </span>
                        <span class="title">Notification</span>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="settings-outline"></ion-icon>
                        </span>
                        <span class="title">Settings</span>
                    </a>
                </li>

                <li>
                    <a href="#">
                        <span class="icon">
                            <ion-icon name="lock-closed-outline"></ion-icon>
                        </span>
                        <span class="title">Password</span>
                    </a>
                </li>

                <li>
                    <a href="#">
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
                <div class="card">
                    <div>
                        <div class="numbers">${lstF.size()}  0</div>
                        <div class="cardName">Total Foods</div>
                    </div>

                    <div class="iconBx">
                        <ion-icon name="nutrition-outline"></ion-icon>
                    </div>
                </div>

                <div class="card">
                    <div>
                        <div class="numbers">${lstFd.size()} 0 </div>
                        <div class="cardName">Your Fooddraft</div>
                    </div> 

                    <div class="iconBx">
                        <ion-icon name="create-outline"></ion-icon>
                    </div>
                </div>

                <div class="card">
                    <div>
                        <div class="numbers">${lstRe.size()} 0</div>
                        <div class="cardName">Your Request</div>
                    </div>

                    <div class="iconBx">
                        <ion-icon name="paper-plane-outline"></ion-icon>
                    </div>
                </div>
                    <div class="card">
                    <div>
                        <div class="numbers">${lstBlog.size()} 0</div>
                        <div class="cardName">Your Blogs</div>
                    </div>

                        <div class="iconBx">
                            <ion-icon name="document-text-outline"></ion-icon>
                        </div>
                    </div> 
            </div>

            <!-- ================ Request Newest List ================= -->
            <div class="details">
                <div class="recentOrders">
                    <div class="cardHeader">
                        <h2>Recent Request</h2>
                        <a href="request.jsp" class="btn">View All</a>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <td>Title</td>
                                <td>Type</td>
                                <td colspan="3">Food Name</td>
                                <td>Status</td>
                                <td colspan="5">Note</td>
                            </tr>
                        </thead>

                        <tbody>
                            
                             <c:forEach var="Re" items="${lstR}" begin="0" end="3" >
                            <tr>
                                <td>${Re.title}</td>
                                <td>${Re.type}</td>
                                <td colspan="3">${Re.authorName}</td>
                                <td><span class="status delivered">${Re.status.toLowerCase()}</span></td>
                                <td colspan="5">${Re.note}</td>
                            </tr>
                             </c:forEach>

                        </tbody>
                    </table>
                </div>

                <!-- ================= New Customers ================ -->
                <div class="recentCustomers">
                    <div class="cardHeader">
                        <h2>NOTIFICATION</h2>
                    </div>

                    <table>
                        <c:forEach var="Re" items="${lstRen}">
                            <tr>
                                <td>
                                    <h4> ${sessionScope.account.name}<br> <span> You have new update from request </span></h4>
                                </td>
                            </tr> 
                        </c:forEach>            
                    </table>
                    
                </div>
            </div>
        </div>
    </div>

    <!-- =========== Scripts =========  -->
    <script src="../JS/Nutritionist/home.js"></script>

    <!-- ====== ionicons ======= -->
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>

</html>