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
               .append("    r.reqID ,\n")
               .append("    r.title ,\n")
               .append("    r.nutritionistID,\n")
               .append("    a.name,\n")
               .append("    r.type ,\n")
               .append("    r.foodDraftID,\n")
               .append("    r.status ,\n")
               .append("    r.note ,\n")
               .append("    r.create_at,\n")
               .append("    r.update_at\n")
               .append("FROM\n")
               .append("    Requests r\n")
               .append("JOIN\n")
               .append("    Accounts a ON r.nutritionistID = a.id\n")
               .append("WHERE 1=1");

            List<Object> params = new ArrayList<>(); 
            if (authorId > 0) {
                sql.append(" AND r.nutritionistID = ?");
                params.add(authorId);
            }
            if (keyword != null && !keyword.trim().isEmpty()) {
                sql.append(" AND (r.title LIKE ?  ");
                String like = "%" + keyword.trim() + "%";
                params.add(like);
            }          
            if (sort != null && !sort.trim().isEmpty()) {
                sql.append(" ORDER BY r.update_at ");
                if (sort.equalsIgnoreCase("newest")) {
                    sql.append("DESC");
                } else if (sort.equalsIgnoreCase("oldest")) {
                    sql.append("ASC");
                }
            } else {
           
                sql.append(" ORDER BY r.update_at DESC");
            }
            conn = db.getConnection(); 

            ps = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();
            while (rs.next()) {
                Requests req = new Requests(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8),
                        rs.getTimestamp(9),
                        rs.getTimestamp(10)
                );
                lstR.add(req);
            }
//            System.out.println(sql.toString());

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return lstR;
    }
}
