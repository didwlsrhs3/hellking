<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>가맹점 검색 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .search-header {
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            color: white;
            padding: 40px 0;
        }
        .chain-card {
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .chain-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
        }
        .rating-stars {
            color: #ffc107;
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
                    <h2 class="fw-bold">가맹점 검색</h2>
                    <p class="lead mb-0">원하는 가맹점을 찾아보세요</p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 검색 폼 -->
        <div class="row mb-4">
            <div class="col-12">
                <form action="${pageContext.request.contextPath}/chain/search" method="get">
                    <div class="input-group input-group-lg">
                        <input type="text" class="form-control" name="keyword" 
                               placeholder="가맹점명 또는 지역으로 검색하세요..." 
                               value="${searchVO.keyword}">
                        <button class="btn btn-primary" type="submit">
                            <i class="fas fa-search"></i> 검색
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- 검색 결과 -->
        <c:if test="${not empty searchVO.keyword}">
            <div class="row mb-4">
                <div class="col-md-6">
                    <h4>"${searchVO.keyword}" 검색 결과</h4>
                    <p class="text-muted">총 ${searchResult.totalCount}개의 가맹점을 찾았습니다</p>
                </div>
                <div class="col-md-6 text-end">
                    <div class="btn-group" role="group">
                        <input type="radio" class="btn-check" name="sortOptions" id="relevance" value="relevance" checked>
                        <label class="btn btn-outline-primary" for="relevance">관련도순</label>
                        
                        <input type="radio" class="btn-check" name="sortOptions" id="name" value="name">
                        <label class="btn btn-outline-primary" for="name">이름순</label>
                        
                        <input type="radio" class="btn-check" name="sortOptions" id="rating" value="rating">
                        <label class="btn btn-outline-primary" for="rating">평점순</label>
                    </div>
                </div>
            </div>
            
            <!-- 검색 결과 목록 -->
            <div class="row">
                <c:choose>
                    <c:when test="${not empty searchResult.chains}">
                        <c:forEach var="chain" items="${searchResult.chains}">
                            <div class="col-lg-6 mb-4">
                                <div class="card chain-card h-100">
                                    <div class="row g-0 h-100">
                                        <div class="col-md-4">
                                            <img src="${pageContext.request.contextPath}/resources/images/chains/${chain.imagePath != null ? chain.imagePath : 'default-chain.jpg'}" 
                                                 class="img-fluid rounded-start h-100" style="object-fit: cover;" alt="${chain.chainName}">
                                        </div>
                                        <div class="col-md-8">
                                            <div class="card-body d-flex flex-column h-100">
                                                <h5 class="card-title">${chain.chainName}</h5>
                                                <p class="card-text text-muted">${chain.address}</p>
                                                <p class="card-text"><small class="text-muted">${chain.phone}</small></p>
                                                
                                                <div class="d-flex justify-content-between align-items-center mb-2">
                                                    <div class="rating-stars">
                                                        <c:forEach begin="1" end="5" var="star">
                                                            <i class="fas fa-star ${star <= chain.avgRating ? '' : 'text-muted'}"></i>
                                                        </c:forEach>
                                                        <span class="ms-1">${chain.formattedRating}</span>
                                                    </div>
                                                    <small class="text-muted">${chain.reviewCountText}</small>
                                                </div>
                                                
                                                <div class="mt-auto">
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
                        <c:if test="${searchResult.hasPrev}">
                            <li class="page-item">
                                <a class="page-link" href="?keyword=${searchVO.keyword}&page=${searchResult.currentPage - 1}">이전</a>
                            </li>
                        </c:if>
                        
                        <c:forEach begin="${searchResult.currentPage - 2 < 1 ? 1 : searchResult.currentPage - 2}" 
                                   end="${searchResult.currentPage + 2 > searchResult.totalPages ? searchResult.totalPages : searchResult.currentPage + 2}" 
                                   var="pageNum">
                            <li class="page-item ${pageNum == searchResult.currentPage ? 'active' : ''}">
                                <a class="page-link" href="?keyword=${searchVO.keyword}&page=${pageNum}">${pageNum}</a>
                            </li>
                        </c:forEach>
                        
                        <c:if test="${searchResult.hasNext}">
                            <li class="page-item">
                                <a class="page-link" href="?keyword=${searchVO.keyword}&page=${searchResult.currentPage + 1}">다음</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </c:if>
        
        <!-- 검색어가 없는 경우 -->
        <c:if test="${empty searchVO.keyword}">
            <div class="text-center py-5">
                <i class="fas fa-map-marked-alt fa-3x text-muted mb-3"></i>
                <h5 class="text-muted">검색어를 입력해주세요</h5>
                <p class="text-muted">가맹점명이나 지역명으로 검색할 수 있습니다</p>
            </div>
        </c:if>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
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
                        // 성공 시 처리
                    }
                });
            }
        }
        
        // 정렬 변경
        document.querySelectorAll('input[name="sortOptions"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const url = new URL(window.location);
                url.searchParams.set('sortBy', this.value);
                window.location.href = url.toString();
            });
        });
    </script>
</body>
</html>