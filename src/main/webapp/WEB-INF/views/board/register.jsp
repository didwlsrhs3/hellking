<!-- register.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
<body>
	<h1>게시글 작성</h1>
	<form method="POST">
		<div>
			<label>제목</label>
			<input type="text" name="title" required >
		</div>
		<div>
			<label>내용</label>
			<textarea name="content" required rows="5" cols="20"></textarea>
		</div>
		<div>
			<label>작성자</label>
			<input type="text" name="writer" required >
		</div>
		<div>
			<input type="submit" value="글 작성">
		</div>
	</form>
</body>
</html>











