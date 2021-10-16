import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.*;

public class Main {	
	public static void main(String[] args) {
		UserDAO userDAO = new UserDAO();
		List<User> users = new ArrayList<User>();
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		// Get all the users exist on the database
		users = userDAO.getAllUsers();
		System.out.println("Id\t\tName\t\tContact Detail\t\tUsername");
		for (User user : users) {
			System.out.println(user.getId() + "\t\t" + user.getName() + "\t\t" + user.getContactDetail() + "\t\t" + user.getUsername());
		}
		
		//Get a user by username
		try {
			String username = br.readLine();
			User fUser = userDAO.findUserByUsername(username);
			if(fUser!=null) {
				System.out.println("User found");
				
				System.out.println("Do you want to update the user ?");
				String name = br.readLine();
			}
			else
				System.out.println("usr not found");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
