<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title></title>
    <!-- ======= Styles ====== -->
    <link rel="stylesheet" href="../CSS/Ncss/common.css">
    <link rel="stylesheet" href="../CSS/Ncss/createblog.css">
    <!--==============linkJS===========-->
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>

</head>

<body>
    <!-- =============== Navigation ================ -->
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
           
         
     <div class="form-container">
         <h2>Blog Post</h2>
         <form action="CreateBlogServlet" method="post" enctype="multipart/form-data">
             <div class="form-card">
                 <div class="form-group">
                     <label for="bmiId">BMI Category</label>
                     <select name="bmiId" id="bmiId" required>
                         <option value="">-- Select BMI --</option>
                         <c:forEach var="bmi" items="${bmiList}">
                             <option value="${bmi.id}" ${bmi.id == selectedBmiId ? 'selected' : ''}>${bmi.name}</option>
                         </c:forEach>
                     </select>
                 </div>

                 <div class="form-group">
                     <label for="title">Title</label>
                     <input type="text" id="title" name="title" value="${title != null ? title : ''}" required />
                 </div>
                 <div class="form-group">
                     <label for="imageUrl">Image</label>
                     <input type="file" id="imageUrl" name="imageUrl" accept="image/*" />
                 </div>
                 <div class="form-group">
                     <label for="content">Content</label>
                     <textarea id="content" name="content" rows="10">${content != null ? content : ''}</textarea>
                 </div>
                 <div class="form-group">
                     <label for="status">Status</label>
                     <select id="status" name="status" required>
                         <option value="Draft" ${status == 'Draft' ? 'selected' : ''}>Draft</option>
                         <option value="Published" ${status == 'Published' ? 'selected' : ''}>Published</option>
                         <option value="Archived" ${status == 'Archived' ? 'selected' : ''}>Archived</option>
                     </select>
                 </div>
                 <button type="submit" class="btn-submit">Publish</button>
             </div>
         </form>
     </div>

     <script>
             ClassicEditor
                .create(document.querySelector('#content'), {
                    language: 'vi'
                })
                .catch(error => {
                    console.error(error);
            });
     </script>


    </div>
    </div>>
    <!-- =========== Scripts =========  -->
    <script src="../JS/Nutritionist/home.js"></script>

    <!-- ====== ionicons ======= -->
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</body>

</html>