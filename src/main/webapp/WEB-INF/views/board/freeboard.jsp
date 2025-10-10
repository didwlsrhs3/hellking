<<<<<<< HEAD
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
<title>자유게시판</title>
</head>
<body>
		<table>
		<tr>
			<th class="boardtitle">모든 게시글</th>
		</tr>
		<tr>
			<button onclick="location.href='register';">게시물 작성</button>
		</tr>
		<tr>
			<td>모든 게시글 테이블</td>
		</tr>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
		</tr>
		<c:forEach items="${allList}" var="list">
			<tr>
				<td>${list.bno}</td>
				<td><a href="readPage?bno=${list.bno}">${list.title}</a></td>
				<td>${list.nickname}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.regdate}" /></td>
				<td>${list.viewcnt}</td>
				<td>${list.agree}</td>
			</tr>
		</c:forEach>
	</table>
	
	<table></table>
	<div class="category">게시판
		<aside class="category-menu">
			<ul>
				<li><span>자유게시판</span></li>
				<li><a href="${pageContext.request.contextPath}/board/secretboard">익명게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/board/localboard">지역게시판</a></li>
				
			</ul>
		</aside>
	
	
	</div>
		

=======
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
 String nickname = "";
  Object userObj = session.getAttribute("loginUser");
  if (userObj != null) {
    net.koreate.hellking.user.vo.UserVO user = (net.koreate.hellking.user.vo.UserVO) userObj;
    nickname = user.getUsername();
  } else {
  }
%>
<%
  boolean isLoginUser = (session.getAttribute("loginUser") != null);
%>
<script>
  function logincheck() {
    const isLoginUser = <%= isLoginUser %>;
    if (!isLoginUser) {
      alert("로그인한 사용자만 이용할 수 있습니다.");
      location.href = "<%=request.getContextPath()%>/user/login";
      return;
    }
    location.href = "<%=request.getContextPath()%>/board/register";
  }
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
body { 
    background: white; 
}

/* 초록색 계열 - 자유게시판 */
.board-header {
    background: linear-gradient(135deg, #28a745, #1e7e34);
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
    background: #28a745;
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
    background: #28a745;
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
    color: #28a745;
    text-decoration: underline;
}

.write-btn {
    background: linear-gradient(135deg, #28a745, #20c997);
    border: none;
    color: white;
    padding: 12px 30px;
    border-radius: 25px;
    font-weight: 600;
    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
    transition: all 0.3s ease;
}

.write-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
    color: white;
}

.pagination {
    justify-content: center;
    margin-top: 30px;
}

.pagination .page-link {
    color: #28a745;
    border-color: #dee2e6;
    margin: 0 2px;
    border-radius: 8px;
}

.pagination .page-link:hover {
    background-color: #28a745;
    border-color: #28a745;
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
                    <h2 class="fw-bold">자유게시판</h2>
                    <p class="lead">자유롭게 대화를 나눌 수 있는 게시판입니다</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="d-flex gap-2 justify-content-end">
                        <span class="badge bg-light text-dark px-3 py-2">
                            <i class="fas fa-comments me-1"></i>자유토론
                        </span>
                        <span class="badge bg-light text-dark px-3 py-2">
                            <i class="fas fa-users me-1"></i>커뮤니티
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
                        <li><a href="${pageContext.request.contextPath}/board/freeboard" class="active">
                            <i class="fas fa-comments me-2"></i>자유게시판
                        </a></li>
                        <li><a href="${pageContext.request.contextPath}/board/secretboard">
                            <i class="fas fa-user-secret me-2"></i>익명게시판
                        </a></li>
                        <li><a href="${pageContext.request.contextPath}/board/localboard">
                            <i class="fas fa-map-marker-alt me-2"></i>지역게시판
                        </a></li>
                    </ul>
                </div>
            </div>

            <!-- 우측 게시판 콘텐츠 -->
            <div class="col-lg-9">
                <!-- 검색 폼 -->
                <div class="search-form">
                    <form action="${pageContext.request.contextPath}/board/freeboard" method="get" class="row g-3">
                        <div class="col-md-3">
                            <select name="searchType" class="form-select">
                                <option value="bno">글번호</option>
                                <option value="title">제목</option>
                                <option value="nickname">작성자</option>
                            </select>
                        </div>
                        <div class="col-md-7">
                            <input type="text" name="keyword" class="form-control" placeholder="검색어를 입력하세요" />
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-success w-100">
                                <i class="fas fa-search"></i>
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
                                                <a href="readPage?bno=${list.bno}" class="post-title">
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
                                            <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                                            <h5 class="text-muted">게시글이 없습니다</h5>
                                            <p class="text-muted">첫 번째 게시글을 작성해보세요!</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- 글쓰기 버튼 -->
                <div class="text-end mt-3">
                    <c:if test="${not empty sessionScope.loginUser}">
                        <button class="write-btn" onclick="logincheck()">
                            <i class="fas fa-pen me-2"></i>게시글 작성
                        </button>
                    </c:if>
                    <c:if test="${empty sessionScope.loginUser}">
                        <button class="btn btn-outline-secondary" onclick="alert('로그인이 필요합니다.'); location.href='${pageContext.request.contextPath}/user/login';">
                            <i class="fas fa-lock me-2"></i>로그인 후 글쓰기
                        </button>
                    </c:if>
                </div>

                <!-- 페이지네이션 -->
                <nav aria-label="게시판 페이지네이션">
                    <ul class="pagination">
                        <c:if test="${pm.first}">
                            <li class="page-item">
                                <a class="page-link" href="?page=1&perPageNum=${pm.cri.perPageNum}">
                                    <i class="fas fa-angle-double-left"></i> 처음
                                </a>
                            </li>
                        </c:if>
                        
                        <c:if test="${pm.prev}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${pm.cri.page - 1}&perPageNum=${pm.cri.perPageNum}">
                                    <i class="fas fa-angle-left"></i> 이전
                                </a>
                            </li>
                        </c:if>
                        
                        <c:if test="${pm.next}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${pm.cri.page + 1}&perPageNum=${pm.cri.perPageNum}">
                                    다음 <i class="fas fa-angle-right"></i>
                                </a>
                            </li>
                        </c:if>
                        
                        <c:if test="${pm.last}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${pm.maxPage}&perPageNum=${pm.cri.perPageNum}">
                                    마지막 <i class="fas fa-angle-double-right"></i>
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