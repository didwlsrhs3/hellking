<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
>>>>>>> b65c320 (Initial commit)
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<<<<<<< HEAD
<meta charset="UTF-8">
<title>지역게시판 게시글 수정</title>
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
			<label>WRITER</label>
			<input type="text" name="writer" required value="${boardVO.writer}">
		</div>
		<div>
			<input type="submit" value="글 수정">
		</div>
	</form>
</body>
</html>











=======
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardstyle.css">
<meta charset="UTF-8">
<title>지역 게시판 - 수정</title>
</head>
<body>
<div class="form-container">
  <h2>지역 게시글 수정</h2>
  <form action="localmodify" method="post">
    <input type="hidden" name="bno" value="${board.bno}">
    <div>
      <label>제목</label>
      <input type="text" name="title" value="${board.title}" required>
    </div>
    <div>
      <label>작성자</label>
      <input type="text" name="nickname" value="${board.nickname}" required>
    </div>
    <div>
      <label>지역 선택</label>
      <select name="categoryId" required>
        <option value="1" ${board.categoryId == 1 ? "selected" : ""}>서울</option>
        <option value="2" ${board.categoryId == 2 ? "selected" : ""}>부산</option>
        <option value="3" ${board.categoryId == 3 ? "selected" : ""}>대구</option>
        <option value="4" ${board.categoryId == 4 ? "selected" : ""}>인천</option>
        <option value="5" ${board.categoryId == 5 ? "selected" : ""}>광주</option>
        <option value="6" ${board.categoryId == 6 ? "selected" : ""}>대전</option>
        <option value="7" ${board.categoryId == 7 ? "selected" : ""}>울산</option>
        <option value="8" ${board.categoryId == 8 ? "selected" : ""}>수원</option>
        <option value="9" ${board.categoryId == 9 ? "selected" : ""}>성남</option>
        <option value="10" ${board.categoryId == 10 ? "selected" : ""}>청주</option>
        <option value="11" ${board.categoryId == 11 ? "selected" : ""}>천안</option>
        <option value="12" ${board.categoryId == 12 ? "selected" : ""}>전주</option>
        <option value="13" ${board.categoryId == 13 ? "selected" : ""}>군산</option>
        <option value="14" ${board.categoryId == 14 ? "selected" : ""}>순천</option>
        <option value="15" ${board.categoryId == 15 ? "selected" : ""}>목포</option>
      </select>
    </div>
    <div>
      <label>내용</label>
      <textarea name="content" rows="10" required>${board.content}</textarea>
    </div>
    <button type="submit">수정 완료</button>
  </form>
</div>
</body>
</html>
>>>>>>> b65c320 (Initial commit)
