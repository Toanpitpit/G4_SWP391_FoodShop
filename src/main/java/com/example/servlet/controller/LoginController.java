package com.example.servlet.controller;



import com.example.servlet.dao.AccountDAO;

import com.example.servlet.model.Account;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;



@WebServlet("/login")
public class LoginController extends HttpServlet {
    private AccountDAO accountDAO;

    @Override
    public void init() {
        accountDAO = new AccountDAO();
    }
      protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
          
           Cookie arr[] = request.getCookies ();
           for (Cookie o : arr) {
              if(o.getName().equals ("userC")){
                  request.setAttribute ("username",o.getValue ());
              }
              if(o.getName().equals ("passC")){
                  request.setAttribute ("password",o.getValue ());
              }
             
          }
            request.getRequestDispatcher("login.jsp").forward(request, response);
              
    }
   @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("rememberMe");
        Account user = null;
        try {
            user = accountDAO.loginUser(username, password);   
        } catch (SQLException ex) {
            Logger.getLogger (LoginController.class.getName()).log (Level.SEVERE, null, ex);
        }
       if (user != null) {
           HttpSession session = request.getSession ();
           session.setAttribute ("Account", user);
           Cookie u = new Cookie ("userC", username);
           Cookie p = new Cookie ("passC", password);
           if (remember != null) {
               
               u.setMaxAge (60);
               if (remember.equals ("true")) {
                   p.setMaxAge (60);
               } else {
                   p.setMaxAge (0);
               }
               
           }
           else {
               u.setMaxAge (60);
               p.setMaxAge (0);
           }
            response.addCookie (u);
            response.addCookie (p);
           
            if(user.getRole ().equals ("Nutritionist")){
            response.sendRedirect ("/dashboadnutri");
            }
            else if(user.getRole ().equals ("Admin")){
                response.sendRedirect ("/adminDashboard");
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
