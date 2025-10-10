<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>식습관 분석 - 푸드다이어리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #007bff;
            --secondary-color: #F4ECDC;
            --text-color: #0F172A;
            --muted-color: #5B6170;
            --border-color: #E7E0D6;
            --brand: #FF6A00;
            --hover: #FFF5EA;
            --radius: 14px;
        }
        
        /* 통일된 헤더 스타일 */
        .page-header {
            background: linear-gradient(135deg, var(--primary-color), #0056b3);
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
            background: white;
            border-radius: var(--radius);
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            height: 100%;
        }
        
        .metric-card {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            padding: 20px;
            text-align: center;
            transition: transform 0.2s;
        }
        
        .metric-card:hover {
            transform: translateY(-2px);
        }
        
        .health-score-big {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border-radius: var(--radius);
            padding: 30px;
            text-align: center;
            margin-bottom: 25px;
        }
        
        .chart-container {
            position: relative;
            height: 300px;
            margin: 20px 0;
        }
        
        .progress-ring {
            width: 120px;
            height: 120px;
            margin: 0 auto;
        }
        
        .encouragement-box {
            background: var(--secondary-color);
            border-radius: var(--radius);
            padding: 20px;
            text-align: center;
            margin-bottom: 25px;
        }
        
        .category-stat {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid var(--border-color);
        }
        
        .category-stat:last-child {
            border-bottom: none;
        }
        
        .meal-distribution {
            display: flex;
            justify-content: space-around;
            text-align: center;
            margin: 20px 0;
        }
        
        .meal-item {
            flex: 1;
            padding: 15px;
            background: var(--hover);
            border-radius: 8px;
            margin: 0 5px;
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
    <jsp:include page="../common/header.jsp" />
    
    <!-- 통일된 페이지 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">홈</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/fooddiary/">푸드다이어리</a></li>
                    <li class="breadcrumb-item active">식습관 분석</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-6 fw-bold mb-3">식습관 분석</h1>
                    <p class="lead mb-0">지금까지의 기록을 분석해서 건강한 패턴을 찾아보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="health-score-big">
                        <div class="display-4 fw-bold mb-2">${healthScore.totalScore}점</div>
                        <p class="mb-2">건강 점수</p>
                        <small>${healthScore.message}</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 격려 메시지 -->
        <div class="encouragement-box">
            <i class="fas fa-heart text-danger fa-2x mb-3"></i>
            <h5 class="fw-bold mb-2">꾸준한 기록이 건강의 시작입니다</h5>
            <p class="mb-0 text-muted">${healthScore.message}</p>
        </div>
        
        <!-- 주요 지표 -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="metric-card">
                    <i class="fas fa-calendar-check text-primary fa-2x mb-3"></i>
                    <h4 class="fw-bold">${totalStats.totalDays}</h4>
                    <p class="text-muted mb-0">총 기록일</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="metric-card">
                    <i class="fas fa-fire text-danger fa-2x mb-3"></i>
                    <h4 class="fw-bold">${monthlyAvg}</h4>
                    <p class="text-muted mb-0">월평균 칼로리</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="metric-card">
                    <i class="fas fa-utensils text-success fa-2x mb-3"></i>
                    <h4 class="fw-bold">${totalStats.totalRecords}</h4>
                    <p class="text-muted mb-0">총 기록 건수</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="metric-card">
                    <i class="fas fa-medal text-warning fa-2x mb-3"></i>
                    <h4 class="fw-bold">${totalStats.maxConsecutiveDays}</h4>
                    <p class="text-muted mb-0">연속 기록일</p>
                </div>
            </div>
        </div>
        
        <div class="row">
            <!-- 왼쪽 컬럼 -->
            <div class="col-lg-8">
                <!-- 주간 칼로리 추이 -->
                <div class="stats-card">
                    <h5 class="fw-bold mb-4">
                        <i class="fas fa-chart-line me-2"></i>주간 칼로리 추이
                    </h5>
                    <div class="chart-container">
                        <canvas id="weeklyChart"></canvas>
                    </div>
                    <p class="text-muted text-center small">
                        꾸준한 기록으로 패턴을 파악해보세요. 목표 칼로리에 가까울수록 좋습니다.
                    </p>
                </div>
                
                <!-- 카테고리별 섭취 현황 -->
                <div class="stats-card">
                    <h5 class="fw-bold mb-4">
                        <i class="fas fa-chart-pie me-2"></i>음식 카테고리별 분석 (최근 30일)
                    </h5>
                    
                    <div class="row">
                        <div class="col-md-6">
                            <div class="chart-container">
                                <canvas id="categoryChart"></canvas>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <c:choose>
                                <c:when test="${not empty categoryStats}">
                                    <c:forEach var="stat" items="${categoryStats}">
                                        <div class="category-stat">
                                            <div>
                                                <strong>${stat.category}</strong>
                                                <div class="small text-muted">${stat.recordCount}회 기록</div>
                                            </div>
                                            <div class="text-end">
                                                <strong class="text-primary">${stat.totalCalories}kcal</strong>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-4">
                                        <i class="fas fa-info-circle text-muted fa-2x mb-2"></i>
                                        <p class="text-muted">아직 분석할 데이터가 충분하지 않습니다</p>
                                        <small class="text-muted">더 많은 음식을 기록해보세요</small>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="mt-3 p-3 bg-light rounded">
                        <small class="text-muted">
                            <i class="fas fa-lightbulb me-1"></i>
                            <strong>팁:</strong> 다양한 카테고리의 음식을 골고루 섭취하면 균형 잡힌 영양을 얻을 수 있습니다.
                        </small>
                    </div>
                </div>
                
                <!-- 식사별 칼로리 분포 -->
                <div class="stats-card">
                    <h5 class="fw-bold mb-4">
                        <i class="fas fa-clock me-2"></i>식사별 칼로리 분포 (최근 7일)
                    </h5>
                    
                    <c:choose>
                        <c:when test="${not empty mealDistribution}">
                            <div class="meal-distribution">
                                <c:forEach var="meal" items="${mealDistribution}">
                                    <div class="meal-item">
                                        <div class="fw-bold text-primary">${meal.totalCalories}kcal</div>
                                        <div class="small text-muted">${meal.mealType}</div>
                                        <div class="small text-muted">평균 ${meal.avgCalories}kcal</div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <div class="chart-container">
                                <canvas id="mealChart"></canvas>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-4">
                                <i class="fas fa-utensils text-muted fa-2x mb-2"></i>
                                <p class="text-muted">최근 7일 식사 기록이 없습니다</p>
                                <small class="text-muted">규칙적인 식사를 기록해보세요</small>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <!-- 오른쪽 사이드바 -->
            <div class="col-lg-4">
                <!-- 건강 점수 상세 -->
                <div class="stats-card">
                    <h5 class="fw-bold mb-4">
                        <i class="fas fa-trophy me-2"></i>건강 점수 상세
                    </h5>
                    
                    <div class="text-center mb-4">
                        <div class="progress-ring">
                            <svg width="120" height="120">
                                <circle cx="60" cy="60" r="50" stroke="#e9ecef" stroke-width="10" fill="transparent"/>
                                <circle cx="60" cy="60" r="50" stroke="#28a745" stroke-width="10" fill="transparent"
                                        stroke-dasharray="${314 * healthScore.totalScore / 100} 314"
                                        stroke-linecap="round" transform="rotate(-90 60 60)"/>
                            </svg>
                            <div class="position-absolute top-50 start-50 translate-middle text-center">
                                <div class="h3 fw-bold text-success">${healthScore.totalScore}</div>
                                <small class="text-muted">/ 100점</small>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="small">꾸준한 기록</span>
                            <span class="badge bg-primary">${healthScore.recordScore}/30점</span>
                        </div>
                        <div class="progress" style="height: 6px;">
                            <div class="progress-bar bg-primary" style="width: ${healthScore.recordScore * 100 / 30}%"></div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="small">적정 칼로리</span>
                            <span class="badge bg-success">${healthScore.calorieScore}/40점</span>
                        </div>
                        <div class="progress" style="height: 6px;">
                            <div class="progress-bar bg-success" style="width: ${healthScore.calorieScore * 100 / 40}%"></div>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="small">다양한 섭취</span>
                            <span class="badge bg-warning">${healthScore.varietyScore}/30점</span>
                        </div>
                        <div class="progress" style="height: 6px;">
                            <div class="progress-bar bg-warning" style="width: ${healthScore.varietyScore * 100 / 30}%"></div>
                        </div>
                    </div>
                    
                    <div class="text-center">
                        <p class="small text-muted mb-3">
                            ${healthScore.message}
                        </p>
                        <a href="${pageContext.request.contextPath}/fooddiary/" class="btn btn-primary btn-sm">
                            오늘 기록하기
                        </a>
                    </div>
                </div>
                
                <!-- 목표 달성률 -->
                <div class="stats-card">
                    <h5 class="fw-bold mb-4">
                        <i class="fas fa-target me-2"></i>이번 주 목표 달성
                    </h5>
                    
                    <div class="text-center mb-3">
                        <div class="h4 fw-bold text-primary">${healthScore.recordDays}/7일</div>
                        <p class="text-muted mb-3">기록 완료</p>
                        
                        <div class="progress mb-3" style="height: 12px;">
                            <div class="progress-bar bg-primary" role="progressbar" 
                                 style="width: ${healthScore.recordDays * 100 / 7}%"></div>
                        </div>
                    </div>
                    
                    <c:choose>
                        <c:when test="${healthScore.recordDays >= 5}">
                            <div class="alert alert-success text-center">
                                <i class="fas fa-check-circle me-2"></i>
                                훌륭해요! 꾸준히 기록하고 계시네요.
                            </div>
                        </c:when>
                        <c:when test="${healthScore.recordDays >= 3}">
                            <div class="alert alert-info text-center">
                                <i class="fas fa-thumbs-up me-2"></i>
                                좋은 시작이에요. 조금 더 꾸준히 해보세요!
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-light text-center">
                                <i class="fas fa-heart me-2"></i>
                                천천히 시작해보세요. 작은 기록도 소중합니다.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- 추천 행동 -->
                <div class="stats-card">
                    <h5 class="fw-bold mb-4">
                        <i class="fas fa-lightbulb me-2"></i>개선 제안
                    </h5>
                    
                    <div class="list-group list-group-flush">
                        <c:choose>
                            <c:when test="${healthScore.recordDays < 3}">
                                <div class="list-group-item border-0 px-0">
                                    <i class="fas fa-calendar-plus text-primary me-2"></i>
                                    <small>매일 조금씩이라도 기록해보세요</small>
                                </div>
                            </c:when>
                            <c:when test="${empty categoryStats or categoryStats.size() < 3}">
                                <div class="list-group-item border-0 px-0">
                                    <i class="fas fa-apple-alt text-success me-2"></i>
                                    <small>다양한 종류의 음식을 드셔보세요</small>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="list-group-item border-0 px-0">
                                    <i class="fas fa-star text-warning me-2"></i>
                                    <small>현재 패턴을 잘 유지하고 계세요!</small>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="list-group-item border-0 px-0">
                            <i class="fas fa-water text-info me-2"></i>
                            <small>충분한 수분 섭취도 잊지 마세요</small>
                        </div>
                        
                        <div class="list-group-item border-0 px-0">
                            <i class="fas fa-moon text-secondary me-2"></i>
                            <small>규칙적인 식사 시간을 지켜보세요</small>
                        </div>
                    </div>
                    
                    <div class="text-center mt-3">
                        <a href="${pageContext.request.contextPath}/fooddiary/profile" 
                           class="btn btn-outline-primary btn-sm">
                            목표 재설정
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            initCharts();
        });
        
        function initCharts() {
            // 주간 칼로리 차트
            const weeklyCtx = document.getElementById('weeklyChart');
            if (weeklyCtx) {
                const weeklyData = [
                    <c:forEach var="stat" items="${weeklyStats}" varStatus="status">
                        ${stat.totalCalories}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];
                
                const labels = ['월', '화', '수', '목', '금', '토', '일'];
                
                new Chart(weeklyCtx, {
                    type: 'line',
                    data: {
                        labels: labels.slice(-weeklyData.length),
                        datasets: [{
                            label: '섭취 칼로리',
                            data: weeklyData,
                            borderColor: '#007bff',
                            backgroundColor: 'rgba(0, 123, 255, 0.1)',
                            tension: 0.4,
                            fill: true,
                            pointBackgroundColor: '#007bff',
                            pointBorderColor: '#ffffff',
                            pointBorderWidth: 2,
                            pointRadius: 6
                        }, {
                            label: '목표 칼로리',
                            data: new Array(weeklyData.length).fill(2000), // 기본 목표값
                            borderColor: '#28a745',
                            borderDash: [5, 5],
                            pointRadius: 0,
                            fill: false
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom'
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) {
                                        return value + 'kcal';
                                    }
                                }
                            }
                        }
                    }
                });
            }
            
            // 카테고리별 파이차트
            const categoryCtx = document.getElementById('categoryChart');
            if (categoryCtx && ${not empty categoryStats}) {
                const categoryLabels = [
                    <c:forEach var="stat" items="${categoryStats}" varStatus="status">
                        '${stat.category}'<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];
                
                const categoryData = [
                    <c:forEach var="stat" items="${categoryStats}" varStatus="status">
                        ${stat.totalCalories}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];
                
                const colors = [
                    '#007bff', '#28a745', '#ffc107', '#17a2b8', 
                    '#dc3545', '#6f42c1', '#fd7e14', '#20c997'
                ];
                
                new Chart(categoryCtx, {
                    type: 'doughnut',
                    data: {
                        labels: categoryLabels,
                        datasets: [{
                            data: categoryData,
                            backgroundColor: colors.slice(0, categoryLabels.length),
                            borderWidth: 2,
                            borderColor: '#ffffff'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom'
                            }
                        }
                    }
                });
            }
            
            // 식사별 칼로리 차트
            const mealCtx = document.getElementById('mealChart');
            if (mealCtx && ${not empty mealDistribution}) {
                const mealLabels = [
                    <c:forEach var="meal" items="${mealDistribution}" varStatus="status">
                        '${meal.mealType}'<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];
                
                const mealData = [
                    <c:forEach var="meal" items="${mealDistribution}" varStatus="status">
                        ${meal.totalCalories}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];
                
                new Chart(mealCtx, {
                    type: 'bar',
                    data: {
                        labels: mealLabels,
                        datasets: [{
                            label: '총 칼로리',
                            data: mealData,
                            backgroundColor: [
                                'rgba(255, 193, 7, 0.8)',   // 아침 - 노란색
                                'rgba(40, 167, 69, 0.8)',   // 점심 - 초록색  
                                'rgba(0, 123, 255, 0.8)',   // 저녁 - 파란색
                                'rgba(23, 162, 184, 0.8)'   // 간식 - 청록색
                            ],
                            borderColor: [
                                '#ffc107', '#28a745', '#007bff', '#17a2b8'
                            ],
                            borderWidth: 2,
                            borderRadius: 8
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: function(value) {
                                        return value + 'kcal';
                                    }
                                }
                            }
                        }
                    }
                });
            }
        }
    </script>
</body>
</html>