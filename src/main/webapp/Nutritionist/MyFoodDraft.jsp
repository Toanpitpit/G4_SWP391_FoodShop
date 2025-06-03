<%-- 
    Document   : MyFoodDraft
    Created on : May 31, 2025, 11:34:59 PM
    Author     : Admin
--%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html >

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>ALOO</h1>
        <select id="filterStatus" name="status">
                         <c:forEach var="status" items="${statusList}">
                             <option value="${status}" <c:if test="${status == status}">selected</c:if>>${status}</option>
                         </c:forEach>
       </select>
    </body>
</html>
