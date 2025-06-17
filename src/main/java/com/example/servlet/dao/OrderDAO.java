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
                "f.p_image AS Image, " + // Lấy đường dẫn ảnh
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
                order.setImage(rs.getString("Image"));
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
    
    // Tìm kiếm đơn hàng với các điều kiện
    public List<Order> searchOrders(String orderId, String customerName, String category, 
                                   String phone, String food,String price, String status) {
        List<Order> orders = new ArrayList<>();
        
        // Build dynamic SQL query
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT ")
           .append("o.oID AS OrderID, ")
           .append("a.name AS CustomerName, ")
           .append("a.phone AS Phone, ")
           .append("o.adress AS Address, ")
           .append("f.pName AS Food, ")
           .append("c.caName AS Category, ")
           .append("od.quantity AS Quantity, ")
           .append("f.price AS Price, ")
           .append("o.status AS Status ")
           .append("FROM Orders o ")
           .append("JOIN Accounts a ON o.acID = a.id ")
           .append("JOIN OrderDetail od ON o.oID = od.oID ")
           .append("JOIN Foods f ON od.pId = f.pID ")
           .append("LEFT JOIN Category c ON f.catID = c.catID ")
           .append("WHERE 1=1 ");
        
        List<Object> parameters = new ArrayList<>();
        
        // Add search conditions for each field
        if (orderId != null && !orderId.trim().isEmpty()) {
            sql.append("AND o.oID = ? ");
            parameters.add(Integer.parseInt(orderId));
        }
        
        if (customerName != null && !customerName.trim().isEmpty()) {
            sql.append("AND a.name LIKE ? ");
            parameters.add("%" + customerName + "%");
        }
        
        if (category != null && !category.trim().isEmpty()) {
            sql.append("AND c.caName LIKE ? ");
            parameters.add("%" + category + "%");
        }
        
        if (phone != null && !phone.trim().isEmpty()) {
            sql.append("AND a.phone LIKE ? ");
            parameters.add("%" + phone + "%");
        }
        
        if (food != null && !food.trim().isEmpty()) {
            sql.append("AND f.pName LIKE ? ");
            parameters.add("%" + food + "%");
        }
        
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND o.status = ? ");
            parameters.add(status);
        }
         sql.append("GROUP BY o.oID, a.name, a.phone, o.adress, o.status ");
    sql.append("ORDER BY o.oID");
        
        
        DBConnect db = new DBConnect();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            // Set parameters
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            
            // Process results
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
            db.closeConnection();
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
    
    // Helper method to get order status by ID
    public String getOrderStatus(int orderId) {
        String status = null;
        String sql = "SELECT status FROM Orders WHERE oID = ?";
        
        DBConnect db = new DBConnect();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                status = rs.getString("status");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.closeConnection();
        }
        
        return status;
    }
    
}