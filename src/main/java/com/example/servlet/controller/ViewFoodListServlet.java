
import com.example.servlet.dao.FoodDAO;
import com.example.servlet.model.Food;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;




@WebServlet("/viewFoodList")
public class ViewFoodListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy tham số từ form tìm kiếm
        String searchID = request.getParameter("searchID");
        String searchName = request.getParameter("searchName");
        String searchCategory = request.getParameter("searchCategory");
        String priceRange = request.getParameter("priceRange");

        try {
            FoodDAO dao = new FoodDAO();

            List<Food> foodList;

            // Nếu không có điều kiện search nào thì lấy toàn bộ
            if ((searchID == null || searchID.isBlank()) &&
                (searchName == null || searchName.isBlank()) &&
                (searchCategory == null || searchCategory.isBlank()) &&
                (priceRange == null || priceRange.isBlank())) {
                foodList = dao.getAllFoods();
            } else {
                // Có điều kiện -> gọi search
                foodList = dao.searchFoods(searchID, searchName, searchCategory, priceRange);
            }

            request.setAttribute("foodList", foodList);
            request.getRequestDispatcher("viewFoods.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(500, "Error loading food list");
        }
    }
}
