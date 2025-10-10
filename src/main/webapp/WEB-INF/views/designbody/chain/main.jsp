<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>체인점 프로그램 - 디자인바디</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        /* 보라색 계열 - 편안한 탐색과 정보 확인 */
        .main-program-header {
            background: linear-gradient(135deg, #6f42c1, #5a2d91);
            color: white;
            padding: 60px 0;
        }
        
        .main-program-header h1, .main-program-header h2 {
            color: white;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .main-program-header p {
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
            background: rgba(255, 106, 0, 0.9);
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
        }
        .status-badge {
            position: absolute;
            top: 12px;
            right: 12px;
        }
        .filter-card {
            background: #f8f9fa;
            border-radius: 16px;
            position: sticky;
            top: 20px;
        }
        .filter-btn {
            border-radius: 20px;
            margin: 2px;
            transition: all 0.2s;
        }
        .filter-btn:hover {
            transform: translateY(-2px);
        }
        .chain-info {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border-radius: 8px;
            padding: 8px 12px;
            margin-bottom: 10px;
        }
        .capacity-info {
            background: #e9ecef;
            border-radius: 20px;
            padding: 2px 8px;
            font-size: 11px;
        }
        .map-view {
            height: 400px;
            border-radius: 12px;
        }

        @media (max-width: 768px) {
            .main-program-header {
                padding: 40px 0;
            }
            .main-program-header h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />
    
    <!-- 메인 프로그램 헤더 -->
    <div class="main-program-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">전국 체인점 프로그램</h2>
                    <p class="lead">가까운 체인점에서 원하는 프로그램을 찾아보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="btn-group" role="group">
                        <input type="radio" class="btn-check" name="viewOptions" id="gridView" checked>
                        <label class="btn btn-outline-light" for="gridView" style="background: rgba(255,255,255,0.1);">
                            <i class="fas fa-th"></i> 그리드
                        </label>
                        <input type="radio" class="btn-check" name="viewOptions" id="mapView">
                        <label class="btn btn-outline-light" for="mapView" style="background: rgba(255,255,255,0.1);">
                            <i class="fas fa-map"></i> 지도
                        </label>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">        
        <div class="row">
            <!-- 필터 사이드바 -->
            <div class="col-lg-3 mb-4">
                <div class="filter-card p-4">
                    <h5 class="mb-4">필터</h5>
                    
                    <!-- 내 위치 기반 검색 -->
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3">내 위치 근처</h6>
                        <div class="d-grid gap-2">
                            <button class="btn btn-outline-primary btn-sm" onclick="findNearbyPrograms()">
                                <i class="fas fa-location-dot me-2"></i>근처 프로그램 찾기
                            </button>
                            <div class="input-group">
                                <input type="number" class="form-control form-control-sm" id="searchRadius" 
                                       placeholder="반경" value="10" min="1" max="50">
                                <span class="input-group-text">km</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 체인점 선택 -->
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3">체인점 선택</h6>
                        <select class="form-select form-select-sm" onchange="filterByChain(this.value)">
                            <option value="">전체 체인점</option>
                            <c:forEach var="chain" items="${chains}">
                                <option value="${chain.chainNum}">${chain.chainName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- 프로그램 타입 -->
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3">프로그램 타입</h6>
                        <div class="d-flex flex-wrap">
                            <button class="btn btn-outline-primary filter-btn ${empty currentType ? 'active' : ''}" 
                                    onclick="filterByType('')">전체</button>
                            <button class="btn btn-outline-danger filter-btn ${currentType == 'DIET' ? 'active' : ''}" 
                                    onclick="filterByType('DIET')">다이어트</button>
                            <button class="btn btn-outline-primary filter-btn ${currentType == 'MUSCLE' ? 'active' : ''}" 
                                    onclick="filterByType('MUSCLE')">근력강화</button>
                            <button class="btn btn-outline-success filter-btn ${currentType == 'CARDIO' ? 'active' : ''}" 
                                    onclick="filterByType('CARDIO')">유산소</button>
                            <button class="btn btn-outline-warning filter-btn ${currentType == 'REHAB' ? 'active' : ''}" 
                                    onclick="filterByType('REHAB')">재활운동</button>
                        </div>
                    </div>
                    
                    <!-- 등록 상태 -->
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3">등록 상태</h6>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="availableOnly" checked>
                            <label class="form-check-label" for="availableOnly">등록 가능한 프로그램만</label>
                        </div>
                    </div>
                    
                    <!-- 필터 초기화 -->
                    <div class="d-grid">
                        <button class="btn btn-outline-secondary" onclick="resetFilters()">
                            <i class="fas fa-refresh me-2"></i>필터 초기화
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- 프로그램 목록/지도 영역 -->
            <div class="col-lg-9">
                <!-- 정렬 및 검색 -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="프로그램명, 체인점명, 트레이너명 검색" 
                                   id="searchKeyword" value="${currentKeyword}">
                            <button class="btn btn-primary" onclick="searchPrograms()">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="d-flex justify-content-between align-items-center">
                            <span class="text-muted">총 ${totalCount}개 프로그램</span>
                            <div class="dropdown">
                                <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                    정렬: ${currentSortBy == 'distance' ? '거리순' : 
                                           currentSortBy == 'popular' ? '인기순' : 
                                           currentSortBy == 'price_low' ? '가격낮은순' : '최신순'}
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#" onclick="sortPrograms('distance')">거리순</a></li>
                                    <li><a class="dropdown-item" href="#" onclick="sortPrograms('popular')">인기순</a></li>
                                    <li><a class="dropdown-item" href="#" onclick="sortPrograms('price_low')">가격 낮은순</a></li>
                                    <li><a class="dropdown-item" href="#" onclick="sortPrograms('price_high')">가격 높은순</a></li>
                                    <li><a class="dropdown-item" href="#" onclick="sortPrograms('latest')">최신순</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 프로그램 그리드 뷰 -->
                <div id="programGrid" class="row">
                    <c:forEach var="program" items="${programs}">
                        <div class="col-lg-4 col-md-6 mb-4 program-item" 
                             data-type="${program.programType}" 
                             data-chain="${program.chainNum}"
                             data-status="${program.enrollmentStatus}">
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
                                    <!-- 체인점 정보 -->
                                    <div class="chain-info">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <small><i class="fas fa-location-dot me-1"></i>${program.shortAddress}</small>
                                            <c:if test="${program.distance != null}">
                                                <small><i class="fas fa-route me-1"></i>${program.formattedDistance}</small>
                                            </c:if>
                                        </div>
                                    </div>
                                    
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
                                    
                                    <h5 class="card-title">${program.programName}</h5>
                                    <p class="card-text text-muted">${program.description}</p>
                                    
                                    <!-- 운영 정보 -->
                                    <div class="program-meta mb-3">
                                        <div class="d-flex justify-content-between text-muted small mb-1">
                                            <span><i class="fas fa-clock me-1"></i>${program.operatingDaysKorean}</span>
                                            <span><i class="fas fa-door-open me-1"></i>${program.programRoom}</span>
                                        </div>
                                        <div class="d-flex justify-content-between text-muted small mb-1">
                                            <span><i class="fas fa-user me-1"></i>${program.instructor}</span>
                                            <span class="capacity-info">${program.capacityInfo}</span>
                                        </div>
                                        <div class="text-muted small">
                                            <i class="fas fa-calendar me-1"></i>${program.operatingTime}
                                        </div>
                                    </div>
                                    
                                    <!-- 오늘 운영 여부 -->
                                    <c:if test="${program.operatingToday}">
                                        <div class="alert alert-success alert-sm py-1 mb-2">
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
                                                빠른 신청
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- 지도 뷰 (처음에는 숨김) -->
                <div id="mapView" class="d-none">
                    <div id="map" class="map-view"></div>
                    <div class="mt-3">
                        <div class="card">
                            <div class="card-body">
                                <h6>지도 사용법</h6>
                                <ul class="small text-muted">
                                    <li>마커를 클릭하면 해당 체인점의 프로그램 정보를 볼 수 있습니다</li>
                                    <li>지도를 움직이거나 확대/축소하여 원하는 지역을 탐색하세요</li>
                                    <li>현재 위치 버튼을 눌러 내 주변 프로그램을 찾아보세요</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 프로그램이 없는 경우 -->
                <c:if test="${empty programs}">
                    <div class="text-center py-5">
                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">조건에 맞는 프로그램이 없습니다</h5>
                        <p class="text-muted">다른 조건으로 검색해보세요</p>
                        <button class="btn btn-primary" onclick="resetFilters()">필터 초기화</button>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <!-- 빠른 신청 모달 -->
    <div class="modal fade" id="quickEnrollModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">프로그램 신청</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div id="enrollProgramInfo"></div>
                    <div class="alert alert-info">
                        <small>신청 후에는 해당 체인점으로 직접 방문하여 프로그램을 시작하실 수 있습니다.</small>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" id="confirmEnrollBtn">신청하기</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_KAKAO_MAP_KEY&libraries=services"></script>
    
    <script>
        let currentProgramNum = null;
        let currentChainNum = null;
        let map = null;
        let markers = [];
        
        // 뷰 전환
        document.getElementById('mapView').addEventListener('change', function() {
            document.getElementById('programGrid').classList.add('d-none');
            document.getElementById('mapView').classList.remove('d-none');
            initMap();
        });
        
        document.getElementById('gridView').addEventListener('change', function() {
            document.getElementById('programGrid').classList.remove('d-none');
            document.getElementById('mapView').classList.add('d-none');
        });
        
        // 지도 초기화
        function initMap() {
            if (typeof kakao === 'undefined') {
                console.error('카카오 지도 API가 로드되지 않았습니다.');
                return;
            }
            
            var container = document.getElementById('map');
            var options = {
                center: new kakao.maps.LatLng(37.5665, 126.9780), // 서울 시청
                level: 8
            };
            
            map = new kakao.maps.Map(container, options);
            
            // 프로그램 마커 추가
            <c:forEach var="program" items="${programs}">
                <c:if test="${program.chainLatitude != null && program.chainLongitude != null}">
                    addProgramMarker(${program.chainLatitude}, ${program.chainLongitude}, 
                                   '${program.chainName}', '${program.programName}', ${program.programNum});
                </c:if>
            </c:forEach>
        }
        
        // 프로그램 마커 추가
        function addProgramMarker(lat, lng, chainName, programName, programNum) {
            var markerPosition = new kakao.maps.LatLng(lat, lng);
            var marker = new kakao.maps.Marker({
                position: markerPosition
            });
            
            marker.setMap(map);
            markers.push(marker);
            
            var infowindow = new kakao.maps.InfoWindow({
                content: '<div style="padding:5px;font-size:12px;">' +
                        '<strong>' + chainName + '</strong><br>' +
                        programName + '<br>' +
                        '<a href="/designbody/chain/detail/' + programNum + '" class="btn btn-primary btn-sm mt-1">상세보기</a>' +
                        '</div>'
            });
            
            kakao.maps.event.addListener(marker, 'click', function() {
                infowindow.open(map, marker);
            });
        }
        
        // 필터 및 검색 함수들
        function filterByType(type) {
            const url = new URL(window.location);
            if (type) {
                url.searchParams.set('type', type);
            } else {
                url.searchParams.delete('type');
            }
            window.location.href = url.toString();
        }
        
        function filterByChain(chainNum) {
            const url = new URL(window.location);
            if (chainNum) {
                url.searchParams.set('chainNum', chainNum);
            } else {
                url.searchParams.delete('chainNum');
            }
            window.location.href = url.toString();
        }
        
        function searchPrograms() {
            const keyword = document.getElementById('searchKeyword').value;
            const url = new URL(window.location);
            if (keyword) {
                url.searchParams.set('keyword', keyword);
            } else {
                url.searchParams.delete('keyword');
            }
            window.location.href = url.toString();
        }
        
        function sortPrograms(sortBy) {
            const url = new URL(window.location);
            url.searchParams.set('sortBy', sortBy);
            window.location.href = url.toString();
        }
        
        function resetFilters() {
            window.location.href = '${pageContext.request.contextPath}/designbody/chain/programs';
        }
        
        // 근처 프로그램 찾기
        function findNearbyPrograms() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    const radius = document.getElementById('searchRadius').value || 10;
                    const url = `${pageContext.request.contextPath}/designbody/chain/nearby?` +
                              `latitude=${position.coords.latitude}&` +
                              `longitude=${position.coords.longitude}&` +
                              `radius=${radius}`;
                    window.location.href = url;
                }, function() {
                    alert('위치 정보를 가져올 수 없습니다.');
                });
            } else {
                alert('이 브라우저는 위치 서비스를 지원하지 않습니다.');
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
                    currentProgramNum = programNum;
                    currentChainNum = chainNum;
                    
                    // 프로그램 정보 로드
                    fetch(`${pageContext.request.contextPath}/designbody/chain/api/program/${programNum}`)
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            const program = data.program;
                            document.getElementById('enrollProgramInfo').innerHTML = `
                                <h6>${program.programName}</h6>
                                <p class="text-muted">${program.chainName} - ${program.programRoom}</p>
                                <div class="row">
                                    <div class="col-6">
                                        <small>가격: <strong>${program.formattedFinalPrice}</strong></small>
                                    </div>
                                    <div class="col-6">
                                        <small>기간: <strong>${program.duration}일</strong></small>
                                    </div>
                                </div>
                                <div class="mt-2">
                                    <small>운영시간: ${program.operatingTime}</small>
                                </div>
                            `;
                            
                            new bootstrap.Modal(document.getElementById('quickEnrollModal')).show();
                        } else {
                            alert('프로그램 정보를 불러올 수 없습니다.');
                        }
                    });
                </c:otherwise>
            </c:choose>
        }
        
        // 신청 확인
        document.getElementById('confirmEnrollBtn').addEventListener('click', function() {
            if (!currentProgramNum || !currentChainNum) return;
            
            fetch('${pageContext.request.contextPath}/designbody/enroll', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: `programNum=${currentProgramNum}&chainNum=${currentChainNum}`
            })
            .then(response => response.json())
            .then(data => {
                alert(data.message);
                if (data.success) {
                    bootstrap.Modal.getInstance(document.getElementById('quickEnrollModal')).hide();
                    location.reload();
                }
            })
            .catch(error => {
                alert('신청 처리 중 오류가 발생했습니다.');
            });
        });
    </script>
</body>
</html>