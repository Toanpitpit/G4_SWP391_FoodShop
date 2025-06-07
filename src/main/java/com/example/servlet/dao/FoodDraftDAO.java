/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.utils.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class FoodDraftDAO {
     
    
public int getTotalFooddraft(int authorID) {
    DBConnect db = new DBConnect();
    int count = 0;

    StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM FoodDrafts");
    boolean hasAuthorID = authorID > 0;

    if (hasAuthorID) {
        sql.append(" WHERE authorID = ?");
    }

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

        if (hasAuthorID) {
            ps.setInt(1, authorID);
        }

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        }

    } catch (SQLException ex) {
        Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, ex);
    } finally {
        db.closeConnection();
    }

    return count;
}

}
