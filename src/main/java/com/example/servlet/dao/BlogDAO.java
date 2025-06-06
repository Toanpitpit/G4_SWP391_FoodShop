/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.model.Blogs;
import com.example.servlet.model.MonthlyStat;
import com.example.servlet.utils.DBConnect;
import java.io.File;
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
//
//    Connection conn;
//    PreparedStatement ps;
//    CallableStatement cs = null;
//    ResultSet rs;
//    DBConnect db = new DBConnect ();

public List<Blogs> getBlogsByFilter(String keyword, int typeBMI, boolean sortNewestFirst, String status) {
    List<Blogs> lstBlog = new ArrayList<>();
    DBConnect db = new DBConnect();

    StringBuilder sql = new StringBuilder(
            "SELECT b.blogID, b.AuthorID, a.name AS authorName, b.typeBMI, b.title, "
            + "b.image, b.content, b.status, b.create_at, b.update_at "
            + "FROM Blogs b JOIN Accounts a ON b.AuthorID = a.id WHERE 1=1 "
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
        sql.append("AND b.status = ? ");
        params.add(status);
    }

    sql.append("ORDER BY b.update_at ").append(sortNewestFirst ? "DESC" : "ASC");

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

        // Set parameters
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }

        try (ResultSet rs = ps.executeQuery()) {
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
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    finally{
        db.closeConnection ();
    }

    return lstBlog;
}


   public List<MonthlyStat> countByTypeBMI(int authorId) {
    List<MonthlyStat> result = new ArrayList<>();
    StringBuilder sql = new StringBuilder(
        "SELECT typeBMI, COUNT(*) AS cnt FROM Blogs "
    );

    // Chỉ thêm WHERE khi authorId > 0
    if (authorId > 0) {
        sql.append("WHERE AuthorID = ? ");
    }

    sql.append("GROUP BY typeBMI ORDER BY typeBMI");

    DBConnect db = new DBConnect();

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

        if (authorId > 0) {
            ps.setInt(1, authorId);
        }

        try (ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int typeId = rs.getInt("typeBMI");
                int cnt = rs.getInt("cnt");

                MonthlyStat m = new MonthlyStat();
                m.setMonthlName(String.valueOf(typeId)); 
                m.setCount(cnt);
                result.add(m);
            }
        }

    } catch (SQLException ex) {
        Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, ex);
    }finally{
        db.closeConnection ();
    }

    return result;
}


    public boolean insertBlog(Blogs blog) {
    String sql = "{call InsertBlog(?, ?, ?, ?, ?, ?)}";
    DBConnect db = new DBConnect();

    try (Connection conn = db.getConnection();
         CallableStatement cs = conn.prepareCall(sql)) {

        cs.setInt(1, blog.getAuthorID());
        cs.setInt(2, blog.getBmiId());
        cs.setString(3, blog.getTitle());
        cs.setString(4, blog.getImageUlr());
        cs.setString(5, blog.getContent());
        cs.setString(6, blog.getStatus());

        boolean hasResultSet = cs.execute();

        if (hasResultSet) {
            try (ResultSet rs = cs.getResultSet()) {
                if (rs.next()) {
                    return true;
                }
            }
        } else {
            // Nếu procedure không trả resultset, bạn có thể check update count
            int updateCount = cs.getUpdateCount();
            return updateCount > 0;
        }

    } catch (SQLException e) {
        e.printStackTrace();
        // Bạn có thể log hoặc throw exception tùy mục đích
    }finally{
        db.closeConnection ();
    }

    return false;
}

