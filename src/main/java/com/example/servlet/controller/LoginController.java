package com.example.servlet.controller;



import com.example.servlet.dao.AccountDAO;
import com.example.servlet.dao.UserDAO;
import com.example.servlet.model.Account;
import com.example.servlet.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;



@WebServlet("/login")
public class LoginController extends HttpServlet {
    private UserDAO userDAO;
    private AccountDAO accountDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
        accountDAO = new AccountDAO();
    }

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//
//        try {
//            User user = userDAO.loginUser(username, password);
//            if (user != null) {
//                HttpSession session = request.getSession();
//                session.setAttribute("user", user);
//                response.sendRedirect("profile.jsp");
//            } else {
//                request.setAttribute("error", "Invalid username or password");
//                request.getRequestDispatcher("login.jsp").forward(request, response);
//            }
//        } catch (SQLException e) {
//            request.setAttribute("error", "Login failed: " + e.getMessage());
//            request.getRequestDispatcher("login.jsp").forward(request, response);
//        }
//    }
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    try {
        Account account = accountDAO.loginUser(username, password);
        if (account != null) {
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
            // Ktra role roi dieu huong
            if ("Admin".equalsIgnoreCase(account.getRole())) {
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
            } else {
                response.sendRedirect("profile.jsp");
            }
        } else {
            request.setAttribute("error", "Username or password invalid!!!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    } catch (SQLException e) {
        request.setAttribute("error", "Login fail: " + e.getMessage());
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
}
