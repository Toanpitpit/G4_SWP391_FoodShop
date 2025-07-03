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

        // Password Validation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match!");
            // Keep other form values
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("gender", gender);
            request.setAttribute("birthDate", birthDateStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        String passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+={}\\[\\]|;:'\",.<>/?-]).{6,}$";
        if (!password.matches(passwordRegex)) {
            request.setAttribute("error", "Password must be at least 6 characters long and include uppercase, lowercase, numbers, and special characters.");
            // Keep other form values
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("gender", gender);
            request.setAttribute("birthDate", birthDateStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Full Name Validation
        if (fullName != null && !fullName.trim().isEmpty()) {
            // Regex to check if fullName contains only letters, spaces, and Vietnamese characters
            String fullNameRegex = "^[a-zA-ZÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵýỷỹ\\s]+$";
            if (!fullName.trim().matches(fullNameRegex)) {
                request.setAttribute("error", "Full Name must contain only letters and spaces. Special characters and numbers are not allowed.");
                // Keep other form values
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("gender", gender);
                request.setAttribute("birthDate", birthDateStr);
                // Keep the invalid fullName so user can see what they entered
                request.setAttribute("fullName", fullName);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            // Check if fullName is not just spaces
            if (fullName.trim().length() < 2) {
                request.setAttribute("error", "Full Name must be at least 2 characters long.");
                // Keep other form values
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("gender", gender);
                request.setAttribute("birthDate", birthDateStr);
                request.setAttribute("fullName", fullName);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "Full Name is required.");
            // Keep other form values
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("gender", gender);
            request.setAttribute("birthDate", birthDateStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        //  Phone Number Validation (Vietnam)
        if (phone != null && !phone.isEmpty()) {
            // Remove any spaces or special characters for validation
            String cleanPhone = phone.replaceAll("[\\s\\-\\(\\)]", "");

            // Check if phone contains only digits
            if (!cleanPhone.matches("\\d+")) {
                request.setAttribute("error", "Phone number must contain only numbers.");
                // Keep other form values
                request.setAttribute("username", username);
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);
                request.setAttribute("gender", gender);
                request.setAttribute("birthDate", birthDateStr);
                request.setAttribute("phone", phone);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Check Vietnam phone number format
            boolean isValidVietnamPhone = false;

            if (cleanPhone.length() == 10) {
                // Mobile numbers (10 digits): 03x, 05x, 07x, 08x, 09x
                if (cleanPhone.matches("^(03[2-9]|05[6|8|9]|07[0|6-9]|08[1-9]|09[0-9])\\d{7}$")) {
                    isValidVietnamPhone = true;
                }
            } else if (cleanPhone.length() == 11) {
                // Landline numbers (11 digits): 02x (area code) + 8 digits
                if (cleanPhone.matches("^02[0-9]\\d{8}$")) {
                    isValidVietnamPhone = true;
                }
            }

            if (!isValidVietnamPhone) {
                request.setAttribute("error", "Phone Number must be in Viet Nam and 11 digits");
                // Keep other form values
                request.setAttribute("username", username);
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);
                request.setAttribute("gender", gender);
                request.setAttribute("birthDate", birthDateStr);
                request.setAttribute("phone", phone);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Store the cleaned phone number (optional - to standardize format)
            phone = cleanPhone;

        } else {
            request.setAttribute("error", "Phone number is required.");
            // Keep other form values
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("gender", gender);
            request.setAttribute("birthDate", birthDateStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        //  End Phone Number Validation 

        // Birth Date Validation
        if (birthDateStr != null && !birthDateStr.isEmpty()) {
            try {
                Date birthDate = Date.valueOf(birthDateStr);
                Date currentDate = new Date(System.currentTimeMillis());

                // Check if birth date is not in the future
                if (birthDate.after(currentDate)) {
                    request.setAttribute("error", "Birth date cannot be in the future.");
                    // Keep other form values
                    request.setAttribute("username", username);
                    request.setAttribute("fullName", fullName);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("gender", gender);
                    request.setAttribute("birthDate", birthDateStr);
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }

                // Calculate age
                long diffInMillies = currentDate.getTime() - birthDate.getTime();
                long diffInDays = diffInMillies / (24 * 60 * 60 * 1000);
                int age = (int) (diffInDays / 365.25); // Using 365.25 to account for leap years

                // Check age range (15-70 years old)
                if (age < 15) {
                    request.setAttribute("error", "You must be at least 15 years old to register.");
                    // Keep other form values
                    request.setAttribute("username", username);
                    request.setAttribute("fullName", fullName);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("gender", gender);
                    request.setAttribute("birthDate", birthDateStr);
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }

                if (age > 70) {
                    request.setAttribute("error", "Age must not exceed 70 years old.");
                    // Keep other form values
                    request.setAttribute("username", username);
                    request.setAttribute("fullName", fullName);
                    request.setAttribute("email", email);
                    request.setAttribute("phone", phone);
                    request.setAttribute("gender", gender);
                    request.setAttribute("birthDate", birthDateStr);
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }

            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Invalid birth date format. Please use YYYY-MM-DD format.");
                // Keep other form values
                request.setAttribute("username", username);
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("gender", gender);
                request.setAttribute("birthDate", birthDateStr);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
        } else {
            request.setAttribute("error", "Birth date is required.");
            // Keep other form values
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("gender", gender);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            // Check if username already exists
            if (userDAO.checkUsernameExists(username)) {
                request.setAttribute("error", "This username already exists! Please choose another username.");
                // Keep other form values except username
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);
                request.setAttribute("phone", phone);
                request.setAttribute("gender", gender);
                request.setAttribute("birthDate", birthDateStr);
                // Keep the invalid username so user can see what they entered
                request.setAttribute("username", username);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Check if email already exists
            if (userDAO.checkEmailExists(email)) {
                request.setAttribute("error", "This email already exists! Please use another email.");
                // Keep other form values except email
                request.setAttribute("username", username);
                request.setAttribute("fullName", fullName);
                request.setAttribute("phone", phone);
                request.setAttribute("gender", gender);
                request.setAttribute("birthDate", birthDateStr);
                // Keep the invalid email so user can see what they entered
                request.setAttribute("email", email);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Create new user
            Account user = new Account();
            user.setUsername(username);
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
            user.setPass(hashedPassword);
            user.setName(fullName.trim()); // Trim whitespace before saving
            user.setEmail(email);
            user.setPhone(phone);
            user.setGender(gender);
            user.setRole("Nutritionist");
            user.setStatus("Active");
            user.setBirthDate(birthDateStr != null && !birthDateStr.isEmpty() ? Date.valueOf(birthDateStr) : null);

            // Register user        
            userDAO.registerUser(user);
            response.sendRedirect("login.jsp?success=Registration successful! Please login to continue.");

        } catch (SQLException e) {
            Logger.getLogger(RegisterController.class.getName()).log(Level.SEVERE, null, e);
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            // Keep all form values when database error occurs
            request.setAttribute("username", username);
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("gender", gender);
            request.setAttribute("birthDate", birthDateStr);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}
