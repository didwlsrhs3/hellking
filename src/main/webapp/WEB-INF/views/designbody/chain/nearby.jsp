<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>근처 프로그램 - 디자인바디</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        /* 보라색 계열 - 편안한 탐색과 정보 확인 */
        .nearby-program-header {
            background: linear-gradient(135deg, #6f42c1, #5a2d91);
            color: white;
            padding: 60px 0;
        }
        
        .nearby-program-header h1, .nearby-program-header h2 {
            color: white;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .nearby-program-header p {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
            margin-bottom: 0;
        }
        
        .chain-program-card {
            transition: all 0.3s ease;
            border-radius: 16px;
            overflow: hidden;
            height: 100%;
        }
        .chain-program-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .program-image {
            height: 180px;
            object-fit: cover;
        }
        .chain-badge {
            position: absolute;
            top: 12px;
            left: 12px;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .distance-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        .program-meta {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 8px 12px;
            margin-bottom: 12px;
        }
        
        @media (max-width: 768px) {
            .nearby-program-header {
                padding: 40px 0;
            }
            .nearby-program-header h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />
    
    <!-- 근처 프로그램 헤더 -->
    <div class="nearby-program-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">내 위치 근처 프로그램</h2>
                    <p class="lead">반경 ${searchRadius}km 내 ${totalCount}개 프로그램을 찾았습니다</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="input-group">
                        <input type="number" class="form-control" id="radiusInput" value="${searchRadius}" min="1" max="50">
                        <span class="input-group-text">km</span>
                        <button class="btn btn-light" onclick="updateRadius()">적용</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 검색 결과 정보 -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h4 class="fw-bold">근처 프로그램 목록</h4>
                <p class="text-muted">거리순으로 정렬되어 표시됩니다</p>
            </div>
            <div class="col-md-6 text-end">
                <div class="btn-group" role="group">
                    <button class="btn btn-outline-primary active" onclick="sortByDistance()">
                        <i class="fas fa-route me-1"></i>거리순
                    </button>
                    <button class="btn btn-outline-primary" onclick="sortByPrice()">
                        <i class="fas fa-won-sign me-1"></i>가격순
                    </button>
                    <button class="btn btn-outline-primary" onclick="sortByPopular()">
                        <i class="fas fa-star me-1"></i>인기순
                    </button>
                </div>
            </div>
        </div>
        
        <div class="row">
            <c:choose>
                <c:when test="${not empty programs}">
                    <c:forEach var="program" items="${programs}">
                        <div class="col-lg-4 col-md-6 mb-4">
                            <div class="card chain-program-card position-relative">
                                <img src="${pageContext.request.contextPath}/resources/images/designbody/programs/${program.imagePath != null ? program.imagePath : 'default-program.jpg'}" 
                                     class="card-img-top program-image" alt="${program.programName}">
                                
                                <!-- 체인점 배지 -->
                                <div class="chain-badge">
                                    <i class="fas fa-map-marker-alt me-1"></i>${program.chainName}
                                </div>
                                
                                <!-- 거리 배지 -->
                                <div class="distance-badge">
                                    <i class="fas fa-route me-1"></i>${program.formattedDistance}
                                </div>
                                
                                <div class="card-body">
                                    <!-- 프로그램 기본 정보 -->
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <span class="badge bg-secondary">${program.typeText}</span>
                                        <div class="text-end">
                                            <strong class="text-primary">${program.formattedFinalPrice}</strong>
                                            <c:if test="${program.hasDiscount()}">
                                                <br><small class="text-danger">${program.discountRate}% 할인</small>
                                            </c:if>
                                        </div>
                                    </div>
                                    
                                    <h6 class="card-title">${program.programName}</h6>
                                    <p class="card-text text-muted small">${program.description}</p>
                                    
                                    <!-- 운영 정보 -->
                                    <div class="program-meta">
                                        <div class="d-flex justify-content-between text-muted small mb-1">
                                            <span><i class="fas fa-user me-1"></i>${program.instructor}</span>
                                            <span><i class="fas fa-door-open me-1"></i>${program.programRoom}</span>
                                        </div>
                                        <div class="d-flex justify-content-between text-muted small mb-1">
                                            <span><i class="fas fa-calendar me-1"></i>${program.operatingDaysKorean}</span>
                                            <span><i class="fas fa-users me-1"></i>${program.capacityInfo}</span>
                                        </div>
                                        <div class="text-muted small">
                                            <i class="fas fa-clock me-1"></i>${program.operatingTime}
                                        </div>
                                    </div>
                                    
                                    <!-- 상태 표시 -->
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="badge ${program.statusBadgeClass}">${program.statusText}</span>
                                        <c:if test="${program.operatingToday}">
                                            <small class="text-success">
                                                <i class="fas fa-check-circle me-1"></i>오늘 운영
                                            </small>
                                        </c:if>
                                    </div>
                                    
                                    <!-- 액션 버튼 -->
                                    <div class="d-grid gap-2">
                                        <a href="${pageContext.request.contextPath}/designbody/chain/detail/${program.programNum}" 
                                           class="btn btn-primary">자세히 보기</a>
                                        
                                        <c:if test="${program.available && not empty sessionScope.userNum}">
                                            <button class="btn btn-outline-primary btn-sm" 
                                                    onclick="quickEnroll(${program.programNum}, ${program.chainNum})">
                                                <i class="fas fa-bolt me-1"></i>빠른 신청
                                            </button>
                                        </c:if>
                                        
                                        <button class="btn btn-outline-secondary btn-sm" 
                                                onclick="getDirections('${program.chainLatitude}', '${program.chainLongitude}', '${program.chainName}')">
                                            <i class="fas fa-directions me-1"></i>길찾기
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="text-center py-5">
                            <i class="fas fa-location-dot fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">근처에 프로그램이 없습니다</h5>
                            <p class="text-muted">검색 반경을 늘려보거나 다른 지역을 탐색해보세요</p>
                            <div class="d-flex gap-2 justify-content-center">
                                <button class="btn btn-primary" onclick="increaseRadius()">
                                    <i class="fas fa-search-plus me-2"></i>반경 늘리기
                                </button>
                                <a href="${pageContext.request.contextPath}/designbody/chain/programs" class="btn btn-outline-primary">
                                    전체 프로그램 보기
                                </a>
                            </div>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- 추가 검색 옵션 -->
        <c:if test="${not empty programs}">
            <div class="mt-5 pt-4 border-top">
                <div class="row">
                    <div class="col-md-6">
                        <h5 class="fw-bold mb-3">더 많은 옵션</h5>
                        <div class="d-grid gap-2">
                            <button class="btn btn-outline-success" onclick="expandSearch()">
                                <i class="fas fa-expand me-2"></i>검색 범위 확장
                            </button>
                            <a href="${pageContext.request.contextPath}/designbody/chain/programs" class="btn btn-outline-primary">
                                <i class="fas fa-list me-2"></i>전체 프로그램 탐색
                            </a>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h5 class="fw-bold mb-3">빠른 필터</h5>
                        <div class="d-flex flex-wrap gap-2">
                            <button class="btn btn-sm btn-outline-danger" onclick="filterByType('DIET')">다이어트</button>
                            <button class="btn btn-sm btn-outline-primary" onclick="filterByType('MUSCLE')">근력강화</button>
                            <button class="btn btn-sm btn-outline-success" onclick="filterByType('CARDIO')">유산소</button>
                            <button class="btn btn-sm btn-outline-warning" onclick="filterByType('REHAB')">재활운동</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function updateRadius() {
            const radius = document.getElementById('radiusInput').value;
            const url = new URL(window.location);
            url.searchParams.set('radius', radius);
            window.location.href = url.toString();
        }
        
        function increaseRadius() {
            const currentRadius = ${searchRadius};
            const newRadius = Math.min(currentRadius * 2, 50);
            const url = new URL(window.location);
            url.searchParams.set('radius', newRadius);
            window.location.href = url.toString();
        }
        
        function expandSearch() {
            const url = new URL(window.location);
            url.searchParams.set('radius', '30');
            window.location.href = url.toString();
        }
        
        function sortByDistance() {
            const url = new URL(window.location);
            url.searchParams.set('sortBy', 'distance');
            window.location.href = url.toString();
        }
        
        function sortByPrice() {
            const url = new URL(window.location);
            url.searchParams.set('sortBy', 'price');
            window.location.href = url.toString();
        }
        
        function sortByPopular() {
            const url = new URL(window.location);
            url.searchParams.set('sortBy', 'popular');
            window.location.href = url.toString();
        }
        
        function filterByType(type) {
            const url = new URL(window.location);
            url.searchParams.set('type', type);
            window.location.href = url.toString();
        }
        
        function getDirections(lat, lng, name) {
            if (lat && lng) {
                window.open(`https://map.kakao.com/link/to/${name},${lat},${lng}`);
            } else {
                alert('해당 체인점의 위치 정보가 없습니다.');
            }
        }
        
        function quickEnroll(programNum, chainNum) {
            <c:choose>
                <c:when test="${empty sessionScope.userNum}">
                    alert('로그인이 필요합니다.');
                    window.location.href = '${pageContext.request.contextPath}/user/login';
                    return;
                </c:when>
                <c:otherwise>
                    if (confirm('이 프로그램을 신청하시겠습니까?')) {
                        fetch('${pageContext.request.contextPath}/designbody/enroll', {
                            method: 'POST',
                            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                            body: `programNum=${programNum}&chainNum=${chainNum}`
                        })
                        .then(response => response.json())
                        .then(data => {
                            alert(data.message);
                            if (data.success) {
                                location.reload();
                            }
                        })
                        .catch(error => {
                            alert('신청 처리 중 오류가 발생했습니다.');
                        });
                    }
                </c:otherwise>
            </c:choose>
        }
    </script>
</body>
</html>