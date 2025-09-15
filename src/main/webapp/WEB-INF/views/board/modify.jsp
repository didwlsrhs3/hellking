<!-- modify.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MODIFY</title>
</head>
<body>
	<!-- model : boardVO -->
	<h1>게시글 수정 - 글번호 ${boardVO.bno}</h1>
	<form method="POST">
		<input type="hidden" name="bno" value="${boardVO.bno}">
		<div>
			<label>TITLE</label>
			<input type="text" name="title" required value="${boardVO.title}">
		</div>
		<div>
			<label>CONTENT</label>
			<textarea name="content" required rows="5" cols="20">${boardVO.content}</textarea>
		</div>
		<div>
			<label>NICKNAME</label>
			<input type="text" name="writer" required value="${boardVO.nickname}">
		</div>
		<div>
			<input type="submit" value="글 수정">
		</div>
	</form>
</body>
</html>











