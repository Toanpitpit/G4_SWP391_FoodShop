
package com.example.servlet.controller;

import com.example.servlet.dao.FoodDetailDAO;
import com.example.servlet.model.Food;
import com.example.servlet.model.FoodDetail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet("/viewFoodDetail")
public class ViewFoodDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        FoodDetailDAO dao = new FoodDetailDAO(); // Sử dụng DAO mới
        List<FoodDetail> foodList = dao.getAllFoodsWithDetails();

        request.setAttribute("foodList", foodList);
        request.getRequestDispatcher("foodDetail.jsp").forward(request, response);
    }
}
