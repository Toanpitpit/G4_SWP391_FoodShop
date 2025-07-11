/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.example.servlet.controller.Nutritionist;

import com.example.servlet.dao.BMIClassificationDAO;
import com.example.servlet.dao.BMI_RecommentdationDAO;
import com.example.servlet.dao.BlogDAO;
import com.example.servlet.dao.CategoryDAO;
import com.example.servlet.dao.FoodDAO;
import com.example.servlet.dao.FoodDetailDAO;
import com.example.servlet.dao.FoodDraftDAO;
import com.example.servlet.dao.NotifyDAO;
import com.example.servlet.dao.RequestDAO;
import com.example.servlet.model.Account;
import com.example.servlet.model.BMIClassification;
import com.example.servlet.model.Blogs;
import com.example.servlet.model.Category;
import com.example.servlet.model.Food;
import com.example.servlet.model.FoodDetail;
import com.example.servlet.model.FoodDraftDTO;
import com.example.servlet.model.Food_Draft;
import com.example.servlet.model.MonthlyStat;
import com.example.servlet.model.Requests;
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
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import org.jsoup.Jsoup;

/**
 *
 * @author Admin
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10
)
public class NutritionistControlServerLet extends HttpServlet {

    private static final String BASE_PATH = "D:\\Semester 5\\SWP391\\Project\\G4_SWP391_FoodShop_Project";
    private static final String UPLOAD_DIRECTORY = BASE_PATH + "\\src\\main\\webapp\\img\\blog";
    private static final String TAGET_DIRECTORY = BASE_PATH + "\\target\\Food-1.0-SNAPSHOT\\img\\blog";
    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesssion = request.getSession (false);
        if (sesssion == null) {

            request.getRequestDispatcher ("Homedemo.jsp").forward (request, response);
            return;
        }
        String action = request.getParameter ("action");

        if (action == null) {
            response.sendRedirect ("Homedemo.jsp");
            return;
        }

        switch (action) {
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
            case "displayBMI":
                handleBMISearrch (request, response);
                break;
            case "showBMI":
                prepareBMIdata (request, response);
                break;
            case "showfood":
                ShowFood (request, response);
                break;
            case "showfooddraft":
                ShowFoodDraft (request, response);
                break;
            case "displaysortfood":
                ShowFoodSortFilter (request, response);
                break;
            case "displaysortfooddraft":
                ShowFoodDraftSortFilter (request, response);
                break;
            case "showfooddetail":
                ShowFoodDetail (request, response);
                break;
            case "copyfood":
                CopyFood (request, response);
                break;
            case "showcreatefooddraft":
                ShowCreateFoodDraft (request, response);
                break;
            case "createfooddraft":
                CreateFoodDraft (request, response);
                break;
            case "showfooddraftdetail":
                ShowFoodDraftDetail (request, response);
                break;
            case "showeditfooddraft":
                ShowUpdateFoodDraft (request, response);
                break;
            case "updatefooddraft":
                UpdateFoodDraft (request, response);
                break;
            case "deletefooddraft":
                deleteFoodDraft (request, response);
                break;
            case "showcategory":
                ShowCategoryList (request, response);
                break;
            case "displaysortcategory":
                ShowCategoryListSort (request, response);
                break;
            case "showEditCategory":
                ShowEditCategory (request, response);
                break;
            case "createCategory":
//                try(PrintWriter o = response.getWriter ()){
//                o.print ("oke");
//                }
                CreateCategory (request, response);
                break;
            case "updateCategory":
                UpdateCategory (request, response);
                break;
            case "deleteCategory":
                deleteCategory (request, response);
                break;
            case "showrequestlist":
                ShowRequestList (request, response);
                break;
            case "showrequestlistsort":
                ShowRequestListSort (request, response);
                break;
            case "showrequesdetail":
                ShowRequestDetail (request, response);
                break;
            case "showcreaterequest":
                ShowCreateRequest (request, response);
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
    }

    protected void createBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
        Part imagePart = request.getPart ("imageUrl");

        request.setAttribute ("title", title);
        request.setAttribute ("status", status);
        request.setAttribute ("content", content);
        if (bmiIdStr != null) {
            request.setAttribute ("selectedBmiId", Integer.parseInt (bmiIdStr));
        }
        String text = Jsoup.parse (content).text ();
        if (text.trim ().isEmpty ()) {
            request.setAttribute ("Errmess", "Vui lòng nhập đủ thông tin");
            DisplayCreateBlog (request, response);
            return;
        }
        if (isNotValidInput (title, content, bmiIdStr, status, imagePart)) {
            request.setAttribute ("Errmess", "Vui lòng chọn ảnh và nhập đủ thông tin");
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

        String imageUrl;
        try {
            imageUrl = processImageUpload (imagePart, "blog");
        } catch (IllegalStateException e) {
            request.setAttribute ("Errmess", "Ảnh vượt quá dung lượng cho phép (5MB).");
            DisplayCreateBlog (request, response);
            return;
        } catch (Exception e) {
            request.setAttribute ("Errmess", "Đã xảy ra lỗi khi tải ảnh.");
            DisplayCreateBlog (request, response);
            return;
        }

        Timestamp now = new Timestamp (System.currentTimeMillis ());
        Blogs blog = new Blogs (0, acc.getId (), acc.getUsername (), bmiId, title, imageUrl, content, status, now, now);
        BlogDAO blogDAO = new BlogDAO ();
        boolean success = blogDAO.insertBlog (blog);

        if (success) {
            session.setAttribute ("successMessage", "Tạo bài viết thành công.");
            DisplayBlog (request, response);
        } else {
            request.setAttribute ("Errmess", "Không thể tạo bài viết. Vui lòng thử lại.");
            DisplayCreateBlog (request, response);
        }
    }

    protected void update(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null || session.getAttribute ("Account") == null) {
            response.sendRedirect ("Homedemo.jsp");
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
        int id = Integer.parseInt (request.getParameter ("id"));
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

            if (imagePart == null || imagePart.getSize () == 0) {
                Blogs blog = blogDAO.getBlogByID (id);
                image_url = blog.getImageUlr ();
            } else {
                Part filePart = request.getPart ("imageUrl");
                String path = blogDAO.getPathBlogByID (id);
                String basePath = BASE_PATH + "/src/main/webapp/";
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
            request.setAttribute ("warningMessage", "Tổng dung lượng dữ liệu gửi lên vượt giới hạn 5MB.");
            DisplayCreateBlog (request, response);
            return;
        } catch (Exception e) {
            e.printStackTrace ();
            request.setAttribute ("Errmess", "Đã xảy ra lỗi khi tải ảnh.");
            DisplayCreateBlog (request, response);
            return;
        }

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
            HttpSession session = request.getSession (false);
            if (session == null || session.getAttribute ("Account") == null) {
                response.sendRedirect ("Homedemo.jsp");
                return;
            }
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
            Logger.getLogger (NutritionistControlServerLet.class.getName ()).log (Level.SEVERE, null, ex);
        }

    }

    protected void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType ("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter ()) {
            HttpSession session = request.getSession (false);
            if (session == null) {
                response.sendRedirect ("Homedemo.jsp");
            }
            int id = 0;
            try {
                id = Integer.parseInt (request.getParameter ("id"));
            } catch (Exception e) {
                session.setAttribute ("Errmess", "Fail to get ID");
                return;
            }
            BlogDAO b_dao = new BlogDAO ();
            String path = b_dao.getPathBlogByID (id);
            String basePath = BASE_PATH + "/src/main/webapp/";
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

    private void DisplayBlog(HttpServletRequest request, HttpServletResponse response)
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

    private void displayBlogDetail(HttpServletRequest request, HttpServletResponse response)
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
            BMIClassificationDAO bi_dao = new BMIClassificationDAO ();
            try {
                String ids = request.getParameter ("id");
                if (ids != null) {
                    if (!ids.trim ().isEmpty ()) {

                        int id = Integer.parseInt (ids);

                        Blogs blog = b_dao.getBlogByID (id);
                        BMIClassification bmi = bi_dao.getBMIByID (blog.getBmiId ());

                        List<Blogs> relesteBlog = b_dao.getRelatedBlogByID (blog.getbID ());
                        List<BMIClassification> lstBMI = bi_dao.getAllBMI ();
                        request.setAttribute ("blog", blog);
                        request.setAttribute ("bmi", bmi);
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

    private void dashboard(HttpServletRequest request, HttpServletResponse response)
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
            ex.printStackTrace ();
            return;
        }
    }

    private void handleBarChartJson(HttpServletRequest request, HttpServletResponse response, PrintWriter out) throws IOException {

        HttpSession session = request.getSession (false);

        Account acc = (Account) session.getAttribute ("Account");
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
        try {
            HttpSession session = request.getSession (false);
            Account acc = (Account) session.getAttribute ("Account");
            BMIClassificationDAO bi_dao = new BMIClassificationDAO ();
            RequestDAO r_dao = new RequestDAO ();
            BlogDAO b_dao = new BlogDAO ();
            FoodDraftDAO fdr_dao = new FoodDraftDAO ();
            NotifyDAO n_dao = new NotifyDAO ();
            FoodDraftDAO fd_dao = new FoodDraftDAO ();
            int totalFoodDraft = fdr_dao.getTotalFoodDraftsByAuthor (acc.getId ()).size ();
            int totalBlog = b_dao.getTotalBlogbyAuthor (acc.getId ());
            int totalNotify = n_dao.getTotalNotify (acc.getId (), null);
            int totalRequest = r_dao.getTotalRequest (acc.getId ());
            List<MonthlyStat> lstM = r_dao.countRequestsByStatus (acc.getId ());
            List<String> pieChart_data_lables = new ArrayList<> ();
            List<Integer> pieChart_data_totals = new ArrayList<> ();
            if (lstM == null || lstM.isEmpty ()) {
                pieChart_data_lables.add ("No data ");
                pieChart_data_totals.add (1);
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
            request.setAttribute ("barChart_data_labelsJson", barChart_data_lablesJson);
            request.setAttribute ("barChart_data_totalsJson", barChart_data_totalsJson);
            request.setAttribute ("pieChart_data_labels", pieChart_data_lables);
            request.setAttribute ("pieChart_data_totals", pieChart_data_totals);
            request.setAttribute ("totalBlog", totalBlog);

            request.setAttribute ("totalNotify", totalNotify);
            request.setAttribute ("totalFdrf", totalFoodDraft);
            request.setAttribute ("totalRequest", totalRequest);
            request.getRequestDispatcher ("/Nutritionist/DashBoard.jsp").forward (request, response);
        } catch (SQLException ex) {
            Logger.getLogger (NutritionistControlServerLet.class.getName ()).log (Level.SEVERE, null, ex);
        }
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
        List<Blogs> lstB = _dao.getBlogsByFilterAndPage (input_search, typeBmiId, true, status, indexPage, pageSize, acc.getId ());
        int totalBlog = _dao.getToatalBlogsByFilter (input_search, typeBmiId, true, status, acc.getId ());
        int totalPages = 1;
        if (totalBlog > 10) {
            totalPages = (totalBlog / 10) + (totalBlog % 10 == 0 ? 0 : 1);
        }

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
        List<Blogs> lstB = _dao.getBlogsByFilterAndPage (null, typeBmiId, true, null, indexPage, pageSize, acc.getId ());
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

    private void prepareBMIdata(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession (false);
        Account acc = (Account) session.getAttribute ("Account");
        int page = 1;
        int limit = 5;
        int offset = (page - 1) * limit;

        try {
            BMIClassificationDAO dao = new BMIClassificationDAO ();
            List<BMIClassification> lstBMI = dao.getBMIWithPagination (offset, limit);
            int totalCount = dao.countAllBMI ();
            request.setAttribute ("totalCount", totalCount);
            int totalPages = (int) Math.ceil ((double) totalCount / limit);
            request.setAttribute ("lstBMI", lstBMI);
            request.setAttribute ("currentPage", page);
            request.setAttribute ("totalPages", totalPages);
            request.getRequestDispatcher ("/Nutritionist/BMIPage.jsp").forward (request, response);
        } catch (Exception e) {
            e.printStackTrace ();
        }
    }

    protected void handleBMISearrch(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession (false);
            Account acc = (Account) session.getAttribute ("Account");

            String input_search = request.getParameter ("search");
            String sortTarget = request.getParameter ("sortOrderTarget");
            String sortId = request.getParameter ("sortOrderID");

            int page = Integer.parseInt (request.getParameter ("page"));
            int limit = Integer.parseInt (request.getParameter ("limitpage"));
            int offset = (page - 1) * limit;

            BMIClassificationDAO dao = new BMIClassificationDAO ();
            List<BMIClassification> lstBMI = dao.getBMIWithFilterAndSort (input_search, sortId, sortTarget, offset, limit);
            int totalBMI = dao.gettotalBMIWithFilterAndSort (input_search, sortId, sortTarget);
            int totalPages = (int) Math.ceil ((double) totalBMI / limit);

            request.setAttribute ("lstBMI", lstBMI);
            request.setAttribute ("totalPages", totalPages);
            request.setAttribute ("totalSize", totalBMI);
            request.setAttribute ("currentSize", lstBMI.size ());
            request.setAttribute ("currentPage", page);
            request.setAttribute ("limitpage", limit);

            request.setAttribute ("search", input_search == null ? "" : input_search);
            request.setAttribute ("sortOrderTarget", sortTarget == null ? "" : sortTarget);
            request.setAttribute ("sortOrderID", sortId == null ? "" : sortId);

            request.getRequestDispatcher ("/Nutritionist/BMIPage.jsp").forward (request, response);
        } catch (Exception ex) {
            ex.printStackTrace ();
            request.setAttribute ("error", "Đã xảy ra lỗi khi tải dữ liệu.");
            request.getRequestDispatcher ("/Nutritionist/BMIPage.jsp").forward (request, response);
        }
    }

    protected void ShowFood(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String Errmess = request.getParameter ("Errmess");
            String successMessage = request.getParameter ("successMessage");

            CategoryDAO c_dao = new CategoryDAO ();
            FoodDAO dao = new FoodDAO ();
            BMIClassificationDAO bidao = new BMIClassificationDAO ();
            List<BMIClassification> lstBMI = bidao.getAllBMI ();
            int pageSize = 8;
            int currentPage = 1;
            List<Category> lstC = c_dao.getListCategoriesNoP (null, null, null);
            List<Food> lstF = dao.getListFoods (null, null, null, null, null, null, null, currentPage, pageSize);
            int totalFood = dao.getListFoodsTotal (null, null, null, null, null, null, null);
            int totalPages = (int) Math.ceil ((double) totalFood / pageSize);

            if (Errmess != null && !Errmess.trim ().isEmpty ()) {
                request.setAttribute ("Errmess", Errmess);
            }
            if (successMessage != null && !successMessage.trim ().isBlank ()) {
                request.setAttribute ("successMessage", successMessage);
            }
            request.setAttribute ("lstBMI", lstBMI);
            request.setAttribute ("lstFood", lstF);
            request.setAttribute ("lstC", lstC);
            request.setAttribute ("totalFood", totalFood);
            request.setAttribute ("totalPages", totalPages);
            request.setAttribute ("currentPage", currentPage);

            request.getRequestDispatcher ("/Nutritionist/FoodList.jsp").forward (request, response);
        } catch (SQLException e) {
            e.printStackTrace ();
        }

    }

    protected void ShowFoodSortFilter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FoodDAO dao = new FoodDAO ();
        CategoryDAO c_dao = new CategoryDAO ();
        try {
            String searchKey = request.getParameter ("searchKey");
            String category = request.getParameter ("category");
            String status = request.getParameter ("status");
            String searchPrice = request.getParameter ("searchPrice");
            String priceRank = request.getParameter ("priceRank");
            String bmiId = request.getParameter ("bmiId");

            Map<String, String> sortFields = new HashMap<> ();
            String sortPrice = request.getParameter ("sortPrice");
            String sortTime = request.getParameter ("sortTime");
            String sortID = request.getParameter ("sortID");

            if (sortID != null && !sortID.isEmpty ()) {
                sortFields.put ("sortID", sortID);
            }
            if (sortPrice != null && !sortPrice.isEmpty ()) {
                sortFields.put ("sortPrice", sortPrice);
            }
            if (sortTime != null && !sortTime.isEmpty ()) {
                sortFields.put ("sortTime", sortTime);
            }

            int pageSize = 8;
            int currentPage = 1;
            String pageParam = request.getParameter ("page");
            if (pageParam != null && !pageParam.isEmpty ()) {
                try {
                    currentPage = Integer.parseInt (pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            int totalFoods = dao.getListFoodsTotal (
                    searchKey, category, status, searchPrice, priceRank, bmiId, sortFields
            );
            List<Food> lstFood = new ArrayList<> ();
            if (totalFoods > pageSize * (currentPage - 1)) {
                lstFood = dao.getListFoods (
                        searchKey,
                        category,
                        status,
                        searchPrice,
                        priceRank,
                        bmiId,
                        sortFields,
                        currentPage,
                        pageSize
                );
                request.setAttribute ("currentPage", currentPage);
            } else {
                lstFood = dao.getListFoods (
                        searchKey,
                        category,
                        status,
                        searchPrice,
                        priceRank,
                        bmiId,
                        sortFields,
                        1,
                        pageSize
                );
                request.setAttribute ("currentPage", "1");
            }

            int totalPages = (int) Math.ceil ((double) totalFoods / pageSize);
            List<Category> lstC = c_dao.getListCategoriesNoP (null, null, null);
            BMIClassificationDAO bidao = new BMIClassificationDAO ();
            List<BMIClassification> lstBMI = bidao.getAllBMI ();
            request.setAttribute ("lstBMI", lstBMI);
            request.setAttribute ("lstC", lstC);
            request.setAttribute ("lstFood", lstFood);
            request.setAttribute ("totalFood", totalFoods);
            request.setAttribute ("totalPages", totalPages);

            request.getRequestDispatcher ("/Nutritionist/FoodList.jsp").forward (request, response);

        } catch (Exception e) {
            e.printStackTrace ();
            request.setAttribute ("error", "Lỗi khi xử lý danh sách món ăn: " + e.getMessage ());
            request.getRequestDispatcher ("error.jsp").forward (request, response);
        }
    }

    protected void ShowFoodDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            FoodDAO dao = new FoodDAO ();
            FoodDetailDAO fd_dao = new FoodDetailDAO ();

            String idtxt = request.getParameter ("id");
            int fID = Integer.parseInt (idtxt);

            Food food = dao.getFoodById (fID);
            FoodDetail fooddetail = fd_dao.getFoodDetailByIdAndDraft (fID, false);
            List<BMIClassification> tagetaudience = fd_dao.getBMIClassificationsByFoodOrDraftId (fID, false);

            if (food == null) {
                response.sendError (HttpServletResponse.SC_NOT_FOUND, "Food not found");
                return;
            }

            request.setAttribute ("id", fID);
            request.setAttribute ("food", food);
            request.setAttribute ("fooddetail", fooddetail);
            request.setAttribute ("tagetaudience", tagetaudience);

            request.getRequestDispatcher ("/Nutritionist/FoodDetail.jsp").forward (request, response);
        } catch (NumberFormatException e) {
            response.sendError (HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
        } catch (Exception e) {
            e.printStackTrace ();
            response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error: " + e.getMessage ());
        }
    }

    protected void ShowFoodDraft(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession (false);
            if (session == null) {
                response.sendRedirect ("/Nutritionist/Homedemo.jsp");
                return;
            }

            if (request.getParameter ("Errmess") != null) {
                request.setAttribute ("Errmess", request.getParameter ("Errmess"));
            }
            if (request.getParameter ("successMessage") != null) {
                request.setAttribute ("successMessage", request.getParameter ("successMessage"));
            }
            Account acc = (Account) session.getAttribute ("Account");
            CategoryDAO c_dao = new CategoryDAO ();
            BMIClassificationDAO bidao = new BMIClassificationDAO ();
            List<BMIClassification> lstBMI = bidao.getAllBMI ();
            int pageSize = 8;
            int currentPage = 1;
            String idtxt = String.valueOf (acc.getId ());
            Map<String, String> filters = new HashMap<> ();
            filters.put ("searchKey", "");
            filters.put ("category", "");
            filters.put ("status", "");
            filters.put ("searchPrice", "");
            filters.put ("priceRank", "");
            filters.put ("bmiId", "");
            filters.put ("authorId", idtxt);

            Map<String, String> sortAndPagination = new HashMap<> ();
            sortAndPagination.put ("sortprice", "desc");
            sortAndPagination.put ("sorttime", "asc");
            sortAndPagination.put ("page", "1");
            sortAndPagination.put ("pageSize", "8");

            FoodDraftDAO dao = new FoodDraftDAO ();
            List<Category> lstC = c_dao.getListCategoriesNoP (null, null, null);
            List<Food_Draft> lstFdr = dao.getListFoodDrafts (filters, sortAndPagination);
            int total = dao.getListFoodDraftsTotal (filters, sortAndPagination);
            int totalPages = (int) Math.ceil ((double) total / 8);
            request.setAttribute ("lstBMI", lstBMI);
            request.setAttribute ("lstFoodDr", lstFdr);
            request.setAttribute ("lstC", lstC);
            request.setAttribute ("totalPages", totalPages);
            request.setAttribute ("total", total);
            request.setAttribute ("currentPage", currentPage);
            request.getRequestDispatcher ("/Nutritionist/FoodSuggestion.jsp").forward (request, response);
        } catch (SQLException e) {
            e.printStackTrace ();
        }

    }

    protected void ShowFoodDraftSortFilter(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FoodDraftDAO dao = new FoodDraftDAO ();
        CategoryDAO c_dao = new CategoryDAO ();
        try {
            String searchKey = request.getParameter ("searchKey");
            String category = request.getParameter ("category");
            String status = request.getParameter ("status");
            String searchPrice = request.getParameter ("searchPrice");
            String priceRank = request.getParameter ("priceRank");
            String bmiId = request.getParameter ("bmiId");
            Map<String, String> filters = new HashMap<> ();
            if (searchKey != null && !searchKey.isEmpty ()) {
                filters.put ("searchKey", searchKey);
            }
            if (category != null && !category.isEmpty ()) {
                filters.put ("category", category);
            }
            if (status != null && !status.isEmpty ()) {
                filters.put ("status", status);
            }
            if (searchPrice != null && !searchPrice.isEmpty ()) {
                filters.put ("searchPrice", searchPrice);
            }
            if (priceRank != null && !priceRank.isEmpty ()) {
                filters.put ("priceRank", priceRank);
            }
            if (bmiId != null && !bmiId.isEmpty ()) {
                filters.put ("bmiId", bmiId);
            }
            Map<String, String> sortAndPagination = new HashMap<> ();
            String sortPrice = request.getParameter ("sortPrice");
            String sortTime = request.getParameter ("sortTime");
            String sortID = request.getParameter ("sortID");

            if (sortID != null && !sortID.isEmpty ()) {
                sortAndPagination.put ("sortID", sortID);
            }
            if (sortPrice != null && !sortPrice.isEmpty ()) {
                sortAndPagination.put ("sortPrice", sortPrice);
            }
            if (sortTime != null && !sortTime.isEmpty ()) {
                sortAndPagination.put ("sortTime", sortTime);
            }

            int pageSize = 8;
            int currentPage = 1;
            String pageParam = request.getParameter ("page");
            if (pageParam != null && !pageParam.isEmpty ()) {
                try {
                    currentPage = Integer.parseInt (pageParam);
                    sortAndPagination.put ("page", pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }

            List<Food_Draft> lstFdr = new ArrayList<> ();
            int total = dao.getListFoodDraftsTotal (filters, sortAndPagination);
            if (total > pageSize * (currentPage - 1)) {
                sortAndPagination.put ("page", pageParam);
                lstFdr = dao.getListFoodDrafts (filters, sortAndPagination);
                request.setAttribute ("currentPage", currentPage);
            } else {
                sortAndPagination.put ("page", "1");
                lstFdr = dao.getListFoodDrafts (filters, sortAndPagination);
                request.setAttribute ("currentPage", "1");
            }
            int totalPages = (int) Math.ceil ((double) total / pageSize);
            List<Category> lstC = c_dao.getListCategoriesNoP (null, null, null);
            BMIClassificationDAO bidao = new BMIClassificationDAO ();
            List<BMIClassification> lstBMI = bidao.getAllBMI ();
            request.setAttribute ("lstBMI", lstBMI);
            request.setAttribute ("lstC", lstC);
            request.setAttribute ("lstFoodDr", lstFdr);
            request.setAttribute ("total", total);
            request.setAttribute ("totalPages", totalPages);

            request.getRequestDispatcher ("/Nutritionist/FoodSuggestion.jsp").forward (request, response);

        } catch (Exception e) {
            e.printStackTrace ();
            request.setAttribute ("error", "Lỗi khi xử lý danh sách món ăn: " + e.getMessage ());
            request.getRequestDispatcher ("error.jsp").forward (request, response);
        }
    }

    protected void CopyFood(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FoodDraftDAO dao = new FoodDraftDAO ();
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        } else {
            Account acc = (Account) session.getAttribute ("Account");
            try {
                String orgIDtxt = request.getParameter ("id");
                if (orgIDtxt != null && !orgIDtxt.trim ().isEmpty ()) {
                    int orgID = Integer.parseInt (orgIDtxt);
                    int authodID = acc.getId ();
                    int check = dao.copyFoodToDraft (orgID, authodID);
                    if (check == -1) {
                        String ErrMess = "Có lỗi trong quá trình copy vui lòng thử lại";
                        request.setAttribute ("Errmess", ErrMess);
                        ShowFood (request, response);
                    }
                    String successMessage = "Copy Sucessfuly draftID is : " + check;
                    request.setAttribute ("successMessage", successMessage);
                    ShowFood (request, response);
                } else {
                    String ErrMess = "Server canot get full ìnomation about authod angd food . Try again!";
                    request.setAttribute ("Errmess", ErrMess);
                    ShowFood (request, response);
                }

            } catch (Exception e) {
                e.printStackTrace ();
                request.setAttribute ("Errmess", "Lỗi hệ thống xin vui lòng thử lại");
                ShowFood (request, response);
            }
        }
    }

    protected void ShowCreateFoodDraft(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        } else {
            try {
                CategoryDAO c_dao = new CategoryDAO ();
                BMIClassificationDAO bi_dao = new BMIClassificationDAO ();
                List<Category> lstC = c_dao.getListCategoriesNoP (null, null, null);
                List<BMIClassification> lstBMI = bi_dao.getAllBMI ();
                if (lstC != null && lstBMI != null) {
                    request.setAttribute ("lstC", lstC);
                    request.setAttribute ("lstBMI", lstBMI);
                    request.getRequestDispatcher ("/Nutritionist/CreateFoodDraft.jsp").forward (request, response);
                } else {
                    request.setAttribute ("Ermessr", "Lỗi tai dữ liệu");
                    request.getRequestDispatcher ("/Nutritionist/CreateFoodDraft.jsp").forward (request, response);
                }
            } catch (Exception e) {
                request.setAttribute ("Ermessr", "Lỗi");
                request.getRequestDispatcher ("/Nutritionist/CreateFoodDraft.jsp").forward (request, response);
            }
        }
    }

    protected void CreateFoodDraft(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FoodDraftDAO dao = new FoodDraftDAO ();
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        } else {
            Account acc = (Account) session.getAttribute ("Account");
            try {
                String name = request.getParameter ("name");
                String pricetxt = request.getParameter ("price");
                String categorytxt = request.getParameter ("category");
                String description = request.getParameter ("description");
                String ingredients = request.getParameter ("ingredients");
                String[] bmiValues = request.getParameterValues ("bmi");
                String bmiString;
                if (bmiValues == null || bmiValues.length == 0) {
                    bmiString = "7";
                } else if (bmiValues.length == 1) {
                    bmiString = bmiValues[0];
                } else {
                    bmiString = String.join (",", bmiValues);
                }

                Part imagePart = request.getPart ("image");
                double price = 0;
                int category = 0;

                if (name == null || name.trim ().isEmpty ()) {
                    request.setAttribute ("Errmess", "Name Food cannot be empty");
                    ShowCreateFoodDraft (request, response);
                    return;
                }

                try {
                    if (pricetxt == null || pricetxt.trim ().isEmpty ()) {
                        request.setAttribute ("Errmess", "Price cannot be empty");
                        ShowCreateFoodDraft (request, response);
                        return;
                    } else {
                        price = Double.parseDouble (pricetxt);
                    }
                    if (categorytxt == null || categorytxt.trim ().isEmpty ()) {
                        request.setAttribute ("Errmess", "Category cannot be null");
                        ShowCreateFoodDraft (request, response);
                        return;
                    } else {
                        category = Integer.parseInt (categorytxt);
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute ("Errmess", "Wrong type price or category");
                    ShowCreateFoodDraft (request, response);
                    return;
                }

                if (isCKEditorContentEmpty (description)) {
                    request.setAttribute ("Errmess", "Description cannot be null");
                    ShowCreateFoodDraft (request, response);
                    return;
                }

                if (isCKEditorContentEmpty (ingredients)) {
                    request.setAttribute ("Errmess", "Ingredients cannot be null");
                    ShowCreateFoodDraft (request, response);
                    return;
                }

                String imageUrl;
                try {
                    imageUrl = processImageUpload (imagePart, "fooddraft");
                } catch (IllegalStateException e) {
                    request.setAttribute ("Errmess", "Ảnh vượt quá dung lượng cho phép (5MB).");
                    ShowCreateFoodDraft (request, response);
                    return;
                } catch (Exception e) {
                    System.err.println ("Image upload error: " + e.getMessage ());
                    e.printStackTrace ();
                    request.setAttribute ("Errmess", "Đã xảy ra lỗi khi tải ảnh: " + e.getMessage ());
                    ShowCreateFoodDraft (request, response);
                    return;
                }

                FoodDraftDTO fdrDto = new FoodDraftDTO ();
                fdrDto.setName (name);
                fdrDto.setAuthorId (acc.getId ());
                fdrDto.setCategoryId (category);
                fdrDto.setDescription (description);
                fdrDto.setIngredients (ingredients);
                fdrDto.setBmiIds (bmiString);
                fdrDto.setStatus ("DRAFT");
                fdrDto.setImagePath (imageUrl);
                fdrDto.setPrice (price);
                fdrDto.setOriginId (null);

                boolean check = dao.createFoodDraft (fdrDto);
                if (check) {
                    request.setAttribute ("successMessage", "Create Successfully!");
                    ShowFoodDraft (request, response);
                } else {
                    request.setAttribute ("Errmess", "Create Failed, try again!");
                    ShowCreateFoodDraft (request, response);
                }

            } catch (Exception e) {
                e.printStackTrace ();
                request.setAttribute ("Errmess", "An unexpected error occurred");
                ShowCreateFoodDraft (request, response);
            }
        }
    }

    protected void ShowFoodDraftDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        } else {
            Account acc = (Account) session.getAttribute ("Account");
            try {
                FoodDraftDAO dao = new FoodDraftDAO ();
                FoodDetailDAO fd_dao = new FoodDetailDAO ();

                String idtxt = request.getParameter ("id");
                int fID = Integer.parseInt (idtxt);

                Food_Draft food = dao.getFoodDraftById (fID, acc.getId ());
                FoodDetail fooddetail = fd_dao.getFoodDetailByIdAndDraft (fID, true);
                List<BMIClassification> tagetaudience = fd_dao.getBMIClassificationsByFoodOrDraftId (fID, true);

                if (food == null) {
                    request.setAttribute ("Errmess", "Fail to colect Food items");
                    ShowFoodDraft (request, response);
                    return;
                }

                request.setAttribute ("food", food);
                request.setAttribute ("fooddetail", fooddetail);
                request.setAttribute ("tagetaudience", tagetaudience);

                request.getRequestDispatcher ("/Nutritionist/FoodDraftDetail.jsp").forward (request, response);
            } catch (NumberFormatException e) {
                response.sendError (HttpServletResponse.SC_BAD_REQUEST, "Invalid ID format");
            } catch (Exception e) {
                e.printStackTrace ();
                response.sendError (HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error: " + e.getMessage ());
            }
        }
    }

    protected void ShowUpdateFoodDraft(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FoodDraftDAO dao = new FoodDraftDAO ();
        FoodDetailDAO fd_dao = new FoodDetailDAO ();
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        } else {
            Account acc = (Account) session.getAttribute ("Account");
            try {
                String fdrID = request.getParameter ("id");
                int id = -1;
                try {
                    id = Integer.parseInt (fdrID);
                } catch (NumberFormatException e) {
                    request.setAttribute ("Ermessr", "Lỗi không nhận được ID chỉnh sửa");
                    request.getRequestDispatcher ("/Nutritionist/FoodSuggesstion.jsp").forward (request, response);
                    return;
                }

                Food_Draft food = dao.getFoodDraftById (id, acc.getId ());
                FoodDetail fooddetail = fd_dao.getFoodDetailByIdAndDraft (id, true);
                request.setAttribute ("fooddraftedit", food);
                request.setAttribute ("fooddetail", fooddetail);
                CategoryDAO c_dao = new CategoryDAO ();

                BMIClassificationDAO bi_dao = new BMIClassificationDAO ();
                List<Category> lstC = c_dao.getListCategoriesNoP (null, null, null);
                List<BMIClassification> lstBMI = bi_dao.getAllBMI ();
                List<BMIClassification> lstbmiRe = fd_dao.getBMIClassificationsByFoodOrDraftId (id, true);

                Map<Integer, Boolean> selectedBmiMap = lstbmiRe.stream ()
                        .collect (Collectors.toMap (BMIClassification::getBmiID, b -> true));
                request.setAttribute ("selectedBmiMap", selectedBmiMap);
                if (lstC != null && lstBMI != null) {
                    request.setAttribute ("lstC", lstC);
                    request.setAttribute ("lstBMI", lstBMI);
                    request.getRequestDispatcher ("/Nutritionist/CreateFoodDraft.jsp").forward (request, response);
                } else {

                    request.setAttribute ("Ermessr", "Fail to loading data");
                    request.getRequestDispatcher ("/Nutritionist/CreateFoodDraft.jsp").forward (request, response);
                }
            } catch (Exception e) {
                request.setAttribute ("Ermessr", "Wrong!!");
                request.getRequestDispatcher ("/Nutritionist/CreateFoodDraft.jsp").forward (request, response);
            }
        }
    }

    protected void UpdateFoodDraft(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Logger logger = Logger.getLogger (this.getClass ().getName ());
        FoodDraftDAO dao = new FoodDraftDAO ();
        HttpSession session = request.getSession (false);

        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        }

        Account acc = (Account) session.getAttribute ("Account");
        try {
            String name = request.getParameter ("name");
            String pricetxt = request.getParameter ("price");
            String categorytxt = request.getParameter ("category");
            String description = request.getParameter ("description");
            String ingredients = request.getParameter ("ingredients");
            String[] bmiValues = request.getParameterValues ("bmi");
            String fdrIDtxt = request.getParameter ("id");

            String bmiString;
            if (bmiValues == null || bmiValues.length == 0) {
                bmiString = "7";
            } else if (bmiValues.length == 1) {
                bmiString = bmiValues[0];
            } else {
                bmiString = String.join (",", bmiValues);
            }

            Part imagePart = request.getPart ("image");
            double price = 0;
            int category = 0;
            int fdrID = 0;

            if (name == null || name.trim ().isEmpty ()) {
                request.setAttribute ("Errmess", "Name Food cannot be empty");
                ShowUpdateFoodDraft (request, response);
                return;
            }

            try {
                if (pricetxt == null || pricetxt.trim ().isEmpty ()) {
                    request.setAttribute ("Errmess", "Price cannot be empty");
                    ShowUpdateFoodDraft (request, response);
                    return;
                } else {
                    price = Double.parseDouble (pricetxt);
                    if (price < 0) {
                        request.setAttribute ("Errmess", "Price must be non-negative");
                        ShowUpdateFoodDraft (request, response);
                        return;
                    }
                }
            } catch (NumberFormatException e) {
                request.setAttribute ("Errmess", "Invalid price format");
                ShowUpdateFoodDraft (request, response);
                return;
            }
            try {
                if (categorytxt == null || categorytxt.trim ().isEmpty ()) {
                    request.setAttribute ("Errmess", "Category cannot be null");
                    ShowUpdateFoodDraft (request, response);
                    return;
                } else {
                    category = Integer.parseInt (categorytxt);
                }
            } catch (NumberFormatException e) {
                request.setAttribute ("Errmess", "Invalid category format");
                ShowUpdateFoodDraft (request, response);
                return;
            }

            try {
                if (fdrIDtxt == null || fdrIDtxt.trim ().isEmpty ()) {
                    request.setAttribute ("Errmess", "Food draft ID is required");
                    ShowUpdateFoodDraft (request, response);
                    return;
                }
                fdrID = Integer.parseInt (fdrIDtxt);
            } catch (NumberFormatException e) {
                request.setAttribute ("Errmess", "Can't collected id");
                ShowUpdateFoodDraft (request, response);
                return;
            }

            if (isCKEditorContentEmpty (description)) {
                request.setAttribute ("Errmess", "Description cannot be null");
                ShowUpdateFoodDraft (request, response);
                return;
            }

            if (isCKEditorContentEmpty (ingredients)) {
                request.setAttribute ("Errmess", "Ingredients cannot be null");
                ShowUpdateFoodDraft (request, response);
                return;
            }

            String imageUrl = null;
            String oldImagePath = null;

            try {
                Food_Draft existingDraft = dao.getFoodDraftById (fdrID, acc.getId ());
                if (existingDraft != null) {
                    oldImagePath = existingDraft.getImageUlr ();
                }

                if (imagePart != null && imagePart.getSize () > 0) {
                    if (oldImagePath != null && !oldImagePath.isEmpty ()) {
                        boolean deleteSuccess = deleteOldImage (oldImagePath);
                        if (!deleteSuccess) {
                            logger.warning ("Failed to delete old image: " + oldImagePath + ", but continuing with update");
                        }
                    }
                    imageUrl = processImageUpload (imagePart, "fooddraft");

                } else {
                    imageUrl = oldImagePath;
                }
            } catch (IllegalStateException e) {
                request.setAttribute ("Errmess", "Ảnh vượt quá dung lượng cho phép (5MB).");
                ShowUpdateFoodDraft (request, response);
                return;
            } catch (Exception e) {
                request.setAttribute ("Errmess", "Đã xảy ra lỗi khi tải ảnh: ");
                ShowUpdateFoodDraft (request, response);
                return;
            }
            FoodDraftDTO fdrDto = new FoodDraftDTO ();

            fdrDto.setName (name);
            fdrDto.setAuthorId (acc.getId ());
            fdrDto.setCategoryId (category);
            fdrDto.setDescription (description);
            fdrDto.setIngredients (ingredients);
            fdrDto.setBmiIds (bmiString);
            fdrDto.setStatus ("Draft");
            fdrDto.setImagePath (imageUrl);
            fdrDto.setPrice (price);
            fdrDto.setOriginId (null);

            boolean check = dao.updateFoodDraft (fdrID, fdrDto);

            if (check) {
                request.setAttribute ("successMessage", "Update Successfully!");
                ShowFoodDraft (request, response);
            } else {
                request.setAttribute ("Errmess", "Update Failed, try again!");
                ShowUpdateFoodDraft (request, response);
            }

        } catch (Exception e) {

            e.printStackTrace ();
            request.setAttribute ("Errmess", "An unexpected error occurred");
            ShowUpdateFoodDraft (request, response);
        }
    }

    protected void ShowCategoryList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        } else {

            try {
                if (request.getParameter ("Errmess") != null) {
                    request.setAttribute ("Errmess", request.getParameter ("Errmess"));
                }
                if (request.getParameter ("successMessage") != null) {
                    request.setAttribute ("successMessage", request.getParameter ("successMessage"));
                }
                CategoryDAO c_dao = new CategoryDAO ();
                List<Category> lstC = c_dao.getListCategories (null, null, null, 1, 5);
                int curentPage = 1;
                int pageSize = 5;
                int total = c_dao.getListCategoriesTotal (null, null, null);
                int totalPages = (int) Math.ceil ((double) total / pageSize);
                request.setAttribute ("currentPage", curentPage);
                request.setAttribute ("totalPages", totalPages);
                request.setAttribute ("totalCategory", total);
                request.setAttribute ("lstC", lstC);
                request.getRequestDispatcher ("/Nutritionist/CategoryList.jsp").forward (request, response);
            } catch (SQLException ex) {
                request.setAttribute ("Ermessr", "Lỗi tai dữ liệu");
                request.getRequestDispatcher ("/Nutritionist/CreateFoodDraft.jsp").forward (request, response);
            }
        }
    }

    protected void ShowCategoryListSort(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        }

        String searchKey = request.getParameter ("searchKey");
        String searchKeyDe = request.getParameter ("searchKeyDe");
        String sortCreate = request.getParameter ("sortCreate");
        String sortUpdate = request.getParameter ("sortUpdate");
        String isJsonRequest = request.getParameter ("json");

        try {
            CategoryDAO c_dao = new CategoryDAO ();

            int pageSize = 5;
            Map<String, String> sortFields = new HashMap<> ();

            if (sortCreate != null && !sortCreate.trim ().isEmpty ()) {
                sortFields.put ("create_at", sortCreate);
            }
            if (sortUpdate != null && !sortUpdate.trim ().isEmpty ()) {
                sortFields.put ("update_at", sortUpdate); // Sửa từ sortCreate thành sortUpdate
            }

            int page = 1;
            String pagetxt = request.getParameter ("page");

            if (pagetxt != null && !pagetxt.trim ().isEmpty ()) {
                try {
                    page = Integer.parseInt (pagetxt);
                    if (page < 1) {
                        page = 1;
                    }
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            List<Category> lstC = c_dao.getListCategories (searchKey, searchKeyDe, sortFields, page, pageSize);
            int total = c_dao.getListCategoriesTotal (searchKey, searchKeyDe, sortFields); // Sửa: truyền đúng tham số
            int totalPages = (int) Math.ceil ((double) total / pageSize);

            if ("true".equals (isJsonRequest)) {

                response.setContentType ("application/json");
                response.setCharacterEncoding ("UTF-8");

                Map<String, Object> jsonResponse = new HashMap<> ();
                jsonResponse.put ("categories", lstC);
                jsonResponse.put ("totalPages", totalPages);
                jsonResponse.put ("currentPage", page);
                jsonResponse.put ("currentSize", lstC.size ());
                jsonResponse.put ("totalSize", total);
                jsonResponse.put ("totalCategory", total);

                Map<String, String> filters = new HashMap<> ();
                filters.put ("searchKey", searchKey != null ? searchKey : "");
                filters.put ("searchKeyDe", searchKeyDe != null ? searchKeyDe : "");
                filters.put ("sortCreate", sortCreate != null ? sortCreate : "");
                filters.put ("sortUpdate", sortUpdate != null ? sortUpdate : "");
                jsonResponse.put ("filters", filters);

                Gson gson = new Gson ();
                String jsonString = gson.toJson (jsonResponse);
                response.getWriter ().write (jsonString);
                return;
            }

            request.setAttribute ("currentPage", page);
            request.setAttribute ("totalPages", totalPages);
            request.setAttribute ("totalCategory", total);
            request.setAttribute ("lstC", lstC);
            request.getRequestDispatcher ("/Nutritionist/CategoryList.jsp").forward (request, response);

        } catch (SQLException ex) {
            if ("true".equals (isJsonRequest)) {

                response.setContentType ("application/json");
                response.setCharacterEncoding ("UTF-8");

                Map<String, String> errorResponse = new HashMap<> ();
                errorResponse.put ("error", "Lỗi tại dữ liệu");
                errorResponse.put ("message", ex.getMessage ());

                Gson gson = new Gson ();
                response.getWriter ().write (gson.toJson (errorResponse));
            } else {
                request.setAttribute ("Ermessr", "Lỗi tại dữ liệu");
                request.getRequestDispatcher ("/Nutritionist/CategoryList.jsp").forward (request, response);
            }
        }
    }

    protected void CreateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        }

        CategoryDAO dao = new CategoryDAO ();
        String name = request.getParameter ("name");
        String rawDescription = request.getParameter ("description");

        if (name != null) {
            name = name.trim ().replaceAll ("\\s+", " ");
        }

        if (rawDescription != null) {
            rawDescription = rawDescription.trim ();
            if (rawDescription.isEmpty ()) {
                request.setAttribute ("Errmess", "Description must have at least 3 words and cannot be empty or just whitespace.");
                ShowEditCategory (request, response);
                return;
            }
            if (isValidText (rawDescription, 3) == false) {
                request.setAttribute ("Errmess", "Description must have at least 3 words and cannot be empty or just whitespace.");
                ShowEditCategory (request, response);
                return;
            }
        }
        if (name == null || name.isEmpty ()) {
            request.setAttribute ("Errmess", "Name must not be empty or only whitespace.");
            ShowEditCategory (request, response);
            return;
        }
        boolean exists = false;
        try {
            exists = dao.existsByName (name);
        } catch (Exception e) {
            e.printStackTrace ();
        }

        if (exists) {
            request.setAttribute ("Errmess", "Category name already exists. Try another name.");
            ShowEditCategory (request, response);
            return;
        }
        Category category = new Category (name, rawDescription);
        boolean inserted = dao.insertCategory (category);

        if (!inserted) {
            request.setAttribute ("Errmess", "Failed to create category. Try again.");
            ShowEditCategory (request, response);
        } else {
            request.setAttribute ("successMessage", "Created successfully!");
            ShowCategoryList (request, response);
        }
    }

    protected void UpdateCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        }

        CategoryDAO dao = new CategoryDAO ();
        String idtxt = request.getParameter ("id");
        int id = 0;
        String name = request.getParameter ("name");
        String rawDescription = request.getParameter ("description");
        if (idtxt == null || idtxt.trim ().isEmpty ()) {
            request.setAttribute ("Errmess", "Colected id fail!!");
            ShowEditCategory (request, response);
            return;
        } else {
            try {
                id = Integer.parseInt (idtxt);
            } catch (Exception e) {
                request.setAttribute ("Errmess", "Wrong type id");
                ShowEditCategory (request, response);
                return;
            }
        }
        Category ca = dao.getCategoryByID (id);

        if (dao.hasAnyFoodOrDraftLinkedToCategory (id)) {
            request.setAttribute ("Errmess", "Cannot update a category that is currently used by one or more foods or FoodSuggestion.");
            ShowEditCategory (request, response);
            return;
        }
        if (ca == null) {
            request.setAttribute ("Errmess", "Category not exited!!");
            ShowEditCategory (request, response);
            return;
        }
        if (name != null) {
            name = name.trim ().replaceAll ("\\s+", " ");
        }

        if (rawDescription != null) {
            rawDescription = rawDescription.trim ();
            if (rawDescription.isEmpty ()) {
                request.setAttribute ("Errmess", "Description must have at least 3 words and cannot be empty or just whitespace.");
                ShowEditCategory (request, response);
                return;
            }
            if (isValidText (rawDescription, 3) == false) {
                request.setAttribute ("Errmess", "Description must have at least 3 words and cannot be empty or just whitespace.");
                ShowEditCategory (request, response);
                return;
            }
        }
        if (name == null || name.isEmpty ()) {
            request.setAttribute ("Errmess", "Name must not be empty or only whitespace.");
            ShowEditCategory (request, response);
            return;
        }
        boolean exists = false;
        try {
            exists = dao.isDuplicateNameExceptId (name, ca.getCatID ());
        } catch (Exception e) {
            e.printStackTrace ();
        }

        if (exists) {
            request.setAttribute ("Errmess", "Category name already exists. Try another name.");
            ShowEditCategory (request, response);
            return;
        }

        ca.setCaName (name);
        ca.setCatID (id);
        ca.setDecription (rawDescription);
        boolean updated = dao.updateCategory (ca);

        if (!updated) {
            request.setAttribute ("Errmess", "Failed to update category. Try again.");
            ShowEditCategory (request, response);
        } else {
            request.setAttribute ("successMessage", "Update successfully!");
            ShowCategoryList (request, response);
        }
    }

    protected void ShowEditCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        } else {

            try {
                if (request.getParameter ("Errmess") != null) {
                    request.setAttribute ("Errmess", request.getParameter ("Errmess"));
                }
                int id = -1;
                CategoryDAO dao = new CategoryDAO ();
                String idCatxt = request.getParameter ("id");
                if (idCatxt != null && !idCatxt.trim ().isEmpty ()) {
                    id = Integer.parseInt (idCatxt);
                    Category cat = dao.getCategoryByID (id);
                    request.setAttribute ("cat", cat);
                }

                request.getRequestDispatcher ("/Nutritionist/EditCategory.jsp").forward (request, response);
            } catch (NumberFormatException ex) {
                request.setAttribute ("Ermessr", "Lỗi tai dữ liệu");
                request.getRequestDispatcher ("/Nutritionist/CreateFoodDraft.jsp").forward (request, response);
            }
        }
    }

    protected void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        } else {

            try {
                int id = -1;
                CategoryDAO dao = new CategoryDAO ();
                String idCatxt = request.getParameter ("id");
                if (idCatxt != null && !idCatxt.trim ().isEmpty ()) {
                    id = Integer.parseInt (idCatxt);
                }
                if (dao.hasAnyFoodOrDraftLinkedToCategory (id)) {
                    request.setAttribute ("Errmess", "Cannot delete a category that is currently used by one or more foods or FoodSuggestion.");
                    ShowCategoryList (request, response);
                    return;
                } else {
                    boolean deleted = dao.deleteCategory (id);

                    if (!deleted) {
                        request.setAttribute ("Errmess", "Failed to delete category. Try again.");
                        ShowCategoryList (request, response);
                    } else {
                        request.setAttribute ("successMessage", "Delete successfully!");
                        ShowCategoryList (request, response);
                    }

                }

            } catch (NumberFormatException ex) {
                request.setAttribute ("Ermessr", "Lỗi tai dữ liệu");
                ShowCategoryList (request, response);
            }
        }
    }

    protected void deleteFoodDraft(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        }

        Account acc = (Account) session.getAttribute ("Account");
        if (acc == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        }

        String idtxt = request.getParameter ("id");

        try {
            if (idtxt == null || idtxt.trim ().isEmpty ()) {
                request.setAttribute ("Errmess", "Food Draft ID is required");
                ShowFoodDraft (request, response);
                return;
            }

            int id = Integer.parseInt (idtxt.trim ());
            FoodDraftDAO dao = new FoodDraftDAO ();
            Food_Draft food = dao.getFoodDraftById (id, acc.getId ());

            if (food == null) {
                request.setAttribute ("Errmess", "Food Draft not found or you are not the author");
                ShowFoodDraft (request, response);
                return;
            }
            if (!"DRAFT".equals (food.getStatus ())) {
                request.setAttribute ("Errmess", "Cannot delete Food Draft with status: " + food.getStatus () + ". Only DRAFT status can be deleted.");
                ShowFoodDraft (request, response);
                return;
            }
            String imgpath = food.getImageUlr ();
            boolean isDeleted = dao.deleteFoodDraft (id);

            if (isDeleted) {
                request.setAttribute ("successMessage", "Food Draft deleted successfully");
                deleteOldImage (imgpath);
                ShowFoodDraft (request, response);
                return;
            } else {
                request.setAttribute ("Errmess", "Failed to delete Food Draft. Please try again.");
                ShowFoodDraft (request, response);
                return;
            }

        } catch (NumberFormatException e) {
            request.setAttribute ("Ermessr", "Invalid Food Draft ID format");
            ShowFoodDraft (request, response);
        } catch (Exception e) {
            e.printStackTrace ();
            request.setAttribute ("Ermessr", "An unexpected error occurred while deleting Food Draft");
            ShowFoodDraft (request, response);
        }
    }

    protected void ShowRequestList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        } else {
            Account acc = (Account) session.getAttribute ("Account");

            try {
                if (request.getParameter ("Errmess") != null) {
                    request.setAttribute ("Errmess", request.getParameter ("Errmess"));
                }
                if (request.getParameter ("successMessage") != null) {
                    request.setAttribute ("successMessage", request.getParameter ("successMessage"));
                }
                RequestDAO dao = new RequestDAO ();
                List<Requests> lstR = dao.getListRequests (null, null, 1, 10);
                int curentPage = 1;
                int pageSize = 10;
                int total = dao.getTotalRequest (acc.getId ());
                int totalPages = (int) Math.ceil ((double) total / pageSize);
                request.setAttribute ("currentPage", curentPage);
                request.setAttribute ("totalPages", totalPages);
                request.setAttribute ("totalRequest", total);
                request.setAttribute ("lstR", lstR);
                request.getRequestDispatcher ("/Nutritionist/Requests.jsp").forward (request, response);
            } catch (SQLException ex) {
                request.setAttribute ("Ermessr", "Lỗi tai dữ liệu");
                request.getRequestDispatcher ("/Nutritionist/Requests.jsp").forward (request, response);
            }
        }
    }

    protected void ShowRequestListSort(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        }
        String searchKey = request.getParameter ("searchKey");
        String sortCreate = request.getParameter ("sortCreate");
        String sortType = request.getParameter ("sortType");
        String sortStatus = request.getParameter ("sortStatus");
        String isJsonRequest = request.getParameter ("json");

        try {
            RequestDAO r_dao = new RequestDAO ();
            int pageSize = 10;
            
            
            Map<String, String> filters = new HashMap<> ();
            if (searchKey != null && !searchKey.trim ().isEmpty ()) {
                filters.put ("title", searchKey);
            }
            if (sortType != null && !sortType.trim ().isEmpty ()) {
                filters.put ("type", sortType);
            }
            if (sortStatus != null && !sortStatus.trim ().isEmpty ()) {
                filters.put ("status", sortStatus);
            }

            Map<String, String> sortFields = new HashMap<> ();
            if (sortCreate != null && !sortCreate.trim ().isEmpty ()) {
                sortFields.put ("update_at", sortCreate);
            }

            int page = 1;
            String pagetxt = request.getParameter ("page");

            if (pagetxt != null && !pagetxt.trim ().isEmpty ()) {
                try {
                    page = Integer.parseInt (pagetxt);
                    if (page < 1) {
                        page = 1;
                    }
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            List<Requests> lstR = r_dao.getListRequests (filters, sortFields, page, pageSize);
            int total = r_dao.getListRequestsTotal (filters, sortFields);
            int totalPages = (int) Math.ceil ((double) total / pageSize);

            if ("true".equals (isJsonRequest)) {
                response.setContentType ("application/json");
                response.setCharacterEncoding ("UTF-8");

                Map<String, Object> jsonResponse = new HashMap<> ();
                jsonResponse.put ("requests", lstR);
                jsonResponse.put ("totalPages", totalPages);
                jsonResponse.put ("currentPage", page);
                jsonResponse.put ("currentSize", lstR.size ());
                jsonResponse.put ("totalSize", total);
                jsonResponse.put ("totalRequest", total);

                Map<String, String> responseFilters = new HashMap<> ();
                responseFilters.put ("searchKey", searchKey != null ? searchKey : "");
                responseFilters.put ("sortCreate", sortCreate != null ? sortCreate : "");
                responseFilters.put ("sortType", sortType != null ? sortType : "");
                responseFilters.put ("sortStatus", sortStatus != null ? sortStatus : "");
                jsonResponse.put ("filters", responseFilters);

                Gson gson = new Gson ();
                String jsonString = gson.toJson (jsonResponse);
                response.getWriter ().write (jsonString);
                return;
            }
            if (request.getParameter ("Errmess") != null) {
                request.setAttribute ("Errmess", request.getParameter ("Errmess"));
            }
            if (request.getParameter ("successMessage") != null) {
                request.setAttribute ("successMessage", request.getParameter ("successMessage"));
            }

            request.setAttribute ("currentPage", page);
            request.setAttribute ("totalPages", totalPages);
            request.setAttribute ("totalRequest", total);
            request.setAttribute ("lstR", lstR);
            request.getRequestDispatcher ("/Nutritionist/Requests.jsp").forward (request, response);

        } catch (SQLException ex) {
   
                request.setAttribute ("Ermessr", "Lỗi tại dữ liệu");
                request.getRequestDispatcher ("/Nutritionist/Requests.jsp").forward (request, response);

        }
    }
    
        protected void ShowRequestDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        } else {
             int id = 0;
                RequestDAO dao = new RequestDAO ();
                String idtxt = request.getParameter ("id");
                if(isIntergerNumber (idtxt)){
                     id = Integer.parseInt (idtxt);
                }
                else {
                    request.setAttribute ("Errmess", "Failed to colect id.");
                    ShowRequestList (request, response);
                }
                Requests requestdetail = dao.getRequestByID (id);
                request.setAttribute ("requestView", requestdetail);
                request.setAttribute ("action", "ViewDetail");
                
//               try(PrintWriter o = response.getWriter () ){
//                   for (Requests requests : lstR) {
//                       o.print (requests.toString ());
//                   }
//                        o.print (totalPages);
//                        o.print (total);
//                        o.print (curentPage);
//               }
                request.getRequestDispatcher ("/Nutritionist/RequestDetail.jsp").forward (request, response);
        }
    } 
        protected void ShowCreateRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession (false);
        if (session == null) {
            response.sendRedirect ("/Nutritionist/Homedemo.jsp");
            return;
        } else {
            try {
                Account acc = (Account) session.getAttribute ("Account");
                int id = 0;
                FoodDraftDAO fdao = new FoodDraftDAO ();
                List<Food_Draft> lstF = fdao.getTotalFoodDraftsByAuthor (acc.getId());
                String idtxt = request.getParameter ("idfood");
                if(isIntergerNumber (idtxt)){
                    id = Integer.parseInt (idtxt);
                    request.setAttribute ("foodID", id);
                }
                request.setAttribute ("action", "Create");
                request.setAttribute ("foodList", lstF);
//                try(PrintWriter o = response.getWriter () ){
//                        o.print ("aloo");
////                        o.print (total);
////                        o.print (curentPage);
//               }
            request.getRequestDispatcher ("/Nutritionist/RequestDetail.jsp").forward (request, response);
            } catch (SQLException ex) {
                Logger.getLogger (NutritionistControlServerLet.class.getName()).log (Level.SEVERE, null, ex);
            }
        }
    }

    private boolean isCKEditorContentEmpty(String html) {
        if (html == null) {
            return true;
        }
        String text = Jsoup.parse (html).text ();
        return text.trim ().isEmpty ();
    }
    
    private boolean isIntergerNumber(String s) {
        if (s == null) {
            return false;
        }
        try {
            Integer.parseInt (s);
            return true;
        } catch (Exception e) {
            return false;
        } 
    }

    public static boolean isValidText(String input, int minWords) {
        if (input == null) {
            return false;
        }
        String cleaned = input.trim ().replaceAll ("\\s+", " ");
        if (cleaned.isEmpty ()) {
            return false;
        }
        Pattern wordPattern = Pattern.compile ("\\b[\\p{L}\\p{N}']+\\b");
        Matcher matcher = wordPattern.matcher (cleaned);

        int count = 0;
        while (matcher.find ()) {
            count++;
            if (count >= minWords) {
                return true;
            }
        }
        return false;
    }

    private String processImageUpload(Part filePart, String folder) throws IOException, IllegalStateException {
        if (filePart.getSize () > 5 * 1024 * 1024) {
            throw new IllegalStateException ("Ảnh vượt quá dung lượng 5MB");
        }

        String fileName = filePart.getSubmittedFileName ();
        if (fileName == null || fileName.isEmpty ()) {
            return null;
        }

        String fileExtension = fileName.contains (".")
                ? fileName.substring (fileName.lastIndexOf (".")).toLowerCase () : "";
        String[] allowedExtensions = {".jpg", ".jpeg", ".png", ".gif"};
        boolean validExtension = false;
        for (String ext : allowedExtensions) {
            if (fileExtension.equals (ext)) {
                validExtension = true;
                break;
            }
        }
        if (!validExtension) {
            throw new IllegalStateException ("File type not allowed. Only JPG, PNG, GIF are supported.");
        }

        String uniqueFileName = UUID.randomUUID () + fileExtension;
        String uploadDirPath = BASE_PATH + "\\src\\main\\webapp\\img\\" + folder;
        String targetDirPath = BASE_PATH + "\\target\\Food-1.0-SNAPSHOT\\img\\" + folder;

        File uploadDir = new File (uploadDirPath);
        File targetDir = new File (targetDirPath);

        if (!uploadDir.exists ()) {
            uploadDir.mkdirs ();
        }
        if (!targetDir.exists ()) {
            targetDir.mkdirs ();
        }

        String filePath = uploadDirPath + File.separator + uniqueFileName;

        try {
            filePart.write (filePath);

            File source = new File (filePath);
            File target = new File (targetDirPath + File.separator + uniqueFileName);

            if (!source.exists ()) {
                throw new IOException ("Source file does not exist after write");
            }

            Files.copy (source.toPath (), target.toPath (), StandardCopyOption.REPLACE_EXISTING);

        } catch (Exception e) {

            File sourceFile = new File (filePath);
            if (sourceFile.exists ()) {
                 sourceFile.delete ();
            }
            throw new IOException ("Error copying file: " + e.getMessage (), e);
        }

        return "img/" + folder + "/" + uniqueFileName;
    }

    private boolean deleteOldImage(String oldImagePath)  {
        if (oldImagePath == null || oldImagePath.isEmpty ()) {
            return true;
        }

        try {
            if (oldImagePath.startsWith ("img/")) {
                String sourceImagePath = BASE_PATH + "\\src\\main\\webapp\\" + oldImagePath.replace ("/", "\\");
                String targetImagePath = BASE_PATH + "\\target\\Food-1.0-SNAPSHOT\\" + oldImagePath.replace ("/", "\\");

                File sourceFile = new File (sourceImagePath);
                File targetFile = new File (targetImagePath);

                boolean sourceDeleted = !sourceFile.exists () || sourceFile.delete ();
                boolean targetDeleted = !targetFile.exists () || targetFile.delete ();

                return sourceDeleted && targetDeleted;
            } else {
                return true;
            }
        } catch (Exception e) {
            return false;
        }
    }

    private boolean isNotValidInput(String title, String content, String bmiIdStr, String status, Part imagePart) {
        return title == null || title.trim ().isEmpty ()
                || content == null || content.trim ().isEmpty ()
                || bmiIdStr == null || bmiIdStr.isEmpty ()
                || status == null || imagePart == null
                || imagePart.getSize () == 0
                || imagePart.getSubmittedFileName ().isEmpty ();
    }

}
