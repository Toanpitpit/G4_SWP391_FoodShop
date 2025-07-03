// dao/FoodDetailDAO.java
package com.example.servlet.dao;

import com.example.servlet.utils.DBConnect;
import com.example.servlet.model.FoodDetail;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;



public class FoodDetailDAO {
    public List<FoodDetail> getAllFoodsWithDetails() {
        List<FoodDetail> list = new ArrayList<>();

        String sql = "SELECT f.pID, f.pName, f.p_image, c.caName, f.price, f.status, " +
                     "b.classification, fd.Pdetail, fd.thanh_phan " +
                     "FROM Foods f " +
                     "JOIN Category c ON f.catID = c.catID " +
                     "JOIN FoodDetail fd ON fd.pID = f.pID AND fd.isDraft = 0 " +
                     "JOIN bmi_classification b ON fd.typeBMI = b.type_id";

       try (Connection conn = new DBConnect().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                FoodDetail food = new FoodDetail();
                food.setId(rs.getInt("pID"));
                food.setName(rs.getString("pName"));
                food.setImage(rs.getString("p_image"));
                food.setCategory(rs.getString("caName"));
                food.setPrice(rs.getDouble("price"));
                food.setStatus(rs.getString("status"));
                food.setBmiClass(rs.getString("classification"));
                food.setDescription(rs.getString("Pdetail"));
                food.setIngredients(rs.getString("thanh_phan"));

                list.add(food);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
