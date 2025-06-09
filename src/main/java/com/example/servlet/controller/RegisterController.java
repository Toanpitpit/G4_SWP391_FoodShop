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
        userDAO = new AccountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String birthDateStr = request.getParameter("birthDate");
        request.setAttribute ("phone", phone);
        request.setAttribute ("username", username);
        request.setAttribute ("fullName", fullName);
        request.setAttribute ("email", email);
   
        
        
        
        
        // Password Validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+={}\\[\\]|;:'\",.<>/?-]).{6,}$";
        if (!password.matches(passwordRegex)) {
            request.setAttribute("error", "Password must be at least 6 characters long and include uppercase, lowercase, numbers, and special characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        
        

        // --- Phone Number Validation ---
        if (phone != null && !phone.isEmpty()) {
            if (!phone.matches("\\d{10,11}")) { // Checks for 10 or 11 digits
                request.setAttribute("error", "Phone number must be 10 or 11 digits long and contain only numbers.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
        } else {
             // Optional: If phone number is mandatory, you can add this check
             // request.setAttribute("error", "Phone number is required.");
             // request.getRequestDispatcher("register.jsp").forward(request, response);
             // return;
        }
        // --- End Phone Number Validation ---

        try {
            // Check if username already exists
            if (userDAO.checkUsernameExists(username)) {
                request.setAttribute("error", "This username already exists! Please choose another username.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Check if email already exists
            if (userDAO.checkEmailExists(email)) {
                request.setAttribute("error", "This email already exists! Please use another email.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Create new user
            Account user = new Account();
            user.setUsername(username);
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            user.setPass(hashedPassword);
            user.setName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
            user.setGender(gender);
            user.setRole("Nutritionist");
            user.setStatus ("Active");
            user.setBirthDate(birthDateStr != null && !birthDateStr.isEmpty() ? Date.valueOf(birthDateStr) : null);

            // Register user
            userDAO.registerUser(user);
            response.sendRedirect("login.jsp?success=Registration successful! Please login to continue.");

        } catch (SQLException e) {
            Logger.getLogger(RegisterController.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
