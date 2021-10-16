import java.util.*;
import java.sql.*;

public class UserDAO {
	public List<User> getAllUsers() {
		List<User> users = new ArrayList<User>();
		
		Connection con = null;
		Statement st = null;
		ResultSet rs = null;
		
		try {
			con = DbConnect.getConnection();
			st = con.createStatement();
			String sql = "select * from user";
			rs = st.executeQuery(sql);
			
			while(rs.next()) {
				users.add(new User(rs.getLong(1), rs.getString(2), rs.getString(3),rs.getString(4),rs.getString(5)));
			}
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(con!=null)
					con.close();
				if(st!=null)
					st.close();
				if(rs!=null)
					rs.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return users;
	}

	public User findUserByUsername (String username) {
		User fUser = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DbConnect.getConnection();
			String sql = "select * from user where username=?";
			ps = con.prepareStatement(sql);
			ps.setString(1, username);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				fUser = new User(rs.getLong(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
			}
			
			
		}catch(SQLException e) {
			e.printStackTrace();
		}catch(ClassNotFoundException e) {
			e.printStackTrace();
		}finally {
			try {
				if(con!=null)
					con.close();
				if(ps!=null)
					ps.close();
				if(rs!=null)
					rs.close();
			}catch(SQLException e) {
				e.printStackTrace();
			}
		}
		
		return fUser;
	}
}


