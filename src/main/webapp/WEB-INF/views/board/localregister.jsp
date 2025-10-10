<<<<<<< HEAD
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











=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ page session="true" %>
<%
  String nickname = "";
  Object userObj = session.getAttribute("loginUser");
  if (userObj != null) {
    net.koreate.hellking.user.vo.UserVO user = (net.koreate.hellking.user.vo.UserVO) userObj;
    nickname = user.getUsername(); // 실제 닉네임 필드명 확인 후 수정
  }
%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/registerstyle.css">
  <meta charset="UTF-8">
  <title>지역 게시판 - 글쓰기</title>
</head>
<body>
<div class="form-container">
  <h2>지역 게시글 작성</h2>

  <form action="localregister" method="post" enctype="multipart/form-data">
    <!-- 게시판 구분 -->
    <input type="hidden" name="boardType" value="local">

    <!-- 제목 -->
    <div>
      <label for="title">제목</label>
      <input type="text" id="title" name="title" required>
    </div>

    <!-- 내용 -->
    <div>
      <label for="content">내용</label>
      <textarea id="content" name="content" rows="10" required></textarea>
    </div>

    <!-- 작성자 -->
    <div>
      <label for="nickname">작성자</label>
      <input type="text" id="nickname" name="nickname" value="<%=nickname%>" readonly required>
    </div>

    <!-- 지역 선택 -->
    <div>
      <label for="categoryId">지역 선택</label>
      <select id="categoryId" name="categoryId" required>
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
      </select>
    </div>

    <!-- 첨부파일 -->
    <div>
      <label for="uploadFile">첨부파일</label>
      <input type="file" name="uploadFile" id="uploadFile" multiple>
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
