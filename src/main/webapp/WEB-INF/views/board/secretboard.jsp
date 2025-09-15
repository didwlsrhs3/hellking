<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardstyle.css">
<meta charset="UTF-8">
<title>익명게시판</title>
</head>
<body>
			<button onclick="location.href='secretregister';">게시물 작성</button>
		<table>
		<tr>
			<th class="boardtitle">익명 게시글</th>
		</tr>
		<tr>
			<td>모든 익명게시글 테이블</td>
		</tr>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
		</tr>
		<c:forEach items="${allList}" var="list">
			<tr>
				<td>${list.bno}</td>
				<td><a href="secretreadPage?bno=${list.bno}">${list.title}</a></td>
				<td>${list.nickname}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.regdate}" /></td>
				<td>${list.viewcnt}</td>
				<td>${list.agree}</td>
			</tr>
		</c:forEach>
	</table>
	
	<table></table>
	<div class="category">게시판
		<aside class="category-menu">
			<ul>
				<li><span>익명게시판</span></li>
				<li><a href="${pageContext.request.contextPath}/board/freeboard">자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/board/localboard">지역게시판</a></li>
				
			</ul>
		</aside>
	
	
	</div>
		

</body>
</html>