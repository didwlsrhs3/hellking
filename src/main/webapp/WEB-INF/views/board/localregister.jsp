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
			<select id="category" onchange="findCategory()">
				<option value="1">서울</option>
				<option value="2">부산</option>
				<option value="3">대구</option>
				<option value="4">인천</option>
				<option value="5">광주</option>
				<option value="6">대전</option>
				<option value="7">울산</option>
				<option value="8">수원</option>
				<option value="9">성남</option>
				<option value="10">청주</option>
				<option value="11">천안</option>
				<option value="12">전주</option>
				<option value="13">군산</option>
				<option value="14">순천</option>
				<option value="15">목포</option>
				  <!-- 나머지 지역 -->
			</select>
				</div>
		<div>
			<label>내용</label>
			<textarea name="content" required rows="5" cols="20"></textarea>
		</div>
		<div>
			<label>작성자</label>
			<input type="text" name="nickname" required >
		</div>
		<div>
			<input type="submit" value="글 작성">
		</div>
	</form>
</body>
</html>











