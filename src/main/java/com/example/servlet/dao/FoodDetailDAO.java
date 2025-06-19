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

    /**
     * Lấy FoodDetail theo id và isDraft.
     * Trả về null nếu không tìm thấy hoặc có lỗi.
     */
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
            // In ra console / Tomcat log để debug
            ex.printStackTrace();
        }
        return null;
    }

    /**
     * Map một ResultSet row thành FoodDetail.
     * Giả định model FoodDetail có:
     *   private int fdID;          // không nullable
     *   private Boolean isDraft;
     *   private Integer fID;       // nullable
     *   private Integer fdrID;     // nullable
     *   private String description;
     *   private String ingredients;
     */
    private FoodDetail mapResultSetToFoodDetail(ResultSet rs) {
        FoodDetail fd = new FoodDetail();
        try {
            // Khóa chính của FoodDetail
            fd.setFdID(rs.getInt("fdId"));

            // isDraft
            fd.setIsDraft(rs.getBoolean("isdraft"));

            // food_id nullable
            int foodId = rs.getInt("food_id");
            if (rs.wasNull()) {
                fd.setfID(null);
            } else {
                fd.setfID(foodId);
            }

            // draft_id nullable
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

    /**
     * Lấy danh sách BMIClassification liên quan tới Food hoặc Draft.
     * Trả về List rỗng nếu không có bản ghi hoặc có lỗi.
     */
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
