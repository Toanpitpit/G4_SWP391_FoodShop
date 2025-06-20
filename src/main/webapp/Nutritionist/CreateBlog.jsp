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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">


        <!--==============linkJS===========-->

    </head>

    <body>
        <!-- =============== Navigation ================ -->
        <jsp:include page="/Nutritionist/nav.jsp"/>  
        <!-- Main Header -->
        <jsp:include page="/Nutritionist/main-header.jsp"/>  
        <!-- ========================= Main ==================== -->
        <main class="main-content" id="mainContent">
            
            <div class="content-wrapper">
            <c:choose>  
                <c:when test="${not empty blogU}">
                    <div class="new-blog-form">
                        <!-- Breadcrumb -->
                        <div class="breadcrumb-section">
                            <div class="breadcrumb-container">
                                <h1 class="page-title" style="padding-left: 32px">🍀 Chia Sẻ Để Khỏe Mỗi Ngày</h1>
                                <nav class="breadcrumb-nav">
                                    <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item"> 
                                        <i class="fas fa-home"></i>Home
                                    </a>
                                    <span class="breadcrumb-separator">
                                        <i class="bi bi-chevron-right"></i>
                                    </span>
                                    <a href="${pageContext.request.contextPath}/nutricontrol?action=displayblog" class="new-breadcrumb-link">
                                        Blog
                                    </a>
                                    <span class="breadcrumb-separator">
                                        <i class="bi bi-chevron-right"></i>
                                    </span>
                                    <span class="breadcrumb-item active">Chỉnh Sửa bài viết</span>
                                </nav>
                            </div>
                        </div>
                        <div class="new-form-wrapper">
                            <div class="new-blog-form-content">
                                <form action="nutricontrol?action=updateBlog&id=${blogU.bID}" method="post" enctype="multipart/form-data" id="newBlogForm">

                                    <div class="new-form-row two-columns">

                                        <div class="new-form-card">
                                            <h3><i class="fas fa-edit"></i> Thông tin cơ bản</h3>
                                            <div class="new-form-group" >
                                                <label for="title">
                                                    <i class="fas fa-id"></i> ID
                                                </label>
                                                <input type="text" name="blogId" value="${blogU.bID}" readonly/>
                                            </div>
                                            <div class="new-form-group">
                                                <label for="title">
                                                    <i class="fas fa-heading"></i> Tiêu đề bài viết <i style="color:red">*</i>
                                                </label>
                                                <input type="text" id="title" name="title" placeholder="Nhập tiêu đề bài viết..."  value="${not empty param.title ? param.title : (not empty blogU ? blogU.title : '')}" required />
                                                <small class="new-note">
                                                    <i class="fas fa-info-circle"></i>
                                                    Giới hạn 5 -30 từ để tối ưu SEO
                                                </small>
                                            </div>
                                            <h3><i class="fas fa-cogs"></i> Cài đặt bài viết</h3>

                                            <div class="new-form-group">
                                                <label for="bmiId">
                                                    <i class="fas fa-weight"></i> Danh mục BMI <i style="color:red">*</i>
                                                </label>
                                                <c:set var="selectedBmiId" value="${empty selectedBmiId ? blogU.bmiId : selectedBmiId}" />
                                                <select name="bmiId" id="bmiId" required>
                                                    <option value="">-- Chọn danh mục BMI --</option>
                                                    <c:forEach var="bmi" items="${lstBMI}">
                                                        <option value="${bmi.bmiID}" ${bmi.bmiID == selectedBmiId ? 'selected' : ''}>${bmi.classification}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="new-form-group">
                                                <label>
                                                    <i class="fas fa-eye"></i> Trạng thái hiển thị <i style="color:red">*</i>
                                                </label>
                                                <div class="new-status-options">
                                                    <c:set var="status" value="${empty status ? blogU.status : status}" />
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
                                                    <i class="fas fa-image"></i> Ảnh Thumbnail <i style="color:red">*</i>
                                                </label>
                                                <div class="new-image-preview-container" onclick="document.getElementById('imageEdit').click();">
                                                    <img id="new-preview-edit"
                                                         src="${empty blogU.imageUlr ? '' : blogU.imageUlr}"
                                                         alt="Preview Image"
                                                         style="${empty blogU.imageUlr ? 'display:none;' : 'display:block;'}"
                                                         />

                                                    <div class="new-upload-placeholder" id="newUploadPlaceholder" style="${not empty blogU.imageUlr ? 'display:none;' : ''}">
                                                        <i class="fas fa-cloud-upload-alt"></i>
                                                        <div>Click để chọn ảnh thumbnail</div>
                                                        <small>Hỗ trợ JPG, PNG, GIF</small>
                                                    </div>
                                                </div>
                                                <input name="imageUrl" type="file" id="imageEdit" onchange="previewImageEdit(event)">
                                                <small class="new-note">
                                                    <i class="fas fa-exclamation-triangle"></i>
                                                    Kích thước tối đa 5MB. Tỷ lệ khuyến nghị 16:9
                                                </small>
                                            </div>
                                            <small class="new-note">
                                                <i style="color:red">*</i> Trường Bát buộc phải nhập 
                                            </small>
                                        </div>

                                        <!-- Column 2: BMI Category & Status -->
                                        <div class="new-form-card">

                                            <div class="new-form-row full-width">
                                                <div class="new-form-card">
                                                    <h3><i class="fas fa-file-alt"></i> Nội dung bài viết </h3>
                                                    <div class="new-form-group">
                                                        <c:set var="content" value="${not empty blogU.content ? blogU.content : param.content}" />
                                                        <label for="editor">
                                                            <i class="fas fa-pen"></i> Nội dung chi tiết
                                                        </label>
                                                        <textarea id="editor" name="content" rows="10" placeholder="Nhập nội dung bài viết của bạn...&#10;&#10;Gợi ý:&#10;- Giới thiệu chủ đề&#10;- Phân tích vấn đề&#10;- Đưa ra lời khuyên&#10;- Kết luận">${content != null ? content : ''}</textarea>
                                                        <small class="new-note">
                                                            <i class="fas fa-lightbulb"></i>
                                                            Chúng tôi khuyến khích khôgn nên copy-paste cả dạng media.
                                                        </small>
                                                    </div>
                                                </div>
                                                <div class="new-submit-container">
                                                    <button type="submit" class="new-btn-submit">
                                                        <i class="fas fa-check"></i>
                                                        Save Change
                                                    </button>
