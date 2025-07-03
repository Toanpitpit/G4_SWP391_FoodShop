/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.model.MonthlyStat;
import com.example.servlet.model.Requests;
import com.example.servlet.utils.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class RequestDAO {
    
    
   private static final String BASE_QUERY = 
        "SELECT r.reqID, r.title, r.nutritionistID as authorID, a1.name as authorName, " +
        "r.type, r.foodDraftID as draftID, fd.pName as foodName, r.status, r.requestNote,r.responseNote, " +
        "a2.name as handleBY, r.create_at, r.update_at " +
        "FROM Requests r " +
        "LEFT JOIN Accounts a1 ON r.nutritionistID = a1.id " +
        "LEFT JOIN Accounts a2 ON r.handleID = a2.id " +
        "LEFT JOIN FoodDrafts fd ON r.foodDraftID = fd.pdrID " +
        "WHERE 1=1 ";

    public List<Requests> getListRequests(Map<String, String> filters, 
            Map<String, String> sortFields, int page, int pageSize) throws SQLException {

        QueryBuilder queryBuilder = new QueryBuilder(BASE_QUERY)
                .addFilters(filters)
                .addSorting(sortFields)
                .addPagination(page, pageSize);

        return executeQuery(queryBuilder);
    }

    public int getListRequestsTotal(Map<String, String> filters, 
            Map<String, String> sortFields) throws SQLException {

        QueryBuilder queryBuilder = new QueryBuilder(BASE_QUERY)
                .addFilters(filters)
                .addSorting(sortFields);

        return executeQuery(queryBuilder).size();
    }

    public List<Requests> getListRequestsNoP(Map<String, String> filters, 
            Map<String, String> sortFields) throws SQLException {

        QueryBuilder queryBuilder = new QueryBuilder(BASE_QUERY)
                .addFilters(filters)
                .addSorting(sortFields);

        return executeQuery(queryBuilder);
    }

    private List<Requests> executeQuery(QueryBuilder queryBuilder) throws SQLException {
        List<Requests> requestsList = new ArrayList<>();
        DBConnect db = new DBConnect();
        try (Connection conn = db.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(queryBuilder.getSql())) {

            queryBuilder.setParameters(ps);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    requestsList.add(mapResultSetToRequests(rs));
                }
            }
        }

        return requestsList;
    }

    private Requests mapResultSetToRequests(ResultSet rs) throws SQLException {
        Requests request = new Requests();
        request.setrID (rs.getInt("reqID"));
        request.setTitle(rs.getString("title"));
        request.setAuthorID(rs.getInt("authorID"));
        request.setAuthorName(rs.getString("authorName"));
        request.setType(rs.getString("type"));
        request.setDraftID(rs.getInt("draftID"));
        request.setFoodName(rs.getString("foodName"));
        request.setStatus(rs.getString("status"));
        request.setRequestNote (rs.getString("requestNote"));
        request.setResponseNote (rs.getString("responseNote"));
        request.setHandleBY(rs.getString("handleBY"));
        request.setCreate_at(rs.getTimestamp("create_at"));
        request.setUpdate_at(rs.getTimestamp("update_at"));
        return request;
    }

    private static class QueryBuilder {

        private final StringBuilder sql;
        private final List<Object> parameters;

        public QueryBuilder(String baseQuery) {
            this.sql = new StringBuilder(baseQuery);
            this.parameters = new ArrayList<>();
        }

        public QueryBuilder addFilters(Map<String, String> filters) {
            if (filters != null && !filters.isEmpty()) {
                for (Map.Entry<String, String> entry : filters.entrySet()) {
                    addFilter(entry.getKey(), entry.getValue());
                }
            }
            return this;
        }

        public QueryBuilder addFilter(String type, String value) {
            if (value != null && !value.trim().isEmpty()) {
                switch (type) {
                    case "title":
                        sql.append("AND r.title LIKE ? ");
                        parameters.add("%" + value.trim() + "%");
                        break;
                    case "type":
                        sql.append("AND r.type = ? ");
                        parameters.add(value.trim());
                        break;
                    case "status":
                        sql.append("AND r.status = ? ");
                        parameters.add(value.trim());
                        break;
                    case "authorName":
                        sql.append("AND a1.name LIKE ? ");
                        parameters.add("%" + value.trim() + "%");
                        break;
                    case "handlerName":
                        sql.append("AND a2.name LIKE ? ");
                        parameters.add("%" + value.trim() + "%");
                        break;
                }
            }
            return this;
        }

        public QueryBuilder addSorting(Map<String, String> sortFields) {
            if (sortFields != null && !sortFields.isEmpty()) {
                List<String> expressions = new ArrayList<>();
                for (Map.Entry<String, String> entry : sortFields.entrySet()) {
                    String dbField = mapSortField(entry.getKey());
                    if (dbField != null) {
                        String direction = entry.getValue().equalsIgnoreCase("desc") ? "DESC" : "ASC";
                        expressions.add(dbField + " " + direction);
                    }
                }
                if (!expressions.isEmpty()) {
                    sql.append("ORDER BY ").append(String.join(", ", expressions)).append(" ");
                }
            }
            return this;
        }

        public QueryBuilder addPagination(int page, int pageSize) {
            if (!sql.toString().toLowerCase().contains("order by")) {
                sql.append("ORDER BY r.reqID ");
            }
            sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
            parameters.add((page - 1) * pageSize);
            parameters.add(pageSize);
            return this;
        }

        private String mapSortField(String field) {
            switch (field) {
                case "id":
                case "reqID":
                    return "r.reqID";
                case "title":
                    return "r.title";
                case "authorName":
                    return "a1.name";
                case "type":
                    return "r.type";
                case "foodName":
                    return "fd.pName";
                case "status":
                    return "r.status";
                case "handleBY":
                    return "a2.name";
                case "create_at":
                    return "r.create_at";
                case "update_at":
                    return "r.update_at";
                default:
                    return null;
            }
        }

        public String getSql() {
            return sql.toString();
        }

        public void setParameters(PreparedStatement ps) throws SQLException {
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
            }
        }
    }

    public boolean insertRequest(Requests request) {
        DBConnect db = new DBConnect();
        String sql = "INSERT INTO Requests (title, nutritionistID, type, foodDraftID, status, requestNote,responseNote) VALUES (?, ?, ?, ?, ?, ?,?)";
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setString(1, request.getTitle());
            ps.setInt(2, request.getAuthorID());
            ps.setString(3, request.getType());
            ps.setInt(4, request.getDraftID());
            ps.setString(5, request.getStatus() != null ? request.getStatus() : "Pending");
            ps.setString(6, request.getRequestNote ());
            ps.setString(7, request.getResponseNote ());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateRequest(Requests request) {
        DBConnect db = new DBConnect();
        String sql = "UPDATE Requests SET title = ?, type = ?, status = ?, requestNote = ?, responseNote = ?, handleID = ?, update_at = ? WHERE reqID = ?";
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setString(1, request.getTitle());
            ps.setString(2, request.getType());
            ps.setString(3, request.getStatus());
            ps.setString(4, request.getRequestNote ());
            ps.setString(5, request.getResponseNote ());
           
            ps.setObject(6, null); // You might need to resolve handleID from handleBY name
            ps.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
            ps.setInt(8, request.getrID ());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateRequestStatus(int reqID, String status, int handleID, String note) {
        DBConnect db = new DBConnect();
        String sql = "UPDATE Requests SET status = ?, handleID = ?, note = ?, update_at = ? WHERE reqID = ?";
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, handleID);
            ps.setString(3, note);
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            ps.setInt(5, reqID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteRequest(int reqID) {
        DBConnect db = new DBConnect();
        String sql = "DELETE FROM Requests WHERE reqID = ?";
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setInt(1, reqID);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Requests getRequestByID(int id) {
        DBConnect db = new DBConnect();
        String sql = BASE_QUERY + "AND r.reqID = ?";

        try (Connection conn = db.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRequests(rs);
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Requests> getRequestsByAuthorID(int authorID) {
        DBConnect db = new DBConnect();
        String sql = BASE_QUERY + "AND r.nutritionistID = ?";

        try (Connection conn = db.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, authorID);
            List<Requests> requestsList = new ArrayList<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    requestsList.add(mapResultSetToRequests(rs));
                }
            }
            return requestsList;
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<Requests> getRequestsByStatus(String status) {
        DBConnect db = new DBConnect();
        String sql = BASE_QUERY + "AND r.status = ?";

        try (Connection conn = db.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            List<Requests> requestsList = new ArrayList<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    requestsList.add(mapResultSetToRequests(rs));
                }
            }
            return requestsList;
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<Requests> getRequestsByHandlerID(int handlerID) {
        DBConnect db = new DBConnect();
        String sql = BASE_QUERY + "AND r.handleID = ?";

        try (Connection conn = db.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, handlerID);
            List<Requests> requestsList = new ArrayList<>();
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    requestsList.add(mapResultSetToRequests(rs));
                }
            }
            return requestsList;
        } catch (SQLException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public int getRequestsCountByStatus(String status) {
        DBConnect db = new DBConnect();
        String sql = "SELECT COUNT(*) FROM Requests WHERE status = ?";
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean existsByTitleAndAuthor(String title, int authorID) {
        DBConnect db = new DBConnect();
        String sql = "SELECT TOP 1 1 FROM Requests WHERE title = ? AND nutritionistID = ?";
        try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setInt(2, authorID);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

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
