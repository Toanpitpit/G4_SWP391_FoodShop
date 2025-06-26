package com.example.servlet.dao;



import com.example.servlet.utils.DBConnect;
import com.example.servlet.model.Food;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class FoodDAO {

    // Lấy toàn bộ danh sách món ăn
    public List<Food> getAllFoods() throws SQLException {
        List<Food> foodList = new ArrayList<>();

        String sql = "SELECT f.pID AS id, f.pName AS name, f.p_image AS image, " +
                     "c.caName AS category, f.price AS price, f.status AS status " +
                     "FROM Foods f " +
                     "LEFT JOIN Category c ON f.catID = c.catID " +
                     "ORDER BY f.pName";

        try (Connection conn = new DBConnect().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Food food = new Food(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getString("category"),
                    rs.getDouble("price"),
                    rs.getString("status")
                );
                foodList.add(food);
            }
        }

        return foodList;
    }

    // Tìm kiếm món ăn theo ID, tên, danh mục và khoảng giá
    public List<Food> searchFoods(String id, String name, String category, String priceRange) throws SQLException {
        List<Food> foodList = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT f.pID AS id, f.pName AS name, f.p_image AS image, " +
            "c.caName AS category, f.price AS price, f.status AS status " +
            "FROM Foods f LEFT JOIN Category c ON f.catID = c.catID WHERE 1=1"
        );

        List<Object> params = new ArrayList<>();

        if (id != null && !id.trim().isEmpty()) {
            sql.append(" AND f.pID LIKE ?");
            params.add("%" + id.trim() + "%");
        }

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND f.pName LIKE ?");
            params.add("%" + name.trim() + "%");
        }

        if (category != null && !category.trim().isEmpty()) {
            sql.append(" AND c.caName = ?");
            params.add(category.trim());
        }

        if (priceRange != null && !priceRange.trim().isEmpty()) {
            switch (priceRange) {
                case "1":
                    sql.append(" AND f.price < 30000");
                    break;
                case "2":
                    sql.append(" AND f.price BETWEEN 30000 AND 50000");
                    break;
                case "3":
                    sql.append(" AND f.price BETWEEN 50000 AND 100000");
                    break;
                case "4":
                    sql.append(" AND f.price > 100000");
                    break;
            }
        }

        try (Connection conn = new DBConnect().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Food food = new Food(
                    rs.getString("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getString("category"),
                    rs.getDouble("price"),
                    rs.getString("status")
                );
                foodList.add(food);
            }
        }

        return foodList;
    }
}