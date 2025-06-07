<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Blog</title>
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
                        <h1>Edit Blog</h1>
                        
                        <form action="updateblog" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="id" value="${blog.id}">
                            
                            <div class="form-group">
                                <label for="title">Title:</label>
                                <input type="text" id="title" name="title" value="${blog.title}" required>
                            </div>

                            <div class="form-group">
                                <label for="image">Image URL:</label>
                                <input type="text" id="image" name="imageUrl" value="${blog.imageUlr}">
                            </div>

                            <div class="form-group">
                                <label for="imageFile">Or Upload Image:</label>
                                <input type="file" id="imageFile" name="imageFile" accept="image/*">
                            </div>

                            <div class="form-group">
                                <label for="content">Content:</label>
                                <textarea id="content" name="content" rows="10" required>${blog.content}</textarea>
                            </div>

                            <div class="form-group">
                                <label for="type">Type:</label>
                                <select id="type" name="type" required>
                                    <option value="">Select Type</option>
                                    <option value="Health" ${blog.type == 'Health' ? 'selected' : ''}>Health</option>
                                    <option value="Nutrition" ${blog.type == 'Nutrition' ? 'selected' : ''}>Nutrition</option>
                                    <option value="Exercise" ${blog.type == 'Exercise' ? 'selected' : ''}>Exercise</option>
                                    <option value="Lifestyle" ${blog.type == 'Lifestyle' ? 'selected' : ''}>Lifestyle</option>
                                    <option value="Diet" ${blog.type == 'Diet' ? 'selected' : ''}>Diet</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="bmi">BMI Range:</label>
                                <select id="bmi" name="bmi" required>
                                    <option value="">Select BMI Range</option>
                                    <option value="Underweight" ${blog.bmi == 'Underweight' ? 'selected' : ''}>Underweight (< 18.5)</option>
                                    <option value="Normal" ${blog.bmi == 'Normal' ? 'selected' : ''}>Normal (18.5 - 24.9)</option>
                                    <option value="Overweight" ${blog.bmi == 'Overweight' ? 'selected' : ''}>Overweight (25 - 29.9)</option>
                                    <option value="Obese" ${blog.bmi == 'Obese' ? 'selected' : ''}>Obese (≥ 30)</option>
                                    <option value="All" ${blog.bmi == 'All' ? 'selected' : ''}>All BMI Ranges</option>
                                </select>
                            </div>

                            <div class="form-actions">
                                <button type="button" onclick="history.back()" class="btn btn-secondary">Cancel</button>
                                <button type="submit" class="btn btn-primary">Update Blog</button>
                            </div>
                        </form>
                    </main>

                    <aside class="sidebar">
                        <h2 class="sidebar-title">Current Blog Info</h2>
                        
                        <div class="current-info">
                            <p><strong>Created:</strong> 
                                <fmt:formatDate value="${blog.created_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </p>
                            <p><strong>Last Updated:</strong> 
                                <fmt:formatDate value="${blog.update_at}" pattern="yyyy-MM-dd HH:mm:ss" />
                            </p>
                            <p><strong>Author:</strong> ${blog.authorName}</p>
                        </div>

                        <div class="current-image">
                            <h3>Current Image:</h3>
                            <img src="${blog.imageUlr}" alt="Current blog image" style="width: 100%; border-radius: 8px;">
                        </div>
                    </aside>
                </div>
            </div>
        </div>
        <script src="../JS/Nutritionist/home.js"></script>
    </body>
</html>
