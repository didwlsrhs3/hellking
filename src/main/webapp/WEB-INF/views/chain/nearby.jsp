<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 주변 가맹점 - 헬킹 피트니스</title>
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
        
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
            background: rgba(255,255,255,0.9);
            color: #333;
=======
            background: rgba(255,106,0,0.9);
            color: white;
>>>>>>> b65c320 (Initial commit)
            border-radius: 20px;
            padding: 4px 12px;
            font-size: 0.85rem;
            font-weight: 600;
        }
        #map {
<<<<<<< HEAD
            height: 400px;
            border-radius: 12px;
=======
            height: 500px;
            border-radius: 12px;
            border: 2px solid #e9ecef;
        }
        .current-location-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            z-index: 10;
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        .map-container {
            position: relative;
        }
        .info-window {
            padding: 10px;
            max-width: 200px;
        }
        .location-status {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid #007bff;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-map-marker-alt text-primary fa-2x me-3"></i>
                            <div>
                                <h6 class="mb-1">현재 위치</h6>
                                <p class="text-muted mb-0" id="currentAddress">위치 정보를 가져오는 중...</p>
                            </div>
=======
                <div class="location-status">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-map-marker-alt text-primary fa-2x me-3"></i>
                        <div>
                            <h6 class="mb-1">현재 위치</h6>
                            <p class="text-muted mb-0" id="currentAddress">
                                <span class="loading-spinner me-2"></span>위치 정보를 가져오는 중...
                            </p>
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
=======
                            <option value="20">20km 이내</option>
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
                        <div id="map" class="bg-light d-flex align-items-center justify-content-center">
                            <div class="text-center">
                                <i class="fas fa-map fa-3x text-muted mb-3"></i>
                                <p class="text-muted">지도를 불러오는 중...</p>
                                <small class="text-muted">카카오맵 API 연동 예정</small>
                            </div>
=======
                        <div class="map-container">
                            <div id="map">
                                <div class="d-flex align-items-center justify-content-center h-100">
                                    <div class="text-center">
                                        <div class="loading-spinner mb-3"></div>
                                        <p class="text-muted">카카오맵을 불러오는 중...</p>
                                    </div>
                                </div>
                            </div>
                            <button class="current-location-btn" onclick="moveToCurrentLocation()" title="내 위치로 이동">
                                <i class="fas fa-crosshairs"></i>
                            </button>
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
=======
                        
                        <input type="radio" class="btn-check" name="sortBy" id="name" value="name">
                        <label class="btn btn-outline-primary" for="name">이름순</label>
>>>>>>> b65c320 (Initial commit)
                    </div>
                </div>
                
                <div id="nearbyChains" class="row">
                    <!-- 가맹점 로딩 상태 -->
                    <div class="col-12 text-center py-5">
<<<<<<< HEAD
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">로딩중...</span>
                        </div>
                        <p class="mt-3 text-muted">주변 가맹점을 검색하고 있습니다...</p>
=======
                        <div class="loading-spinner mb-3"></div>
                        <p class="text-muted">내 위치를 찾은 후 주변 가맹점을 검색합니다...</p>
>>>>>>> b65c320 (Initial commit)
                    </div>
                </div>
            </div>
        </div>
    </div>
    
<<<<<<< HEAD
=======
    <!-- 카카오맵 API -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakaoMapApiKey}&libraries=services"></script>
>>>>>>> b65c320 (Initial commit)
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
<<<<<<< HEAD
        let currentPosition = null;
        
        // 페이지 로드 시 자동으로 위치 가져오기
        window.addEventListener('load', function() {
            getCurrentLocation();
        });
        
=======
        let map;
        let currentPosition = null;
        let geocoder;
        let markers = [];
        let currentLocationMarker = null;
        let infoWindow = null;
        
        // 페이지 로드 시 초기화
        window.addEventListener('load', function() {
            initializeMap();
            getCurrentLocation();
        });
        
        // 카카오맵 초기화
        function initializeMap() {
            const container = document.getElementById('map');
            const options = {
                center: new kakao.maps.LatLng(37.5665, 126.9780), // 서울 시청 기본 위치
                level: 5
            };
            
            map = new kakao.maps.Map(container, options);
            geocoder = new kakao.maps.services.Geocoder();
            
            console.log('카카오맵 초기화 완료');
        }
        
