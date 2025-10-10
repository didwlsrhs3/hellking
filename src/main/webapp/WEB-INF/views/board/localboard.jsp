<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
>>>>>>> b65c320 (Initial commit)
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<<<<<<< HEAD
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

=======
<meta charset="UTF-8">
<title>지역게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
body { 
    background: white; 
}

/* 보라색 계열 - 지역게시판 */
.board-header {
    background: linear-gradient(135deg, #6f42c1, #5a2d91);
    color: white;
    padding: 60px 0;
}

.board-header h1, .board-header h2 {
    color: white;
    font-size: 2.5rem;
    font-weight: 800;
    margin-bottom: 15px;
    text-shadow: 0 2px 4px rgba(0,0,0,0.2);
}

.board-header p {
    color: rgba(255,255,255,0.9);
    font-size: 1.1rem;
    margin-bottom: 0;
}

.category-menu {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 20px;
    position: sticky;
    top: 20px;
}

.category-menu ul {
    list-style: none;
    padding: 0;
    margin: 0;
}

.category-menu li {
    margin-bottom: 10px;
}

.category-menu a {
    display: block;
    padding: 12px 16px;
    text-decoration: none;
    color: #495057;
    border-radius: 8px;
    transition: all 0.2s;
    font-weight: 500;
}

.category-menu a:hover, .category-menu a.active {
    background: #6f42c1;
    color: white;
    transform: translateX(5px);
}

.search-form {
    background: #f8f9fa;
    padding: 20px;
    border-radius: 12px;
    margin-bottom: 20px;
}

.board-table {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.board-table th {
    background: #6f42c1;
    color: white;
    border: none;
    padding: 15px;
    font-weight: 600;
}

.board-table td {
    padding: 12px 15px;
    border-bottom: 1px solid #dee2e6;
    vertical-align: middle;
}

.board-table tr:hover {
    background: #f8f9fa;
}

.post-title {
    color: #495057;
    text-decoration: none;
    font-weight: 500;
}

.post-title:hover {
    color: #6f42c1;
    text-decoration: underline;
}

.write-btn {
    background: linear-gradient(135deg, #6f42c1, #5a2d91);
    border: none;
    color: white;
    padding: 12px 30px;
    border-radius: 25px;
    font-weight: 600;
    box-shadow: 0 4px 15px rgba(111, 66, 193, 0.3);
    transition: all 0.3s ease;
}

.write-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(111, 66, 193, 0.4);
    color: white;
}

.pagination {
    justify-content: center;
    margin-top: 30px;
}

.pagination .page-link {
    color: #6f42c1;
    border-color: #dee2e6;
    margin: 0 2px;
    border-radius: 8px;
}

.pagination .page-link:hover, .pagination .page-link.active {
    background-color: #6f42c1;
    border-color: #6f42c1;
    color: white;
}

@media (max-width: 768px) {
    .board-header {
        padding: 40px 0;
    }
    .board-header h2 {
        font-size: 1.8rem;
    }
    .category-menu {
        margin-bottom: 20px;
    }
    .board-table {
        font-size: 0.9rem;
    }
    .board-table th, .board-table td {
        padding: 10px 8px;
    }
}
</style>
</head>
<body>
    
    <!-- 게시판 헤더 -->
    <div class="board-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">지역게시판</h2>
                    <p class="lead">지역별로 카테고리를 나누어 소통할 수 있는 게시판입니다</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="d-flex gap-2 justify-content-end">
                        <span class="badge bg-light text-dark px-3 py-2">
                            <i class="fas fa-map-marker-alt me-1"></i>지역별 소통
                        </span>
                        <span class="badge bg-light text-dark px-3 py-2">
                            <i class="fas fa-users me-1"></i>동네 커뮤니티
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-4">
        <div class="row">
            <!-- 좌측 카테고리 메뉴 -->
            <div class="col-lg-3 mb-4">
                <div class="category-menu">
                    <h5 class="fw-bold mb-3">게시판 목록</h5>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/board/freeboard">
                            <i class="fas fa-comments me-2"></i>자유게시판
                        </a></li>
                        <li><a href="${pageContext.request.contextPath}/board/secretboard">
                            <i class="fas fa-user-secret me-2"></i>익명게시판
                        </a></li>
                        <li><a href="${pageContext.request.contextPath}/board/localboard" class="active">
                            <i class="fas fa-map-marker-alt me-2"></i>지역게시판
                        </a></li>
                    </ul>
                </div>
            </div>

            <!-- 우측 게시판 콘텐츠 -->
            <div class="col-lg-9">
                <!-- 검색/지역 선택 폼 -->
                <div class="search-form">
                    <form action="${pageContext.request.contextPath}/board/localboard" method="get" class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label">지역 선택</label>
                            <select name="categoryId" class="form-select">
                                <option value="0" ${pm.cri.categoryId == 0 ? 'selected' : ''}>전체</option>
                                <option value="1" ${pm.cri.categoryId == 1 ? 'selected' : ''}>서울</option>
                                <option value="2" ${pm.cri.categoryId == 2 ? 'selected' : ''}>부산</option>
                                <option value="3" ${pm.cri.categoryId == 3 ? 'selected' : ''}>대구</option>
                                <option value="4" ${pm.cri.categoryId == 4 ? 'selected' : ''}>인천</option>
                                <option value="5" ${pm.cri.categoryId == 5 ? 'selected' : ''}>광주</option>
                                <option value="6" ${pm.cri.categoryId == 6 ? 'selected' : ''}>대전</option>
                                <option value="7" ${pm.cri.categoryId == 7 ? 'selected' : ''}>울산</option>
                                <option value="8" ${pm.cri.categoryId == 8 ? 'selected' : ''}>수원</option>
                                <option value="9" ${pm.cri.categoryId == 9 ? 'selected' : ''}>성남</option>
                                <option value="10" ${pm.cri.categoryId == 10 ? 'selected' : ''}>청주</option>
                                <option value="11" ${pm.cri.categoryId == 11 ? 'selected' : ''}>천안</option>
                                <option value="12" ${pm.cri.categoryId == 12 ? 'selected' : ''}>전주</option>
                                <option value="13" ${pm.cri.categoryId == 13 ? 'selected' : ''}>군산</option>
                                <option value="14" ${pm.cri.categoryId == 14 ? 'selected' : ''}>순천</option>
                                <option value="15" ${pm.cri.categoryId == 15 ? 'selected' : ''}>목포</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">검색 조건</label>
                            <select name="searchType" class="form-select">
                                <option value="bno">글번호</option>
                                <option value="title">제목</option>
                                <option value="nickname">작성자</option>
                            </select>
                        </div>
                        <div class="col-md-5">
                            <label class="form-label">검색어</label>
                            <input type="text" name="keyword" class="form-control" placeholder="검색어 입력" />
                        </div>
                        <div class="col-md-2">
                            <label class="form-label">&nbsp;</label>
                            <button type="submit" class="btn btn-primary w-100 d-block">
                                <i class="fas fa-search"></i> 검색
                            </button>
                        </div>
                    </form>
                </div>

                <!-- 게시글 목록 -->
                <div class="board-table">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th style="width: 10%">글번호</th>
                                <th style="width: 45%">제목</th>
                                <th style="width: 15%">작성자</th>
                                <th style="width: 15%">작성일</th>
                                <th style="width: 8%">조회수</th>
                                <th style="width: 7%">추천수</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty allList}">
                                    <c:forEach items="${allList}" var="list">
                                        <tr>
                                            <td class="text-center">${list.bno}</td>
                                            <td>
                                                <a href="localreadPage?bno=${list.bno}" class="post-title">
                                                    ${list.title}
                                                </a>
                                            </td>
                                            <td>${list.nickname}</td>
                                            <td class="text-muted">
                                                <fmt:formatDate pattern="yyyy-MM-dd" value="${list.regdate}" />
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-info">${list.viewcnt}</span>
                                            </td>
                                            <td class="text-center">
                                                <span class="badge bg-success">${list.agree}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center py-5">
                                            <i class="fas fa-map-marker-alt fa-3x text-muted mb-3"></i>
                                            <h5 class="text-muted">게시글이 없습니다</h5>
                                            <p class="text-muted">우리 지역 첫 번째 게시글을 작성해보세요!</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- 글쓰기 버튼 -->
                <div class="text-end mt-3">
                    <button class="write-btn" onclick="location.href='localregister';">
                        <i class="fas fa-pen me-2"></i>게시글 작성
                    </button>
                </div>

                <!-- 페이지네이션 -->
                <nav aria-label="게시판 페이지네이션">
                    <ul class="pagination">
                        <c:if test="${pm.prev}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${pm.cri.page - 1}&perPageNum=${pm.cri.perPageNum}&categoryId=${pm.cri.categoryId}">
                                    <i class="fas fa-angle-left"></i> 이전
                                </a>
                            </li>
                        </c:if>
                        
                        <c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="p">
                            <li class="page-item">
                                <a class="page-link ${pm.cri.page == p ? 'active' : ''}" 
                                   href="?page=${p}&perPageNum=${pm.cri.perPageNum}&categoryId=${pm.cri.categoryId}">
                                    ${p}
                                </a>
                            </li>
                        </c:forEach>
                        
                        <c:if test="${pm.next}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${pm.cri.page + 1}&perPageNum=${pm.cri.perPageNum}&categoryId=${pm.cri.categoryId}">
                                    다음 <i class="fas fa-angle-right"></i>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
>>>>>>> b65c320 (Initial commit)
</body>
</html>