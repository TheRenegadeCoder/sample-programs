import java.sql.*;

public class JdbcUsingSQLite_1 {
    public static void main(String[] args) {
        try {
            Class.forName("org.sqlite.JDBC");

            Connection con = DriverManager.getConnection("jdbc:sqlite:C:/sqlite/univ.db", "satyam", "12345");

            //1. first way
            Statement sm = con.createStatement();

            ResultSet rs = sm.executeQuery("select *from dept");

            while (rs.next()) {
                System.out.println(rs.getInt("deptno") + " " + rs.getString("dename"));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
