<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="java.util.Date" %>
 <%@page import="java.text.SimpleDateFormat" %>
<!-- 오류 페이지 정의  -->
<%@ page errorPage="board_error.jsp" %>

<!-- 자바 클래스 Import  -->
<%@ page import = "board.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<%


Date now = new Date();
SimpleDateFormat sf = new SimpleDateFormat("yyyy년MM월dd일 E요일 a hh:mm:ss");

String today = sf.format(now);

	// request 내장객체에서 boardDTO get하여 클래스 변수에 저장()
	BoardDTO boardDTO = (BoardDTO)request.getAttribute("boardDTO");
	
	// edit가 아닌 add인 경우는 DTO 객체 생성
	if(boardDTO == null) {
		boardDTO = new BoardDTO();
	}
	%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>게시판</title>
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/custom.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
	<script type="text/javascript">

		// window.load는 페이지 로딩 후 실행
		window.onload = function() {
			
			var action = document.form1.action.value;
		
		
			if(action=="edit") {
				document.getElementById("insert").disabled=true;
				// document.getElementById("update").disabled=false;
				// document.getElementById("delete").disabled=false;
				// document.getElementById("reply").disabled=false;
				
			} else if(action=="add") {
				// document.getElementById("insert").disabled=false;
				document.getElementById("update").disabled=true;
				document.getElementById("delete").disabled=true;
				document.getElementById("reply").disabled=true;
			}
		} 
	
		function insertcheck() {
			// post방식
			document.form1.action.value="insert";
			document.form1.submit();
		}
	
		function updatecheck() {
			var inrepasswd = $('#reppasswd').val();
			// post방식
		if(<%= boardDTO.getPpasswd() %>!=inrepasswd){
			alert('비번을 다시 입력해주세요');
		}else{
			document.form1.action.value="update";
			document.form1.submit();}
		}
	
		function deletecheck() {
			var inrepasswd = $('#reppasswd').val();
			// post방식
		if(<%= boardDTO.getPpasswd() %>!=inrepasswd){
			alert('비번을 다시 입력해주세요');
		}else{
			result = confirm("정말로 삭제하시겠습니까 ?");
		
			if(result == true){
				
				// post방식
				document.form1.action.value="delete";
				document.form1.submit();
			}
			else
				return;
		}
			}
		
		function replycheck() {
			// post방식
			document.form1.action.value="reply";
			document.form1.submit();
		}

	</script>

</head>




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
	<!-- 게시판 등록용 -->
	<form name="form1" method="post" action=board_control.jsp>
	
		<%

			// action구분 등 파라메터(add 또는 edit)
			String action = request.getParameter("action");
			
			// action이 add이면 값 초기화
			if(action.equals("add")) {
				boardDTO.setUserName("");
				boardDTO.setTitle("");
				boardDTO.setContent("");
				boardDTO.setPpasswd("");
			}
			
		%>
		<input type="hidden" name="action" value="<%= action %>">
		<input type="hidden" name="id" value="<%= boardDTO.getId() %>">
		<input type="hidden" name="category" value="reply">
		<input type="hidden" name="groupId" value="<%= boardDTO.getGroupId() %>">
		<input type="hidden" name="ddate" value="<%= today%>">
		<table class = "table table:striped" style="text-align: center; border: 1px solid #dddddd">
		<thead>
 			<tr>
 				<th colspan="3" style = "background-color :#eeeeee; text-align: center;">Q&A 댓글 수정</th>
 			</tr>
 		</thead>
			<tr>
				<th>제목</th>
				<td style="border-right : 1px solid #dddddd"><input class="form-control" type=text size=20 name=title value="<%= boardDTO.getTitle() %>"></td>				
			</tr>
			<tr>
				<th>성명</th>
				<td style="border-right : 1px solid #dddddd"><input class="form-control" type=text size=20 name=userName value="<%= boardDTO.getUserName() %>"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td style="border-right : 1px solid #dddddd"><textarea class="form-control" name="content" maxlength="2048" style="height: 350px"><%= boardDTO.getContent() %></textarea></td>
			</tr>
			<%if(boardDTO.getPpasswd()==null||boardDTO.getPpasswd()==""){%>
			<tr>
				<th>비번</th>
				<td style="border-right : 1px solid #dddddd"><input class="form-control" type=password size=100 id="ppasswd" name=ppasswd value="<%= boardDTO.getPpasswd() %>"></td>
			</tr>
			<%}else{ %>
			<tr>
				<th>비번확인</th>
				<td style="border-right : 1px solid #dddddd"><input class="form-control" type=password size=100 id="reppasswd" name=reppasswd value=""></td>
			</tr>
			<%} %>
		</table>
		<a href="board_list.jsp" class="btn btn-primary pull-right">돌아가기</a>
		<input style="margin-right: 3px;" class="btn btn-primary pull-right" type="button" id="delete" value="삭제" onClick="deletecheck()">
		<input style="margin-right: 3px;" class="btn btn-primary pull-right" type="button" id="update" value="수정" onClick="updatecheck()">	
	</form>
	</div>
	</div>
 <!-- 애니매이션 담당 JQUERY -->
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> 
 <!-- 부트스트랩 JS  -->
 <script src="js/bootstrap.js"></script>
</body>
</html>