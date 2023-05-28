<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<!-- view : id/name/history/update/createdate-->
<%
	// 유효성 검사
	if(request.getParameter("teacherNo") == null
	||request.getParameter("teacherNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");
		return;	
	}
	
	// 받아온 값 저장 & 메서드 호출
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	TeacherDao teacher = new TeacherDao();
	
	// Teacher 객체 변수에 저장
	Teacher one = teacher.selectTeacherOne(teacherNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>강사 정보</title>
<style>
a{text-decoration: none;}
#bar {background-color: #FAECC5;}
</style>
</head>
<body>
<div class="container mt-3">
<br><br><br>
<h2 style="text-align: center;">강사 정보</h2>
<br>
<table class="table table-bordered">
	<tr>
		<td id="bar">teacher_no</td>
		<td><%=one.getTeacherNo()%>
		</td>
	</tr>
	<tr>
		<td id="bar">ID</td>
		<td><%=one.getTeacherId()%></td>
	</tr>
	<tr>
		<td id="bar">이름</td>
		<td><%=one.getTeacherName()%></td>
	</tr>
	<tr>
		<td id="bar">history</td>
		<td><%=one.getTeacherHistory()%></td>
	</tr>
	<tr>
		<td id="bar">createdate</td>
		<td><%=one.getCreatedate()%></td>
	</tr>
	<tr>
		<td id="bar">updatedate</td>
		<td><%=one.getUpdatedate()%></td>
	</tr>
</table>
<a href="<%=request.getContextPath()%>/teacher/teacherList.jsp?teacherNo=<%=one.getTeacherNo()%>" class="btn btn-light">목록</a>
<a href="<%=request.getContextPath()%>/teacher/teacherUpdate.jsp?teacherNo=<%=one.getTeacherNo()%>" class="btn btn-light">수정</a>
<a href="<%=request.getContextPath()%>/teacher/teacherDelete.jsp?teacherNo=<%=one.getTeacherNo()%>" class="btn btn-outline-light text-dark" style="float: right;">삭제</a>
</div>
</body>
</html>