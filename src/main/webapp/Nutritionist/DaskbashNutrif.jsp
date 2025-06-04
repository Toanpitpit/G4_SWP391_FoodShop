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
<!--                            <ion-icon name="logo-apple"></ion-icon>-->
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
                        <span class="title">My    Blogs</span>
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
                            <div class="numbers">${lstR.size()}</div>
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
                            <div class="numbers">${lstB.size()}</div>
                            <div class="cardName">Your Blogs</div>
                        </div>

                        <div class="iconBx">
                            <ion-icon name="document-text-outline"></ion-icon>
                        </div>
                    </div> 
                </a>
            </div>

            <!-- ================ Request Newest List ================= -->
            <div class="details">
                <div class="recentOrders">
                    <div class="cardHeader">
                        <p></p>
                        <h2>Recent Request</h2>
                        <a href="request.jsp" class="btn"><p>View All</p></a>
                    </div>
                    <div class="table_Wap">
                        <table>
                        <thead>
                            <tr>
                                <td>Title</td>
                                <td>Type</td>
                                <td colspan="3">Food Name</td>
                                <td>Note</td>
                                <td colspan="5">Status</td>
                            </tr>
                        </thead>

                        <tbody>
                            
                             <c:forEach var="Re" items="${lstR}" begin="0" end="5" >
                            <tr onclick="window.location.href='request-detail?id=${Re.rID}'" style="cursor: pointer;">
                                <td class "sub_info">${Re.title}</td>
                                <td>${Re.type}</td>
                                <td colspan="3">${Re.foodName}</td>
                                <td  class ="sub_info" colspan="5">${Re.note}</td>
                                <td><span class="status ${Re.status.toLowerCase()}">${Re.status}</span></td>
                            </tr>
                             </c:forEach>

                        </tbody>
                    </table>
                    </div>
                </div>

                <!-- ================= New Customers ================ -->
                <div class="recentnotify">
                    <div>
                        <h2>NOTIFICATION</h2>
                    </div>
                    <table> 
                        <c:forEach var="No" items="${lstN}">
                            <tr>
                                <td>
<!--                                    <img src="a" alt="avatar" style="width: 30px; height: 30px; border-radius: 50%;">-->
                                    <div >
                                        <p>${No.message}</p>
                                    </div>
                                    <div class="status-dot"  
                                         style="width: 8px; height: 8px; border-radius: 50%; background-color: ${No.isRead ? 'transparent' : '#28a745'}; cursor: pointer;">
                                    </div>
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
