<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상담예약 신청 | 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 - 초록색 */
        .page-header {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 60px 0;
        }
        
        .page-header h2 {
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
        
        /* 기존 스타일 조정 */
        :root {
            --primary-color: #28a745;
            --secondary-color: #F4ECDC;
            --text-color: #0F172A;
            --muted-color: #5B6170;
            --border-color: #E7E0D6;
        }
        
        .form-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            padding: 2.5rem;
            border: 1px solid var(--border-color);
        }
        
        .form-label {
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 0.5rem;
        }
        
        .form-control {
            border: 2px solid #E2E8F0;
            border-radius: 8px;
            padding: 0.75rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
        }
        
        .btn-primary-custom {
            background: var(--primary-color);
            border: none;
            padding: 0.875rem 3rem;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1.1rem;
            transition: all 0.3s ease;
            color: white;
        }
        
        .btn-primary-custom:hover {
            background: #218838;
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-outline-custom {
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            padding: 0.875rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-outline-custom:hover {
            background: var(--primary-color);
            color: white;
        }
        
        .time-slot {
            border: 2px solid #E2E8F0;
            border-radius: 8px;
            padding: 0.75rem;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 0.5rem;
        }
        
        .time-slot:hover {
            border-color: var(--primary-color);
            background: rgba(40, 167, 69, 0.1);
        }
        
        .time-slot.selected {
            border-color: var(--primary-color);
            background: var(--primary-color);
            color: white;
        }
        
        .time-slot.disabled {
            background: #F1F5F9;
            color: #94A3B8;
            cursor: not-allowed;
            border-color: #E2E8F0;
        }
        
        .info-alert {
            background: #FEF3C7;
            border: 1px solid #F59E0B;
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 2rem;
        }
        
        .required {
            color: #EF4444;
        }
        
        .loading-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 9999;
        }
        
        .loading-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 2rem;
            border-radius: 12px;
            text-align: center;
        }
        
        /* 반응형 */
        @media (max-width: 768px) {
            .page-header {
                padding: 40px 0;
            }
            .page-header .row {
                text-align: center;
            }
            .page-header .col-md-4 {
                margin-top: 20px;
            }
            .form-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    
    <!-- 통일된 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/">홈</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/support/">고객센터</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/support/consultation">상담예약</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">예약신청</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">상담예약 신청</h2>
                    <p class="lead">전문 상담사와 1:1 맞춤 상담을 받아보세요. 빠른 시일 내에 연락드리겠습니다.</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/support/consultation" 
                       class="btn btn-light btn-lg">
                        <i class="fas fa-arrow-left me-2"></i>상담 목록
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        
        <!-- 메시지 표시 -->
        <c:if test="${not empty message}">
            <div class="alert alert-${messageType == 'error' ? 'danger' : 'success'} alert-dismissible fade show">
                <i class="fas fa-${messageType == 'error' ? 'exclamation-triangle' : 'check-circle'} me-2"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <div class="row justify-content-center">
            <div class="col-lg-8">
                
                <!-- 안내 메시지 -->
                <div class="info-alert">
                    <div class="d-flex">
                        <i class="fas fa-info-circle me-3 mt-1" style="color: #F59E0B;"></i>
                        <div>
                            <strong>예약 안내</strong>
                            <ul class="mb-0 mt-2">
                                <li>상담시간: 평일 10:00-12:00, 14:00-17:00 (점심시간 제외)</li>
                                <li>예약은 선착순으로 진행됩니다</li>
                                <li>예약 1시간 전까지 취소 가능합니다</li>
                                <li>주말 및 공휴일은 휴무입니다</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <!-- 예약 폼 -->
                <div class="form-card">
                    <form id="consultationForm" method="post" action="${pageContext.request.contextPath}/support/consultation/create">
                        
                        <!-- 날짜 선택 -->
                        <div class="mb-4">
                            <label class="form-label">
                                상담 날짜 <span class="required">*</span>
                            </label>
                            <input type="date" class="form-control" id="consultationDate" 
                                   name="consultationDate" required>
                            <div class="form-text">평일만 선택 가능합니다 (주말, 공휴일 제외)</div>
                        </div>
                        
                        <!-- 시간 선택 -->
                        <div class="mb-4">
                            <label class="form-label">
                                상담 시간 <span class="required">*</span>
                            </label>
                            <div id="timeSlots" class="row">
                                <div class="col-12 text-center text-muted">
                                    날짜를 먼저 선택해주세요
                                </div>
                            </div>
                            <input type="hidden" id="consultationTime" name="consultationTime" required>
                        </div>
                        
                        <!-- 예약자 정보 -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="form-label">
                                    예약자명 <span class="required">*</span>
                                </label>
                                <input type="text" class="form-control" id="name" name="name" 
                                       value="${not empty recentConsultation ? recentConsultation.name : user.username}" 
                                       required maxlength="50">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">
                                    연락처 <span class="required">*</span>
                                </label>
                                <input type="tel" class="form-control" id="phone" name="phone" 
                                       value="${not empty recentConsultation ? recentConsultation.phone : user.phone}" 
                                       required pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" 
                                       placeholder="010-1234-5678">
                            </div>
                        </div>
                        
                        <!-- 이메일 -->
                        <div class="mb-4">
                            <label class="form-label">
                                이메일 <span class="required">*</span>
                            </label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   value="${not empty recentConsultation ? recentConsultation.email : user.email}" 
                                   required maxlength="100">
                            <div class="form-text">예약 확인 및 안내 메일을 받으실 이메일 주소입니다</div>
                        </div>
                        
                        <!-- 상담 내용 -->
                        <div class="mb-4">
                            <label class="form-label">상담 내용</label>
                            <textarea class="form-control" id="content" name="content" rows="4" 
                                      maxlength="500" placeholder="상담 받고 싶은 내용이나 궁금한 점을 자유롭게 작성해주세요 (선택사항)"></textarea>
                            <div class="form-text">
                                <span id="contentCount">0</span>/500자
                            </div>
                        </div>
                        
                        <!-- 버튼 -->
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/support/consultation" 
                               class="btn btn-outline-custom">
                                <i class="fas fa-arrow-left me-2"></i>목록으로
                            </a>
                            <button type="submit" class="btn btn-primary-custom" id="submitBtn">
                                <i class="fas fa-check me-2"></i>예약 신청
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 로딩 오버레이 -->
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-content">
            <div class="spinner-border text-primary mb-3" style="width: 3rem; height: 3rem;"></div>
            <h5>예약을 처리하고 있습니다...</h5>
            <p class="text-muted mb-0">잠시만 기다려주세요</p>
        </div>
    </div>
    
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const dateInput = document.getElementById('consultationDate');
            const timeSlots = document.getElementById('timeSlots');
            const timeInput = document.getElementById('consultationTime');
            const contentTextarea = document.getElementById('content');
            const contentCount = document.getElementById('contentCount');
            const form = document.getElementById('consultationForm');
            const loadingOverlay = document.getElementById('loadingOverlay');
            
            // 오늘 날짜 이후만 선택 가능하도록 설정
            const today = new Date();
            const tomorrow = new Date(today);
            tomorrow.setDate(tomorrow.getDate() + 1);
            dateInput.min = tomorrow.toISOString().split('T')[0];
            
            // 날짜 변경 시 시간대 로드
            dateInput.addEventListener('change', function() {
                console.log('날짜 변경됨:', this.value);
                loadTimeSlots(this.value);
            });
            
            // 텍스트 카운터
            contentTextarea.addEventListener('input', function() {
                contentCount.textContent = this.value.length;
            });
            
            // 폼 제출
            form.addEventListener('submit', function(e) {
                if (!timeInput.value) {
                    e.preventDefault();
                    alert('상담 시간을 선택해주세요.');
                    return;
                }
                
                loadingOverlay.style.display = 'block';
            });
            
            // 시간대 로드 함수
            function loadTimeSlots(date) {
                if (!date) return;
                
                console.log('시간대 로드 시작:', date);
                timeSlots.innerHTML = '<div class="col-12 text-center"><div class="spinner-border spinner-border-sm"></div> 로딩 중...</div>';
                
                // AJAX 요청
                const xhr = new XMLHttpRequest();
                xhr.open('POST', '/hellking/support/consultation/available-times', true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                
                xhr.onreadystatechange = function() {
                    if (xhr.readyState === 4) {
                        console.log('AJAX 응답 상태:', xhr.status);
                        console.log('AJAX 응답 내용:', xhr.responseText);
                        
                        if (xhr.status === 200) {
                            try {
                                const data = JSON.parse(xhr.responseText);
                                console.log('파싱된 데이터:', data);
                                
                                if (data.success) {
                                    renderTimeSlots(data.availableTimes);
                                } else {
                                    timeSlots.innerHTML = '<div class="col-12 text-center text-danger">' + 
                                                        (data.message || '시간을 불러올 수 없습니다') + '</div>';
                                }
                            } catch (error) {
                                console.error('JSON 파싱 오류:', error);
                                timeSlots.innerHTML = '<div class="col-12 text-center text-danger">응답 처리 오류가 발생했습니다</div>';
                            }
                        } else {
                            console.error('AJAX 요청 실패:', xhr.status);
                            timeSlots.innerHTML = '<div class="col-12 text-center text-danger">서버 오류가 발생했습니다</div>';
                        }
                    }
                };
                
                xhr.send('date=' + encodeURIComponent(date));
            }
            
            // 시간대 렌더링 함수
            function renderTimeSlots(availableTimes) {
                console.log('시간대 렌더링:', availableTimes);
                const allTimes = ['10:00', '11:00', '14:00', '15:00', '16:00'];
                
                if (availableTimes.length === 0) {
                    timeSlots.innerHTML = '<div class="col-12 text-center text-muted">예약 가능한 시간이 없습니다</div>';
                    return;
                }
                
                let html = '';
                allTimes.forEach(function(time) {
                    const isAvailable = availableTimes.includes(time);
                    const slotClass = isAvailable ? 'time-slot' : 'time-slot disabled';
                    
                    html += '<div class="col-6 col-md-4 mb-2">';
                    html += '<div class="' + slotClass + '"';
                    if (isAvailable) {
                        html += ' onclick="selectTime(\'' + time + '\')"';
                    }
                    html += '>';
                    html += time;
                    if (!isAvailable) {
                        html += '<br><small>예약완료</small>';
                    }
                    html += '</div>';
                    html += '</div>';
                });
                
                timeSlots.innerHTML = html;
            }
            
            // 시간 선택 함수 (전역 함수로 정의)
            window.selectTime = function(time) {
                console.log('시간 선택됨:', time);
                
                // 기존 선택 해제
                const selectedSlots = document.querySelectorAll('.time-slot.selected');
                selectedSlots.forEach(function(slot) {
                    slot.classList.remove('selected');
                });
                
                // 새로운 선택
                event.target.classList.add('selected');
                timeInput.value = time;
                console.log('hidden input value 설정:', timeInput.value);
            };
            
            // 연락처 자동 포맷팅
            const phoneInput = document.getElementById('phone');
            phoneInput.addEventListener('input', function(e) {
                let value = e.target.value.replace(/[^0-9]/g, '');
                
                if (value.length >= 3 && value.length <= 7) {
                    value = value.replace(/(\d{3})(\d{1,4})/, '$1-$2');
                } else if (value.length > 7) {
                    value = value.replace(/(\d{3})(\d{4})(\d{1,4})/, '$1-$2-$3');
                }
                
                e.target.value = value;
            });
        });
    </script>
</body>
</html>