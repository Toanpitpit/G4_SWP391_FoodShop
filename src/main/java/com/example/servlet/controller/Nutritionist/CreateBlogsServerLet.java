/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.example.servlet.controller.Nutritionist;

import com.example.servlet.dao.BMIClassificationDAO;
import com.example.servlet.dao.BlogDAO;
import com.example.servlet.model.BMIClassification;
import com.example.servlet.model.Blogs;
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
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class CreateBlogsServerLet extends HttpServlet {   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
private static final String UPLOAD_DIRECTORY = "D:\\Semester 5\\SWP391\\Project\\G4_SWP391_FoodShop-master\\G4_SWP391_FoodShop-master\\src\\main\\webapp\\img\\blog";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreateBlogsServerLet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateBlogsServerLet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 
    @Override
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        BMIClassificationDAO b_dao = new BMIClassificationDAO();
        try {       
            List< BMIClassification> lstBMI = b_dao.getAllBMI();
            BlogDAO _dao = new BlogDAO();
            List<String> ststuss = _dao.getAllDistinctStatuses();
            request.setAttribute("statusList", ststuss);
            request.setAttribute("lstBMI", lstBMI);
            request.getRequestDispatcher("/Nutritionist/CreateBlog.jsp")
                .forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CreateBlogsServerLet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
        Logger.getLogger(CreateBlogsServerLet.class.getName()).log(Level.SEVERE, null, ex);
    }
        
    } 
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");
    try (PrintWriter out = response.getWriter()) {
        String title = request.getParameter("title");
        String bmiIdStr = request.getParameter("bmiId");
        String status = request.getParameter("status");
        String content = request.getParameter("content");

        int bmiId = 0;
        try {
            bmiId = Integer.parseInt(bmiIdStr);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }        String image_ulr = null;

        try {
            Part filePart = request.getPart("imageUrl"); 
            String fileName = filePart.getSubmittedFileName();

            if (fileName != null && !fileName.isEmpty()) {
                String fileExtension = "";
                int dotIndex = fileName.lastIndexOf('.');
                if (dotIndex >= 0) {
                    fileExtension = fileName.substring(dotIndex);
                }
                String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
                File uploadDir = new File(UPLOAD_DIRECTORY);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                String filePath = UPLOAD_DIRECTORY + File.separator + uniqueFileName;
                filePart.write(filePath);
                try {
                    Thread.sleep(500); // Delay 500ms (nửa giây)
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                image_ulr = "img/blog/" + uniqueFileName;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
      Timestamp create_at = new Timestamp(System.currentTimeMillis());
      Timestamp update_at = new Timestamp(System.currentTimeMillis());
      int authorID = 19;
      String name = "nsams";
      Blogs blog = new Blogs(0, authorID, name, bmiId, title, image_ulr, content, status, create_at, update_at);
          BlogDAO _dao = new BlogDAO();
          boolean suscess = _dao.insertBlog(blog);
          String mess = null , Errmess = null;
          if(suscess){
               mess = "Create sucessfuly";
          }
          else  Errmess = "Fail to create";
          HttpSession session = request.getSession();
          session.setAttribute("mess", mess);
          session.setAttribute("Errmess", Errmess);
          response.sendRedirect("/listblog");
          
    }
}

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
