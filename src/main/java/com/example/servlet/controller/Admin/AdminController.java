package com.example.servlet.controller.Admin;

import com.example.servlet.dao.AccountDAO;
import com.example.servlet.model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/adminDashboard")
public class AdminController extends HttpServlet {

    private AccountDAO accountDAO;

    @Override
    public void init() {
        accountDAO = new AccountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("account") : null;
        if (session == null || account == null || !"Admin".equalsIgnoreCase(account.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String search = request.getParameter("search");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        if ("detail".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Account detailAccount = null;
            try {
                detailAccount = accountDAO.findById(id);
            } catch (SQLException ex) {
                Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, "Error fetching account details", ex);
            }
            if (detailAccount != null) {
                request.setAttribute("account", detailAccount);
                request.getRequestDispatcher("/accountDetail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/adminDashboard?error=AccountNotFound");
            }
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Account user = null;
            try {
                user = accountDAO.findById(id); 
            } catch (SQLException ex) {
                Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, null, ex);
            }
            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/editAccount.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/adminDashboard?error=AccountNotFound");
            }
        } else if ("activate".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                accountDAO.updateUserStatus(id, "Active");
            } catch (SQLException ex) {
                Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, "Error activating account", ex);
            }
            response.sendRedirect(request.getContextPath() + "/adminDashboard");
        } else if ("deactivate".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            try {
                accountDAO.updateUserStatus(id, "Inactive");
            } catch (SQLException ex) {
                Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, "Error deactivating account", ex);
            }
            response.sendRedirect(request.getContextPath() + "/adminDashboard");
        } else {
            try {
                List<Account> accounts = accountDAO.getAllAccounts(search, role, status);
                request.setAttribute("accounts", accounts);
                request.setAttribute("search", search);
                request.setAttribute("role", role);
                request.setAttribute("status", status);
                request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
            } catch (SQLException e) {
                Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, "Error fetching accounts", e);
                response.sendRedirect(request.getContextPath() + "/adminDashboard?error=DatabaseError");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Account account = (session != null) ? (Account) session.getAttribute("account") : null;
        if (session == null || account == null || !"Admin".equalsIgnoreCase(account.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            try {
                String username = request.getParameter("username").trim();
                String password = request.getParameter("pass");
                String name = request.getParameter("name");
                String email = request.getParameter("email").trim();
                String phone = request.getParameter("phone");
                String gender = request.getParameter("gender");
                Date birthDate = new Date(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("birthDate")).getTime());
                String role = request.getParameter("role");
                String status = "Active";
                String image = request.getParameter("image");

                if (accountDAO.checkUsernameExists(username)) {
                    request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                    request.getRequestDispatcher("/addAccount.jsp").forward(request, response);
                    return;
                }
                if (accountDAO.checkEmailExists(email)) {
                    request.setAttribute("error", "Email đã tồn tại!");
                    request.getRequestDispatcher("/addAccount.jsp").forward(request, response);
                    return;
                }
                if (!accountDAO.isValidPassword(password)) {
                    request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa và ký tự đặc biệt!");
                    request.getRequestDispatcher("/addAccount.jsp").forward(request, response);
                    return;
                }
                if (!accountDAO.validateBirthDate(birthDate)) {
                    request.setAttribute("error", "Ngày sinh phải trước ngày hiện tại!");
                    request.getRequestDispatcher("/addAccount.jsp").forward(request, response);
                    return;
                }

                Account newAccount = new Account(0, username, password, name, email, phone, gender, birthDate, role, status, image, null);
                accountDAO.registerUser(newAccount);
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
            } catch (Exception e) {
                Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, "Error adding account", e);
                response.sendRedirect(request.getContextPath() + "/adminDashboard?error=AddFailed");
            }
        } else if ("update".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String username = request.getParameter("username").trim();
                String password = request.getParameter("pass");
                String name = request.getParameter("name");
                String email = request.getParameter("email").trim();
                String phone = request.getParameter("phone");
                String gender = request.getParameter("gender");
                Date birthDate = new Date(new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("birthDate")).getTime());
                String role = request.getParameter("role");
                String status = request.getParameter("status");
                String image = request.getParameter("image");

                Account existingAccount = accountDAO.findById(id);
                if (existingAccount == null) {
                    throw new SQLException("Tài khoản không tồn tại!");
                }

                if (!existingAccount.getEmail().equalsIgnoreCase(email) && accountDAO.checkEmailExists(email)) {
                    request.setAttribute("error", "Email đã tồn tại!");
                    request.getRequestDispatcher("/editAccount.jsp").forward(request, response);
                    return;
                }

                if (!accountDAO.validateBirthDate(birthDate)) {
                    request.setAttribute("error", "Ngày sinh phải trước ngày hiện tại!");
                    request.getRequestDispatcher("/editAccount.jsp").forward(request, response);
                    return;
                }

                String passwordToSet = (password != null && !password.isEmpty())
                        ? BCrypt.hashpw(password, BCrypt.gensalt())
                        : existingAccount.getPass();

                Account updatedAccount = new Account(id, username, passwordToSet, name, email, phone, gender, birthDate, role, status, image, null);
                accountDAO.updateUser(updatedAccount);
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
            } catch (Exception e) {
                Logger.getLogger(AdminController.class.getName()).log(Level.SEVERE, "Error updating account", e);
                response.sendRedirect(request.getContextPath() + "/adminDashboard?error=UpdateFailed");
            }
        }
    }
}


