package com.example.servlet.dao;

import com.example.servlet.model.Food;
import com.example.servlet.utils.DBConnect;
import java.sql.*;
import java.util.*;

public class FoodDAO {

    // Base query với DISTINCT để tránh duplicate rows
    private static final String BASE_QUERY =
        "SELECT DISTINCT f.pID, f.pName, c.caName, " +
        "(SELECT TOP 1 b.classification FROM FoodBMIRecommendation fbr2 " +
        " LEFT JOIN bmi_classification b ON fbr2.bmiID = b.type_id " +
        " WHERE fbr2.pID = f.pID) AS bmi_type, " +
        "f.p_image, f.price, f.status, f.create_at, f.update_at " +
        "FROM Foods f " +
        "INNER JOIN Category c ON f.catID = c.catID " +
        "WHERE 1=1 ";

    public List<Food> getListFoods(String searchKey, String category, String status, String searchPrice, String priceRank, String bmiId,
            Map<String, String> sortFields,
            int page, int pageSize) throws SQLException {

        QueryBuilder queryBuilder = new QueryBuilder(BASE_QUERY)
                .addFilter("name", searchKey)           // searchKey từ form
                .addFilter("category", category)
                .addFilter("status", status)
                .addFilter("searchPrice", searchPrice)   // giá max đơn giản
                .addFilter("priceRank", priceRank)      // range giá từ dropdown
                .addFilter("bmiID", bmiId)
                .addSorting(sortFields)
                .addPagination(page, pageSize);

        return executeQuery(queryBuilder);
    }

    public int getListFoodsTotal(String searchKey, String category, String status, String searchPrice, String priceRank, String bmiId,
            Map<String, String> sortFields) throws SQLException {

        QueryBuilder queryBuilder = new QueryBuilder(BASE_QUERY)
                .addFilter("name", searchKey)
                .addFilter("category", category)
                .addFilter("status", status)
                .addFilter("searchPrice", searchPrice)
                .addFilter("priceRank", priceRank)
                .addFilter("bmiID", bmiId)
                .addSorting(sortFields);
        return executeQuery(queryBuilder).size();
    }

    private List<Food> executeQuery(QueryBuilder queryBuilder) throws SQLException {
        List<Food> foodList = new ArrayList<>();
        DBConnect db = new DBConnect();
        System.out.println("Generated SQL: " + queryBuilder.getSql());
        System.out.println("With parameters: " + queryBuilder.parameters);
        
        try (Connection conn = db.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(queryBuilder.getSql())) {

            queryBuilder.setParameters(ps);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    foodList.add(mapResultSetToFood(rs));
                }
            }
        }

        return foodList;
    }

    private Food mapResultSetToFood(ResultSet rs) throws SQLException {
        Food food = new Food();
        food.setFoodId(rs.getInt("pID"));
        food.setFoodname(rs.getString("pName"));
        food.setCategory(rs.getString("caName"));
        food.setBmi_type(rs.getString("bmi_type"));
        food.setImage(rs.getString("p_image"));
        food.setPrice(rs.getDouble("price"));
        food.setStatus(rs.getString("status"));
        food.setCreate_at(rs.getTimestamp("create_at"));
        food.setUpdate_at(rs.getTimestamp("update_at"));
        return food;
    }

    private static class QueryBuilder {

        private final StringBuilder sql;
        private List<Object> parameters;

        public QueryBuilder(String baseQuery) {
            this.sql = new StringBuilder(baseQuery);
            this.parameters = new ArrayList<>();
        }

        public QueryBuilder addFilter(String type, String value) {
            if (value != null && !value.trim().isEmpty()) {
                switch (type) {
                    case "name":
                        sql.append("AND f.pName LIKE ? ");
                        parameters.add("%" + value.trim() + "%");
                        break;
                    case "category":
                        try {
                            int categoryId = Integer.parseInt(value.trim());
                            sql.append("AND f.catID = ? ");
                            parameters.add(categoryId);
                        } catch (NumberFormatException e) {
                            System.err.println("Invalid category ID: " + value);
                        }
                        break;
                    case "status":
                        sql.append("AND f.status = ? ");
                        parameters.add(value.trim());
                        break;
                    case "searchPrice":
                        // Giá tối đa đơn giản từ input number
                        try {
                            double maxPrice = Double.parseDouble(value.trim());
                            sql.append("AND f.price <= ? ");
                            parameters.add(maxPrice);
                        } catch (NumberFormatException e) {
                            System.err.println("Invalid search price value: " + value);
                        }
                        break;
                    case "priceRank":
                        // Range giá từ dropdown
                        addPriceRangeFilter(value.trim());
                        break;
                    case "bmiID":
                        addBMIFilter(value.trim());
                        break;
                    default:
                        break;
                }
            }
            return this;
        }

        private void addPriceRangeFilter(String value) {
            try {
                if (value.contains("-")) {
                    String[] parts = value.split("-");
                    double min = Double.parseDouble(parts[0]);
                    double max = Double.parseDouble(parts[1]);
                    sql.append("AND f.price BETWEEN ? AND ? ");
                    parameters.add(min);
                    parameters.add(max);
                } else if (value.endsWith("+")) {
                    double min = Double.parseDouble(value.replace("+", ""));
                    sql.append("AND f.price > ? ");
                    parameters.add(min);
                } else {
                    double max = Double.parseDouble(value);
                    sql.append("AND f.price <= ? ");
                    parameters.add(max);
                }
            } catch (NumberFormatException e) {
                System.err.println("Invalid price range filter value: " + value);
            }
        }

        private void addBMIFilter(String value) {
            // Không cần thêm JOIN vì sẽ dùng EXISTS
            try {
                int bmiId = Integer.parseInt(value);
                sql.append("AND EXISTS (SELECT 1 FROM FoodBMIRecommendation fbr WHERE fbr.pID = f.pID AND fbr.bmiID = ?) ");
                parameters.add(bmiId);
            } catch (NumberFormatException e) {
                System.err.println("Invalid BMI ID: " + value);
            }
        }

        public QueryBuilder addSorting(Map<String, String> sortFields) {
            if (sortFields != null && !sortFields.isEmpty()) {
                List<String> sortExpressions = new ArrayList<>();

                for (Map.Entry<String, String> entry : sortFields.entrySet()) {
                    String dbField = mapSortField(entry.getKey());
                    if (dbField != null) {
                        String direction = entry.getValue().equalsIgnoreCase("desc") ? "DESC" : "ASC";
                        sortExpressions.add(dbField + " " + direction);
                    }
                }

                if (!sortExpressions.isEmpty()) {
                    sql.append("ORDER BY ").append(String.join(", ", sortExpressions));
                    // Always add primary key as secondary sort for consistency
                    if (!sortExpressions.toString().contains("f.pID")) {
                        sql.append(", f.pID ASC ");
                    }
                    sql.append(" ");
                }
            }

            return this;
        }

        public QueryBuilder addPagination(int page, int pageSize) {
            if (!sql.toString().toLowerCase().contains("order by")) {
                sql.append("ORDER BY f.pID ASC ");
            }
            sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
            parameters.add((page - 1) * pageSize);
            parameters.add(pageSize);
            return this;
        }

        private String mapSortField(String field) {
            switch (field) {
                case "id":
                case "sortID":
                    return "f.pID";
                case "name":
                    return "f.pName";
                case "price":
                case "sortPrice":
                    return "f.price";
                case "create_at":
                    return "f.create_at";
                case "update_at":
                case "sortTime":
                    return "f.update_at";
                case "category":
                    return "c.caName";
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
}
