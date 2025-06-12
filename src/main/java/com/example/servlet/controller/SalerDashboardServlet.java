package controller.saler;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "SalerDashboardServlet", urlPatterns = {"/dashboard"})
public class SalerDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng tới trang salerDashboard.jsp
        request.getRequestDispatcher("salerDashboard.jsp").forward(request, response);
    }

}
