/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.example.servlet.controller.Nutritionist;

import com.example.servlet.dao.BlogDAO;
import com.example.servlet.dao.NotifyDAO;
import com.example.servlet.dao.RequestDAO;
import com.example.servlet.model.Blogs;
import com.example.servlet.model.Notifys;
import com.example.servlet.model.Requests;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class DashboardServerLet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Dashboard</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Dashboard at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("account") == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }

        RequestDAO r_dao = new RequestDAO();
        BlogDAO b_dao = new BlogDAO();
        NotifyDAO n_dao = new NotifyDAO();
        
        List<Blogs> lstB = b_dao.getBlogsByFilter("", -1, true);
        List<Requests> lstR = r_dao.getRequestByFilter(-2, "", "newest");
        List<Notifys> lstN = n_dao.getNotificationsByFilter(null, "Saler", false, true);
        request.setAttribute("lstR", lstR);
        request.setAttribute("lstB", lstB);
        request.setAttribute("lstN", lstN);
        request.getRequestDispatcher("/Nutritionist/DaskbashNutrif.jsp")
                .forward(request, response);

    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
