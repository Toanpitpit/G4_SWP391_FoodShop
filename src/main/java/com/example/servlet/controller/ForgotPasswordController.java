package com.example.servlet.controller;

import com.example.servlet.dao.AccountDAO;
import jakarta.mail.*;
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
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ForgotPasswordController extends HttpServlet {

    // Lưu trữ mã xác nhận kèm thời gian tạo
    static final ConcurrentHashMap<String, VerificationData> verificationCodes = new ConcurrentHashMap<>();
    private final AccountDAO userDAO = new AccountDAO();

    // Thời gian hết hạn mã xác nhận (1 phút = 60,000 milliseconds)
    private static final long CODE_EXPIRY_TIME = 1 * 60 * 1000;

    // Class để lưu trữ mã xác nhận và thời gian tạo
    public static class VerificationData {

        private final String code;
        private final long createdTime;

        public VerificationData(String code) {
            this.code = code;
            this.createdTime = System.currentTimeMillis();
        }

        public String getCode() {
            return code;
        }

        public boolean isExpired() {
            return System.currentTimeMillis() - createdTime > CODE_EXPIRY_TIME;
        }

        public long getRemainingTime() {
            long elapsed = System.currentTimeMillis() - createdTime;
            return Math.max(0, CODE_EXPIRY_TIME - elapsed);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("forgetpassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String action = req.getParameter("action");

        // Xử lý resend code
        if ("resend".equals(action)) {
            handleResendCode(req, resp, email);
            return;
        }

        // Xử lý gửi mã lần đầu (logic cũ)
        handleInitialCodeSend(req, resp, email);
    }

    private void handleResendCode(HttpServletRequest req, HttpServletResponse resp, String email)
            throws ServletException, IOException {

        if (email == null || email.trim().isEmpty()) {
            resp.getWriter().write("Invalid Email!");
            return;
        }

        // Kiểm tra email tồn tại
        boolean emailExists = false;
        try {
            emailExists = userDAO.checkEmailExists(email);
        } catch (SQLException ex) {
            Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE, null, ex);
            resp.getWriter().write("System error!");
            return;
        }

        if (!emailExists) {
            resp.getWriter().write("Email does not exist!");
            return;
        }

        // Xóa mã cũ và tạo mã mới
        cleanupExpiredCodes();
        verificationCodes.remove(email); // Xóa mã cũ

        String newCode = generateVerificationCode();
        verificationCodes.put(email, new VerificationData(newCode));

        try {
            sendEmail(req.getServletContext(), email, "Reset verification code",
                    createEmailContent(newCode));

            // Trả về response thành công
            resp.setContentType("text/html;charset=UTF-8");
            resp.getWriter().write("The verification code has been sent! The code will expire in 1 minute.");

        } catch (Exception e) {
            Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE,
                    "Error sending resend email for: " + email, e);
            resp.getWriter().write("Error sending mail: " + e.getMessage());
        }
    }

    private void handleInitialCodeSend(HttpServletRequest req, HttpServletResponse resp, String email)
            throws ServletException, IOException {

        if (email == null || email.trim().isEmpty()) {
            req.setAttribute("error", "Please enter your email");
            req.getRequestDispatcher("forgetpassword.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra email tồn tại
        boolean emailExists = false;
        try {
            emailExists = userDAO.checkEmailExists(email);
        } catch (SQLException ex) {
            Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE, null, ex);
            req.setAttribute("error", "System error! Please try again.");
            req.getRequestDispatcher("forgetpassword.jsp").forward(req, resp);
            return;
        }

        if (!emailExists) {
            req.setAttribute("error", "The email does not exist in the system!");
            req.getRequestDispatcher("forgetpassword.jsp").forward(req, resp);
            return;
        }

        // Xóa mã cũ nếu có (cleanup)
        cleanupExpiredCodes();

        String code = generateVerificationCode();
        verificationCodes.put(email, new VerificationData(code));

        try {
            sendEmail(req.getServletContext(), email, "Reset verification code",
                    createEmailContent(code));

            req.setAttribute("success", "The verification code has been sent! The code will expire in 1 minute.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);

        } catch (Exception e) {
            Logger.getLogger(ForgotPasswordController.class.getName()).log(Level.SEVERE,
                    "Error sending resend email for: " + email, e);
            req.setAttribute("error", "Error sending mail: " + e.getMessage());
            req.getRequestDispatcher("forgetpassword.jsp").forward(req, resp);
        }
    }

    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

    private String createEmailContent(String code) {
        return "Hello,\n\n"
                + "You have requested to reset the password for your account.\n\n"
                + "Your verification code is: " + code + "\n\n"
                + "This code will expire in 1 minute.\n\n"
                + "If you did not request a password reset, please ignore this email.\n\n"
                + "Best regards,\n"
                + "The Support Team";
    }

    private void sendEmail(ServletContext context, String to, String subject, String content)
            throws MessagingException, IOException {
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
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        message.setText(content);
        Transport.send(message);
    }

    // Phương thức để kiểm tra và xác thực mã
    public static boolean verifyCode(String email, String inputCode) {
        VerificationData data = verificationCodes.get(email);
        if (data == null) {
            return false; // Không có mã cho email này
        }

        if (data.isExpired()) {
            verificationCodes.remove(email); // Xóa mã đã hết hạn
            return false; // Mã đã hết hạn
        }

        boolean isValid = data.getCode().equals(inputCode);
        if (isValid) {
            verificationCodes.remove(email); // Xóa mã sau khi sử dụng thành công
        }

        return isValid;
    }

    // Phương thức để lấy thời gian còn lại của mã
    public static long getRemainingTime(String email) {
        VerificationData data = verificationCodes.get(email);
        return data != null ? data.getRemainingTime() : 0;
    }

    // Dọn dẹp các mã đã hết hạn
    private void cleanupExpiredCodes() {
        verificationCodes.entrySet().removeIf(entry -> entry.getValue().isExpired());
    }

    // Phương thức để kiểm tra mã có tồn tại và còn hiệu lực không
    public static String getCodeStatus(String email) {
        VerificationData data = verificationCodes.get(email);
        if (data == null) {
            return "NO_CODE"; // Không có mã
        }
        if (data.isExpired()) {
            verificationCodes.remove(email);
            return "EXPIRED"; // Mã đã hết hạn
        }
        return "VALID"; // Mã còn hiệu lực
    }
}
