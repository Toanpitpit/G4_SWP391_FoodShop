<%-- 
    Document   : Requests
    Created on : May 31, 2025, 11:34:06 PM
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
        document.addEventListener('DOMContentLoaded', function () {
        const ctx = document.getElementById('statusChart').getContext('2d');
        const data = {
        labels: ['Public', 'Draft', 'Private'],
        datasets: [{
        data: [
        ${publicCount},
        ${draftCount},
        ${privateCount}
        ],
        backgroundColor: [
        'rgba(75, 192, 192, 0.8)',
        'rgba(255, 205, 86, 0.8)',
        'rgba(255, 99, 132, 0.8)'
        ],
        hoverOffset: 4
        }]
        };
        new Chart(ctx, {
        type: 'pie',
        data: data,
        options: {
        responsive: true,
        plugins: {
        legend: {
        display: false
        },
        tooltip: {
        callbacks: {
        label: function (context) {
        const label = context.label || '';
        const value = context.parsed || 0;
        return label + ': ' + value;
        }
        }
        }
        }
        }
        });
        });       
    </body>
</html>
