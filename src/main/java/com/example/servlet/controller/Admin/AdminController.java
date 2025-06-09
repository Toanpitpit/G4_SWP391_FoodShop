package com.example.servlet.controller.Admin;

import com.example.servlet.dao.AccountDAO;
import com.example.servlet.model.Account;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.mindrot.jbcrypt.BCrypt;

// Annotation để cấu hình upload file
@WebServlet("/adminDashboard")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB trước khi lưu vào đĩa
    maxFileSize = 1024 * 1024 * 10,  // Giới hạn 10MB cho mỗi file
    maxRequestSize = 1024 * 1024 * 50 // Giới hạn 50MB cho toàn bộ request
)
public class AdminController extends HttpServlet {

    private AccountDAO dao;
    private static final String UPLOAD_DIR = "img/avar"; // Thư mục lưu ảnh gốc
    private static final String TARGET_DIR = "target";   // Thư mục sao chép ảnh
    private static final Logger LOGGER = Logger.getLogger(AdminController.class.getName());

    @Override
    public void init() {
        dao = new AccountDAO(); // Khởi tạo DAO để tương tác với database
    }

    // Xử lý GET request (hiển thị danh sách, chi tiết, hoặc form chỉnh sửa)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Lấy session mà không tạo mới
        Account account = (session != null) ? (Account) session.getAttribute("Account") : null;

