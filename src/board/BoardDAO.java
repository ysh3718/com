package board;

import java.sql.*;
import java.util.ArrayList;

import board.BoardDTO;

// �쟾�떖 �뜲�씠�꽣�떒�쐞�씤 (DTO : Data Transfer Object)瑜� �궗�슜�븯硫댁꽌 DB �뜲�씠�꽣瑜� 吏곸젒 泥섎━�븯�뒗
// DAO(Data Access Object)
public class BoardDAO {

	Connection conn = null;
	PreparedStatement pstmt = null;

	/* MySQL �뿰寃곗젙蹂� */
	String jdbc_driver = "com.mysql.jdbc.Driver";
	
	String jdbc_url = "jdbc:mysql://127.0.0.1/jspdb?useSSL=true&verifyServerCertificate=false&serverTimezone=UTC";
	
	/******************************************************************************************/
	// DB�뿰寃� 硫붿꽌�뱶
	/******************************************************************************************/
	void connect() {
		try {
			Class.forName(jdbc_driver);

			conn = DriverManager.getConnection(jdbc_url,"jspbook","1234");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	/******************************************************************************************/
	// DB �뿰寃고빐�젣 硫붿냼�뱶
	/******************************************************************************************/
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	/******************************************************************************************/
	// 寃뚯떆�뙋 �엯�젰 硫붿꽌�뱶
	/******************************************************************************************/
	public boolean insertDB(BoardDTO boardDTO) {
		
		
		connect();
		
		
		// id �뒗 �옄�룞 �벑濡� �릺誘�濡� �엯�젰�븯吏� �븡�뒗�떎.				
			String sql ="insert into BoardR(category, userName,title,ddate,ppasswd, content, groupId) values(?,?,?,?,?,?,?)";		
		try {
			
			pstmt = conn.prepareStatement(sql);

			// SQL臾몄뿉 蹂��닔 �엯�젰
			pstmt.setString(1,boardDTO.getCategory());
			pstmt.setString(2,boardDTO.getUserName());
			pstmt.setString(3,boardDTO.getTitle());
			pstmt.setString(4,boardDTO.getDdate());
			pstmt.setString(5,boardDTO.getPpasswd());
			pstmt.setString(6,boardDTO.getContent());
			pstmt.setInt(7,boardDTO.getGroupId());
			
			//SQL臾� �떎�뻾
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
	
	/******************************************************************************************/
	// 寃뚯떆�뙋紐⑸줉 議고쉶 硫붿꽌�뱶
	/******************************************************************************************/
	public ArrayList<BoardDTO> getDBList() {
		
		connect();
		
		ArrayList<BoardDTO> boardList = new ArrayList<BoardDTO>();
		
		String sql = "select id, category, userName, title, ddate, ppasswd, content, groupId from BoardR order by groupId desc, id asc";
		
		
		//******************************************************************************************************
		// 寃뚯떆湲�怨� �뙎湲��씠 蹂꾨룄 �뀒�씠釉붿씠�씪硫� Union�쓣 �솢�슜�븯�뿬 select
		//*****************************************************************************************************
		//		SELECT 寃뚯떆湲�ID, "notice", 寃뚯떆�옄�꽦紐�, 湲��젣紐�, 湲��궡�슜, 寃뚯떆湲�ID, �옉�꽦�씪�떆
		//		FROM 寃뚯떆�뙋
		//		UNION
		//		SELECT �뙎湲�ID, "reply", �뙎湲��옄�꽦紐�, 湲��젣紐�, 湲��궡�슜, 寃뚯떆湲�ID, �옉�꽦�씪�떆
		//		FROM �뙎湲�
		//		ORDER BY 寃뚯떆湲�ID ASC, �옉�꽦�씪�떆 ASC
		//*****************************************************************************************************

		try {
			
			pstmt = conn.prepareStatement(sql);
			
			//SQL臾� �떎�뻾
			ResultSet rs = pstmt.executeQuery();

			while(rs.next()) {
				
				// DO 媛앹껜 �깮�꽦
				BoardDTO boardDTO = new BoardDTO();
				
				// DB Select寃곌낵瑜� DO 媛앹껜�뿉 ���옣
				boardDTO.setId(rs.getInt("id"));
				boardDTO.setCategory(rs.getString("category"));
				boardDTO.setUserName(rs.getString("userName"));
				boardDTO.setTitle(rs.getString("title"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setDdate(rs.getString("ddate"));
				boardDTO.setPpasswd(rs.getString("ppasswd"));
				boardDTO.setGroupId(rs.getInt("groupId"));

				boardList.add(boardDTO);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return boardList;
	}

	/******************************************************************************************/
	// edit�슜 寃뚯떆�뙋 1嫄� 議고쉶 硫붿꽌�뱶
	/******************************************************************************************/
	public BoardDTO getDB(int id) {
		
		connect();
		
		BoardDTO boardDTO = new BoardDTO();
		
		String sql = "select * from BoardR where id = ? order by id desc";
		
		try {
			
			pstmt = conn.prepareStatement(sql);
			
			// SQL臾몄뿉 議고쉶議곌굔 �엯�젰
			pstmt.setInt(1,id);

			//SQL臾� �떎�뻾
			ResultSet rs = pstmt.executeQuery();

			// �뜲�씠�꽣媛� �븯�굹留� �엳�쑝誘�濡� rs.next()瑜� �븳踰덈쭔 �떎�뻾 �븳�떎.
			rs.next();
			
			// DB Select寃곌낵瑜� DO 媛앹껜�뿉 ���옣
			boardDTO.setId(rs.getInt("id"));
			boardDTO.setCategory(rs.getString("category"));
			boardDTO.setUserName(rs.getString("userName"));
			boardDTO.setTitle(rs.getString("title"));
			boardDTO.setContent(rs.getString("content"));
			boardDTO.setDdate(rs.getString("ddate"));
			boardDTO.setPpasswd(rs.getString("ppasswd"));
			boardDTO.setGroupId(rs.getInt("groupId"));
			
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return boardDTO;
	}


	/******************************************************************************************/
	// 寃뚯떆�뙋 �닔�젙 硫붿꽌�뱶
	/******************************************************************************************/
	public boolean updateDB(BoardDTO boardDTO) {
		
		
		connect();
		
		// id濡� 留ㅼ묶�븯�뿬 update(寃뚯떆�뙋�씪�옄�� 寃뚯떆�뙋湲덉븸留� �닔�젙 媛��뒫)				
		String sql ="update BoardR set userName=?, title=?, content=? where id=?";

		try {
			
			pstmt = conn.prepareStatement(sql);

			// SQL臾몄뿉 蹂��닔 �엯�젰
			pstmt.setString(1,boardDTO.getUserName());
			pstmt.setString(2,boardDTO.getTitle());
			pstmt.setString(3,boardDTO.getContent());
			
			pstmt.setInt(4,boardDTO.getId());
		
			//SQL臾� �떎�뻾
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
	
	/******************************************************************************************/
	// 寃뚯떆�뙋 �궘�젣 硫붿꽌�뱶
	/******************************************************************************************/
	public boolean deleteDB(String category, int id, int groupId) {
		
		
		connect();
		
		String sql;
		// 寃뚯떆湲� �궘�젣
		if(category.equals("notice")) {
			sql ="delete from BoardR where groupId=?";
		// �뙎湲� �궘�젣
		} else {
			sql ="delete from BoardR where id=?";
		}
		
		try {
			
			// 寃뚯떆湲� �궘�젣, GroupId濡� 寃뚯떆�뒳怨� �뙎湲� 紐⑤몢 �궘�젣
			if(category.equals("notice")) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,groupId);
			// �뙎湲� �궘�젣
			} else {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,id);
			}
						
			//SQL臾� �떎�뻾
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
		}
		return true;
	}
	
	
/******************************************************************************************/
// 寃뚯떆�뙋 洹몃９ID 梨꾨쾲 硫붿꽌�뱶
/******************************************************************************************/
public int getNewGroupId() {
	
	connect();
	
	int newGroupId = 0;
	
	String sql = "select distinct groupId from BoardR where groupId = (select MAX(groupId) from BoardR)";
	
	try {
		
		pstmt = conn.prepareStatement(sql);
		
		//SQL臾� �떎�뻾
		ResultSet rs = pstmt.executeQuery();

		
		// 寃뚯떆�뙋 湲��씠 1嫄� �엳�뒗 寃쎌슦
		if(rs.next()) {
			
			newGroupId = rs.getInt("groupId") + 1;
			
		} else {

			newGroupId = 1;
			
		}
		
		System.out.println("groupId : " + newGroupId);
		
		rs.close();
		
	} catch (SQLException e) {
		e.printStackTrace();
	}
	finally {
		disconnect();
	}
	
	return newGroupId;
}

}