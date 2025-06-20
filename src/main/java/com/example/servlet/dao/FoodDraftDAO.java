/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.model.Food_Draft;
import com.example.servlet.utils.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class FoodDraftDAO {
     
     private static final String BASE_QUERY
            = "SELECT DISTINCT fd.pdrID, fd.originID, fd.authorID, fd.pName, c.caName, "
            + "(SELECT TOP 1 b.classification FROM FoodBMIRecommendation fbr2 "
            + " LEFT JOIN bmi_classification b ON fbr2.bmiID = b.type_id "
            + " WHERE fbr2.fdrID = fd.pdrID AND fbr2.isDraft = 1) AS bmi_type, "
            + "fd.p_image, fd.price, fd.status, fd.create_at, fd.update_at "
            + "FROM FoodDrafts fd "
            + "INNER JOIN Category c ON fd.catID = c.catID "
            + "WHERE 1=1 ";
    public List<Food_Draft> getListFoodDrafts(Map<String, String> filters, Map<String, String> sortAndPagination) throws SQLException {
        String searchKey = filters.get("searchKey");
        String category = filters.get("category");
        String status = filters.get("status");
        String searchPrice = filters.get("searchPrice");
        String priceRank = filters.get("priceRank");
        String bmiId = filters.get("bmiId");
        String authorId = filters.get("authorId");
        
        Map<String, String> sortFields = new HashMap<>();
        for (Map.Entry<String, String> entry : sortAndPagination.entrySet()) {
            String key = entry.getKey();
            if (key.startsWith("sort") && !key.equals("page") && !key.equals("pageSize")) {
                String sortField = key.replace("sort", "").toLowerCase();
                if (sortField.equals("id")) sortField = "id";
                else if (sortField.equals("price")) sortField = "price";
                else if (sortField.equals("time")) sortField = "update_at";
                else if (sortField.equals("name")) sortField = "name";
                else if (sortField.equals("category")) sortField = "category";
                
                sortFields.put(sortField, entry.getValue());
            }
        }
        int page = 1;
        int pageSize = 10;
        
        try {
            if (sortAndPagination.get("page") != null) {
                page = Integer.parseInt(sortAndPagination.get("page"));
            }
            if (sortAndPagination.get("pageSize") != null) {
                pageSize = Integer.parseInt(sortAndPagination.get("pageSize"));
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid pagination parameters, using defaults");
        }

        QueryBuilder queryBuilder = new QueryBuilder(BASE_QUERY)
                .addFilter("name", searchKey) 
                .addFilter("category", category)
                .addFilter("status", status)
                .addFilter("searchPrice", searchPrice) 
                .addFilter("priceRank", priceRank) 
                .addFilter("bmiID", bmiId)
                .addFilter("authorID", authorId)
                .addSorting(sortFields)
                .addPagination(page, pageSize);

        return executeQuery(queryBuilder);
    }

    public int getListFoodDraftsTotal(Map<String, String> filters, Map<String, String> sortAndPagination) throws SQLException {
        
        String searchKey = filters.get("searchKey");
        String category = filters.get("category");
        String status = filters.get("status");
        String searchPrice = filters.get("searchPrice");
        String priceRank = filters.get("priceRank");
        String bmiId = filters.get("bmiId");
        String authorId = filters.get("authorId");
        
        Map<String, String> sortFields = new HashMap<>();
        for (Map.Entry<String, String> entry : sortAndPagination.entrySet()) {
            String key = entry.getKey();
            if (key.startsWith("sort") && !key.equals("page") && !key.equals("pageSize")) {
                String sortField = key.replace("sort", "").toLowerCase();
                if (sortField.equals("id")) sortField = "id";
                else if (sortField.equals("price")) sortField = "price";
                else if (sortField.equals("time")) sortField = "update_at";
                else if (sortField.equals("name")) sortField = "name";
                else if (sortField.equals("category")) sortField = "category";
                
                sortFields.put(sortField, entry.getValue());
            }
        }

        QueryBuilder queryBuilder = new QueryBuilder(BASE_QUERY)
                .addFilter("name", searchKey)
                .addFilter("category", category)
                .addFilter("status", status)
                .addFilter("searchPrice", searchPrice)
                .addFilter("priceRank", priceRank)
                .addFilter("bmiID", bmiId)
                .addFilter("authorID", authorId)
                .addSorting(sortFields);
                
        return executeQuery(queryBuilder).size();
    }

    private List<Food_Draft> executeQuery(QueryBuilder queryBuilder) throws SQLException {
        List<Food_Draft> foodDraftList = new ArrayList<> ();
        DBConnect db = new DBConnect ();
        System.out.println ("Generated SQL: " + queryBuilder.getSql ());
        System.out.println ("With parameters: " + queryBuilder.parameters);

        try (Connection conn = db.getConnection (); PreparedStatement ps = conn.prepareStatement (queryBuilder.getSql ())) {

            queryBuilder.setParameters (ps);

            try (ResultSet rs = ps.executeQuery ()) {
                while (rs.next ()) {
                    foodDraftList.add (mapResultSetToFoodDraft (rs));
                }
            }
        }

        return foodDraftList;
    }

    private Food_Draft mapResultSetToFoodDraft(ResultSet rs) throws SQLException {
        Food_Draft foodDraft = new Food_Draft ();
        foodDraft.setFdrID (rs.getInt ("pdrID"));
        foodDraft.setOriginID (rs.getInt ("originID"));
        int authorId = rs.getInt ("authorID");
        if (rs.wasNull ()) {
            foodDraft.setAuthorID (-1);
        } else {
            foodDraft.setAuthorID (authorId);
        }
        foodDraft.setFoodName (rs.getString ("pName"));
        foodDraft.setCatName (rs.getString ("caName"));
        foodDraft.setImageUlr (rs.getString ("p_image"));
        foodDraft.setPrice (rs.getDouble ("price"));
        foodDraft.setStatus (rs.getString ("status"));
        foodDraft.setCreate_at (rs.getTimestamp ("create_at"));
        foodDraft.setUpdate_at (rs.getTimestamp ("update_at"));
        return foodDraft;
    }

    private static class QueryBuilder {

        private final StringBuilder sql;
        private List<Object> parameters;

        public QueryBuilder(String baseQuery) {
            this.sql = new StringBuilder (baseQuery);
            this.parameters = new ArrayList<> ();
        }

        public QueryBuilder addFilter(String type, String value) {
            if (value != null && !value.trim ().isEmpty ()) {
                switch (type) {
                    case "name":
                        sql.append ("AND fd.pName LIKE ? ");
                        parameters.add ("%" + value.trim () + "%");
                        break;
                    case "category":
                        try {
                        int categoryId = Integer.parseInt (value.trim ());
                        sql.append ("AND fd.catID = ? ");
                        parameters.add (categoryId);
                    } catch (NumberFormatException e) {
                        System.err.println ("Invalid category ID: " + value);
                    }
                    break;
                    case "status":
                        sql.append ("AND fd.status = ? ");
                        parameters.add (value.trim ());
                        break;
                    case "searchPrice":
                        // Giá tối đa đơn giản từ input number
                        try {
                        double maxPrice = Double.parseDouble (value.trim ());
                        sql.append ("AND fd.price <= ? ");
                        parameters.add (maxPrice);
                    } catch (NumberFormatException e) {
                        System.err.println ("Invalid search price value: " + value);
                    }
                    break;
                    case "priceRank":
                        // Range giá từ dropdown
                        addPriceRangeFilter (value.trim ());
                        break;
                    case "bmiID":
                        addBMIFilter (value.trim ());
                        break;
                    case "authorID":
                        try {
                        int authorId = Integer.parseInt (value.trim ());
                        sql.append ("AND fd.authorID = ? ");
                        parameters.add (authorId);
                    } catch (NumberFormatException e) {
                        System.err.println ("Invalid author ID: " + value);
                    }
                    break;
                    default:
                        break;
                }
            }
            return this;
        }

        private void addPriceRangeFilter(String value) {
            try {
                if (value.contains ("-")) {
                    String[] parts = value.split ("-");
                    double min = Double.parseDouble (parts[0]);
                    double max = Double.parseDouble (parts[1]);
                    sql.append ("AND fd.price BETWEEN ? AND ? ");
                    parameters.add (min);
                    parameters.add (max);
                } else if (value.endsWith ("+")) {
                    double min = Double.parseDouble (value.replace ("+", ""));
                    sql.append ("AND fd.price > ? ");
                    parameters.add (min);
                } else {
                    double max = Double.parseDouble (value);
                    sql.append ("AND fd.price <= ? ");
                    parameters.add (max);
                }
            } catch (NumberFormatException e) {
                System.err.println ("Invalid price range filter value: " + value);
            }
        }

        private void addBMIFilter(String value) {
            try {
                int bmiId = Integer.parseInt (value);
                sql.append ("AND EXISTS (SELECT 1 FROM FoodBMIRecommendation fbr WHERE fbr.fdrID = fd.pdrID AND fbr.bmiID = ? AND fbr.isDraft = 1) ");
                parameters.add (bmiId);
            } catch (NumberFormatException e) {
                System.err.println ("Invalid BMI ID: " + value);
            }
        }

        public QueryBuilder addSorting(Map<String, String> sortFields) {
            if (sortFields != null && !sortFields.isEmpty ()) {
                List<String> sortExpressions = new ArrayList<> ();

                for (Map.Entry<String, String> entry : sortFields.entrySet ()) {
                    String dbField = mapSortField (entry.getKey ());
                    if (dbField != null) {
                        String direction = entry.getValue ().equalsIgnoreCase ("desc") ? "DESC" : "ASC";
                        sortExpressions.add (dbField + " " + direction);
                    }
                }

                if (!sortExpressions.isEmpty ()) {
                    sql.append ("ORDER BY ").append (String.join (", ", sortExpressions));
                    if (!sortExpressions.toString ().contains ("fd.pdrID")) {
                        sql.append (", fd.pdrID ASC ");
                    }
                    sql.append (" ");
                }
            }

            return this;
        }

        public QueryBuilder addPagination(int page, int pageSize) {
            if (!sql.toString ().toLowerCase ().contains ("order by")) {
                sql.append ("ORDER BY fd.pdrID ASC ");
            }
            sql.append ("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
            parameters.add ((page - 1) * pageSize);
            parameters.add (pageSize);
            return this;
        }

        private String mapSortField(String field) {
            switch (field) {
                case "id":
                case "sortID":
                    return "fd.pdrID";
                case "name":
                    return "fd.pName";
                case "price":
                case "sortPrice":
                    return "fd.price";
                case "create_at":
                    return "fd.create_at";
                case "update_at":
                case "sortTime":
                    return "fd.update_at";
                case "category":
                    return "c.caName";
                case "originID":
                    return "fd.originID";
                case "authorID":
                    return "fd.authorID";
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

    public Food_Draft getFoodDraftById(int foodDraftId) {
        String sql = BASE_QUERY + " AND fd.pdrID = ?";

        try (Connection conn = new DBConnect ().getConnection (); PreparedStatement stmt = conn.prepareStatement (sql)) {

            stmt.setInt (1, foodDraftId);

            try (ResultSet rs = stmt.executeQuery ()) {
                if (rs.next ()) {
                    return mapResultSetToFoodDraft (rs);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger (FoodDraftDAO.class.getName ()).log (Level.SEVERE, null, ex);
        }

        return null;
    }

    public List<Food_Draft> getFoodDraftsByAuthor(int authorId, int page, int pageSize) throws SQLException {
        QueryBuilder queryBuilder = new QueryBuilder (BASE_QUERY)
                .addFilter ("authorID", String.valueOf(authorId))
                .addPagination (page, pageSize);
        return executeQuery (queryBuilder);
    }
    public List<Food_Draft> getFoodDraftsByOrigin(int originId, int page, int pageSize) throws SQLException {
        String sql = BASE_QUERY + " AND fd.originID = ? ORDER BY fd.pdrID ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        List<Food_Draft> foodDraftList = new ArrayList<>();
        try (Connection conn = new DBConnect().getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, originId);
            stmt.setInt(2, (page - 1) * pageSize);
            stmt.setInt(3, pageSize);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    foodDraftList.add(mapResultSetToFoodDraft(rs));
                }
            }
        }

        return foodDraftList;
    }

    public boolean insertFoodDraft(Food_Draft foodDraft) {
        String sql = "INSERT INTO FoodDrafts (originID, authorID, pName, catID, p_image, price, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = new DBConnect().getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (foodDraft.getOriginID() == 0) {
                stmt.setNull(1, java.sql.Types.INTEGER);
            } else {
                stmt.setInt(1, foodDraft.getOriginID());
            }
            stmt.setInt(2, foodDraft.getAuthorID());
            stmt.setString(3, foodDraft.getFoodName());
            stmt.setObject(4, getCategoryIdByName(foodDraft.getCatName()));
            stmt.setString(5, foodDraft.getImageUlr());
            stmt.setDouble(6, foodDraft.getPrice());
            stmt.setString(7, foodDraft.getStatus());

            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(FoodDraftDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean updateFoodDraft(Food_Draft foodDraft) {
        String sql = "UPDATE FoodDrafts SET pName = ?, catID = ?, p_image = ?, price = ?, status = ?, update_at = GETDATE() "
                   + "WHERE pdrID = ?";

        try (Connection conn = new DBConnect().getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, foodDraft.getFoodName());
            stmt.setObject(2, getCategoryIdByName(foodDraft.getCatName()));
            stmt.setString(3, foodDraft.getImageUlr());
            stmt.setDouble(4, foodDraft.getPrice());
            stmt.setString(5, foodDraft.getStatus());
            stmt.setInt(6, foodDraft.getFdrID());

            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(FoodDraftDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean deleteFoodDraft(int foodDraftId) {
        String sql = "DELETE FROM FoodDrafts WHERE pdrID = ?";

        try (Connection conn = new DBConnect().getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, foodDraftId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(FoodDraftDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    private Integer getCategoryIdByName(String categoryName) {
        if (categoryName == null || categoryName.trim().isEmpty()) {
            return null;
        }

        String sql = "SELECT catID FROM Category WHERE caName = ?";
        try (Connection conn = new DBConnect().getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, categoryName.trim());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("catID");
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(FoodDraftDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<Food_Draft> getPendingFoodDraft(int page, int pageSize) throws SQLException {
        QueryBuilder queryBuilder = new QueryBuilder (BASE_QUERY)
                .addFilter ("status", "pending")
                .addPagination (page, pageSize);

        return executeQuery (queryBuilder);
    }

    public int countFoodDraftsByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM FoodDrafts WHERE status = ?";
        
        try (Connection conn = new DBConnect().getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(FoodDraftDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public boolean approveFoodDraft(int foodDraftId) {
        String selectSql = "SELECT * FROM FoodDrafts WHERE pdrID = ?";
        String insertSql = "INSERT INTO Foods (pName, catID, p_image, price, status) VALUES (?, ?, ?, ?, 'active')";
        String updateSql = "UPDATE FoodDrafts SET status = 'approved' WHERE pdrID = ?";

        try (Connection conn = new DBConnect().getConnection()) {
            conn.setAutoCommit(false);
            
            try {
                Food_Draft draft = null;
                try (PreparedStatement selectStmt = conn.prepareStatement(selectSql)) {
                    selectStmt.setInt(1, foodDraftId);
                    try (ResultSet rs = selectStmt.executeQuery()) {
                        if (rs.next()) {
                            draft = new Food_Draft();
                            draft.setFdrID(rs.getInt("pdrID"));
                            draft.setOriginID(rs.getInt("originID"));
                            draft.setAuthorID(rs.getInt("authorID"));
                            draft.setFoodName(rs.getString("pName"));
                            draft.setImageUlr(rs.getString("p_image"));
                            draft.setPrice(rs.getDouble("price"));
                            draft.setStatus(rs.getString("status"));
                        }
                    }
                }

                if (draft == null) {
                    conn.rollback();
                    return false;
                }
                try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                    insertStmt.setString(1, draft.getFoodName());
                    insertStmt.setObject(2, getCategoryIdByName(draft.getCatName()));
                    insertStmt.setString(3, draft.getImageUlr());
                    insertStmt.setDouble(4, draft.getPrice());
                    insertStmt.executeUpdate();
                }

                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, foodDraftId);
                    updateStmt.executeUpdate();
                }

                conn.commit();
                return true;
            } catch (SQLException ex) {
                conn.rollback();
                throw ex;
            }
        } catch (SQLException ex) {
            Logger.getLogger(FoodDraftDAO.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}

/*
VÍ DỤ CÁCH SỬ DỤNG:

// Tạo Map filters
Map<String, String> filters = new HashMap<>();
filters.put("searchKey", "pizza");
filters.put("category", "1");
filters.put("status", "pending");
filters.put("searchPrice", "50.0");
filters.put("priceRank", "10-50");
filters.put("bmiId", "2");
filters.put("authorId", "123");

// Tạo Map sort và pagination
Map<String, String> sortAndPagination = new HashMap<>();
sortAndPagination.put("sortprice", "desc");  // sort theo giá giảm dần
sortAndPagination.put("sorttime", "asc");    // sort theo thời gian tăng dần
sortAndPagination.put("page", "1");          // trang 1
sortAndPagination.put("pageSize", "20");     // 20 items per page

// Gọi phương thức
FoodDraftDAO dao = new FoodDraftDAO();
List<Food_Draft> results = dao.getListFoodDrafts(filters, sortAndPagination);
int total = dao.getListFoodDraftsTotal(filters, sortAndPagination);
*/
