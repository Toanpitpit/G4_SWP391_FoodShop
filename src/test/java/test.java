
//import com.example.servlet.dao.AccountDAO;
import com.example.servlet.dao.BMIClassificationDAO;
import com.example.servlet.dao.BlogDAO;
import com.example.servlet.dao.FoodDraftDAO;
import com.example.servlet.dao.NotifyDAO;
import com.example.servlet.dao.RequestDAO;
import com.example.servlet.model.Account;
import com.example.servlet.model.BMIClassification;
import com.example.servlet.model.Blogs;
import com.example.servlet.model.MonthlyStat;
import com.example.servlet.model.Notifys;
import com.example.servlet.model.Requests;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
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
//        dis4();
//        dis6();
//         dis5();
dis();
//dis();
    }
    public static void dis() throws SQLException{
        BlogDAO _dao = new BlogDAO();
        List<MonthlyStat> lstMBlog = _dao.getMonthlyBlogStatsByYearAndAuthor (2025,21);
//        System.out.println (lstMBlog);
//        List<MonthlyStat> typeStats = new ArrayList<>();
//       List<Blogs> lstBlog = _dao.getBlogsByFilter("", 5, true,null);
       List<Blogs> lstB = _dao.getBlogsByFilterAndPage(null, -1, true, null, 1,10, 21);
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
        FoodDraftDAO dao= new FoodDraftDAO ();
        System.out.println (dao.getTotalFooddraft (19)); 
        System.out.println (_dao.getTotalBlogbyAuthor (21));
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
//public static void dis4() {
//    RequestDAO _dao = new RequestDAO();
//    List<Requests> lstR = _dao.getRequestByFilter(-3,"" , null);
//    if(lstR.isEmpty()){
//        System.out.println("deo có du lieu");
//    }
//    for (Requests requests : lstR) {
//        System.out.println(requests.toString());
//    }
//}
//public static void dis5() throws SQLException {
//    AccountDAO dao = new AccountDAO();
//    Account testUser = new Account();
//            testUser.setUsername("ToanAdmin");
//            String pass = "Tatoan@123";
//            String hashedPassword = BCrypt.hashpw(pass, BCrypt.gensalt());
//            testUser.setPass(hashedPassword);
//            testUser.setName("Tạ Văn Toàn");
//            testUser.setEmail("he187337tavantoan@gmail.com");
//            testUser.setPhone("0707408906");
//            testUser.setGender("Male");
//            testUser.setBirthDate(Date.valueOf(LocalDate.of(2004, 10, 04))); // yyyy-MM-dd
//            testUser.setRole("Nutritonist");
//            testUser.setStatus("Active");
//            testUser.setImage("default.png");
//            dao.registerUser(testUser);
//}

public static void dis6() {
    NotifyDAO n_dao = new NotifyDAO();
    List<Notifys> lstN = n_dao.getNotificationsByFilter(null, "Saler", false, true);
    for (Notifys notifys : lstN) {
        System.out.println(notifys.toString());
    }
}


public static void dis7() throws SQLException {
    BMIClassificationDAO dao = new BMIClassificationDAO();
   
    List<BMIClassification> lstBMI = dao.getAllBMI();
    for (BMIClassification bMIClassification : lstBMI) {
        System.out.println(bMIClassification.toString());
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
