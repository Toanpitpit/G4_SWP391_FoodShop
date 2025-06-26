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
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">
        <script src="${pageContext.request.contextPath}/assets/ckedit/ckeditor/ckeditor.js"></script>
        <style>
            /* CSS cho form tạo danh mục - full height với viền đậm */

            .content-wrapper {
                padding: 20px 30px;
                background-color: #f8f9fa;
                height: calc(85vh - 120px); /* Trừ header + footer */
                display: flex;
                flex-direction: column;
            }

            .content-wrapper form {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15),
                    0 4px 15px rgba(0, 0, 0, 0.1);
                width: 100%;
                margin: 0;
                position: relative;
                z-index: 1;
                border: 1px solid rgba(255, 255, 255, 0.8);
                transition: all 0.3s ease;
                flex: 1;
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
            }

            .form-label {
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 8px;
                font-size: 14px;
            }

            .form-control {
                padding: 12px 16px;
                font-size: 14px;
                background-color: #ffffff;
                border: 2px solid #e9ecef;
                border-radius: 8px;
                transition: all 0.3s ease;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                position: relative;
            }

            .form-control:focus {
                background-color: #ffffff;
                border-color: #3490dc;
                box-shadow: 0 0 0 3px rgba(52, 144, 220, 0.2),
                    0 4px 12px rgba(0, 0, 0, 0.15);
                outline: none;
                transform: translateY(-2px);
                z-index: 6;
            }

            .btn-primary {
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
                border: none;
                padding: 12px 30px;
                border-radius: 6px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
                box-shadow: 0 3px 10px rgba(102, 126, 234, 0.3);
                max-width: 200px;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
                background: linear-gradient(135deg, var(--primary-green), #3b82f6);
            }

            .btn-primary:active {
                transform: translateY(0);
            }
            .mb-3 {
                margin-bottom: 1.2rem;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .content-wrapper {
                    padding: 15px 20px;
                    height: calc(100vh - 100px);
                }

                .content-wrapper form {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <jsp:include page="/Nutritionist/nav.jsp"/>  
        <!-- Main Header -->
        <jsp:include page="/Nutritionist/main-header.jsp"/>  

        <!-- Main Content -->
        <main class="main-content" id="mainContent">
            <!-- Breadcrumb Section -->
            <div class="breadcrumb-section">
                <div class="breadcrumb-container">
                    <h1 class="page-title" style="padding-left: 32px">Welcome to Nutritionist Admin Dashboard</h1>
                    <nav class="breadcrumb-nav">
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Home</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Category</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <span class="breadcrumb-item active">Create Category</span>
                    </nav>
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
            <!-- Content Wrapper -->
            <div class="content-wrapper">
                <c:choose>
                    <c:when test="${not empty cat}">
                        <form action="/category/create" method="post">
                            <div class="mb-3">
                                <label for="name" class="form-label">Tên danh mục</label>
                                <c:set var="name" value="${not empty param.name ? param.name : cat.caName}"/>
                                <input type="text" value="${not empty name ? name :''} " class="form-control" id="name" name="name" required>
                            </div>

                            <div class="mb-3">
                                <label for="description" class="form-label">Mô tả</label> 
                                <c:set var="description" value="${not empty param.description ? param.decription : cat.decription}"/>
                                <textarea class="form-control" id="description" name="description" rows="3" required> ${not empty description ? description :''}</textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="mb-3">
                            <label for="name" class="form-label">Tên danh mục</label>
                            <input type="text" value="${not empty param.name ? param.name :''} " class="form-control" id="name" name="name" required>
                        </div>

                        <div class="mb-3">
                            <label for="decription" class="form-label">Mô tả</label> 
                            <textarea class="form-control"  value="${not empty param.decription ? param.decription :''}" id="description" name="description" rows="3" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Tạo danh mục</button>
                        </form>
                    </c:otherwise>
                </c:choose>

            </div>
            <jsp:include page="/Nutritionist/footer.jsp"/>  
        </main>


        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0"></script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/common.js"></script>

        <script>
            CKEDITOR.replace('description', {
                height: 300,
                versionCheck: false,
                toolbar: [
                    {name: 'basicstyles', items: ['Bold', 'Italic', 'Underline']},
                    {name: 'paragraph', items: ['NumberedList', 'BulletedList', 'JustifyLeft', 'JustifyCenter', 'JustifyRight']},
                    {name: 'styles', items: ['Format']},
                    {name: 'clipboard', items: ['Undo', 'Redo']}
                ],
                removePlugins: 'image,table,media,flash',
            });
        </script>
    </body>
</html>
