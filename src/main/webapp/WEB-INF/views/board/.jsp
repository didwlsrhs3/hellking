<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr>
			<th>인기 게시글</th>
		</tr>
		<tr>
			<td>주간 최신 인기글을 만나보세요</td>
		</tr>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
		</tr>
		<c:forEach items="${list}" var="list">
			<tr>
				<td>${list.bno}</td>
				<td>${list.title}</td>
				<td>${list.writer}</td>
				<td>${list.regdate}</td>
				<td>${list.viewcnt}</td>
				<td>${list.agree}</td>
			</tr>
		</c:forEach>
		
	</table>
	<div class="category">게시판
		<aside class="category-menu">
			<ul>
				<li><a href="${pageContext.request.contextPath}/board/freeboard">자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/board/secretboard">익명게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/board/localboard">지역게시판</a></li>
				
			</ul>
		</aside>
	
	
	</div>
		

</body>
</html>