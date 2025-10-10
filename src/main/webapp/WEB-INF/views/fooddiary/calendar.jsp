<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>월간 캘린더 - 푸드다이어리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #FF6A00;
            --secondary-color: #F4ECDC;
            --text-color: #0F172A;
            --muted-color: #5B6170;
            --border-color: #E7E0D6;
            --hover: #FFF5EA;
            --radius: 14px;
        }
        
        /* 통일된 헤더 스타일 */
        .page-header {
            background: linear-gradient(135deg, var(--primary-color), #e55a00);
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
        
        .calendar-controls {
            background: white;
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .calendar-table {
            background: white;
            border-radius: var(--radius);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        
        .calendar-table table {
            width: 100%;
            margin: 0;
        }
        
        .calendar-table th {
            background: var(--primary-color);
            color: white;
            padding: 15px 10px;
            text-align: center;
            font-weight: bold;
            border: none;
        }
        
        .calendar-table td {
            height: 120px;
            width: 14.28%;
            vertical-align: top;
            padding: 8px;
            border: 1px solid var(--border-color);
            position: relative;
            cursor: pointer;
            transition: background 0.2s;
        }
        
        .calendar-table td:hover {
            background: var(--hover);
        }
        
        .calendar-date {
            font-weight: bold;
            margin-bottom: 5px;
            color: var(--text-color);
        }
        
        .calendar-date.other-month {
            color: var(--muted-color);
        }
        
        .calendar-date.today {
            background: var(--primary-color);
            color: white;
            border-radius: 50%;
            width: 25px;
            height: 25px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
        }
        
        .calendar-stats {
            font-size: 11px;
            margin-top: 5px;
        }
        
        .calorie-info {
            background: var(--hover);
            border-radius: 4px;
            padding: 2px 5px;
            margin-bottom: 2px;
            font-size: 10px;
            color: var(--text-color);
        }
        
        .calorie-info.over-target {
            background: #ffe6e6;
            color: #d32f2f;
        }
        
        .calorie-info.under-target {
            background: #fff3e0;
            color: #ff8f00;
        }
        
        .calorie-info.good-range {
            background: #e8f5e8;
            color: #2e7d32;
        }
        
        .meal-dots {
            display: flex;
            gap: 2px;
            margin-top: 3px;
        }
        
        .meal-dot {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--muted-color);
        }
        
        .meal-dot.breakfast { background: #ffc107; }
        .meal-dot.lunch { background: #28a745; }
        .meal-dot.dinner { background: #FF6A00; }
        .meal-dot.snack { background: #17a2b8; }
        
        .legend {
            background: white;
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .legend-item {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
        }
        
        .legend-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 8px;
        }
        
        .summary-card {
            background: white;
            border-radius: var(--radius);
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }
        
        .month-nav-btn {
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: none;
            background: var(--primary-color);
            color: white;
            transition: all 0.2s;
        }
        
        .month-nav-btn:hover {
            background: #e55a00;
            transform: scale(1.1);
        }
        
        .no-data {
            text-align: center;
            color: var(--muted-color);
            padding: 40px 20px;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 40px 0;
            }
            .page-header h1 {
                font-size: 1.8rem;
            }
            .calendar-table td {
                height: 80px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 통일된 페이지 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">홈</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/fooddiary/">푸드다이어리</a></li>
                    <li class="breadcrumb-item active">월간 캘린더</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-6 fw-bold mb-3">월간 식단 캘린더</h1>
                    <p class="lead mb-0">한 달간의 식단 기록을 한눈에 확인하고 패턴을 분석해보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <i class="fas fa-calendar-alt fa-4x opacity-75"></i>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 월 선택 및 네비게이션 -->
        <div class="calendar-controls">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="d-flex align-items-center">
                        <button class="month-nav-btn me-3" onclick="changeMonth(-1)">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                        
                        <div>
                            <h3 class="mb-0" id="currentMonthYear">${currentYearMonth}월</h3>
                            <small class="text-muted">월간 식단 기록</small>
                        </div>
                        
                        <button class="month-nav-btn ms-3" onclick="changeMonth(1)">
                            <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                </div>
                
                <div class="col-md-6 text-end">
                    <a href="${pageContext.request.contextPath}/fooddiary/" class="btn btn-primary">
                        <i class="fas fa-plus me-2"></i>오늘 기록하기
                    </a>
                    <a href="${pageContext.request.contextPath}/fooddiary/stats" class="btn btn-outline-primary ms-2">
                        <i class="fas fa-chart-bar me-2"></i>상세 통계
                    </a>
                </div>
            </div>
        </div>
        
        <div class="row">
            <!-- 메인 캘린더 -->
            <div class="col-lg-9">
                <div class="calendar-table">
                    <table class="table table-bordered mb-0">
                        <thead>
                            <tr>
                                <th>일</th>
                                <th>월</th>
                                <th>화</th>
                                <th>수</th>
                                <th>목</th>
                                <th>금</th>
                                <th>토</th>
                            </tr>
                        </thead>
                        <tbody id="calendarBody">
                            <!-- JavaScript로 동적 생성 -->
                        </tbody>
                    </table>
                </div>
            </div>
            
            <!-- 사이드바 -->
            <div class="col-lg-3">
                <!-- 범례 -->
                <div class="legend">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-info-circle me-2"></i>범례
                    </h6>
                    
                    <div class="legend-item">
                        <div class="legend-dot" style="background: #ffc107;"></div>
                        <small>아침</small>
                    </div>
                    <div class="legend-item">
                        <div class="legend-dot" style="background: #28a745;"></div>
                        <small>점심</small>
                    </div>
                    <div class="legend-item">
                        <div class="legend-dot" style="background: #FF6A00;"></div>
                        <small>저녁</small>
                    </div>
                    <div class="legend-item">
                        <div class="legend-dot" style="background: #17a2b8;"></div>
                        <small>간식</small>
                    </div>
                    
                    <hr class="my-3">
                    
                    <div class="mb-2">
                        <div class="calorie-info good-range d-inline-block">적정 범위</div>
                        <small class="ms-2">목표의 80-120%</small>
                    </div>
                    <div class="mb-2">
                        <div class="calorie-info under-target d-inline-block">부족</div>
                        <small class="ms-2">목표의 80% 미만</small>
                    </div>
                    <div class="mb-2">
                        <div class="calorie-info over-target d-inline-block">초과</div>
                        <small class="ms-2">목표의 120% 이상</small>
                    </div>
                </div>
                
                <!-- 월간 요약 -->
                <div class="summary-card">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-calendar-check me-2"></i>이번 달 요약
                    </h6>
                    
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span>기록 일수</span>
                            <strong class="text-primary" id="monthlyRecordDays">-</strong>
                        </div>
                        <div class="progress" style="height: 6px;">
                            <div class="progress-bar bg-primary" id="recordProgress" style="width: 0%"></div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <span class="small">평균 칼로리</span>
                            <span class="small" id="averageCalories">-</span>
                        </div>
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <span class="small">목표 달성일</span>
                            <span class="small" id="targetAchievedDays">-</span>
                        </div>
                    </div>
                    
                    <div class="text-center">
                        <div class="small text-muted mb-2">건강 점수</div>
                        <div class="h4 fw-bold text-success" id="healthScore">-</div>
                    </div>
                </div>
                
                <!-- 빠른 액션 -->
                <div class="summary-card">
                    <h6 class="fw-bold mb-3">바로가기</h6>
                    <div class="d-grid gap-2">
                        <button class="btn btn-outline-primary btn-sm" onclick="goToToday()">
                            <i class="fas fa-calendar-day me-2"></i>오늘로 이동
                        </button>
                        <button class="btn btn-outline-success btn-sm" onclick="exportCalendar()">
                            <i class="fas fa-download me-2"></i>캘린더 내보내기
                        </button>
                        <a href="${pageContext.request.contextPath}/fooddiary/search" class="btn btn-outline-info btn-sm">
                            <i class="fas fa-search me-2"></i>음식 검색
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 날짜별 상세보기 모달 -->
    <div class="modal fade" id="dateDetailModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalDateTitle">2024년 1월 1일 식단</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="modalContent">
                    <!-- 동적으로 로드됩니다 -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" onclick="goToDate()">이 날짜로 이동</button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let currentYear = new Date().getFullYear();
        let currentMonth = new Date().getMonth();
        let selectedDate = null;
        
        // 서버에서 전달받은 월간 통계 데이터
        let monthlyData = ${monthlyStats != null ? monthlyStats : "[]"};
        
        document.addEventListener('DOMContentLoaded', function() {
            // URL에서 년월 파라미터 확인
            const urlParams = new URLSearchParams(window.location.search);
            const yearMonth = urlParams.get('yearMonth');
            
            if (yearMonth) {
                const [year, month] = yearMonth.split('-');
                currentYear = parseInt(year);
                currentMonth = parseInt(month) - 1; // JavaScript는 0부터 시작
            }
            
            renderCalendar();
            updateMonthlySummary();
        });
        
        function renderCalendar() {
            const firstDay = new Date(currentYear, currentMonth, 1);
            const lastDay = new Date(currentYear, currentMonth + 1, 0);
            const startDate = new Date(firstDay);
            startDate.setDate(startDate.getDate() - firstDay.getDay()); // 일요일부터 시작
            
            const calendarBody = document.getElementById('calendarBody');
            calendarBody.innerHTML = '';
            
            // 월 표시 업데이트
            document.getElementById('currentMonthYear').textContent = 
                `${currentYear}년 ${currentMonth + 1}월`;
            
            for (let week = 0; week < 6; week++) {
                const row = document.createElement('tr');
                
                for (let day = 0; day < 7; day++) {
                    const cellDate = new Date(startDate);
                    cellDate.setDate(startDate.getDate() + (week * 7) + day);
                    
                    const cell = document.createElement('td');
                    cell.onclick = () => showDateDetail(cellDate);
                    
                    const dateDiv = document.createElement('div');
                    dateDiv.className = 'calendar-date';
                    
                    if (cellDate.getMonth() !== currentMonth) {
                        dateDiv.className += ' other-month';
                    }
                    
                    if (isToday(cellDate)) {
                        dateDiv.className += ' today';
                    }
                    
                    dateDiv.textContent = cellDate.getDate();
                    cell.appendChild(dateDiv);
                    
                    // 해당 날짜의 데이터 찾기
                    const dateStr = formatDate(cellDate);
                    const dayData = findDayData(dateStr);
                    
                    if (dayData && cellDate.getMonth() === currentMonth) {
                        // 칼로리 정보 추가
                        const calorieDiv = document.createElement('div');
                        calorieDiv.className = 'calorie-info';
                        calorieDiv.textContent = `${dayData.totalCalories}kcal`;
                        
                        // 목표 대비 상태에 따른 스타일링
                        const targetCalories = 2000; // 기본값, 실제로는 사용자 설정값 사용
                        const ratio = dayData.totalCalories / targetCalories;
                        
                        if (ratio >= 0.8 && ratio <= 1.2) {
                            calorieDiv.className += ' good-range';
                        } else if (ratio < 0.8) {
                            calorieDiv.className += ' under-target';
                        } else {
                            calorieDiv.className += ' over-target';
                        }
                        
                        cell.appendChild(calorieDiv);
                        
                        // 식사별 점 표시
                        if (dayData.mealTypes) {
                            const dotsDiv = document.createElement('div');
                            dotsDiv.className = 'meal-dots';
                            
                            dayData.mealTypes.forEach(mealType => {
                                const dot = document.createElement('div');
                                dot.className = `meal-dot ${getMealClass(mealType)}`;
                                dotsDiv.appendChild(dot);
                            });
                            
                            cell.appendChild(dotsDiv);
                        }
                    }
                    
                    row.appendChild(cell);
                }
                
                calendarBody.appendChild(row);
            }
        }
        
        function findDayData(dateStr) {
            // monthlyData에서 해당 날짜 찾기
            // 실제 구현에서는 서버에서 받은 데이터 구조에 맞게 조정
            return monthlyData.find(data => data.recordDate === dateStr);
        }
        
        function getMealClass(mealType) {
            const mealClasses = {
                '아침': 'breakfast',
                '점심': 'lunch', 
                '저녁': 'dinner',
                '간식': 'snack'
            };
            return mealClasses[mealType] || '';
        }
        
        function isToday(date) {
            const today = new Date();
            return date.getDate() === today.getDate() &&
                   date.getMonth() === today.getMonth() &&
                   date.getFullYear() === today.getFullYear();
        }
        
        function formatDate(date) {
            return date.getFullYear() + '-' + 
                   String(date.getMonth() + 1).padStart(2, '0') + '-' +
                   String(date.getDate()).padStart(2, '0');
        }
        
        function changeMonth(delta) {
            currentMonth += delta;
            if (currentMonth < 0) {
                currentMonth = 11;
                currentYear--;
            } else if (currentMonth > 11) {
                currentMonth = 0;
                currentYear++;
            }
            
            // 새로운 월 데이터를 서버에서 로드
            const yearMonth = `${currentYear}-${String(currentMonth + 1).padStart(2, '0')}`;
            window.location.href = `${pageContext.request.contextPath}/fooddiary/calendar?yearMonth=${yearMonth}`;
        }
        
        function showDateDetail(date) {
            selectedDate = date;
            const dateStr = formatDate(date);
            
            document.getElementById('modalDateTitle').textContent = 
                `${date.getFullYear()}년 ${date.getMonth() + 1}월 ${date.getDate()}일 식단`;
            
            // AJAX로 해당 날짜의 상세 데이터 로드
            fetch(`${pageContext.request.contextPath}/fooddiary/api/daily/${dateStr}`)
                .then(response => response.json())
                .then(data => {
                    displayDateDetail(data);
                })
                .catch(error => {
                    document.getElementById('modalContent').innerHTML = 
                        '<div class="text-center py-4"><p class="text-muted">데이터를 불러올 수 없습니다.</p></div>';
                });
            
            new bootstrap.Modal(document.getElementById('dateDetailModal')).show();
        }
        
        function displayDateDetail(data) {
            const modalContent = document.getElementById('modalContent');
            
            if (!data || !data.meals || data.meals.length === 0) {
                modalContent.innerHTML = `
                    <div class="text-center py-4">
                        <i class="fas fa-utensils fa-3x text-muted mb-3"></i>
                        <p class="text-muted">이 날의 식단 기록이 없습니다.</p>
                        <button class="btn btn-primary" onclick="goToDate()">
                            이 날짜에 기록하기
                        </button>
                    </div>
                `;
                return;
            }
            
            let html = '';
            
            // 일일 통계
            html += `
                <div class="row mb-4">
                    <div class="col-md-3 text-center">
                        <div class="h5 text-primary">${data.totalCalories || 0}</div>
                        <small class="text-muted">총 칼로리</small>
                    </div>
                    <div class="col-md-3 text-center">
                        <div class="h6">${data.totalProtein || 0}g</div>
                        <small class="text-muted">단백질</small>
                    </div>
                    <div class="col-md-3 text-center">
                        <div class="h6">${data.totalCarbs || 0}g</div>
                        <small class="text-muted">탄수화물</small>
                    </div>
                    <div class="col-md-3 text-center">
                        <div class="h6">${data.totalFat || 0}g</div>
                        <small class="text-muted">지방</small>
                    </div>
                </div>
            `;
            
            // 식사별 상세 내역
            const mealGroups = data.mealGroups || {};
            const mealTypes = ['아침', '점심', '저녁', '간식'];
            
            mealTypes.forEach(mealType => {
                if (mealGroups[mealType] && mealGroups[mealType].length > 0) {
                    html += `
                        <div class="mb-3">
                            <h6 class="fw-bold border-bottom pb-2">${mealType}</h6>
                    `;
                    
                    mealGroups[mealType].forEach(food => {
                        html += `
                            <div class="d-flex justify-content-between align-items-center py-2">
                                <div>
                                    <strong>${food.foodName}</strong>
                                    <small class="text-muted ms-2">${food.amountGrams}g</small>
                                </div>
                                <div class="text-end">
                                    <strong class="text-primary">${food.caloriesConsumed}kcal</strong>
                                    <div class="small text-muted">
                                        P ${food.proteinConsumed}g · 
                                        C ${food.carbsConsumed}g · 
                                        F ${food.fatConsumed}g
                                    </div>
                                </div>
                            </div>
                        `;
                    });
                    
                    html += '</div>';
                }
            });
            
            modalContent.innerHTML = html;
        }
        
        function goToDate() {
            if (selectedDate) {
                const dateStr = formatDate(selectedDate);
                window.location.href = `${pageContext.request.contextPath}/fooddiary/logs/${dateStr}`;
            }
        }
        
        function goToToday() {
            const today = new Date();
            currentYear = today.getFullYear();
            currentMonth = today.getMonth();
            renderCalendar();
        }
        
        function exportCalendar() {
            // 캘린더 내보내기 기능 (CSV 형태로 구현 가능)
            alert('캘린더 내보내기 기능은 준비 중입니다.');
        }
        
        function updateMonthlySummary() {
            // 월간 요약 정보 업데이트
            let recordDays = 0;
            let totalCalories = 0;
            let targetAchieved = 0;
            
            monthlyData.forEach(data => {
                if (data && data.totalCalories > 0) {
                    recordDays++;
                    totalCalories += data.totalCalories;
                    
                    const targetCalories = 2000; // 실제로는 사용자 설정값
                    if (data.totalCalories >= targetCalories * 0.8 && 
                        data.totalCalories <= targetCalories * 1.2) {
                        targetAchieved++;
                    }
                }
            });
            
            document.getElementById('monthlyRecordDays').textContent = recordDays + '일';
            document.getElementById('recordProgress').style.width = (recordDays / 31 * 100) + '%';
            
            const avgCalories = recordDays > 0 ? Math.round(totalCalories / recordDays) : 0;
            document.getElementById('averageCalories').textContent = avgCalories + 'kcal';
            document.getElementById('targetAchievedDays').textContent = targetAchieved + '일';
            
            // 건강 점수 계산 (간단한 공식)
            const healthScore = Math.min(100, 
                (recordDays * 2) + (targetAchieved * 3) + (recordDays > 20 ? 20 : 0));
            document.getElementById('healthScore').textContent = healthScore + '점';
        }
    </script>
</body>
</html>