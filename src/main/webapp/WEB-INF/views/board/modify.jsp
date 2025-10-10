<<<<<<< HEAD
<!-- modify.jsp -->
=======
>>>>>>> b65c320 (Initial commit)
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<<<<<<< HEAD
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











=======
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/modifystyle.css">
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
    <!-- model : boardVO -->
    <h1>게시글 수정</h1>
    <!-- 파일 업로드 위해 enctype 추가 -->
    <form method="POST" enctype="multipart/form-data" 
          action="${pageContext.request.contextPath}/board/modify">
          
    	<input type="hidden" name="boardType" value="free">
    	
        <input type="hidden" name="bno" value="${board.bno}">
        
        <div>
            <label>제목</label>
            <input type="text" name="title" required value="${board.title}">
        </div>
        
        <div>
            <label>내용</label>
            <textarea name="content" required rows="5" cols="20">${board.content}</textarea>
        </div>
        
        <div>
            <label>작성자</label>
                <input type="text" name="nickname" value="${sessionScope.username}" readonly>
        </div>
        
        <!-- 기존 첨부파일 -->
        <div>
            <label>첨부된 파일</label><br>
            <c:forEach var="file" items="${files}">
                <input type="checkbox" name="delFiles" value="${file.fno}"> 삭제
                <a href="${pageContext.request.contextPath}/board/download?file=${file.savedName}&path=${file.uploadPath}">
                    ${file.originalName}
                </a><br>
            </c:forEach>
        </div>
        
        <!-- 새 파일 업로드 -->
        <div>
            <label>새 파일 업로드</label>
            <input type="file" name="uploadFile" multiple>
        </div>
        
        <div>
            <input type="submit" value="글 수정">
        </div>
    </form>
</body>
</html>
>>>>>>> b65c320 (Initial commit)
