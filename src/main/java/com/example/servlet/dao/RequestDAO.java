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

    public int getTotalRequest(int authorID) {
        DBConnect db = new DBConnect ();
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Requests WHERE nutritionistID = ? ";
        try (Connection conn = db.getConnection (); PreparedStatement ps = conn.prepareStatement (sql);) {
            ps.setInt (1, authorID);
            try (ResultSet rs = ps.executeQuery ()) {
                if (rs.next ()) {
                    count = rs.getInt (1);
                }
            } catch (Exception e) {
            }
        } catch (SQLException ex) {
            Logger.getLogger (BlogDAO.class.getName ()).log (Level.SEVERE, null, ex);
        } finally {
            db.closeConnection ();
        }

        return count;
    }

    public List<MonthlyStat> countRequestsByStatus(Integer authorID) {
        List<MonthlyStat> result = new ArrayList<> ();
        StringBuilder sql = new StringBuilder ("SELECT status, COUNT(*) AS total FROM Requests");

        boolean filterByAuthor = (authorID != null && authorID >= 0);
        if (filterByAuthor) {
            sql.append (" WHERE nutritionistID = ?");
        }
        sql.append (" GROUP BY status ORDER BY status");

        DBConnect db = new DBConnect ();
        try (Connection conn = db.getConnection (); PreparedStatement ps = conn.prepareStatement (sql.toString ())) {

            if (filterByAuthor) {
                ps.setInt (1, authorID);
            }

            try (ResultSet rs = ps.executeQuery ()) {
                while (rs.next ()) {
                    String status = rs.getString ("status");
                    int total = rs.getInt ("total");

                    MonthlyStat stat = new MonthlyStat ();
                    stat.setMonthlName (status);  // Lưu status vào monthlName
                    stat.setCount (total);
                    result.add (stat);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger (RequestDAO.class.getName ()).log (Level.SEVERE, null, ex);
        }
        return result;
    }

}
