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

    public BMIClassification getBMIByID(int bmiID) throws SQLException {
        BMIClassification bi = null;
        DBConnect db = new DBConnect ();

        String sql = "SELECT * FROM bmi_classification WHERE type_id = ?";

        try (Connection conn = db.getConnection (); PreparedStatement ps = conn.prepareStatement (sql)) {

            ps.setInt (1, bmiID);
            try (ResultSet rs = ps.executeQuery ()) {
                if (rs.next ()) {
                    bi = new BMIClassification ();
                    bi.setBmiID (rs.getInt ("type_id"));
                    bi.setClassification (rs.getString ("classification"));
                    bi.setMin_bmi(rs.getFloat("min_bmi")); // CHỖ NÀY SỬA
                    bi.setMax_bmi(rs.getFloat("max_bmi"));
                    bi.setDecription (rs.getString ("description"));
                    bi.setTagetAudience (rs.getString ("target_audience"));
                }
            }

        } catch (Exception ex) {
            Logger.getLogger (BMIClassificationDAO.class.getName ()).log (Level.SEVERE, null, ex);
        }

        return bi;
    }

    public List<BMIClassification> getAllBMI() throws SQLException {
        List<BMIClassification> lstBMI = new ArrayList<> ();
        DBConnect db = new DBConnect ();

        String sql = "SELECT DISTINCT * FROM bmi_classification";

        try (Connection conn = db.getConnection (); PreparedStatement ps = conn.prepareStatement (sql); ResultSet rs = ps.executeQuery ()) {

            while (rs.next ()) {
                BMIClassification bi = new BMIClassification ();
                bi.setBmiID (rs.getInt ("type_id"));
                bi.setClassification (rs.getString ("classification"));
                bi.setMin_bmi(rs.getFloat("min_bmi")); // CHỖ NÀY SỬA
                bi.setMax_bmi(rs.getFloat("max_bmi"));
                bi.setDecription (rs.getString ("description"));
                bi.setTagetAudience (rs.getString ("target_audience"));
                lstBMI.add (bi);
            }

        } catch (Exception ex) {
            Logger.getLogger (BMIClassificationDAO.class.getName ()).log (Level.SEVERE, null, ex);
        }

        return lstBMI;
    }

    public List<BMIClassification> getBMIWithPagination(int offset, int limit) throws SQLException {
        List<BMIClassification> lstBMI = new ArrayList<> ();
        DBConnect db = new DBConnect ();
        String sql = "SELECT * FROM bmi_classification "
                + "ORDER BY type_id "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = db.getConnection (); PreparedStatement ps = conn.prepareStatement (sql)) {

            ps.setInt (1, offset);
            ps.setInt (2, limit);

            try (ResultSet rs = ps.executeQuery ()) {
                while (rs.next ()) {
                    BMIClassification bi = new BMIClassification ();
                    bi.setBmiID (rs.getInt ("type_id"));
                    bi.setClassification (rs.getString ("classification"));
                    bi.setMin_bmi(rs.getFloat("min_bmi")); // CHỖ NÀY SỬA
                    bi.setMax_bmi(rs.getFloat("max_bmi"));
                    bi.setDecription (rs.getString ("description"));
                    bi.setTagetAudience (rs.getString ("target_audience"));
                    lstBMI.add (bi);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger (BMIClassificationDAO.class.getName ()).log (Level.SEVERE, null, ex);
            throw ex; // Rethrow nếu bạn muốn báo lỗi cho tầng gọi
        }

        return lstBMI;
    }

    public int countAllBMI() {
        DBConnect db = new DBConnect ();
        int count = 0;
        String sql = "SELECT COUNT(*) FROM bmi_classification";

        try (
                Connection conn = db.getConnection (); PreparedStatement ps = conn.prepareStatement (sql); ResultSet rs = ps.executeQuery ()) {
            if (rs.next ()) {
                count = rs.getInt (1);
            }
        } catch (Exception e) {
            Logger.getLogger (BMIClassificationDAO.class.getName ()).log (Level.SEVERE, null, e);
        }

        return count;
    }

    public List<BMIClassification> getBMIWithFilterAndSort(
            String targetKeyword,
            String sortColumn, 
            String sortOrder, 
            int offset,
            int limit) throws SQLException {

        List<BMIClassification> lstBMI = new ArrayList<> ();
        DBConnect db = new DBConnect ();

       
        StringBuilder sql = new StringBuilder ("SELECT * FROM bmi_classification WHERE 1=1");

        
        if (targetKeyword != null && !targetKeyword.trim ().isEmpty ()) {
            sql.append (" AND target_audience LIKE ?");
        }

       
        if ("type_id".equalsIgnoreCase (sortColumn) || "classification".equalsIgnoreCase (sortColumn)) {
            sql.append (" ORDER BY ").append (sortColumn);
        } else {
            sql.append (" ORDER BY type_id");  // mặc định
        }

       
        if ("desc".equalsIgnoreCase (sortOrder)) {
            sql.append (" DESC");
        } else {
            sql.append (" ASC");
        }

        
        sql.append (" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (Connection conn = db.getConnection (); PreparedStatement ps = conn.prepareStatement (sql.toString ())) {

            int index = 1;

            if (targetKeyword != null && !targetKeyword.trim ().isEmpty ()) {
                ps.setString (index++, "%" + targetKeyword.trim () + "%");
            }

            ps.setInt (index++, offset);
            ps.setInt (index, limit);

            try (ResultSet rs = ps.executeQuery ()) {
                while (rs.next ()) {
                    BMIClassification bi = new BMIClassification ();
                    bi.setBmiID (rs.getInt ("type_id"));
                    bi.setClassification (rs.getString ("classification"));
                    bi.setMin_bmi(rs.getFloat("min_bmi")); // CHỖ NÀY SỬA
                    bi.setMax_bmi(rs.getFloat("max_bmi"));
                    bi.setDecription (rs.getString ("description"));
                    bi.setTagetAudience (rs.getString ("target_audience"));
                    lstBMI.add (bi);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger (BMIClassificationDAO.class.getName ()).log (Level.SEVERE, null, ex);
            throw ex;
        }

        return lstBMI;
    }
 
    public int gettotalBMIWithFilterAndSort(
            String targetKeyword,
            String sortColumn,
            String sortOrder
           ) throws SQLException {

        List<BMIClassification> lstBMI = new ArrayList<> ();
        DBConnect db = new DBConnect ();

        
        StringBuilder sql = new StringBuilder ("SELECT * FROM bmi_classification WHERE 1=1");

  
        if (targetKeyword != null && !targetKeyword.trim ().isEmpty ()) {
            sql.append (" AND target_audience LIKE ?");
        }

        if ("type_id".equalsIgnoreCase (sortColumn) || "classification".equalsIgnoreCase (sortColumn)) {
            sql.append (" ORDER BY ").append (sortColumn);
        } else {
            sql.append (" ORDER BY type_id");  // mặc định
        }

 
        if ("desc".equalsIgnoreCase (sortOrder)) {
            sql.append (" DESC");
        } else {
            sql.append (" ASC");
        }

    
       

        try (Connection conn = db.getConnection (); PreparedStatement ps = conn.prepareStatement (sql.toString ())) {

            int index = 1;

            if (targetKeyword != null && !targetKeyword.trim ().isEmpty ()) {
                ps.setString (index++, "%" + targetKeyword.trim () + "%");
            }

            try (ResultSet rs = ps.executeQuery ()) {
                while (rs.next ()) {
                    BMIClassification bi = new BMIClassification ();
                    bi.setBmiID (rs.getInt ("type_id"));
                    bi.setClassification (rs.getString ("classification"));
                    bi.setMin_bmi(rs.getFloat("min_bmi")); 
                    bi.setMax_bmi(rs.getFloat("max_bmi"));
                    bi.setDecription (rs.getString ("description"));
                    bi.setTagetAudience (rs.getString ("target_audience"));
                    lstBMI.add (bi);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger (BMIClassificationDAO.class.getName ()).log (Level.SEVERE, null, ex);
            throw ex;
        }

        return lstBMI.size ();
    }

}


