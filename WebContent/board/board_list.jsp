<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 오류 페이지 정의  -->
<%@ page errorPage="board_error.jsp" %>

<!-- 자바 클래스 Import  -->
<%@ page import = "board.*" %>
<%@ page import = "java.util.ArrayList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>게시판</title>

	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/custom.css">
	<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
	<style type="text/css">
	a, a:hover{
	color : #000000;
	text-decoration : none;
	}
	</style>
	<!-- 자동조회를위한 값 받아오기  -->
	<% String A = (String)request.getAttribute("A"); %>

	<script type="text/javascript">
	
	//자동조회를위한 조건문
	$(function(){
		if(<%=A%> != "A") {
			document.form1.action.list;
			document.form1.submit();
		} 
	});
		
		function retrivalcheck() {
			
			// get방식
			// document.location.href="addr_control.jsp?action=list";
			
			// post방식 디펄트가 list
			document.form1.action.value="list";
			document.form1.submit();
	
			
		}
	
		function editcheck(id) {
		
			// get방식
			// document.location.href="addr_control.jsp?action=edit&id="+id;
			
			// post방식
			document.form1.action.value="edit";
			document.form1.id.value=id;
			document.form1.submit();
	
		}
	</script>

</head>

<%
	// request 내장객체에서 accountTransferList를 get하여 클래스 변수에 저장
	ArrayList boardList = (ArrayList)request.getAttribute("boardList");

%>


<body>
 <nav class="navbar navbar-default">
  <div class="navbar-header">
   <button type="button" class="navbar-toggle collapsed" 
    data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
    aria-expaned="false">
     <span class="icon-bar"></span>
     <span class="icon-bar"></span>
     <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="board_list.jsp">Q&A</a>
  </div>
  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
   <ul class="nav navbar-nav">
    <li class="active"><a href="board_list.jsp">Q&A</a></li>
   </ul>
   </div> 
 </nav>
	<div class="container">
 		<div class="row">
	<!-- 게시판 목록 조회폼 -->
	<form name="form1" method="post" action="board_control.jsp">
		<input type="hidden" name="action" value="list">
		<input type="hidden" name="id" value=0>
	
		<table width = "100%" class = "table table-striped" style="text-align: center; border : 1px solid #dddddd">
			<tr>
				<th width = "15%" style = "background-color :#eeeeee; text-align: center;">글구분</th>
				<th width = "30%" style = "background-color :#eeeeee; text-align: center;">제목</th>
				<th width = "0" style = "background-color :#eeeeee; text-align: center; display: none;">내용</th>
				<th width = "20%" style = "background-color :#eeeeee; text-align: center;">성명</th>
				<th style = "background-color :#eeeeee; text-align: center;">작성날짜</th>
			</tr>
			<%
				if(boardList != null) {
					
						// boardList 변수 List 반복처리
						for(BoardDTO boardDTO : (ArrayList<BoardDTO>) boardList) {
				if((boardDTO.getCategory()).equals("notice")) {			
			%>
			<tr class="tbody">
							<td><a href="javascript:editcheck(<%=boardDTO.getId() %>)">Q.질문</a></td>
							<td style="text-align:left;"><a href="javascript:editcheck(<%=boardDTO.getId() %>)"><%=boardDTO.getTitle() %></a></td>			
			<%
				} else {
			%>
							<td>A.답변</td>				
							<td style="text-align:left;"><a href="javascript:editcheck(<%=boardDTO.getId() %>)"><%=boardDTO.getTitle() %></a></td>
			<%
				} 
			%>
							<td style = "display: none;"><%=boardDTO.getContent() %></td>
							<td><%=boardDTO.getUserName() %></td>
							<td style = "display: none;"><%=boardDTO.getGroupId() %></td>
							<td><%=boardDTO.getDdate() %></td>
						</tr>
			<%	
					}
				}
			%>
			</table>
		</form>
			<a href="board_control.jsp?action=add" class="btn btn-primary pull-right">글쓰기</a>
 		</div>
 	</div>
 <!-- 애니매이션 담당 JQUERY -->
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <!-- 부트스트랩 JS  -->
 <script src="js/bootstrap.js"></script>
</body>

</html>