<!-- register.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<<<<<<< HEAD
<!DOCTYPE html>
<html>
<head>
=======
<%@ page session="true" %>
<%
 String nickname = "";
  Object userObj = session.getAttribute("loginUser");
  if (userObj != null) {
    net.koreate.hellking.user.vo.UserVO user = (net.koreate.hellking.user.vo.UserVO) userObj;
    nickname = user.getUsername(); // 또는 getUsername() → 실제 닉네임 필드에 맞게
  } else {
  }
%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/registerstyle.css">
>>>>>>> b65c320 (Initial commit)
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
<body>
	<h1>게시글 작성</h1>
<<<<<<< HEAD
	<form method="POST">
=======
	<form method="POST" class="form-container" enctype="multipart/form-data">
	<input type="hidden" name="boardType" value="free">
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
			<input type="text" name="nickname" required >
		</div>
=======
			<input type="text" name="nickname" value="<%=nickname%>" readonly required >
		</div>
		
		 <div>
		    <label for="uploadFile">첨부파일</label>
		    <input type="file" name="uploadFile" id="uploadFile" multiple>
		 </div>
  
>>>>>>> b65c320 (Initial commit)
		<div>
			<input type="submit" value="글 작성">
		</div>
	</form>
</body>
</html>











