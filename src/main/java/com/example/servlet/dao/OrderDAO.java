package com.yourpackage.dao;

import com.example.servlet.utils.DBConnect;
import com.yourpackage.model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Lấy danh sách đơn hàng
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT " +
                "o.oID AS OrderID, " +
                "a.name AS CustomerName, " +
                "a.phone AS Phone, " +
                "o.adress AS Address, " +  // chú ý nếu DB bạn sai chính tả "adress" thì phải giữ nguyên
                "f.pName AS Food, " +
                "c.caName AS Category, " +
                "od.quantity AS Quantity, " +
                "f.price AS Price, " +
                "o.status AS Status " +
                "FROM Orders o " +
                "JOIN Accounts a ON o.acID = a.id " +
                "JOIN OrderDetail od ON o.oID = od.oID " +
                "JOIN Foods f ON od.pId = f.pID " +
                "LEFT JOIN Category c ON f.catID = c.catID " +
                "ORDER BY o.oID";

        DBConnect db = new DBConnect();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("OrderID"));
                order.setCustomerName(rs.getString("CustomerName"));
                order.setPhone(rs.getString("Phone"));
                order.setAddress(rs.getString("Address"));
                order.setFood(rs.getString("Food"));
                order.setCategory(rs.getString("Category"));
                order.setQuantity(rs.getInt("Quantity"));
                order.setPrice(rs.getDouble("Price"));
                order.setStatus(rs.getString("Status"));
               

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.closeConnection(); // đóng connection
        }

        return orders;
    }

    // Cập nhật trạng thái đơn hàng
    public boolean updateOrderStatus(int orderId, String newStatus) {
        String sql = "UPDATE Orders SET status = ? WHERE oID = ?";
        DBConnect db = new DBConnect();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, newStatus);
            ps.setInt(2, orderId);

            int affected = ps.executeUpdate();
            return affected > 0;

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.closeConnection();
        }
        return false;
    }
}
