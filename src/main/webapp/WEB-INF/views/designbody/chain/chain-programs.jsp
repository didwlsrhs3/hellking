<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${chain.chainName} 프로그램 - 디자인바디</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        /* 보라색 계열 - 편안한 탐색과 정보 확인 */
        .page-header {
            background: linear-gradient(135deg, #6f42c1, #5a2d91);
            color: white;
            padding: 60px 0;
        }
        
        .page-header h1, .page-header h2 {
            color: white;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .page-header p {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
            margin-bottom: 0;
        }
        
        .breadcrumb-item a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
        }
        
        .breadcrumb-item a:hover {
            color: white;
        }
        
        .breadcrumb-item.active {
            color: white;
        }
        
        .breadcrumb-item + .breadcrumb-item::before {
            color: rgba(255,255,255,0.6);
        }
        
        .stats-card {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
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
            height: 200px;
            object-fit: cover;
        }
        .program-meta {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 8px 12px;
            margin-bottom: 12px;
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 40px 0;
            }
            .page-header h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />
    
    <!-- 통일된 페이지 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">홈</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/designbody/">디자인바디</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/designbody/chain/programs">체인점 프로그램</a></li>
                    <li class="breadcrumb-item active">${chain.chainName}</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-6 fw-bold mb-3">${chain.chainName} 프로그램</h1>
                    <p class="lead mb-2"><i class="fas fa-map-marker-alt me-2"></i>${chain.address}</p>
                    <p class="mb-0"><i class="fas fa-phone me-2"></i>${chain.phone}</p>
                </div>
                <div class="col-md-4">
                    <div class="row text-center">
                        <div class="col-4">
                            <div class="stats-card">
                                <div class="h4 mb-1">${chainStats.totalPrograms}</div>
                                <small>프로그램</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="stats-card">
                                <div class="h4 mb-1">${chainStats.totalEnrollment}</div>
                                <small>참여자</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="stats-card">
                                <div class="h4 mb-1">${chainStats.averagePrice}원</div>
                                <small>평균가격</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 체인점 소개 -->
        <c:if test="${not empty chain.description}">
            <div class="row mb-4">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="fw-bold mb-3">체인점 소개</h5>
                            <p class="mb-0">${chain.description}</p>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        
        <!-- 프로그램 필터링 -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h4 class="fw-bold">운영 프로그램 <span class="text-muted">(${programs.size()}개)</span></h4>
            </div>
            <div class="col-md-6 text-end">
                <div class="btn-group" role="group">
                    <button class="btn btn-outline-secondary active" onclick="showAllPrograms()">전체</button>
                    <button class="btn btn-outline-danger" onclick="filterPrograms('DIET')">다이어트</button>
                    <button class="btn btn-outline-primary" onclick="filterPrograms('MUSCLE')">근력강화</button>
                    <button class="btn btn-outline-success" onclick="filterPrograms('CARDIO')">유산소</button>
                    <button class="btn btn-outline-warning" onclick="filterPrograms('REHAB')">재활운동</button>
                </div>
            </div>
        </div>
        
        <!-- 프로그램 목록 -->
        <div class="row" id="programList">
            <c:choose>
                <c:when test="${not empty programs}">
                    <c:forEach var="program" items="${programs}">
                        <div class="col-lg-4 col-md-6 mb-4 program-item" data-type="${program.programType}">
                            <div class="card chain-program-card">
                                <img src="${pageContext.request.contextPath}/resources/images/designbody/programs/${program.imagePath != null ? program.imagePath : 'default-program.jpg'}" 
                                     class="card-img-top program-image" alt="${program.programName}">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <span class="badge bg-secondary">${program.typeText}</span>
                                        <div class="text-end">
                                            <strong class="text-primary">${program.formattedFinalPrice}</strong>
                                            <c:if test="${program.hasDiscount()}">
                                                <br><small class="text-danger">${program.discountRate}% 할인</small>
                                            </c:if>
                                        </div>
                                    </div>
                                    
                                    <h5 class="card-title">${program.programName}</h5>
                                    <p class="card-text">${program.description}</p>
                                    
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
                                    
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="badge ${program.statusBadgeClass}">${program.statusText}</span>
                                        <c:if test="${program.operatingToday}">
                                            <small class="text-success">
                                                <i class="fas fa-check-circle me-1"></i>오늘 운영
                                            </small>
                                        </c:if>
                                    </div>
                                    
                                    <div class="d-grid">
                                        <a href="${pageContext.request.contextPath}/designbody/chain/detail/${program.programNum}" 
                                           class="btn btn-primary">자세히 보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="text-center py-5">
                            <i class="fas fa-dumbbell fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">운영중인 프로그램이 없습니다</h5>
                            <p class="text-muted">곧 새로운 프로그램이 추가될 예정입니다</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- 체인점 추가 정보 -->
        <div class="mt-5 pt-4 border-top">
            <div class="row">
                <div class="col-md-6">
                    <h5 class="fw-bold mb-3">체인점 정보</h5>
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex align-items-start mb-3">
                                <i class="fas fa-map-marker-alt text-primary me-2 mt-1"></i>
                                <div>
                                    <strong>주소</strong><br>
                                    <span class="text-muted">${chain.address}</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-start mb-3">
                                <i class="fas fa-phone text-success me-2 mt-1"></i>
                                <div>
                                    <strong>전화번호</strong><br>
                                    <span class="text-muted">${chain.phone}</span>
                                </div>
                            </div>
                            <c:if test="${not empty chain.operatingHours}">
                                <div class="d-flex align-items-start">
                                    <i class="fas fa-clock text-warning me-2 mt-1"></i>
                                    <div>
                                        <strong>운영시간</strong><br>
                                        <span class="text-muted">${chain.operatingHours}</span>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <h5 class="fw-bold mb-3">빠른 액션</h5>
                    <div class="d-grid gap-2">
                        <button class="btn btn-outline-primary" onclick="showLocation()">
                            <i class="fas fa-map me-2"></i>체인점 위치 보기
                        </button>
                        <button class="btn btn-outline-success" onclick="callChain()">
                            <i class="fas fa-phone me-2"></i>전화 문의
                        </button>
                        <a href="${pageContext.request.contextPath}/designbody/chain/programs" class="btn btn-outline-secondary">
                            <i class="fas fa-list me-2"></i>다른 체인점 보기
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 프로그램 필터링
        function showAllPrograms() {
            const items = document.querySelectorAll('.program-item');
            items.forEach(item => item.style.display = 'block');
            updateActiveFilter(event.target);
        }
        
        function filterPrograms(type) {
            const items = document.querySelectorAll('.program-item');
            items.forEach(item => {
                if (item.dataset.type === type) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
            updateActiveFilter(event.target);
        }
        
        function updateActiveFilter(activeButton) {
            // 모든 버튼에서 active 클래스 제거
            document.querySelectorAll('.btn-group .btn').forEach(btn => {
                btn.classList.remove('active');
            });
            // 클릭된 버튼에 active 클래스 추가
            activeButton.classList.add('active');
        }
        
        // 체인점 위치 보기
        function showLocation() {
            <c:if test="${chain.latitude != null && chain.longitude != null}">
                window.open(`https://map.kakao.com/link/map/${chain.chainName},${chain.latitude},${chain.longitude}`);
            </c:if>
            <c:if test="${chain.latitude == null || chain.longitude == null}">
                alert('체인점 위치 정보가 등록되지 않았습니다.\n주소: ${chain.address}');
            </c:if>
        }
        
        // 전화 문의
        function callChain() {
            if (confirm('${chain.chainName}에 전화를 걸겠습니까?\n\n전화번호: ${chain.phone}')) {
                window.location.href = 'tel:${chain.phone}';
            }
        }
        
        // 페이지 로드 시 첫 번째 필터 버튼을 활성화
        document.addEventListener('DOMContentLoaded', function() {
            const firstFilterBtn = document.querySelector('.btn-group .btn');
            if (firstFilterBtn) {
                firstFilterBtn.classList.add('active');
            }
        });
    </script>
</body>
</html>