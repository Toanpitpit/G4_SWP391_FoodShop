
import com.example.servlet.dao.AccountDAO;
import com.example.servlet.dao.BMIClassificationDAO;
import com.example.servlet.dao.BlogDAO;
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
    }
    public static void dis() throws SQLException{
        BlogDAO _dao = new BlogDAO();
        List<MonthlyStat> typeStats = new ArrayList<>();
       List<Blogs> lstBlog = _dao.getBlogsByFilter("", 5, true,null);
        
        for(Blogs b : lstBlog){
            System.out.println(b.toString());
            System.out.println("Bai moi ne");
        }
//        typeStats = _dao.countByTypeBMI(-3);
//        for (MonthlyStat typeStat : typeStats) {
//            System.out.println(typeStat.toString());
//        }
    }
   public static void dis2() {
    BlogDAO _dao = new BlogDAO();
    Blogs testBlog = new Blogs(
    11, // blogID
    9,  // authorID
    "Nguyễn Văn Dũng", // authorName
    2,  // bmiId
    "Test update moi ne truoc deu th ", // title
    "https://example.com/imascdumay.jpg", // imageUlr
    "Nội dung chi tiết về chế độ ăn theo BMI.", // content
    "Private", // status
    new Timestamp(System.currentTimeMillis()), // create_at
    new Timestamp(System.currentTimeMillis())  // update_at
);

     System.out.println(testBlog);
//     _dao.insertBlog(testBlog);
     _dao.updateBlog(testBlog);
    
}
   public static void dis3() {
    BlogDAO _dao = new BlogDAO();
    _dao.deleteBlogByID(11);
}
public static void dis4() {
    RequestDAO _dao = new RequestDAO();
    List<Requests> lstR = _dao.getRequestByFilter(-3,"" , null);
    if(lstR.isEmpty()){
        System.out.println("deo có du lieu");
    }
    for (Requests requests : lstR) {
        System.out.println(requests.toString());
    }
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
    BMIClassification b = dao.getBMIByID(2);
    System.out.println(b.toString());
}
}
