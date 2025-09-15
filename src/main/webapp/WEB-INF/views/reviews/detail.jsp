<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${review.title} - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .rating-stars { color: #ffc107; }
        .like-btn, .dislike-btn {
            transition: all 0.2s;
        }
        .like-btn.active { background-color: #28a745; color: white; }
        .dislike-btn.active { background-color: #dc3545; color: white; }
        .comment-form { background-color: #f8f9fa; border-radius: 8px; padding: 20px; }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-4">
        <!-- 브레드크럼 -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">홈</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/reviews/list">리뷰</a></li>
                <li class="breadcrumb-item active">${review.title}</li>
            </ol>
        </nav>
        
        <!-- 리뷰 상세 내용 -->
        <div class="row">
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-start">
                            <div class="d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/resources/images/profiles/${review.userProfileImage != null ? review.userProfileImage : 'default-avatar.png'}" 
                                     class="rounded-circle me-3" width="50" height="50" alt="프로필">
                                <div>
                                    <h6 class="mb-1">${review.username}</h6>
                                    <div class="rating-stars mb-1">
                                        <c:forEach begin="1" end="5" var="star">
                                            <i class="fas fa-star ${star <= review.rating ? '' : 'text-muted'}"></i>
                                        </c:forEach>
                                        <span class="ms-2">${review.formattedRating}</span>
                                    </div>
                                    <small class="text-muted">${review.formattedCreatedAt}</small>
                                </div>
                            </div>
                            
                            <c:if test="${sessionScope.userNum == review.userNum}">
                                <div class="dropdown">
                                    <button class="btn btn-outline-secondary btn-sm dropdown-toggle" type="button" 
                                            data-bs-toggle="dropdown">관리</button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/reviews/edit/${review.reviewNum}">수정</a></li>
                                        <li><a class="dropdown-item text-danger" href="#" onclick="deleteReview()">삭제</a></li>
                                    </ul>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="card-body">
                        <h4 class="mb-3">${review.title}</h4>
                        <p class="mb-4" style="white-space: pre-line;">${review.content}</p>
                        
                        <div class="mb-3">
                            <small class="text-muted">
                                <i class="fas fa-map-marker-alt me-1"></i>
                                <strong>${review.chainName}</strong> - ${review.chainAddress}
                            </small>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex gap-2">
                                <button class="btn btn-outline-success like-btn ${review.currentUserLikeType == 'LIKE' ? 'active' : ''}" 
                                        onclick="toggleLike('LIKE')">
                                    <i class="fas fa-thumbs-up me-1"></i>
                                    <span id="likeCount">${review.likeCount}</span>
                                </button>
                                <button class="btn btn-outline-danger dislike-btn ${review.currentUserLikeType == 'DISLIKE' ? 'active' : ''}" 
                                        onclick="toggleLike('DISLIKE')">
                                    <i class="fas fa-thumbs-down me-1"></i>
                                    <span id="dislikeCount">${review.dislikeCount}</span>
                                </button>
                            </div>
                            <div class="d-flex gap-3 text-muted small">
                                <span><i class="fas fa-comment me-1"></i>${review.commentCount}개 댓글</span>
                                <span><i class="fas fa-eye me-1"></i>${review.viewCount}번 조회</span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 댓글 섹션 -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h6 class="mb-0">댓글 (${comments.size()})</h6>
                    </div>
                    <div class="card-body">
                        <!-- 댓글 작성 폼 -->
                        <c:if test="${not empty sessionScope.userNum}">
                            <div class="comment-form mb-4">
                                <form id="commentForm">
                                    <div class="mb-3">
                                        <textarea class="form-control" id="commentContent" rows="3" 
                                                  placeholder="댓글을 작성해주세요..." maxlength="500"></textarea>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted"><span id="commentCount">0</span> / 500자</small>
                                        <button type="submit" class="btn btn-primary">댓글 작성</button>
                                    </div>
                                </form>
                            </div>
                        </c:if>
                        
                        <!-- 댓글 목록 -->
                        <div id="commentsList">
                            <c:forEach var="comment" items="${comments}">
                                <div class="d-flex mb-3 comment-item" data-comment-id="${comment.commentNum}">
                                    <img src="${pageContext.request.contextPath}/resources/images/profiles/${comment.userProfileImage != null ? comment.userProfileImage : 'default-avatar.png'}" 
                                         class="rounded-circle me-3" width="40" height="40" alt="프로필">
                                    <div class="flex-grow-1">
                                        <div class="d-flex justify-content-between align-items-center mb-1">
                                            <strong>${comment.username}</strong>
                                            <div class="d-flex gap-2 align-items-center">
                                                <small class="text-muted">${comment.formattedCreatedAt}</small>
                                                <c:if test="${sessionScope.userNum == comment.userNum}">
                                                    <button class="btn btn-sm btn-outline-danger" 
                                                            onclick="deleteComment(${comment.commentNum})">삭제</button>
                                                </c:if>
                                            </div>
                                        </div>
                                        <p class="mb-0" style="white-space: pre-line;">${comment.content}</p>
                                    </div>
                                </div>
                            </c:forEach>
                            
                            <c:if test="${empty comments}">
                                <p class="text-muted text-center py-4">첫 댓글을 작성해보세요!</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 사이드바 -->
            <div class="col-lg-4">
                <!-- 가맹점 정보 -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h6 class="mb-0">가맹점 정보</h6>
                    </div>
                    <div class="card-body">
                        <h6>${review.chainName}</h6>
                        <p class="text-muted mb-3">${review.chainAddress}</p>
                        <div class="d-grid">
                            <a href="${pageContext.request.contextPath}/chain/detail/${review.chainNum}" 
                               class="btn btn-outline-primary">가맹점 상세보기</a>
                        </div>
                    </div>
                </div>
                
                <!-- 작성자 정보 -->
                <div class="card">
                    <div class="card-header">
                        <h6 class="mb-0">작성자 정보</h6>
                    </div>
                    <div class="card-body text-center">
                        <img src="${pageContext.request.contextPath}/resources/images/profiles/${review.userProfileImage != null ? review.userProfileImage : 'default-avatar.png'}" 
                             class="rounded-circle mb-3" width="80" height="80" alt="프로필">
                        <h6>${review.username}</h6>
                        <div class="d-grid">
                            <a href="${pageContext.request.contextPath}/reviews/list?author=${review.userNum}" 
                               class="btn btn-outline-secondary">다른 리뷰 보기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 댓글 글자수 카운터
        document.getElementById('commentContent')?.addEventListener('input', function() {
            document.getElementById('commentCount').textContent = this.value.length;
        });
        
        // 좋아요/싫어요 토글
        function toggleLike(type) {
            <c:if test="${empty sessionScope.userNum}">
                alert('로그인이 필요합니다.');
                return;
            </c:if>
            
            fetch('${pageContext.request.contextPath}/reviews/like', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'reviewNum=${review.reviewNum}&type=' + type
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    document.getElementById('likeCount').textContent = data.likeCount;
                    document.getElementById('dislikeCount').textContent = data.dislikeCount;
                    
                    // 버튼 상태 업데이트
                    const likeBtn = document.querySelector('.like-btn');
                    const dislikeBtn = document.querySelector('.dislike-btn');
                    
                    likeBtn.classList.remove('active');
                    dislikeBtn.classList.remove('active');
                    
                    if (data.currentUserLikeType === 'LIKE') {
                        likeBtn.classList.add('active');
                    } else if (data.currentUserLikeType === 'DISLIKE') {
                        dislikeBtn.classList.add('active');
                    }
                }
            });
        }
        
        // 댓글 작성
        document.getElementById('commentForm')?.addEventListener('submit', function(e) {
            e.preventDefault();
            
            const content = document.getElementById('commentContent').value.trim();
            if (!content) {
                alert('댓글 내용을 입력해주세요.');
                return;
            }
            
            fetch('${pageContext.request.contextPath}/reviews/comment', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'reviewNum=${review.reviewNum}&content=' + encodeURIComponent(content)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('댓글이 작성되었습니다.');
                    location.reload();
                } else {
                    alert(data.message);
                }
            });
        });
        
        // 댓글 삭제
        function deleteComment(commentNum) {
            if (confirm('댓글을 삭제하시겠습니까?')) {
                fetch('${pageContext.request.contextPath}/reviews/comment/delete', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'commentNum=' + commentNum
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                });
            }
        }
        
        // 리뷰 삭제
        function deleteReview() {
            if (confirm('리뷰를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/reviews/delete/${review.reviewNum}';
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>