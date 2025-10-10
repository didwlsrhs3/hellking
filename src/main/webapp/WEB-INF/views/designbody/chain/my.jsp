<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 체인점 프로그램 - 디자인바디</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        /* 보라색 계열 - 편안한 탐색과 정보 확인 */
        .my-program-header {
            background: linear-gradient(135deg, #6f42c1, #5a2d91);
            color: white;
            padding: 60px 0;
        }
        
        .my-program-header h1, .my-program-header h2 {
            color: white;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .my-program-header p {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
            margin-bottom: 0;
        }
        
        .progress-card {
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            color: white;
            border-radius: 16px;
        }
        .chain-program-card {
            border-radius: 12px;
            transition: transform 0.2s;
        }
        .chain-program-card:hover {
            transform: translateY(-2px);
        }
        .chain-badge {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border-radius: 12px;
            padding: 4px 12px;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
        .chain-location {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 8px 12px;
        }

        @media (max-width: 768px) {
            .my-program-header {
                padding: 40px 0;
            }
            .my-program-header h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />
    
    <!-- 내 프로그램 헤더 -->
    <div class="my-program-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">내 체인점 프로그램</h2>
                    <p class="lead">전국 체인점에서 참여중인 프로그램을 관리하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/designbody/chain/programs" class="btn btn-light btn-lg">
                        <i class="fas fa-plus me-2"></i>새 프로그램 찾기
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 통계 카드 -->
        <div class="stats-grid mb-5">
            <div class="progress-card p-4 text-center">
                <div class="display-6 fw-bold">${stats.totalCount}</div>
                <p class="mb-0">총 신청 프로그램</p>
            </div>
            <div class="card p-4 text-center">
                <div class="display-6 fw-bold text-success">${stats.activeCount}</div>
                <p class="mb-0 text-muted">진행중인 프로그램</p>
            </div>
            <div class="card p-4 text-center">
                <div class="display-6 fw-bold text-primary">${stats.completedCount}</div>
                <p class="mb-0 text-muted">완료한 프로그램</p>
            </div>
        </div>
        
        <!-- 진행중인 프로그램 -->
        <div class="row mb-5">
            <div class="col-12">
                <h4 class="fw-bold mb-4">진행중인 프로그램</h4>
                <c:choose>
                    <c:when test="${not empty activeEnrollments}">
                        <div class="row">
                            <c:forEach var="enrollment" items="${activeEnrollments}">
                                <div class="col-lg-6 mb-4">
                                    <div class="card chain-program-card">
                                        <div class="card-body">
                                            <!-- 체인점 정보 -->
                                            <div class="chain-location mb-3">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <i class="fas fa-map-marker-alt text-success me-1"></i>
                                                        <strong>${enrollment.chainName}</strong>
                                                    </div>
                                                    <span class="chain-badge">${enrollment.statusText}</span>
                                                </div>
                                                <small class="text-muted">${enrollment.chainAddress}</small>
                                            </div>
                                            
                                            <!-- 프로그램 정보 -->
                                            <div class="row align-items-center">
                                                <div class="col-md-8">
                                                    <div class="mb-2">
                                                        <span class="badge bg-secondary me-2">${enrollment.programType}</span>
                                                        <span class="badge bg-success">${enrollment.statusText}</span>
                                                    </div>
                                                    <h5 class="card-title mb-2">${enrollment.programName}</h5>
                                                    <p class="text-muted mb-2">
                                                        <i class="fas fa-user me-2"></i>${enrollment.instructor}
                                                    </p>
                                                    <div class="d-flex justify-content-between text-muted small mb-3">
                                                        <span>
                                                            시작: <fmt:formatDate value="${enrollment.startDate}" pattern="MM.dd"/>
                                                        </span>
                                                        <span>
                                                            종료: <fmt:formatDate value="${enrollment.endDate}" pattern="MM.dd"/>
                                                        </span>
                                                    </div>
                                                    
                                                    <!-- 진행률 -->
                                                    <div class="progress mb-2">
                                                        <div class="progress-bar bg-success" role="progressbar" 
                                                             style="width: ${enrollment.progressPercent}%"></div>
                                                    </div>
                                                    <small class="text-muted">진행률: ${enrollment.progressPercent}%</small>
                                                </div>
                                                <div class="col-md-4 text-center">
                                                    <div class="position-relative d-inline-block">
                                                        <svg width="80" height="80">
                                                            <circle cx="40" cy="40" r="35" stroke="#e9ecef" stroke-width="8" fill="transparent"/>
                                                            <circle cx="40" cy="40" r="35" stroke="#28a745" stroke-width="8" fill="transparent"
                                                                    stroke-dasharray="${220 * enrollment.progressPercent / 100} 220"
                                                                    stroke-linecap="round" transform="rotate(-90 40 40)"/>
                                                        </svg>
                                                        <div class="position-absolute top-50 start-50 translate-middle">
                                                            <strong class="text-success">${enrollment.progressPercent}%</strong>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            <!-- 액션 버튼 -->
                                            <div class="d-flex gap-2 mt-3">
                                                <button class="btn btn-sm btn-primary flex-fill" 
                                                        onclick="showChainLocation(${enrollment.chainNum})">
                                                    <i class="fas fa-map-marker-alt me-1"></i>체인점 위치
                                                </button>
                                                <button class="btn btn-sm btn-outline-secondary" 
                                                        onclick="viewSchedule(${enrollment.enrollNum})">
                                                    <i class="fas fa-calendar me-1"></i>일정 보기
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card">
                            <div class="card-body text-center py-5">
                                <i class="fas fa-dumbbell fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">진행중인 체인점 프로그램이 없습니다</h5>
                                <p class="text-muted mb-4">가까운 체인점에서 새로운 프로그램을 시작해보세요!</p>
                                <a href="${pageContext.request.contextPath}/designbody/chain/programs" 
                                   class="btn btn-primary">프로그램 둘러보기</a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- 전체 신청 내역 -->
        <div class="row">
            <div class="col-12">
                <h4 class="fw-bold mb-4">전체 신청 내역</h4>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>체인점</th>
                                <th>프로그램명</th>
                                <th>카테고리</th>
                                <th>트레이너</th>
                                <th>신청일</th>
                                <th>진행기간</th>
                                <th>상태</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="enrollment" items="${myEnrollments}">
                                <tr>
                                    <td>
                                        <div>
                                            <strong>${enrollment.chainName}</strong>
                                            <br><small class="text-muted">${enrollment.chainAddress}</small>
                                        </div>
                                    </td>
                                    <td>
                                        <strong>${enrollment.programName}</strong>
                                    </td>
                                    <td>
                                        <span class="badge bg-secondary">${enrollment.programType}</span>
                                    </td>
                                    <td>${enrollment.instructor}</td>
                                    <td>
                                        <fmt:formatDate value="${enrollment.enrollDate}" pattern="yyyy.MM.dd"/>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${enrollment.startDate}" pattern="MM.dd"/> ~ 
                                        <fmt:formatDate value="${enrollment.endDate}" pattern="MM.dd"/>
                                    </td>
                                    <td>
                                        <span class="badge ${enrollment.status == 'ACTIVE' ? 'bg-success' : 
                                                           enrollment.status == 'COMPLETED' ? 'bg-primary' : 'bg-secondary'}">
                                            ${enrollment.statusText}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <c:choose>
                                                <c:when test="${enrollment.status == 'ACTIVE'}">
                                                    <button class="btn btn-outline-primary" 
                                                            onclick="showChainLocation(${enrollment.chainNum})">
                                                        <i class="fas fa-map-marker-alt"></i> 체인점
                                                    </button>
                                                    <button class="btn btn-outline-success" 
                                                            onclick="viewSchedule(${enrollment.enrollNum})">
                                                        <i class="fas fa-calendar"></i> 일정
                                                    </button>
                                                </c:when>
                                                <c:when test="${enrollment.status == 'COMPLETED'}">
                                                    <button class="btn btn-outline-success" 
                                                            onclick="viewCertificate(${enrollment.enrollNum})">
                                                        <i class="fas fa-certificate"></i> 수료증
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-outline-secondary" disabled>
                                                        ${enrollment.statusText}
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty myEnrollments}">
                                <tr>
                                    <td colspan="8" class="text-center py-5">
                                        <div class="text-muted">
                                            <i class="fas fa-inbox fa-2x mb-3"></i>
                                            <p>신청한 체인점 프로그램이 없습니다.</p>
                                            <a href="${pageContext.request.contextPath}/designbody/chain/programs" 
                                               class="btn btn-primary">프로그램 찾기</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 체인점 위치 모달 -->
    <div class="modal fade" id="chainLocationModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">체인점 위치</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div id="chainInfo"></div>
                    <div id="chainMap" style="height: 300px; border-radius: 8px;"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" id="directionsBtn">길찾기</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 일정 보기 모달 -->
    <div class="modal fade" id="scheduleModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">프로그램 일정</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div id="scheduleInfo"></div>
                    <div id="programSchedule" style="height: 400px;"></div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_KAKAO_MAP_KEY"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js"></script>
    
    <script>
        let chainMap;
        let scheduleCalendar;
        
        function showChainLocation(chainNum) {
            // 체인점 정보 조회
            fetch(`${pageContext.request.contextPath}/chain/api/detail/${chainNum}`)
            .then(response => response.json())
            .then(data => {
                if (data.success && data.chain) {
                    const chain = data.chain;
                    
                    document.getElementById('chainInfo').innerHTML = `
                        <div class="mb-3">
                            <h6>${chain.chainName}</h6>
                            <p class="text-muted mb-1">${chain.address}</p>
                            <p class="text-muted">${chain.phone}</p>
                        </div>
                    `;
                    
                    // 지도 표시
                    if (chain.latitude && chain.longitude) {
                        initChainMap(chain.latitude, chain.longitude, chain.chainName, chain.address);
                        
                        // 길찾기 버튼 설정
                        document.getElementById('directionsBtn').onclick = function() {
                            window.open(`https://map.kakao.com/link/to/${chain.chainName},${chain.latitude},${chain.longitude}`);
                        };
                    }
                    
                    new bootstrap.Modal(document.getElementById('chainLocationModal')).show();
                }
            })
            .catch(error => {
                alert('체인점 정보를 불러올 수 없습니다.');
            });
        }
        
        function initChainMap(lat, lng, name, address) {
            const container = document.getElementById('chainMap');
            const options = {
                center: new kakao.maps.LatLng(lat, lng),
                level: 3
            };
            
            chainMap = new kakao.maps.Map(container, options);
            
            const markerPosition = new kakao.maps.LatLng(lat, lng);
            const marker = new kakao.maps.Marker({
                position: markerPosition
            });
            marker.setMap(chainMap);
            
            const infowindow = new kakao.maps.InfoWindow({
                content: `<div style="padding:5px;font-size:12px;"><strong>${name}</strong><br>${address}</div>`
            });
            infowindow.open(chainMap, marker);
        }
        
        function viewSchedule(enrollNum) {
            // 프로그램 일정 정보 조회
            document.getElementById('scheduleInfo').innerHTML = `
                <div class="alert alert-info">
                    <small><i class="fas fa-info-circle me-1"></i>프로그램 일정 캘린더입니다. 체인점 방문 시 참고하세요.</small>
                </div>
            `;
            
            // 캘린더 초기화
            if (scheduleCalendar) {
                scheduleCalendar.destroy();
            }
            
            const calendarEl = document.getElementById('programSchedule');
            scheduleCalendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ko',
                height: 400,
                events: [
                    // 샘플 이벤트 - 실제로는 서버에서 해당 프로그램의 일정을 가져와야 함
                    {
                        title: '프로그램 진행',
                        start: new Date().toISOString().split('T')[0],
                        backgroundColor: '#FF6A00'
                    }
                ]
            });
            
            scheduleCalendar.render();
            new bootstrap.Modal(document.getElementById('scheduleModal')).show();
        }
        
        function viewCertificate(enrollNum) {
            alert('수료증 발급 기능은 추후 업데이트 예정입니다.');
        }
    </script>
</body>
</html>