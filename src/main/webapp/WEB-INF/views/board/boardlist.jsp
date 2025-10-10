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
<title>게시판</title>
</head>
<body>
	<table>
		<tr>
			<th class="boardtitle">인기 게시글</th>
		</tr>
		<tr>
			<td>주간 최신 인기글을 만나보세요</td>
		</tr>
		<tr>
			<button onclick="location.href='register';">게시물 작성</button>
		</tr>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
		</tr>
		<c:forEach items="${hotlist}" var="list">
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
	
		<table>
		<tr>
			<th class="boardtitle">모든 게시글</th>
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
				<td>${list.title}</td>
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
				<li><a href="${pageContext.request.contextPath}/board/freeboard">자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/board/secretboard">익명게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/board/localboard">지역게시판</a></li>
				
			</ul>
		</aside>
	
	
	</div>
		

=======
<meta charset="UTF-8">
<title>게시판 - 인기 게시글</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
body { 
    background: white; 
}

/* 파란색 계열 - 메인/인기 게시글 */
.board-header {
    background: linear-gradient(135deg, #007bff, #0056b3);
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

.category-menu a:hover {
    background: #007bff;
    color: white;
    transform: translateX(5px);
}

.hot-post-card {
    border: none;
    border-radius: 12px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
    margin-bottom: 20px;
}

.hot-post-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(0,0,0,0.15);
}

.hot-badge {
    background: linear-gradient(135deg, #ff4757, #ff3838);
    color: white;
    font-size: 0.8rem;
    font-weight: 600;
    border-radius: 20px;
    padding: 4px 12px;
}

.stats-item {
    color: #6c757d;
    font-size: 0.9rem;
}

.stats-item i {
    margin-right: 4px;
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
}
</style>
</head>
<body>
    
    <!-- 게시판 헤더 -->
    <div class="board-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">인기 게시글</h2>
                    <p class="lead">주간 최신 인기글을 만나보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="d-flex gap-2 justify-content-end">
                        <span class="badge bg-light text-dark px-3 py-2">
                            <i class="fas fa-fire me-1"></i>실시간 HOT
                        </span>
                        <span class="badge bg-light text-dark px-3 py-2">
                            <i class="fas fa-chart-line me-1"></i>${hotlist.size()}개 게시글
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
                        <li><a href="${pageContext.request.contextPath}/board/localboard">
                            <i class="fas fa-map-marker-alt me-2"></i>지역게시판
                        </a></li>
                    </ul>
                </div>
            </div>

            <!-- 우측 인기 게시글 목록 -->
            <div class="col-lg-9">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold">
                        <i class="fas fa-fire text-danger me-2"></i>실시간 인기글
                    </h4>
                    <small class="text-muted">조회수와 추천수 기준으로 선정</small>
                </div>

                <c:choose>
                    <c:when test="${not empty hotlist}">
                        <c:forEach items="${hotlist}" var="list" varStatus="status">
                            <div class="hot-post-card card">
                                <div class="card-body">
                                    <div class="row align-items-center">
                                        <!-- 순위 -->
                                        <div class="col-auto">
                                            <div class="text-center">
                                                <div class="display-6 fw-bold text-primary">${status.count}</div>
                                                <small class="text-muted">순위</small>
                                            </div>
                                        </div>
                                        
                                        <!-- 게시글 정보 -->
                                        <div class="col">
                                            <div class="d-flex justify-content-between align-items-start mb-2">
                                                <span class="hot-badge">HOT</span>
                                                <span class="badge bg-secondary">글번호 ${list.bno}</span>
                                            </div>
                                            
                                            <h5 class="card-title mb-2">
                                                <a href="readPage?bno=${list.bno}" class="text-decoration-none text-dark fw-bold">
                                                    ${list.title}
                                                </a>
                                            </h5>
                                            
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div class="d-flex gap-3">
                                                    <span class="stats-item">
                                                        <i class="fas fa-user"></i>${list.nickname}
                                                    </span>
                                                    <span class="stats-item">
                                                        <i class="fas fa-calendar"></i><fmt:formatDate pattern="MM-dd" value="${list.regdate}" />
                                                    </span>
                                                </div>
                                                <div class="d-flex gap-3">
                                                    <span class="stats-item">
                                                        <i class="fas fa-eye text-info"></i>${list.viewcnt}
                                                    </span>
                                                    <span class="stats-item">
                                                        <i class="fas fa-thumbs-up text-success"></i>${list.agree}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="fas fa-fire fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">인기 게시글이 없습니다</h5>
                            <p class="text-muted">활발한 토론으로 인기 게시글을 만들어보세요!</p>
                        </div>
                    </c:otherwise>
                </c:choose>

                <!-- 더 많은 게시글 보기 -->
                <div class="text-center mt-4">
                    <h5 class="fw-bold mb-3">다른 게시판도 둘러보세요</h5>
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <a href="${pageContext.request.contextPath}/board/freeboard" 
                               class="btn btn-outline-success w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4">
                                <i class="fas fa-comments fa-2x mb-2"></i>
                                <h6>자유게시판</h6>
                                <small class="text-muted">자유로운 소통</small>
                            </a>
                        </div>
                        <div class="col-md-4 mb-3">
                            <a href="${pageContext.request.contextPath}/board/secretboard" 
                               class="btn btn-outline-warning w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4">
                                <i class="fas fa-user-secret fa-2x mb-2"></i>
                                <h6>익명게시판</h6>
                                <small class="text-muted">익명으로 자유롭게</small>
                            </a>
                        </div>
                        <div class="col-md-4 mb-3">
                            <a href="${pageContext.request.contextPath}/board/localboard" 
                               class="btn btn-outline-primary w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4">
                                <i class="fas fa-map-marker-alt fa-2x mb-2"></i>
                                <h6>지역게시판</h6>
                                <small class="text-muted">지역별 소통</small>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
>>>>>>> b65c320 (Initial commit)
</body>
</html>