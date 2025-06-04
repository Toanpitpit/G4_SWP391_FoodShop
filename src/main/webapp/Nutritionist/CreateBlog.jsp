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
                    <form action="createblog" method="post" enctype="multipart/form-data">
                        <div class="form-card">
                            <div class="form-layout">
                                <!-- Phần bên trái: Các trường nhập liệu -->
                                <div class="form-left">
                                    <div class="form-group">
                                        <label for="title">Title</label>
                                        <input type="text" id="title" name="title" value="${title != null ? title : ''}" required />
                                    </div>

                                    <div class="form-group">
                                        <label for="bmiId">BMI Category</label>
                                        <select name="bmiId" id="bmiId" required>
                                            <option value="">-- Select BMI --</option>
                                            <c:forEach var="bmi" items="${lstBMI}">
                                                <option value="${bmi.bmiID}" ${bmi.bmiID == selectedBmiId ? 'selected' : ''}>${bmi.classification}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <label>Status</label>
                                        <div class="status-options">
                                            <c:forEach var="s" items="${statusList}">
                                                <label class="radio-inline">
                                                    <input type="radio" name="status" value="${s}" ${s == status ? 'checked' : ''} />
                                                    ${s}
                                                </label>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Phần bên phải: Ảnh -->
                                <div class="form-right">
                                    <div class="form-group image-preview-group">
                                        <label for="imageUrl">Thumbnail Image</label>
                                        <img id="preview" src="#" alt="Preview Image" style="display:none; width:100%; max-height:300px; object-fit:cover; margin-bottom: 10px; border-radius: 10px;" />
                                        <input type="file" id="imageUrl" name="imageUrl" accept="image/*" onchange="previewImage(event)" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Phần content ở cuối -->
                        <div class="form-group">
                            <label for="content">Content</label>
                            <textarea id="content" name="content" rows="10">${content != null ? content : ''}</textarea>
                        </div>
                        <button type="submit" class="btn-submit">Publish</button>
                    </form>
                </div>

                <script>
                    ClassicEditor
                            .create(document.querySelector('#content'), {
                                language: 'vi',
                                toolbar: {
                                    items: [
                                        'heading', '|',
                                        'bold', 'italic', 'link', '|',
                                        'bulletedList', 'numberedList', '|',
                                        'insertTable', 'tableColumn', 'tableRow', 'mergeTableCells', 'tableProperties', 'tableCellProperties', '|',
                                        'undo', 'redo'
                                    ]
                                },
                                table: {
                                    contentToolbar: [
                                        'tableColumn', 'tableRow', 'mergeTableCells',
                                        'tableProperties', 'tableCellProperties'
                                    ]
                                }
                            })
                            .catch(error => {
                                console.error(error);
                            });

                </script>


            </div>
        </div>
        <!-- =========== Scripts =========  -->
        <script src="../JS/Nutritionist/home.js"></script>
        <script src="../JS/Nutritionist/createblog.js"></script>

        <!-- ====== ionicons ======= -->
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    </body>

</html>
