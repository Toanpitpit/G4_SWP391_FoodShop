package com.example.servlet.controller;

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
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.sql.SQLException;

@WebServlet("/profile")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProfileController extends HttpServlet {
    private AccountDAO userDAO;
    private static final String UPLOAD_DIR = "D:\\Semester 5\\SWP391\\Project\\G4_SWP391_FoodShop-master\\G4_SWP391_FoodShop-master\\src\\main\\webapp\\img\\avar";
    private static final String RELATIVE_PATH = "img/avar";
    private static final String TAGET_DIRECTORY = "D:\\Semester 5\\SWP391\\Project\\G4_SWP391_FoodShop-master\\G4_SWP391_FoodShop-master\\target\\Food-1.0-SNAPSHOT\\img\\avar";

    @Override
    public void init() {
        userDAO = new AccountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("Account");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            user = userDAO.findByEmail(user.getEmail());
            if (user != null) {
                session.setAttribute("Account", user);
            } 
        } catch (SQLException e) {
            request.setAttribute("error", "Error loading user data: " + e.getMessage());
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Account user = (Account) session.getAttribute("Account");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String birthDateStr = request.getParameter("birthDate");
     

        // Handle file upload
        String imagePath = user.getImage();
        Part filePart = request.getPart("image");
      if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName (filePart);
            File uploadDir = new File (UPLOAD_DIR);
            if (!uploadDir.exists ()) {
                uploadDir.mkdirs ();
            }

            String fullPath = UPLOAD_DIR + File.separator + fileName;
            filePart.write (fullPath);
            imagePath = RELATIVE_PATH + "/" + fileName;

            // ✅ Sửa chỗ này
            File sourceFile = new File (UPLOAD_DIR + File.separator + fileName);
            File targetFile = new File (TAGET_DIRECTORY + File.separator + fileName);
            Files.copy (sourceFile.toPath (), targetFile.toPath (), StandardCopyOption.REPLACE_EXISTING);
        }


        // Update user object
        user.setName(name);
        user.setPhone(phone);
        user.setGender(gender);
        user.setBirthDate(birthDateStr != null && !birthDateStr.isEmpty() ? Date.valueOf(birthDateStr) : null);
        user.setImage(imagePath);

        try {
            userDAO.updateUser(user);
            session.setAttribute("user", user);
            response.sendRedirect("profile?success=Profile updated successfully");
        } catch (SQLException e) {
            request.setAttribute("error", "Update failed: " + e.getMessage());
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
    }
}
