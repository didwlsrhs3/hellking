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
<title>익명게시판</title>
</head>
<body>
			<button onclick="location.href='secretregister';">게시물 작성</button>
		<table>
		<tr>
			<th class="boardtitle">익명 게시글</th>
		</tr>
		<tr>
			<td>모든 익명게시글 테이블</td>
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
				<td><a href="secretreadPage?bno=${list.bno}">${list.title}</a></td>
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
				<li><span>익명게시판</span></li>
				<li><a href="${pageContext.request.contextPath}/board/freeboard">자유게시판</a></li>
				<li><a href="${pageContext.request.contextPath}/board/localboard">지역게시판</a></li>
				
			</ul>
		</aside>
	
	
	</div>
		

=======
<meta charset="UTF-8">
<title>익명게시판</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
body { 
    background: white; 
}

/* 주황색 계열 - 익명게시판 */
.board-header {
    background: linear-gradient(135deg, #fd7e14, #e8590c);
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
    background: #fd7e14;
    color: white;
    transform: translateX(5px);
}

.board-table {
    background: white;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.board-table th {
    background: #fd7e14;
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
    color: #fd7e14;
    text-decoration: underline;
}

.write-btn {
    background: linear-gradient(135deg, #fd7e14, #e8590c);
    border: none;
    color: white;
    padding: 12px 30px;
    border-radius: 25px;
    font-weight: 600;
    box-shadow: 0 4px 15px rgba(253, 126, 20, 0.3);
    transition: all 0.3s ease;
}

.write-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(253, 126, 20, 0.4);
    color: white;
}

.anonymous-info {
    background: linear-gradient(135deg, #fff3cd, #ffeaa7);
    border-left: 4px solid #fd7e14;
    padding: 15px;
    border-radius: 8px;
    margin-bottom: 20px;
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
                    <h2 class="fw-bold">익명게시판</h2>
                    <p class="lead">로그인하지 않고도 자유롭게 이용할 수 있는 게시판입니다</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="d-flex gap-2 justify-content-end">
                        <span class="badge bg-light text-dark px-3 py-2">
                            <i class="fas fa-user-secret me-1"></i>완전 익명
                        </span>
                        <span class="badge bg-light text-dark px-3 py-2">
                            <i class="fas fa-shield-alt me-1"></i>자유토론
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
                        <li><a href="${pageContext.request.contextPath}/board/secretboard" class="active">
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
                <!-- 익명게시판 안내 -->
                <div class="anonymous-info">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-user-secret fa-2x text-warning me-3"></i>
                        <div>
                            <h6 class="fw-bold mb-1">익명게시판 이용 안내</h6>
                            <p class="mb-0 text-muted small">
                                로그인 없이 자유롭게 글을 작성할 수 있습니다. 
                                단, 수정/삭제 시 비밀번호가 필요하니 기억해 주세요.
                            </p>
                        </div>
                    </div>
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
                                                <a href="secretreadPage?bno=${list.bno}" class="post-title">
                                                    <i class="fas fa-mask me-2 text-muted"></i>${list.title}
                                                </a>
                                            </td>
                                            <td>
                                                <i class="fas fa-user-secret text-warning me-1"></i>
                                                ${list.nickname}
                                            </td>
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
                                            <i class="fas fa-user-secret fa-3x text-muted mb-3"></i>
                                            <h5 class="text-muted">게시글이 없습니다</h5>
                                            <p class="text-muted">익명으로 첫 번째 게시글을 작성해보세요!</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- 글쓰기 버튼 -->
                <div class="text-end mt-3">
                    <button class="write-btn" onclick="location.href='secretregister';">
                        <i class="fas fa-pen me-2"></i>익명으로 글쓰기
                    </button>
                </div>

                <!-- 익명게시판 특징 안내 -->
                <div class="mt-4">
                    <div class="card border-warning">
                        <div class="card-body">
                            <h6 class="card-title">
                                <i class="fas fa-info-circle text-warning me-2"></i>익명게시판 특징
                            </h6>
                            <div class="row">
                                <div class="col-md-4 mb-2">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-user-secret text-warning me-2"></i>
                                        <small>완전 익명 보장</small>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-lock text-warning me-2"></i>
                                        <small>비밀번호로 관리</small>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-2">
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-comments text-warning me-2"></i>
                                        <small>자유로운 소통</small>
                                    </div>
                                </div>
                            </div>
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