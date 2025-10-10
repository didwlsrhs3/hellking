<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${typeText} 체인점 프로그램 - 디자인바디</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        /* 주황색 계열 - 브랜드 특화 영역 */
        .category-hero {
            background: linear-gradient(135deg, #FF6A00, #e55a00);
            color: white;
            padding: 60px 0;
            position: relative;
        }
        
        .category-hero h1, .category-hero h2 {
            color: white;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .category-hero p {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
            margin-bottom: 0;
        }
        
        .category-hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
        }
        .chain-program-card {
            transition: all 0.3s ease;
            border-radius: 16px;
            overflow: hidden;
            height: 100%;
        }
        .chain-program-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }
        .program-image {
            height: 200px;
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
        .status-badge {
            position: absolute;
            top: 12px;
            right: 12px;
        }
        .chain-info {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 8px 12px;
            margin-bottom: 10px;
        }
        .capacity-bar {
            height: 4px;
            border-radius: 2px;
            background: #e9ecef;
            overflow: hidden;
        }
        .capacity-fill {
            height: 100%;
            background: linear-gradient(135deg, #28a745, #20c997);
            transition: width 0.3s ease;
        }
        .type-icon {
            width: 80px;
            height: 80px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            margin: 0 auto 20px;
            box-shadow: 0 8px 25px rgba(255,255,255,0.2);
        }

        @media (max-width: 768px) {
            .category-hero {
                padding: 40px 0;
            }
            .category-hero h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />
    
    <!-- 카테고리 히어로 -->
    <div class="category-hero">
        <div class="container position-relative">
            <div class="text-center">
                <div class="type-icon">
                    <c:choose>
                        <c:when test="${currentType == 'DIET'}">
                            <i class="fas fa-weight-scale text-danger"></i>
                        </c:when>
                        <c:when test="${currentType == 'MUSCLE'}">
                            <i class="fas fa-dumbbell text-primary"></i>
                        </c:when>
                        <c:when test="${currentType == 'CARDIO'}">
                            <i class="fas fa-heart-pulse text-success"></i>
                        </c:when>
                        <c:when test="${currentType == 'REHAB'}">
                            <i class="fas fa-user-doctor text-warning"></i>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-dumbbell text-primary"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
                <h1 class="display-4 fw-bold mb-3">${typeText} 체인점 프로그램</h1>
                <p class="lead">전국 헬스 체인점에서 운영하는 전문 ${typeText} 프로그램으로 목표를 달성하세요</p>
                <div class="mt-4">
                    <button class="btn btn-light btn-lg me-3" onclick="findNearbyPrograms()">
                        <i class="fas fa-location-dot me-2"></i>근처 프로그램 찾기
                    </button>
                    <a href="${pageContext.request.contextPath}/designbody/chain/programs" class="btn btn-outline-light btn-lg">
                        전체 프로그램 보기
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-5">
        <!-- 프로그램 목록 헤더 -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h3 class="fw-bold">${typeText} 프로그램 목록</h3>
                <p class="text-muted">총 ${programs.size()}개의 체인점 프로그램이 운영중입니다</p>
            </div>
            <div class="col-md-6 text-end">
                <div class="btn-group" role="group">
                    <input type="radio" class="btn-check" name="sortOptions" id="sortDistance" checked>
                    <label class="btn btn-outline-secondary" for="sortDistance">거리순</label>
                    <input type="radio" class="btn-check" name="sortOptions" id="sortPrice">
                    <label class="btn btn-outline-secondary" for="sortPrice">가격순</label>
                    <input type="radio" class="btn-check" name="sortOptions" id="sortPopular">
                    <label class="btn btn-outline-secondary" for="sortPopular">인기순</label>
                </div>
            </div>
        </div>
        
        <!-- 프로그램 그리드 -->
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
                                
                                <!-- 상태 배지 -->
                                <div class="status-badge">
                                    <span class="badge ${program.statusBadgeClass}">${program.statusText}</span>
                                </div>
                                
                                <div class="card-body">
                                    <!-- 체인점 위치 정보 -->
                                    <div class="chain-info">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small class="text-muted">
                                                <i class="fas fa-location-dot me-1"></i>${program.shortAddress}
                                            </small>
                                            <c:if test="${program.distance != null}">
                                                <small class="fw-bold text-success">
                                                    ${program.formattedDistance}
                                                </small>
                                            </c:if>
                                        </div>
                                    </div>
                                    
                                    <!-- 프로그램 기본 정보 -->
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <span class="badge bg-secondary">${program.difficultyText}</span>
                                        <div class="text-end">
                                            <strong class="text-primary">${program.formattedFinalPrice}</strong>
                                            <c:if test="${program.hasDiscount()}">
                                                <br><small class="text-danger">${program.discountRate}% 할인</small>
                                            </c:if>
                                        </div>
                                    </div>
                                    
                                    <h5 class="card-title">${program.programName}</h5>
                                    <p class="card-text text-muted small">${program.description}</p>
                                    
                                    <!-- 운영 정보 -->
                                    <div class="program-meta mb-3">
                                        <div class="d-flex justify-content-between text-muted small mb-1">
                                            <span><i class="fas fa-user me-1"></i>${program.instructor}</span>
                                            <span><i class="fas fa-door-open me-1"></i>${program.programRoom}</span>
                                        </div>
                                        <div class="d-flex justify-content-between text-muted small mb-2">
                                            <span><i class="fas fa-calendar me-1"></i>${program.operatingDaysKorean}</span>
                                            <span><i class="fas fa-users me-1"></i>${program.capacityInfo}</span>
                                        </div>
                                        
                                        <!-- 정원 현황 바 -->
                                        <div class="capacity-bar mb-1">
                                            <div class="capacity-fill" style="width: ${program.enrollmentRate}%"></div>
                                        </div>
                                        <small class="text-muted">${program.enrollmentRate}% 등록됨</small>
                                    </div>
                                    
                                    <!-- 오늘 운영 여부 -->
                                    <c:if test="${program.operatingToday}">
                                        <div class="alert alert-success alert-sm py-1 mb-3">
                                            <small><i class="fas fa-check-circle me-1"></i>오늘 운영중</small>
                                        </div>
                                    </c:if>
                                    
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
                                        
                                        <c:if test="${program.full}">
                                            <button class="btn btn-outline-secondary btn-sm" disabled>
                                                <i class="fas fa-users me-1"></i>정원 마감
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="text-center py-5">
                            <c:choose>
                                <c:when test="${currentType == 'DIET'}">
                                    <i class="fas fa-weight-scale fa-3x text-muted mb-3"></i>
                                </c:when>
                                <c:when test="${currentType == 'MUSCLE'}">
                                    <i class="fas fa-dumbbell fa-3x text-muted mb-3"></i>
                                </c:when>
                                <c:when test="${currentType == 'CARDIO'}">
                                    <i class="fas fa-heart-pulse fa-3x text-muted mb-3"></i>
                                </c:when>
                                <c:when test="${currentType == 'REHAB'}">
                                    <i class="fas fa-user-doctor fa-3x text-muted mb-3"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                                </c:otherwise>
                            </c:choose>
                            <h5 class="text-muted">${typeText} 프로그램이 준비 중입니다</h5>
                            <p class="text-muted">곧 다양한 체인점에서 ${typeText} 프로그램을 만나보실 수 있습니다</p>
                            <a href="${pageContext.request.contextPath}/designbody/chain/programs" class="btn btn-primary">
                                다른 프로그램 보기
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- 다른 카테고리 추천 -->
        <div class="mt-5 pt-5 border-top">
            <h4 class="fw-bold mb-4 text-center">다른 카테고리도 확인해보세요</h4>
            <div class="row">
                <div class="col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/designbody/chain/type/diet" 
                       class="btn btn-outline-danger w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4 ${currentType == 'DIET' ? 'disabled' : ''}">
                        <i class="fas fa-weight-scale fa-2x mb-2"></i>
                        <h6>다이어트</h6>
                        <small class="text-muted">체중감량 & 체지방 관리</small>
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/designbody/chain/type/muscle" 
                       class="btn btn-outline-primary w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4 ${currentType == 'MUSCLE' ? 'disabled' : ''}">
                        <i class="fas fa-dumbbell fa-2x mb-2"></i>
                        <h6>근력강화</h6>
                        <small class="text-muted">근육량 증가 & 체형 교정</small>
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/designbody/chain/type/cardio" 
                       class="btn btn-outline-success w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4 ${currentType == 'CARDIO' ? 'disabled' : ''}">
                        <i class="fas fa-heart-pulse fa-2x mb-2"></i>
                        <h6>유산소</h6>
                        <small class="text-muted">심폐기능 & 지구력 향상</small>
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/designbody/chain/type/rehab" 
                       class="btn btn-outline-warning w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4 ${currentType == 'REHAB' ? 'disabled' : ''}">
                        <i class="fas fa-user-doctor fa-2x mb-2"></i>
                        <h6>재활운동</h6>
                        <small class="text-muted">부상 예방 & 관리</small>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 근처 프로그램 찾기
        function findNearbyPrograms() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    const url = `${pageContext.request.contextPath}/designbody/chain/nearby?` +
                              `latitude=${position.coords.latitude}&` +
                              `longitude=${position.coords.longitude}&` +
                              `type=${currentType}&` +
                              `radius=10`;
                    window.location.href = url;
                }, function() {
                    // 위치 정보를 못 가져오면 타입 필터링만 적용
                    window.location.href = `${pageContext.request.contextPath}/designbody/chain/programs?type=${currentType}`;
                });
            } else {
                window.location.href = `${pageContext.request.contextPath}/designbody/chain/programs?type=${currentType}`;
            }
        }
        
        // 빠른 신청
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
        
        // 정렬 기능
        document.addEventListener('DOMContentLoaded', function() {
            const sortButtons = document.querySelectorAll('input[name="sortOptions"]');
            sortButtons.forEach(button => {
                button.addEventListener('change', function() {
                    const sortType = this.id.replace('sort', '').toLowerCase();
                    const url = new URL(window.location);
                    url.searchParams.set('sortBy', sortType);
                    window.location.href = url.toString();
                });
            });
        });
    </script>
</body>
</html>