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
			<button onclick="location.href='secretmodify?bno=${list.bno}';">수정</button>
			<button onclick="location.href='secretremove?bno=${list.bno}';">삭제</button>
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

/* 주황색 계열 - 익명게시판 */
.post-header {
    background: linear-gradient(135deg, #fd7e14, #e8590c);
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

.anonymous-badge {
    background: linear-gradient(135deg, #fd7e14, #e8590c);
    color: white;
    padding: 8px 15px;
    border-radius: 20px;
    font-size: 0.9rem;
    font-weight: 600;
    display: inline-block;
    margin-bottom: 15px;
}

.post-meta {
    background: #fff3e0;
    border-radius: 12px;
    padding: 15px;
    margin-bottom: 25px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-left: 4px solid #fd7e14;
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
    background: #fff3e0;
    border-radius: 12px;
    margin-bottom: 25px;
}

.reaction-section button {
    background: linear-gradient(135deg, #fd7e14, #e8590c);
    border: none;
    color: white;
    padding: 12px 25px;
    border-radius: 25px;
    font-size: 1.1rem;
    font-weight: 600;
    box-shadow: 0 4px 15px rgba(253, 126, 20, 0.3);
    transition: all 0.3s ease;
}

.reaction-section button:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(253, 126, 20, 0.4);
}

.button-group {
    text-align: center;
    margin-bottom: 30px;
}

.button-group button {
    margin: 0 5px;
    padding: 10px 20px;
    border-radius: 8px;
    font-weight: 500;
}

.password-check-form {
    background: #fff3e0;
    border: 2px solid #fd7e14;
    border-radius: 12px;
    padding: 20px;
    margin-top: 15px;
}

.divider {
    height: 2px;
    background: linear-gradient(90deg, transparent, #fd7e14, transparent);
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
    background: #fff3e0;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 25px;
}

.comment-form button {
    background: #fd7e14;
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
    border-left: 3px solid #fd7e14;
}

.comment-item.depth-2 {
    margin-left: 60px;
    padding-left: 20px;
    border-left: 3px solid #ffb347;
}

.comment-meta {
    margin-bottom: 10px;
}

.comment-meta b {
    color: #fd7e14;
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
    background: #fd7e14;
    color: white;
    border-color: #fd7e14;
}

.reply-form {
    background: #fff3e0;
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
                    <p class="lead">익명게시판 게시글</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/board/secretboard" 
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
            <!-- 익명 표시 -->
            <div class="anonymous-badge">
                <i class="fas fa-user-secret me-2"></i>익명 게시글
            </div>

            <!-- 게시글 메타 정보 -->
            <div class="post-meta">
                <div>
                    <span class="badge bg-warning text-dark me-2">
                        <i class="fas fa-user-secret me-1"></i>${list.nickname}
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

            <!-- 추천 섹션 (익명도 가능) -->
            <div class="reaction-section">
                <button id="agree-btn-${list.bno}" onclick="plusAgree(${list.bno})">
                    <i class="fas fa-thumbs-up me-2"></i>추천하기
                </button>
                <div class="mt-2">
                    <span class="fs-4 fw-bold" id="agree-count">${list.agree}</span>
                    <div class="text-muted small">명이 추천했습니다</div>
                </div>
            </div>

            <!-- 수정/삭제 버튼 (비밀번호 확인 필요) -->
            <div class="button-group">
                <button type="button" class="btn btn-outline-warning" onclick="showPasswordForm('modify')">
                    <i class="fas fa-edit me-1"></i>수정
                </button>
                <button type="button" class="btn btn-outline-danger" onclick="showPasswordForm('remove')">
                    <i class="fas fa-trash me-1"></i>삭제
                </button>
            </div>

            <!-- 비밀번호 확인 폼 (기본 숨김) -->
            <div id="password-check" class="password-check-form" style="display:none;">
                <h6 class="fw-bold mb-3">
                    <i class="fas fa-lock me-2"></i>비밀번호 확인
                </h6>
                <form id="passwordForm" method="post">
                    <input type="hidden" name="bno" value="${list.bno}">
                    <div class="input-group">
                        <input type="password" name="password" class="form-control" 
                               placeholder="작성시 입력한 비밀번호를 입력하세요" required>
                        <button type="submit" class="btn btn-warning">
                            <i class="fas fa-check me-1"></i>확인
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- 구분선 -->
        <div class="divider"></div>

        <!-- 댓글 섹션 -->
        <div class="comment-section">
            <h4 class="fw-bold mb-4">
                <i class="fas fa-comments me-2"></i>댓글
            </h4>

            <!-- 댓글 작성 (로그인 안해도 가능) -->
            <form class="comment-form" action="${pageContext.request.contextPath}/comment/add" method="post">
                <input type="hidden" name="bno" value="${list.bno}" />
                <div class="row g-3">
                    <div class="col-md-3">
                        <input type="text" name="username" class="form-control" 
                               placeholder="닉네임 입력" required />
                    </div>
                    <div class="col-md-7">
                        <textarea name="content" rows="3" class="form-control" placeholder="댓글을 입력하세요"></textarea>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-warning h-100 w-100">
                            <i class="fas fa-comment me-1"></i>댓글 등록
                        </button>
                    </div>
                </div>
            </form>

            <!-- 댓글 목록 -->
            <c:choose>
                <c:when test="${not empty comments}">
                    <c:forEach var="comment" items="${comments}">
                        <div class="comment-item depth-${comment.depth}">
                            <!-- 작성자/날짜 -->
                            <div class="comment-meta">
                                <b>
                                    <i class="fas fa-user-secret me-1"></i>${comment.username}
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
                                    <button type="button" class="reply-btn" data-cno="${comment.cno}">
                                        <i class="fas fa-reply me-1"></i>답글
                                    </button>
                                </div>
                                <div class="right-actions">
                                    <!-- 익명 댓글도 비밀번호 확인 후 수정/삭제 -->
                                    <button type="button" onclick="showPasswordForm('commentModify', ${comment.cno})">
                                        <i class="fas fa-edit me-1"></i>수정
                                    </button>
                                    <button type="button" onclick="showPasswordForm('commentRemove', ${comment.cno})">
                                        <i class="fas fa-trash me-1"></i>삭제
                                    </button>
                                </div>
                            </div>

                            <!-- 답글 작성 폼 -->
                            <form id="reply-form-${comment.cno}" class="reply-form"
                                  action="${pageContext.request.contextPath}/comment/reply" method="post" hidden>
                                <input type="hidden" name="parentCno" value="${comment.cno}" />
                                <input type="hidden" name="bno" value="${list.bno}" />
                                <div class="row g-2">
                                    <div class="col-md-3">
                                        <input type="text" name="username" class="form-control" 
                                               placeholder="닉네임 입력" required />
                                    </div>
                                    <div class="col-md-7">
                                        <textarea name="content" rows="3" class="form-control" placeholder="답글을 입력하세요"></textarea>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-warning h-100 w-100">
                                            <i class="fas fa-reply me-1"></i>답글 등록
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                        <h6 class="text-muted">아직 댓글이 없습니다</h6>
                        <p class="text-muted">익명으로 첫 번째 댓글을 작성해보세요!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
// 추천
function plusAgree(bno){
  fetch("${pageContext.request.contextPath}/board/secretagree?bno=" + bno, {method: "POST"})
    .then(res => res.json())
    .then(data => {
      document.getElementById("agree-count").innerText = data;
    })
    .catch(() => alert("추천 실패"));
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

// 비밀번호 확인 처리
function showPasswordForm(action, cno = null){
  const form = document.getElementById("passwordForm");
  if(action === 'modify'){
    form.action = "${pageContext.request.contextPath}/board/secretmodify";
  } else if(action === 'remove'){
    form.action = "${pageContext.request.contextPath}/board/secretremove";
  } else if(action === 'commentModify'){
    form.action = "${pageContext.request.contextPath}/comment/secretModify?cno=" + cno;
  } else if(action === 'commentRemove'){
    form.action = "${pageContext.request.contextPath}/comment/secretRemove?cno=" + cno;
  }
  document.getElementById("password-check").style.display = "block";
}
>>>>>>> b65c320 (Initial commit)
</script>
</body>
</html>