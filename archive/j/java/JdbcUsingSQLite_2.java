import java.sql.*;
import java.util.Scanner;

public class JdbcUsingSQLite_2 {
    public static void main(String[] args) {
        try {
            Class.forName("org.sqlite.JDBC");

            Connection con = DriverManager.getConnection("jdbc:sqlite:C:/sqlite/univ.db");

            //2. second way
            PreparedStatement stm = con.prepareStatement("select *from dept where deptno=?");

            Scanner sc = new Scanner(System.in);
            System.out.print("Enter deparatment no : ");
            int input = sc.nextInt();

            stm.setInt(1, input);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                System.out.println(rs.getInt("deptno") + " " + rs.getString(2));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}

