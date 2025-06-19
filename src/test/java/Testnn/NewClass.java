/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Testnn;

import com.example.servlet.utils.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Admin
 */
public class NewClass {
     public static void main(String[] args) {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();

        String sql = "INSERT INTO Accounts (username, pass, name, email, phone, gender, birthDate, role, status, image, create_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            // TÃ i khoáº£n Admin
            String hashedPassword = BCrypt.hashpw("admin123", BCrypt.gensalt());
            ps.setString(1, "admin");
            ps.setString(2, hashedPassword);
            ps.setString(3, "Admin User");
            ps.setString(4, "admin@foodshop.com");
            ps.setString(5, "1234567890");
            ps.setString(6, "Male");
            ps.setDate(7, java.sql.Date.valueOf("1980-01-01"));
            ps.setString(8, "Admin");
            ps.setString(9, "Active");
            ps.setString(10, "admin.jpg");
            ps.executeUpdate();

            // TÃ i khoáº£n User 1
            ps.setString(1, "user1");
            ps.setString(2, hashedPassword);
            ps.setString(3, "User One");
            ps.setString(4, "user1@foodshop.com");
            ps.setString(5, "0987654321");
            ps.setString(6, "Female");
            ps.setDate(7, java.sql.Date.valueOf("1990-05-15"));
            ps.setString(8, "Member");
            ps.setString(9, "Active");
            ps.setString(10, "user1.jpg");
            ps.executeUpdate();

            // TÃ i khoáº£n User 2
            ps.setString(1, "user2");
            ps.setString(2, hashedPassword);
            ps.setString(3, "User Two");
            ps.setString(4, "user2@foodshop.com");
            ps.setString(5, "0123456789");
            ps.setString(6, "Male");
            ps.setDate(7, java.sql.Date.valueOf("1995-10-20"));
            ps.setString(8, "Member");
            ps.setString(9, "Inactive");
            ps.setString(10, "user2.jpg");
            ps.executeUpdate();

            System.out.println("Sample data added successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbConnect.closeConnection();
        }
    }
}
