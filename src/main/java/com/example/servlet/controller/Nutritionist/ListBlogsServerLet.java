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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class ListBlogsServerLet extends HttpServlet {
   
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
            out.println("<title>Servlet ListBlogsServerLet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListBlogsServerLet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.setCharacterEncoding ("UTF-8");
        response.setContentType ("text/html;charset=UTF-8");
        BlogDAO _dao = new BlogDAO ();
        BMIClassificationDAO b_dao = new BMIClassificationDAO ();
        HttpSession session = request.getSession (false);
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
        int  indexPage =1;
        if(index != null) {
            indexPage = Integer.parseInt (index);
        }
        try {
            List<Blogs> lstB =_dao.getBlogsByFilterAndPage (null, -1, true,"" , indexPage, 10);
            List<Blogs> lstB1 = _dao.getBlogsByFilter ("", -1, true, "Public");
            List<Blogs> lstB2 = _dao.getBlogsByFilter ("", -1, true, "Private");
            List<Blogs> lstB3 = _dao.getBlogsByFilter ("", -1, true, "Draft");
            List<String> ststuss = _dao.getAllDistinctStatuses ();
            List<String> typeLables = new ArrayList<> ();
            List<Integer> typeCounts = new ArrayList<> ();
            List< BMIClassification> lstBMI = b_dao.getAllBMI ();
            List<MonthlyStat> typeStats = _dao.countByTypeBMI (-1);
            int totalBlog = _dao.getTotalBlog ();
            int totalPages = (totalBlog/10) +1;
            request.setAttribute ("totalPages", totalPages);
            request.setAttribute ("typeStats", typeStats);

            BMIClassificationDAO bmiDAO = new BMIClassificationDAO ();
            typeStats = _dao.countByTypeBMI (-1);
            for (MonthlyStat typeStat : typeStats) {
                String typeIdStr = typeStat.getMonthlName ();
                int typeId = Integer.parseInt (typeIdStr);
                BMIClassification bmi = bmiDAO.getBMIByID (typeId);
                typeLables.add (bmi.getClassification ());
                typeCounts.add (typeStat.getCount ());
            }

            request.setAttribute ("lstBMI", lstBMI);
            request.setAttribute ("statusList", ststuss);
            request.setAttribute ("typeLabels", typeLables);
            request.setAttribute ("typeCounts", typeCounts);
            request.setAttribute ("lstB", lstB);
            request.setAttribute ("publicCount", lstB1.size ());
            request.setAttribute ("privateCount", lstB2.size ());
            request.setAttribute ("draftCount", lstB3.size ());
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
        doGet(request, response);
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
