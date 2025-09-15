<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardstyle.css">
<meta charset="UTF-8">
<title>지역게시판</title>
</head>
<body>
			<button onclick="location.href='localregister';">게시물 작성</button>
		<table>
		<tr>
			<th class="boardtitle">지역 게시글</th>
		</tr>
		<tr>
			<td>모든 지역 게시글 테이블</td>
			<td>
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
			</td>
		</tr>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
		</tr>
		<%-- <c:forEach items="${allList}" var="list"> --%>
			<tbody id="list">
			</tbody>
		<%-- </c:forEach> --%>
	</table>
	
	<table></table>
	<div class="menucategory">게시판
		<aside class="category-menu">
			<ul>
				<li><span>익명게시판</span></li>
				<li><a href="${pageContext.request.contextPath}/board/freeboard">자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/board/localboard">지역게시판</a></li>
				
			</ul>
		</aside>
	
	
	</div>
<script>
// 내가 지정한 findCategory 함수를 불러오는 로직
function findCategory() {
	const contextPath = "${pageContext.request.contextPath}";
	console.log("contextPath:", contextPath);
	// 내가 카테고리를 선택하면 그 카테고리에 해당하는 번호값을 가져옴
  const categoryId = document.getElementById('category').value;
	// 3항연산자 사용 categoryId가 있으면 board/board...로 경로를 지정하고, 없으면 board/list로 경로를호출해서 모든게시글을 다보여줌
  // const url = categoryId  ? `${contextPath}/board/localboard/${categoryId}` : `${contextPath}/board/list`;
  // const url = categoryId  ? `${contextPath}/board/localboard/${categoryId}` : `${contextPath}/board/localboard`;
  console.log('categoryId:', categoryId); // 각 객체에 값이 있는지 확인
  console.log("타입 : ", typeof categoryId);
  const url = `${contextPath}/board/localboard/${categoryId}`;
  console.log("최종 요청 경로:", url);
  if (categoryId && categoryId.trim() !== "") {
	  const url = `${contextPath}/board/localboard/${categoryId}`;
	  console.log("정상 요청 경로:", url);
	} else {
	  const url = `${contextPath}/board/localboard`;
	  console.log("전체 요청 경로:", url);
	}


	
  // 위에서 선언된 url로 서버에 GET 요청을보냄 서버는 json 형태로 응답해야함
  fetch(url)
  	// 서버응답을 json으로 파싱 res는 HTTP 응답객체이고 .json()은 본문을 js객체로 변환
    .then(res => res.json())
    // json으로 파싱된 게시글 목록 배열
    .then(data => {  
	// 게시글 배열을 순회하며 HTML tr을 자동생성
      const rows = data.map(list => {
    	  console.log('각 게시글:', list); // 각 객체에 값이 있는지 확인
    	  const date = list.regdate ? new Date(list.regdate).toLocaleDateString() : '';
      return ` <tr>
          <td>${list.bno}</td>
          <td>${list.title}</td>
          <td>${list.nickname}</td>
          <td>${date}</td>
          <td>${list.viewcnt}</td>
          <td>${list.agree}</td>
        </tr> `
      }).join('');
      document.getElementById('list').innerHTML = rows;
    })
    .catch(err => {
      console.error('게시글 불러오기 실패:', err);
      document.getElementById('list').innerHTML = `<tr><td colspan="6">게시글을 불러올 수 없습니다.</td></tr>`;
    });
}
</script>

</body>
</html>