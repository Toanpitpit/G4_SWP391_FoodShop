/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.servlet.dao;

import com.example.servlet.model.FoodDraftDTO;
import com.example.servlet.model.Food_Draft;
import com.example.servlet.utils.DBConnect;
import com.google.common.util.concurrent.ExecutionError;
import java.math.BigDecimal;
import java.sql.CallableStatement;
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
                       
                        try {
                        double maxPrice = Double.parseDouble (value.trim ());
                        sql.append ("AND fd.price <= ? ");
                        parameters.add (maxPrice);
                    } catch (NumberFormatException e) {
                        System.err.println ("Invalid search price value: " + value);
                    }
                    break;
                    case "priceRank":
                       
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

    public Food_Draft getFoodDraftById(int foodDraftId,int authodID) {
        String sql = BASE_QUERY + " AND fd.pdrID = ?";

        try (Connection conn = new DBConnect ().getConnection (); PreparedStatement stmt = conn.prepareStatement (sql)) {

            stmt.setInt (1, foodDraftId);

            try (ResultSet rs = stmt.executeQuery ()) {
                if (rs.next ()) {
                    Food_Draft food =  mapResultSetToFoodDraft (rs);
                    if(food.getAuthorID () != authodID ){
                        return null;
                    }else {
                        return food;
                    }
                }
            }
            
        } catch (SQLException ex) {
            Logger.getLogger (FoodDraftDAO.class.getName ()).log (Level.SEVERE, null, ex);
        }

        return null;
    }
    public boolean deleteFoodDraft(int pdrID) {
        String sql = "EXEC DeleteFoodDraft ?";
        
        try (Connection conn = new DBConnect ().getConnection ();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, pdrID);
            ps.executeUpdate();
            return true;
            
        } catch (SQLException e) {
            System.err.println("Error deleting Food Draft: " + e.getMessage());
            return false;
        }
    }

    public List<Food_Draft> getFoodDraftsByAuthor(int authorId, int page, int pageSize) throws SQLException {
        QueryBuilder queryBuilder = new QueryBuilder (BASE_QUERY)
                .addFilter ("authorID", String.valueOf(authorId))
                .addPagination (page, pageSize);
        return executeQuery (queryBuilder);
    }
    public List<Food_Draft> getTotalFoodDraftsByAuthor(int authorId) throws SQLException {
        QueryBuilder queryBuilder = new QueryBuilder (BASE_QUERY)
                .addFilter ("authorID", String.valueOf(authorId));
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

    
    public int copyFoodToDraft(int originalFoodID, int authorID) {
        String sql = "{CALL CopyFoodToDraft(?, ?)}";

        try (CallableStatement cs = new DBConnect ().getConnection ().prepareCall (sql)) {

            cs.setInt (1, originalFoodID);
            cs.setInt (2, authorID);
            try (ResultSet rs = cs.executeQuery ()) {
                if (rs.next ()) {
                    return rs.getInt ("NewDraftID");
                }
            }
            catch (ExecutionError e){
                  e.printStackTrace ();
            }
        } catch (SQLException e) {
            System.err.println ("Error copying food to draft: " + e.getMessage ());
            e.printStackTrace ();
        }
        return -1;
    }


public boolean createFoodDraft(FoodDraftDTO dto) {
    String sql = "{call CreateFoodDraft(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
    try (Connection conn = new DBConnect().getConnection();
         CallableStatement stmt = conn.prepareCall(sql)) {
        stmt.setNString(1, dto.getName());
        stmt.setInt(2, dto.getCategoryId());
        stmt.setString(3, dto.getImagePath());
        stmt.setDouble(4, dto.getPrice());
        stmt.setString(5, dto.getStatus());
        stmt.setInt(6, dto.getAuthorId());

        if (dto.getOriginId() != null && dto.getOriginId() > 0) {
            stmt.setInt(7, dto.getOriginId());
        } else {
            stmt.setNull(7, java.sql.Types.INTEGER);
        }
        stmt.setNString(8, dto.getDescription());
        stmt.setNString(9, dto.getIngredients());
        stmt.setNString(10, dto.getBmiIds());
        
        boolean hasResult = stmt.execute();
        while (hasResult) {
            try (ResultSet rs = stmt.getResultSet()) {
                if (rs.next()) {
                    return rs.getInt("Success") == 1;
                }
            }
            hasResult = stmt.getMoreResults();
        }
        
    } catch (SQLException e) {
        System.err.println("SQL Exception in createFoodDraft: " + e.getMessage());
        e.printStackTrace();
        return false;
    } catch (Exception e) {
        System.err.println("Unexpected error in createFoodDraft: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
    
    return false;
}
public boolean updateFoodDraft(int draftID, FoodDraftDTO dto) {
    String sql = "{call UpdateFoodDraft(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
    try (Connection conn = new DBConnect().getConnection();
         CallableStatement stmt = conn.prepareCall(sql)) {
        stmt.setInt(1, draftID);
        stmt.setNString(2, dto.getName());
        stmt.setInt(3, dto.getCategoryId());
        stmt.setString(4, dto.getImagePath());
        stmt.setDouble(5, dto.getPrice());
        stmt.setString(6, dto.getStatus());
        stmt.setInt(7, dto.getAuthorId());
        if (dto.getOriginId() != null && dto.getOriginId() > 0) {
            stmt.setInt(8, dto.getOriginId());
        } else {
            stmt.setNull(8, java.sql.Types.INTEGER);
        }
        stmt.setNString(9, dto.getDescription());
        stmt.setNString(10, dto.getIngredients());
        stmt.setNString(11, dto.getBmiIds());
        
        boolean hasResult = stmt.execute();
        while (hasResult) {
            try (ResultSet rs = stmt.getResultSet()) {
                if (rs.next()) {
                    return rs.getInt("Success") == 1;
                }
            }
            hasResult = stmt.getMoreResults();
        }
        
    } catch (SQLException e) {
        System.err.println("SQL Exception in updateFoodDraft: " + e.getMessage());
        e.printStackTrace();
        return false;
    } catch (Exception e) {
        System.err.println("Unexpected error in updateFoodDraft: " + e.getMessage());
        e.printStackTrace();
        return false;
    }
    
    return false;
}
}

