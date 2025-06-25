package com.example.servlet.controller;

import com.example.servlet.dao.AccountDAO;
import com.example.servlet.model.Account;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/changePassword")
public class ChangePasswordController extends HttpServlet {

    private AccountDAO userDAO;

    @Override
    public void init() {
        userDAO = new AccountDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            // Validate old password
            Account loggedInUser = userDAO.loginUser(user.getUsername(), oldPassword);
            if (loggedInUser == null) {
                request.setAttribute("error", "Incorrect old password");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            // Check if new passwords match
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }
            
            if (!isPasswordStrong(newPassword)) {
                String strengthMessage = getPasswordStrengthMessage(newPassword);
                request.setAttribute("error", strengthMessage != null ? strengthMessage : "Password is not strong enough!");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

            // Update password
            userDAO.updatePassword(user.getEmail(), hashedPassword);

            sendPasswordChangeNotification(request.getServletContext(), user.getEmail());

            user.setPass(newPassword);
            session.setAttribute("user", user);
            response.sendRedirect("profile.jsp?success=Password changed successfully! Please login with your new password! ");

        } catch (SQLException e) {
            request.setAttribute("error", "Password change failed: " + e.getMessage());
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
    
    private boolean isPasswordStrong(String password) {
        String strongPasswordPattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$";
        return password.matches(strongPasswordPattern);
    }

    private String getPasswordStrengthMessage(String password) {
        if (password.length() < 8) {
            return "Password must be at least 8 characters long!";
        }
        if (!password.matches(".*[a-z].*")) {
            return "Password must contain at least one lowercase letter!";
        }
        if (!password.matches(".*[A-Z].*")) {
            return "Password must contain at least one uppercase letter!";
        }
        if (!password.matches(".*\\d.*")) {
            return "Password must contain at least one number!";
        }
        if (!password.matches(".*[@#$%^&+=!].*")) {
            return "Password must contain at least one special character (@#$%^&+=!)!";
        }
        return null;
    }
    
    private void sendPasswordChangeNotification(ServletContext context, String email) {
        try {
            String subject = "Password Changed Successfully";
            String content = createPasswordChangeNotificationContent();

            Properties props = new Properties();
            props.load(context.getResourceAsStream("/WEB-INF/application.properties"));

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(props.getProperty("mail.username"),
                            props.getProperty("mail.password"));
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(props.getProperty("mail.username")));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject(subject);
            message.setText(content);
            Transport.send(message);

        } catch (Exception e) {
            Logger.getLogger(ChangePasswordController.class.getName()).log(Level.WARNING,
                    "Could not send password change notification to: " + email, e);
        }
    }

    private String createPasswordChangeNotificationContent() {
        return "Hello,\n\n"
                + "Your password has been successfully changed from your profile settings.\n\n"
                + "If you did not make this change, please contact our support team immediately.\n\n"
                + "For your security:\n"
                + "- Never share your password with anyone\n"
                + "- Use a unique password for this account\n"
                + "- Consider enabling two-factor authentication if available\n\n"
                + "Best regards,\n"
                + "The Security Team";
    }
}
