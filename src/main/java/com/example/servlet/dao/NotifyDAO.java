/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.model.Notifys;
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
public class NotifyDAO {

 
    DBConnect db = new DBConnect ();

  public List<Notifys> getNotificationsByFilter(Integer receiverID, String roleTarget, Boolean isRead, boolean sortNewestFirst) {
    List<Notifys> lstNoti = new ArrayList<>();
    StringBuilder sql = new StringBuilder("SELECT * FROM Notifications WHERE 1=1 ");
    List<Object> params = new ArrayList<>();

    // Lọc theo receiverID hoặc roleTarget
    if (receiverID != null) {
        sql.append("AND receiverID = ? ");
        params.add(receiverID);
    } else if (roleTarget != null && !roleTarget.trim().isEmpty()) {
        sql.append("AND role_target = ? ");
        params.add(roleTarget);
    }
    if (isRead != null) {
        sql.append("AND isRead = ? ");
        params.add(isRead);
    }
    sql.append("ORDER BY create_at ").append(sortNewestFirst ? "DESC" : "ASC");

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Notifys noti = new Notifys(
                        rs.getInt("notificationID"),
                        rs.getInt("receiverID"),
                        rs.getString("role_target"),
                        rs.getString("message"),
                        rs.getInt("senderID"),
                        rs.getInt("blogID"),
                        rs.getBoolean("isRead"),
                        rs.getTimestamp("create_at")
                );
                lstNoti.add(noti);
            }
        }

    } catch (Exception ex) {
        ex.printStackTrace();
    }

    return lstNoti;
}

    
    public int getTotalNotify(int authorID , String role) {
    int count = 0;
    String sql = "SELECT COUNT(*) FROM Notifications WHERE Notifications.isRead = 0";
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

}
