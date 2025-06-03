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
import java.util.logging.Level;
import java.util.logging.Logger;

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
    
 public BMIClassification getBMIByID(int bmiID) throws SQLException {
    BMIClassification bi = new BMIClassification();
    try {
        conn = db.getConnection();
        String sql = "SELECT * FROM bmi_classification WHERE type_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, bmiID);
        rs = ps.executeQuery();
        if (rs.next()) {
            bi.setBmiID(rs.getInt("type_id"));
            bi.setClassification(rs.getString("classification"));
            bi.setBmiRange(rs.getString("bmi_range"));
            bi.setDecription(rs.getString("description"));
            bi.setTagetAudience(rs.getString("target_audience"));
        }
        conn.close();
    } catch (Exception ex) {
        Logger.getLogger(BMIClassificationDAO.class.getName()).log(Level.SEVERE, null, ex);
    }
    return bi;
}


    public List<BMIClassification> getAllBMI() throws SQLException {
        List<BMIClassification> lstBMI = new ArrayList<>();
        try {
            conn = db.getConnection();
            
           
            String sql = "SELECT * FROM bmi_classification ";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
                while (rs.next()) {
                    BMIClassification bi = new BMIClassification();
                    bi.setBmiID(rs.getInt("type_id"));
                    bi.setClassification(rs.getString("classification"));
                    bi.setBmiRange(rs.getString("bmi_range"));
                    bi.setDecription(rs.getString("description"));
                    bi.setTagetAudience(rs.getString("target_audience"));
                    lstBMI.add(bi);
                }
            conn.close();
            
        }   catch (Exception ex) {
            Logger.getLogger(BMIClassificationDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lstBMI;
    } 
}
