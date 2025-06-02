/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.model.Requests;
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
public class RequestDAO {
    
    
    Connection conn;
    PreparedStatement ps;
    CallableStatement cs = null;
    ResultSet rs;
    DBConnect db = new DBConnect();
    
    
    
public List<Requests> getRequestByFilter(int authorId, String keyword, String sort) {
    List<Requests> lstR = new ArrayList<>();
    try {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT\n")
           .append("    r.reqID,\n")
           .append("    r.title,\n")
           .append("    r.nutritionistID,\n")
           .append("    a.name AS authorName,\n")
           .append("    r.type,\n")
           .append("    r.foodDraftID,\n")
           .append("    f.pName AS foodName,\n")
           .append("    r.status,\n")
           .append("    r.note,\n")
           .append("    r.create_at,\n")
           .append("    r.update_at,\n")
           .append("    h.name AS handlerName\n") 
           .append("FROM Requests r\n")
           .append("JOIN Accounts a ON r.nutritionistID = a.id\n")
           .append("LEFT JOIN Accounts h ON r.handleID = h.id\n") 
           .append("LEFT JOIN FoodDrafts f ON r.foodDraftID = f.pdrID\n")
           .append("WHERE 1=1");

        List<Object> params = new ArrayList<>();
        if (authorId > 0) {
            sql.append(" AND r.nutritionistID = ?");
            params.add(authorId);
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND r.title LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }

        sql.append(" ORDER BY r.update_at ");
        if (sort != null && !sort.trim().isEmpty()) {
            if (sort.equalsIgnoreCase("oldest")) {
                sql.append("ASC");
            } else {
                sql.append("DESC"); 
            }
        } else {
            sql.append("DESC");
        }

        conn = db.getConnection();
        ps = conn.prepareStatement(sql.toString());

        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        rs = ps.executeQuery();
        while (rs.next()) {
            Requests req = new Requests(
                rs.getInt("reqID"),
                rs.getString("title"),
                rs.getInt("nutritionistID"),
                rs.getString("authorName"),
                rs.getString("type"),
                rs.getInt("foodDraftID"),
                rs.getString("foodName"),
                rs.getString("status"),
                rs.getString("note"),
                rs.getString("handlerName") != null ? rs.getString("handlerName") : "Chưa xử lý",
                rs.getTimestamp("create_at"),
                rs.getTimestamp("update_at")
            );
            lstR.add(req);
        }

    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        db.closeConnection();
    }
    return lstR;
}


}
