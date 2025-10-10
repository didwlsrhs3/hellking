<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<<<<<<< HEAD
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
=======
    <title>리뷰 상세 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        .page-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 60px 0;
        }
        
        :root {
            --brand: #FF6A00;
            --ink: #0F172A;
            --muted: #5B6170;
            --line: #E7E0D6;
        }
        
        .review-content img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
            margin: 10px 0;
        }
        
        .rating-stars {
            color: #ffc107;
        }
        
        .reaction-buttons {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        
        .reaction-btn {
            border: 1px solid #ddd;
            background: white;
            padding: 8px 16px;
            border-radius: 20px;
            cursor: pointer;
            transition: all 0.2s;
            font-size: 14px;
        }
        
        .reaction-btn:hover {
            border-color: var(--brand);
            color: var(--brand);
        }
        
        .reaction-btn.active {
            background: var(--brand);
            border-color: var(--brand);
            color: white;
        }
        
        .comment-section {
            border-top: 1px solid #e9ecef;
            margin-top: 30px;
            padding-top: 30px;
        }
        
        .comment-item {
            border-bottom: 1px solid #f8f9fa;
            padding: 15px 0;
        }
        
        .comment-item:last-child {
            border-bottom: none;
        }
        
        .comment-author {
            font-weight: 600;
            color: var(--ink);
        }
        
        .comment-content {
            margin: 8px 0;
            line-height: 1.5;
        }
        
        .comment-date {
            font-size: 12px;
            color: var(--muted);
        }
        
        /* 수정된 이미지 갤러리 스타일 */
        .image-gallery {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            margin: 20px 0;
        }
        
        .image-gallery img {
            width: 100%;
            max-height: 400px; /* 최대 높이 제한 */
            object-fit: contain; /* 비율 유지하면서 전체 이미지 표시 */
            border-radius: 8px;
            cursor: pointer;
            transition: transform 0.2s;
            border: 1px solid #e9ecef;
        }
        
        .image-gallery img:hover {
            transform: scale(1.02);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        /* 모달 내 이미지 */
        #modalImage {
            max-width: 100%;
            max-height: 80vh;
            object-fit: contain;
        }
        
        /* 반응형 */
        @media (max-width: 768px) {
            .page-header {
                padding: 40px 0;
            }
            .page-header .row {
                text-align: center;
            }
            .page-header .col-md-4 {
                margin-top: 20px;
            }
            
            .image-gallery {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 10px;
            }
            
            .image-gallery img {
                max-height: 300px;
            }
        }
>>>>>>> b65c320 (Initial commit)
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
<<<<<<< HEAD
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
=======
    <!-- 패스권 상세정보 헤더 -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">리뷰 상세정보</h2>
                    <p class="lead">회원들의 생생한 후기와 경험담</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/reviews/list" class="btn btn-outline-light">
                        <i class="fas fa-list me-2"></i>리뷰 목록
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4 mb-5">
        <div class="row">
            <div class="col-lg-8">
                <!-- 리뷰 상세 카드 -->
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <!-- 리뷰 헤더 -->
                        <div class="d-flex justify-content-between align-items-start mb-4">
                            <div class="d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/resources/images/profiles/${review.userProfileImage != null ? review.userProfileImage : 'default-avatar.png'}" 
                                     class="rounded-circle me-3" width="60" height="60" alt="프로필">
                                <div>
                                    <h5 class="mb-1">${review.username}</h5>
>>>>>>> b65c320 (Initial commit)
                                    <div class="rating-stars mb-1">
                                        <c:forEach begin="1" end="5" var="star">
                                            <i class="fas fa-star ${star <= review.rating ? '' : 'text-muted'}"></i>
                                        </c:forEach>
<<<<<<< HEAD
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
=======
                                        <span class="ms-2">${review.formattedRating}점</span>
                                    </div>
                                    <small class="text-muted">${review.formattedCreatedAt} • ${review.chainName}</small>
                                </div>
                            </div>
                            
                            <!-- 작성자 메뉴 -->
                            <c:if test="${sessionScope.userNum == review.userNum}">
                                <div class="dropdown">
                                    <button class="btn btn-outline-secondary btn-sm dropdown-toggle" 
                                            type="button" data-bs-toggle="dropdown">
                                        관리
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li><a class="dropdown-item" 
                                               href="${pageContext.request.contextPath}/reviews/edit/${review.reviewNum}">
                                            <i class="fas fa-edit me-2"></i>수정</a></li>
                                        <li><a class="dropdown-item text-danger" href="#" 
                                               onclick="deleteReview(${review.reviewNum})">
                                            <i class="fas fa-trash me-2"></i>삭제</a></li>
>>>>>>> b65c320 (Initial commit)
                                    </ul>
                                </div>
                            </c:if>
                        </div>
<<<<<<< HEAD
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
=======
                        
                        <!-- 리뷰 제목 -->
                        <h3 class="mb-3">${review.title}</h3>
                        
                        <!-- 원본 이미지 갤러리 - 수정된 부분 -->
                        <c:if test="${review.hasImages()}">
                            <div class="image-gallery">
                                <c:forEach var="image" items="${review.images}">
                                    <!-- 원본 이미지 경로 계산 -->
                                    <c:set var="originalPath" value="${image.imagePath}" />
                                    <c:if test="${image.imagePath.contains('s_')}">
                                        <!-- 썸네일 경로에서 원본 경로 추출 -->
                                        <c:set var="originalPath" value="${image.imagePath.replace('s_', '')}" />
                                    </c:if>
                                    
                                    <img src="${pageContext.request.contextPath}/displayFile?fileName=${originalPath}" 
                                         alt="${image.originalName}" 
                                         onclick="openImageModal('${pageContext.request.contextPath}/displayFile?fileName=${originalPath}', '${image.originalName}')"
                                         onerror="console.log('원본 이미지 로드 실패, 썸네일로 fallback'); this.src='${pageContext.request.contextPath}/displayFile?fileName=${image.imagePath}';"
                                         loading="lazy">
                                </c:forEach>
                            </div>
                        </c:if>
                        
                        <!-- 리뷰 내용 -->
                        <div class="review-content">
                            <p class="lead">${review.content}</p>
                        </div>
                        
                        <!-- 리뷰 통계 -->
                        <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                            <div class="d-flex gap-4">
                                <span class="text-muted">
                                    <i class="fas fa-eye me-1"></i>조회 ${review.viewCount}
                                </span>
                                <span class="text-muted">
                                    <i class="fas fa-comment me-1"></i>댓글 ${review.commentCount}
                                </span>
                            </div>
                            
                            <!-- 반응 버튼 -->
                            <div class="reaction-buttons">
                                <button class="reaction-btn ${userReaction == 'like' ? 'active' : ''}" 
                                        onclick="toggleReaction('like')">
                                    <i class="fas fa-thumbs-up me-1"></i>좋아요 ${review.likeCount}
                                </button>
                                <button class="reaction-btn ${userReaction == 'dislike' ? 'active' : ''}" 
                                        onclick="toggleReaction('dislike')">
                                    <i class="fas fa-thumbs-down me-1"></i>아쉬워요 ${review.dislikeCount}
                                </button>
>>>>>>> b65c320 (Initial commit)
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 댓글 섹션 -->
<<<<<<< HEAD
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
=======
                <div class="card shadow-sm mt-4">
                    <div class="card-body">
                        <h5 class="mb-4">
                            <i class="fas fa-comments me-2"></i>댓글 (${review.commentCount}개)
                        </h5>
                        
                        <!-- 댓글 작성 폼 -->
                        <c:choose>
                            <c:when test="${not empty sessionScope.userNum}">
                                <form action="${pageContext.request.contextPath}/reviews/comment" method="post" class="mb-4">
                                    <input type="hidden" name="reviewNum" value="${review.reviewNum}">
                                    <div class="d-flex">
                                        <img src="${pageContext.request.contextPath}/resources/images/profiles/${sessionScope.userProfileImage != null ? sessionScope.userProfileImage : 'default-avatar.png'}" 
                                             class="rounded-circle me-3" width="40" height="40" alt="내 프로필">
                                        <div class="flex-grow-1">
                                            <textarea class="form-control" name="content" rows="3" 
                                                      placeholder="댓글을 작성해주세요..." required></textarea>
                                            <div class="text-end mt-2">
                                                <button type="submit" class="btn btn-primary btn-sm">
                                                    <i class="fas fa-paper-plane me-1"></i>댓글 등록
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-3 bg-light rounded mb-4">
                                    <p class="mb-2">댓글을 작성하려면 로그인이 필요합니다.</p>
                                    <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary btn-sm">
                                        <i class="fas fa-sign-in-alt me-1"></i>로그인
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        
                        <!-- 댓글 목록 -->
                        <div class="comment-section">
                            <c:choose>
                                <c:when test="${not empty comments}">
                                    <c:forEach var="comment" items="${comments}">
                                        <div class="comment-item">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div class="d-flex">
                                                    <img src="${pageContext.request.contextPath}/resources/images/profiles/${comment.userProfileImage != null ? comment.userProfileImage : 'default-avatar.png'}" 
                                                         class="rounded-circle me-3" width="40" height="40" alt="프로필">
                                                    <div>
                                                        <div class="comment-author">${comment.username}</div>
                                                        <div class="comment-content">${comment.content}</div>
                                                        <div class="comment-date">${comment.formattedCreatedAt}</div>
                                                    </div>
                                                </div>
                                                
                                                <!-- 댓글 작성자만 삭제 가능 -->
                                                <c:if test="${sessionScope.userNum == comment.userNum}">
                                                    <button class="btn btn-sm btn-outline-danger" 
                                                            onclick="deleteComment(${comment.commentNum})">
                                                        <i class="fas fa-times"></i>
                                                    </button>
                                                </c:if>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-4 text-muted">
                                        <i class="fas fa-comment fa-2x mb-2"></i>
                                        <p>첫 번째 댓글을 작성해보세요!</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
>>>>>>> b65c320 (Initial commit)
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 사이드바 -->
            <div class="col-lg-4">
                <!-- 가맹점 정보 -->
<<<<<<< HEAD
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
=======
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h6 class="card-title">
                            <i class="fas fa-map-marker-alt me-2"></i>가맹점 정보
                        </h6>
                        <div class="d-flex align-items-center mb-3">
                            <img src="${pageContext.request.contextPath}/resources/images/chains/gym${review.chainNum}.jpg" 
                                 class="rounded me-3" width="60" height="60" alt="${review.chainName}"
                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='inline-block';">
                            <i class="fas fa-dumbbell fa-2x text-muted" style="display: none;"></i>
                            <div>
                                <h6 class="mb-1">${review.chainName}</h6>
                                <small class="text-muted">${review.chainAddress}</small>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/chains/detail/${review.chainNum}" 
                           class="btn btn-outline-primary btn-sm w-100">
                            <i class="fas fa-info-circle me-1"></i>가맹점 상세보기
                        </a>
                    </div>
                </div>
                
                <!-- 작성자 다른 리뷰 -->
                <c:if test="${not empty authorOtherReviews}">
                    <div class="card shadow-sm mb-4">
                        <div class="card-body">
                            <h6 class="card-title">
                                <i class="fas fa-user-edit me-2"></i>${review.username}님의 다른 리뷰
                            </h6>
                            <c:forEach var="otherReview" items="${authorOtherReviews}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/reviews/detail/${otherReview.reviewNum}" 
                                           class="text-decoration-none">
                                            <h6 class="mb-1">${otherReview.title}</h6>
                                        </a>
                                        <div class="rating-stars small mb-1">
                                            <c:forEach begin="1" end="5" var="star">
                                                <i class="fas fa-star ${star <= otherReview.rating ? '' : 'text-muted'}"></i>
                                            </c:forEach>
                                        </div>
                                        <small class="text-muted">${otherReview.chainName}</small>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                
                <!-- 관련 리뷰 -->
                <c:if test="${not empty relatedReviews}">
                    <div class="card shadow-sm">
                        <div class="card-body">
                            <h6 class="card-title">
                                <i class="fas fa-thumbs-up me-2"></i>이 가맹점 다른 리뷰
                            </h6>
                            <c:forEach var="relatedReview" items="${relatedReviews}" varStatus="status">
                                <c:if test="${status.index < 3}">
                                    <div class="mb-3">
                                        <a href="${pageContext.request.contextPath}/reviews/detail/${relatedReview.reviewNum}" 
                                           class="text-decoration-none">
                                            <h6 class="mb-1">${relatedReview.title}</h6>
                                        </a>
                                        <div class="rating-stars small mb-1">
                                            <c:forEach begin="1" end="5" var="star">
                                                <i class="fas fa-star ${star <= relatedReview.rating ? '' : 'text-muted'}"></i>
                                            </c:forEach>
                                            <span class="ms-1">${relatedReview.username}</span>
                                        </div>
                                        <small class="text-muted">${relatedReview.formattedCreatedAt}</small>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <!-- 이미지 모달 -->
    <div class="modal fade" id="imageModal" tabindex="-1">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="imageModalTitle">이미지</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center">
                    <img id="modalImage" src="" alt="" class="img-fluid">
>>>>>>> b65c320 (Initial commit)
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
<<<<<<< HEAD
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
=======
        // 반응 토글
        function toggleReaction(reactionType) {
            <c:choose>
                <c:when test="${empty sessionScope.userNum}">
                    alert('로그인이 필요합니다.');
                    window.location.href = '${pageContext.request.contextPath}/user/login';
                    return;
                </c:when>
                <c:otherwise>
                    fetch('${pageContext.request.contextPath}/reviews/reaction', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: 'reviewNum=${review.reviewNum}&reactionType=' + reactionType
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            location.reload();
                        } else {
                            alert('반응 등록 중 오류가 발생했습니다.');
                        }
                    })
                    .catch(error => {
                        console.error('반응 오류:', error);
                        alert('반응 등록 중 오류가 발생했습니다.');
                    });
                </c:otherwise>
            </c:choose>
        }
        
        // 리뷰 삭제
        function deleteReview(reviewNum) {
            if (confirm('정말로 이 리뷰를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/reviews/delete/' + reviewNum;
>>>>>>> b65c320 (Initial commit)
                document.body.appendChild(form);
                form.submit();
            }
        }
<<<<<<< HEAD
=======
        
        // 댓글 삭제
        function deleteComment(commentNum) {
            if (confirm('댓글을 삭제하시겠습니까?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/reviews/deleteComment';
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'commentNum';
                input.value = commentNum;
                form.appendChild(input);
                
                const reviewNumInput = document.createElement('input');
                reviewNumInput.type = 'hidden';
                reviewNumInput.name = 'reviewNum';
                reviewNumInput.value = '${review.reviewNum}';
                form.appendChild(reviewNumInput);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // 이미지 모달 열기
        function openImageModal(imageSrc, imageName) {
            document.getElementById('modalImage').src = imageSrc;
            document.getElementById('imageModalTitle').textContent = imageName;
            new bootstrap.Modal(document.getElementById('imageModal')).show();
        }
        
        // 키보드 단축키
        document.addEventListener('keydown', function(e) {
            // ESC: 모달 닫기
            if (e.key === 'Escape') {
                const modal = bootstrap.Modal.getInstance(document.getElementById('imageModal'));
                if (modal) {
                    modal.hide();
                }
            }
        });
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            console.log('리뷰 상세 페이지 로드됨');
            
            // 이미지 로드 에러 처리 개선
            document.querySelectorAll('.image-gallery img').forEach(img => {
                img.addEventListener('error', function() {
                    console.log('이미지 로드 실패:', this.src);
                    // fallback이 이미 적용되었다면 숨김
                    if (this.src.includes('s_')) {
                        this.style.display = 'none';
                    }
                });
                
                img.addEventListener('load', function() {
                    console.log('이미지 로드 성공:', this.src, '크기:', this.naturalWidth, 'x', this.naturalHeight);
                });
            });
        });
>>>>>>> b65c320 (Initial commit)
    </script>
</body>
</html>