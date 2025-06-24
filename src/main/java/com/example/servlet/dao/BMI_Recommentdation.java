/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.model.BMIClassification;
import com.example.servlet.model.BMI_Recomentdation;
import com.example.servlet.model.FoodDetail;
import com.example.servlet.utils.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class BMI_Recommentdation {
     public BMI_Recomentdation getBMIRecommentdationID(int id,boolean isDraft) {
        String sql = "SELECT * FROM FoodBMIRecommendation WHERE isdraft = ? AND " +
                     (isDraft ? "fdrID = ?" : "fID = ?");
        try (Connection conn = new DBConnect().getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setBoolean(1, isDraft);
            stmt.setInt(2, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBmiRecomendation(rs);
                }
            }
        } catch (java.sql.SQLException ex) {
             Logger.getLogger (BMI_Recommentdation.class.getName()).log (Level.SEVERE, null, ex);
         }
        return null;
    }

    private BMI_Recomentdation mapResultSetToBmiRecomendation(ResultSet rs) {
        BMI_Recomentdation re = new BMI_Recomentdation ();
        try {
            re.setBirID (rs.getInt ("id"));
            re.setIsDraft (rs.getBoolean ("isDraft"));
            re.setBmiID (rs.getInt ("bmiID"));
            re.setFdrID (rs.getInt ("fdrID"));
            re.setfID (rs.getInt ("fdrID")); 
            
        } catch (java.sql.SQLException ex) {
             Logger.getLogger (BMI_Recommentdation.class.getName()).log (Level.SEVERE, null, ex);
         }
        return re;
    }


//    public List<BMIClassification> getBMIClassificationsByFoodOrDraftId(int id, boolean isDraft) {
//        List<BMIClassification> bmiList = new ArrayList<>();
//
//        String sql = "SELECT bc.type_id, bc.classification, bc.min_bmi, bc.max_bmi, bc.description, bc.target_audience " +
//                     "FROM FoodBMIRecommendation fbr " +
//                     "JOIN bmi_classification bc ON fbr.bmiID = bc.type_id " +
//                     "WHERE fbr.isDraft = ? AND " + (isDraft ? "fbr.fdrID = ?" : "fbr.fID = ?");
//        try (Connection conn = new DBConnect().getConnection();
//             PreparedStatement stmt = conn.prepareStatement(sql)) {
//
//            stmt.setBoolean(1, isDraft);
//            stmt.setInt(2, id);
//
//            try (ResultSet rs = stmt.executeQuery()) {
//                while (rs.next()) {
//                    BMIClassification bmi = new BMIClassification();
//                    bmi.setBmiID(rs.getInt("type_id"));
//                    bmi.setClassification(rs.getString("classification"));
//                    bmi.setMin_bmi(rs.getFloat("min_bmi"));
//                    bmi.setMax_bmi(rs.getFloat("max_bmi"));
//                    bmi.setDecription(rs.getString("description"));
//                    bmi.setTagetAudience(rs.getString("target_audience"));
//                    bmiList.add(bmi);
//                }
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//        return bmiList;
//    }
}