public boolean deleteBlogByID(int blogID) {
    String sql = "DELETE FROM Blogs WHERE blogID = ?";
    DBConnect db = new DBConnect();

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, blogID);

        int rowsAffected = ps.executeUpdate();
        return rowsAffected > 0;

    } catch (SQLException ex) {
        Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, ex);
    }finally{
        db.closeConnection ();
    }

    return false;
}

    public boolean deleteImage(String absolutePath) {
        File file = new File (absolutePath);
        if (file.exists ()) {
            boolean deleted = file.delete ();
            if (!deleted) {
                System.out.println ("Failed to delete: " + absolutePath);
            }
            return deleted;
        } else {
            System.out.println (" File not found: " + absolutePath);
            return false;
        }
    }


  public String getPathBlogByID(int blogID) {
    String path = "";
    String sql = "SELECT image FROM Blogs WHERE blogID = ?";
    DBConnect db = new DBConnect();

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, blogID);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                path = rs.getString(1);
            }
        }

    } catch (SQLException ex) {
        Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, ex);
    }finally{
        db.closeConnection ();
    }

    return path;
}


 public Blogs getBlogByID(int blogID) {
    Blogs blog = null;
    String sql = "SELECT b.blogID, b.AuthorID, a.name AS authorName, b.typeBMI, b.title, "
               + "b.image, b.content, b.status, b.create_at, b.update_at "
               + "FROM Blogs b JOIN Accounts a ON b.AuthorID = a.id WHERE b.blogID = ?";
    DBConnect db = new DBConnect();

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        ps.setInt(1, blogID);

        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                blog = new Blogs();
                blog.setbID(rs.getInt("blogID"));
                blog.setAuthorID(rs.getInt("AuthorID"));
                blog.setAuthorName(rs.getString("authorName"));
                blog.setBmiId(rs.getInt("typeBMI"));
                blog.setTitle(rs.getString("title"));
                blog.setImageUlr(rs.getString("image"));
                blog.setContent(rs.getString("content"));
                blog.setStatus(rs.getString("status"));
                blog.setCreate_at(rs.getTimestamp("create_at"));
                blog.setUpdate_at(rs.getTimestamp("update_at"));
            }
        }

    } catch (SQLException ex) {
        Logger.getLogger(BlogDAO.class.getName()).log(Level.SEVERE, null, ex);
    }finally{
        db.closeConnection ();
    }

    return blog;
}


public List<Blogs> getBlogsByFilterAndPage(
        String keyword,
        int typeBMI,
        boolean sortNewestFirst,
        String status,
        int pageIndex,
        int pageSize
) throws SQLException {
    List<Blogs> lstBlog = new ArrayList<>();
    StringBuilder sql = new StringBuilder(
            "SELECT b.blogID, b.AuthorID, a.name AS authorName, b.typeBMI, "
            + "b.title, b.image, b.content, b.status, b.create_at, b.update_at "
            + "FROM Blogs b JOIN Accounts a ON b.AuthorID = a.id WHERE 1=1 "
    );

    List<Object> params = new ArrayList<>();
    if (typeBMI != -1) {
        sql.append(" AND b.typeBMI = ? ");
        params.add(typeBMI);
    }
    if (keyword != null && !keyword.trim().isEmpty()) {
        sql.append(" AND (b.title LIKE ? OR a.name LIKE ?) ");
        String like = "%" + keyword.trim() + "%";
        params.add(like);
        params.add(like);
    }
    if (status != null && !status.trim().isEmpty()) {
        sql.append(" AND b.status = ? ");
        params.add(status.trim());
    }

    sql.append(" ORDER BY b.update_at ").append(sortNewestFirst ? "DESC " : "ASC ");
    sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;");

    DBConnect db = new DBConnect();

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql.toString())) {

        int idx = 1;
        for (Object param : params) {
            ps.setObject(idx++, param);
        }
        int offset = (pageIndex - 1) * pageSize;
        ps.setInt(idx++, offset);
        ps.setInt(idx, pageSize);

        try (ResultSet rs = ps.executeQuery()) {
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
        }
    }finally{
        db.closeConnection ();
    }

    return lstBlog;
}


   public List<String> getAllDistinctStatuses() throws SQLException {
    List<String> statuses = new ArrayList<>();
    String sql = "SELECT DISTINCT status FROM Blogs";
    DBConnect db = new DBConnect();

    try (Connection conn = db.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            statuses.add(rs.getString(1));
        }
    }finally{
        db.closeConnection ();
    }

    return statuses;
}

public int getTotalBlog() {
    int count = 0;
    String sql = "SELECT COUNT(*) FROM Blogs";
    DBConnect db = new DBConnect();

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
