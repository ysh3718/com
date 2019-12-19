package board;

public class BoardDTO {

	// set, get에서 사용하는 필드 정의
	private int id;
	private String category;
	private String userName;
	private String title;
	private String ddate;
	private String ppasswd;
	private String content;
	private int groupId;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	public String getDdate() {
		return ddate;
	}
	public void setDdate(String ddate) {
		this.ddate = ddate;
	}
	public String getPpasswd() {
		return ppasswd;
	}
	public void setPpasswd(String ppasswd) {
		this.ppasswd = ppasswd;
	}
	
	
	
		
		
}
