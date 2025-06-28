package com.example.servlet.dao;

import com.example.servlet.model.Category;
import com.example.servlet.utils.DBConnect;

import java.sql.*;
import java.util.*;

public class CategoryDAO {

    private static final String BASE_QUERY
            = "SELECT c.catID, c.caName, c.description, c.create_at, c.update_at FROM Category c WHERE 1=1 ";

    public List<Category> getListCategories(String name, String description,
            Map<String, String> sortFields, int page, int pageSize) throws SQLException {

        QueryBuilder queryBuilder = new QueryBuilder (BASE_QUERY)
                .addFilter ("name", name)
                .addFilter ("description", description)
                .addSorting (sortFields)
                .addPagination (page, pageSize);

        return executeQuery (queryBuilder);
    }

    public int getListCategoriesTotal(String name, String description,
            Map<String, String> sortFields) throws SQLException {

        QueryBuilder queryBuilder = new QueryBuilder (BASE_QUERY)
                .addFilter ("name", name)
                .addFilter ("description", description)
                .addSorting (sortFields);

        return executeQuery (queryBuilder).size ();
    }

    public List<Category> getListCategoriesNoP(String name, String description,
            Map<String, String> sortFields) throws SQLException {

        QueryBuilder queryBuilder = new QueryBuilder (BASE_QUERY)
                .addFilter ("name", name)
                .addFilter ("description", description)
                .addSorting (sortFields);

        return executeQuery (queryBuilder);
    }

    private List<Category> executeQuery(QueryBuilder queryBuilder) throws SQLException {
        List<Category> categoryList = new ArrayList<> ();
        DBConnect db = new DBConnect ();
        try (Connection conn = db.getConnection (); PreparedStatement ps = conn.prepareStatement (queryBuilder.getSql ())) {

            queryBuilder.setParameters (ps);

            try (ResultSet rs = ps.executeQuery ()) {
                while (rs.next ()) {
                    categoryList.add (mapResultSetToCategory (rs));
                }
            }
        }

        return categoryList;
    }

    private Category mapResultSetToCategory(ResultSet rs) throws SQLException {
        Category category = new Category ();
        category.setCatID (rs.getInt ("catID"));
        category.setCaName (rs.getString ("caName"));
        category.setDecription (rs.getString ("description"));
        category.setCreate_at (rs.getTimestamp ("create_at"));
        category.setUpdate_at (rs.getTimestamp ("update_at"));
        return category;
    }

    private static class QueryBuilder {

        private final StringBuilder sql;
        private final List<Object> parameters;

        public QueryBuilder(String baseQuery) {
            this.sql = new StringBuilder (baseQuery);
            this.parameters = new ArrayList<> ();
        }

        public QueryBuilder addFilter(String type, String value) {
            if (value != null && !value.trim ().isEmpty ()) {
                switch (type) {
                    case "name":
                        sql.append ("AND c.caName LIKE ? ");
                        parameters.add ("%" + value.trim () + "%");
                        break;
                    case "description":
                        sql.append ("AND c.description LIKE ? ");
                        parameters.add ("%" + value.trim () + "%");
                        break;
                }
            }
            return this;
        }

        public QueryBuilder addSorting(Map<String, String> sortFields) {
            if (sortFields != null && !sortFields.isEmpty ()) {
                List<String> expressions = new ArrayList<> ();
                for (Map.Entry<String, String> entry : sortFields.entrySet ()) {
                    String dbField = mapSortField (entry.getKey ());
                    if (dbField != null) {
                        String direction = entry.getValue ().equalsIgnoreCase ("desc") ? "DESC" : "ASC";
                        expressions.add (dbField + " " + direction);
                    }
                }
                if (!expressions.isEmpty ()) {
                    sql.append ("ORDER BY ").append (String.join (", ", expressions)).append (" ");
                }
            }
            return this;
        }