        // Kiểm tra quyền Admin, nếu không phải redirect về login
        if (session == null || account == null || !"Admin".equalsIgnoreCase(account.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action"); // Lấy action từ URL
        String search = request.getParameter("search");
        String role = request.getParameter("role");
        String status = request.getParameter("status");
        
        try {
            if ("detail".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id")); // Lấy ID từ URL
                Account detailAccount = dao.findById(id); // Lấy tài khoản từ database
                if (detailAccount != null) {
                    request.setAttribute("account", detailAccount); // Đưa tài khoản vào request
                    request.getRequestDispatcher("/accountDetail.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/adminDashboard?error=AccountNotFound");
                }
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Account user = dao.findById(id);
                if (user != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/editAccount.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/adminDashboard?error=AccountNotFound");
                }
            } else if ("activate".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Account targetAccount = dao.findById(id); // Lấy thông tin tài khoản cần kích hoạt
                if (targetAccount != null && "Admin".equalsIgnoreCase(targetAccount.getRole())) {
                    // Không cho phép thay đổi trạng thái nếu là Admin
                    response.sendRedirect(request.getContextPath() + "/adminDashboard?error=CannotModifyAdminStatus");
                } else {
                    dao.updateUserStatus(id, "Active"); // Cập nhật trạng thái thành Active
                    response.sendRedirect(request.getContextPath() + "/adminDashboard");
                }
            } else if ("deactivate".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Account targetAccount = dao.findById(id); // Lấy thông tin tài khoản cần vô hiệu hóa
                if (targetAccount != null && "Admin".equalsIgnoreCase(targetAccount.getRole())) {
                    // Không cho phép thay đổi trạng thái nếu là Admin
                    response.sendRedirect(request.getContextPath() + "/adminDashboard?error=CannotModifyAdminStatus");
                } else {
                    dao.updateUserStatus(id, "Inactive"); // Cập nhật trạng thái thành Inactive
                    response.sendRedirect(request.getContextPath() + "/adminDashboard");
                }
            } else {
                List<Account> accounts = dao.getAllAccounts(search, role, status); // Lấy danh sách tài khoản
                request.setAttribute("accounts", accounts);
                request.setAttribute("search", search);
                request.setAttribute("role", role);
                request.setAttribute("status", status);
                request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error in doGet", e); // Log lỗi database
            response.sendRedirect(request.getContextPath() + "/adminDashboard?error=DatabaseError");
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid ID format", e); // Log lỗi định dạng ID
            response.sendRedirect(request.getContextPath() + "/adminDashboard?error=InvalidRequest");
        }
    }

    // Xử lý POST request (thêm hoặc cập nhật tài khoản)
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

                Part filePart = request.getPart("image"); // Lấy file ảnh từ form
                String fileName = getFileName(filePart);
                if (fileName == null || fileName.isEmpty()) {
                    request.setAttribute("error", "Vui lòng chọn một file hình ảnh!");
                    request.getRequestDispatcher("/addAccount.jsp").forward(request, response);
                    return;
                }

                String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                if (!"jpg".equals(fileExt) && !"jpeg".equals(fileExt) && !"png".equals(fileExt)) {
                    request.setAttribute("error", "Chỉ hỗ trợ file .jpg, .jpeg hoặc .png!");
                    request.getRequestDispatcher("/addAccount.jsp").forward(request, response);
                    return;
                }

                String appPath = request.getServletContext().getRealPath(""); // Lấy đường dẫn gốc của ứng dụng
                String savePath = new File(appPath, UPLOAD_DIR).getAbsolutePath();
                String targetPath = new File(appPath, TARGET_DIR).getAbsolutePath();

                LOGGER.info("Application Path: " + appPath);
                LOGGER.info("Save Path (img/avar): " + savePath);
                LOGGER.info("Target Path: " + targetPath);

                File saveDir = new File(savePath);
                if (!saveDir.exists()) {
                    if (!saveDir.mkdirs()) {
                        throw new IOException("Không thể tạo thư mục save: " + savePath);
                    }
                    LOGGER.info("Created directory: " + savePath);
                }
                File targetDir = new File(targetPath);
                if (!targetDir.exists()) {
                    if (!targetDir.mkdirs()) {
                        throw new IOException("Không thể tạo thư mục target: " + targetPath);
                    }
                    LOGGER.info("Created directory: " + targetPath);
                }

                String uniqueFileName = System.currentTimeMillis() + "_" + fileName; // Tạo tên file duy nhất
                String filePath = new File(savePath, uniqueFileName).getAbsolutePath();
                String targetFilePath = new File(targetPath, uniqueFileName).getAbsolutePath();

                LOGGER.info("Saving file to: " + filePath);
                LOGGER.info("Copying file to: " + targetFilePath);

                try (InputStream inputStream = filePart.getInputStream();
                     FileOutputStream outputStream = new FileOutputStream(filePath)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        outputStream.write(buffer, 0, bytesRead);
                    }
                    outputStream.flush();
                } catch (IOException e) {
                    LOGGER.log(Level.SEVERE, "Error writing file to " + filePath, e);
                    throw new IOException("Lỗi khi ghi file: " + e.getMessage());
                }

                File sourceFile = new File(filePath);
                if (!sourceFile.exists() || sourceFile.length() == 0) {
                    throw new IOException("File nguồn không tồn tại hoặc rỗng sau khi ghi: " + filePath);
                }
                LOGGER.info("File saved successfully at: " + filePath);

                File targetFile = new File(targetFilePath);
                Files.copy(sourceFile.toPath(), targetFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                if (!targetFile.exists()) {
                    throw new IOException("Sao chép file thất bại: " + targetFilePath);
                }
                LOGGER.info("File copied successfully to: " + targetFilePath);

                String dbFilePath = UPLOAD_DIR + "/" + uniqueFileName;

                if (dao.checkUsernameExists(username)) {
                    request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                    request.getRequestDispatcher("/addAccount.jsp").forward(request, response);
                    return;
                }
                if (dao.checkEmailExists(email)) {
                    request.setAttribute("error", "Email đã tồn tại!");
                    request.getRequestDispatcher("/addAccount.jsp").forward(request, response);
                    return;
                }
                if (!dao.isValidPassword(password)) {
                    request.setAttribute("error", "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa và ký tự đặc biệt!");
                    request.getRequestDispatcher("/addAccount.jsp").forward(request, response);
                    return;
                }
                if (!dao.validateBirthDate(birthDate)) {
                    request.setAttribute("error", "Ngày sinh phải trước ngày hiện tại!");
                    request.getRequestDispatcher("/addAccount.jsp").forward(request, response);
                    return;
                }

                Timestamp createAt = new Timestamp(System.currentTimeMillis()); // Thời gian tạo
                Account newAccount = new Account(
                    0, username, BCrypt.hashpw(password, BCrypt.gensalt()), name, email, phone,
                    gender, birthDate, role, status, dbFilePath, createAt
                );
                dao.addAccount(newAccount); // Lưu vào database
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error adding account", e);
                request.setAttribute("error", "Thêm tài khoản thất bại: " + e.getMessage());
                request.getRequestDispatcher("/addAccount.jsp").forward(request, response);
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

                Account existingAccount = dao.findById(id);
                if (existingAccount == null) {
                    throw new SQLException("Tài khoản không tồn tại!");
                }

                if (!existingAccount.getEmail().equalsIgnoreCase(email) && dao.checkEmailExists(email)) {
                    request.setAttribute("error", "Email đã tồn tại!");
                    request.getRequestDispatcher("/editAccount.jsp").forward(request, response);
                    return;
                }

                if (!dao.validateBirthDate(birthDate)) {
                    request.setAttribute("error", "Ngày sinh phải trước ngày hiện tại!");
                    request.getRequestDispatcher("/editAccount.jsp").forward(request, response);
                    return;
                }

                String dbFilePath = existingAccount.getImage(); // Giữ đường dẫn ảnh cũ
                Part filePart = request.getPart("image"); // Kiểm tra có file mới không
                if (filePart != null && filePart.getSize() > 0) {
                    String fileName = getFileName(filePart);
                    String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                    if (!"jpg".equals(fileExt) && !"jpeg".equals(fileExt) && !"png".equals(fileExt)) {
                        request.setAttribute("error", "Chỉ hỗ trợ file .jpg, .jpeg hoặc .png!");
                        request.getRequestDispatcher("/editAccount.jsp").forward(request, response);
                        return;
                    }

                    String appPath = request.getServletContext().getRealPath("");
                    String savePath = new File(appPath, UPLOAD_DIR).getAbsolutePath();
                    String targetPath = new File(appPath, TARGET_DIR).getAbsolutePath();

                    LOGGER.info("Application Path: " + appPath);
                    LOGGER.info("Save Path (img/avar): " + savePath);
                    LOGGER.info("Target Path: " + targetPath);

                    File saveDir = new File(savePath);
                    if (!saveDir.exists()) {
                        if (!saveDir.mkdirs()) {
                            throw new IOException("Không thể tạo thư mục save: " + savePath);
                        }
                        LOGGER.info("Created directory: " + savePath);
                    }
                    File targetDir = new File(targetPath);
                    if (!targetDir.exists()) {
                        if (!targetDir.mkdirs()) {
                            throw new IOException("Không thể tạo thư mục target: " + targetPath);
                        }
                        LOGGER.info("Created directory: " + targetPath);
                    }

                    String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
                    String filePath = new File(savePath, uniqueFileName).getAbsolutePath();
                    String targetFilePath = new File(targetPath, uniqueFileName).getAbsolutePath();

                    LOGGER.info("Updating file to: " + filePath);
                    LOGGER.info("Copying file to: " + targetFilePath);

                    try (InputStream inputStream = filePart.getInputStream();
                         FileOutputStream outputStream = new FileOutputStream(filePath)) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = inputStream.read(buffer)) != -1) {
                            outputStream.write(buffer, 0, bytesRead);
                        }
                        outputStream.flush();
                    } catch (IOException e) {
                        LOGGER.log(Level.SEVERE, "Error writing file to " + filePath, e);
                        throw new IOException("Lỗi khi ghi file: " + e.getMessage());
                    }

