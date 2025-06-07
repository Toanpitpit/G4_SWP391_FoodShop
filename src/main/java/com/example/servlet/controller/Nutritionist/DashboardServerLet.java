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
import com.example.servlet.model.MonthlyStat;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class DashboardServerLet extends HttpServlet {

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
            out.println ("<title>Servlet Dashboard</title>");
            out.println ("</head>");
            out.println ("<body>");
            out.println ("<h1>Servlet Dashboard at " + request.getContextPath () + "</h1>");
            out.println ("</body>");
            out.println ("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType ("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter ()) {

            //HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("account") == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
            
            
            BMIClassificationDAO bi_dao = new BMIClassificationDAO ();
            RequestDAO r_dao = new RequestDAO ();
            BlogDAO b_dao = new BlogDAO ();
            NotifyDAO n_dao = new NotifyDAO ();
            FoodDraftDAO fd_dao = new FoodDraftDAO ();
            int totalFdrf = fd_dao.getTotalFooddraft (-1);
            int totalBlog = b_dao.getTotalBlog ();
            int totalNotify = n_dao.getTotalNotify (1, null);
            int totalRequest = r_dao.getTotalRequest (-1);
            List<MonthlyStat> lstM = r_dao.countRequestsByStatus (-1);
            List<String> pieChart_data_lables = new ArrayList<> ();
            List<Integer> pieChart_data_totals = new ArrayList<> ();

            for (MonthlyStat monthlyStat : lstM) {
                pieChart_data_lables.add (monthlyStat.getMonthlName ());
                pieChart_data_totals.add (monthlyStat.getCount ());
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
            List<MonthlyStat> lstMBlog = b_dao.getMonthlyBlogStatsByYearAndAuthor (selectedYear,-1);
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

            request.getRequestDispatcher ("/Nutritionist/DaskbashNutrif.jsp")
                    .forward (request, response);
//                request.getRequestDispatcher ("/Nutritionist/Blog.jsp")
//                        .forward (request, response);
        } catch (Exception ex) {
            Logger.getLogger (DashboardServerLet.class.getName ()).log (Level.SEVERE, null, ex);
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
