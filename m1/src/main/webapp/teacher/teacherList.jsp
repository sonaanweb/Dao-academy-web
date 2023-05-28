<%@page import="javax.websocket.OnError"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 페이징 1) 현재페이지
	int currentPage = 1; // 페이지 시작은 1
	if(request.getParameter("currentPage")!=null){ // 유효한 값이면 정상 출력
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	// 페이징 2) 전체 페이지
	TeacherDao teacherDao = new TeacherDao();
	int totalRow = teacherDao.selectTeacherCnt(); //dao 안 전체row
	int rowPerPage = 5;  // 페이지 당 행의 수
	int beginRow = (currentPage-1) * rowPerPage; //시작 행
	
	// 페이징 3) 페이지 네비게이션 (하단 페이징)
	int pagePerPage = 2; // 하단 페이징 숫자
	
	int lastPage = totalRow / rowPerPage; //마지막 페이지
	if(totalRow % rowPerPage != 0){ // 나누어 떨어지지 않으면 페이지 +1 하여 넘어감
		lastPage = lastPage + 1;
	}
	
	// minpage : 하단 페이징 가장 작은 수
	int minPage = ((currentPage -1) / pagePerPage) * pagePerPage + 1;
	
	// maxpage : 하단 페이징 가장 큰 수
	int maxPage = minPage + pagePerPage -1;
	if(maxPage > lastPage) {
		maxPage = lastPage;
	}

	ArrayList<HashMap<String,Object>> list = teacherDao.selectTeacherListByPage(beginRow, rowPerPage); 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>강사 목록</title>
<style>
td{text-align: center;}
a{text-decoration: none;}
</style>
</head>
<body>
<div class="container mt-3">
<br><br><br>
<h2 style="text-align: center;">강사 목록</h2>
<br>
<table class="table">
	<tr style="background-color: #FAECC5;">
		<td>teacher_no</td>
		<td>ID</td>
		<td>이름</td>
		<td>과목명</td>
	</tr>
<%
	for(HashMap<String,Object> t : list){
%>
	<tr>
		<td>
		<a href="<%=request.getContextPath()%>/teacher/teacherOne.jsp?teacherNo=<%=t.get("teacherNo")%>">
		<%=t.get("teacherNo")%>
		</a>
		</td>
		<td><%=t.get("teacherId")%></td>
		<td><%=t.get("teacherName")%></td>
		<td><%=t.get("subjectName")%></td>
	</tr>
<%
	}
%>
</table>
<!---------- 페이징 ----------->
	<div id="page" style="text-align: center;">
	<%
		if(minPage > 1) { //minpage가 1보다 클때 이전 페이지 출력
	%>
		<a href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=minPage-pagePerPage%>"
		class="btn btn-outline-light text-dark">이전</a>
	<%
			}
		for(int i = minPage; i<=maxPage; i=i+1) {
			if(i == currentPage){
	%>
			<span class="btn btn-outline-light text-dark"><%=i%></span>		
	<%			
			}else{	
	%>
		<a href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=i%>"
		class="btn btn-outline-light text-dark"><%=i%></a>
	<%
			}
		}
		
		if(maxPage != lastPage) { // maxpage와 lastpage가 같지 않을 때 다음 출력
	%>
		<a href="<%=request.getContextPath()%>/teacher/teacherList.jsp?currentPage=<%=minPage+pagePerPage%>"
		class="btn btn-outline-light text-dark">다음</a>
	<%
		}
	%>
	</div>
</div>
</body>
</html>