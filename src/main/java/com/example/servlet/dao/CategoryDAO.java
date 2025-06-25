package com.example.servlet.dao;

import com.example.servlet.model.Category;
import com.example.servlet.utils.DBConnect;

import java.sql.*;
import java.util.*;

public class CategoryDAO {

    private static final String BASE_QUERY =
        "SELECT c.catID, c.caName, c.description, c.create_at, c.update_at FROM Category c WHERE 1=1 ";

    public List<Category> getListCategories(String name, String description,
            Map<String, String> sortFields, int page, int pageSize) throws SQLException {

        QueryBuilder queryBuilder = new QueryBuilder(BASE_QUERY)
                .addFilter("name", name)
                .addFilter("description", description)
                .addSorting(sortFields)
                .addPagination(page, pageSize);

        return executeQuery(queryBuilder);
    }

    public int getListCategoriesTotal(String name, String description,
            Map<String, String> sortFields) throws SQLException {

        QueryBuilder queryBuilder = new QueryBuilder(BASE_QUERY)
                .addFilter("name", name)
                .addFilter("description", description)
                .addSorting(sortFields);

        return executeQuery(queryBuilder).size();
    }

    public List<Category> getListCategoriesNoP(String name, String description,
            Map<String, String> sortFields) throws SQLException {

        QueryBuilder queryBuilder = new QueryBuilder(BASE_QUERY)
                .addFilter("name", name)
                .addFilter("description", description)
                .addSorting(sortFields);

        return executeQuery(queryBuilder);
    }

    private List<Category> executeQuery(QueryBuilder queryBuilder) throws SQLException {
        List<Category> categoryList = new ArrayList<>();
        DBConnect db = new DBConnect();

        System.out.println("Generated SQL: " + queryBuilder.getSql());
        System.out.println("With parameters: " + queryBuilder.parameters);

        try (Connection conn = db.getConnection();
             PreparedStatement ps = conn.prepareStatement(queryBuilder.getSql())) {

            queryBuilder.setParameters(ps);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    categoryList.add(mapResultSetToCategory(rs));
                }
            }
        }

        return categoryList;
    }

    private Category mapResultSetToCategory(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setCatID(rs.getInt("catID"));
        category.setCaName(rs.getString("caName"));
        category.setDecription(rs.getString("description"));
        category.setCreate_at(rs.getTimestamp("create_at"));
        category.setUpdate_at(rs.getTimestamp("update_at"));
        return category;
    }

    private static class QueryBuilder {
        private final StringBuilder sql;
        private final List<Object> parameters;

        public QueryBuilder(String baseQuery) {
            this.sql = new StringBuilder(baseQuery);
            this.parameters = new ArrayList<>();
        }

        public QueryBuilder addFilter(String type, String value) {
            if (value != null && !value.trim().isEmpty()) {
                switch (type) {
                    case "name":
                        sql.append("AND c.caName LIKE ? ");
                        parameters.add("%" + value.trim() + "%");
                        break;
                    case "description":
                        sql.append("AND c.description LIKE ? ");
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
                sql.append("ORDER BY c.catID ");
            }
            sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
            parameters.add((page - 1) * pageSize);
            parameters.add(pageSize);
            return this;
        }

        private String mapSortField(String field) {
            switch (field) {
                case "id": return "c.catID";
                case "name": return "c.caName";
                case "description": return "c.description";
                case "create_at": return "c.create_at";
                case "update_at": return "c.update_at";
                default: return null;
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
