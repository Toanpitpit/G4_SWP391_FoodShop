package com.example.servlet.controller;

import com.example.servlet.dao.AccountDAO;
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
import java.io.IOException;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.mindrot.jbcrypt.BCrypt;

public class ResetPasswordController extends HttpServlet {

    private final AccountDAO userDAO = new AccountDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Hiển thị form reset password
        String email = req.getParameter("email");
        if (email != null && !email.trim().isEmpty()) {
            req.setAttribute("email", email);

            // Kiểm tra trạng thái mã hiện tại
            String codeStatus = ForgotPasswordController.getCodeStatus(email);
            if ("EXPIRED".equals(codeStatus) || "NO_CODE".equals(codeStatus)) {
                req.setAttribute("codeExpired", true);
                req.setAttribute("info", "The verification code has expired. Please resend a new code!");
            }
        }
        req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String code = req.getParameter("code");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        // Kiểm tra các field bắt buộc
        if (email == null || email.trim().isEmpty()
                || code == null || code.trim().isEmpty()
                || newPassword == null || newPassword.trim().isEmpty()) {
            req.setAttribute("error", "Please fill in all the information!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra mật khẩu xác nhận (nếu có field này)
        if (confirmPassword != null && !newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "The confirmation password does not match!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra mật khẩu mạnh
        if (!isPasswordStrong(newPassword)) {
            String strengthMessage = getPasswordStrengthMessage(newPassword);
            req.setAttribute("error", strengthMessage != null ? strengthMessage : "Password is not strong enough!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra trạng thái mã xác nhận
        String codeStatus = ForgotPasswordController.getCodeStatus(email);

        switch (codeStatus) {
            case "NO_CODE":
                req.setAttribute("error", "Verification code not found! Please resend a new code");
                req.setAttribute("email", email);
                req.setAttribute("codeExpired", true);
                req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
                return;

            case "EXPIRED":
                req.setAttribute("error", "The verification code has expired. Please resend a new code!");
                req.setAttribute("email", email);
                req.setAttribute("codeExpired", true);
                req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
                return;

            case "VALID":
                // Tiếp tục xử lý
                break;

            default:
                req.setAttribute("error", "System error! Please try again.");
                req.setAttribute("email", email);
                req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
                return;
        }

        // Xác thực mã
        if (!ForgotPasswordController.verifyCode(email, code)) {
            req.setAttribute("error", "The verification code is incorrect!");
            req.setAttribute("email", email);

            // Hiển thị thời gian còn lại nếu mã vẫn còn hiệu lực
            long remainingTime = ForgotPasswordController.getRemainingTime(email);
            if (remainingTime > 0) {
                long seconds = remainingTime / 1000;
                req.setAttribute("remainingTime", "The code is valid for " + seconds + " giây.");
            } else {
                req.setAttribute("codeExpired", true);
            }

            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
            return;
        }

        try {
            // Hash mật khẩu mới
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

            // Cập nhật mật khẩu trong database
            userDAO.updatePassword(email, hashedPassword);

            // GỬI THÔNG BÁO EMAIL (THÊM DÒNG NÀY)
            sendPasswordChangeNotification(req.getServletContext(), email);

            // Xóa mã xác nhận sau khi đổi mật khẩu thành công (THÊM DÒNG NÀY)
            ForgotPasswordController.verificationCodes.remove(email);

            // Thành công - chuyển đến trang login với thông báo thành công (CẬP NHẬT MESSAGE)
            req.setAttribute("success", "Password reset successful! A confirmation email has been sent. Please log in with your new password.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);

        } catch (SQLException e) {
            Logger.getLogger(ResetPasswordController.class.getName()).log(Level.SEVERE,
                    "Error updating password for email: " + email, e);
            req.setAttribute("error", "System error! Please try again.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
        } catch (Exception e) {
            Logger.getLogger(ResetPasswordController.class.getName()).log(Level.SEVERE,
                    "Unknown error: " + e.getMessage(), e);
            req.setAttribute("error", "Errors have occurred! Please try again.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
        }
    }

    private boolean isPasswordStrong(String password) {
        // Mật khẩu mạnh: ít nhất 8 ký tự, có chữ hoa, chữ thường, số và ký tự đặc biệt
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
            Logger.getLogger(ResetPasswordController.class.getName()).log(Level.WARNING,
                    "Could not send password change notification to: " + email, e);
            // Không throw exception để không ảnh hưởng đến quá trình đổi mật khẩu chính
        }
    }

    private String createPasswordChangeNotificationContent() {
        return "Hello,\n\n"
                + "Your password has been successfully changed.\n\n"
                + "If you did not make this change, please contact our support team immediately.\n\n"
                + "For your security:\n"
                + "- Never share your password with anyone\n"
                + "- Use a unique password for this account\n"
                + "- Consider enabling two-factor authentication if available\n\n"
                + "Best regards,\n"
                + "The Security Team";
    }
}
