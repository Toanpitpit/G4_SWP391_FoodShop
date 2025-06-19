
//import com.example.servlet.dao.AccountDAO;
import com.example.servlet.dao.AccountDAO;
import com.example.servlet.dao.BMIClassificationDAO;
import com.example.servlet.dao.BlogDAO;
import com.example.servlet.dao.FoodDAO;
import com.example.servlet.dao.NotifyDAO;
import com.example.servlet.dao.RequestDAO;
import com.example.servlet.model.Account;
import com.example.servlet.model.BMIClassification;
import com.example.servlet.model.Blogs;
import com.example.servlet.model.Food;
import com.example.servlet.model.MonthlyStat;
import com.example.servlet.model.Notifys;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mindrot.jbcrypt.BCrypt;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Admin
 */
public class test {
    
    public static void main(String[] args) throws SQLException {
//        dis4();
//        dis6();
//         dis5();
dis8();
//dis();
 try {
           FoodDAO dao = new FoodDAO();
            String name = "";               // lọc theo tên, null nếu không cần
            String category = null;        // lọc theo danh mục, null nếu không cần
            String status = "Active";      // "Active", "Inactive", hoặc null
            // Map chứa các trường sắp xếp và hướng sắp xếp
            Map<String, String> sortFields = new HashMap<>();
            sortFields.put("id", "DESC");
            sortFields.put("create_at", "ASC");
            int page = 1;
            int pageSize = 10;

//            List<Food> foodList = dao.getListFoods(name, category, status,"20000", null,null, page, pageSize);
//
//            System.out.println("===== KẾT QUẢ =====");
//            for (Food food : foodList) {
//                System.out.printf("ID: %d | Tên: %s | Giá: %.2f | Tạo lúc: %s | Trạng thái: %s%n",
//                        food.getFoodId(), food.getFoodname(), food.getPrice(), food.getCreate_at(), food.getStatus());
//            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static void dis() throws SQLException{
        BlogDAO _dao = new BlogDAO();
        RequestDAO r_dao  = new RequestDAO ();
        List<MonthlyStat> lstMBlog = _dao.getMonthlyBlogStatsByYearAndAuthor (2025,21);
         List<MonthlyStat> lstM = r_dao.countRequestsByStatus (21);
         for (MonthlyStat monthlyStat : lstM) {
             System.out.println (monthlyStat);
        }
    
//        System.out.println (lstMBlog);
//        List<MonthlyStat> typeStats = new ArrayList<>();
//       List<Blogs> lstBlog = _dao.getBlogsByFilter("", 5, true,null);
//       List<Blogs> lstB = _dao.getBlogsByFilterAndPage(null, -1, true, null, 1,10, 21);
//          System.out.println (_dao.getTotalBlog());
//        List<String> ststuss;
//        try {
//            ststuss = _dao.getAllDistinctStatuses();
//            for (String ststus : ststuss) {
//            System.out.println(ststus);
//        }
//        } catch (Exception ex) {
//            Logger.getLogger(test.class.getName()).log(Level.SEVERE, null, ex);
////        }
//Blogs b = _dao.getBlogByID (100);
//        System.out.println (b);
//        for(Blogs b : lstB){
//            System.out.println(b.toString());
//        }
//    List<Blogs> relesteBlog = _dao.getRelatedBlogByID (237);
//        for (Blogs blogs : relesteBlog) {
//            System.out.println (blogs.toString ());
//        }
//        FoodDraftDAO dao= new FoodDraftDAO ();
//        System.out.println (dao.getTotalFooddraft (19)); 
//        System.out.println (_dao.getTotalBlogbyAuthor (21));
//        typeStats = _dao.countByTypeBMI(-3);
//        for (MonthlyStat typeStat : typeStats) {
//            System.out.println(typeStat.toString());
//        }
    }
   public static void dis2() {
    BlogDAO _dao = new BlogDAO();
    Blogs testBlog = new Blogs(
    1, // blogID
    9,  // authorID
    "Nguyễn Văn Dũng", // authorName
    3,  // bmiId
    "Test update moi ne truoc deu th", // title
    "sdasd", // imageUlr
    "Nội dung chi tiết về chế độ ăn theo BMI.", // content
    "Private", // status
    null, // create_at
    new Timestamp(System.currentTimeMillis())  // update_at
);
//     _dao.insertBlog(testBlog);
     _dao.updateBlog(testBlog);
    
}
   public static void dis3() throws SQLException {
    BlogDAO _dao = new BlogDAO();
    boolean check = _dao.deleteBlogByID(41);
       System.out.println (check);
}
public static void dis4() {
    RequestDAO _dao = new RequestDAO();
    int lstR = _dao.getTotalRequest (21);
    System.out.println (lstR);
//    if(lstR.isEmpty()){
//        System.out.println("deo có du lieu");
//    }
//    for (Requests requests : lstR) {
//        System.out.println(requests.toString());
//    }
//}
}
public static void dis5() throws SQLException {
    AccountDAO dao = new AccountDAO();
    Account testUser = new Account();
            testUser.setUsername("ToanAdmin");
            String pass = "Tatoan@123";
            String hashedPassword = BCrypt.hashpw(pass, BCrypt.gensalt());
            testUser.setPass(hashedPassword);
            testUser.setName("Tạ Văn Toàn");
            testUser.setEmail("he187337tavantoan@gmail.com");
            testUser.setPhone("0707408906");
            testUser.setGender("Male");
            testUser.setBirthDate(Date.valueOf(LocalDate.of(2004, 10, 04))); // yyyy-MM-dd
            testUser.setRole("Nutritonist");
            testUser.setStatus("Active");
            testUser.setImage("default.png");
            dao.registerUser(testUser);
}

public static void dis6() {
    NotifyDAO n_dao = new NotifyDAO();
    List<Notifys> lstN = n_dao.getNotificationsByFilter(null, "Saler", false, true);
    for (Notifys notifys : lstN) {
        System.out.println(notifys.toString());
    }
}


public static void dis7() throws SQLException {
    BMIClassificationDAO dao = new BMIClassificationDAO();
    System.out.println (dao.countAllBMI ());
    List<BMIClassification> lstBMI = dao.getBMIWithFilterAndSort("Người","type_id",null,0,7);
    int totl = dao.gettotalBMIWithFilterAndSort ("Người", "type_id", null);
//    List<BMIClassification> lstBMI = dao.getAllBMI();
    for (BMIClassification bMIClassification : lstBMI) {
        System.out.println(bMIClassification.toString());
    }
    System.out.println (totl);
    
    
    
}
public static void dis8() throws SQLException {
    FoodDAO dao= new FoodDAO();
    Map<String , String> map = new HashMap<>();
    map.put ("pID", "desc");
    
    List<Food> lstF = dao.getListFoods (null, null, null,null,null,null, map, 1, 5);
    for (Food o : lstF) {
        System.out.println (o.toString ());
             
    }
    
    
}


//public static void dis8() throws SQLException {
//      BMIClassificationDAO bi_dao = new BMIClassificationDAO ();
//                RequestDAO r_dao = new RequestDAO ();
//                BlogDAO b_dao = new BlogDAO ();
//                NotifyDAO n_dao = new NotifyDAO ();
//                FoodDraftDAO fd_dao = new FoodDraftDAO ();
//                int totalFdrf = fd_dao.getTotalFooddraft (-1);
//                int totalBlog  = b_dao.getTotalBlog ();
//                int totalNotify = n_dao.getTotalNotify (-1,null);
//                int totalRequest = r_dao.getTotalRequest (-1);
//                List<MonthlyStat> lstM = r_dao.countRequestsByStatus (-1);
//                
//                System.out.println (totalBlog + "+ " + totalFdrf +" +" +  totalNotify + "+" + totalRequest+ " + " + lstM);
//}
}
