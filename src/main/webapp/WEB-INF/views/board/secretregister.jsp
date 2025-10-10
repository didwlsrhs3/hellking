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
			<input type="text" name="nickname" required >
		</div>
		<div>
			<input type="submit" value="글 작성">
		</div>
	</form>
</body>
</html>











=======
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/registerstyle.css">
<meta charset="UTF-8">
<title>익명 게시판 - 글쓰기</title>
</head>
<body>
<div class="form-container">
  <h2>익명 게시글 작성</h2>
  <form action="secretregister" method="post">
  
  <input type="hidden" name="boardType" value="secret">
    <div>
      <label>제목</label>
      <input type="text" name="title" required>
    </div>
    <div>
      <label>작성자(닉네임)</label>
      <input type="text" name="nickname" required>
    </div>
    <div>
      <label>비밀번호</label>
      <input type="password" name="password" required>
      <p class="desc">※ 수정/삭제 시 필요합니다.</p>
    </div>
    <div>
      <label>내용</label>
      <textarea name="content" rows="10" required></textarea>
    </div>
    <!-- 버튼 -->
    <div class="form-actions">
      <input type="submit" value="글 작성">
    </div>
  </form>
</div>
</body>
</html>
>>>>>>> b65c320 (Initial commit)
