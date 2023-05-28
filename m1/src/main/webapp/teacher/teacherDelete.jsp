<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	// 유효성 검사 (teacherNo)
	if(request.getParameter("teacherNo") == null
	||request.getParameter("teacherNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");
		return;	
	}

	// 값 저장 & 메서드 호출
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	TeacherDao delTeacher = new TeacherDao();
	
	// delete action 변화 행, 불러온 dao에 있는 deleteTeacher int값이 행 변수에 들어간다
	int row = delTeacher.deleteTeacher(teacherNo);

	if(row == 1){
		System.out.println("강사정보 삭제 완료");
	}
	
	response.sendRedirect(request.getContextPath() + "/teacher/teacherList.jsp");
%>