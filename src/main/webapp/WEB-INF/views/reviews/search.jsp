<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 검색 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .search-header {
            background: linear-gradient(135deg, #6f42c1, #e83e8c);
            color: white;
            padding: 40px 0;
        }
        .review-card {
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .review-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .rating-stars {
            color: #ffc107;
        }
        .highlight {
            background-color: #fff3cd;
            padding: 1px 3px;
            border-radius: 3px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 검색 헤더 -->
    <div class="search-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">리뷰 검색</h2>
                    <p class="lead mb-0">원하는 리뷰를 찾아보세요</p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 검색 폼 -->
        <div class="row mb-4">
            <div class="col-12">
                <form action="${pageContext.request.contextPath}/reviews/search" method="get">
                    <div class="input-group input-group-lg">
                        <input type="text" class="form-control" name="keyword" 
                               placeholder="리뷰 내용, 가맹점명으로 검색하세요..." 
                               value="${searchResult.keyword}">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-search"></i> 검색
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- 검색 결과 -->
        <c:if test="${not empty searchResult.keyword}">
            <div class="row mb-4">
                <div class="col-md-6">
                    <h4>"${searchResult.keyword}" 검색 결과</h4>
                    <p class="text-muted">총 ${searchResult.totalCount}개의 리뷰를 찾았습니다</p>
                </div>
                <div class="col-md-6 text-end">
                    <div class="btn-group" role="group">
                        <input type="radio" class="btn-check" name="sortOptions" id="relevance" value="relevance" checked>
                        <label class="btn btn-outline-primary" for="relevance">관련도순</label>
                        
                        <input type="radio" class="btn-check" name="sortOptions" id="latest" value="latest">
                        <label class="btn btn-outline-primary" for="latest">최신순</label>
                        
                        <input type="radio" class="btn-check" name="sortOptions" id="rating" value="rating">
                        <label class="btn btn-outline-primary" for="rating">평점순</label>
                    </div>
                </div>
            </div>
            
            <!-- 검색 결과 목록 -->
            <div class="row">
                <c:choose>
                    <c:when test="${not empty searchResult.reviews}">
                        <c:forEach var="review" items="${searchResult.reviews}">
                            <div class="col-lg-6 mb-4">
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
                                            <small class="text-muted">${review.formattedCreatedAt}</small>
                                        </div>
                                        
                                        <h6 class="card-title">${review.title}</h6>
                                        <p class="card-text">${review.shortContent}</p>
                                        
                                        <div class="mb-3">
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
                                            <a href="${pageContext.request.contextPath}/reviews/detail/${review.reviewNum}" 
                                               class="btn btn-sm btn-outline-primary">자세히 보기</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <div class="text-center py-5">
                                <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">검색 결과가 없습니다</h5>
                                <p class="text-muted">다른 키워드로 검색해보세요</p>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- 페이징 -->
            <c:if test="${searchResult.totalPages > 1}">
                <nav aria-label="검색 결과 페이지네이션">
                    <ul class="pagination justify-content-center">
                        <c:if test="${searchResult.currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="?keyword=${searchResult.keyword}&page=${searchResult.currentPage - 1}">이전</a>
                            </li>
                        </c:if>
                        
                        <c:forEach begin="${searchResult.currentPage - 2 < 1 ? 1 : searchResult.currentPage - 2}" 
                                   end="${searchResult.currentPage + 2 > searchResult.totalPages ? searchResult.totalPages : searchResult.currentPage + 2}" 
                                   var="pageNum">
                            <li class="page-item ${pageNum == searchResult.currentPage ? 'active' : ''}">
                                <a class="page-link" href="?keyword=${searchResult.keyword}&page=${pageNum}">${pageNum}</a>
                            </li>
                        </c:forEach>
                        
                        <c:if test="${searchResult.currentPage < searchResult.totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="?keyword=${searchResult.keyword}&page=${searchResult.currentPage + 1}">다음</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </c:if>
        
        <!-- 검색어가 없는 경우 -->
        <c:if test="${empty searchResult.keyword}">
            <div class="text-center py-5">
                <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                <h5 class="text-muted">검색어를 입력해주세요</h5>
                <p class="text-muted">리뷰 내용이나 가맹점명으로 검색할 수 있습니다</p>
            </div>
        </c:if>
        
        <!-- 인기 검색어 (선택사항) -->
        <c:if test="${empty searchResult.keyword}">
            <div class="card mt-4">
                <div class="card-header">
                    <h6 class="mb-0">인기 검색어</h6>
                </div>
                <div class="card-body">
                    <div class="d-flex flex-wrap gap-2">
                        <a href="?keyword=청결" class="btn btn-sm btn-outline-secondary">#청결</a>
                        <a href="?keyword=친절" class="btn btn-sm btn-outline-secondary">#친절</a>
                        <a href="?keyword=시설" class="btn btn-sm btn-outline-secondary">#시설</a>
                        <a href="?keyword=운동기구" class="btn btn-sm btn-outline-secondary">#운동기구</a>
                        <a href="?keyword=샤워실" class="btn btn-sm btn-outline-secondary">#샤워실</a>
                        <a href="?keyword=주차" class="btn btn-sm btn-outline-secondary">#주차</a>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 정렬 변경
        document.querySelectorAll('input[name="sortOptions"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const url = new URL(window.location);
                url.searchParams.set('sort', this.value);
                window.location.href = url.toString();
            });
        });
        
        // 검색어 하이라이트 (실제 구현 시)
        function highlightKeyword(text, keyword) {
            if (!keyword) return text;
            const regex = new RegExp(`(${keyword})`, 'gi');
            return text.replace(regex, '<span class="highlight">$1</span>');
        }
    </script>
</body>
</html>