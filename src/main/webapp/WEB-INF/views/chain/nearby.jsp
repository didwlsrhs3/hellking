<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 주변 가맹점 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .location-header {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 60px 0;
        }
        .chain-card {
            transition: transform 0.2s;
            border-radius: 12px;
        }
        .chain-card:hover {
            transform: translateY(-2px);
        }
        .distance-badge {
            background: rgba(255,255,255,0.9);
            color: #333;
            border-radius: 20px;
            padding: 4px 12px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        #map {
            height: 400px;
            border-radius: 12px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 위치 헤더 -->
    <div class="location-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">내 주변 가맹점</h2>
                    <p class="lead">현재 위치 기반으로 가까운 가맹점을 찾아보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <button class="btn btn-light btn-lg" onclick="getCurrentLocation()">
                        <i class="fas fa-location-arrow me-2"></i>내 위치 찾기
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 위치 정보 및 필터 -->
        <div class="row mb-4">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-map-marker-alt text-primary fa-2x me-3"></i>
                            <div>
                                <h6 class="mb-1">현재 위치</h6>
                                <p class="text-muted mb-0" id="currentAddress">위치 정보를 가져오는 중...</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h6 class="mb-3">검색 반경</h6>
                        <select class="form-select" id="radiusSelect" onchange="searchNearby()">
                            <option value="1">1km 이내</option>
                            <option value="3" selected>3km 이내</option>
                            <option value="5">5km 이내</option>
                            <option value="10">10km 이내</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 지도 -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div id="map" class="bg-light d-flex align-items-center justify-content-center">
                            <div class="text-center">
                                <i class="fas fa-map fa-3x text-muted mb-3"></i>
                                <p class="text-muted">지도를 불러오는 중...</p>
                                <small class="text-muted">카카오맵 API 연동 예정</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 주변 가맹점 목록 -->
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h4 class="fw-bold">주변 가맹점 <span class="badge bg-primary" id="chainCount">0</span></h4>
                    <div class="btn-group" role="group">
                        <input type="radio" class="btn-check" name="sortBy" id="distance" value="distance" checked>
                        <label class="btn btn-outline-primary" for="distance">거리순</label>
                        
                        <input type="radio" class="btn-check" name="sortBy" id="rating" value="rating">
                        <label class="btn btn-outline-primary" for="rating">평점순</label>
                    </div>
                </div>
                
                <div id="nearbyChains" class="row">
                    <!-- 가맹점 로딩 상태 -->
                    <div class="col-12 text-center py-5">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">로딩중...</span>
                        </div>
                        <p class="mt-3 text-muted">주변 가맹점을 검색하고 있습니다...</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let currentPosition = null;
        
        // 페이지 로드 시 자동으로 위치 가져오기
        window.addEventListener('load', function() {
            getCurrentLocation();
        });
        
        // 현재 위치 가져오기
        function getCurrentLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    function(position) {
                        currentPosition = {
                            latitude: position.coords.latitude,
                            longitude: position.coords.longitude
                        };
                        
                        updateAddressDisplay(currentPosition.latitude, currentPosition.longitude);
                        searchNearby();
                    },
                    function(error) {
                        console.error('위치 정보를 가져올 수 없습니다:', error);
                        document.getElementById('currentAddress').textContent = '위치 정보를 가져올 수 없습니다';
                        
                        // 기본 위치로 서울 설정
                        currentPosition = { latitude: 37.5665, longitude: 126.9780 };
                        searchNearby();
                    }
                );
            } else {
                alert('이 브라우저는 위치 서비스를 지원하지 않습니다.');
                // 기본 위치로 서울 설정
                currentPosition = { latitude: 37.5665, longitude: 126.9780 };
                searchNearby();
            }
        }
        
        // 주소 표시 업데이트 (실제로는 역지오코딩 API 사용)
        function updateAddressDisplay(lat, lng) {
            // 임시 주소 표시
            document.getElementById('currentAddress').textContent = 
                `위도: ${lat.toFixed(4)}, 경도: ${lng.toFixed(4)}`;
        }
        
        // 주변 가맹점 검색
        function searchNearby() {
            if (!currentPosition) {
                alert('위치 정보가 필요합니다.');
                return;
            }
            
            const radius = document.getElementById('radiusSelect').value;
            
            fetch('${pageContext.request.contextPath}/chain/nearbySearch', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: `latitude=${currentPosition.latitude}&longitude=${currentPosition.longitude}&radius=${radius}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    displayNearbyChains(data.chains);
                } else {
                    document.getElementById('nearbyChains').innerHTML = 
                        '<div class="col-12 text-center py-5"><p class="text-muted">주변 가맹점을 찾을 수 없습니다.</p></div>';
                }
            })
            .catch(error => {
                console.error('검색 중 오류:', error);
                document.getElementById('nearbyChains').innerHTML = 
                    '<div class="col-12 text-center py-5"><p class="text-danger">검색 중 오류가 발생했습니다.</p></div>';
            });
        }
        
        // 가맹점 목록 표시
        function displayNearbyChains(chains) {
            const container = document.getElementById('nearbyChains');
            document.getElementById('chainCount').textContent = chains.length;
            
            if (chains.length === 0) {
                container.innerHTML = '<div class="col-12 text-center py-5"><p class="text-muted">주변에 가맹점이 없습니다.</p></div>';
                return;
            }
            
            let html = '';
            chains.forEach((chain, index) => {
                // 임시 거리 계산 (실제로는 서버에서 계산)
                const distance = (Math.random() * 3 + 0.1).toFixed(1);
                
                html += `
                    <div class="col-lg-6 mb-4">
                        <div class="card chain-card h-100">
                            <div class="row g-0 h-100">
                                <div class="col-md-4 position-relative">
                                    <img src="${pageContext.request.contextPath}/resources/images/chains/default-chain.jpg" 
                                         class="img-fluid rounded-start h-100" style="object-fit: cover;" alt="${chain.chainName}">
                                    <div class="position-absolute top-0 end-0 m-2">
                                        <span class="distance-badge">${distance}km</span>
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="card-body d-flex flex-column h-100">
                                        <h5 class="card-title">${chain.chainName}</h5>
                                        <p class="card-text text-muted">${chain.address || '주소 정보 없음'}</p>
                                        <p class="card-text"><small class="text-muted">${chain.phone || '전화번호 없음'}</small></p>
                                        
                                        <div class="mt-auto">
                                            <div class="d-flex gap-2">
                                                <a href="${pageContext.request.contextPath}/chain/detail/${chain.chainNum}" 
                                                   class="btn btn-primary flex-fill">상세보기</a>
                                                <button class="btn btn-outline-success" onclick="quickEnter('${chain.chainCode}')">
                                                    길찾기
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                `;
            });
            
            container.innerHTML = html;
        }
        
        // 길찾기 (실제로는 지도 앱 연동)
        function quickEnter(chainCode) {
            alert('길찾기 기능은 추후 업데이트 예정입니다.');
        }
        
        // 정렬 변경
        document.querySelectorAll('input[name="sortBy"]').forEach(radio => {
            radio.addEventListener('change', function() {
                searchNearby(); // 정렬 기준 변경 시 재검색
            });
        });
    </script>
</body>
</html>