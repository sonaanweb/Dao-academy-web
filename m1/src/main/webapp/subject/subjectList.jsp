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
	
	// dao 변수 객체 생성
	SubjectDao subjectDao = new SubjectDao();
	
	// 페이징 2) 전체 페이지
	int totalRow = subjectDao.selectSubjectCnt(); //dao 안 전체row
	int rowPerPage = 2;  // 페이지 당 행의 수
	int beginRow = (currentPage-1) * rowPerPage; //시작 행

	// 페이징 3) 페이지 네비게이션 (하단 페이징)
	int pagePerPage = 5; // 하단 페이징 숫자
	
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
	
	// 불러올 리스트
	ArrayList<Subject> list = subjectDao.selectSubjectListByPage(beginRow, rowPerPage);
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<title>subject List</title>
</head>
<body>
<div class="container mt-3">
<table class="table">
	<tr class="table-primary">
		<td>과목명</td>
		<td>교육시간</td>
	</tr>
<%
	for(Subject s : list){
%>
	<tr>
		<td><%=s.getSubjectName()%></td>
		<td><%=s.getSubjectTime()%>H</td>
	</tr>
<%
	}
%>
</table>
<!---------- 페이징 ----------->
	<%
		if(minPage > 1) { //minpage가 1보다 클때 이전 페이지 출력
	%>
		<!-- 절대주소 사용 (getContextPath) -->
		<!-- 1페이지가 1이면 '이전'이 나오지 않아야 한다 -->
		<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=minPage-pagePerPage%>">이전</a>
	<%
			}
		for(int i = minPage; i<=maxPage; i=i+1) {
			if(i == currentPage){
	%>
			<span><%=i%></span>		
	<%			
			}else{	
	%>
		<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=i%>"><%=i%></a>
	<%
			}
		}
		
		if(maxPage != lastPage) { // maxpage와 lastpage가 같지 않을 때 다음 출력
	%>
		<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=minPage+pagePerPage%>">다음</a>
		<!-- maxPage+1을 해도 결과물은 같다 -->
		<!-- 마지막 페이지에선 다음이 없어야 한다 -->
	<%
		}
	%>
</div>
</body>
</html>