>>>>>>> b65c320 (Initial commit)
        // 현재 위치 가져오기
        function getCurrentLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(
                    function(position) {
                        currentPosition = {
                            latitude: position.coords.latitude,
                            longitude: position.coords.longitude
                        };
                        
<<<<<<< HEAD
                        updateAddressDisplay(currentPosition.latitude, currentPosition.longitude);
=======
                        console.log('현재 위치:', currentPosition);
                        
                        // 지도 중심 이동
                        const moveLatLng = new kakao.maps.LatLng(currentPosition.latitude, currentPosition.longitude);
                        map.setCenter(moveLatLng);
                        
                        // 현재 위치 마커 표시
                        showCurrentLocationMarker();
                        
                        // 주소 표시 업데이트
                        updateAddressDisplay(currentPosition.latitude, currentPosition.longitude);
                        
                        // 주변 가맹점 검색
>>>>>>> b65c320 (Initial commit)
                        searchNearby();
                    },
                    function(error) {
                        console.error('위치 정보를 가져올 수 없습니다:', error);
<<<<<<< HEAD
                        document.getElementById('currentAddress').textContent = '위치 정보를 가져올 수 없습니다';
                        
                        // 기본 위치로 서울 설정
                        currentPosition = { latitude: 37.5665, longitude: 126.9780 };
=======
                        document.getElementById('currentAddress').innerHTML = 
                            '<i class="fas fa-exclamation-triangle text-warning me-2"></i>위치 정보를 가져올 수 없습니다';
                        
                        // 기본 위치로 설정 (서울 시청)
                        currentPosition = { latitude: 37.5665, longitude: 126.9780 };
                        document.getElementById('currentAddress').innerHTML += ' (기본 위치: 서울 시청)';
>>>>>>> b65c320 (Initial commit)
                        searchNearby();
                    }
                );
            } else {
                alert('이 브라우저는 위치 서비스를 지원하지 않습니다.');
<<<<<<< HEAD
                // 기본 위치로 서울 설정
=======
>>>>>>> b65c320 (Initial commit)
                currentPosition = { latitude: 37.5665, longitude: 126.9780 };
                searchNearby();
            }
        }
        
<<<<<<< HEAD
        // 주소 표시 업데이트 (실제로는 역지오코딩 API 사용)
        function updateAddressDisplay(lat, lng) {
            // 임시 주소 표시
            document.getElementById('currentAddress').textContent = 
                `위도: ${lat.toFixed(4)}, 경도: ${lng.toFixed(4)}`;
=======
        // 현재 위치 마커 표시
        function showCurrentLocationMarker() {
            if (currentLocationMarker) {
                currentLocationMarker.setMap(null);
            }
            
            const position = new kakao.maps.LatLng(currentPosition.latitude, currentPosition.longitude);
            
            // 현재 위치 마커 (파란색)
            const markerImage = new kakao.maps.MarkerImage(
                'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_blue.png',
                new kakao.maps.Size(36, 37)
            );
            
            currentLocationMarker = new kakao.maps.Marker({
                position: position,
                map: map,
                image: markerImage,
                title: '현재 위치'
            });
            
            // 현재 위치 원형 표시
            const circle = new kakao.maps.Circle({
                center: position,
                radius: parseInt(document.getElementById('radiusSelect').value) * 1000,
                strokeWeight: 2,
                strokeColor: '#007bff',
                strokeOpacity: 0.8,
                fillColor: '#007bff',
                fillOpacity: 0.1
            });
            
            circle.setMap(map);
        }
        
        // 내 위치로 지도 이동
        function moveToCurrentLocation() {
            if (currentPosition) {
                const moveLatLng = new kakao.maps.LatLng(currentPosition.latitude, currentPosition.longitude);
                map.setCenter(moveLatLng);
                map.setLevel(5);
            }
        }
        
        // 주소 표시 업데이트
        function updateAddressDisplay(lat, lng) {
            geocoder.coord2Address(lng, lat, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    const addr = result[0].address.address_name;
                    document.getElementById('currentAddress').innerHTML = 
                        '<i class="fas fa-map-marker-alt text-success me-2"></i>' + addr;
                } else {
                    document.getElementById('currentAddress').innerHTML = 
                        '<i class="fas fa-map-marker-alt text-primary me-2"></i>위도: ' + 
                        lat.toFixed(4) + ', 경도: ' + lng.toFixed(4);
                }
            });
