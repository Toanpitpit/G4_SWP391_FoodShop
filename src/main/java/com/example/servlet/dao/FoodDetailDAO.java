package com.example.servlet.dao;

import com.example.servlet.model.BMIClassification;
import com.example.servlet.model.FoodDetail;
import com.example.servlet.utils.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FoodDetailDAO {

    public FoodDetail getFoodDetailByIdAndDraft(int id, boolean isDraft) {
        String sql = "SELECT * FROM FoodDetail WHERE isdraft = ? AND " +
                     (isDraft ? "draft_id = ?" : "food_id = ?");
        try (Connection conn = new DBConnect().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, isDraft);
            stmt.setInt(2, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToFoodDetail(rs);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    private FoodDetail mapResultSetToFoodDetail(ResultSet rs) {
        FoodDetail fd = new FoodDetail();
        try {
            fd.setFdID(rs.getInt("fdId"));
            fd.setIsDraft(rs.getBoolean("isdraft"));
            int foodId = rs.getInt("food_id");
            if (rs.wasNull()) {
                fd.setfID(null);
            } else {
                fd.setfID(foodId);
            }
            int draftId = rs.getInt("draft_id");
            if (rs.wasNull()) {
                fd.setFdrID(null);
            } else {
                fd.setFdrID(draftId);
            }

            fd.setDescription(rs.getString("description"));
            fd.setIngredients(rs.getString("ingredients"));
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return fd;
    }


    public List<BMIClassification> getBMIClassificationsByFoodOrDraftId(int id, boolean isDraft) {
        List<BMIClassification> bmiList = new ArrayList<>();

        String sql = "SELECT bc.type_id, bc.classification, bc.min_bmi, bc.max_bmi, bc.description, bc.target_audience " +
                     "FROM FoodBMIRecommendation fbr " +
                     "JOIN bmi_classification bc ON fbr.bmiID = bc.type_id " +
                     "WHERE fbr.isDraft = ? AND " + (isDraft ? "fbr.fdrID = ?" : "fbr.fID = ?");
        try (Connection conn = new DBConnect().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, isDraft);
            stmt.setInt(2, id);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BMIClassification bmi = new BMIClassification();
                    bmi.setBmiID(rs.getInt("type_id"));
                    bmi.setClassification(rs.getString("classification"));
                    bmi.setMin_bmi(rs.getFloat("min_bmi"));
                    bmi.setMax_bmi(rs.getFloat("max_bmi"));
                    bmi.setDecription(rs.getString("description"));
                    bmi.setTagetAudience(rs.getString("target_audience"));
                    bmiList.add(bmi);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return bmiList;
    }
}
