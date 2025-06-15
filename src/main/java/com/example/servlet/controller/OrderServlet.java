import com.yourpackage.dao.OrderDAO;
import com.yourpackage.model.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 *
 * @author User
 */
@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get search parameters
        String orderId = request.getParameter("orderId");
        String customerName = request.getParameter("customerName");
        String category = request.getParameter("category");
        String phone = request.getParameter("phone");
        String food = request.getParameter("food");
        String status = request.getParameter("status");
        
        List<Order> orders;
        
        // Check if any search parameters are provided
        if (hasSearchParameters(orderId, customerName, category, phone, food, status)) {
            // Perform search with filters
            orders = orderDAO.searchOrders(orderId, customerName, category, phone, food, status);
        } else {
            // Get all orders if no search parameters
            orders = orderDAO.getAllOrders();
        }
        
        // Set attributes for JSP to maintain search form values
        request.setAttribute("orderList", orders);
        request.setAttribute("searchOrderId", orderId);
        request.setAttribute("searchCustomerName", customerName);
        request.setAttribute("searchCategory", category);
        request.setAttribute("searchPhone", phone);
        request.setAttribute("searchFood", food);
        request.setAttribute("searchStatus", status);
        
        request.getRequestDispatcher("order.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");
        
        if (orderIdStr != null && action != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                String newStatus = null;
                
                switch (action) {
                    case "accept":
                        newStatus = "Accepted";
                        break;
                    case "reject":
                        newStatus = "Rejected";
                        break;
                    case "cancel":
                        newStatus = "Cancelled";
                        break;
                    case "status":
                        // Redirect to order tracking page for status check
                        response.sendRedirect("ordertracking.jsp?orderId=" + orderId);
                        return;
                }
                
                if (newStatus != null) {
                    boolean updated = orderDAO.updateOrderStatus(orderId, newStatus);
                    if (updated && "Accepted".equals(newStatus)) {
                        // Redirect to tracking page after accepting order
                        response.sendRedirect("ordertracking.jsp?orderId=" + orderId);
                        return;
                    } else if (!updated) {
                        request.setAttribute("error", "Failed to update order status");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                        return;
                    }
                }
                
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("error", "Invalid order ID format");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
        }
        
        // Sau khi xử lý POST thì load lại trang danh sách
        response.sendRedirect("order");
    }
    
    /**
     * Helper method to check if any search parameters are provided
     */
    private boolean hasSearchParameters(String... parameters) {
        for (String param : parameters) {
            if (param != null && !param.trim().isEmpty()) {
                return true;
            }
        }
        return false;
    }
}