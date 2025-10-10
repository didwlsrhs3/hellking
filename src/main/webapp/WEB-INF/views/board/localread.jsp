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
<meta charset="UTF-8">
<<<<<<< HEAD
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
=======
<title>${list.title}</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
<style>
body { 
    background: white; 
}

/* 보라색 계열 - 지역게시판 */
.post-header {
    background: linear-gradient(135deg, #6f42c1, #5a2d91);
    color: white;
    padding: 60px 0;
}

.post-header h1, .post-header h2 {
    color: white;
    font-size: 2.5rem;
    font-weight: 800;
    margin-bottom: 15px;
    text-shadow: 0 2px 4px rgba(0,0,0,0.2);
}

.post-header p {
    color: rgba(255,255,255,0.9);
    font-size: 1.1rem;
    margin-bottom: 0;
}

.post-content-card {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    padding: 30px;
    margin-bottom: 30px;
}

.post-meta {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 25px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.post-content {
    font-size: 1.1rem;
    line-height: 1.8;
    color: #495057;
    margin-bottom: 30px;
}

.reaction-section {
    text-align: center;
    padding: 25px;
    background: #f8f9fa;
    border-radius: 12px;
    margin-bottom: 25px;
}

.reaction-section button {
    background: linear-gradient(135deg, #6f42c1, #5a2d91);
    border: none;
    color: white;
    padding: 12px 25px;
    border-radius: 25px;
    font-size: 1.1rem;
    font-weight: 600;
    box-shadow: 0 4px 15px rgba(111, 66, 193, 0.3);
    transition: all 0.3s ease;
}

.reaction-section button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(111, 66, 193, 0.4);
}

.button-group {
    text-align: center;
    margin-bottom: 30px;
}

.button-group button, .button-group form {
    margin: 0 5px;
    display: inline-block;
}

.button-group button {
    padding: 10px 20px;
    border-radius: 8px;
    font-weight: 500;
}

.divider {
    height: 2px;
    background: linear-gradient(90deg, transparent, #6f42c1, transparent);
    margin: 40px 0;
    border-radius: 2px;
}

.comment-section {
    background: white;
    border-radius: 16px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    padding: 30px;
}

.comment-form {
    background: #f8f9fa;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 25px;
}

.comment-form input[readonly] {
    background: #e9ecef;
    border-color: #ced4da;
}

.comment-form button {
    background: #6f42c1;
    border: none;
    color: white;
    padding: 10px 20px;
    border-radius: 8px;
    font-weight: 500;
}

.comment-item {
    border-bottom: 1px solid #dee2e6;
    padding: 20px 0;
}

.comment-item:last-child {
    border-bottom: none;
}

.comment-item.depth-1 {
    margin-left: 30px;
    padding-left: 20px;
    border-left: 3px solid #6f42c1;
}

.comment-item.depth-2 {
    margin-left: 60px;
    padding-left: 20px;
    border-left: 3px solid #9561e2;
}

.comment-meta {
    margin-bottom: 10px;
}

.comment-meta b {
    color: #6f42c1;
}

.comment-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
}

.comment-actions button {
    background: none;
    border: 1px solid #dee2e6;
    color: #6c757d;
    padding: 5px 10px;
    border-radius: 4px;
    font-size: 0.9rem;
    margin-right: 5px;
}

.comment-actions button:hover {
    background: #6f42c1;
    color: white;
    border-color: #6f42c1;
}

.reply-form {
    background: #f3f0ff;
    border-radius: 8px;
    padding: 15px;
    margin-top: 15px;
}

@media (max-width: 768px) {
    .post-header {
        padding: 40px 0;
    }
    .post-header h2 {
        font-size: 1.8rem;
    }
    .post-content-card {
        padding: 20px;
    }
    .comment-section {
        padding: 20px;
    }
    .comment-item.depth-1 {
        margin-left: 15px;
    }
    .comment-item.depth-2 {
        margin-left: 30px;
    }
}
</style>
</head>
<body>
    
    <!-- 게시글 헤더 -->
    <div class="post-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">${list.title}</h2>
                    <p class="lead">지역게시판 게시글</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/board/localboard" 
                       class="btn btn-light">
                        <i class="fas fa-list me-2"></i>목록으로
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-4">
        <!-- 게시글 내용 -->
        <div class="post-content-card">
            <!-- 게시글 메타 정보 -->
            <div class="post-meta">
                <div>
                    <span class="badge bg-primary me-2">
                        <i class="fas fa-user me-1"></i>${list.nickname}
                    </span>
                    <span class="text-muted">
                        <i class="fas fa-calendar me-1"></i>
                        <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${list.regdate}" />
                    </span>
                </div>
                <div>
                    <span class="badge bg-info me-2">
                        <i class="fas fa-eye me-1"></i>조회 ${list.viewcnt}
                    </span>
                    <span class="badge bg-success">
                        <i class="fas fa-thumbs-up me-1"></i>추천 ${list.agree}
                    </span>
                </div>
            </div>

            <!-- 게시글 본문 -->
            <div class="post-content">
                ${list.content}
            </div>

            <!-- 추천 섹션 -->
            <c:if test="${not empty sessionScope.loginUser}">
                <div class="reaction-section">
                    <button id="agree-btn-${list.bno}" onclick="plusAgree(${list.bno})">
                        <i class="fas fa-thumbs-up me-2"></i>추천하기
                    </button>
                    <div class="mt-2">
                        <span class="fs-4 fw-bold" id="agree-count">${list.agree}</span>
                        <div class="text-muted small">명이 추천했습니다</div>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty sessionScope.loginUser}">
                <div class="reaction-section">
                    <p class="text-muted">로그인한 사용자만 추천할 수 있습니다.</p>
                    <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary">
                        <i class="fas fa-sign-in-alt me-2"></i>로그인하기
                    </a>
                </div>
            </c:if>

            <!-- 수정/삭제 버튼 (작성자 본인만 가능) -->
            <c:if test="${not empty sessionScope.loginUser 
                          and sessionScope.loginUser.userId == list.userId}">
                <div class="button-group">
                    <form action="localmodify" method="get" class="d-inline">
                        <input type="hidden" name="bno" value="${list.bno}">
                        <button type="submit" class="btn btn-outline-primary">
                            <i class="fas fa-edit me-1"></i>수정
                        </button>
                    </form>
                    <form action="localremove" method="post" class="d-inline">
                        <input type="hidden" name="bno" value="${list.bno}">
                        <button type="submit" class="btn btn-outline-danger" 
                                onclick="return confirm('정말 삭제하시겠습니까?')">
                            <i class="fas fa-trash me-1"></i>삭제
                        </button>
                    </form>
                </div>
            </c:if>
        </div>

        <!-- 구분선 -->
        <div class="divider"></div>

        <!-- 댓글 섹션 -->
        <div class="comment-section">
            <h4 class="fw-bold mb-4">
                <i class="fas fa-comments me-2"></i>댓글
            </h4>

            <!-- 댓글 작성 -->
            <c:if test="${not empty sessionScope.loginUser}">
                <form class="comment-form" action="${pageContext.request.contextPath}/comment/add" method="post">
                    <input type="hidden" name="bno" value="${list.bno}" />
                    <div class="row g-3">
                        <div class="col-md-3">
                            <input type="text" name="username" value="${sessionScope.loginUser.username}" 
                                   class="form-control" readonly />
                        </div>
                        <div class="col-md-7">
                            <textarea name="content" rows="3" class="form-control" placeholder="댓글을 입력하세요"></textarea>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary h-100 w-100">
                                <i class="fas fa-comment me-1"></i>댓글 등록
                            </button>
                        </div>
                    </div>
                </form>
            </c:if>
            <c:if test="${empty sessionScope.loginUser}">
                <div class="comment-form text-center">
                    <p class="text-muted mb-3">댓글을 작성하려면 로그인이 필요합니다</p>
                    <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary">
                        <i class="fas fa-sign-in-alt me-2"></i>로그인하기
                    </a>
                </div>
            </c:if>

            <!-- 댓글 목록 -->
            <c:choose>
                <c:when test="${not empty comments}">
                    <c:forEach var="comment" items="${comments}">
                        <div class="comment-item depth-${comment.depth}">
                            <!-- 작성자/날짜 -->
                            <div class="comment-meta">
                                <b>
                                    <i class="fas fa-user me-1"></i>${comment.username}
                                </b>
                                <span class="text-muted ms-3">
                                    <i class="fas fa-clock me-1"></i>
                                    <fmt:formatDate value="${comment.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </span>
                            </div>

                            <!-- 댓글 내용 -->
                            <div class="comment-content" id="content-view-${comment.cno}">
                                ${comment.content}
                            </div>

                            <!-- 액션 버튼 -->
                            <div class="comment-actions">
                                <div class="left-actions">
                                    <c:if test="${not empty sessionScope.loginUser}">
                                        <button type="button" class="reply-btn" data-cno="${comment.cno}">
                                            <i class="fas fa-reply me-1"></i>답글
                                        </button>
                                    </c:if>
                                </div>
                                <div class="right-actions">
                                    <c:if test="${not empty sessionScope.loginUser 
                                                  and sessionScope.loginUser.userId == comment.userId}">
                                        <button type="button" class="edit-btn" data-cno="${comment.cno}">
                                            <i class="fas fa-edit me-1"></i>수정
                                        </button>
                                        <form action="${pageContext.request.contextPath}/comment/delete" method="post" class="d-inline">
                                            <input type="hidden" name="cno" value="${comment.cno}" />
                                            <input type="hidden" name="bno" value="${list.bno}" />
                                            <button type="submit" onclick="return confirm('정말 삭제하시겠습니까?')">
                                                <i class="fas fa-trash me-1"></i>삭제
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>

                            <!-- 답글 작성 폼 -->
                            <c:if test="${not empty sessionScope.loginUser}">
                                <form id="reply-form-${comment.cno}" class="reply-form" 
                                      action="${pageContext.request.contextPath}/comment/reply" method="post" hidden>
                                    <input type="hidden" name="parentCno" value="${comment.cno}" />
                                    <input type="hidden" name="bno" value="${list.bno}" />
                                    <div class="row g-2">
                                        <div class="col-md-3">
                                            <input type="text" name="username" value="${sessionScope.loginUser.username}" 
                                                   class="form-control" readonly />
                                        </div>
                                        <div class="col-md-7">
                                            <textarea name="content" rows="3" class="form-control" placeholder="답글을 입력하세요"></textarea>
                                        </div>
                                        <div class="col-md-2">
                                            <button type="submit" class="btn btn-primary h-100 w-100">
                                                <i class="fas fa-reply me-1"></i>답글 등록
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                        <h6 class="text-muted">아직 댓글이 없습니다</h6>
                        <p class="text-muted">우리 지역 첫 번째 댓글을 작성해보세요!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// 추천 기능
function plusAgree(bno){
  fetch("${pageContext.request.contextPath}/board/localagree?bno=" + bno, {method: "POST"})
    .then(res => res.json())
    .then(data => {
      document.getElementById("agree-count").innerText = data;
    })
    .catch(err => alert("추천 실패"));
}

// 답글 토글
document.querySelectorAll(".reply-btn").forEach(btn => {
  btn.addEventListener("click", function(){
    const cno = this.dataset.cno;
    const form = document.getElementById("reply-form-" + cno);
    if(form){
      form.style.display = (form.style.display === "none" || form.style.display === "") 
        ? "block" : "none";
    }
  });
});
>>>>>>> b65c320 (Initial commit)
</script>
</body>
</html>