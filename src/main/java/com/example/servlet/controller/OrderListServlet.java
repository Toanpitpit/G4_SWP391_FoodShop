package com.example.servlet.controller;

import com.yourpackage.dao.OrderDAO;
import com.yourpackage.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

@WebServlet("/orders")
public class OrderListServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số tìm kiếm
        String orderId = request.getParameter("orderId");
        String customerName = request.getParameter("customerName");
        String food = request.getParameter("food");
        String status = request.getParameter("status");
        
        // Tìm kiếm đơn hàng
        List<Order> orders = orderDAO.searchOrders(orderId, customerName, food, status);
        
        // Lưu kết quả và các tham số tìm kiếm vào request
        request.setAttribute("orderList", orders);
        request.setAttribute("orderId", orderId);
        request.setAttribute("customerName", customerName);
        request.setAttribute("food", food);
        request.setAttribute("status", status);
        
        // Chuyển hướng đến trang dashboard.jsp
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xử lý cập nhật trạng thái
        String action = request.getParameter("action");
        String orderId = request.getParameter("orderId");
        
        // Lấy các tham số tìm kiếm hiện tại để giữ lại sau khi redirect
        String searchOrderId = request.getParameter("searchOrderId");
        String searchCustomerName = request.getParameter("searchCustomerName");
        String searchFood = request.getParameter("searchFood");
        String searchStatus = request.getParameter("searchStatus");
        
        if (orderId != null && action != null) {
            try {
                // Cập nhật trạng thái
                switch (action) {
                    case "accept":
                        orderDAO.updateOrderStatus(Integer.parseInt(orderId), "Accepted");
                        break;
                    case "reject":
                        orderDAO.updateOrderStatus(Integer.parseInt(orderId), "Rejected");
                        break;
                    case "cancel":
                        orderDAO.updateOrderStatus(Integer.parseInt(orderId), "Cancelled");
                        break;
                }
            } catch (Exception e) {
                e.printStackTrace();
                // Xử lý lỗi nếu cần
            }
        }
        
        // Xây dựng URL redirect với các tham số tìm kiếm hiện tại
        StringBuilder redirectUrl = new StringBuilder("orders?");
        if (searchOrderId != null && !searchOrderId.isEmpty()) {
            redirectUrl.append("orderId=").append(URLEncoder.encode(searchOrderId, "UTF-8")).append("&");
        }
        if (searchCustomerName != null && !searchCustomerName.isEmpty()) {
            redirectUrl.append("customerName=").append(URLEncoder.encode(searchCustomerName, "UTF-8")).append("&");
        }
        if (searchFood != null && !searchFood.isEmpty()) {
            redirectUrl.append("food=").append(URLEncoder.encode(searchFood, "UTF-8")).append("&");
        }
        if (searchStatus != null && !searchStatus.isEmpty()) {
            redirectUrl.append("status=").append(URLEncoder.encode(searchStatus, "UTF-8"));
        }
        
        // Loại bỏ dấu '&' cuối cùng nếu cần
        String urlString = redirectUrl.toString();
        if (urlString.endsWith("&")) {
            urlString = urlString.substring(0, urlString.length() - 1);
        } else if (urlString.endsWith("?")) {
            urlString = urlString.substring(0, urlString.length() - 1);
        }
        
        response.sendRedirect(urlString);
    }
}