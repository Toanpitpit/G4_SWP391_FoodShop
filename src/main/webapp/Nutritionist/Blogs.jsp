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
        <link rel="stylesheet" href="../CSS/Ncss/common.css">
        <link rel="stylesheet" href="../CSS/Ncss/Blogs.css">
    </head>

    <body>
        <div class="container">
            <div class="navigation">
                <ul>
                    <li>
                        <a href="../dashboadnutri">
                            <span class="icon">
                                <!--                            <ion-icon name="logo-apple"></ion-icon>-->
                            </span>
                            <span class="title">Heathy Foods</span>
                        </a>
                    </li>

                    <li>
                        <a href="../dashboadnutri">
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
                        <a href="/Nutritionist/Blogs.jsp">
                            <span class="icon">
                                <ion-icon name="chatbubble-outline"></ion-icon>
                            </span>
                            <span class="title">Blogs</span>
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
                            <div class="numbers">${lstR.size()}</div>
                            <div class="cardName">Your Request</div>
                        </div>

                        <div class="iconBx">
                            <ion-icon name="paper-plane-outline"></ion-icon>
                        </div>
                    </div>
                    <div class="card">
                        <div>
                            <div class="numbers">${lstB.size()}</div>
                            <div class="cardName">Your Blogs</div>
                        </div>

                        <div class="iconBx">
                            <ion-icon name="document-text-outline"></ion-icon>
                        </div>
                    </div> 
                </div>

                <!-- ================ Request Newest List ================= -->
                <div class="details">
                    <!-- Left: Blog List -->
                    <div class="blogList">
                        <div class="cardHeader">
                            <h2>Blog Posts</h2>
                            <a href="blog.jsp" class="btn"><p>View All</p></a>
                        </div>
                        <div class="table_Wap">
                            <table>
                                <thead>
                                    <tr>
                                        <td>Title</td>
                                        <td>Author</td>
                                        <td>Date</td>
                                        <td>Status</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="post" items="${blogList}" begin="0" end="5">
                                        <tr onclick="window.location.href = 'blog-detail?id=${post.id}'" style="cursor:pointer;">
                                            <td class="sub_info">${post.title}</td>
                                            <td>${post.author}</td>
                                            <td>${post.date}</td>
                                            <td><span class="status ${post.status.toLowerCase()}">${post.status}</span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Right: Filter & Search -->
                    <div class="filterBox">
                        <div class="cardHeader">
                            <h2>Filter & Search</h2>
                        </div>
                        <form action="blog.jsp" method="get">
                            <!-- Search -->
                            <div class="form-group">
                                <input type="text" name="q" placeholder="Search posts..." />
                                <button type="submit">Search</button>
                            </div>
                            <!-- BMI Filter -->
                            <fieldset class="form-group">
                                <legend>By BMI</legend>
                                <c:forEach var="bmi" items="${bmiList}">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" name="bmi" value="${bmi}" /> ${bmi}
                                        </label>
                                    </div>
                                </c:forEach>
                            </fieldset>
                            <!-- Time Filter -->
                            <fieldset class="form-group">
                                <legend>By Date</legend>
                                <div class="radio">
                                    <label><input type="radio" name="order" value="newest" checked/> Newest</label>
                                </div>
                                <div class="radio">
                                    <label><input type="radio" name="order" value="oldest" /> Oldest</label>
                                </div>
                            </fieldset>
                        </form>
                        <!-- Results Table -->
                        <div class="table_Wap">
                            <table>
                                <thead>
                                    <tr>
                                        <td>Image</td>
                                        <td>Title</td>
                                        <td>Status</td>
                                        <td>Content</td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="post" items="${filteredBlogList}">
                                        <tr onclick="window.location.href = 'blog-detail?id=${post.id}'" style="cursor:pointer;">
                                            <td><img src="${post.imageUrl}" alt="thumb"/></td>
                                            <td class="sub_info">${post.title}</td>
                                            <td><span class="status ${post.status.toLowerCase()}">${post.status}</span></td>
                                            <td class="sub_info">${post.content}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


                <!-- ================= New Customers ================ -->

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