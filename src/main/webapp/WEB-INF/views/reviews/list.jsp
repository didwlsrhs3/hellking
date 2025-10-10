<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<<<<<<< HEAD
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
=======
>>>>>>> b65c320 (Initial commit)
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객 리뷰 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
<<<<<<< HEAD
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
=======
        body { 
            background: white; 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif;
        }
        
        .page-header {
            background: linear-gradient(135deg, #e83e8c, #6f42c1);
            color: white;
            padding: 60px 0;
            position: relative;
            overflow: hidden;
        }
        
        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="white" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="white" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
        }
        
        :root {
            --brand: #FF6A00;
            --ink: #0F172A;
            --muted: #5B6170;
            --line: #E7E0D6;
            --surface: #FAFAFA;
        }
        
        .search-filter-section {
            background: white;
            padding: 25px;
            margin-bottom: 25px;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            border: 1px solid #f0f0f0;
        }
        
        .search-form {
            display: flex;
            gap: 12px;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .search-input {
            flex: 1;
            min-width: 200px;
            border-radius: 30px;
            border: 2px solid #e9ecef;
            padding: 12px 20px;
            font-size: 14px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: #fafafa;
        }
        
        .search-input:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 0.2rem rgba(255, 106, 0, 0.15);
            background: white;
            transform: translateY(-1px);
        }
        
        .search-btn {
            border-radius: 30px;
            padding: 12px 24px;
            background: linear-gradient(135deg, var(--brand), #e65a00);
            border: none;
            color: white;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 12px rgba(255, 106, 0, 0.3);
        }
        
        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 106, 0, 0.4);
            background: linear-gradient(135deg, #e65a00, #cc5200);
        }
        
        .category-filter {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
            justify-content: center;
        }
        
        .category-tab {
            padding: 10px 20px;
            border: 2px solid #e9ecef;
            border-radius: 25px;
            text-decoration: none;
            color: #6c757d;
            font-weight: 500;
            font-size: 14px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            background: white;
            position: relative;
            overflow: hidden;
        }
        
        .category-tab::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
            transition: left 0.5s;
        }
        
        .category-tab:hover::before {
            left: 100%;
        }
        
        .category-tab:hover {
            border-color: var(--brand);
            color: var(--brand);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(255, 106, 0, 0.2);
        }
        
        .category-tab.active {
            background: linear-gradient(135deg, var(--brand), #e65a00);
            border-color: var(--brand);
            color: white;
            transform: translateY(-1px);
            box-shadow: 0 4px 15px rgba(255, 106, 0, 0.3);
        }
        
        .excellent-badge {
            background: linear-gradient(45deg, #ff6a00, #ff8533);
            animation: glow 2s ease-in-out infinite alternate;
        }
        
        .candidate-badge {
            background: linear-gradient(45deg, #17a2b8, #20c997);
        }
        
        @keyframes glow {
            from { box-shadow: 0 0 5px rgba(255, 106, 0, 0.5); }
            to { box-shadow: 0 0 15px rgba(255, 106, 0, 0.8); }
        }
        
        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        /* 한 줄 리스트 스타일 */
        .review-list-item {
            background: white;
            border: 1px solid var(--line);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 20px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            position: relative;
            overflow: hidden;
            animation: slideInUp 0.5s ease-out;
        }
        
        .review-list-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--brand);
            transform: scaleY(0);
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .review-list-item:hover::before {
            transform: scaleY(1);
        }
        
        .review-list-item:hover {
            background: var(--surface);
            border-color: var(--brand);
            transform: translateY(-4px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.12);
        }
        
        /* 가맹점 섹션 */
        .chain-section {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 90px;
            flex-shrink: 0;
        }
        
        .chain-image {
            width: 64px;
            height: 64px;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border: 2px solid #e9ecef;
            margin-bottom: 8px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }
        
        .chain-image::after {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(45deg, transparent 30%, rgba(255,255,255,0.3) 50%, transparent 70%);
            transform: translateX(-100%);
            transition: transform 0.6s;
        }
        
        .review-list-item:hover .chain-image::after {
            transform: translateX(100%);
        }
        
        .chain-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        
        .review-list-item:hover .chain-image img {
            transform: scale(1.1);
        }
        
        .chain-image .default-icon {
            font-size: 20px;
            color: var(--muted);
        }
        
        .chain-name {
            font-size: 11px;
            font-weight: 700;
            color: var(--brand);
            text-align: center;
            line-height: 1.2;
            word-break: keep-all;
            letter-spacing: -0.3px;
        }
        
        /* 리뷰 이미지 썸네일 */
        .review-thumbnail {
            width: 72px;
            height: 72px;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            overflow: hidden;
            border: 2px solid #e9ecef;
            position: relative;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .review-thumbnail img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .review-list-item:hover .review-thumbnail img {
            transform: scale(1.15);
        }
        
        .review-thumbnail .image-count {
            position: absolute;
            bottom: 4px;
            right: 4px;
            background: rgba(15, 23, 42, 0.85);
            color: white;
            font-size: 10px;
            font-weight: 600;
            padding: 2px 6px;
            border-radius: 8px;
            backdrop-filter: blur(4px);
        }
        
        /* 메인 콘텐츠 */
        .review-content {
            flex-grow: 1;
            min-width: 0;
            padding-right: 16px;
        }
        
        .review-title {
            font-weight: 700;
            font-size: 16px;
            color: var(--ink);
            margin-bottom: 6px;
            line-height: 1.4;
            display: -webkit-box;
            -webkit-line-clamp: 1;
            -webkit-box-orient: vertical;
            overflow: hidden;
            transition: color 0.3s ease;
        }
        
        .review-list-item:hover .review-title {
            color: var(--brand);
        }
        
        .review-excerpt {
            font-size: 14px;
            color: var(--muted);
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            margin: 0;
        }
        
        /* 메타 정보 */
        .review-meta {
            display: flex;
            align-items: center;
            gap: 16px;
            flex-shrink: 0;
            font-size: 13px;
            color: var(--muted);
            min-width: 300px;
        }
        
        .review-author {
            font-weight: 600;
            color: var(--ink);
            min-width: 60px;
        }
        
        .review-stats {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .rating-stars {
            color: #ffc107;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 1px;
        }
        
        .reaction-badges {
            display: flex;
            gap: 6px;
            align-items: center;
        }
        
        .badge {
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 10px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .review-date {
            color: var(--muted);
            font-size: 12px;
            min-width: 50px;
        }
        
        /* 우수리뷰 섹션 카드 스타일 개선 */
        .excellent-review-card {
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            height: 100%;
            border: 1px solid #e9ecef;
            position: relative;
            overflow: hidden;
        }
        
        .excellent-review-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, #ff6a00, #e65a00);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }
        
        .excellent-review-card:hover::before {
            transform: scaleX(1);
        }
        
        .excellent-review-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            border-color: var(--brand);
        }
        
        /* 로딩 애니메이션 */
        .loading-skeleton {
            background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
            background-size: 200% 100%;
            animation: loading 1.5s infinite;
        }
        
        @keyframes loading {
            0% { background-position: 200% 0; }
            100% { background-position: -200% 0; }
        }
        
        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .review-list-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
                padding: 16px;
            }
            
            .chain-section {
                width: 100%;
                flex-direction: row;
                align-items: center;
                gap: 12px;
                justify-content: flex-start;
            }
            
            .chain-image {
                margin-bottom: 0;
                width: 48px;
                height: 48px;
            }
            
            .review-meta {
                flex-wrap: wrap;
                gap: 8px;
                min-width: auto;
            }
            
            .category-filter {
                justify-content: flex-start;
                overflow-x: auto;
                padding-bottom: 8px;
            }
            
            .search-form {
                flex-direction: column;
                gap: 10px;
            }
            
            .search-input {
                min-width: auto;
            }
        }
        
        /* 스크롤 애니메이션 */
        .fade-in-up {
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.6s ease-out forwards;
        }
        
        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* 페이지네이션 스타일 개선 */
        .pagination .page-link {
            color: var(--brand);
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin: 0 2px;
            padding: 8px 12px;
            transition: all 0.3s ease;
        }
        
        .pagination .page-item.active .page-link {
            background: linear-gradient(135deg, var(--brand), #e65a00);
            border-color: var(--brand);
            transform: translateY(-1px);
            box-shadow: 0 4px 8px rgba(255, 106, 0, 0.3);
        }
        
        .pagination .page-link:hover {
            color: #e65a00;
            border-color: var(--brand);
            transform: translateY(-1px);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
>>>>>>> b65c320 (Initial commit)
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
<<<<<<< HEAD
    
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
=======
    <!-- 헤더 -->
    <div class="page-header">
        <div class="container position-relative">
>>>>>>> b65c320 (Initial commit)
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-5 fw-bold mb-3">고객 리뷰</h1>
                    <p class="lead">실제 회원들의 생생한 후기를 확인해보세요</p>
                </div>
                <div class="col-md-4 text-end">
<<<<<<< HEAD
                    <!-- 디버깅 정보 표시 -->
                    <div class="debug-info">
                        <strong>세션 디버깅:</strong><br>
                        userNum: '${sessionScope.userNum}'<br>
                        userId: '${sessionScope.userId}'<br>
                        username: '${sessionScope.username}'<br>
                        empty? ${empty sessionScope.userNum}
                    </div>
                    
                    <!-- 글쓰기 버튼 조건문 -->
=======
>>>>>>> b65c320 (Initial commit)
                    <c:choose>
                        <c:when test="${not empty sessionScope.userNum}">
                            <a href="${pageContext.request.contextPath}/reviews/write" class="btn btn-light btn-lg">
                                <i class="fas fa-edit me-2"></i>리뷰 작성하기
                            </a>
<<<<<<< HEAD
                            <div class="mt-2" style="font-size: 14px;">
=======
                            <div class="mt-2" style="font-size: 14px; opacity: 0.9;">
>>>>>>> b65c320 (Initial commit)
                                환영합니다, ${sessionScope.username}님!
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-sign-in-alt me-2"></i>로그인 후 작성
                            </a>
<<<<<<< HEAD
                            <div class="mt-2" style="font-size: 14px;">
=======
                            <div class="mt-2" style="font-size: 14px; opacity: 0.9;">
>>>>>>> b65c320 (Initial commit)
                                리뷰 작성을 위해 로그인해주세요
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
<<<<<<< HEAD
        <!-- 우수 리뷰 섹션 -->
        <c:if test="${not empty excellentReviews}">
            <div class="row mb-5">
                <div class="col-12">
                    <h3 class="fw-bold mb-4">
                        <i class="fas fa-crown text-warning me-2"></i>이달의 우수 리뷰
=======
        <!-- 검색 및 필터 섹션 -->
        <div class="search-filter-section fade-in-up">
            <!-- 검색 폼 -->
            <form class="search-form" method="get">
                <input type="text" name="keyword" class="search-input" 
                       value="${keyword}" placeholder="제목, 내용, 가맹점명, 사용자명으로 검색하세요..." />
                <input type="hidden" name="sort" value="${currentSort}" />
                <input type="hidden" name="category" value="${category}" />
                <button type="submit" class="btn search-btn">
                    <i class="fas fa-search me-1"></i>검색
                </button>
                <c:if test="${not empty keyword}">
                    <a href="?sort=${currentSort}${not empty category ? '&category='.concat(category) : ''}" 
                       class="btn btn-outline-secondary">
                        <i class="fas fa-times"></i> 초기화
                    </a>
                </c:if>
            </form>
            
            <!-- 카테고리 필터 -->
            <div class="category-filter">
                <a href="?sort=${currentSort}${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="category-tab ${empty category || category == 'all' ? 'active' : ''}">
                    <i class="fas fa-list me-1"></i>전체 
                    <c:if test="${not empty categoryCount}">
                        (${categoryCount.all})
                    </c:if>
                </a>
                
                <a href="?category=excellent&sort=${currentSort}${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="category-tab ${category == 'excellent' ? 'active' : ''}">
                    <i class="fas fa-crown me-1"></i>우수리뷰 
                    <c:if test="${not empty categoryCount}">
                        (${categoryCount.excellent})
                    </c:if>
                </a>
                
                <a href="?category=recent&sort=${currentSort}${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="category-tab ${category == 'recent' ? 'active' : ''}">
                    <i class="fas fa-clock me-1"></i>최근 30일 
                    <c:if test="${not empty categoryCount}">
                        (${categoryCount.recent})
                    </c:if>
                </a>
                
                <a href="?category=popular&sort=${currentSort}${not empty keyword ? '&keyword='.concat(keyword) : ''}" 
                   class="category-tab ${category == 'popular' ? 'active' : ''}">
                    <i class="fas fa-fire me-1"></i>인기리뷰 
                    <c:if test="${not empty categoryCount}">
                        (${categoryCount.popular})
                    </c:if>
                </a>
            </div>
        </div>
        
        <!-- 결과 정보 -->
        <c:if test="${isSearch || isCategory}">
            <div class="alert alert-info fade-in-up">
                <c:choose>
                    <c:when test="${isSearch}">
                        <i class="fas fa-search me-2"></i>
                        '<strong>${keyword}</strong>' 검색 결과: 총 <strong>${reviewData.totalCount}</strong>개의 리뷰를 찾았습니다.
                    </c:when>
                    <c:when test="${isCategory}">
                        <i class="fas fa-filter me-2"></i>
                        <c:choose>
                            <c:when test="${category == 'excellent'}">우수리뷰</c:when>
                            <c:when test="${category == 'recent'}">최근 30일 리뷰</c:when>
                            <c:when test="${category == 'popular'}">인기리뷰</c:when>
                        </c:choose>
                        필터링 결과: 총 <strong>${reviewData.totalCount}</strong>개
                    </c:when>
                </c:choose>
            </div>
        </c:if>
        
        <!-- 우수 리뷰 섹션 (전체 보기일 때만) -->
        <c:if test="${not empty excellentReviews && empty category && empty keyword}">
            <div class="row mb-5 fade-in-up">
                <div class="col-12">
                    <h3 class="fw-bold mb-4">
                        <i class="fas fa-crown text-warning me-2"></i>이달의 우수 리뷰
                        <small class="text-muted fs-6">(반응수 5개 이상)</small>
>>>>>>> b65c320 (Initial commit)
                    </h3>
                    <div class="row">
                        <c:forEach var="review" items="${excellentReviews}">
                            <div class="col-md-4 mb-3">
<<<<<<< HEAD
                                <div class="card review-card border-warning">
                                    <div class="card-header bg-warning text-dark">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <strong>${review.username}</strong>
                                            <span class="badge excellent-badge text-white">우수리뷰</span>
=======
                                <div class="card excellent-review-card border-warning">
                                    <div class="card-header bg-warning text-dark">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <strong>${review.username}</strong>
                                            <span class="excellent-badge text-white">
                                                <i class="fas fa-crown me-1"></i>우수리뷰
                                            </span>
                                        </div>
                                        <div class="mt-2">
                                            <small class="badge bg-light text-dark">
                                                <i class="fas fa-thumbs-up text-success"></i> ${review.likeCount} 
                                                <i class="fas fa-thumbs-down text-danger"></i> ${review.dislikeCount} 
                                                <i class="fas fa-bolt text-warning"></i> 총 ${review.likeCount + review.dislikeCount}개 반응
                                            </small>
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
=======
                                    <div class="card-footer bg-transparent">
                                        <a href="${pageContext.request.contextPath}/reviews/detail/${review.reviewNum}" 
                                           class="btn btn-warning btn-sm w-100">
                                            <i class="fas fa-crown me-1"></i>우수리뷰 보기
                                        </a>
                                    </div>
>>>>>>> b65c320 (Initial commit)
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </c:if>
        
<<<<<<< HEAD
        <!-- 필터 및 정렬 -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h4>전체 리뷰 (${reviewData.totalCount}개)</h4>
=======
        <!-- 정렬 및 결과 표시 -->
        <div class="row mb-4 fade-in-up">
            <div class="col-md-6">
                <h4>
                    <c:choose>
                        <c:when test="${isSearch}">
                            검색 결과 (${reviewData.totalCount}개)
                        </c:when>
                        <c:when test="${isCategory}">
                            <c:choose>
                                <c:when test="${category == 'excellent'}">우수리뷰</c:when>
                                <c:when test="${category == 'recent'}">최근 리뷰</c:when>
                                <c:when test="${category == 'popular'}">인기리뷰</c:when>
                            </c:choose>
                            (${reviewData.totalCount}개)
                        </c:when>
                        <c:otherwise>
                            전체 리뷰 (${reviewData.totalCount}개)
                        </c:otherwise>
                    </c:choose>
                </h4>
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
=======
                    
                    <input type="radio" class="btn-check" name="sortOptions" id="view" value="view"
                           ${currentSort == 'view' ? 'checked' : ''}>
                    <label class="btn btn-outline-primary" for="view">조회순</label>
>>>>>>> b65c320 (Initial commit)
                </div>
            </div>
        </div>
        
<<<<<<< HEAD
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
=======
        <!-- 한 줄 리뷰 목록 -->
        <div class="review-list">
            <c:forEach var="review" items="${reviewData.reviews}" varStatus="status">
                <div class="review-list-item fade-in-up" 
                     style="animation-delay: ${status.index * 0.1}s"
                     onclick="location.href='${pageContext.request.contextPath}/reviews/detail/${review.reviewNum}'">
                    
                    <!-- 가맹점 섹션 -->
                    <div class="chain-section">
                        <div class="chain-image">
                            <img src="${pageContext.request.contextPath}/resources/images/chains/gym${review.chainNum}.jpg" 
                                 alt="${review.chainName}" 
                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                            <div class="default-icon" style="display: none;">
                                <i class="fas fa-dumbbell"></i>
                            </div>
                        </div>
                        <div class="chain-name">${review.chainName}</div>
                    </div>
                    
                    <!-- 리뷰 이미지 썸네일 -->
                    <c:if test="${review.hasImages() && not empty review.images}">
                        <div class="review-thumbnail">
                            <img src="${pageContext.request.contextPath}/displayFile?fileName=${review.images[0].imagePath}" 
                                 alt="리뷰 이미지"
                                 onerror="this.style.display='none'; this.parentElement.style.display='none';">
                            <c:if test="${review.imageCount > 1}">
                                <div class="image-count">+${review.imageCount - 1}</div>
                            </c:if>
                        </div>
                    </c:if>
                    
                    <!-- 메인 콘텐츠 -->
                    <div class="review-content">
                        <div class="review-title">${review.title}</div>
                        <div class="review-excerpt">${review.shortContent}</div>
                    </div>
                    
                    <!-- 메타 정보 -->
                    <div class="review-meta">
                        <div class="review-author">${review.username}</div>
                        
                        <div class="rating-stars">
                            <c:forEach begin="1" end="5" var="star">
                                <i class="fas fa-star ${star <= review.rating ? '' : 'text-muted'}"></i>
                            </c:forEach>
                        </div>
                        
                        <div class="review-stats">
                            <span title="조회수"><i class="fas fa-eye"></i> ${review.viewCount}</span>
                            <span title="댓글수"><i class="fas fa-comment"></i> ${review.commentCount}</span>
                            <span title="좋아요"><i class="fas fa-thumbs-up"></i> ${review.likeCount}</span>
                        </div>
                        
                        <div class="review-date">${review.formattedCreatedAt}</div>
                        
                        <div class="reaction-badges">
                            <c:set var="totalReactions" value="${review.likeCount + review.dislikeCount}" />
                            <c:choose>
                                <c:when test="${totalReactions >= 5}">
                                    <span class="badge excellent-badge text-white">
                                        <i class="fas fa-crown"></i>
                                    </span>
                                </c:when>
                                <c:when test="${totalReactions == 4}">
                                    <span class="badge candidate-badge text-white">
                                        <i class="fas fa-star"></i>
                                    </span>
                                </c:when>
                            </c:choose>
>>>>>>> b65c320 (Initial commit)
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <!-- 리뷰가 없는 경우 -->
        <c:if test="${empty reviewData.reviews}">
<<<<<<< HEAD
            <div class="text-center py-5">
                <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                <h4 class="text-muted">아직 작성된 리뷰가 없습니다</h4>
                <p class="text-muted mb-4">첫 번째 리뷰를 작성해보세요!</p>
                <c:if test="${not empty sessionScope.userNum}">
                    <a href="${pageContext.request.contextPath}/reviews/write" class="btn btn-primary btn-lg">
                        <i class="fas fa-edit me-2"></i>첫 리뷰 작성하기
                    </a>
                </c:if>
=======
            <div class="text-center py-5 fade-in-up">
                <c:choose>
                    <c:when test="${isSearch}">
                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">검색 결과가 없습니다</h4>
                        <p class="text-muted mb-4">다른 키워드로 검색해보시거나 검색어를 짧게 입력해보세요.</p>
                        <a href="${pageContext.request.contextPath}/reviews/list" class="btn btn-primary">
                            <i class="fas fa-list me-2"></i>전체 리뷰 보기
                        </a>
                    </c:when>
                    <c:when test="${isCategory}">
                        <i class="fas fa-filter fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">해당 카테고리에 리뷰가 없습니다</h4>
                        <p class="text-muted mb-4">다른 카테고리를 확인해보세요.</p>
                        <a href="${pageContext.request.contextPath}/reviews/list" class="btn btn-primary">
                            <i class="fas fa-list me-2"></i>전체 리뷰 보기
                        </a>
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-comments fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">아직 작성된 리뷰가 없습니다</h4>
                        <p class="text-muted mb-4">첫 번째 리뷰를 작성해보세요!</p>
                        <c:if test="${not empty sessionScope.userNum}">
                            <a href="${pageContext.request.contextPath}/reviews/write" class="btn btn-primary btn-lg">
                                <i class="fas fa-edit me-2"></i>첫 리뷰 작성하기
                            </a>
                        </c:if>
                    </c:otherwise>
                </c:choose>
>>>>>>> b65c320 (Initial commit)
            </div>
        </c:if>
        
        <!-- 페이징 -->
        <c:if test="${reviewData.totalPages > 1}">
<<<<<<< HEAD
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
=======
            <nav aria-label="리뷰 페이지네이션" class="fade-in-up">
                <ul class="pagination justify-content-center">
                    <c:if test="${reviewData.hasPrev}">
                        <li class="page-item">
                            <a class="page-link" href="?sort=${currentSort}&page=${reviewData.currentPage - 1}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty category ? '&category='.concat(category) : ''}">이전</a>
                        </li>
                    </c:if>
                    
                    <c:choose>
                        <c:when test="${reviewData.totalPages <= 10}">
                            <c:forEach begin="1" end="${reviewData.totalPages}" var="pageNum">
                                <li class="page-item ${pageNum == reviewData.currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?sort=${currentSort}&page=${pageNum}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty category ? '&category='.concat(category) : ''}">${pageNum}</a>
                                </li>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <c:set var="startPage" value="${reviewData.currentPage <= 5 ? 1 : reviewData.currentPage - 4}" />
                            <c:set var="endPage" value="${reviewData.currentPage <= 5 ? 10 : (reviewData.currentPage + 5 > reviewData.totalPages ? reviewData.totalPages : reviewData.currentPage + 5)}" />
                            
                            <c:if test="${startPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?sort=${currentSort}&page=1${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty category ? '&category='.concat(category) : ''}">1</a>
                                </li>
                                <c:if test="${startPage > 2}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                            </c:if>
                            
                            <c:forEach begin="${startPage}" end="${endPage}" var="pageNum">
                                <li class="page-item ${pageNum == reviewData.currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?sort=${currentSort}&page=${pageNum}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty category ? '&category='.concat(category) : ''}">${pageNum}</a>
                                </li>
                            </c:forEach>
                            
                            <c:if test="${endPage < reviewData.totalPages}">
                                <c:if test="${endPage < reviewData.totalPages - 1}">
                                    <li class="page-item disabled">
                                        <span class="page-link">...</span>
                                    </li>
                                </c:if>
                                <li class="page-item">
                                    <a class="page-link" href="?sort=${currentSort}&page=${reviewData.totalPages}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty category ? '&category='.concat(category) : ''}">${reviewData.totalPages}</a>
                                </li>
                            </c:if>
                        </c:otherwise>
                    </c:choose>
                    
                    <c:if test="${reviewData.hasNext}">
                        <li class="page-item">
                            <a class="page-link" href="?sort=${currentSort}&page=${reviewData.currentPage + 1}${not empty keyword ? '&keyword='.concat(keyword) : ''}${not empty category ? '&category='.concat(category) : ''}">다음</a>
>>>>>>> b65c320 (Initial commit)
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
        
<<<<<<< HEAD
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
=======
        <!-- 우수리뷰 기준 안내 -->
        <div class="row mt-4 fade-in-up">
            <div class="col-12">
                <div class="card border-warning">
                    <div class="card-body">
                        <h6 class="card-title text-warning">
                            <i class="fas fa-info-circle me-2"></i>우수리뷰 선정 기준
                        </h6>
                        <div class="row text-center">
                            <div class="col-md-4">
                                <div class="badge excellent-badge text-white mb-2 p-2">
                                    <i class="fas fa-crown"></i> 우수리뷰
                                </div>
                                <p class="small mb-0">추천+비추천 합계 <strong>5개 이상</strong></p>
                            </div>
                            <div class="col-md-4">
                                <div class="badge candidate-badge text-white mb-2 p-2">
                                    <i class="fas fa-star"></i> 후보
                                </div>
                                <p class="small mb-0">추천+비추천 합계 <strong>4개</strong></p>
                            </div>
                            <div class="col-md-4">
                                <div class="badge bg-secondary text-white mb-2 p-2">
                                    <i class="fas fa-file-alt"></i> 일반
                                </div>
                                <p class="small mb-0">추천+비추천 합계 <strong>3개 이하</strong></p>
                            </div>
>>>>>>> b65c320 (Initial commit)
                        </div>
                    </div>
                </div>
            </div>
<<<<<<< HEAD
        </c:if>
=======
        </div>
>>>>>>> b65c320 (Initial commit)
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
<<<<<<< HEAD
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
=======
        // 정렬 옵션 변경 시
        document.querySelectorAll('input[name="sortOptions"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const keyword = '${keyword}';
                const category = '${category}';
                let url = '?sort=' + this.value + '&page=1';
                if (keyword) url += '&keyword=' + encodeURIComponent(keyword);
                if (category) url += '&category=' + encodeURIComponent(category);
                location.href = url;
            });
        });
        
        // 페이지 로드 시 애니메이션
        document.addEventListener('DOMContentLoaded', function() {
            // 스크롤 애니메이션 관찰자
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('fade-in-up');
                    }
                });
            }, {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            });
            
            // 모든 리뷰 아이템 관찰
            document.querySelectorAll('.review-list-item').forEach(item => {
                observer.observe(item);
            });
            
            // 이미지 로드 에러 처리
            document.querySelectorAll('.review-thumbnail img, .chain-image img').forEach(img => {
                img.addEventListener('error', function() {
                    console.log('이미지 로드 실패:', this.src);
                    if (this.parentElement.classList.contains('chain-image')) {
                        this.style.display = 'none';
                        this.nextElementSibling.style.display = 'flex';
                    } else if (this.parentElement.classList.contains('review-thumbnail')) {
                        this.parentElement.style.display = 'none';
                    }
                });
            });
            
            // 리뷰 아이템 클릭 효과
            document.querySelectorAll('.review-list-item').forEach(item => {
                item.addEventListener('click', function(e) {
                    // 클릭 리플 효과
                    const ripple = document.createElement('div');
                    ripple.style.position = 'absolute';
                    ripple.style.borderRadius = '50%';
                    ripple.style.background = 'rgba(255, 106, 0, 0.3)';
                    ripple.style.transform = 'scale(0)';
                    ripple.style.animation = 'ripple 0.6s linear';
                    ripple.style.left = (e.clientX - this.offsetLeft - 10) + 'px';
                    ripple.style.top = (e.clientY - this.offsetTop - 10) + 'px';
                    ripple.style.width = ripple.style.height = '20px';
                    
                    this.style.position = 'relative';
                    this.appendChild(ripple);
                    
                    setTimeout(() => {
                        ripple.remove();
                    }, 600);
                });
            });
            
            // 검색 입력 포커스 효과
            const searchInput = document.querySelector('.search-input');
            if (searchInput) {
                searchInput.addEventListener('focus', function() {
                    this.parentElement.style.transform = 'scale(1.02)';
                });
                
                searchInput.addEventListener('blur', function() {
                    this.parentElement.style.transform = 'scale(1)';
                });
            }
        });
        
        // CSS 애니메이션 추가
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
>>>>>>> b65c320 (Initial commit)
    </script>
</body>
</html>