>>>>>>> b65c320 (Initial commit)
        }
        
        // 주변 가맹점 검색
        function searchNearby() {
            if (!currentPosition) {
                alert('위치 정보가 필요합니다.');
                return;
            }
            
<<<<<<< HEAD
            const radius = document.getElementById('radiusSelect').value;
=======
            const radius = parseInt(document.getElementById('radiusSelect').value);
            const sortBy = document.querySelector('input[name="sortBy"]:checked').value;
            
            // 로딩 표시
            const nearbyContainer = document.getElementById('nearbyChains');
            nearbyContainer.innerHTML = 
                '<div class="col-12 text-center py-5">' +
                '<div class="loading-spinner mb-3"></div>' +
                '<p class="text-muted">주변 가맹점을 검색하고 있습니다...</p>' +
                '</div>';
            
            console.log('주변 가맹점 검색 시작:', {
                position: currentPosition,
                radius: radius,
                sortBy: sortBy
            });
>>>>>>> b65c320 (Initial commit)
            
            fetch('${pageContext.request.contextPath}/chain/nearbySearch', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
<<<<<<< HEAD
                body: `latitude=${currentPosition.latitude}&longitude=${currentPosition.longitude}&radius=${radius}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    displayNearbyChains(data.chains);
                } else {
                    document.getElementById('nearbyChains').innerHTML = 
=======
                body: 'latitude=' + currentPosition.latitude + 
                      '&longitude=' + currentPosition.longitude + 
                      '&radius=' + radius + 
                      '&sortBy=' + sortBy
            })
            .then(response => response.json())
            .then(data => {
                console.log('서버 응답:', data);
                
                if (data.success) {
                    displayNearbyChains(data.chains);
                    displayChainsOnMap(data.chains);
                } else {
                    nearbyContainer.innerHTML = 
>>>>>>> b65c320 (Initial commit)
                        '<div class="col-12 text-center py-5"><p class="text-muted">주변 가맹점을 찾을 수 없습니다.</p></div>';
                }
            })
            .catch(error => {
                console.error('검색 중 오류:', error);
<<<<<<< HEAD
                document.getElementById('nearbyChains').innerHTML = 
=======
                nearbyContainer.innerHTML = 
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
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
=======
                html += '<div class="col-lg-6 mb-4">' +
                        '<div class="card chain-card h-100">' +
                        '<div class="row g-0 h-100">' +
                        '<div class="col-md-4 position-relative">' +
                        '<img src="${pageContext.request.contextPath}/resources/images/chains/' + (chain.imagePath || 'default-chain.jpg') + '" ' +
                        'class="img-fluid rounded-start h-100" style="object-fit: cover;" alt="' + chain.chainName + '"' +
                        'onerror="this.src=\'${pageContext.request.contextPath}/resources/images/default-chain.jpg\'">' +
                        '<div class="position-absolute top-0 end-0 m-2">' +
                        '<span class="distance-badge">' + (chain.distanceText || '거리 계산 중') + '</span>' +
                        '</div>' +
                        '</div>' +
                        '<div class="col-md-8">' +
                        '<div class="card-body d-flex flex-column h-100">' +
                        '<h5 class="card-title">' + chain.chainName + '</h5>' +
                        '<p class="card-text text-muted">' + chain.address + '</p>' +
                        '<p class="card-text"><small class="text-muted">' + (chain.phone || '전화번호 없음') + '</small></p>' +
                        '<div class="mt-auto">' +
                        '<div class="d-flex gap-2">' +
                        '<a href="${pageContext.request.contextPath}/chain/detail/' + chain.chainNum + '" ' +
                        'class="btn btn-primary flex-fill">상세보기</a>' +
                        '<button class="btn btn-outline-success" onclick="showChainOnMap(' + chain.latitude + ', ' + chain.longitude + ')">' +
                        '지도보기</button>' +
                        '<button class="btn btn-outline-info" onclick="getDirections(\'' + chain.address + '\')">' +
                        '길찾기</button>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>';
>>>>>>> b65c320 (Initial commit)
            });
            
            container.innerHTML = html;
        }
        
<<<<<<< HEAD
        // 길찾기 (실제로는 지도 앱 연동)
        function quickEnter(chainCode) {
            alert('길찾기 기능은 추후 업데이트 예정입니다.');
=======
        // 지도에 가맹점 마커 표시
        function displayChainsOnMap(chains) {
            // 기존 마커 제거
            markers.forEach(marker => marker.setMap(null));
            markers = [];
            
            chains.forEach(chain => {
                if (chain.latitude && chain.longitude) {
                    const position = new kakao.maps.LatLng(chain.latitude, chain.longitude);
                    
                    const marker = new kakao.maps.Marker({
                        position: position,
                        map: map,
                        title: chain.chainName
                    });
                    
                    markers.push(marker);
                    
                    // 마커 클릭 이벤트
                    kakao.maps.event.addListener(marker, 'click', function() {
                        if (infoWindow) {
                            infoWindow.close();
                        }
                        
                        const content = '<div class="info-window">' +
                                        '<h6 class="mb-2">' + chain.chainName + '</h6>' +
                                        '<p class="mb-1 small">' + chain.address + '</p>' +
                                        '<p class="mb-2 text-muted small">' + (chain.distanceText || '거리 계산 중') + '</p>' +
                                        '<div class="d-flex gap-1">' +
                                        '<a href="${pageContext.request.contextPath}/chain/detail/' + chain.chainNum + '" ' +
                                        'class="btn btn-sm btn-primary">상세보기</a>' +
                                        '</div>' +
                                        '</div>';
                        
                        infoWindow = new kakao.maps.InfoWindow({
                            content: content,
                            removable: true
                        });
                        
                        infoWindow.open(map, marker);
                    });
                }
            });
        }
        
        // 특정 가맹점을 지도에서 보여주기
        function showChainOnMap(latitude, longitude) {
            const position = new kakao.maps.LatLng(latitude, longitude);
            map.setCenter(position);
            map.setLevel(3);
            
            // 해당 마커 찾아서 클릭 이벤트 발생
            markers.forEach(marker => {
                if (marker.getPosition().equals(position)) {
                    kakao.maps.event.trigger(marker, 'click');
                }
            });
        }
        
        // 길찾기 (외부 지도 앱 연동)
        function getDirections(address) {
            if (confirm('외부 지도 앱으로 길찾기를 시작하시겠습니까?')) {
                // 카카오맵 앱 또는 웹으로 연결
                const kakaoMapUrl = 'https://map.kakao.com/link/to/' + encodeURIComponent(address);
                window.open(kakaoMapUrl, '_blank');
            }
        }
        
        // 거리 포맷팅 함수
        function formatDistance(distance) {
            if (!distance) return '';
            
            if (distance < 1) {
                return Math.round(distance * 1000) + 'm';
            } else {
                return distance.toFixed(1) + 'km';
            }
>>>>>>> b65c320 (Initial commit)
        }
        
        // 정렬 변경
        document.querySelectorAll('input[name="sortBy"]').forEach(radio => {
            radio.addEventListener('change', function() {
<<<<<<< HEAD
                searchNearby(); // 정렬 기준 변경 시 재검색
            });
        });
    </script>
=======
                searchNearby();
            });
        });
        
        // 반경 변경 시 검색 원 업데이트
        document.getElementById('radiusSelect').addEventListener('change', function() {
            if (currentPosition) {
                showCurrentLocationMarker(); // 원 다시 그리기
            }
        });
    </script>
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e9b67200244ba257199ebb728770b0a8&libraries=services"></script>
>>>>>>> b65c320 (Initial commit)
</body>
</html>