
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
        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orderList", orders);
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
                        // có thể trả về trang trạng thái chi tiết hoặc thông báo hiện tại
                        // Hiện tạm không update gì, chỉ redirect về trang order
                        break;
                }

                if (newStatus != null) {
                    boolean updated = orderDAO.updateOrderStatus(orderId, newStatus);
                    if (!updated) {
                        // Xử lý lỗi update nếu muốn
                    }
                }

            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Sau khi xử lý POST thì load lại trang danh sách
        response.sendRedirect("order");
    }
}