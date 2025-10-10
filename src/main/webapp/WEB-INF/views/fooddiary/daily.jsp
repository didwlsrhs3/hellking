<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>일별 상세 기록 - 푸드다이어리</title>
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
        
        .date-navigation {
            background: white;
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }
        
        .date-nav-btn {
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
        
        .date-nav-btn:hover {
            background: #0056b3;
            transform: scale(1.1);
        }
        
        .daily-summary {
            background: white;
            border-radius: var(--radius);
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }
        
        .calorie-progress {
            position: relative;
            width: 150px;
            height: 150px;
            margin: 0 auto;
        }
        
        .progress-ring {
            width: 150px;
            height: 150px;
        }
        
        .progress-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }
        
        .meal-section {
            background: white;
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
        }
        
        .meal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--border-color);
        }
        
        .food-item {
            background: var(--hover);
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 10px;
            transition: all 0.2s;
            border-left: 4px solid transparent;
        }
        
        .food-item:hover {
            background: var(--border-color);
            border-left-color: var(--primary-color);
        }
        
        .food-item.highlighted {
            background: #fff3e0;
            border-left-color: var(--brand);
            box-shadow: 0 2px 8px rgba(255, 106, 0, 0.2);
        }
        
        .macro-chart {
            background: white;
            border-radius: var(--radius);
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }
        
        .macro-bar {
            height: 20px;
            border-radius: 10px;
            overflow: hidden;
            background: var(--border-color);
            margin-bottom: 10px;
        }
        
        .macro-segment {
            height: 100%;
            float: left;
            transition: width 0.5s ease;
        }
        
        .protein-segment { background: #2196f3; }
        .carbs-segment { background: #4caf50; }
        .fat-segment { background: #ff9800; }
        
        .empty-day {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted-color);
        }
        
        .nutrition-breakdown {
            background: var(--secondary-color);
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 25px;
        }
        
        .stat-card {
            background: white;
            border-radius: var(--radius);
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            transition: transform 0.2s;
        }
        
        .stat-card:hover {
            transform: translateY(-2px);
        }
        
        .timeline-item {
            position: relative;
            padding-left: 30px;
            margin-bottom: 20px;
        }
        
        .timeline-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 8px;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--primary-color);
        }
        
        .timeline-item::after {
            content: '';
            position: absolute;
            left: 5px;
            top: 20px;
            width: 2px;
            height: calc(100% + 10px);
            background: var(--border-color);
        }
        
        .timeline-item:last-child::after {
            display: none;
        }
        
        .meal-time {
            font-size: 12px;
            color: var(--muted-color);
            margin-bottom: 5px;
        }
        
        .quick-actions {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 1000;
        }
        
        .action-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: none;
            color: white;
            margin-bottom: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.3);
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .action-btn:hover {
            transform: scale(1.1);
        }
        
        .add-food-btn {
            background: var(--brand);
        }
        
        .copy-day-btn {
            background: #6c757d;
        }
        
        .analysis-insight {
            background: linear-gradient(135deg, #e3f2fd, #f3e5f5);
            border-left: 4px solid var(--primary-color);
            border-radius: 0 var(--radius) var(--radius) 0;
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .day-comparison {
            background: white;
            border-radius: var(--radius);
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
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
                    <li class="breadcrumb-item active">일별 상세</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-6 fw-bold mb-3">
                        <fmt:formatDate value="${recordDate}" pattern="M월 d일" />
                        <c:choose>
                            <c:when test="${recordDate != null}">
                                <fmt:formatDate value="${recordDate}" pattern="(E)" />
                            </c:when>
                            <c:otherwise>(오늘)</c:otherwise>
                        </c:choose>
                        식단
                    </h1>
                    <p class="lead mb-0">하루 동안의 자세한 식단 기록을 확인하고 분석해보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="text-white">
                        <div class="h4 mb-1">${stats.totalCalories != null ? stats.totalCalories : 0}kcal</div>
                        <div class="small opacity-75">총 섭취 칼로리</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 날짜 네비게이션 -->
        <div class="date-navigation">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="d-flex align-items-center">
                        <button class="date-nav-btn me-3" onclick="changeDate(-1)">
                            <i class="fas fa-chevron-left"></i>
                        </button>
                        
                        <div>
                            <h4 class="mb-0">
                                <fmt:formatDate value="${recordDate}" pattern="yyyy년 M월 d일" />
                            </h4>
                            <small class="text-muted">
                                <fmt:formatDate value="${recordDate}" pattern="EEEE" />
                            </small>
                        </div>
                        
                        <button class="date-nav-btn ms-3" onclick="changeDate(1)">
                            <i class="fas fa-chevron-right"></i>
                        </button>
                    </div>
                </div>
                
                <div class="col-md-6 text-end">
                    <button class="btn btn-outline-primary me-2" onclick="goToToday()">
                        <i class="fas fa-calendar-day me-2"></i>오늘로
                    </button>
                    <button class="btn btn-primary" onclick="addFood()">
                        <i class="fas fa-plus me-2"></i>음식 추가
                    </button>
                </div>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${not empty mealGroups and (not empty mealGroups['아침'] or not empty mealGroups['점심'] or not empty mealGroups['저녁'] or not empty mealGroups['간식'] or not empty mealGroups['기타'])}">
                
                <div class="row">
                    <!-- 메인 컨텐츠 -->
                    <div class="col-lg-8">
                        <!-- 일일 요약 -->
                        <div class="daily-summary">
                            <div class="row">
                                <div class="col-md-4 text-center">
                                    <div class="calorie-progress">
                                        <svg class="progress-ring" width="150" height="150">
                                            <circle cx="75" cy="75" r="65" stroke="#E7E0D6" stroke-width="8" fill="transparent"/>
                                            <circle cx="75" cy="75" r="65" stroke="#007bff" stroke-width="8" fill="transparent"
                                                    stroke-dasharray="${408 * (stats.caloriesAchievementPercent != null ? stats.caloriesAchievementPercent : 0) / 100} 408"
                                                    stroke-linecap="round" transform="rotate(-90 75 75)"/>
                                        </svg>
                                        <div class="progress-text">
                                            <div class="h4 fw-bold text-primary">${stats.totalCalories != null ? stats.totalCalories : 0}</div>
                                            <small class="text-muted">/ ${stats.targetCalories != null ? stats.targetCalories : 2000}kcal</small>
                                            <div class="small text-success mt-1">${stats.caloriesAchievementPercent != null ? stats.caloriesAchievementPercent : 0}%</div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-8">
                                    <div class="row">
                                        <div class="col-4">
                                            <div class="stat-card">
                                                <div class="h5 text-primary mb-1">${stats.totalProtein != null ? stats.totalProtein : 0}g</div>
                                                <small class="text-muted">단백질</small>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="stat-card">
                                                <div class="h5 text-success mb-1">${stats.totalCarbs != null ? stats.totalCarbs : 0}g</div>
                                                <small class="text-muted">탄수화물</small>
                                            </div>
                                        </div>
                                        <div class="col-4">
                                            <div class="stat-card">
                                                <div class="h5 text-warning mb-1">${stats.totalFat != null ? stats.totalFat : 0}g</div>
                                                <small class="text-muted">지방</small>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="mt-4">
                                        <h6 class="text-muted mb-3">영양소 구성비</h6>
                                        <div class="macro-bar">
                                            <div class="macro-segment protein-segment" style="width: ${stats.macroRatio.proteinPercent != null ? stats.macroRatio.proteinPercent : 0}%"></div>
                                            <div class="macro-segment carbs-segment" style="width: ${stats.macroRatio.carbsPercent != null ? stats.macroRatio.carbsPercent : 0}%"></div>
                                            <div class="macro-segment fat-segment" style="width: ${stats.macroRatio.fatPercent != null ? stats.macroRatio.fatPercent : 0}%"></div>
                                        </div>
                                        <div class="d-flex justify-content-between small text-muted">
                                            <span><i class="fas fa-square text-primary me-1"></i>단백질 ${stats.macroRatio.proteinPercent != null ? stats.macroRatio.proteinPercent : 0}%</span>
                                            <span><i class="fas fa-square text-success me-1"></i>탄수화물 ${stats.macroRatio.carbsPercent != null ? stats.macroRatio.carbsPercent : 0}%</span>
                                            <span><i class="fas fa-square text-warning me-1"></i>지방 ${stats.macroRatio.fatPercent != null ? stats.macroRatio.fatPercent : 0}%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- 식사별 상세 기록 -->
                        <c:forEach var="mealType" items="아침,점심,저녁,간식,기타" varStatus="status">
                            <c:if test="${not empty mealGroups[mealType]}">
                                <div class="meal-section">
                                    <div class="meal-header">
                                        <div class="d-flex align-items-center flex-grow-1">
                                            <c:choose>
                                                <c:when test="${mealType == '아침'}">
                                                    <i class="fas fa-sun me-2 text-warning"></i>
                                                </c:when>
                                                <c:when test="${mealType == '점심'}">
                                                    <i class="fas fa-sun me-2 text-success"></i>
                                                </c:when>
                                                <c:when test="${mealType == '저녁'}">
                                                    <i class="fas fa-moon me-2 text-primary"></i>
                                                </c:when>
                                                <c:when test="${mealType == '간식'}">
                                                    <i class="fas fa-cookie-bite me-2 text-info"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-utensils me-2 text-secondary"></i>
                                                </c:otherwise>
                                            </c:choose>
                                            <h5 class="mb-0">${mealType}</h5>
                                            <span class="ms-3 badge bg-light text-dark">
                                                ${mealGroups[mealType].size()}개 음식
                                            </span>
                                        </div>
                                        
                                        <div class="text-end">
                                            <c:set var="mealCalories" value="0" />
                                            <c:forEach var="food" items="${mealGroups[mealType]}">
                                                <c:set var="mealCalories" value="${mealCalories + food.caloriesConsumed}" />
                                            </c:forEach>
                                            <strong class="text-primary">${mealCalories}kcal</strong>
                                        </div>
                                    </div>
                                    
                                    <!-- 타임라인 형태로 음식 표시 -->
                                    <div class="timeline">
                                        <c:forEach var="food" items="${mealGroups[mealType]}">
                                            <div class="timeline-item">
                                                <div class="meal-time">
                                                    <fmt:formatDate value="${food.createdAt}" pattern="HH:mm" />에 기록
                                                </div>
                                                <div class="food-item">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div class="flex-grow-1">
                                                            <h6 class="fw-bold mb-1">${food.foodName}</h6>
                                                            <div class="small text-muted mb-2">
                                                                ${food.category} • ${food.amountGrams}g
                                                            </div>
                                                            <div class="small">
                                                                <span class="badge bg-primary me-1">${food.caloriesConsumed}kcal</span>
                                                                <span class="text-muted">
                                                                    P ${food.proteinConsumed}g • 
                                                                    C ${food.carbsConsumed}g • 
                                                                    F ${food.fatConsumed}g
                                                                </span>
                                                            </div>
                                                        </div>
                                                        
                                                        <div class="dropdown">
                                                            <button class="btn btn-sm btn-outline-secondary" type="button" 
                                                                    data-bs-toggle="dropdown">
                                                                <i class="fas fa-ellipsis-v"></i>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <li><a class="dropdown-item" href="#" onclick="editFood(${food.foodLogNum})">
                                                                    <i class="fas fa-edit me-2"></i>수정
                                                                </a></li>
                                                                <li><a class="dropdown-item" href="#" onclick="duplicateFood(${food.foodLogNum})">
                                                                    <i class="fas fa-copy me-2"></i>복사하기
                                                                </a></li>
                                                                <li><a class="dropdown-item text-danger" href="#" onclick="deleteFood(${food.foodLogNum})">
                                                                    <i class="fas fa-trash me-2"></i>삭제
                                                                </a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                        
                    </div>
                    
                    <!-- 사이드바 -->
                    <div class="col-lg-4">
                        <!-- 일일 분석 -->
                        <div class="analysis-insight">
                            <h6 class="fw-bold mb-3">
                                <i class="fas fa-lightbulb me-2"></i>오늘의 분석
                            </h6>
                            
                            <c:choose>
                                <c:when test="${stats.isOverTarget()}">
                                    <p class="mb-2">
                                        <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                                        목표보다 ${stats.totalCalories - stats.targetCalories}kcal 초과했어요.
                                    </p>
                                    <small class="text-muted">내일은 조금 더 가볍게 드셔보세요.</small>
                                </c:when>
                                <c:when test="${stats.isUnderRecommended()}">
                                    <p class="mb-2">
                                        <i class="fas fa-info-circle text-info me-2"></i>
                                        목표보다 ${stats.targetCalories - stats.totalCalories}kcal 부족해요.
                                    </p>
                                    <small class="text-muted">충분한 영양 섭취를 위해 조금 더 드셔보세요.</small>
                                </c:when>
                                <c:otherwise>
                                    <p class="mb-2">
                                        <i class="fas fa-check-circle text-success me-2"></i>
                                        목표 칼로리 범위 내에서 잘 드셨어요!
                                    </p>
                                    <small class="text-muted">균형잡힌 식단을 유지하고 계시네요.</small>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <!-- 영양소 상세 분석 -->
                        <div class="nutrition-breakdown">
                            <h6 class="fw-bold mb-3">영양소 분석</h6>
                            
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <span class="small">단백질</span>
                                    <span class="small fw-bold">${stats.totalProtein}g</span>
                                </div>
                                <div class="progress" style="height: 6px;">
                                    <div class="progress-bar bg-primary" style="width: ${stats.macroRatio.proteinPercent}%"></div>
                                </div>
                                <small class="text-muted">전체의 ${stats.macroRatio.proteinPercent}%</small>
                            </div>
                            
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <span class="small">탄수화물</span>
                                    <span class="small fw-bold">${stats.totalCarbs}g</span>
                                </div>
                                <div class="progress" style="height: 6px;">
                                    <div class="progress-bar bg-success" style="width: ${stats.macroRatio.carbsPercent}%"></div>
                                </div>
                                <small class="text-muted">전체의 ${stats.macroRatio.carbsPercent}%</small>
                            </div>
                            
                            <div class="mb-0">
                                <div class="d-flex justify-content-between align-items-center mb-1">
                                    <span class="small">지방</span>
                                    <span class="small fw-bold">${stats.totalFat}g</span>
                                </div>
                                <div class="progress" style="height: 6px;">
                                    <div class="progress-bar bg-warning" style="width: ${stats.macroRatio.fatPercent}%"></div>
                                </div>
                                <small class="text-muted">전체의 ${stats.macroRatio.fatPercent}%</small>
                            </div>
                        </div>
                        
                        <!-- 어제/내일 비교 -->
                        <div class="day-comparison">
                            <h6 class="fw-bold mb-3">
                                <i class="fas fa-chart-line me-2"></i>기록 비교
                            </h6>
                            
                            <div class="row text-center">
                                <div class="col-6">
                                    <div class="border-end">
                                        <div class="h6 text-muted">어제</div>
                                        <div class="small text-primary">-kcal</div>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="h6 text-muted">오늘</div>
                                    <div class="small text-success">${stats.totalCalories}kcal</div>
                                </div>
                            </div>
                            
                            <div class="mt-3 text-center">
                                <small class="text-muted">어제와 비교해서 <!-- 동적으로 계산된 차이 표시 --></small>
                            </div>
                        </div>
                        
                        <!-- 빠른 작업 -->
                        <div class="stat-card">
                            <h6 class="fw-bold mb-3">빠른 작업</h6>
                            <div class="d-grid gap-2">
                                <button class="btn btn-primary btn-sm" onclick="addFood()">
                                    <i class="fas fa-plus me-2"></i>음식 추가하기
                                </button>
                                <button class="btn btn-outline-secondary btn-sm" onclick="copyToToday()">
                                    <i class="fas fa-copy me-2"></i>오늘로 복사하기
                                </button>
                                <button class="btn btn-outline-info btn-sm" onclick="shareDay()">
                                    <i class="fas fa-share me-2"></i>기록 공유하기
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                
            </c:when>
            <c:otherwise>
                <div class="empty-day">
                    <i class="fas fa-calendar-times fa-3x mb-3"></i>
                    <h4>이 날의 식단 기록이 없습니다</h4>
                    <p class="mb-4 text-muted">
                        <fmt:formatDate value="${recordDate}" pattern="M월 d일" />의 식사를 기록해보세요.<br>
                        건강한 식습관은 꾸준한 기록부터 시작됩니다.
                    </p>
                    <button class="btn btn-primary btn-lg" onclick="addFood()">
                        <i class="fas fa-plus me-2"></i>첫 번째 음식 기록하기
                    </button>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <!-- 플로팅 액션 버튼들 -->
    <div class="quick-actions">
        <button class="action-btn add-food-btn" onclick="addFood()" title="음식 추가">
            <i class="fas fa-plus"></i>
        </button>
        <button class="action-btn copy-day-btn" onclick="copyDay()" title="이 날 기록 복사">
            <i class="fas fa-copy"></i>
        </button>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        const contextPath = '${pageContext.request.contextPath}';
        const currentDate = '${recordDateStr}';
        
        function changeDate(delta) {
            const date = new Date('${recordDateStr}');
            date.setDate(date.getDate() + delta);
            
            const dateStr = date.getFullYear() + '-' + 
                           String(date.getMonth() + 1).padStart(2, '0') + '-' +
                           String(date.getDate()).padStart(2, '0');
            
            window.location.href = contextPath + '/fooddiary/logs/' + dateStr;
        }
        
        function goToToday() {
            const today = new Date();
            const dateStr = today.getFullYear() + '-' + 
                           String(today.getMonth() + 1).padStart(2, '0') + '-' +
                           String(today.getDate()).padStart(2, '0');
            
            window.location.href = contextPath + '/fooddiary/logs/' + dateStr;
        }
        
        function addFood() {
            // 해당 날짜로 음식 추가 페이지로 이동
            window.location.href = contextPath + '/fooddiary/?date=' + currentDate;
        }
        
        function editFood(foodLogNum) {
            // 음식 기록 수정 (모달로 구현하거나 별도 페이지로)
            alert('수정 기능은 준비 중입니다.');
        }
        
        function deleteFood(foodLogNum) {
            if (confirm('이 기록을 삭제하시겠습니까?')) {
                fetch(contextPath + '/fooddiary/log/' + foodLogNum, {
                    method: 'DELETE'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert(data.message || '삭제에 실패했습니다.');
                    }
                })
                .catch(error => {
                    console.error('삭제 오류:', error);
                    alert('삭제 중 오류가 발생했습니다.');
                });
            }
        }
        
        function duplicateFood(foodLogNum) {
            // 해당 음식을 오늘 날짜로 복사
            alert('복사 기능은 준비 중입니다.');
        }
        
        function copyToToday() {
            if (confirm('이 날의 모든 식단을 오늘로 복사하시겠습니까?')) {
                // 전체 식단 복사 로직
                alert('복사 기능은 준비 중입니다.');
            }
        }
        
        function copyDay() {
            if (confirm('이 날의 식단을 다른 날로 복사하시겠습니까?')) {
                // 날짜 선택 후 복사하는 기능
                alert('복사 기능은 준비 중입니다.');
            }
        }
        
        function shareDay() {
            // 기록 공유 기능 (SNS 공유, 이미지 생성 등)
            if (navigator.share) {
                navigator.share({
                    title: '푸드다이어리 - ' + '${recordDateStr}' + ' 식단',
                    text: '오늘 ${stats.totalCalories}kcal를 섭취했어요!',
                    url: window.location.href
                });
            } else {
                // 기본 공유 로직
                alert('공유 기능은 준비 중입니다.');
            }
        }
        
        // 페이지 로드 시 애니메이션 효과
        document.addEventListener('DOMContentLoaded', function() {
            // 음식 아이템들에 순차적으로 애니메이션 적용
            const foodItems = document.querySelectorAll('.food-item');
            foodItems.forEach((item, index) => {
                setTimeout(() => {
                    item.style.opacity = '0';
                    item.style.transform = 'translateY(20px)';
                    item.style.transition = 'all 0.3s ease';
                    
                    setTimeout(() => {
                        item.style.opacity = '1';
                        item.style.transform = 'translateY(0)';
                    }, 50);
                }, index * 100);
            });
        });
        
        // 키보드 단축키
        document.addEventListener('keydown', function(e) {
            if (e.target.tagName.toLowerCase() === 'input' || e.target.tagName.toLowerCase() === 'textarea') {
                return; // 입력 필드에서는 단축키 비활성화
            }
            
            switch(e.key) {
                case 'ArrowLeft':
                    e.preventDefault();
                    changeDate(-1);
                    break;
                case 'ArrowRight':
                    e.preventDefault();
                    changeDate(1);
                    break;
                case 'a':
                case 'A':
                    e.preventDefault();
                    addFood();
                    break;
                case 't':
                case 'T':
                    e.preventDefault();
                    goToToday();
                    break;
            }
        });
    </script>
</body>
</html>