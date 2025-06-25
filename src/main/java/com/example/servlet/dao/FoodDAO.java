package com.example.servlet.dao;

import com.example.servlet.model.Food;
import com.example.servlet.utils.DBConnect;
import java.sql.*;
import java.util.*;

public class FoodDAO {

    public List<Food> getAllFoods() {
        List<Food> list = new ArrayList<>();
        String sql = "SELECT * FROM Foods";
        DBConnect db = new DBConnect();
        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

           
            while (rs.next()) {
                list.add(new Food(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getString("category"),
                    rs.getDouble("price")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    
}

