<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${program.programName} - ${program.chainName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        /* 빨간색 계열 - 적극적인 선택과 결정 */
        .program-detail-header {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            padding: 60px 0;
        }
        
        .program-detail-header h1, .program-detail-header h2 {
            color: white;
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .program-detail-header p {
            color: rgba(255,255,255,0.9);
            font-size: 1.1rem;
            margin-bottom: 0;
        }
        
        .program-hero {
            height: 400px;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)),
                        url('${pageContext.request.contextPath}/resources/images/designbody/programs/${program.imagePath != null ? program.imagePath : "default-program.jpg"}');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            color: white;
        }
        .chain-info-card {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border-radius: 16px;
        }
        .enroll-card {
            position: sticky;
            top: 20px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .feature-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
        }
        .capacity-progress {
            height: 8px;
            border-radius: 4px;
        }
        .schedule-calendar {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
        }
        .time-slot {
            background: #e9ecef;
            border-radius: 8px;
            padding: 8px 12px;
            margin: 4px 0;
            cursor: pointer;
            transition: all 0.2s;
        }
        .time-slot:hover {
            background: #FF6A00;
            color: white;
        }
        .time-slot.selected {
            background: #FF6A00;
            color: white;
        }
        .fc-event {
            background: #FF6A00;
            border-color: #FF6A00;
        }
        .map-container {
            height: 300px;
            border-radius: 12px;
        }

        @media (max-width: 768px) {
            .program-detail-header {
                padding: 40px 0;
            }
            .program-detail-header h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />
    
    <!-- 프로그램 상세 헤더 -->
    <div class="program-detail-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <div class="mb-3">
                        <span class="badge bg-light text-dark me-2">${program.typeText}</span>
                        <span class="badge bg-secondary">${program.difficultyText}</span>
                        <span class="badge ${program.statusBadgeClass}">${program.statusText}</span>
                    </div>
                    <h2 class="fw-bold">${program.programName}</h2>
                    <p class="lead">${program.description}</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="d-flex gap-4 justify-content-end">
                        <div class="text-center">
                            <div class="fw-bold fs-4">${program.duration}</div>
                            <small>일 과정</small>
                        </div>
                        <div class="text-center">
                            <div class="fw-bold fs-4">${program.formattedFinalPrice}</div>
                            <small>
                                <c:if test="${program.hasDiscount()}">
                                    <s class="text-decoration-line-through">${program.formattedPrice}</s>
                                    <span class="badge bg-danger ms-1">${program.discountRate}% 할인</span>
                                </c:if>
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-5">
        <div class="row">
            <div class="col-lg-8">
                <!-- 체인점 정보 -->
                <div class="chain-info-card p-4 mb-4">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h4 class="text-white mb-2">
                                <i class="fas fa-map-marker-alt me-2"></i>${program.chainName}
                            </h4>
                            <p class="mb-2">${program.chainAddress}</p>
                            <div class="d-flex gap-3">
                                <span><i class="fas fa-phone me-1"></i>${program.chainPhone}</span>
                                <span><i class="fas fa-door-open me-1"></i>${program.programRoom}</span>
                            </div>
                        </div>
                        <div class="col-md-4 text-end">
                            <button class="btn btn-light" onclick="showMap()">
                                <i class="fas fa-map me-2"></i>지도 보기
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- 운영 일정 및 시간 -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="mb-4">운영 일정</h4>
                        
                        <!-- 요일 및 시간 정보 -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <h6>운영 요일</h6>
                                <div class="d-flex flex-wrap gap-2">
                                    <c:forEach var="day" items="${program.operatingDaysArray}">
                                        <span class="badge bg-primary">${day}</span>
                                    </c:forEach>
                                </div>
                                <c:if test="${program.operatingToday}">
                                    <div class="alert alert-success mt-2 py-2">
                                        <small><i class="fas fa-check-circle me-1"></i>오늘 운영중입니다</small>
                                    </div>
                                </c:if>
                            </div>
                            <div class="col-md-6">
                                <h6>운영 시간</h6>
                                <p class="mb-0">${program.operatingTime}</p>
                                <c:if test="${not empty program.holidayInfo}">
                                    <small class="text-muted">휴무: ${program.holidayInfo}</small>
                                </c:if>
                            </div>
                        </div>
                        
                        <!-- 캘린더 -->
                        <div class="schedule-calendar">
                            <h6 class="mb-3">프로그램 캘린더</h6>
                            <div id="programCalendar"></div>
                        </div>
                    </div>
                </div>
                
                <!-- 프로그램 소개 -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="mb-4">프로그램 소개</h4>
                        <p style="white-space: pre-line;">${program.description}</p>
                        
                        <c:if test="${not empty program.targetAudience}">
                            <h6 class="mt-4">추천 대상</h6>
                            <p>${program.targetAudience}</p>
                        </c:if>
                        
                        <c:if test="${not empty program.equipment}">
                            <h6 class="mt-4">필요한 장비</h6>
                            <p>${program.equipment}</p>
                        </c:if>
                    </div>
                </div>
                
                <!-- 프로그램 특징 -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="mb-4">프로그램 특징</h4>
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <div class="d-flex align-items-center">
                                    <div class="feature-icon me-3">
                                        <i class="fas fa-map-marker-alt"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">체인점 전용</h6>
                                        <small class="text-muted">${program.chainName}에서만 제공</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="d-flex align-items-center">
                                    <div class="feature-icon me-3">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">소수정예</h6>
                                        <small class="text-muted">최대 ${program.maxCapacity}명까지</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="d-flex align-items-center">
                                    <div class="feature-icon me-3">
                                        <i class="fas fa-clock"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">정해진 시간</h6>
                                        <small class="text-muted">${program.operatingDaysKorean}</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="d-flex align-items-center">
                                    <div class="feature-icon me-3">
                                        <i class="fas fa-user-tie"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">전문 트레이너</h6>
                                        <small class="text-muted">${program.instructor}</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 지도 (처음에는 숨김) -->
                <div class="card mb-4 d-none" id="mapCard">
                    <div class="card-body">
                        <h4 class="mb-4">체인점 위치</h4>
                        <div id="chainMap" class="map-container"></div>
                        <div class="mt-3">
                            <p class="mb-0"><strong>${program.chainName}</strong></p>
                            <p class="text-muted">${program.chainAddress}</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 사이드바 - 신청 카드 -->
            <div class="col-lg-4">
                <div class="enroll-card p-4">
                    <!-- 정원 현황 -->
                    <div class="text-center mb-4">
                        <div class="display-6 fw-bold text-primary">${program.formattedFinalPrice}</div>
                        <small class="text-muted">${program.duration}일 프로그램</small>
                        <c:if test="${program.hasDiscount()}">
                            <div class="mt-2">
                                <span class="badge bg-danger">${program.discountRate}% 할인 중!</span>
                            </div>
                        </c:if>
                    </div>
                    
                    <!-- 정원 진행률 -->
                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="text-muted">정원 현황</span>
                            <span class="fw-bold">${program.capacityInfo}</span>
                        </div>
                        <div class="progress capacity-progress">
                            <div class="progress-bar ${program.almostFull ? 'bg-warning' : program.full ? 'bg-danger' : 'bg-success'}" 
                                 style="width: ${program.enrollmentRate}%"></div>
                        </div>
                        <small class="text-muted">${program.enrollmentRate}% 등록됨</small>
                    </div>
                    
                    <!-- 신청 버튼 -->
                    <c:choose>
                        <c:when test="${empty sessionScope.userNum}">
                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary btn-lg">
                                    로그인하고 신청하기
                                </a>
                                <small class="text-muted text-center">회원만 신청 가능합니다</small>
                            </div>
                        </c:when>
                        <c:when test="${alreadyEnrolled}">
                            <div class="alert alert-success text-center">
                                <i class="fas fa-check-circle me-2"></i>이미 신청한 프로그램입니다
                            </div>
                            <div class="d-grid">
                                <a href="${pageContext.request.contextPath}/designbody/chain/my" class="btn btn-outline-primary">
                                    내 프로그램 보기
                                </a>
                            </div>
                        </c:when>
                        <c:when test="${program.full}">
                            <div class="alert alert-danger text-center">
                                <i class="fas fa-exclamation-circle me-2"></i>정원이 마감되었습니다
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="d-grid gap-2">
                                <c:if test="${program.almostFull}">
                                    <div class="alert alert-warning py-2 text-center">
                                        <small><i class="fas fa-clock me-1"></i>마감 임박! 서둘러 신청하세요</small>
                                    </div>
                                </c:if>
                                <button class="btn btn-primary btn-lg" onclick="enrollProgram()">
                                    지금 신청하기
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <hr class="my-4">
                    
                    <!-- 프로그램 정보 -->
                    <div class="program-info">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">체인점</span>
                            <span>${program.chainName}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">프로그램실</span>
                            <span>${program.programRoom}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">카테고리</span>
                            <span>${program.typeText}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">난이도</span>
                            <span>${program.difficultyText}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">기간</span>
                            <span>${program.duration}일</span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">트레이너</span>
                            <span>${program.instructor}</span>
                        </div>
                    </div>
                </div>
                
                <!-- 같은 체인점의 다른 프로그램 -->
                <c:if test="${not empty otherPrograms}">
                    <div class="card mt-4">
                        <div class="card-header">
                            <h6 class="mb-0">${program.chainName}의 다른 프로그램</h6>
                        </div>
                        <div class="card-body">
                            <c:forEach var="otherProgram" items="${otherPrograms}">
                                <div class="d-flex align-items-center mb-3">
                                    <img src="${pageContext.request.contextPath}/resources/images/designbody/programs/${otherProgram.imagePath != null ? otherProgram.imagePath : 'default-program.jpg'}" 
                                         class="rounded me-3" width="60" height="60" alt="프로그램">
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">${otherProgram.programName}</h6>
                                        <small class="text-muted">${otherProgram.difficultyText} · ${otherProgram.formattedFinalPrice}</small>
                                        <div class="mt-1">
                                            <span class="badge ${otherProgram.statusBadgeClass} badge-sm">${otherProgram.statusText}</span>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            <a href="${pageContext.request.contextPath}/designbody/chain/chain/${program.chainNum}" 
                               class="btn btn-sm btn-outline-primary w-100">더 많은 프로그램 보기</a>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js"></script>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_KAKAO_MAP_KEY"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    
    <script>
        let calendar;
        let chainMap;
        
        // 페이지 로드 시 캘린더 초기화
        document.addEventListener('DOMContentLoaded', function() {
            initCalendar();
        });
        
        // 캘린더 초기화
        function initCalendar() {
            var calendarEl = document.getElementById('programCalendar');
            
            calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'ko',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,listWeek'
                },
                height: 400,
                events: generateProgramEvents(),
                eventDisplay: 'block',
                dayMaxEvents: 2,
                eventClick: function(info) {
                    alert('시간: ' + info.event.title + '\n프로그램: ${program.programName}');
                }
            });
            
            calendar.render();
        }
        
        // 프로그램 이벤트 생성
        function generateProgramEvents() {
            var events = [];
            var operatingDays = '${program.operatingDays}'.split(',');
            var operatingTime = '${program.operatingTime}';
            
            // 다음 한 달간의 이벤트 생성
            var today = new Date();
            var endDate = new Date();
            endDate.setMonth(endDate.getMonth() + 1);
            
            var dayMap = {
                'MON': 1, 'TUE': 2, 'WED': 3, 'THU': 4, 
                'FRI': 5, 'SAT': 6, 'SUN': 0
            };
            
            var current = new Date(today);
            while (current <= endDate) {
                var dayOfWeek = current.getDay();
                
                // 운영 요일인지 확인
                var isOperatingDay = operatingDays.some(day => dayMap[day.trim()] === dayOfWeek);
                
                if (isOperatingDay) {
                    events.push({
                        title: operatingTime,
                        start: current.toISOString().split('T')[0],
                        backgroundColor: '#FF6A00',
                        borderColor: '#FF6A00',
                        textColor: 'white'
                    });
                }
                
                current.setDate(current.getDate() + 1);
            }
            
            return events;
        }
        
        // 지도 표시
        function showMap() {
            var mapCard = document.getElementById('mapCard');
            mapCard.classList.toggle('d-none');
            
            if (!mapCard.classList.contains('d-none') && !chainMap) {
                initChainMap();
            }
        }
        
        // 체인점 지도 초기화
        function initChainMap() {
            <c:if test="${chain.latitude != null && chain.longitude != null}">
                var container = document.getElementById('chainMap');
                var options = {
                    center: new kakao.maps.LatLng(${chain.latitude}, ${chain.longitude}),
                    level: 3
                };
                
                chainMap = new kakao.maps.Map(container, options);
                
                // 마커 표시
                var markerPosition = new kakao.maps.LatLng(${chain.latitude}, ${chain.longitude});
                var marker = new kakao.maps.Marker({
                    position: markerPosition
                });
                marker.setMap(chainMap);
                
                // 인포윈도우 표시
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="padding:5px;font-size:12px;">' +
                            '<strong>${program.chainName}</strong><br>' +
                            '${program.chainAddress}' +
                            '</div>'
                });
                infowindow.open(chainMap, marker);
            </c:if>
        }
        
        // 프로그램 신청
        function enrollProgram() {
            <c:if test="${program.price > 0}">
                if (confirm('${program.programName} 프로그램을 ${program.formattedFinalPrice}에 신청하시겠습니까?\n\n체인점: ${program.chainName}\n기간: ${program.duration}일')) {
                    // 결제 진행
                    requestPayment();
                } 
            </c:if>
            <c:if test="${program.price == 0}">
                if (confirm('${program.programName} 프로그램을 신청하시겠습니까?\n\n체인점: ${program.chainName}\n기간: ${program.duration}일\n\n무료 프로그램입니다.')) {
                    processEnrollment(null);
                }
            </c:if>
        }
        
        // 결제 처리
        function requestPayment() {
            // 실제 환경에서는 포트원 결제 구현
            alert('결제 기능은 실제 배포 환경에서 구현됩니다.');
            
            // 데모용 - 임시 결제 ID로 신청 처리
            const paymentId = 'demo_payment_' + Date.now();
            processEnrollment(paymentId);
        }
        
        // 신청 처리
        function processEnrollment(paymentId) {
            fetch('${pageContext.request.contextPath}/designbody/enroll', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'programNum=${program.programNum}&chainNum=${program.chainNum}&paymentId=' + (paymentId || '')
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
    </script>
</body>
</html>