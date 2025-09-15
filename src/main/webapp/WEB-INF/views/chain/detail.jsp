<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${chain.chainName} - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .hero-image {
            height: 400px;
            object-fit: cover;
            border-radius: 12px;
        }
        .info-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
        }
        .rating-display {
            font-size: 2rem;
            color: #ffc107;
        }
        .qr-enter-btn {
            background: linear-gradient(135deg, #28a745, #20c997);
            border: none;
            box-shadow: 0 4px 15px rgba(40,167,69,0.3);
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-4">
        <!-- 브레드크럼 -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">홈</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/chain/list">가맹점</a></li>
                <li class="breadcrumb-item active">${chain.chainName}</li>
            </ol>
        </nav>
        
        <!-- 가맹점 기본 정보 -->
        <div class="row mb-4">
            <div class="col-md-8">
                <img src="${pageContext.request.contextPath}/resources/images/chains/${chain.imagePath != null ? chain.imagePath : 'default-chain.jpg'}" 
                     class="img-fluid hero-image w-100" alt="${chain.chainName}">
            </div>
            <div class="col-md-4">
                <div class="info-card h-100">
                    <h2 class="fw-bold mb-3">${chain.chainName}</h2>
                    
                    <div class="mb-3">
                        <div class="rating-display mb-2">
                            <c:forEach begin="1" end="5" var="star">
                                <i class="fas fa-star ${star <= chain.avgRating ? '' : 'text-muted'}"></i>
                            </c:forEach>
                            <span class="ms-2 fs-5">${chain.formattedRating}</span>
                        </div>
                        <small class="text-muted">${chain.reviewCount}개의 리뷰</small>
                    </div>
                    
                    <div class="mb-3">
                        <h6><i class="fas fa-map-marker-alt me-2"></i>주소</h6>
                        <p class="text-muted">${chain.address}</p>
                    </div>
                    
                    <div class="mb-3">
                        <h6><i class="fas fa-phone me-2"></i>전화번호</h6>
                        <p class="text-muted">${chain.phone}</p>
                    </div>
                    
                    <div class="mb-3">
                        <h6><i class="fas fa-clock me-2"></i>가맹점 코드</h6>
                        <p class="text-muted font-monospace">${chain.chainCode}</p>
                    </div>
                    
                    <c:if test="${canEnter}">
                        <div class="d-grid gap-2">
                            <button class="btn btn-success qr-enter-btn btn-lg" onclick="enterGym()">
                                <i class="fas fa-qrcode me-2"></i>QR 입장하기
                            </button>
                        </div>
                    </c:if>
                    
                    <c:if test="${empty sessionScope.userNum}">
                        <div class="alert alert-info mt-3">
                            <small>QR 입장을 위해서는 <a href="${pageContext.request.contextPath}/user/login">로그인</a>과 패스권이 필요합니다.</small>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
        
        <!-- 상세 정보 탭 -->
        <div class="row">
            <div class="col-12">
                <ul class="nav nav-tabs" id="detailTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="info-tab" data-bs-toggle="tab" data-bs-target="#info" 
                                type="button" role="tab">가맹점 소개</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="facilities-tab" data-bs-toggle="tab" data-bs-target="#facilities" 
                                type="button" role="tab">시설 안내</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="reviews-tab" data-bs-toggle="tab" data-bs-target="#reviews" 
                                type="button" role="tab">리뷰 (${chain.reviewCount})</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="location-tab" data-bs-toggle="tab" data-bs-target="#location" 
                                type="button" role="tab">위치 안내</button>
                    </li>
                </ul>
                
                <div class="tab-content mt-3" id="detailTabsContent">
                    <!-- 가맹점 소개 -->
                    <div class="tab-pane fade show active" id="info" role="tabpanel">
                        <div class="p-4">
                            <h5>가맹점 소개</h5>
                            <p>${chain.description}</p>
                            
                            <h6 class="mt-4">운영시간</h6>
                            <p>${chain.operatingHours != null ? chain.operatingHours : '24시간 운영'}</p>
                        </div>
                    </div>
                    
                    <!-- 시설 안내 -->
                    <div class="tab-pane fade" id="facilities" role="tabpanel">
                        <div class="p-4">
                            <h5>이용 가능 시설</h5>
                            <div class="row">
                                <div class="col-md-6">
                                    <ul class="list-unstyled">
                                        <li><i class="fas fa-dumbbell me-2 text-primary"></i>웨이트 트레이닝</li>
                                        <li><i class="fas fa-heart me-2 text-danger"></i>유산소 운동</li>
                                        <li><i class="fas fa-swimmer me-2 text-info"></i>기능성 트레이닝</li>
                                        <li><i class="fas fa-users me-2 text-success"></i>그룹 레슨</li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <ul class="list-unstyled">
                                        <li><i class="fas fa-shower me-2 text-primary"></i>샤워실</li>
                                        <li><i class="fas fa-tshirt me-2 text-warning"></i>락커룸</li>
                                        <li><i class="fas fa-car me-2 text-secondary"></i>주차장</li>
                                        <li><i class="fas fa-wifi me-2 text-info"></i>무료 WiFi</li>
                                    </ul>
                                </div>
                            </div>
                            
                            <c:if test="${not empty chain.facilities}">
                                <h6 class="mt-4">추가 시설</h6>
                                <p>${chain.facilities}</p>
                            </c:if>
                            
                            <c:if test="${not empty chain.parking}">
                                <h6 class="mt-4">주차 안내</h6>
                                <p>${chain.parking}</p>
                            </c:if>
                        </div>
                    </div>
                    
                    <!-- 리뷰 -->
                    <div class="tab-pane fade" id="reviews" role="tabpanel">
                        <div class="p-4">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h5>고객 리뷰</h5>
                                <c:if test="${not empty sessionScope.userNum}">
                                    <a href="${pageContext.request.contextPath}/reviews/write?chainNum=${chain.chainNum}" 
                                       class="btn btn-primary">리뷰 작성</a>
                                </c:if>
                            </div>
                            
                            <!-- 리뷰 통계 -->
                            <div class="row mb-4">
                                <div class="col-md-4">
                                    <div class="text-center">
                                        <div class="display-4 text-primary">${chain.formattedRating}</div>
                                        <div class="rating-stars mb-2">
                                            <c:forEach begin="1" end="5" var="star">
                                                <i class="fas fa-star ${star <= chain.avgRating ? 'text-warning' : 'text-muted'}"></i>
                                            </c:forEach>
                                        </div>
                                        <small class="text-muted">${chain.reviewCount}개 리뷰</small>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <!-- 별점별 분포 (실제 데이터는 추가 구현 필요) -->
                                    <div class="d-flex align-items-center mb-1">
                                        <span class="me-2">5★</span>
                                        <div class="progress flex-fill me-2">
                                            <div class="progress-bar bg-warning" style="width: 60%"></div>
                                        </div>
                                        <small class="text-muted">60%</small>
                                    </div>
                                    <div class="d-flex align-items-center mb-1">
                                        <span class="me-2">4★</span>
                                        <div class="progress flex-fill me-2">
                                            <div class="progress-bar bg-warning" style="width: 25%"></div>
                                        </div>
                                        <small class="text-muted">25%</small>
                                    </div>
                                    <div class="d-flex align-items-center mb-1">
                                        <span class="me-2">3★</span>
                                        <div class="progress flex-fill me-2">
                                            <div class="progress-bar bg-warning" style="width: 10%"></div>
                                        </div>
                                        <small class="text-muted">10%</small>
                                    </div>
                                    <div class="d-flex align-items-center mb-1">
                                        <span class="me-2">2★</span>
                                        <div class="progress flex-fill me-2">
                                            <div class="progress-bar bg-warning" style="width: 3%"></div>
                                        </div>
                                        <small class="text-muted">3%</small>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <span class="me-2">1★</span>
                                        <div class="progress flex-fill me-2">
                                            <div class="progress-bar bg-warning" style="width: 2%"></div>
                                        </div>
                                        <small class="text-muted">2%</small>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 리뷰 목록 (AJAX로 로드) -->
                            <div id="reviewsList">
                                <div class="text-center">
                                    <div class="spinner-border" role="status">
                                        <span class="visually-hidden">리뷰 로딩중...</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 위치 안내 -->
                    <div class="tab-pane fade" id="location" role="tabpanel">
                        <div class="p-4">
                            <h5>오시는 길</h5>
                            <p class="mb-3">${chain.address}</p>
                            
                            <!-- 지도 (실제로는 카카오맵 API 등 사용) -->
                            <div class="bg-light rounded p-5 text-center mb-3" style="height: 300px;">
                                <i class="fas fa-map-marked-alt fa-3x text-muted mb-3"></i>
                                <p class="text-muted">지도 API 연동 예정</p>
                                <small class="text-muted">카카오맵 또는 구글맵 API로 실제 지도 표시</small>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <h6>대중교통</h6>
                                    <p class="text-muted">지하철, 버스 정보는 상세 페이지에서 확인하세요.</p>
                                </div>
                                <div class="col-md-6">
                                    <h6>주차 안내</h6>
                                    <p class="text-muted">${chain.parking != null ? chain.parking : '주차 가능'}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // QR 입장 처리
        function enterGym() {
            if(confirm('${chain.chainName}에 입장하시겠습니까?')) {
                fetch('${pageContext.request.contextPath}/qr/enter', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'chainCode=${chain.chainCode}'
                })
                .then(response => response.json())
                .then(data => {
                    alert(data.message);
                    if(data.success) {
                        // 성공 처리
                    }
                });
            }
        }
        
        // 리뷰 탭이 활성화될 때 리뷰 로드
        document.getElementById('reviews-tab').addEventListener('shown.bs.tab', function() {
            loadReviews();
        });
        
        function loadReviews() {
            fetch('${pageContext.request.contextPath}/reviews/chain/${chain.chainNum}')
            .then(response => response.json())
            .then(data => {
                const reviewsList = document.getElementById('reviewsList');
                if(data.reviews && data.reviews.length > 0) {
                    let html = '';
                    data.reviews.forEach(review => {
                        html += `
                            <div class="border rounded p-3 mb-3">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div>
                                        <strong>${review.username}</strong>
                                        <div class="rating-stars">
                                            ${generateStars(review.rating)}
                                            <span class="ms-1">${review.rating}</span>
                                        </div>
                                    </div>
                                    <small class="text-muted">${review.createdAt}</small>
                                </div>
                                <h6>${review.title}</h6>
                                <p class="mb-2">${review.content}</p>
                                <div class="d-flex gap-2">
                                    <button class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-thumbs-up"></i> ${review.likeCount}
                                    </button>
                                    <button class="btn btn-sm btn-outline-secondary">
                                        답글 ${review.commentCount}
                                    </button>
                                </div>
                            </div>
                        `;
                    });
                    reviewsList.innerHTML = html;
                } else {
                    reviewsList.innerHTML = '<p class="text-muted text-center">아직 리뷰가 없습니다. 첫 리뷰를 작성해보세요!</p>';
                }
            })
            .catch(() => {
                document.getElementById('reviewsList').innerHTML = '<p class="text-danger text-center">리뷰를 불러오는 중 오류가 발생했습니다.</p>';
            });
        }
        
        function generateStars(rating) {
            let stars = '';
            for(let i = 1; i <= 5; i++) {
                stars += `<i class="fas fa-star ${i <= rating ? 'text-warning' : 'text-muted'}"></i>`;
            }
            return stars;
        }
    </script>
</body>
</html>