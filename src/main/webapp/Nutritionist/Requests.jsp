
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
                    <div class="user">
                        <img src="assets/imgs/customer01.jpg" alt="">
                    </div>
                </div>

                <div class="blog-container">
                    <main class="main-content">
                        <img src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80" alt="Online Shopping" class="hero-image">

                        <div class="content-wrapper">
                            <h1 class="blog-title">The Pros And Cons Of Online Shopping: Is It Right For You?</h1>

                            <div class="meta-info">
                                <div class="author-info">
                                    <div class="author-avatar">EP</div>
                                    <span class="author-name">Ezat Popy</span>
                                </div>
                                <span class="publish-date">August 9, 2023</span>
                                <span class="blog-tag">E-commerce</span>
                            </div>

                            <div class="blog-content">
                                <p>In a network security system, security flaws are crucial. Fuzzing is a vulnerability detection technique that is extensively utilized to prevent damage before it occurs. Traditional fuzz testing, on the other hand, has a nothin number of difficulties, including how to successfully. Amet minim mollit non deserunt ullamco est sit alique dolor domet consectetur adipiscing elit. With the sequential duo enim velit mollit xercitation. Now that the Covid 19 pandemic lockdown has been lifted from most countries around the world, travelers have been spreading their wings again and going on long-awaited.</p>

                                <p>Amet minim mollit non deserunt ullamco est sit alique altrough dolor domet sint. Velit ther sequat duis enim velit mollit xercitation. Now that the Covid 19 pandemic lockdown has been lifted from.</p>
                            </div>

                            <div class="quote">
                                "The goal of a designer is to listen, observe, understand, sympathize, empathize, synthesize, and glean insights that enable him or her to make the invisible evisbile. observe, understand, sympathize."
                            </div>

                            <div class="blog-content">
                                <p>In a network security system, security flaws are crucial. Fuzzing is a vulnerability detection technique that is extensively utilized to prevent damage before it occurs. Traditional fuzz testing, on the other hand, has a nothin number of difficulties, including how to the successfully. Amet minim mollit non deserunt ullamco est sit alique altrough</p>
                            </div>
                        </div>
                    </main>

                    <aside class="sidebar">
                        <h2 class="sidebar-title">Bài viết liên quan</h2>

                        <article class="related-post">
                            <img src="https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" alt="Digital Marketing" class="related-image">
                            <div class="related-content">
                                <h3 class="related-title">Digital Marketing Strategies for Modern Business</h3>
                                <span class="related-tag">Marketing</span>
                            </div>
                        </article>
                    </aside>
                </div>
            </div>
            <div>
                <script src="../JS/Nutritionist/home.js"></script>
                </body>
                </html>
