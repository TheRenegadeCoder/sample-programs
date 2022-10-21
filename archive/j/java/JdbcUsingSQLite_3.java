//  SQLite does not support CALLABLESTATEMENT

import java.sql.*;

public class JdbcUsingSQLite_3 {
    public static void main(String[] args) {
        try {
            Class.forName("org.sqlite.JDBC");

            Connection con = DriverManager.getConnection("jdbc:sqlite:C:/sqlite/univ.db");

            //3.
            CallableStatement stm = con.prepareCall("select *from dept where deptno=10");

            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                System.out.println(rs.getInt("deptno") + " " + rs.getString(2));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}


