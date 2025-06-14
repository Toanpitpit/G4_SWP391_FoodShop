/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.example.servlet.controller.Nutritionist;

import com.example.servlet.dao.BMIClassificationDAO;
import com.example.servlet.dao.BlogDAO;
import com.example.servlet.dao.FoodDraftDAO;
import com.example.servlet.dao.NotifyDAO;
import com.example.servlet.dao.RequestDAO;
import com.example.servlet.model.Account;
import com.example.servlet.model.BMIClassification;
import com.example.servlet.model.Blogs;
import com.example.servlet.model.MonthlyStat;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.Year;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
 @MultipartConfig(
    fileSizeThreshold = 1024 * 1024,  // 1MB
    maxFileSize = 1024 * 1024 * 5,    // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class NutritionistControlServerLet extends HttpServlet {
    // D:\Semester 5\SWP391\SWP391_HealthyFood-main\G4_SWP391_FoodShop-master (3)\G4_SWP391_FoodShop-master\G4_SWP391_FoodShop-master
    private static final String BASE_PATH = "D:\\Semester 5\\SWP391\\Project\\G4_SWP391_FoodShop_Project";
    private static final String UPLOAD_DIRECTORY = BASE_PATH +"\\src\\main\\webapp\\img\\blog";
    private static final String TAGET_DIRECTORY = BASE_PATH + "\\target\\Food-1.0-SNAPSHOT\\img\\blog";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter ("action");
        
        if (action == null) {
            response.sendRedirect ("login.jsp");
            return;
        }
        switch (action) {
            // BLOG
            case "dashboard":                
                dashboard (request, response);
                break;
            case "displayblog":
                DisplayBlog (request, response);
                break;
            case "displaycreateblog":
                DisplayCreateBlog (request, response);
                break;
            case "displayblogdetail":
                displayBlogDetail (request, response);
                break;
            case "deleteblog":
                deleteBlog (request, response);
                break;
            case "updateblog":
                createBlog (request, response);
                break;
            case "createblog":
                createBlog (request, response);
                break;
            case "editblog":
                DisplayCreateBlog (request, response);
                break;
            case "updateBlog":
                update (request, response);
                break;
            case "showdetail":
                displayBlogDetail (request, response);
                break;
            default:
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest (request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest (request, response); 
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// 

//    protected void createBlog(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession (false);
//        if (session == null || session.getAttribute ("Account") == null) {
//            response.sendRedirect ("login.jsp");
//            return;
//        }
//        
//        Account acc = (Account) session.getAttribute ("Account");
//        
//        String title = request.getParameter ("title");
//        String bmiIdStr = request.getParameter ("bmiId");
//        String status = request.getParameter ("status");
//        String content = request.getParameter ("content");
//        request.setAttribute ("title", title);
//        request.setAttribute ("status", status);
//        request.setAttribute ("content", content);
//        Part imagePart = request.getPart ("imageUrl");
//        
//        if (bmiIdStr != null) {
//            request.setAttribute ("selectedBmiId", Integer.parseInt (bmiIdStr));
//        }
//        if (title == null || title.trim ().isEmpty ()
//                || content == null || content.trim ().isEmpty ()
//                || bmiIdStr == null || bmiIdStr.isEmpty ()
//                || status == null || imagePart == null
//                || imagePart.getSize () == 0
//                || imagePart.getSubmittedFileName ().isEmpty ()) {
//            request.setAttribute ("Errmess", "Vui lòng nhập đầy đủ tiêu đề, nội dung , ảnh và chọn BMI.");
//            DisplayCreateBlog (request, response);
//            return;
//        }
//        
//        int bmiId;
//        try {
//            bmiId = Integer.parseInt (bmiIdStr);
//        } catch (NumberFormatException e) {
//            request.setAttribute ("Errmess", "Giá trị BMI không hợp lệ.");
//            DisplayCreateBlog (request, response);
//            return;
//        }
//        String image_url = null;
//        try {
//            Part filePart = request.getPart ("imageUrl");
//            
//            if (filePart.getSize () > 5 * 1024 * 1024) {
//                request.setAttribute ("Errmess", "Ảnh vượt quá dung lượng cho phép (5MB).");
//                DisplayCreateBlog (request, response);
//                return;
//            }
//            
//            String fileName = filePart.getSubmittedFileName ();
//            if (fileName != null && !fileName.isEmpty ()) {
//                String fileExtension = "";
//                int dotIndex = fileName.lastIndexOf ('.');
//                if (dotIndex >= 0) {
//                    fileExtension = fileName.substring (dotIndex);
//                }
//                
//                String uniqueFileName = UUID.randomUUID ().toString () + fileExtension;
//                File uploadDir = new File (UPLOAD_DIRECTORY);
//                if (!uploadDir.exists ()) {
//                    uploadDir.mkdirs ();
//                }
//                
//                String filePath = UPLOAD_DIRECTORY + File.separator + uniqueFileName;
//                filePart.write (filePath);
//                
//                File sourceFile = new File (filePath);
//                File targetFile = new File (TAGET_DIRECTORY + File.separator + uniqueFileName);
//                Files.copy (sourceFile.toPath (), targetFile.toPath (), StandardCopyOption.REPLACE_EXISTING);
//                
//                image_url = "img/blog/" + uniqueFileName;
//            }
//            
//        } catch (IllegalStateException e) {
//            request.setAttribute ("Errmess", "Tổng dung lượng dữ liệu gửi lên vượt giới hạn 5MB.");
//            DisplayCreateBlog (request, response);
//            return;
//        } catch (Exception e) {
//            e.printStackTrace ();
//            request.setAttribute ("Errmess", "Đã xảy ra lỗi khi tải ảnh.");
//            DisplayCreateBlog (request, response);
//            return;
//        }
//        Timestamp now = new Timestamp (System.currentTimeMillis ());
//        Blogs blog = new Blogs (
//                0, acc.getId (), acc.getUsername (), bmiId,
//                title, image_url, content, status, now, now
//        );
//        BlogDAO blogDAO = new BlogDAO ();
//        boolean success = blogDAO.insertBlog (blog);
//        
//        if (success) {
//            session.setAttribute ("successMessage", "Tạo bài viết thành công.");
//            DisplayBlog (request, response);
//        } else {
//            request.setAttribute ("Errmess", "Không thể tạo bài viết. Vui lòng thử lại.");
//           DisplayCreateBlog (request, response);
//        }
//        
//    }
    protected void createBlog(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession(false);
    if (session == null || session.getAttribute("Account") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Account acc = (Account) session.getAttribute("Account");

    String title = request.getParameter("title");
    String bmiIdStr = request.getParameter("bmiId");
    String status = request.getParameter("status");
    String content = request.getParameter("content");
    Part imagePart = request.getPart("imageUrl");

    request.setAttribute("title", title);
    request.setAttribute("status", status);
    request.setAttribute("content", content);
    if (bmiIdStr != null) request.setAttribute("selectedBmiId", Integer.parseInt(bmiIdStr));

    if (isNotValidInput(title, content, bmiIdStr, status, imagePart)) {
        request.setAttribute("Errmess", "Vui lòng nhập đầy đủ tiêu đề, nội dung , ảnh và chọn BMI.");
        DisplayCreateBlog(request, response);
        return;
    }

    int bmiId;
    try {
        bmiId = Integer.parseInt(bmiIdStr);
    } catch (NumberFormatException e) {
        request.setAttribute("Errmess", "Giá trị BMI không hợp lệ.");
        DisplayCreateBlog(request, response);
        return;
    }

    String imageUrl;
    try {
        imageUrl = processImageUpload(imagePart);
    } catch (IllegalStateException e) {
        request.setAttribute("Errmess", "Ảnh vượt quá dung lượng cho phép (5MB).");
        DisplayCreateBlog(request, response);
        return;
    } catch (Exception e) {
        request.setAttribute("Errmess", "Đã xảy ra lỗi khi tải ảnh.");
        DisplayCreateBlog(request, response);
        return;
    }

    Timestamp now = new Timestamp(System.currentTimeMillis());
    Blogs blog = new Blogs(0, acc.getId(), acc.getUsername(), bmiId, title, imageUrl, content, status, now, now);
    BlogDAO blogDAO = new BlogDAO();
    boolean success = blogDAO.insertBlog(blog);

    if (success) {
        session.setAttribute("successMessage", "Tạo bài viết thành công.");
        DisplayBlog(request, response);
    } else {
        request.setAttribute("Errmess", "Không thể tạo bài viết. Vui lòng thử lại.");
        DisplayCreateBlog(request, response);
    }
}

   private String processImageUpload(Part filePart) throws IOException {
    if (filePart.getSize() > 5 * 1024 * 1024) {
        throw new IllegalStateException("Ảnh vượt quá dung lượng 5MB");
    }

    String fileName = filePart.getSubmittedFileName();
    if (fileName == null || fileName.isEmpty()) return null;

    String fileExtension = fileName.contains(".") ?
            fileName.substring(fileName.lastIndexOf(".")) : "";

    String uniqueFileName = UUID.randomUUID() + fileExtension;

    File uploadDir = new File(UPLOAD_DIRECTORY);
    if (!uploadDir.exists()) uploadDir.mkdirs();

    String filePath = UPLOAD_DIRECTORY + File.separator + uniqueFileName;
    filePart.write(filePath);

    File source = new File(filePath);
    File target = new File(TAGET_DIRECTORY + File.separator + uniqueFileName);
    Files.copy(source.toPath(), target.toPath(), StandardCopyOption.REPLACE_EXISTING);

    return "img/blog/" + uniqueFileName;
}
  
   private boolean isNotValidInput(String title, String content, String bmiIdStr, String status, Part imagePart) {
    return title == null || title.trim().isEmpty()
            || content == null || content.trim().isEmpty()
            || bmiIdStr == null || bmiIdStr.isEmpty()
            || status == null || imagePart == null
            || imagePart.getSize() == 0
            || imagePart.getSubmittedFileName().isEmpty();
}

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null || session.getAttribute ("Account") == null) {
            response.sendRedirect ("login.jsp");
            return;
        }
        BlogDAO blogDAO = new BlogDAO ();
        Account acc = (Account) session.getAttribute ("Account");
        
        String title = request.getParameter ("title");
        String bmiIdStr = request.getParameter ("bmiId");
        String status = request.getParameter ("status");
        String content = request.getParameter ("content");
        request.setAttribute ("title", title);
        request.setAttribute ("status", status);
        request.setAttribute ("content", content);
        Part imagePart = request.getPart ("imageUrl");
        int  id =  Integer.parseInt (request.getParameter ("id"));
        if (bmiIdStr != null) {
            request.setAttribute ("selectedBmiId", Integer.parseInt (bmiIdStr));
        }
        if (title == null || title.trim ().isEmpty ()
                || content == null || content.trim ().isEmpty ()
                || bmiIdStr == null || bmiIdStr.isEmpty ()
                || status == null) {
            request.setAttribute ("Errmess", "Vui lòng nhập đầy đủ tiêu đề, nội dung và chọn BMI.");
            DisplayCreateBlog (request, response);
            return;
        }
        
        int bmiId;
        try {
            bmiId = Integer.parseInt (bmiIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute ("Errmess", "Giá trị BMI không hợp lệ.");
            DisplayCreateBlog (request, response);
            return;
        }

        String image_url = null;
        try {
            
            if(imagePart == null || imagePart.getSize () == 0){ 
                 Blogs blog = blogDAO.getBlogByID (id);
                    image_url = blog.getImageUlr ();
            } else {
                Part filePart = request.getPart ("imageUrl");
                String path = blogDAO.getPathBlogByID (id);
                String basePath = BASE_PATH+ "/src/main/webapp/";
                String realPath = basePath + path;
                blogDAO.deleteImage (realPath);
            if (filePart.getSize () > 5 * 1024 * 1024) {
                request.setAttribute ("Errmess", "Ảnh vượt quá dung lượng cho phép (5MB).");
                DisplayCreateBlog (request, response);
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
            }
            
            
        } catch (IllegalStateException e) {
            request.setAttribute ("Errmess", "Tổng dung lượng dữ liệu gửi lên vượt giới hạn 5MB.");
            DisplayCreateBlog (request, response);
            return;
        } catch (Exception e) {
            e.printStackTrace ();
            request.setAttribute ("Errmess", "Đã xảy ra lỗi khi tải ảnh.");
            DisplayCreateBlog (request, response);
            return;
        }

        // Tạo blog object
        Timestamp now = new Timestamp (System.currentTimeMillis ());
        Blogs blog = new Blogs (
                id, acc.getId (), acc.getUsername (), bmiId,
                title, image_url, content, status, now, now
        );
        
        boolean success = blogDAO.updateBlog (blog);
        
        if (success) {
            session.setAttribute ("successMessage", "Chỉnh sửa bài viết thành công.");
            DisplayBlog (request, response);
        } else {
            request.setAttribute ("Errmess", "Không thể tạo bài viết. Vui lòng thử lại.");
           DisplayCreateBlog (request, response);
        }
        
    }
    
    protected void DisplayCreateBlog(HttpServletRequest request, HttpServletResponse response)
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
                    Logger.getLogger ("Wrong");
                }
            } else {
                List< BMIClassification> lstBMI = b_dao.getAllBMI ();
                List<String> ststuss = _dao.getAllDistinctStatuses ();
                request.setAttribute ("statusList", ststuss);
                request.setAttribute ("lstBMI", lstBMI);
                String title = request.getParameter ("title");
                String bmiIdStr = request.getParameter ("bmiId");
                String status = request.getParameter ("status");
                String content = request.getParameter ("content");
                request.setAttribute ("title", title);
                request.setAttribute ("status", status);
                request.setAttribute ("content", content);
                if (bmiIdStr != null) {
                    request.setAttribute ("selectedBmiId", Integer.parseInt (bmiIdStr));
                }
                request.getRequestDispatcher ("/Nutritionist/CreateBlog.jsp")
                        .forward (request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger (NutritionistControlServerLet.class.getName()).log (Level.SEVERE, null, ex);
        }
        
    }
    
    protected void notgen(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    // xóa bài viết 
    protected void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType ("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter ()) {
            HttpSession session = request.getSession (false);
            if (session == null) {
                response.sendRedirect ("login.jsp");
            }
            int id = Integer.parseInt (request.getParameter ("id"));
            BlogDAO b_dao = new BlogDAO ();
            String path = b_dao.getPathBlogByID (id);
            String basePath = "D:/Semester 5/SWP391/Project/G4_SWP391_FoodShop-master/G4_SWP391_FoodShop-master/src/main/webapp/";
            String realPath = basePath + path;
            b_dao.deleteImage (realPath);
            boolean check = b_dao.deleteBlogByID (id);
            if (check) {
                session.setAttribute ("successMessage", "Delete Sucsessfuly");
            } else {
                session.setAttribute ("Errmess", "Fail to detele");
            }
            DisplayBlog (request, response);
        }
        
    }
    
    protected void nogen(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {    
    }

    protected void DisplayBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding ("UTF-8");
        response.setContentType ("text/html;charset=UTF-8");
        HttpSession session = request.getSession (false);
        if (session == null || session.getAttribute ("Account") == null) {
            response.sendRedirect ("login.jsp");
            return;
        }
        
        if (session != null) {
            String mess = (String) session.getAttribute ("successMessage");
            String errMess = (String) session.getAttribute ("Errmess");
            if (mess != null) {
                request.setAttribute ("successMessage", mess);
                session.removeAttribute ("successMessage");
            }
            if (errMess != null) {
                request.setAttribute ("Errmess", errMess);
                session.removeAttribute ("Errmess");
            }
            
            try {
                if ("true".equals (request.getParameter ("json"))) {
                    handleJsonRequest (request, response);
                } else {
                    
                    handleNormalRequest (request, response);
                    return;                    
                }
            } catch (SQLException ex) {
                ex.printStackTrace ();
                throw new ServletException (ex);
            }
            
        }
    }
    
    protected void displayBlogDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType ("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter ()) {
            HttpSession session = request.getSession (false);
            if (session == null || session.getAttribute ("Account") == null) {
                response.sendRedirect ("login.jsp");
                return;
            }
            Account acc = (Account) session.getAttribute ("Account");
            BlogDAO b_dao = new BlogDAO ();
            try {
                String ids = request.getParameter ("id");
                if (ids != null) {
                    if (!ids.trim ().isEmpty ()) {
                        
                        int id = Integer.parseInt (ids);
                        Blogs blog = b_dao.getBlogByID (id);
                        List<Blogs> relesteBlog = b_dao.getRelatedBlogByID (blog.getBmiId (),acc.getId());
                        request.setAttribute ("blog", blog);
                        request.setAttribute ("relblog", relesteBlog);
                        request.getRequestDispatcher ("/Nutritionist/BlogDetail.jsp")
                                .forward (request, response);
                    }
                }
                Logger.getLogger ("Wrong");
            } catch (Exception e) {
                e.printStackTrace ();
            }
        }        
    }
    
    protected void dashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType ("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter ()) {
            HttpSession session = request.getSession (false);
            if (session == null || session.getAttribute ("Account") == null) {
                response.sendRedirect ("login.jsp");
                return;
            }
            String isJsonRequest = request.getParameter ("json");
            if ("true".equals (request.getParameter ("json"))) {
                handleBarChartJson (request, response, out);
                return;
            }            
            prepareDashboardData (request, response);
        } catch (Exception ex) {
            
        }
    }
    
    private void handleBarChartJson(HttpServletRequest request, HttpServletResponse response, PrintWriter out) throws IOException {
       
        HttpSession session = request.getSession (false);
            
        Account acc= (Account) session.getAttribute ("Account");
        int selectedYear = Year.now ().getValue ();
        String yearParam = request.getParameter ("year");
        if (yearParam != null && !yearParam.trim ().isEmpty ()) {
            try {
                selectedYear = Integer.parseInt (yearParam.trim ());
            } catch (NumberFormatException e) {
                response.sendError (HttpServletResponse.SC_BAD_REQUEST, "Invalid year");
                return;
            }
        }
        
        BlogDAO b_dao = new BlogDAO ();
        List<MonthlyStat> stats = b_dao.getMonthlyBlogStatsByYearAndAuthor (selectedYear, acc.getId ());
        
        List<String> labels = new ArrayList<> ();
        List<Integer> counts = new ArrayList<> ();
        for (MonthlyStat stat : stats) {
            labels.add (stat.getMonthlName ());
            counts.add (stat.getCount ());
        }
        
        Map<String, Object> jsonData = new HashMap<> ();
        jsonData.put ("labels", labels);
        jsonData.put ("counts", counts);
        
        response.setContentType ("application/json");
        response.setCharacterEncoding ("UTF-8");
        out.print (new Gson ().toJson (jsonData));
        out.flush ();
    }
    
    private void prepareDashboardData(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        Account acc = (Account) session.getAttribute ("Account");
        BMIClassificationDAO bi_dao = new BMIClassificationDAO ();
        RequestDAO r_dao = new RequestDAO ();
        BlogDAO b_dao = new BlogDAO ();
        NotifyDAO n_dao = new NotifyDAO ();
        FoodDraftDAO fd_dao = new FoodDraftDAO ();
        
        int totalFdrf = fd_dao.getTotalFooddraft (acc.getId ());
        int totalBlog = b_dao.getTotalBlogbyAuthor (acc.getId ());
        int totalNotify = n_dao.getTotalNotify (acc.getId (), null);
        int totalRequest = r_dao.getTotalRequest (acc.getId ());
        
        List<MonthlyStat> lstM = r_dao.countRequestsByStatus (acc.getId ());
        List<String> pieChart_data_lables = new ArrayList<> ();
        List<Integer> pieChart_data_totals = new ArrayList<> ();
        if(lstM == null || lstM.isEmpty ()){
            pieChart_data_lables.add("No data ");
            pieChart_data_totals.add (0);
        } else {
        for (MonthlyStat monthlyStat : lstM) {
            pieChart_data_lables.add (monthlyStat.getMonthlName ());
            pieChart_data_totals.add (monthlyStat.getCount ());
        }
        }
        int currentYear = Year.now ().getValue ();
        List<Integer> years = new ArrayList<> ();
        for (int y = 2024; y <= currentYear; y++) {
            years.add (y);
        }
        
        int selectedYear = currentYear;
        String text_years = request.getParameter ("year");
        if (text_years != null && !text_years.trim ().isEmpty ()) {
            selectedYear = Integer.parseInt (text_years.trim ());
        }
        
        List<String> barChart_data_lables = new ArrayList<> ();
        List<Integer> barChart_data_totals = new ArrayList<> ();
        List<MonthlyStat> lstMBlog = b_dao.getMonthlyBlogStatsByYearAndAuthor (selectedYear, -1);
        for (MonthlyStat monthlyStat : lstMBlog) {
            barChart_data_lables.add (monthlyStat.getMonthlName ());
            barChart_data_totals.add (monthlyStat.getCount ());
        }
        
        Gson gson = new Gson ();
        String pieChart_data_labelsJson = gson.toJson (pieChart_data_lables);
        String pieChart_data_totalsJson = gson.toJson (pieChart_data_totals);
        String barChart_data_lablesJson = gson.toJson (barChart_data_lables);
        String barChart_data_totalsJson = gson.toJson (barChart_data_totals);
        
        request.setAttribute ("years", years);
        request.setAttribute ("currentYear", currentYear);
        request.setAttribute ("selectedYear", selectedYear);
        request.setAttribute ("pieChart_data_labelsJson", pieChart_data_labelsJson);
        request.setAttribute ("pieChart_data_totalsJson", pieChart_data_totalsJson);
        request.setAttribute ("barChart_data_lablesJson", barChart_data_lablesJson);
        request.setAttribute ("barChart_data_totalsJson", barChart_data_totalsJson);
        request.setAttribute ("pieChart_data_lables", pieChart_data_lables);
        request.setAttribute ("pieChart_data_totals", pieChart_data_totals);
        request.setAttribute ("totalBlog", totalBlog);
        request.setAttribute ("totalFdrf", totalFdrf);
        request.setAttribute ("totalNotify", totalNotify);
        request.setAttribute ("totalRequest", totalRequest);
        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("years: " + request.getAttribute("years"));
        out.println("currentYear: " + request.getAttribute("currentYear"));
        out.println("selectedYear: " + request.getAttribute("selectedYear"));
        out.println("pieChart_data_labelsJson: " + request.getAttribute("pieChart_data_labelsJson"));
        out.println("pieChart_data_totalsJson: " + request.getAttribute("pieChart_data_totalsJson"));
        out.println("barChart_data_lablesJson: " + request.getAttribute("barChart_data_lablesJson"));
        out.println("barChart_data_totalsJson: " + request.getAttribute("barChart_data_totalsJson"));
        out.println("pieChart_data_lables: " + request.getAttribute("pieChart_data_lables"));
        out.println("pieChart_data_totals: " + request.getAttribute("pieChart_data_totals"));
        out.println("totalBlog: " + request.getAttribute("totalBlog"));
        out.println("totalFdrf: " + request.getAttribute("totalFdrf"));
        out.println("totalNotify: " + request.getAttribute("totalNotify"));
        out.println("totalRequest: " + request.getAttribute("totalRequest"));
        request.getRequestDispatcher ("/Nutritionist/DashBoard.jsp").forward (request, response);
    }

    
    private void handleJsonRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        BlogDAO _dao = new BlogDAO ();
        HttpSession session = request.getSession (false);
        Account acc = (Account) session.getAttribute ("Account");
        String input_search = request.getParameter ("input_search");
        String status = request.getParameter ("status");
        int indexPage = 1;
        if (request.getParameter ("index") != null) {
            indexPage = Integer.parseInt (request.getParameter ("index"));
        }
        int pageSize = 10;
