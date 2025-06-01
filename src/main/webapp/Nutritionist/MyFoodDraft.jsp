<%-- 
    Document   : MyFoodDraft
    Created on : May 31, 2025, 11:34:59 PM
    Author     : Admin
--%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="Blog_box">
                    <div class="blog-list-container">
                        <c:choose>
                            <c:when test="${not empty lstR}">
                                <table>
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Tiêu đề</th>
                                            <th>Trạng thái</th>
                                            <th>Ngày tạo</th>
                                            <th>Hành động</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="blog" items="${lstR}">
                                            <tr>
                                                <td>${blog.id}</td>
                                                <td>${blog.title}</td>
                                                <td>${blog.authorName}</td>
                                                <td>${blog.handleBY}</td>
                                                <td>
                         
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p style="text-align:center;">Không có bài viết nào.</p>
                            </c:otherwise>
                        </c:choose>

                    </div>

                    <div class="search-filter">
                        <label>
                            <input type="text" placeholder="Search here" id="blogSearchInput" />
                            <ion-icon name="search-outline"></ion-icon>
                        </label>
                        <select id="filterStatus">
                            <option value="">Tất cả trạng thái</option>
                            <option value="Public">Public</option>
                            <option value="Draft">Draft</option>
                            <option value="Private">Private</option>
                        </select>
                    </div>
                </div>
    </body>
</html>
