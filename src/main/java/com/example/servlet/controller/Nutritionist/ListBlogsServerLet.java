/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.example.servlet.controller.Nutritionist;

import com.example.servlet.dao.BMIClassificationDAO;
import com.example.servlet.dao.BlogDAO;
import com.example.servlet.model.BMIClassification;
import com.example.servlet.model.Blogs;
import com.example.servlet.model.MonthlyStat;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class ListBlogsServerLet extends HttpServlet {

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
        response.setContentType ("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter ()) {
            /* TODO output your page here. You may use following sample code. */
            out.println ("<!DOCTYPE html>");
            out.println ("<html>");
            out.println ("<head>");
            out.println ("<title>Servlet ListBlogsServerLet</title>");
            out.println ("</head>");
            out.println ("<body>");
            out.println ("<h1>Servlet ListBlogsServerLet at " + request.getContextPath () + "</h1>");
            out.println ("</body>");
            out.println ("</html>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding ("UTF-8");
        response.setContentType ("text/html;charset=UTF-8");
        BlogDAO _dao = new BlogDAO ();
        BMIClassificationDAO b_dao = new BMIClassificationDAO ();
        HttpSession session = request.getSession (false);
        if (session == null || session.getAttribute("Account") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        if (session != null) {
            String mess = (String) session.getAttribute ("mess");
            String errMess = (String) session.getAttribute ("Errmess");
            if (mess != null) {
                request.setAttribute ("mess", mess);
                session.removeAttribute ("mess");
            }
            if (errMess != null) {
                request.setAttribute ("Errmess", errMess);
                session.removeAttribute ("Errmess");
            }
        } 
        String index = request.getParameter ("index");

        request.setAttribute ("currentPage", index);
        int indexPage = 1;
        if (index != null) {
            indexPage = Integer.parseInt (index);
        }
        try {
            String input_search = request.getParameter ("input_search");
            
            int pageSize = 10;
            
            if (request.getParameter ("pageSize") == null || request.getParameter ("pageSize").trim ().isEmpty ()) {
                pageSize = 10;
            } else {
                pageSize = Integer.parseInt (request.getParameter ("pageSize"));
            }
            

            List<String> ststuss = _dao.getAllDistinctStatuses ();
           
            List< BMIClassification> lstBMI = b_dao.getAllBMI ();
            List<MonthlyStat> typeStats = _dao.countByTypeBMI (-1);
            int totalBlog = _dao.getTotalBlog ();
              int totalPages = 1;
            if(totalBlog > 10 ){
                totalPages = (totalBlog / 10) + 1;
            }
            BMIClassificationDAO bmiDAO = new BMIClassificationDAO ();
            List<BMIClassification> lstBmi = bmiDAO.getAllBMI ();
            
            if(lstBmi != null || !lstBmi.isEmpty ()){
                request.setAttribute ("lstBMI", lstBmi);
            }
            request.setAttribute ("totalPages", totalPages);
            
            request.setAttribute ("typeStats", typeStats);
            request.setAttribute ("lstBMI", lstBMI);
            request.setAttribute ("statusList", ststuss);
            request.setAttribute ("totalBlog", totalBlog);

            List<Blogs> lstB = _dao.getBlogsByFilterAndPage (input_search, -1, true, "", indexPage, pageSize);
            request.setAttribute ("lstB", lstB);
            request.getRequestDispatcher ("/Nutritionist/Blogs.jsp")
                    .forward (request, response);
        } catch (SQLException ex) {
            ex.printStackTrace ();
        } catch (Exception ex) {
            Logger.getLogger (ListBlogsServerLet.class.getName ()).log (Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//                doGet (request, response);
            
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    private void handleJsonRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, SQLException {
    BlogDAO _dao = new BlogDAO();

    String input_search = request.getParameter("input_search");
    String status = request.getParameter("status");
    int indexPage = 1;
    if (request.getParameter("index") != null) {
        indexPage = Integer.parseInt(request.getParameter("index"));
    }
    int pageSize = 10;
    if (request.getParameter("pageSize") != null && !request.getParameter("pageSize").trim().isEmpty()) {
        pageSize = Integer.parseInt(request.getParameter("pageSize"));
    }

    List<Blogs> lstB = _dao.getBlogsByFilterAndPage(input_search, -1 ,true,status, indexPage, pageSize);
    int totalBlog = _dao.getTotalBlog ();
              int totalPages = 1;
            if(totalBlog > 10 ){
                totalPages = (totalBlog / 10) + 1;
    }      
    response.setContentType("application/json;charset=UTF-8");
    PrintWriter out = response.getWriter();

    com.google.gson.Gson gson = new com.google.gson.Gson();

    String json = gson.toJson(lstB);
    out.print("{\"blogs\":" + json + ", \"totalPages\":" + totalPages + "}");
    out.flush();
}
  
    
    private void handleNormalRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, SQLException {
    BlogDAO _dao = new BlogDAO();

    String input_search = request.getParameter("input_search");
    String status = request.getParameter("status");
    int indexPage = 1;
    if (request.getParameter("index") != null) {
        indexPage = Integer.parseInt(request.getParameter("index"));
    }
    int pageSize = 10;
    if (request.getParameter("pageSize") != null && !request.getParameter("pageSize").trim().isEmpty()) {
        pageSize = Integer.parseInt(request.getParameter("pageSize"));
    }

    List<String> statusList = _dao.getAllDistinctStatuses();
    List<Blogs> lstB = _dao.getBlogsByFilterAndPage (input_search, -1, true, "", indexPage, pageSize);
        int totalBlog = _dao.getTotalBlog ();
        int totalPages = 1;
        if (totalBlog > 10) {
            totalPages = (totalBlog / 10) + 1;
        }
    request.setAttribute("currentPage", indexPage);
    request.setAttribute("totalPages", totalPages);
    request.setAttribute("lstB", lstB);
    request.setAttribute("statusList", statusList);
    request.setAttribute("input_search", input_search);
    request.setAttribute("status", status);

    request.getRequestDispatcher("/Nutritionist/Blogs.jsp").forward(request, response);
}

}
