<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="list">
		<tr>
			<th colspan="2">
				<h1>${list.title}</h1>
			</th>
		</tr>
		<tr>
			<td>작성자</td>
			<td>
				<!-- 작성자 이름 들어갈 자리 -->
				${list.nickname}
			</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>
				<!-- 제목들어갈 자리 -->
				${list.title}
			</td>
		</tr>
		<tr>
			<td>내용</td>
			<td>
				<div style="width:600px; min-height:300px;">
					<pre>${list.content}</pre>
				</div>
			</td>
		</tr>
		<tr>
			<td>작성시간</td>
			<td>
				<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${list.regdate}" />
			</td>
		</tr>
		<tr>
			<td><button onclick="update(${list.bno})">추천!</button>
			<span id="agree-${list.bno}">${list.agree}</span>
			</td>
			<td><button>비추천!</button></td>
		</tr>
		<tr>
			<button onclick="location.href='localmodify?bno=${list.bno}';">수정</button>
			<button onclick="location.href='localremove?bno=${list.bno}';">삭제</button>
		</tr>
	</table>
<!-- -------------------------------------------------------------------------------------- -->
<script>
	function update(bno){
		fetch("/board/agree",{
			method : "POST",
			headers : {
				"Content-Type" : "application/x-www-form-urlencoded",
				// "Accept" : "text/plain" // or "application/json"
			},
			body : "bno=" + bno
		})
		.then(response => {
			console.log(response);
			return response.json();
		})
		.then(newAgree => {
			console.log(newAgree);
			document.getElementById("agree-" + bno).innerText = newAgree;
		})
		.catch(error => {
			console.log("추천 실패 : ", error);
			alert("추천 처리 중 오류가 발생했습니다.");
		});
	}
</script>
</body>
</html>