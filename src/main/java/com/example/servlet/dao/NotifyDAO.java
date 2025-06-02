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

/**
 *
 * @author Admin
 */
public class NotifyDAO {
    
    Connection conn;
    PreparedStatement ps;
    CallableStatement cs = null;
    ResultSet rs;
    DBConnect db = new DBConnect();
    
    
    public List<Notifys> getNotificationsByFilter(Integer receiverID, String roleTarget, Boolean isRead, boolean sortNewestFirst) {
    List<Notifys> lstNoti = new ArrayList<>();
    DBConnect db = new DBConnect();
//notiID, receiverID, role_target, message, senderID, relatedRequestID, isRead, create_at "
    try {
        StringBuilder sql = new StringBuilder(
            "SELECT * " +
            "FROM Notifications WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (receiverID != null) {
            sql.append("AND receiverID = ? ");
            params.add(receiverID);
            
        } else 
            if (roleTarget != null && !roleTarget.trim().isEmpty()) {
            sql.append("AND role_target = ? ");
            params.add(roleTarget);
        }

        if (isRead != null) {
            sql.append("AND isRead = ? ");
            params.add(isRead);
        }

        sql.append("ORDER BY create_at ").append(sortNewestFirst ? "DESC" : "ASC");

        conn = db.getConnection();
        ps = conn.prepareStatement(sql.toString());

        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        rs = ps.executeQuery();
        while (rs.next()) {
            Notifys noti = new Notifys(
                rs.getInt(1),
                rs.getInt(2),
                rs.getString(3),
                rs.getString(4),
                rs.getInt(5),
                rs.getInt(6),
                rs.getBoolean(7),
                rs.getTimestamp(8)
            );
            lstNoti.add(noti);
        }

    } catch (Exception ex) {
        ex.printStackTrace();
    } finally {
        db.closeConnection();
    }

    return lstNoti;
}

}
