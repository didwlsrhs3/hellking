<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>가맹점 찾기 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
<<<<<<< HEAD
=======
        :root {
            --brand: #FF6A00;
            --bg-cream: #F4ECDC;
        }
        body { 
            background: white; 
        }
        
        .list-header {
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            color: white;
            padding: 60px 0;
        }
        
>>>>>>> b65c320 (Initial commit)
        .chain-card {
            transition: transform 0.2s, box-shadow 0.2s;
            height: 100%;
        }
        .chain-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .chain-image {
            height: 200px;
            object-fit: cover;
        }
        .rating-stars {
            color: #ffc107;
        }
        .stats-card {
<<<<<<< HEAD
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            color: white;
=======
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            border-radius: 12px;
        }
        
        /* 정렬 옵션 스타일 */
        .sort-controls {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
        
        .sort-controls .btn {
            margin-right: 8px;
            margin-bottom: 8px;
        }
        
        .sort-controls .btn.active {
            background-color: var(--brand);
            border-color: var(--brand);
            color: white;
        }
        
        /* 페이징 스타일 */
        .pagination {
            justify-content: center;
            margin-top: 30px;
        }
        
        .pagination .page-link {
            color: var(--brand);
            border-color: #dee2e6;
        }
        
        .pagination .page-item.active .page-link {
            background-color: var(--brand);
            border-color: var(--brand);
        }
        
        .pagination .page-link:hover {
            background-color: rgba(255, 106, 0, 0.1);
            border-color: var(--brand);
        }
        
        /* 결과 정보 스타일 */
        .result-info {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 8px;
            padding: 12px 16px;
            margin-bottom: 20px;
            font-size: 14px;
            color: #495057;
        }
        
        .result-info strong {
            color: var(--brand);
>>>>>>> b65c320 (Initial commit)
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
<<<<<<< HEAD
    <div class="container mt-4">
        <!-- 헤더 섹션 -->
        <div class="row mb-4">
            <div class="col-md-8">
                <h2 class="fw-bold">전국 헬킹 가맹점</h2>
                <p class="text-muted">전국 ${stats.totalChains}개 가맹점에서 자유롭게 운동하세요</p>
            </div>
            <div class="col-md-4">
                <div class="card stats-card">
                    <div class="card-body text-center">
                        <h4>${stats.totalChains}개 가맹점</h4>
=======
    <!-- 헤더 섹션 -->
    <div class="list-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">전국 헬킹 가맹점</h2>
                    <p class="lead">전국 ${stats.totalChains}개 가맹점에서 자유롭게 운동하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="stats-card text-center p-3">
                        <h4 class="mb-1">${stats.totalChains}개 가맹점</h4>
>>>>>>> b65c320 (Initial commit)
                        <p class="mb-0">${stats.totalRegions}개 지역 운영중</p>
                    </div>
                </div>
            </div>
        </div>
<<<<<<< HEAD
        
=======
    </div>
    
    <div class="container mt-4">
>>>>>>> b65c320 (Initial commit)
        <!-- 검색 바 -->
        <div class="row mb-4">
            <div class="col-12">
                <form action="${pageContext.request.contextPath}/chain/search" method="get">
                    <div class="input-group">
                        <input type="text" class="form-control form-control-lg" 
                               name="keyword" placeholder="가맹점명 또는 지역으로 검색하세요..."
                               value="${param.keyword}">
<<<<<<< HEAD
=======
                        <input type="hidden" name="sortBy" value="${sortBy}">
>>>>>>> b65c320 (Initial commit)
                        <button class="btn btn-primary" type="submit">검색</button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- 추천 가맹점 섹션 -->
        <div class="row mb-4">
            <div class="col-12">
                <h4 class="fw-bold mb-3">인기 가맹점</h4>
                <div class="row">
                    <c:forEach var="chain" items="${recommended.popular}" end="2">
                        <div class="col-md-4 mb-3">
                            <div class="card chain-card">
                                <img src="${pageContext.request.contextPath}/resources/images/chains/${chain.imagePath != null ? chain.imagePath : 'default-chain.jpg'}" 
                                     class="card-img-top chain-image" alt="${chain.chainName}">
                                <div class="card-body">
                                    <h6 class="card-title">${chain.chainName}</h6>
                                    <p class="card-text text-muted small">${chain.formattedAddress}</p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="rating-stars">
                                            <c:forEach begin="1" end="5" var="star">
                                                <i class="fas fa-star ${star <= chain.avgRating ? '' : 'text-muted'}"></i>
                                            </c:forEach>
                                            <span class="ms-1">${chain.formattedRating}</span>
                                        </div>
                                        <small class="text-muted">${chain.reviewCountText}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="col-md-4 mb-3">
                        <div class="card h-100 d-flex align-items-center justify-content-center">
                            <div class="card-body text-center">
                                <h6 class="text-muted">더 많은 인기 가맹점</h6>
                                <a href="${pageContext.request.contextPath}/chain/popular" class="btn btn-outline-primary">
                                    전체 보기
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
<<<<<<< HEAD
        <!-- 전체 가맹점 목록 -->
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="fw-bold">전체 가맹점</h4>
                    <div class="btn-group" role="group">
                        <button type="button" class="btn btn-outline-secondary active" data-view="grid">
                            <i class="fas fa-th"></i>
                        </button>
                        <button type="button" class="btn btn-outline-secondary" data-view="list">
                            <i class="fas fa-list"></i>
                        </button>
                    </div>
                </div>
                
                <div class="row" id="chainGrid">
                    <c:forEach var="chain" items="${chains}">
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="card chain-card">
                                <img src="${pageContext.request.contextPath}/resources/images/chains/${chain.imagePath != null ? chain.imagePath : 'default-chain.jpg'}" 
                                     class="card-img-top chain-image" alt="${chain.chainName}">
                                <div class="card-body">
                                    <h5 class="card-title">${chain.chainName}</h5>
                                    <p class="card-text text-muted">${chain.formattedAddress}</p>
                                    <p class="card-text small">${chain.description}</p>
                                    
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <div class="rating-stars">
                                            <c:forEach begin="1" end="5" var="star">
                                                <i class="fas fa-star ${star <= chain.avgRating ? '' : 'text-muted'}"></i>
                                            </c:forEach>
                                            <span class="ms-1">${chain.formattedRating}</span>
                                        </div>
                                        <small class="text-muted">${chain.reviewCountText}</small>
                                    </div>
                                    
                                    <div class="d-flex gap-2">
                                        <a href="${pageContext.request.contextPath}/chain/detail/${chain.chainNum}" 
                                           class="btn btn-primary flex-fill">상세보기</a>
                                        <c:if test="${not empty sessionScope.userNum}">
                                            <button class="btn btn-outline-success" 
                                                    onclick="quickEnter('${chain.chainCode}')">
                                                QR 입장
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
=======
        <!-- 정렬 및 필터 컨트롤 -->
        <div class="row">
            <div class="col-12">
                <div class="sort-controls">
                    <div class="d-flex flex-wrap justify-content-between align-items-center">
                        <div>
                            <h5 class="mb-2">정렬 기준</h5>
                            <div class="btn-group" role="group">
                                <a href="?sortBy=rating_desc&page=1" 
                                   class="btn ${sortBy == 'rating_desc' ? 'btn-primary active' : 'btn-outline-primary'}">
                                    평점 높은순
                                </a>
                                <a href="?sortBy=rating_asc&page=1" 
                                   class="btn ${sortBy == 'rating_asc' ? 'btn-primary active' : 'btn-outline-primary'}">
                                    평점 낮은순
                                </a>
                                <a href="?sortBy=review_desc&page=1" 
                                   class="btn ${sortBy == 'review_desc' ? 'btn-primary active' : 'btn-outline-primary'}">
                                    리뷰 많은순
                                </a>
                                <a href="?sortBy=name&page=1" 
                                   class="btn ${sortBy == 'name' ? 'btn-primary active' : 'btn-outline-primary'}">
                                    가맹점명순
                                </a>
                                <a href="?sortBy=latest&page=1" 
                                   class="btn ${sortBy == 'latest' ? 'btn-primary active' : 'btn-outline-primary'}">
                                    최신순
                                </a>
                            </div>
                        </div>
                        
                        <div class="d-flex align-items-center">
                            <span class="text-muted me-3">현재 정렬: <strong>${sortDescription}</strong></span>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-outline-secondary active" data-view="grid">
                                    <i class="fas fa-th"></i>
                                </button>
                                <button type="button" class="btn btn-outline-secondary" data-view="list">
                                    <i class="fas fa-list"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 결과 정보 -->
        <c:if test="${totalCount > 0}">
            <div class="row">
                <div class="col-12">
                    <div class="result-info">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                전체 <strong>${totalCount}개</strong> 가맹점 중 
                                <strong>${(currentPage-1) * 6 + 1}</strong> ~ 
                                <strong>${currentPage * 6 > totalCount ? totalCount : currentPage * 6}</strong>번째 
                                (<strong>${sortDescription}</strong>)
                            </div>
                            <div class="text-muted">
                                ${currentPage} / ${totalPages} 페이지
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        
        <!-- 전체 가맹점 목록 -->
        <div class="row">
            <div class="col-12">
                <div class="row" id="chainGrid">
                    <c:choose>
                        <c:when test="${not empty chains}">
                            <c:forEach var="chain" items="${chains}">
                                <div class="col-lg-4 col-md-6 mb-4">
                                    <div class="card chain-card">
                                        <img src="${pageContext.request.contextPath}/resources/images/chains/${chain.imagePath != null ? chain.imagePath : 'default-chain.jpg'}" 
                                             class="card-img-top chain-image" alt="${chain.chainName}">
                                        <div class="card-body">
                                            <h5 class="card-title">${chain.chainName}</h5>
                                            <p class="card-text text-muted">${chain.formattedAddress}</p>
                                            <p class="card-text small">${chain.description}</p>
                                            
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <div class="rating-stars">
                                                    <c:forEach begin="1" end="5" var="star">
                                                        <i class="fas fa-star ${star <= chain.avgRating ? '' : 'text-muted'}"></i>
                                                    </c:forEach>
                                                    <span class="ms-1">${chain.formattedRating}</span>
                                                </div>
                                                <small class="text-muted">${chain.reviewCountText}</small>
                                            </div>
                                            
                                            <div class="d-flex gap-2">
                                                <a href="${pageContext.request.contextPath}/chain/detail/${chain.chainNum}" 
                                                   class="btn btn-primary flex-fill">상세보기</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12 text-center py-5">
                                <div class="text-muted">
                                    <i class="fas fa-search fa-3x mb-3"></i>
                                    <h5>표시할 가맹점이 없습니다</h5>
                                    <p>다른 정렬 기준을 선택해보세요.</p>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- 페이지네이션 -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="가맹점 목록 페이지네이션">
                        <ul class="pagination">
                            <!-- 첫 페이지 -->
                            <c:if test="${hasPrev}">
                                <li class="page-item">
                                    <a class="page-link" href="?sortBy=${sortBy}&page=1">
                                        <i class="fas fa-angle-double-left"></i>
                                    </a>
                                </li>
                            </c:if>
                            
                            <!-- 이전 페이지 -->
                            <c:if test="${hasPrev}">
                                <li class="page-item">
                                    <a class="page-link" href="?sortBy=${sortBy}&page=${currentPage - 1}">
                                        <i class="fas fa-angle-left"></i>
                                    </a>
                                </li>
                            </c:if>
                            
                            <!-- 페이지 번호들 -->
                            <c:forEach begin="${pageNav.startPage}" end="${pageNav.endPage}" var="pageNum">
                                <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                    <a class="page-link" href="?sortBy=${sortBy}&page=${pageNum}">
                                        ${pageNum}
                                    </a>
                                </li>
                            </c:forEach>
                            
                            <!-- 다음 페이지 -->
                            <c:if test="${hasNext}">
                                <li class="page-item">
                                    <a class="page-link" href="?sortBy=${sortBy}&page=${currentPage + 1}">
                                        <i class="fas fa-angle-right"></i>
                                    </a>
                                </li>
                            </c:if>
                            
                            <!-- 마지막 페이지 -->
                            <c:if test="${hasNext}">
                                <li class="page-item">
                                    <a class="page-link" href="?sortBy=${sortBy}&page=${totalPages}">
                                        <i class="fas fa-angle-double-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
>>>>>>> b65c320 (Initial commit)
            </div>
        </div>
    </div>
    
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
<<<<<<< HEAD
        // 빠른 QR 입장 기능
        function quickEnter(chainCode) {
            if(confirm('이 가맹점에 입장하시겠습니까?')) {
                fetch('${pageContext.request.contextPath}/qr/enter', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'chainCode=' + chainCode
                })
                .then(response => response.json())
                .then(data => {
                    alert(data.message);
                    if(data.success) {
                        // 성공 시 입장 처리
                    }
                });
            }
        }
=======
>>>>>>> b65c320 (Initial commit)
        
        // 보기 방식 변경
        document.querySelectorAll('[data-view]').forEach(btn => {
            btn.addEventListener('click', function() {
                const view = this.dataset.view;
                const grid = document.getElementById('chainGrid');
                
                document.querySelectorAll('[data-view]').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                
                if(view === 'list') {
                    grid.classList.remove('row');
                    grid.classList.add('list-view');
                } else {
                    grid.classList.remove('list-view');
                    grid.classList.add('row');
                }
            });
        });
<<<<<<< HEAD
=======
        
        // 페이지 로드 시 현재 정렬 방식 표시
        document.addEventListener('DOMContentLoaded', function() {
            const currentSort = '${sortBy}';
            console.log('현재 정렬 기준:', currentSort);
        });
>>>>>>> b65c320 (Initial commit)
    </script>
</body>
</html>