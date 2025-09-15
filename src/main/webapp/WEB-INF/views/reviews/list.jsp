<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객 리뷰 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .review-card {
            transition: transform 0.2s, box-shadow 0.2s;
            height: 100%;
        }
        .review-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .rating-stars {
            color: #ffc107;
        }
        .excellent-badge {
            background: linear-gradient(45deg, #ff6a00, #ff8533);
        }
        .hero-section {
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            color: white;
            padding: 60px 0;
        }
        .debug-info {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 8px;
            padding: 10px;
            margin-bottom: 15px;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-5 fw-bold mb-3">고객 리뷰</h1>
                    <p class="lead">실제 회원들의 생생한 후기를 확인해보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <!-- 디버깅 정보 표시 -->
                    <div class="debug-info">
                        <strong>세션 디버깅:</strong><br>
                        userNum: '${sessionScope.userNum}'<br>
                        userId: '${sessionScope.userId}'<br>
                        username: '${sessionScope.username}'<br>
                        empty? ${empty sessionScope.userNum}
                    </div>
                    
                    <!-- 글쓰기 버튼 조건문 -->
                    <c:choose>
                        <c:when test="${not empty sessionScope.userNum}">
                            <a href="${pageContext.request.contextPath}/reviews/write" class="btn btn-light btn-lg">
                                <i class="fas fa-edit me-2"></i>리뷰 작성하기
                            </a>
                            <div class="mt-2" style="font-size: 14px;">
                                환영합니다, ${sessionScope.username}님!
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-sign-in-alt me-2"></i>로그인 후 작성
                            </a>
                            <div class="mt-2" style="font-size: 14px;">
                                리뷰 작성을 위해 로그인해주세요
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 우수 리뷰 섹션 -->
        <c:if test="${not empty excellentReviews}">
            <div class="row mb-5">
                <div class="col-12">
                    <h3 class="fw-bold mb-4">
                        <i class="fas fa-crown text-warning me-2"></i>이달의 우수 리뷰
                    </h3>
                    <div class="row">
                        <c:forEach var="review" items="${excellentReviews}">
                            <div class="col-md-4 mb-3">
                                <div class="card review-card border-warning">
                                    <div class="card-header bg-warning text-dark">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <strong>${review.username}</strong>
                                            <span class="badge excellent-badge text-white">우수리뷰</span>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <h6 class="card-title">${review.title}</h6>
                                        <p class="card-text text-muted small">${review.shortContent}</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="rating-stars">
                                                <c:forEach begin="1" end="5" var="star">
                                                    <i class="fas fa-star ${star <= review.rating ? '' : 'text-muted'}"></i>
                                                </c:forEach>
                                                <span class="ms-1">${review.formattedRating}</span>
                                            </div>
                                            <small class="text-muted">${review.chainName}</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>
        
        <!-- 필터 및 정렬 -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h4>전체 리뷰 (${reviewData.totalCount}개)</h4>
            </div>
            <div class="col-md-6 text-end">
                <div class="btn-group" role="group">
                    <input type="radio" class="btn-check" name="sortOptions" id="latest" value="latest" 
                           ${currentSort == 'latest' ? 'checked' : ''}>
                    <label class="btn btn-outline-primary" for="latest">최신순</label>
                    
                    <input type="radio" class="btn-check" name="sortOptions" id="rating" value="rating"
                           ${currentSort == 'rating' ? 'checked' : ''}>
                    <label class="btn btn-outline-primary" for="rating">평점순</label>
                    
                    <input type="radio" class="btn-check" name="sortOptions" id="like" value="like"
                           ${currentSort == 'like' ? 'checked' : ''}>
                    <label class="btn btn-outline-primary" for="like">좋아요순</label>
                </div>
            </div>
        </div>
        
        <!-- 리뷰 목록 -->
        <div class="row">
            <c:forEach var="review" items="${reviewData.reviews}">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card review-card h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <div class="d-flex align-items-center">
                                    <img src="${pageContext.request.contextPath}/resources/images/profiles/${review.userProfileImage != null ? review.userProfileImage : 'default-avatar.png'}" 
                                         class="rounded-circle me-2" width="40" height="40" alt="프로필">
                                    <div>
                                        <strong>${review.username}</strong>
                                        <div class="rating-stars">
                                            <c:forEach begin="1" end="5" var="star">
                                                <i class="fas fa-star ${star <= review.rating ? '' : 'text-muted'}"></i>
                                            </c:forEach>
                                            <span class="ms-1">${review.formattedRating}</span>
                                        </div>
                                    </div>
                                </div>
                                <c:if test="${review.isExcellentReview()}">
                                    <span class="badge excellent-badge text-white">우수</span>
                                </c:if>
                            </div>
                            
                            <h6 class="card-title">${review.title}</h6>
                            <p class="card-text">${review.shortContent}</p>
                            
                            <div class="mb-2">
                                <small class="text-muted">
                                    <i class="fas fa-map-marker-alt me-1"></i>${review.chainName}
                                </small>
                            </div>
                            
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="d-flex gap-2">
                                    <span class="text-muted small">
                                        <i class="fas fa-thumbs-up me-1"></i>${review.likeCount}
                                    </span>
                                    <span class="text-muted small">
                                        <i class="fas fa-comment me-1"></i>${review.commentCount}
                                    </span>
                                    <span class="text-muted small">
                                        <i class="fas fa-eye me-1"></i>${review.viewCount}
                                    </span>
                                </div>
                                <small class="text-muted">${review.formattedCreatedAt}</small>
                            </div>
                        </div>
                        <div class="card-footer bg-transparent">
                            <a href="${pageContext.request.contextPath}/reviews/detail/${review.reviewNum}" 
                               class="btn btn-outline-primary w-100">자세히 보기</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!-- 리뷰가 없는 경우 -->
        <c:if test="${empty reviewData.reviews}">
            <div class="text-center py-5">
                <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                <h4 class="text-muted">아직 작성된 리뷰가 없습니다</h4>
                <p class="text-muted mb-4">첫 번째 리뷰를 작성해보세요!</p>
                <c:if test="${not empty sessionScope.userNum}">
                    <a href="${pageContext.request.contextPath}/reviews/write" class="btn btn-primary btn-lg">
                        <i class="fas fa-edit me-2"></i>첫 리뷰 작성하기
                    </a>
                </c:if>
            </div>
        </c:if>
        
        <!-- 페이징 -->
        <c:if test="${reviewData.totalPages > 1}">
            <nav aria-label="리뷰 페이지네이션">
                <ul class="pagination justify-content-center">
                    <c:if test="${reviewData.hasPrev}">
                        <li class="page-item">
                            <a class="page-link" href="?sort=${currentSort}&page=${reviewData.currentPage - 1}">이전</a>
                        </li>
                    </c:if>
                    
                    <c:forEach begin="${reviewData.currentPage - 2 < 1 ? 1 : reviewData.currentPage - 2}" 
                               end="${reviewData.currentPage + 2 > reviewData.totalPages ? reviewData.totalPages : reviewData.currentPage + 2}" 
                               var="pageNum">
                        <li class="page-item ${pageNum == reviewData.currentPage ? 'active' : ''}">
                            <a class="page-link" href="?sort=${currentSort}&page=${pageNum}">${pageNum}</a>
                        </li>
                    </c:forEach>
                    
                    <c:if test="${reviewData.hasNext}">
                        <li class="page-item">
                            <a class="page-link" href="?sort=${currentSort}&page=${reviewData.currentPage + 1}">다음</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
        
        <!-- 로그인 유도 섹션 -->
        <c:if test="${empty sessionScope.userNum}">
            <div class="row mt-5">
                <div class="col-12">
                    <div class="card bg-light">
                        <div class="card-body text-center py-4">
                            <h5 class="card-title">리뷰를 작성하고 싶으신가요?</h5>
                            <p class="card-text text-muted">로그인하고 다른 회원들과 피트니스 경험을 공유해보세요!</p>
                            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary me-2">로그인</a>
                            <a href="${pageContext.request.contextPath}/user/join" class="btn btn-outline-primary">회원가입</a>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 세션 디버깅 정보를 콘솔에 출력
        console.log('=== 리뷰 페이지 세션 디버깅 ===');
        console.log('userNum:', '${sessionScope.userNum}');
        console.log('userId:', '${sessionScope.userId}');
        console.log('username:', '${sessionScope.username}');
        console.log('empty userNum?', ${empty sessionScope.userNum});
        console.log('========================');
        
        // 정렬 옵션 변경 시
        document.querySelectorAll('input[name="sortOptions"]').forEach(radio => {
            radio.addEventListener('change', function() {
                location.href = '?sort=' + this.value + '&page=1';
            });
        });
        
        // 페이지 로드 시 세션 상태 확인
        document.addEventListener('DOMContentLoaded', function() {
            const userNum = '${sessionScope.userNum}';
            const debugInfo = document.querySelector('.debug-info');
            
            if (userNum && userNum.trim() !== '') {
                console.log('✅ 로그인 상태 확인됨');
                if (debugInfo) {
                    debugInfo.style.borderColor = '#28a745';
                    debugInfo.innerHTML += '<br><span style="color: #28a745;">✅ 로그인됨</span>';
                }
            } else {
                console.log('❌ 로그인되지 않은 상태');
                if (debugInfo) {
                    debugInfo.style.borderColor = '#dc3545';
                    debugInfo.innerHTML += '<br><span style="color: #dc3545;">❌ 미로그인</span>';
                }
            }
        });
        
        // 글쓰기 버튼 클릭 시 추가 확인
        document.addEventListener('click', function(e) {
            if (e.target.closest('a[href*="/reviews/write"]')) {
                console.log('글쓰기 버튼 클릭됨');
                const userNum = '${sessionScope.userNum}';
                if (!userNum || userNum.trim() === '') {
                    console.log('⚠️ 세션이 없는데 글쓰기 버튼이 표시됨');
                }
            }
        });
    </script>
</body>
</html>