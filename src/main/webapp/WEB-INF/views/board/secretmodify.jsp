<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardstyle.css">
<meta charset="UTF-8">
<title>익명 게시판 - 수정</title>
</head>
<body>
<div class="form-container">
  <h2>익명 게시글 수정</h2>
  <form action="secretmodify" method="post">
    <input type="hidden" name="bno" value="${board.bno}">
    <div>
      <label>제목</label>
      <input type="text" name="title" value="${board.title}" required>
    </div>
    <div>
      <label>작성자(닉네임)</label>
      <input type="text" name="nickname" value="${board.nickname}" required>
    </div>
    <div>
      <label>비밀번호</label>
      <input type="password" name="password" required>
      <p class="desc">※ 원래 설정한 비밀번호와 일치해야 수정됩니다.</p>
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
