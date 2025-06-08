/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.example.servlet.controller.Nutritionist;

import com.example.servlet.dao.BlogDAO;
import com.example.servlet.model.Blogs;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class BlogDetailServerLet extends HttpServlet {
   
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
            out.println("<title>Servlet BlogDetailServerLet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogDetailServerLet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType ("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter ()) {
             HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("Account") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
            BlogDAO b_dao = new BlogDAO ();
            try {
                String ids = request.getParameter ("id");
                
                if (ids != null) {
                    if (!ids.trim ().isEmpty ()) {
                        
                        int id = Integer.parseInt (ids);
                        Blogs blog = b_dao.getBlogByID (id);
                        request.setAttribute ("blog", blog);
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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        
        
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
