<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page errorPage="board_error.jsp" %>
 
 <!-- 자바 클래스 Import  -->
<%@ page import = "board.*" %>
<%@ page import = "java.util.ArrayList" %>

<%-- request 내장객체의 한글 인코딩 --%>    
<% request.setCharacterEncoding("UTF-8"); %>

 
<%
 	// DAO 메소드 호출을 위하여 객체 생성
  	BoardDAO boardDAO = new BoardDAO();

   	// 자료전달에 필요한 DTO 객체 생성
   	BoardDTO boardDTO = new BoardDTO();
   	
      // action구분 파라메터
   	String action = request.getParameter("action");
      
   	// 글구분 파라메터
    String category = request.getParameter("category");
   	
     // 입력 또는 수정인 경우 화면 	화면 HTML 값을 DTO 객체에 저장
      if(action.equals("insert") || action.equals("update")) {
   		
    	  boardDTO.setId(Integer.parseInt(request.getParameter("id")));
    	  boardDTO.setCategory(request.getParameter("category"));
    	  boardDTO.setUserName(request.getParameter("userName"));
    	  boardDTO.setTitle(request.getParameter("title"));
    	  boardDTO.setDdate(request.getParameter("ddate"));
    	  boardDTO.setPpasswd(request.getParameter("ppasswd"));
    	  boardDTO.setContent(request.getParameter("content"));
    	  boardDTO.setGroupId(Integer.parseInt(request.getParameter("groupId")));
      }
      
      // 게시글 입력인 경우 그룹ID 채번
      if(action.equals("insert") && category.equals("notice")) {

      	int newGroupId = boardDAO.getNewGroupId();
  		boardDTO.setGroupId(newGroupId);
      }
      
      // 댓글 입력인 경우 게시글 그룹ID Setting
      if(action.equals("insert") && category.equals("reply")) {

    	int noticeGroupId = Integer.parseInt(request.getParameter("noticeGroupId"));
    	boardDTO.setGroupId(noticeGroupId);
      }
      
   
      ///////////////////////////////////////////
      // action에 따라 각각 처리
      /////////////////////////////////////////// 
   	if (action.equals("add")) {

   		// 게시판 입력화면 오픈
   		pageContext.forward("board_view.jsp?action=add");

   	} else if (action.equals("reply")) {
   		
       int groupId = Integer.parseInt(request.getParameter("groupId"));
  		
       // 댓글 입력화면 오픈, 댓글 입력이므로 게시글 그룹ID를 파라메터로 넘김
   		pageContext.forward("boardreply_view.jsp?action=add&groupId=" + groupId);
   		
   		
   	} else if (action.equals("insert")) {

  		// 게시판 입력
   		if (boardDAO.insertDB(boardDTO)) {

   			// 조회를 위하여 controll 호출
   			pageContext.forward("board_control.jsp?action=list");
   		} else {
   			throw new Exception("DB 입력오류");
   		}

   	} else if (action.equals("list")) {
   		
   	//자동조회를위한 값생성
		request.setAttribute("A", "A");

   		// 게시판 조회결과
   		ArrayList<BoardDTO> boardList = boardDAO.getDBList();

   		// List를 setAttribute
   		request.setAttribute("boardList", boardList);
   		pageContext.forward("board_list.jsp");
   	} else if (action.equals("edit")) {

   		// edit용 1건을 select
   		boardDTO = boardDAO.getDB(Integer.parseInt((String) request.getParameter("id")));

   		// edit를 setAttribute
   		request.setAttribute("boardDTO", boardDTO);
   		
   		// 게시글 edit와 댓글 edit 구분하여 화면 open
   		if(boardDTO.getCategory().equals("notice")) {
   	 		pageContext.forward("board_view.jsp?action=edit");
   		} else {
   			pageContext.forward("boardreply_view.jsp?action=edit");
   		}
   			

   	}else if (action.equals("viewUpdate")) {

   		// edit용 1건을 select
   		boardDTO = boardDAO.getDB(Integer.parseInt((String) request.getParameter("id")));

   		// edit를 setAttribute
   		request.setAttribute("boardDTO", boardDTO);
   		
   		if(boardDTO.getCategory().equals("notice")) {
   	 		pageContext.forward("board_update.jsp?action=viewUpdate");
   		}

   	}else if (action.equals("re_updatev")) {

   		// edit용 1건을 select
   		boardDTO = boardDAO.getDB(Integer.parseInt((String) request.getParameter("id")));

   		// edit를 setAttribute
   		request.setAttribute("boardDTO", boardDTO);
   		
   		if(boardDTO.getCategory().equals("reply")) {
   	 		pageContext.forward("boardreply_update.jsp?action=re_updatev");
   		}

   	}else if (action.equals("update")) {

   		// 게시판 수정
   		if (boardDAO.updateDB(boardDTO)) {

   			// 조회를 위하여 controll 호출
   			pageContext.forward("board_control.jsp?action=list");
   		} else {
   			throw new Exception("DB 수정오류");
   		}

   	} else if (action.equals("delete")) {

   		// 게시판 삭제
   		if (boardDAO.deleteDB(request.getParameter("category"), Integer.parseInt((String) request.getParameter("id")), Integer.parseInt((String) request.getParameter("groupId"))) ) {

   			// 조회를 위하여 controll 호출
   			pageContext.forward("board_control.jsp?action=list");
   		} else {
   			throw new Exception("DB 삭제오류");
   		}

   	} else {

   		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");

   	}
      
 %> 
 
