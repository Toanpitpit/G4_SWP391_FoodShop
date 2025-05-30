package com.yourpackage.dao;

import com.yourpackage.model.Order;
import com.example.servlet.utils.DBConnect; // đường dẫn chính xác tới DBConnect

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private static final String SELECT_ALL_ORDERS = "SELECT * FROM Orders";
    private static final String UPDATE_ORDER_STATUS = "UPDATE Orders SET status = ? WHERE id = ?";

    // Lấy danh sách tất cả đơn hàng
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        DBConnect db = new DBConnect(); // tạo đối tượng DBConnect
        try (Connection connection = db.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_ORDERS)) {

            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String customerName = rs.getString("customerName");
                String address = rs.getString("address");
                String phone = rs.getString("phone");
                String food = rs.getString("food");
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("price");
                String status = rs.getString("status");

                Order order = new Order(id, customerName, address, phone, food, quantity, price, status);
                orders.add(order);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(); // đóng kết nối sau khi dùng
        }

        return orders;
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(int orderId, String status) {
        boolean rowUpdated = false;
        DBConnect db = new DBConnect();
        try (Connection connection = db.getConnection();
             PreparedStatement statement = connection.prepareStatement(UPDATE_ORDER_STATUS)) {

            statement.setString(1, status);
            statement.setInt(2, orderId);
            rowUpdated = statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.closeConnection();
        }

        return rowUpdated;
    }
}
