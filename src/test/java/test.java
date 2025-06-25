
//import com.example.servlet.dao.AccountDAO;
import com.example.servlet.dao.AccountDAO;
import com.example.servlet.dao.BMIClassificationDAO;
import com.example.servlet.dao.BlogDAO;
import com.example.servlet.dao.CategoryDAO;
import com.example.servlet.dao.FoodDAO;
import com.example.servlet.dao.FoodDetailDAO;
import com.example.servlet.dao.FoodDraftDAO;
import com.example.servlet.dao.NotifyDAO;
import com.example.servlet.dao.RequestDAO;
import com.example.servlet.model.Account;
import com.example.servlet.model.BMIClassification;
import com.example.servlet.model.Blogs;
import com.example.servlet.model.Category;
import com.example.servlet.model.Food;
import com.example.servlet.model.FoodDetail;
import com.example.servlet.model.Food_Draft;
import com.example.servlet.model.MonthlyStat;
import com.example.servlet.model.Notifys;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
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
        CategoryDAO dao =new CategoryDAO ();
        List<Category> lst = dao.getListCategories (null, null, null, 1, 10);
        for (Category category : lst) {
            System.out.println (category.toString ());
        }
      
    }
    
 public static void diss() {
//     try {
//          FoodDetailDAO fddao= new FoodDetailDAO();
//     FoodDAO dao = new FoodDAO();
//     List<Food> lstF = dao.getListFoods (null, null, null, null, null, null, null, 1, 3);
//     Food f = dao.getFoodById (3);
//     FoodDetail fd = fddao.getFoodDetailByIdAndDraft (3, true);
//     FoodDetail fdf = fddao.getFoodDetailByIdAndDraft (3, false);
////     System.out.println (fd);
////     System.out.println (f);
////     System.out.println (fdf);
//for (Food food : lstF) {
//         System.out.println (food);    
//         }
//     } catch (Exception e) {
//     }

            FoodDraftDAO dao = new FoodDraftDAO();
            FoodDetailDAO fd_dao = new FoodDetailDAO ();
            Food_Draft food = dao.getFoodDraftById (119,21);
            FoodDetail fooddetail = fd_dao.getFoodDetailByIdAndDraft (119, true);
            List<BMIClassification> tagetaudience = fd_dao.getBMIClassificationsByFoodOrDraftId (119, true);
            System.out.println (food); 
            System.out.println (fooddetail); 
            for (BMIClassification bmi : tagetaudience) {
                System.out.println (bmi.getClassification ());
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
   //  dàdfsdfsdffdđâ aloo
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



public static void dis9()  {
//    Map<String, String> filters = new HashMap<>();
//    filters.put("searchKey", "");
//    filters.put("category", "");
//    filters.put("status", "");
//    filters.put("searchPrice", "");
//    filters.put("priceRank", "");
//    filters.put("bmiId", "");
//    filters.put("authorId", "19");
//    Map<String, String> sortAndPagination = new HashMap<>();
//    sortAndPagination.put("sortprice", "desc");
//    sortAndPagination.put("sorttime", "asc");
//    sortAndPagination.put("page", "1");
//    sortAndPagination.put("pageSize", "10");
    FoodDraftDAO dao = new FoodDraftDAO();
//            List<Food_Draft> results = dao.getListFoodDrafts(filters, sortAndPagination);
//            int total = dao.getListFoodDraftsTotal(filters, sortAndPagination);
//            for (Food_Draft result : results) {
//                System.out.println (result);
//            }   
//            System.out.println (total);

    int check =  dao.copyFoodToDraft (1, 21);
    System.out.println (check);
}

}
