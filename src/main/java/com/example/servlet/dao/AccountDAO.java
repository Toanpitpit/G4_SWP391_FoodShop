package com.example.servlet.dao;

import com.example.servlet.model.Account;
import com.example.servlet.utils.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

public class AccountDAO {

    public void registerUser(Account user) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "INSERT INTO Accounts (username, pass, name, email, phone, gender, birthDate, role, status, image, create_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPass());
            stmt.setString(3, user.getName());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getGender());
            stmt.setDate(7, user.getBirthDate());
            stmt.setString(8, user.getRole());
            stmt.setString(9, user.getStatus());
            stmt.setString(10, user.getImage());
            stmt.executeUpdate();
        } finally {
            dbConnect.closeConnection();
        }
    }

    public Account loginUser(String email, String password) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "SELECT * FROM Accounts WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String hashedPassword = rs.getString("pass");  
                if (BCrypt.checkpw(password, hashedPassword) ) {
                    return new Account(
                            rs.getInt("id"),
                            rs.getString("username"),
                            hashedPassword,
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("gender"),
                            rs.getDate("birthDate"),
                            rs.getString("role"),
                            rs.getString("status"),
                            rs.getString("image"),
                            rs.getTimestamp("create_at")
                    );
                }
            }
            return null;
        } finally {
            dbConnect.closeConnection();
        }
    }

    public boolean checkEmailExists(String email) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "SELECT email FROM Accounts WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } finally {
            dbConnect.closeConnection();
        }
    }

    public void updatePassword(String email, String newPass) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "UPDATE Accounts SET pass = ? WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPass);
            stmt.setString(2, email);
            stmt.executeUpdate();
        } finally {
            dbConnect.closeConnection();
        }
    }

    public void updateUser(Account user) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "UPDATE Accounts SET name = ?, email = ?, phone = ?, gender = ?, birthDate = ?, role = ?, status = ?, image = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getGender());
            stmt.setDate(5, user.getBirthDate());
            stmt.setString(6, user.getRole());
            stmt.setString(7, user.getStatus());
            stmt.setString(8, user.getImage());
            stmt.setInt(9, user.getId());
            stmt.executeUpdate();
        } finally {
            dbConnect.closeConnection();
        }
    }

    public Account findByEmail(String email) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "SELECT * FROM Accounts WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Account(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("pass"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("gender"),
                        rs.getDate("birthDate"),
                        rs.getString("role"),
                        rs.getString("status"),
                        rs.getString("image"),
                        rs.getTimestamp("create_at")
                );
            }
            return null;
        } finally {
            dbConnect.closeConnection();
        }
    }
    
    public List<Account> getAllAccounts() {
        List<Account> accounts = new ArrayList<>();
        String query = "SELECT * FROM Accounts";
        DBConnect dbConnect = new DBConnect();
        try (Connection conn = dbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Account user = new Account(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("pass"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("gender"),
                    rs.getDate("birthDate"),
                    rs.getString("role"),
                    rs.getString("status"),
                    rs.getString("image"),
                    rs.getTimestamp("create_at")
                );
                accounts.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbConnect.closeConnection();
        }
        return accounts;
    }


public boolean addAccount(Account account) {
    String query = "INSERT INTO Accounts (username, pass, name, email, phone, gender, birthDate, role, status, image, create_at) " +
                   "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
    DBConnect dbConnect = new DBConnect();
    try (Connection conn = dbConnect.getConnection();
         PreparedStatement ps = conn.prepareStatement(query)) {

        String hashedPassword = BCrypt.hashpw(account.getPass(), BCrypt.gensalt());
        ps.setString(1, account.getUsername());
        ps.setString(2, hashedPassword);
        ps.setString(3, account.getName());
        ps.setString(4, account.getEmail());
        ps.setString(5, account.getPhone());
        ps.setString(6, account.getGender());
        ps.setDate(7, account.getBirthDate());
        ps.setString(8, account.getRole());
        ps.setString(9, account.getStatus());
        ps.setString(10, account.getImage());

        int rowsInserted = ps.executeUpdate();
        return rowsInserted > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    } finally {
        dbConnect.closeConnection();
    }
}


    public void updateAccount(Account account) {
        String query;
        PreparedStatement ps;
        DBConnect dbConnect = new DBConnect();
        try (Connection conn = dbConnect.getConnection()) {
            Account existingUser = getAccountById(account.getId());
            if (existingUser == null) {
                throw new SQLException("User not found with ID: " + account.getId());
            }

            String passwordToSet = account.getPass() != null && !account.getPass().isEmpty() 
                ? BCrypt.hashpw(account.getPass(), BCrypt.gensalt()) 
                : existingUser.getPass();

            query = "UPDATE Accounts SET username = ?, pass = ?, name = ?, email = ?, phone = ?, gender = ?, birthDate = ?, role = ?, status = ?, image = ? WHERE id = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, account.getUsername());
            ps.setString(2, passwordToSet);
            ps.setString(3, account.getName());
            ps.setString(4, account.getEmail());
            ps.setString(5, account.getPhone());
            ps.setString(6, account.getGender());
            ps.setDate(7, account.getBirthDate());
            ps.setString(8, account.getRole());
            ps.setString(9, account.getStatus());
            ps.setString(10, account.getImage());
            ps.setInt(11, account.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbConnect.closeConnection();
        }
    }

    public void deleteAccount(int id) {
        String query = "DELETE FROM Accounts WHERE id = ?";
        DBConnect dbConnect = new DBConnect();
        try (Connection conn = dbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbConnect.closeConnection();
        }
    }

    public Account getAccountById(int id) {
        String query = "SELECT * FROM Accounts WHERE id = ?";
        DBConnect dbConnect = new DBConnect();
        try (Connection conn = dbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("pass"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("gender"),
                    rs.getDate("birthDate"),
                    rs.getString("role"),
                    rs.getString("status"),
                    rs.getString("image"),
                    rs.getTimestamp("create_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbConnect.closeConnection();
        }
        return null;
    }

    public Account getAccountByUsername(String username) {
        String query = "SELECT * FROM Accounts WHERE username = ?";
        DBConnect dbConnect = new DBConnect();
        try (Connection conn = dbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Account(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("pass"),
                    rs.getString("name"),
                    rs.getString("email"),
                    rs.getString("phone"),
                    rs.getString("gender"),
                    rs.getDate("birthDate"),
                    rs.getString("role"),
                    rs.getString("status"),
                    rs.getString("image"),
                    rs.getTimestamp("create_at")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            dbConnect.closeConnection();
        }
        return null;
    }

    public boolean checkUsernameExists(String username) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "SELECT username FROM Accounts WHERE username = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username.trim());
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } finally {
            dbConnect.closeConnection();
        }
    }
    
    public Account findById(int id) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "SELECT * FROM Accounts WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Account(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("pass"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("gender"),
                        rs.getDate("birthDate"),
                        rs.getString("role"),
                        rs.getString("status"),
                        rs.getString("image"),
                        rs.getTimestamp("create_at")
                );
            }
            return null;
        } finally {
            dbConnect.closeConnection();
        }
    }

    public List<Account> getAllAccounts(String search, String role, String status) throws SQLException {
        List<Account> accounts = new ArrayList<>();
        String query = "SELECT * FROM Accounts WHERE 1=1";
        if (search != null && !search.trim().isEmpty()) {
            search = search.trim().replaceAll("\\s+", " ");
            query += " AND (name LIKE ? OR email LIKE ?)";
        }
        if (role != null && !role.isEmpty()) {
            query += " AND role = ?";
        }
        if (status != null && !status.isEmpty()) {
            query += " AND status = ?";
        }
        DBConnect dbConnect = new DBConnect();
        try (Connection conn = dbConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            int paramIndex = 1;
            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
                ps.setString(paramIndex++, "%" + search + "%");
            }
            if (role != null && !role.isEmpty()) {
                ps.setString(paramIndex++, role);
            }
            if (status != null && !status.isEmpty()) {
                ps.setString(paramIndex++, status);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                accounts.add(new Account(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("pass"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("gender"),
                        rs.getDate("birthDate"),
                        rs.getString("role"),
                        rs.getString("status"),
                        rs.getString("image"),
                        rs.getTimestamp("create_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            dbConnect.closeConnection();
        }
        return accounts;
    }

    public void updateUserStatus(int id, String status) throws SQLException {
        DBConnect dbConnect = new DBConnect();
        Connection conn = dbConnect.getConnection();
        try {
            String sql = "UPDATE Accounts SET status = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, id);
            stmt.executeUpdate();
        } finally {
            dbConnect.closeConnection();
        }
    }

    // Validate số điện thoại (10 chữ số, bắt đầu bằng 03x, 05x, 07x, 08x, 09x)
    public boolean isValidPhoneNumber(String phone) {
        if (phone == null) {
            return false;
        }
        String cleanedPhone = phone.replaceAll("[^0-9]", "");
        if (cleanedPhone.length() != 10) {
            return false;
        }
        String validPrefixes = "^(03[2-9]|05[6-9]|07[0|6-9]|08[1-9]|09[0-4|6-9])[0-9]{7}$";
        return cleanedPhone.matches(validPrefixes);
    }

    // Validate ngày sinh (trước ngày hiện tại, tuổi >= 15, tuổi <= 100)
    public boolean validateBirthDate(Date birthDate) {
        if (birthDate == null) {
            return false;
        }
        java.util.Date today = new java.util.Date();
        Calendar todayCal = Calendar.getInstance();
        todayCal.setTime(today);
        todayCal.set(Calendar.HOUR_OF_DAY, 0);
        todayCal.set(Calendar.MINUTE, 0);
        todayCal.set(Calendar.SECOND, 0);
        todayCal.set(Calendar.MILLISECOND, 0);

        if (!birthDate.before(new java.sql.Date(todayCal.getTimeInMillis()))) {
            return false; // Ngày sinh phải trước ngày hiện tại
        }

        Calendar birthCal = Calendar.getInstance();
        birthCal.setTime(birthDate);
        int age = todayCal.get(Calendar.YEAR) - birthCal.get(Calendar.YEAR);
        if (todayCal.get(Calendar.DAY_OF_YEAR) < birthCal.get(Calendar.DAY_OF_YEAR)) {
            age--;
        }
        return age >= 15 && age <= 65; // Tuổi từ 15 đến 65
    }
}