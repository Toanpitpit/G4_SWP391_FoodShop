/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.model.Blogs;
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
public class BlogDAO {

    Connection conn;
    PreparedStatement ps;
    CallableStatement cs = null;
    ResultSet rs;
    DBConnect db = new DBConnect();
    

 public List<Blogs> getBlogsByFilter(String keyword, int typeBMI, boolean sortNewestFirst , String status) {
    List<Blogs> lstBlog = new ArrayList<>();
    DBConnect db = new DBConnect();

    try {
        
        StringBuilder sql = new StringBuilder(
            "SELECT b.blogID, b.AuthorID, a.name AS authorName, b.typeBMI, b.title, " +
            "b.image, b.content, b.status, b.create_at, b.update_at " +
            "FROM Blogs b JOIN Accounts a ON b.AuthorID = a.id WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (typeBMI != -1) {
            sql.append("AND b.typeBMI = ? ");
            params.add(typeBMI);
        }

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (b.title LIKE ? OR a.name LIKE ?) ");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND (b.status = ?) ");
            params.add(status);
        }
        sql.append("ORDER BY b.update_at ").append(sortNewestFirst ? "DESC" : "ASC");

        conn = db.getConnection();
        ps = conn.prepareStatement(sql.toString());

        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        rs = ps.executeQuery();
        while (rs.next()) {
            Blogs blog = new Blogs(
                rs.getInt("blogID"),
                rs.getInt("AuthorID"),
                rs.getString("authorName"),
                rs.getInt("typeBMI"),
                rs.getString("title"),
                rs.getString("image"),
                rs.getString("content"),
                rs.getString("status"),
                rs.getTimestamp("create_at"),
                rs.getTimestamp("update_at")
            );
            lstBlog.add(blog);
        }
        conn.close();
    } catch (Exception ex) {
        ex.printStackTrace();
    } 
    

    return lstBlog;
}
 public List<MonthlyStat> countByTypeBMI(int authorId) throws SQLException {
        
            
       

    StringBuilder sql = new StringBuilder(
        "SELECT typeBMI, COUNT(*) AS cnt FROM Blogs "
    );
    if (authorId > 0 ) {
        sql.append("WHERE AuthorID = ? ");
    }
    sql.append("GROUP BY typeBMI ORDER BY typeBMI");

    List<MonthlyStat> result = new ArrayList<>();
        try {
            conn = db.getConnection();
        } catch (Exception ex) {
            Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    try (  
            PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        if (authorId >=0 ) {
            ps.setInt(1, authorId);
        }
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            int typeId = rs.getInt("typeBMI");
            int cnt    = rs.getInt("cnt");

            MonthlyStat m = new MonthlyStat();
            m.setMonthlName(String.valueOf(typeId));
            m.setCount(cnt);
            result.add(m);
        }
        conn.close();
    }

    return result;
}


    public boolean insertBlog(Blogs blog) {
    
        try {
            conn = db.getConnection();
            conn.setAutoCommit(true);

            String sql = "{call InsertBlog(?, ?, ?, ?, ?, ?)}";
            cs = conn.prepareCall(sql);

            cs.setInt(1, blog.getAuthorID());
            cs.setInt(2, blog.getBmiId());
            cs.setString(3, blog.getTitle());
            cs.setString(4, blog.getImageUlr());
            cs.setString(5, blog.getContent());
            cs.setString(6, blog.getStatus());

            boolean hasResultSet = cs.execute();

            if (hasResultSet) {
                ResultSet rs = cs.getResultSet();
                if (rs.next()) {
                    return true;
                }
            } else {
                return false;
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) { 
            Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void updateBlog(Blogs blog)  {
        DBConnect db = new DBConnect();
        try {
            conn = db.getConnection();
            conn.setAutoCommit(true);

            String sql = "{call UpdateBlog(?, ?, ?, ?, ?, ?)}";
            cs = conn.prepareCall(sql);

            cs.setInt(1, blog.getbID());         // blogID là tham số đầu tiên
            cs.setInt(2, blog.getBmiId());
            cs.setString(3, blog.getTitle());
            cs.setString(4, blog.getImageUlr());
            cs.setString(5, blog.getContent());
            cs.setString(6, blog.getStatus());

            boolean hasResultSet = cs.execute();

            if (hasResultSet) {
                ResultSet rs = cs.getResultSet();
                if (rs.next()) {
                    System.out.println("Rows affected: " + rs.getInt("RowsAffected"));
                }
            } else {
                System.out.println("Procedure executed, no result set.");
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception ex) {
            Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
    public void deleteBlogByID(int blogID) {
    try {
        String sql = "DELETE FROM Blogs WHERE blogID = ?";

        conn = db.getConnection();
        ps = conn.prepareStatement(sql);
        ps.setInt(1, blogID);

        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            System.out.println("Xóa blog thành công. Số dòng bị ảnh hưởng: " + rowsAffected);
        } else {
            System.out.println("Không tìm thấy blog để xóa.");
        }
        conn.close();

    } catch (Exception ex) {
        Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, ex);
    } 
}

public List<Blogs> getBlogsByFilterAndPage(
        String keyword,
        int typeBMI,
        boolean sortNewestFirst,
        String status,
        int pageIndex,
        int pageSize
) {
    List<Blogs> lstBlog = new ArrayList<>();
    try {
        StringBuilder sql = new StringBuilder(
            "SELECT b.blogID, b.AuthorID, a.name AS authorName, b.typeBMI, " +
            "       b.title, b.image, b.content, b.status, b.create_at, b.update_at " +
            "FROM Blogs b " +
            "  JOIN Accounts a ON b.AuthorID = a.id " +
            "WHERE 1 = 1 "
        );
        List<Object> params = new ArrayList<>();
        if (typeBMI != -1) {
            sql.append("  AND b.typeBMI = ? ");
            params.add(typeBMI);
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("  AND (b.title LIKE ? OR a.name LIKE ?) ");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append("  AND b.status = ? ");
            params.add(status.trim());
        }
        sql.append("ORDER BY b.update_at ").append(sortNewestFirst ? "DESC " : "ASC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;");

        conn = db.getConnection();
        ps = conn.prepareStatement(sql.toString());
        int idx = 1;
        for (Object param : params) {
            ps.setObject(idx++, param);
        }
        int offset = (pageIndex - 1) * pageSize;
        ps.setInt(idx++, offset);
        ps.setInt(idx, pageSize);

        rs = ps.executeQuery();
        while (rs.next()) {
            Blogs blog;
            blog = new Blogs(
                    rs.getInt("blogID"),
                    rs.getInt("AuthorID"),
                    rs.getString("authorName"),
                    rs.getInt("typeBMI"),
                    rs.getString("title"),
                    rs.getString("image"),
                    rs.getString("content"),
                    rs.getString("status"),
                    rs.getTimestamp("create_at"),
                    rs.getTimestamp("update_at")
            );
            lstBlog.add(blog);
        }
        conn.close ();
    } catch (Exception ex) {
        ex.printStackTrace();
    } 
    return lstBlog;
}
    public List<String> getAllDistinctStatuses() throws SQLException, Exception {
        List<String> statuses = new ArrayList<>();
        String sql = "SELECT DISTINCT status FROM Blogs";
        conn = db.getConnection();
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
        while (rs.next()) {
            statuses.add(rs.getString(1));
        }
        conn.close();
        return statuses;
    }
    
    public int getTotalBlog() {
        int count = 0;
        try {
            conn = db.getConnection ();
            String sql = "SELECT COUNT (*) FROM Blogs";
            ps = conn.prepareStatement (sql);
            rs = ps.executeQuery ();
            while (rs.next ()) {
               return rs.getInt (1);
            }
            conn.close ();
        } catch (Exception ex) {
            Logger.getLogger (BlogDAO.class.getName ()).log (Level.SEVERE, null, ex);
        }
        return count;
    }

}

