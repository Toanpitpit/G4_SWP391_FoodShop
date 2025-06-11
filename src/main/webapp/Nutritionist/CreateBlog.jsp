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
        <script src="assets/ckedit/ckeditor/ckeditor.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">



        <!--==============linkJS===========-->

    </head>

    <body>
        <!-- =============== Navigation ================ -->
        <div class="container">
            <jsp:include page="/Nutritionist/Common.jsp"/>
            <!-- ========================= Main ==================== -->
            <div class="main"> 
                <jsp:include page="/Nutritionist/topbar.jsp"/> 

                <!-- New Blog Form Design -->
                <div class="new-blog-form">
                    <!-- Breadcrumb -->
                    <div class="new-breadcrumb-section">
                        <nav class="new-breadcrumb-nav">
                            <a href="${pageContext.request.contextPath}/dashboadnutri" class="new-breadcrumb-link">
                                <i class="fas fa-home"></i> Trang chủ
                            </a>
                            <span class="new-separator">/</span>
                            <a href="${pageContext.request.contextPath}/listblog" class="new-breadcrumb-link">
                                Blog
                            </a>
                            <span class="new-separator">/</span>
                            <span class="new-breadcrumb-current">Tạo bài viết mới</span>
                        </nav>
                    </div>

                    <!-- Form Section -->
                    <div class="new-form-wrapper">
                        <div class="new-blog-form-content">
                            <form action="createblog" method="post" enctype="multipart/form-data" id="newBlogForm">
                                <!-- Row 1: Title & Image + BMI & Status -->
                                <div class="new-form-row two-columns">
                                    <!-- Column 1: Title & Image -->
                                    <div class="new-form-card">
                                        <h3><i class="fas fa-edit"></i> Thông tin cơ bản</h3>

                                        <div class="new-form-group">
                                            <label for="title">
                                                <i class="fas fa-heading"></i> Tiêu đề bài viết
                                            </label>
                                            <input type="text" id="title" name="title" placeholder="Nhập tiêu đề bài viết..." value="${title != null ? title : ''}" required />
                                            <small class="new-note">
                                                <i class="fas fa-info-circle"></i>
                                                Giới hạn 5 -30 từ để tối ưu SEO
                                            </small>
                                        </div>
                                        <h3><i class="fas fa-cogs"></i> Cài đặt bài viết</h3>

                                        <div class="new-form-group">
                                            <label for="bmiId">
                                                <i class="fas fa-weight"></i> Danh mục BMI
                                            </label>
                                            <select name="bmiId" id="bmiId" required>
                                                <option value="">-- Chọn danh mục BMI --</option>
                                                <c:forEach var="bmi" items="${lstBMI}">
                                                    <option value="${bmi.bmiID}" ${bmi.bmiID == selectedBmiId ? 'selected' : ''}>${bmi.classification}</option>
                                                </c:forEach>
                                            </select>
                                        </div>

                                        <div class="new-form-group">
                                            <label>
                                                <i class="fas fa-eye"></i> Trạng thái hiển thị
                                            </label>
                                            <div class="new-status-options">
                                                <label class="new-radio-option">
                                                    <input type="radio" name="status" value="Public" ${status == 'Public' ? 'checked' : ''} />
                                                    <span class="new-radio-label">
                                                        <i class="fas fa-globe"></i> Public
                                                    </span>
                                                </label>
                                                <label class="new-radio-option">
                                                    <input type="radio" name="status" value="Draft" ${status == 'Draft' ? 'checked' : ''} />
                                                    <span class="new-radio-label">
                                                        <i class="fas fa-file-alt"></i> Draft
                                                    </span>
                                                </label>
                                                <label class="new-radio-option">
                                                    <input type="radio" name="status" value="Private" ${status == 'Private' ? 'checked' : ''} />
                                                    <span class="new-radio-label">
                                                        <i class="fas fa-lock"></i> Private
                                                    </span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="new-form-group new-image-preview-group">
                                            <label for="imageUrl">
                                                <i class="fas fa-image"></i> Ảnh Thumbnail
                                            </label>
                                            <div class="new-image-preview-container" onclick="document.getElementById('imageUrl').click();">
                                                <img id="new-preview" src="#" alt="Preview Image" />
                                                <div class="new-upload-placeholder" id="newUploadPlaceholder">
                                                    <i class="fas fa-cloud-upload-alt"></i>
                                                    <div>Click để chọn ảnh thumbnail</div>
                                                    <small>Hỗ trợ JPG, PNG, GIF</small>
                                                </div>
                                            </div>
                                            <input type="file" id="imageUrl" name="imageUrl" accept="image/*" onchange="newPreviewImage(event)" />
                                            <small class="new-note">
                                                <i class="fas fa-exclamation-triangle"></i>
                                                Kích thước tối đa 5MB. Tỷ lệ khuyến nghị 16:9
                                            </small>
                                        </div>
                                    </div>

                                    <!-- Column 2: BMI Category & Status -->
                                    <div class="new-form-card">
                                        
                                        <div class="new-form-row full-width">
                                            <div class="new-form-card">
                                                <h3><i class="fas fa-file-alt"></i> Nội dung bài viết</h3>
                                                <div class="new-form-group">
                                                    <label for="editor">
                                                        <i class="fas fa-pen"></i> Nội dung chi tiết
                                                    </label>
                                                    <textarea id="editor" name="content" rows="10" placeholder="Nhập nội dung bài viết của bạn...&#10;&#10;Gợi ý:&#10;- Giới thiệu chủ đề&#10;- Phân tích vấn đề&#10;- Đưa ra lời khuyên&#10;- Kết luận">${content != null ? content : ''}</textarea>
                                                    <small class="new-note">
                                                        <i class="fas fa-lightbulb"></i>
                                                        Sử dụng CKEditor để định dạng văn bản đẹp hơn
                                                    </small>
                                                </div>
                                            </div>
                                            <div class="new-submit-container">
                                                <button type="submit" class="new-btn-submit">
                                                    <i class="fas fa-check"></i>
                                                    Xuất bản bài viết
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <c:if test="${not empty Errmess}">
                    <div class="alert alert-danger" style="display: none;">${Errmess}</div>
                </c:if>

                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success" style="display: none;">${successMessage}</div>
                </c:if>

                <c:if test="${not empty warningMessage}">
                    <div class="alert alert-warning" style="display: none;">${warningMessage}</div>
                </c:if>

                <c:if test="${not empty infoMessage}">
                    <div class="alert alert-info" style="display: none;">${infoMessage}</div>
                </c:if>
                <script>
                    CKEDITOR.replace('editor', {
                        versionCheck: false
                    });

                    function newPreviewImage(event) {
                        const file = event.target.files[0];
                        const preview = document.getElementById('new-preview');
                        const placeholder = document.getElementById('newUploadPlaceholder');
                        const container = document.querySelector('.new-image-preview-container');

                        if (file) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                preview.src = e.target.result;
                                preview.style.display = 'block';
                                placeholder.style.display = 'none';
                                container.classList.add('has-image');
                            }
                            reader.readAsDataURL(file);
                        }
                    }

                    // Form submission with loading state
                    document.getElementById('newBlogForm').addEventListener('submit', function () {
                        const button = document.querySelector('.new-btn-submit');
                        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
                        document.querySelector('.new-blog-form').classList.add('loading');
                    });

                    // Auto-resize textarea
                    const textarea = document.getElementById('editor');
                    if (textarea) {
                        textarea.addEventListener('input', function () {
                            this.style.height = 'auto';
                            this.style.height = Math.max(this.scrollHeight, 200) + 'px';
                        });
                    }
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
