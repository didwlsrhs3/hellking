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
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            color: white;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
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
                        <p class="mb-0">${stats.totalRegions}개 지역 운영중</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 검색 바 -->
        <div class="row mb-4">
            <div class="col-12">
                <form action="${pageContext.request.contextPath}/chain/search" method="get">
                    <div class="input-group">
                        <input type="text" class="form-control form-control-lg" 
                               name="keyword" placeholder="가맹점명 또는 지역으로 검색하세요..."
                               value="${param.keyword}">
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
            </div>
        </div>
    </div>
    
    <!-- Font Awesome for icons -->
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
                        // 성공 시 입장 처리
                    }
                });
            }
        }
        
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
    </script>
</body>
</html>