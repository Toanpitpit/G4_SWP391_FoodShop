/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.model.MonthlyStat;
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
public class RequestDAO {
    
    
  

    
    
    
//public List<Requests> getRequestByFilter(int authorId, String keyword, String sort) {
//    List<Requests> lstR = new ArrayList<>();
//    try {
//        StringBuilder sql = new StringBuilder();
//        sql.append("SELECT\n")
//           .append("    r.reqID,\n")
//           .append("    r.title,\n")
//           .append("    r.nutritionistID,\n")
//           .append("    a.name AS authorName,\n")
//           .append("    r.type,\n")
//           .append("    r.foodDraftID,\n")
//           .append("    f.pName AS foodName,\n")
//           .append("    r.status,\n")
//           .append("    r.note,\n")
//           .append("    r.create_at,\n")
//           .append("    r.update_at,\n")
//           .append("    h.name AS handlerName\n") 
//           .append("FROM Requests r\n")
//           .append("JOIN Accounts a ON r.nutritionistID = a.id\n")
//           .append("LEFT JOIN Accounts h ON r.handleID = h.id\n") 
//           .append("LEFT JOIN FoodDrafts f ON r.foodDraftID = f.pdrID\n")
//           .append("WHERE 1=1");
//
//        List<Object> params = new ArrayList<>();
//        if (authorId > 0) {
//            sql.append(" AND r.nutritionistID = ?");
//            params.add(authorId);
//        }
//        if (keyword != null && !keyword.trim().isEmpty()) {
//            sql.append(" AND r.title LIKE ?");
//            params.add("%" + keyword.trim() + "%");
//        }
//
//        sql.append(" ORDER BY r.update_at ");
//        if (sort != null && !sort.trim().isEmpty()) {
//            if (sort.equalsIgnoreCase("oldest")) {
//                sql.append("ASC");
//            } else {
//                sql.append("DESC"); 
//            }
//        } else {
//            sql.append("DESC");
//        }
//
//        conn = db.getConnection();
//        ps = conn.prepareStatement(sql.toString());
//
//        for (int i = 0; i < params.size(); i++) {
//            ps.setObject(i + 1, params.get(i));
//        }
//
//        rs = ps.executeQuery();
//        while (rs.next()) {
//            Requests req = new Requests(
//                rs.getInt("reqID"),
//                rs.getString("title"),
//                rs.getInt("nutritionistID"),
//                rs.getString("authorName"),
//                rs.getString("type"),
//                rs.getInt("foodDraftID"),
//                rs.getString("foodName"),
//                rs.getString("status"),
//                rs.getString("note"),
//                rs.getString("handlerName") != null ? rs.getString("handlerName") : "Chưa xử lý",
//                rs.getTimestamp("create_at"),
//                rs.getTimestamp("update_at")
//            );
//            lstR.add(req);
//        }
//        conn.close();;
//
//    } catch (Exception ex) {
//        ex.printStackTrace();
//    } 
//    return lstR;
//}
 public int getTotalRequest(int authorID) {
    DBConnect db = new DBConnect();
    int count = 0;
    String sql = "SELECT COUNT(*) FROM Requests ";
    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        if (rs.next()) {
            count = rs.getInt(1);
        }
    } catch (SQLException ex) {
        Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, ex);
    }finally{
        db.closeConnection ();
    }

    return count;
}
public List<MonthlyStat> countRequestsByStatus(Integer authorID) {
    List<MonthlyStat> result = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT status, COUNT(*) AS total FROM Requests");
    
    boolean filterByAuthor = (authorID != null && authorID >= 0);
    if (filterByAuthor) {
        sql.append(" WHERE nutritionistID = ?");
    }
    sql.append(" GROUP BY status ORDER BY status");

    DBConnect db = new DBConnect();
    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

        if (filterByAuthor) {
            ps.setInt(1, authorID);
        }

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String status = rs.getString("status");
                int total = rs.getInt("total");

                MonthlyStat stat = new MonthlyStat();
                stat.setMonthlName(status);  // Lưu status vào monthlName
                stat.setCount(total);
                result.add(stat);
            }
        }

    } catch (SQLException ex) {
        Logger.getLogger(RequestDAO.class.getName()).log(Level.SEVERE, null, ex);
    } 
    return result;
}


}