//        if (request.getParameter ("pageSize") != null && !request.getParameter ("pageSize").trim ().isEmpty ()) {
//            pageSize = Integer.parseInt (request.getParameter ("pageSize"));
//        }
        String typeBmiParam = request.getParameter ("typebmi");
        int typeBmiId = -1;
        if (typeBmiParam != null && !typeBmiParam.isEmpty ()) {
            try {
                typeBmiId = Integer.parseInt (typeBmiParam);
            } catch (NumberFormatException e) {
                typeBmiId = -1;
            }
        }
        List<Blogs> lstB = _dao.getBlogsByFilterAndPage (input_search, typeBmiId, true, status, indexPage, pageSize,acc.getId ());
        int totalBlog = _dao.getToatalBlogsByFilter (input_search, typeBmiId, true, status,acc.getId ());
        int totalPages = 1;
        if (totalBlog > 7) {
            totalPages = (totalBlog / 10) + (totalBlog % 10 == 0 ? 0 : 1);
        }
        // Chuẩn bị map để trả json nhiều dữ liệu
        Map<String, Object> jsonData = new HashMap<> ();
        jsonData.put ("blogs", lstB);
        jsonData.put ("totalPages", totalPages);
        jsonData.put ("totalSize", totalBlog);
        jsonData.put ("currentSize", lstB.size ());
        
        Map<String, String> filters = new HashMap<> ();
        filters.put ("input_search", input_search == null ? "" : input_search);
        filters.put ("status", status == null ? "all" : status);
        jsonData.put ("filters", filters);
        jsonData.put ("currentPage", indexPage);
        
        response.setContentType ("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter ();
        
        com.google.gson.Gson gson = new com.google.gson.Gson ();
        String json = gson.toJson (jsonData);
        
        out.print (json);
        out.flush ();
    }
    
    private void handleNormalRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        HttpSession session = request.getSession (false);
        Account acc = (Account) session.getAttribute ("Account");
        BlogDAO _dao = new BlogDAO ();
        int indexPage = 1;
        int pageSize = 10;
        String typeBmiParam = request.getParameter ("typebmi");
        int typeBmiId = -1;
        if (typeBmiParam != null && !typeBmiParam.isEmpty ()) {
            try {
                typeBmiId = Integer.parseInt (typeBmiParam);
            } catch (NumberFormatException e) {
                typeBmiId = -1;
            }
        }
        BMIClassificationDAO bi_dao = new BMIClassificationDAO ();
        List<BMIClassification> lstBMI = bi_dao.getAllBMI ();
        List<String> statusList = _dao.getAllDistinctStatuses ();
        List<Blogs> lstB = _dao.getBlogsByFilterAndPage (null, typeBmiId, true, null, indexPage, pageSize,acc.getId());
        int totalBlog = _dao.getTotalBlogbyAuthor (acc.getId ());
        int totalPages = 1;
        if (totalBlog > 10) {
            totalPages = (totalBlog / 10) + 1;
        }
        request.setAttribute ("lstBMItype", lstBMI);
        request.setAttribute ("currentPage", indexPage);
        request.setAttribute ("totalPages", totalPages);
        request.setAttribute ("totalBlog", totalBlog);
        request.setAttribute ("lstB", lstB);
        request.setAttribute ("statusList", statusList);
        request.getRequestDispatcher ("/Nutritionist/BlogPages.jsp").forward (request, response);
    }
    
}
