package com.example.servlet.controller;
import com.example.servlet.dao.AccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
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
                req.setAttribute("info", "Mã xác nhận đã hết hạn. Vui lòng yêu cầu mã mới.");
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
        if (email == null || email.trim().isEmpty() ||
            code == null || code.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty()) {
            req.setAttribute("error", "Vui lòng điền đầy đủ thông tin!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
            return;
        }
        
        // Kiểm tra mật khẩu xác nhận (nếu có field này)
        if (confirmPassword != null && !newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
            return;
        }
        
        // Kiểm tra độ dài mật khẩu
        if (newPassword.length() < 6) {
            req.setAttribute("error", "Mật khẩu phải có ít nhất 6 ký tự!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
            return;
        }
        
        // Kiểm tra trạng thái mã xác nhận
        String codeStatus = ForgotPasswordController.getCodeStatus(email);
        
        switch (codeStatus) {
            case "NO_CODE":
                req.setAttribute("error", "Không tìm thấy mã xác nhận! Vui lòng yêu cầu mã mới.");
                req.setAttribute("email", email);
                req.setAttribute("codeExpired", true);
                req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
                return;
                
            case "EXPIRED":
                req.setAttribute("error", "Mã xác nhận đã hết hạn! Vui lòng yêu cầu mã mới.");
                req.setAttribute("email", email);
                req.setAttribute("codeExpired", true);
                req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
                return;
                
            case "VALID":
                // Tiếp tục xử lý
                break;
                
            default:
                req.setAttribute("error", "Lỗi hệ thống! Vui lòng thử lại.");
                req.setAttribute("email", email);
                req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
                return;
        }
        
        // Xác thực mã
        if (!ForgotPasswordController.verifyCode(email, code)) {
            req.setAttribute("error", "Mã xác nhận không đúng!");
            req.setAttribute("email", email);
            
            // Hiển thị thời gian còn lại nếu mã vẫn còn hiệu lực
            long remainingTime = ForgotPasswordController.getRemainingTime(email);
            if (remainingTime > 0) {
                long seconds = remainingTime / 1000;
                req.setAttribute("remainingTime", "Mã còn hiệu lực trong " + seconds + " giây.");
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
            
            // Thành công - chuyển đến trang login với thông báo thành công
            req.setAttribute("success", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
            
        } catch (SQLException e) {
            Logger.getLogger(ResetPasswordController.class.getName()).log(Level.SEVERE, 
                "Lỗi cập nhật mật khẩu cho email: " + email, e);
            req.setAttribute("error", "Lỗi hệ thống! Vui lòng thử lại sau.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
        } catch (Exception e) {
            Logger.getLogger(ResetPasswordController.class.getName()).log(Level.SEVERE, 
                "Lỗi không xác định: " + e.getMessage(), e);
            req.setAttribute("error", "Đã xảy ra lỗi! Vui lòng thử lại.");
            req.setAttribute("email", email);
            req.getRequestDispatcher("resetpassword.jsp").forward(req, resp);
        }
    }
}
