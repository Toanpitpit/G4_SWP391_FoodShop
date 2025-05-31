<%-- 
    Document   : BlogDeatil
    Created on : May 30, 2025, 9:46:09 PM
    Author     : Admin
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1">
            <thead>
                <tr>
                    <th>id</th>
                    <th>authorID</th>
                    <th>authorName</th>
                    <th>bmiId</th>
                    <th>title</th>
                    <th>imageUlr</th>
                    <th>content</th>
                    <th>status</th>
                    <th>create_at</th>
                    <th>update_at</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="post" items="${lstB}">
                    <tr>
                    <td>${post.bID}</td>
                    <td>${post.authorID}</td>
                    <td>${post.authorName}</td>
                    <td>${post.bmiId}</td>
                    <td>${post.title}</td>
                    <td>${post.imageUlr}</td>
                    <td>${post.content}</td>
                    <td>${post.status}</td>
                    <td>${post.create_at}</td>
                    <td>${post.update_at}</td> 
                </tr>
                                        
               </c:forEach>
               
            </tbody>
        </table>

    </body>
</html>
