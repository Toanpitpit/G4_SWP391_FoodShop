/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.model.BMIClassification;
import com.example.servlet.model.MonthlyStat;
import com.example.servlet.utils.DBConnect;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class BMIClassificationDAO {
    Connection conn;
    PreparedStatement ps;
    CallableStatement cs = null;
    ResultSet rs;
    DBConnect db = new DBConnect();
    /*
    private int bmiID;
    private String classification;
    private String bmiRange;
    private String decription;
    private String tagetAudience;*/
    
    
    public BMIClassification getBMIByID(int bmiID) throws SQLException {
        conn = db.getConnection();
    String sql = "SELECT * FROM bmi_classification WHERE type_id = ?";
    try (PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, bmiID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            BMIClassification bi = new BMIClassification();
            bi.setBmiID(rs.getInt("type_id")); 
            bi.setClassification(rs.getString("classification")); 
            bi.setBmiRange(rs.getString("bmi_range"));
            bi.setDecription(rs.getString("description"));
            bi.setTagetAudience(rs.getString("target_audience"));
            return bi;
        }
    }
    return null; 
} 

    public List<BMIClassification> getAllBMI() throws SQLException {
        conn = db.getConnection();
        List<BMIClassification> lstBMI = new ArrayList<>();
        String sql = "SELECT * FROM bmi_classification ";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
             while (rs.next()) {
                BMIClassification bi = new BMIClassification();
                bi.setBmiID(rs.getInt("type_id"));
                bi.setClassification(rs.getString("classification"));
                bi.setBmiRange(rs.getString("bmi_range"));
                bi.setDecription(rs.getString("description"));
                bi.setTagetAudience(rs.getString("target_audience"));
                lstBMI.add(bi);
            }
        }
        return lstBMI;
    } 
}
