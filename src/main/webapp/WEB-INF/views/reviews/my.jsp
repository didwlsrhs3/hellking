<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 리뷰 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .stats-card {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-radius: 16px;
        }
        .review-card {
            border-radius: 12px;
            transition: transform 0.2s;
        }
        .review-card:hover {
            transform: translateY(-2px);
        }
        .rating-stars {
            color: #ffc107;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-4">
        <!-- 페이지 헤더 -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h2 class="fw-bold">내 리뷰 관리</h2>
                <p class="text-muted">작성한 리뷰를 확인하고 관리하세요</p>
            </div>
            <div class="col-md-6 text-end">
                <a href="${pageContext.request.contextPath}/reviews/write" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>새 리뷰 작성
                </a>
            </div>
        </div>
        
        <!-- 통계 카드 -->
        <div class="stats-grid mb-5">
            <div class="stats-card p-4 text-center">
                <div class="display-6 fw-bold">${stats.totalCount}</div>
                <p class="mb-0">작성한 리뷰</p>
            </div>
            <div class="card p-4 text-center">
                <div class="display-6 fw-bold text-warning">${stats.avgRating}</div>
                <p class="mb-0 text-muted">평균 평점</p>
            </div>
            <div class="card p-4 text-center">
                <div class="display-6 fw-bold text-success">${stats.totalLikes}</div>
                <p class="mb-0 text-muted">받은 좋아요</p>
            </div>
        </div>
        
        <!-- 내 리뷰 목록 -->
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold">작성한 리뷰 (${myReviews.size()}개)</h4>
                    <div class="btn-group" role="group">
                        <input type="radio" class="btn-check" name="filterOptions" id="all" value="all" checked>
                        <label class="btn btn-outline-primary" for="all">전체</label>
                        
                        <input type="radio" class="btn-check" name="filterOptions" id="recent" value="recent">
                        <label class="btn btn-outline-primary" for="recent">최근 작성</label>
                        
                        <input type="radio" class="btn-check" name="filterOptions" id="popular" value="popular">
                        <label class="btn btn-outline-primary" for="popular">인기 리뷰</label>
                    </div>
                </div>
                
                <c:choose>
                    <c:when test="${not empty myReviews}">
                        <div class="row" id="reviewsList">
                            <c:forEach var="review" items="${myReviews}">
                                <div class="col-lg-6 mb-4 review-item" 
                                     data-date="${review.createdAt.time}"
                                     data-likes="${review.likeCount}">
                                    <div class="card review-card h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <div class="rating-stars">
                                                    <c:forEach begin="1" end="5" var="star">
                                                        <i class="fas fa-star ${star <= review.rating ? '' : 'text-muted'}"></i>
                                                    </c:forEach>
                                                    <span class="ms-2">${review.formattedRating}</span>
                                                </div>
                                                <div class="dropdown">
                                                    <button class="btn btn-sm btn-outline-secondary dropdown-toggle" 
                                                            type="button" data-bs-toggle="dropdown">관리</button>
                                                    <ul class="dropdown-menu">
                                                        <li><a class="dropdown-item" 
                                                               href="${pageContext.request.contextPath}/reviews/edit/${review.reviewNum}">
                                                            <i class="fas fa-edit me-2"></i>수정</a></li>
                                                        <li><a class="dropdown-item text-danger" href="#" 
                                                               onclick="deleteReview(${review.reviewNum})">
                                                            <i class="fas fa-trash me-2"></i>삭제</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                            
                                            <h6 class="card-title">${review.title}</h6>
                                            <p class="card-text">${review.shortContent}</p>
                                            
                                            <div class="mb-3">
                                                <small class="text-muted">
                                                    <i class="fas fa-map-marker-alt me-1"></i>${review.chainName}
                                                </small>
                                            </div>
                                            
                                            <div class="d-flex justify-content-between align-items-center mb-3">
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
                                            
                                            <div class="d-flex gap-2">
                                                <a href="${pageContext.request.contextPath}/reviews/detail/${review.reviewNum}" 
                                                   class="btn btn-outline-primary flex-fill">상세보기</a>
                                                <a href="${pageContext.request.contextPath}/reviews/edit/${review.reviewNum}" 
                                                   class="btn btn-outline-secondary">수정</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card">
                            <div class="card-body text-center py-5">
                                <i class="fas fa-pen-alt fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">작성한 리뷰가 없습니다</h5>
                                <p class="text-muted mb-4">첫 리뷰를 작성해보세요!</p>
                                <a href="${pageContext.request.contextPath}/reviews/write" 
                                   class="btn btn-primary">리뷰 작성하기</a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- 리뷰 작성 팁 -->
        <c:if test="${empty myReviews}">
            <div class="row mt-5">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h6 class="mb-0"><i class="fas fa-lightbulb me-2"></i>좋은 리뷰 작성 팁</h6>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <div class="text-center">
                                        <i class="fas fa-star fa-2x text-warning mb-2"></i>
                                        <h6>솔직한 평가</h6>
                                        <p class="small text-muted">실제 경험을 바탕으로 솔직하게 작성해주세요</p>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <div class="text-center">
                                        <i class="fas fa-camera fa-2x text-primary mb-2"></i>
                                        <h6>구체적인 내용</h6>
                                        <p class="small text-muted">시설, 서비스, 청결도 등을 구체적으로 설명해주세요</p>
                                    </div>
                                </div>
                                <div class="col-md-4 mb-3">
                                    <div class="text-center">
                                        <i class="fas fa-users fa-2x text-success mb-2"></i>
                                        <h6>도움이 되는 정보</h6>
                                        <p class="small text-muted">다른 회원들에게 도움이 되는 정보를 포함해주세요</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 리뷰 삭제
        function deleteReview(reviewNum) {
            if (confirm('정말로 이 리뷰를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/reviews/delete/' + reviewNum;
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // 필터링
        document.querySelectorAll('input[name="filterOptions"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const filterType = this.value;
                const reviews = document.querySelectorAll('.review-item');
                
                let sortedReviews = Array.from(reviews);
                
                if (filterType === 'recent') {
                    sortedReviews.sort((a, b) => {
                        return parseInt(b.dataset.date) - parseInt(a.dataset.date);
                    });
                } else if (filterType === 'popular') {
                    sortedReviews.sort((a, b) => {
                        return parseInt(b.dataset.likes) - parseInt(a.dataset.likes);
                    });
                }
                
                const container = document.getElementById('reviewsList');
                sortedReviews.forEach(review => container.appendChild(review));
            });
        });
    </script>
</body>
</html>