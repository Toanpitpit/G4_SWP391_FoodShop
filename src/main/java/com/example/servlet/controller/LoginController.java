package com.example.servlet.controller;



import com.example.servlet.dao.AccountDAO;
import com.example.servlet.model.Account;
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
    private AccountDAO userDAO;

    @Override
    public void init() {
        userDAO = new AccountDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Account user = userDAO.loginUser(username, password);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                if(user.getRole ().equals ("Nutritionist") && user.getStatus ().equals ("Active")){
                    response.sendRedirect("/dashboadnutri");
                }
//                response.sendRedirect("profile.jsp");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
