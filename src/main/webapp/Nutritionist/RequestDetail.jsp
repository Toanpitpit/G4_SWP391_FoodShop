<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Request</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.10.0/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&family=Rubik:wght@500&family=Nunito:wght@600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Be+Vietnam+Pro:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Ncss/defauld.css">
        <style>
            .card {
                border: 3px solid #ced4da;
                border-radius: 16px;
                box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08);
                background: linear-gradient(135deg, #ffffff 0%, #f8fcf9 100%);
                overflow: hidden;
                position: relative;
                z-index: 1;
            }
            .card h3 {
                color: #047857;
                font-weight: 600;
                font-size: 1.5rem;
                margin-bottom: 2rem;
                padding-bottom: 0.5rem;
                border-bottom: 2px solid #e6fffa;
                position: relative;
            }

            .card h3::after {
                content: '';
                position: absolute;
                bottom: -2px;
                left: 0;
                width: 60px;
                height: 2px;
                background: linear-gradient(90deg, #10b981, #059669);
            }
            .form-label {
                font-weight: 600;
                color: #065f46;
                margin-bottom: 0.5rem;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .form-control {
                border: 2px solid #d1fae5;
                border-radius: 12px;
                padding: 12px 16px;
                font-size: 0.95rem;
                transition: all 0.3s ease;
                background: #ffffff;
                color: #374151;
            }

            .form-control:focus {
                border-color: #10b981;
                box-shadow: 0 0 0 0.2rem rgba(16, 185, 129, 0.15);
                background: #ffffff;
                outline: none;
            }

            .form-control[readonly] {
                background: linear-gradient(135deg, #f0fdf4 0%, #ecfdf5 100%);
                border-color: #bbf7d0;
                color: #166534;
                cursor: default;
            }
            textarea.form-control {
                min-height: 100px;
                resize: vertical;
                line-height: 1.6;
            }
            .text-decoration-underline {
                color: #10b981;
                text-decoration: none;
                font-weight: 500;
                transition: all 0.3s ease;
                position: relative;
            }

            .text-decoration-underline:hover {
                color: #059669;
                text-decoration: none;
            }

            .text-decoration-underline::after {
                content: '';
                position: absolute;
                width: 0;
                height: 2px;
                bottom: -2px;
                left: 0;
                background: linear-gradient(90deg, #10b981, #059669);
                transition: width 0.3s ease;
            }

            .text-decoration-underline:hover::after {
                width: 100%;
            }
            .text-muted {
                color: #6b7280;
                font-style: italic;
            }
            .btn {
                border-radius: 10px;
                padding: 10px 20px;
                font-weight: 600;
                font-size: 0.9rem;
                transition: all 0.3s ease;
                border: none;
                position: relative;
                overflow: hidden;
            }

            .btn::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: left 0.5s ease;
            }

            .btn:hover::before {
                left: 100%;
            }

            .btn-primary {
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
                box-shadow: 0 4px 15px rgba(16, 185, 129, 0.3);
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #059669 0%, #047857 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(16, 185, 129, 0.4);
            }

            .btn-danger {
                background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                color: white;
                box-shadow: 0 4px 15px rgba(239, 68, 68, 0.3);
            }

            .btn-danger:hover {
                background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%);
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(239, 68, 68, 0.4);
            }
            .row.mb-3 {
                margin-bottom: 1.5rem;
            }

            .mb-3 {
                margin-bottom: 1.5rem;
            }
            .d-flex.justify-content-end.gap-2 {
                gap: 12px;
                margin-top: 2rem;
                padding-top: 1.5rem;
                border-top: 1px solid #e6fffa;
            }
            .btn i {
                margin-right: 8px;
                font-size: 0.9rem;
            }
            
            .food-link {
    color: #10b981;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.3s ease;
    position: relative;
    display: inline-block;
    padding: 8px 12px;
    background: linear-gradient(135deg, #ecfdf5 0%, #d1fae5 100%);
    border-radius: 8px;
    border: 1px solid #bbf7d0;
}

.food-link:hover {
    color: #059669;
    text-decoration: none;
    background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(16, 185, 129, 0.15);
}

.text-muted {
    color: #6b7280;
    font-style: italic;
    padding: 8px 12px;
    background: #f9fafb;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
}

            @media (max-width: 768px) {
                .card {
                    margin: 1rem;
                    border-radius: 12px;
                }

                .card h3 {
                    font-size: 1.3rem;
                }

                .form-control {
                    padding: 10px 14px;
                    font-size: 0.9rem;
                }

                .btn {
                    padding: 8px 16px;
                    font-size: 0.85rem;
                }

                .d-flex.justify-content-end.gap-2 {
                    flex-direction: column;
                    gap: 8px;
                }

                .btn {
                    width: 100%;
                }
            }
            .form-control:not([readonly]):hover {
                border-color: #a7f3d0;
                background: #fefffe;
            }
            .card {
                animation: slideInUp 0.6s ease-out;
            }

            @keyframes slideInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .card:focus-within {
                box-shadow: 0 12px 40px rgba(16, 185, 129, 0.12);
                transform: translateY(-2px);
                transition: all 0.3s ease;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/Nutritionist/nav.jsp"/>  
        <!-- Main Header -->
        <jsp:include page="/Nutritionist/main-header.jsp"/>  
        
        <c:set  var="actiontodo" value="${action ? action : 'ViewDetail'}"/>
        <c:set  var="isView" value="${actiontodo eq 'ViewDetail'}"/>
        <c:set  var="isCreate" value="${actiontodo eq 'Create'}"/>
        <c:set  var="isUpdate" value="${actiontodo eq 'Update'}"/>
        
        
        <c:set  var="titleinput" value="${ not empty param.titleinput ? param.titleinput : ''}"/>    
        <c:set  var="typeinput" value="${ not empty param.typeinput ? param.typeinput : ''}"/>    
        <c:set  var="foodinput" value="${ not empty param.foodinput ? param.foodinput : ''}"/>    
        <c:set  var="requestNoteInput" value="${ not empty param.requestNoteInput ? param.requestNoteInput : ''}"/>    
         
             
        <c:set var="titleUpdate" value="${not empty param.titleUpdate ? param.titleUpdate : (not empty requestupdate.title ? requestupdate.title : 'No data')}" />
        <c:set var="typeUpdate" value="${not empty param.typeUpdate ? param.typeUpdate : (not empty requestupdate.type ? requestupdate.type : 'No data')}" />
        <c:set var="foodUpdate" value="${not empty param.foodUpdate ? param.foodUpdate : (not empty requestupdate.food ? requestupdate.food : 'No data')}" />
        <c:set var="requestNoteUpdate" value="${not empty param.requestNoteUpdate ? param.requestNoteUpdate : (not empty requestupdate.requestNote ? request.requestNote : 'No data')}" />

        
        <main class="main-content" id="mainContent">
            <!-- Breadcrumb Section -->
            <div class="breadcrumb-section">
                <div class="breadcrumb-container">
                    <h1 class="page-title" style="padding-left: 32px">Request Detail</h1>
                    <nav class="breadcrumb-nav">
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Home</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <a href="${pageContext.request.contextPath}/nutricontrol?action=dashboard" class="breadcrumb-item">Request</a>
                        <span class="breadcrumb-separator">
                            <i class="bi bi-chevron-right"></i>
                        </span>
                        <c:choose>
                            <c:when test="${isView}">
                                <span class="breadcrumb-item active">Detail</span>
                            </c:when>
                            <c:when test="${isCreate}">
                                <span class="breadcrumb-item active">Create Request</span>
                            </c:when>
                            <c:when test="${isUpdate}">
                                <span class="breadcrumb-item active"> Update Request</span>
                            </c:when>
                        </c:choose>
                    </nav>
                </div>
            </div>
            <div class="content-wrapper">
                <div class="card shadow-sm p-4">
                    <form>
                        <div class="form-section">
                            <div class="section-title">Thông tin cơ bản</div>
                            <div class="mb-3">
                                <label class="form-label">Tiêu đề yêu cầu</label>
                                <c:choose>
                                    <c:when test="${isView}">
                                        <input type="text" class="form-control" value="${requestView.title != null ? requestView.title : 'No data'}" readonly>
                                    </c:when>
                                    <c:when test="${isCreate}">
                                        <input type="text" class="form-control" name="titleinput" value="${titleinput}">
                                    </c:when>
                                    <c:when test="${isUpdate}">
                                        <input type="text" class="form-control" name="titleUpdate" value="${titleUpdate}">
                                    </c:when>
                                </c:choose>
                            </div>



                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label class="form-label">Loại yêu cầu</label>
                                    <c:choose>
                                        <c:when test="${isView}">
                                            <input type="text" class="form-control" value="${requestView.type != null ? requestView.type : 'No data'}" readonly>
                                        </c:when>
                                        <c:when test="${isCreate}">
                                            <select class="form-control" name="typeinput">
                                                <option value="CREATE" ${typeinput == 'CREATE' ? 'selected' : ''}>CREATE</option>
                                                <option value="UPDATE" ${typeinput == 'UPDATE' ? 'selected' : ''}>UPDATE</option>
                                                <option value="REMOVE" ${typeinput == 'REMOVE' ? 'selected' : ''}>REMOVE</option>
                                            </select>
                                        </c:when>
                                        <c:when test="${isUpdate}">
                                            <select class="form-control" name="typeUpdate">
                                                <option value="CREATE" ${typeUpdate == 'CREATE' ? 'selected' : ''}>CREATE</option>
                                                <option value="UPDATE" ${typeUpdate == 'UPDATE' ? 'selected' : ''}>UPDATE</option>
                                                <option value="REMOVE" ${typeUpdate == 'REMOVE' ? 'selected' : ''}>REMOVE</option>
                                            </select>
                                        </c:when>
                                    </c:choose>
                                </div>
                                <c:if test="${isView}">
                                    <div class="col-md-4">
                                        <label class="form-label">ID</label>
                                        <input type="text" class="form-control" value="${not empty requestView.rID ? requestView.rID : 'No data'}" readonly>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label">Status</label>
                                        <div class="mt-2">
                                            <span class="status-badge status-pending">${not empty requestView.status ? requestView.status : 'No data'}</span>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                        
                        <c:if test="${isView}">
                            <div class="form-section">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label">Người gửi yêu cầu</label>
                                        <input type="text" class="form-control" value="${not empty requestView.authorName ? requestView.authorName : 'No data'}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Người xử lý</label>
                                        <input type="text" class="form-control" value="${not empty requestView.handleBY ? requestView.handleBY : 'No data'}" readonly>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <div class="form-section">
                            <div class="mb-3">
                                <label class="form-label">Món ăn đề xuất</label>

                                <c:choose>
                                    <!-- View Mode -->
                                    <c:when test="${isView}">
                                        <c:choose>
                                            <c:when test="${not empty requestView.draftID}">
                                                <c:set var="draftLink" value="nutricontrol?action=showfooddraftdetail&id=${requestView.draftID}" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="draftLink" value="#" />
                                            </c:otherwise>
                                        </c:choose>

                                        <a href="${draftLink}" target="_blank" class="food-link">
                                            <i class="fas fa-utensils me-2"></i>
                                            ${not empty requestView.foodName ? requestView.foodName : 'No data'}
                                        </a>
                                    </c:when> 
                                    <c:otherwise>
                                        <select class="form-control" 
                                                name="${isUpdate ? 'foodUpdate' : 'foodinput'}" 
                                                id="foodSelect" onchange="updateFoodLink()">
                                            <option value="">-- Chọn món ăn --</option>
                                            <c:forEach var="food" items="${foodList}">
                                                <option value="${food.id}"
                                                        <c:choose>
                                                            <c:when test="${isUpdate}">
                                                                <c:if test="${foodUpdate == food.id}">selected</c:if>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:if test="${foodinput == food.id}">selected</c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        >${food.name}</option>
                                            </c:forEach>
                                        </select>
                                        <a href="#" id="foodLink" target="_blank" class="food-link d-block mt-2" style="display:none;">
                                            <i class="fas fa-utensils me-2"></i> Xem chi tiết món ăn
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>



                        <div class="form-section">
                            <div class="mb-3">
                                <label class="form-label">Ghi chú từ người gửi</label>
                                <textarea class="form-control" readonly></textarea>
                            </div>
                        </div>

                      
                        <div class="form-section">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Ngày tạo yêu cầu</label>
                                    <div class="datetime-info">
                                        <i class="fas fa-calendar-plus me-2"></i>
                                        
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Ngày cập nhật cuối</label>
                                    <div class="datetime-info">
                                        <i class="fas fa-calendar-edit me-2"></i>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>

                       
                        <div class="d-flex justify-content-end action-buttons">
                            <a href="#" class="btn btn-primary">
                                <i class="fas fa-edit"></i> Chỉnh sửa
                            </a>
                            <a href="#" class="btn btn-danger"
                               onclick="return confirm('Bạn có chắc muốn xóa yêu cầu này không?');">
                                <i class="fas fa-trash"></i> Xóa
                            </a>
                        </div>
                    </form>
                </div>
            </div>                          
            <jsp:include page="/Nutritionist/footer.jsp"/>  
        </main>


        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0"></script>
        <script src="${pageContext.request.contextPath}/JS/Nutritionist/common.js"></script>
    </body>
</html>