        public QueryBuilder addPagination(int page, int pageSize) {
            if (!sql.toString ().toLowerCase ().contains ("order by")) {
                sql.append ("ORDER BY c.catID ");
            }
            sql.append ("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
            parameters.add ((page - 1) * pageSize);
            parameters.add (pageSize);
            return this;
        }

        private String mapSortField(String field) {
            switch (field) {
                case "id":
                    return "c.catID";
                case "name":
                    return "c.caName";
                case "description":
                    return "c.description";
                case "create_at":
                    return "c.create_at";
                case "update_at":
                    return "c.update_at";
                default:
                    return null;
            }
        }

        public String getSql() {
            return sql.toString ();
        }

        public void setParameters(PreparedStatement ps) throws SQLException {
            for (int i = 0; i < parameters.size (); i++) {
                ps.setObject (i + 1, parameters.get (i));
            }
        }
    }

    public boolean insertCategory(Category category) {
        DBConnect db = new DBConnect ();
        String sql = "INSERT INTO Category (caName, description) VALUES (?, ?)";
        try (PreparedStatement ps = db.getConnection ().prepareStatement (sql)) {
            ps.setString (1, category.getCaName ());
            ps.setString (2, category.getDecription ());
            return ps.executeUpdate () > 0;
        } catch (SQLException e) {
            e.printStackTrace ();
            return false;
        }
    }

    public boolean updateCategory(Category category) {
        DBConnect db = new DBConnect ();
        String sql = "UPDATE Category SET caName = ?, description = ?, update_at = ? WHERE catID = ?";
        try (PreparedStatement ps = db.getConnection ().prepareStatement (sql)) {
            ps.setString (1, category.getCaName ());
            ps.setString (2, category.getDecription ());
            ps.setTimestamp (3, new Timestamp (System.currentTimeMillis ()));
            ps.setInt (4, category.getCatID ());
            return ps.executeUpdate () > 0;
        } catch (SQLException e) {
            e.printStackTrace ();
            return false;
        }
    }
    public boolean deleteCategory(int catID) {
    DBConnect db = new DBConnect();
    String sql = "DELETE FROM Category WHERE catID = ?";
    try (PreparedStatement ps = db.getConnection().prepareStatement(sql)) {
        ps.setInt(1, catID);
        return ps.executeUpdate() > 0;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}


    public boolean existsByName(String caName) {
        DBConnect db = new DBConnect ();
        String sql = "SELECT TOP 1 1 FROM Category WHERE caName = ?";
        try (PreparedStatement ps = db.getConnection ().prepareStatement (sql)) {
            ps.setString (1, caName);
            try (ResultSet rs = ps.executeQuery ()) {
                return rs.next ();
            }
        } catch (SQLException e) {
            e.printStackTrace ();
            return false;
        }
    }

    public boolean isDuplicateNameExceptId(String caName, int excludeId) {
        DBConnect db = new DBConnect ();
        String sql = "SELECT TOP 1 1 FROM Category WHERE caName = ? AND catID != ?";
        try (PreparedStatement ps = db.getConnection ().prepareStatement (sql)) {
            ps.setString (1, caName);
            ps.setInt (2, excludeId);
            try (ResultSet rs = ps.executeQuery ()) {
                return rs.next ();
            }
        } catch (SQLException e) {
            e.printStackTrace ();
            return false;
        }
    }

    public Category getCategoryByID(int id) {
        DBConnect db = new DBConnect ();
        String sql = BASE_QUERY + "AND c.catID = ?";

        try (Connection conn = db.getConnection (); PreparedStatement ps = conn.prepareStatement (sql)) {

            ps.setInt (1, id);
            try (ResultSet rs = ps.executeQuery ()) {
                if (rs.next ()) {
                    return mapResultSetToCategory (rs);
                } else {
                    return null;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace ();
            return null;
        }
    }

    public boolean hasAnyFoodOrDraftLinkedToCategory(int catID) {
        String sql
                = "SELECT 1 FROM Foods WHERE catID = ? "
                + "UNION "
                + "SELECT 1 FROM FoodDrafts WHERE catID = ?";

        try (
                Connection conn = new DBConnect ().getConnection (); PreparedStatement ps = conn.prepareStatement (sql)) {
            ps.setInt (1, catID);
            ps.setInt (2, catID);

            try (ResultSet rs = ps.executeQuery ()) {
                return rs.next ();
            }

        } catch (SQLException e) {
            e.printStackTrace ();
            return false;
        }
    }

}
