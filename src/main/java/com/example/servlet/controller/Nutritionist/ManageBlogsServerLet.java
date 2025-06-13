/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.example.servlet.controller.Nutritionist;

import com.example.servlet.dao.BMIClassificationDAO;
import com.example.servlet.dao.BlogDAO;
import com.example.servlet.model.Account;
import com.example.servlet.model.BMIClassification;
import com.example.servlet.model.Blogs;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.Console;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.taglibs.standard.functions.Functions;

/**
 *
 * @author Admin
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5)
public class ManageBlogsServerLet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String UPLOAD_DIRECTORY = "D:\\Semester 5\\SWP391\\Project\\G4_SWP391_FoodShop-master\\G4_SWP391_FoodShop-master\\src\\main\\webapp\\img\\blog";
    private static final String TAGET_DIRECTORY = "D:\\Semester 5\\SWP391\\Project\\G4_SWP391_FoodShop-master\\G4_SWP391_FoodShop-master\\target\\Food-1.0-SNAPSHOT\\img\\blog";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType ("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter ()) {
            /* TODO output your page here. You may use following sample code. */
            out.println ("<!DOCTYPE html>");
            out.println ("<html>");
            out.println ("<head>");
            out.println ("<title>Servlet CreateBlogsServerLet</title>");
            out.println ("</head>");
            out.println ("<body>");
            out.println ("<h1>Servlet CreateBlogsServerLet at " + request.getContextPath () + "</h1>");
            out.println ("</body>");
            out.println ("</html>");
        }
    }

    @Override

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BMIClassificationDAO b_dao = new BMIClassificationDAO ();
        BlogDAO _dao = new BlogDAO ();
        try {
            String id = request.getParameter ("id");

            response.setContentType ("text/html;charset=UTF-8");
            if (id != null) {
                try {
                    int bid = Integer.parseInt (id);
                    Blogs b = _dao.getBlogByID (bid);
                    request.setAttribute ("blogU", b);
                    List< BMIClassification> lstBMI = b_dao.getAllBMI ();
                    List<String> ststuss = _dao.getAllDistinctStatuses ();
                    request.setAttribute ("statusList", ststuss);
                    request.setAttribute ("lstBMI", lstBMI);
                    response.setContentType ("text/html;charset=UTF-8");
                    request.getRequestDispatcher ("/Nutritionist/CreateBlog.jsp")
                            .forward (request, response);
                } catch (Exception e) {
                }
            } else {
                List< BMIClassification> lstBMI = b_dao.getAllBMI ();
                List<String> ststuss = _dao.getAllDistinctStatuses ();
                request.setAttribute ("statusList", ststuss);
                request.setAttribute ("lstBMI", lstBMI);
                request.getRequestDispatcher ("/Nutritionist/CreateBlog.jsp")
                        .forward (request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger (ManageBlogsServerLet.class.getName ()).log (Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger (ManageBlogsServerLet.class.getName ()).log (Level.SEVERE, null, ex);
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType ("text/html;charset=UTF-8");
        request.setCharacterEncoding ("UTF-8");

        HttpSession session = request.getSession (false);
        if (session == null || session.getAttribute ("Account") == null) {
            response.sendRedirect ("login.jsp");
            return;
        }

        Account acc = (Account) session.getAttribute ("Account");

        String title = request.getParameter ("title");
        String bmiIdStr = request.getParameter ("bmiId");
        String status = request.getParameter ("status");
        String content = request.getParameter ("content");
        request.setAttribute ("title", title);
        request.setAttribute ("status", status);
        request.setAttribute ("content", content);
        Part imagePart = request.getPart ("imageUrl");
        if (bmiIdStr != null) {
            request.setAttribute ("selectedBmiId", Integer.parseInt (bmiIdStr));
        }
        if (title == null || title.trim ().isEmpty ()
                || content == null || content.trim ().isEmpty ()
                || bmiIdStr == null || bmiIdStr.isEmpty ()
                || status == null || imagePart == null
                || imagePart.getSize () == 0
                || imagePart.getSubmittedFileName ().isEmpty ()) {
            request.setAttribute ("Errmess", "Vui lòng nhập đầy đủ tiêu đề, nội dung , ảnh và chọn BMI.");
            doGet (request, response);
            return;
        }

        int bmiId;
        try {
            bmiId = Integer.parseInt (bmiIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute ("Errmess", "Giá trị BMI không hợp lệ.");
            doGet (request, response);
            return;
        }

        // Handle file upload
        String image_url = null;
        try {
            Part filePart = request.getPart ("imageUrl");

            if (filePart.getSize () > 5 * 1024 * 1024) {
                request.setAttribute ("Errmess", "Ảnh vượt quá dung lượng cho phép (5MB).");
                doGet (request, response);
                return;
            }

            String fileName = filePart.getSubmittedFileName ();
            if (fileName != null && !fileName.isEmpty ()) {
                String fileExtension = "";
                int dotIndex = fileName.lastIndexOf ('.');
                if (dotIndex >= 0) {
                    fileExtension = fileName.substring (dotIndex);
                }

                String uniqueFileName = UUID.randomUUID ().toString () + fileExtension;
                File uploadDir = new File (UPLOAD_DIRECTORY);
                if (!uploadDir.exists ()) {
                    uploadDir.mkdirs ();
                }

                String filePath = UPLOAD_DIRECTORY + File.separator + uniqueFileName;
                filePart.write (filePath);

                File sourceFile = new File (filePath);
                File targetFile = new File (TAGET_DIRECTORY + File.separator + uniqueFileName);
                Files.copy (sourceFile.toPath (), targetFile.toPath (), StandardCopyOption.REPLACE_EXISTING);

                image_url = "img/blog/" + uniqueFileName;
            }

        } catch (IllegalStateException e) {
            request.setAttribute ("Errmess", "Tổng dung lượng dữ liệu gửi lên vượt giới hạn 5MB.");
            doGet (request, response);
            return;
        } catch (Exception e) {
            e.printStackTrace ();
            request.setAttribute ("Errmess", "Đã xảy ra lỗi khi tải ảnh.");
            doGet (request, response);
            return;
        }

        // Tạo blog object
        Timestamp now = new Timestamp (System.currentTimeMillis ());
        Blogs blog = new Blogs (
                0, acc.getId (), acc.getUsername (), bmiId,
                title, image_url, content, status, now, now
        );

        // Lưu blog vào DB
        BlogDAO blogDAO = new BlogDAO ();
        boolean success = blogDAO.insertBlog (blog);

        if (success) {
            session.setAttribute ("mess", "Tạo bài viết thành công.");
            response.sendRedirect ("listblog");
        } else {
            request.setAttribute ("Errmess", "Không thể tạo bài viết. Vui lòng thử lại.");
            doGet (request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
