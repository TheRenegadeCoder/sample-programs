
public class User {
	private Long id;
	private String name;
	private String contactDetail;
	private String username;
	private String password;
	
	public User() {}
	
	public User(Long id, String name, String contactDetail, String username, String password) {
		super();
		this.id = id;
		this.name = name;
		this.contactDetail = contactDetail;
		this.username = username;
		this.password = password;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getContactDetail() {
		return contactDetail;
	}

	public void setContactDetail(String contactDetail) {
		this.contactDetail = contactDetail;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", contactDetail=" + contactDetail + ", username=" + username
				+ ", password=" + password + "]";
	}
}
