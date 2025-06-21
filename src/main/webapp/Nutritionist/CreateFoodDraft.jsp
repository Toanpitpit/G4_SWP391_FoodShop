<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nutritionist Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&family=Rubik:wght@500&family=Nunito:wght@600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;600;700&display=swap" rel="stylesheet">
        <script src="${pageContext.request.contextPath}/assets/ckedit/ckeditor/ckeditor.js"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/dashboard.css" >
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">  
        <style>


            .form-container {
                width: 100%;
                background: white;
                min-height: 100vh;
            }

            .form-header {
                background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
                padding: 30px 0;
                text-align: center;
                color: white;
                position: relative;
                overflow: hidden;
            }

            .form-header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
                opacity: 0.3;
            }

            .form-header h1 {
                font-size: 2.2rem;
                font-weight: 700;
                margin-bottom: 8px;
                position: relative;
                z-index: 1;
            }

            .form-header p {
                font-size: 1rem;
                opacity: 0.9;
                position: relative;
                z-index: 1;
            }

            .form-content {
                width: 100%;
                max-width: none;
                padding: 0;
            }

            .main-layout {
                display: grid;
                grid-template-columns: 1fr 1fr;
                min-height: calc(100vh - 120px);
            }

            .left-section {
                background: #ffffff;
                padding: 40px;
                border-right: 1px solid #e2e8f0;
            }

            .right-section {
                background: #f8fafc;
                padding: 40px;
            }

            .section-title {
                display: flex;
                align-items: center;
                gap: 12px;
                margin-bottom: 30px;
                font-size: 1.3rem;
                font-weight: 600;
                color: #2d3748;
                padding-bottom: 15px;
                border-bottom: 2px solid #e2e8f0;
            }

            .section-icon {
                width: 36px;
                height: 36px;
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                font-size: 1.1rem;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-label {
                display: block;
                font-weight: 500;
                color: #4a5568;
                margin-bottom: 8px;
                font-size: 0.95rem;
            }

            .form-control, .form-select {
                width: 100%;
                padding: 12px 16px;
                border: 2px solid #e2e8f0;
                border-radius: 8px;
                font-size: 1rem;
                transition: all 0.3s ease;
                background: white;
            }

            .form-control:focus, .form-select:focus {
                outline: none;
                border-color: #4facfe;
                box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
            }

            .category-group {
                display: flex;
                gap: 10px;
                align-items: end;
            }

            .category-select {
                flex: 1;
            }

            .btn-new-category {
                padding: 12px 20px;
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
                white-space: nowrap;
            }

            .btn-new-category:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(72, 187, 120, 0.3);
            }

            .bmi-grid {
                min-height:150px;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
            }

            .bmi-option {
                display: flex;
                align-items: center;
                gap: 12px;
                padding: 15px;
                background: #f7fafc;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
                border: 2px solid transparent;
            }

            .bmi-option:hover {
                background: #edf2f7;
            }

            .bmi-option.selected {
                background: rgba(79, 172, 254, 0.1);
                border-color: #4facfe;
            }

            .bmi-checkbox {
                width: 18px;
                height: 18px;
                accent-color: #4facfe;
            }

            .bmi-label {
                font-weight: 500;
                font-size: 0.9rem;
            }

            .bmi-range {
                font-size: 0.8rem;
                color: #a0aec0;
            }

            .image-upload-section {
                background: white;
                border-radius: 12px;
                padding: 30px;
                border: 1px solid #e2e8f0;
                margin-bottom: 30px;
            }

            .image-upload-area {
                border: 2px dashed #cbd5e0;
                border-radius: 12px;
                padding: 40px;
                text-align: center;
                background: #f7fafc;
                transition: all 0.3s ease;
                cursor: pointer;
                position: relative;
                overflow: hidden;
            }

            .image-upload-area:hover {
                border-color: #4facfe;
                background: rgba(79, 172, 254, 0.05);
            }

            .image-upload-area.has-image {
                padding: 0;
                border: none;
            }

            .upload-icon {
                font-size: 2.5rem;
                color: #a0aec0;
                margin-bottom: 16px;
            }

            .upload-text {
                color: #4a5568;
                font-weight: 500;
                margin-bottom: 8px;
            }

            .upload-subtext {
                color: #a0aec0;
                font-size: 0.9rem;
            }

            .image-preview {
                width: 100%;
                height: 250px;
                object-fit: cover;
                border-radius: 12px;
            }

            .text-editor-section {
                background: white;
                border-radius: 12px;
                padding: 30px;
                border: 1px solid #e2e8f0;
            }

            .text-editor-wrapper {
                border: 2px solid #e2e8f0;
                border-radius: 8px;
                overflow: hidden;
                transition: all 0.3s ease;
                margin-bottom: 25px;
            }

            .text-editor-wrapper:focus-within {
                border-color: #4facfe;
                box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
            }

            .form-textarea {
                width: 100%;
                min-height: 120px;
                padding: 16px;
                border: none;
                outline: none;
                resize: vertical;
                font-family: inherit;
                font-size: 1rem;
                line-height: 1.6;
            }

            .submit-section {
                grid-column: 1 / -1;
                text-align: center;
                padding: 40px;
                background: white;
                border-top: 1px solid #e2e8f0;
            }

            .btn-submit {
                padding: 16px 50px;
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
                color: white;
                border: none;
                border-radius: 8px;
                font-size: 1.1rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .btn-submit:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(79, 172, 254, 0.3);
            }

            .btn-submit:active {
                transform: translateY(0);
            }

            .progress-bar {
                position: sticky;
                top: 0;
                height: 4px;
                background: #e2e8f0;
                z-index: 100;
            }

            .progress-fill {
                height: 100%;
                background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%);
                width: 0%;
                transition: width 0.3s ease;
            }

            @media (max-width: 1024px) {
                .main-layout {
                    grid-template-columns: 1fr;
                }

                .left-section,
                .right-section {
                    padding: 30px 20px;
                }

                .left-section {
                    border-right: none;
                    border-bottom: 1px solid #e2e8f0;
                }

                .bmi-grid {
                    grid-template-columns: 1fr;
                }
            }

            @media (max-width: 768px) {
                .form-header {
                    padding: 20px;
                }

                .form-header h1 {
                    font-size: 1.8rem;
                }

                .category-group {
                    flex-direction: column;
                    align-items: stretch;
                }

                .left-section,
                .right-section {
                    padding: 20px 15px;
                }
            }
        </style>
    </head>
    <body>

        <jsp:include page="/Nutritionist/nav.jsp"/>  

        <jsp:include page="/Nutritionist/main-header.jsp"/>  
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

        <main class="main-content" id="mainContent">
            <c:choose>
                <c:when test="${empty fooddraftedit}">
                    <div class="breadcrumb-section">
                        <div class="breadcrumb-container">
                            <h1 class="page-title" style="padding-left: 32px">️ Tạo Món Ăn Mới</h1>
                            <nav class="breadcrumb-nav">
                                <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Home</a>
                                <span class="breadcrumb-separator">
                                    <i class="bi bi-chevron-right"></i>
                                </span>
                                <a href="${pageContext.request.contextPath}/nutricontrol?action=showfooddraft" class="breadcrumb-item">Food Sugesstion</a>
                                <span class="breadcrumb-separator">
                                    <i class="bi bi-chevron-right"></i>
                                </span>
                                <span class="breadcrumb-item active">Create Food Sugesstion</span>
                            </nav>
                        </div>
                    </div>
                    <form action="nutricontrol?action=createfooddraft" method="post" enctype="multipart/form-data" id="foodForm">

                        <div class="main-layout">
                            <div class="left-section">
                                <div class="section-title">
                                    <div class="section-icon">
                                        <i class="bi bi-info-circle"></i>
                                    </div>
                                    Thông tin cơ bản
                                </div>


                                <div class="form-group">
                                    <label class="form-label" for="name">Tên món ăn:</label>
                                    <input type="text" class="form-control" name="name" id="name" required placeholder="Nhập tên món ăn...">
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="price">Giá (VND):</label>
                                    <input type="number" class="form-control" name="price" id="price" min="0"  required placeholder="0">
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Danh mục:</label>
                                    <div class="category-group">
                                        <div class="category-select">
                                            <select class="form-select" name="category" id="category">
                                                <option value="">Chọn danh mục...</option>
                                                <c:choose>
                                                    <c:when test="${not empty lstC}">
                                                        <c:forEach var="ca" items="${lstC}">
                                                            <option value="${ca.catID}">${ca.caName}</option>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="">Không có dữ liệu</option>
                                                    </c:otherwise>
                                                </c:choose>

                                            </select>
                                        </div>
                                        <button type="button" class="btn-new-category" onclick="">
                                            + Tạo mới
                                        </button>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Ảnh minh họa:</label>
                                    <div class="image-upload-area" id="imageUploadArea" onclick="document.getElementById('imageInput').click()">
                                        <input type="file" name="image" id="imageInput" accept="image/*" style="display: none;" onchange="previewImage(this)">
                                        <div id="uploadPlaceholder">
                                            <div class="upload-icon">
                                                <i class="bi bi-cloud-upload"></i>
                                            </div>
                                            <div class="upload-text">Chọn file...</div>
                                            <div class="upload-subtext">Chỉ hỗ trợ JPG, PNG, GIF</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">» Xem trước ảnh:</label>
                                    <div id="imagePreview" style="border: 1px dashed #cbd5e0; border-radius: 8px; padding: 20px; text-align: center; color: #a0aec0; font-size: 0.9rem; background: #f7fafc; display: none;">
                                        <img id="previewImageTag" style="max-width: 100%; max-height: 300px; border-radius: 20px;" />
                                    </div>
                                </div>

                            </div>

                            <div class="right-section">
                                <div class="section-title">
                                    <div class="section-icon">
                                        <i class="bi bi-heart-pulse"></i>
                                    </div>
                                    Thông tin chi tiết
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Recommend cho BMI:</label>
                                    <div class="bmi-grid">
                                        <c:choose>
                                            <c:when test="${not empty lstBMI}">
                                                <c:forEach var="bi" items="${lstBMI}">
                                                    <div class="bmi-option">
                                                        <input type="checkbox" class="bmi-checkbox" name="bmi" value="${bi.bmiID}" id="underweight">
                                                        <div>
                                                            <div class="bmi-label">${bi.classification}</div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bmi-option">
                                                    <div>
                                                        <div style="display:  flex ; justify-content: center;
                                                             align-content: center; color: red; ">Không có dữ liêu</div>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                    <small style="text-align: center; display: flex;justify-content: center
                                           ">Giá trị mặc định sẽ là Chung nếu không có mục nào được chọn</small>
                                </div>

                                <div class="text-editor-section">
                                    <div class="form-group">
                                        <label class="form-label">Thành phần món ăn:</label>
                                        <div class="text-editor-wrapper">
                                            <textarea class="form-textarea" name="ingredients" id="ingredients"  placeholder="Thành phần ...">${param.ingredients != null ? param.ingredients : ''}</textarea>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Mô tả món ăn:</label>
                                        <div class="text-editor-wrapper">
                                            <textarea class="form-textarea" name="description" id="description" placeholder="Mô tả ...">${param.description != null ? param.description : ''}</textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="submit-section">
                                <button type="submit" class="btn-submit">
                                    TẠO MÓN ĂN
                                </button>
                            </div>
                        </div>
                    </form>
                </c:when>
                <c:otherwise>
                    <div class="breadcrumb-section">
                        <div class="breadcrumb-container">
                            <h1 class="page-title" style="padding-left: 32px">️ Tạo Món Ăn Mới</h1>
                            <nav class="breadcrumb-nav">
                                <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Home</a>
                                <span class="breadcrumb-separator">
                                    <i class="bi bi-chevron-right"></i>
                                </span>
                                <span class="breadcrumb-item active">Dashboard</span>
                            </nav>
                        </div>
                    </div>
                    <form action="nutricontrol?action=createfooddraft" method="post" enctype="multipart/form-data" id="foodForm">

                        <div class="main-layout">
                            <div class="left-section">
                                <div class="section-title">
                                    <div class="section-icon">
                                        <i class="bi bi-info-circle"></i>
                                    </div>
                                    Thông tin cơ bản
                                </div>


                                <div class="form-group">
                                    <label class="form-label" for="name">Tên món ăn:</label>
                                    <input type="text" class="form-control" name="name" id="name" required placeholder="Nhập tên món ăn...">
                                </div>

                                <div class="form-group">
                                    <label class="form-label" for="price">Giá (VND):</label>
                                    <input type="number" class="form-control" name="price" id="price" min="0"  required placeholder="0">
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Danh mục:</label>
                                    <div class="category-group">
                                        <div class="category-select">
                                            <select class="form-select" name="category" id="category">
                                                <option value="">Chọn danh mục...</option>
                                                <c:choose>
                                                    <c:when test="${not empty lstC}">
                                                        <c:forEach var="ca" items="${lstC}">
                                                            <option value="${ca.catID}">${ca.caName}</option>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="">Không có dữ liệu</option>
                                                    </c:otherwise>
                                                </c:choose>

                                            </select>
                                        </div>
                                        <button type="button" class="btn-new-category" onclick="">
                                            + Tạo mới
                                        </button>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Ảnh minh họa:</label>
                                    <div class="image-upload-area" id="imageUploadArea" onclick="document.getElementById('imageInput').click()">
                                        <input type="file" name="image" id="imageInput" accept="image/*" style="display: none;" onchange="previewImage(this)">
                                        <div id="uploadPlaceholder">
                                            <div class="upload-icon">
                                                <i class="bi bi-cloud-upload"></i>
                                            </div>
                                            <div class="upload-text">Chọn file...</div>
                                            <div class="upload-subtext">Chỉ hỗ trợ JPG, PNG, GIF</div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">» Xem trước ảnh:</label>
                                    <div id="imagePreview" style="border: 1px dashed #cbd5e0; border-radius: 8px; padding: 20px; text-align: center; color: #a0aec0; font-size: 0.9rem; background: #f7fafc; display: none;">
                                        <img id="previewImageTag" style="max-width: 100%; max-height: 300px; border-radius: 20px;" />
                                    </div>
                                </div>

                            </div>

                            <div class="right-section">
                                <div class="section-title">
                                    <div class="section-icon">
                                        <i class="bi bi-heart-pulse"></i>
                                    </div>
                                    Thông tin chi tiết
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Recommend cho BMI:</label>
                                    <div class="bmi-grid">
                                        <c:choose>
                                            <c:when test="${not empty lstBMI}">
                                                <c:forEach var="bi" items="${lstBMI}">
                                                    <div class="bmi-option">
                                                        <input type="checkbox" class="bmi-checkbox" name="bmi" value="${bi.bmiID}" id="underweight">
                                                        <div>
                                                            <div class="bmi-label">${bi.classification}</div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="bmi-option">
                                                    <div>
                                                        <div style="display:  flex ; justify-content: center;
                                                             align-content: center; color: red; ">Không có dữ liêu</div>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>
                                    <small style="text-align: center; display: flex;justify-content: center
                                           ">Giá trị mặc định sẽ là Chung nếu không có mục nào được chọn</small>
                                </div>

                                <div class="text-editor-section">
                                    <div class="form-group">
                                        <label class="form-label">Thành phần món ăn:</label>
                                        <div class="text-editor-wrapper">
                                            <textarea class="form-textarea" name="ingredients" id="ingredients"  placeholder="Thành phần ...">${param.ingredients != null ? param.ingredients : ''}</textarea>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label">Mô tả món ăn:</label>
                                        <div class="text-editor-wrapper">
                                            <textarea class="form-textarea" name="description" id="description" placeholder="Mô tả ...">${param.description != null ? param.description : ''}</textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="submit-section">
                                <button type="submit" class="btn-submit">
                                    TẠO MÓN ĂN
                                </button>
                            </div>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>


            <jsp:include page="/Nutritionist/footer.jsp"/>  
        </main>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/common.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/ckeditor/4.22.1/ckeditor.js"></script>
        <script>
                                        CKEDITOR.replace('ingredients', {
                                            height: 200,
                                            versionCheck: false,
                                            toolbar: [
                                                {name: 'basicstyles', items: ['Bold', 'Italic', 'Underline']},
                                                {name: 'paragraph', items: ['NumberedList', 'BulletedList', 'JustifyLeft', 'JustifyCenter', 'JustifyRight']},
                                                {name: 'styles', items: ['Format']},
                                                {name: 'clipboard', items: ['Undo', 'Redo']}
                                            ],
                                            removePlugins: 'image,table,media,flash',
                                        });
                                        CKEDITOR.replace('description', {
                                            height: 200,
                                            versionCheck: false,
                                            toolbar: [
                                                {name: 'basicstyles', items: ['Bold', 'Italic', 'Underline']},
                                                {name: 'paragraph', items: ['NumberedList', 'BulletedList', 'JustifyLeft', 'JustifyCenter', 'JustifyRight']},
                                                {name: 'styles', items: ['Format']},
                                                {name: 'clipboard', items: ['Undo', 'Redo']}
                                            ],
                                            removePlugins: 'image,table,media,flash',
                                        });

                                        function previewImage(input) {
                                            const file = input.files[0];
                                            const previewContainer = document.getElementById('imagePreview');
                                            const previewImg = document.getElementById('previewImageTag');
                                            const placeholder = document.getElementById('uploadPlaceholder');

                                            if (!file) {
                                                previewImg.src = '';
                                                previewContainer.style.display = 'none';
                                                placeholder.style.display = 'block';
                                                return;
                                            }

                                            const allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
                                            if (!allowedTypes.includes(file.type)) {
                                                showWarning("❌ Chỉ hỗ trợ ảnh JPG, PNG, GIF.");
                                                input.value = '';
                                                previewImg.src = '';
                                                previewContainer.style.display = 'none';
                                                placeholder.style.display = 'block';
                                                return;
                                            }

                                            if (file.size > 5 * 1024 * 1024) {
                                                showWarning("❌ Ảnh vượt quá dung lượng cho phép (5MB).");
                                                input.value = '';
                                                previewImg.src = '';
                                                previewContainer.style.display = 'none';
                                                placeholder.style.display = 'block';
                                                return;
                                            }
                                            const reader = new FileReader();
                                            reader.onload = function (e) {
                                                previewImg.src = e.target.result;
                                                previewContainer.style.display = 'block';
                                                placeholder.style.display = 'none';
                                            };
                                            reader.readAsDataURL(file);
                                        }
                                        document.getElementById('foodForm').addEventListener('submit', function (e) {
                                            const form = this;
                                            const name = document.getElementById('name').value.trim();
                                            const price = document.getElementById('price').value.trim();
                                            const category = document.getElementById('category').value;
                                            const imageInput = document.getElementById('imageInput');
                                            const ingredients = document.getElementById('ingredients').value.trim();
                                            const description = document.getElementById('description').value.trim();

                                            let hasError = false;

                                            if (name.length < 3) {
                                                showWarning("❗ Tên món ăn phải có ít nhất 3 ký tự.");
                                                hasError = true;
                                            }

                                            if (!price || isNaN(price) || parseInt(price) <= 0) {
                                                showWarning("❗ Giá món ăn phải là số nguyên dương hợp lệ.");
                                                hasError = true;
                                            }

                                            if (!category) {
                                                showWarning("❗ Vui lòng chọn danh mục cho món ăn hoặc tạo mới.");
                                                hasError = true;
                                            }

                                            const file = imageInput.files[0];
                                            if (!file) {
                                                showWarning("❗ Vui lòng chọn ảnh minh họa cho món ăn.");
                                                hasError = true;
                                            } else {
                                                const allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
                                                if (!allowedTypes.includes(file.type)) {
                                                    showWarning("❌ Ảnh phải là JPG, PNG hoặc GIF.");
                                                    hasError = true;
                                                }
                                                if (file.size > 5 * 1024 * 1024) {
                                                    showWarning("❌ Ảnh vượt quá 5MB cho phép.");
                                                    hasError = true;
                                                }
                                            }

                                            if (ingredients.length === 0) {
                                                showWarning("❗ Vui lòng nhập thành phần món ăn.");
                                                hasError = true;
                                            }

                                            if (description.length === 0) {
                                                showWarning("❗ Vui lòng nhập mô tả món ăn.");
                                                hasError = true;
                                            }

                                            if (hasError) {
                                                e.preventDefault();
                                                return;
                                            }
                                            const checkedBMI = document.querySelectorAll('input[name="bmi"]:checked');
                                            if (checkedBMI.length === 0) {
                                                const hidden = document.createElement('input');
                                                hidden.type = 'hidden';
                                                hidden.name = 'bmi';
                                                hidden.value = '7';
                                                form.appendChild(hidden);
                                            }

                                            const submitBtn = form.querySelector('.btn-submit');
                                            submitBtn.disabled = true;
                                            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Đang xử lý...';
                                        });
        </script>
    </body>
</html>