<!--                                                    <button id="view" type="button" class="new-btn-submit">
                                                        <i class="fas fa-eye"></i>
                                                        View
                                                    </button>-->
<!--                                                    <button type="button" class="new-btn-preview" data-bs-toggle="modal" data-bs-target="#previewModal"><i class="fas fa-eye">View</i></button>-->

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="new-blog-form">
                        <!-- Breadcrumb -->
                        <div class="breadcrumb-section">
                            <div class="breadcrumb-container">
                                <h1 class="page-title" style="padding-left: 32px">🍀 Chia Sẻ Để Khỏe Mỗi Ngày</h1>
                                <nav class="breadcrumb-nav">
                                    <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item"> 
                                        <i class="fas fa-home"></i>Home
                                    </a>
                                    <span class="breadcrumb-separator">
                                        <i class="bi bi-chevron-right"></i>
                                    </span>
                                    <a href="${pageContext.request.contextPath}/nutricontrol?action=displayblog" class="new-breadcrumb-link">
                                        Blog
                                    </a>
                                    <span class="breadcrumb-separator">
                                        <i class="bi bi-chevron-right"></i>
                                    </span>
                                    <span class="breadcrumb-item active">Create new Blog</span>
                                </nav>
                            </div>
                        </div>
                        <!-- Form Section -->
                        <div class="new-form-wrapper">
                            <div class="new-blog-form-content">
                                <form action="nutricontrol?action=createblog" method="post" enctype="multipart/form-data" id="newBlogForm">
                                    <!-- Row 1: Title & Image + BMI & Status -->
                                    <div class="new-form-row two-columns">
                                        <!-- Column 1: Title & Image -->
                                        <div class="new-form-card">
                                            <h3><i class="fas fa-edit"></i> Thông tin cơ bản</h3>

                                            <div class="new-form-group">
                                                <label for="title">
                                                    <i class="fas fa-heading"></i> Tiêu đề bài viết <i style="color:red">*</i>
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
                                                    <i class="fas fa-weight"></i> Danh mục BMI <i style="color:red">*</i>
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
                                                    <i class="fas fa-eye"></i> Trạng thái hiển thị <i style="color:red">*</i>
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
                                                    <i class="fas fa-image"></i> Ảnh Thumbnail <i style="color:red">*</i>
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
                                            <small class="new-note">
                                                <i style="color:red">*</i> Trường Bát buộc phải nhập 
                                            </small>
                                        </div>

                                        <!-- Column 2: BMI Category & Status -->
                                        <div class="new-form-card">

                                            <div class="new-form-row full-width">
                                                <div class="new-form-card">
                                                    <h3><i class="fas fa-file-alt"></i> Nội dung bài viết </h3>
                                                    <div class="new-form-group">
                                                        <label for="editor">
                                                            <i class="fas fa-pen"></i> Nội dung chi tiết
                                                        </label>
                                                        <textarea id="editor" name="content" rows="10" required placeholder="Nhập nội dung bài viết của bạn...&#10;&#10;Gợi ý:&#10;- Giới thiệu chủ đề&#10;- Phân tích vấn đề&#10;- Đưa ra lời khuyên&#10;- Kết luận">${content != null ? content : ''}</textarea>
                                                        <small class="new-note">
                                                            <i class="fas fa-lightbulb"></i>
                                                            Sử dụng CKEditor để định dạng văn bản đẹp hơn <i style="color:red">*</i>
                                                        </small>
                                                    </div>
                                                </div>
                                                <div class="new-submit-container">
                                                    <button type="submit" class="new-btn-submit">
                                                        <i class="fas fa-check"></i>
                                                        Tạo mới
                                                    </button>
<!--                                                    <button type="button" id="view" class="new-btn-submit">
                                                        <i class="fas fa-eye"></i>
                                                        View
                                                    </button>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
             </div>
             <jsp:include page="/Nutritionist/footer.jsp"/>  
        </main>
        
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
                versionCheck: false,
                height: 300
            });

            document.getElementById('newBlogForm').addEventListener('submit', function () {
                const button = document.querySelector('.new-btn-submit');
                button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
                document.querySelector('.new-blog-form').classList.add('loading');
            });

            const textarea = document.getElementById('editor');
            if (textarea) {
                textarea.addEventListener('input', function () {
                    this.style.height = 'auto';
                    this.style.height = Math.max(this.scrollHeight, 500) + 'px';
                });
            }          
        </script>
        
        <!-- =========== Scripts =========  -->
       
        <script src="../JS/Nutritionist/common.js"></script>
        <script src="../JS/Nutritionist/createblog.js"></script>
        

        <!-- ====== ionicons ======= -->
        <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
        <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    </body>

</html>