                    File sourceFile = new File(filePath);
                    if (!sourceFile.exists() || sourceFile.length() == 0) {
                        throw new IOException("File nguồn không tồn tại hoặc rỗng: " + filePath);
                    }
                    LOGGER.info("File updated successfully at: " + filePath);

                    File targetFile = new File(targetFilePath);
                    Files.copy(sourceFile.toPath(), targetFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
                    if (!targetFile.exists()) {
                        throw new IOException("Sao chép file thất bại: " + targetFilePath);
                    }
                    LOGGER.info("File copied successfully to: " + targetFilePath);

                    if (existingAccount.getImage() != null) {
                        String oldFilePath = new File(appPath, existingAccount.getImage()).getAbsolutePath();
                        String oldTargetPath = new File(appPath, existingAccount.getImage().replace(UPLOAD_DIR, TARGET_DIR)).getAbsolutePath();
                        Files.deleteIfExists(new File(oldFilePath).toPath()); // Xóa file cũ
                        Files.deleteIfExists(new File(oldTargetPath).toPath());
                    }

                    dbFilePath = UPLOAD_DIR + "/" + uniqueFileName;
                }

                String passwordToSet = (password != null && !password.isEmpty())
                        ? BCrypt.hashpw(password, BCrypt.gensalt())
                        : existingAccount.getPass(); // Giữ mật khẩu cũ nếu không thay đổi

                Account updatedAccount = new Account(
                    id, username, passwordToSet, name, email, phone, gender,
                    birthDate, role, status, dbFilePath, existingAccount.getCreate_at()
                );
                dao.updateAccount(updatedAccount); // Cập nhật vào database
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Error updating account", e);
                response.sendRedirect(request.getContextPath() + "/adminDashboard?error=UpdateFailed");
            }
        }
    }

    // Lấy tên file từ header của Part
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String cd : contentDisposition.split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}
