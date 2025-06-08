package com.example.servlet.controller;

import com.example.servlet.dao.AccountDAO;
import com.example.servlet.model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    private AccountDAO userDAO;

    @Override
    public void init() {
        userDAO = new AccountDAO ();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher ("register.jsp").forward (request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter ("username");
        String password = request.getParameter ("password");
        String confirmPassword = request.getParameter ("confirmPassword");
        String fullName = request.getParameter ("fullName");
        String email = request.getParameter ("email");
        String phone = request.getParameter ("phone");
        String gender = request.getParameter ("gender");
        String birthDateStr = request.getParameter ("birthDate");
        request.setAttribute ("username", username);
        request.setAttribute ("email", email);
        request.setAttribute ("phone", phone);
        request.setAttribute ("gender", gender);
        request.setAttribute ("fullName", fullName);
        Date bod =Date.valueOf (birthDateStr);
        request.setAttribute ("birthDateStr", bod);
        if (!password.equals (confirmPassword)) {
            request.setAttribute ("error", "Passwords do not match!");
            request.getRequestDispatcher ("register.jsp").forward (request, response);
            return;
        }
        try {
            if (userDAO.checkEmailExists (email)) {
                request.setAttribute ("error", "This email existed!");
                request.getRequestDispatcher ("register.jsp").forward (request, response);
            }
        } catch (SQLException ex) {
        }
        Account user = new Account ();
        user.setUsername (username);
        String hashedPassword = BCrypt.hashpw (password, BCrypt.gensalt ());
        user.setPass (hashedPassword);
        user.setName (fullName);
        user.setEmail (email);
        user.setPhone (phone);
        user.setGender (gender);
        /*Customer*/
        user.setRole ("Saler");
        user.setStatus ("Active");
        user.setBirthDate (birthDateStr != null && !birthDateStr.isEmpty () ? Date.valueOf (birthDateStr) : null);

        try {
            userDAO.registerUser (user);
            response.sendRedirect ("login.jsp?success=Registration successful");
        } catch (SQLException e) {
            request.setAttribute ("error", "Registration failed: " + e.getMessage ());
            request.getRequestDispatcher ("register.jsp").forward (request, response);
        }
    }
}
