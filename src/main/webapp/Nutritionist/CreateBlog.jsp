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
        <script src="assets/ckeditor/ckeditor.js"></script>

        <!--==============linkJS===========-->

    </head>

    <body>
        <!-- =============== Navigation ================ -->
        <div class="container">
           <jsp:include page="/Nutritionist/Common.jsp"/>
            <!-- ========================= Main ==================== -->
            <div class="main"> 
                <jsp:include page="/Nutritionist/topbar.jsp"/> 
                <h2 class="form-title">🥗 Blog Post</h2>
                <div class="form_box" >
                    <div class="form-container">
                        <form action="createblog" method="post" enctype="multipart/form-data">
                            <div class="form-card">
                                <div class="form-group image-preview-group">
                                    <label for="imageUrl">Thumbnail Image</label>
                                    <img id="preview" src="#" alt="Preview Image" style="display:none; width:100%; max-height:500px; object-fit:cover; margin-bottom: 10px; border-radius: 10px;" />
                                    <input type="file" id="imageUrl" name="imageUrl" accept="image/*" onchange="previewImage(event)" />
                                </div>

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
                                        <label class="radio-inline">
                                            <input type="radio" name="status" value="Public" ${s == status ? 'checked' : ''} />
                                            Public
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="status" value="Draft" ${s == status ? 'checked' : ''} />
                                            Draft
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="status" value="Private" ${s == status ? 'checked' : ''} />
                                            Private
                                        </label>
                                    </div>
                                </div>

                                <!-- Content -->
                                <div class="form-group">
                                    <label for="editor">Content</label>
                                    <textarea id="editor" name="content" rows="10">${content != null ? content : ''}</textarea>
                                </div>

                                <button type="submit" class="btn-submit">Publish</button>
                            </div>
                        </form>

                    </div>
                </div>
                <script>
                    CKEDITOR.replace('editor')
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
