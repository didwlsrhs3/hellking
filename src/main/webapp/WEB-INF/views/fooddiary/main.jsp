<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" buffer="32kb"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>푸드다이어리 - 헬킹 피트니스</title>
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
        
        body {
            background: #f8f9fa;
            color: var(--text-color);
        }
        
        .stats-card {
            background: white;
            border-radius: var(--radius);
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: transform 0.2s;
            height: 100%;
        }
        
        .stats-card:hover {
            transform: translateY(-2px);
        }
        
        .calorie-circle {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            margin: 0 auto 20px;
            font-weight: bold;
            position: relative;
            background: conic-gradient(var(--border-color) 0deg, var(--border-color) 360deg);
            text-align: center;
            line-height: 1;
        }
        
        .progress-text {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            width: 100%;
            height: 100%;
            margin-top: -2px;
        }
        
        .progress-text .h4 {
            margin: 0;
            line-height: 1.1;
            color: var(--text-color);
            font-size: 1.5rem;
            font-weight: bold;
        }
        
        .progress-text small {
            margin-top: 2px;
            line-height: 1;
            white-space: nowrap;
            color: var(--muted-color);
            font-size: 0.75rem;
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
            padding: 12px;
            margin-bottom: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: background 0.2s;
        }
        
        .food-item:hover {
            background: var(--border-color);
        }
        
        .quick-add-btn {
            background: var(--brand);
            color: white;
            border: none;
            border-radius: 50%;
            width: 50px;
            height: 50px;
            font-size: 24px;
            position: fixed;
            bottom: 30px;
            right: 30px;
            box-shadow: 0 4px 12px rgba(255, 106, 0, 0.3);
            z-index: 1000;
            transition: all 0.2s;
        }
        
        .quick-add-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 6px 16px rgba(255, 106, 0, 0.4);
        }
        
        .empty-meal {
            text-align: center;
            color: var(--muted-color);
            padding: 30px;
            font-style: italic;
        }
        
        .health-score-card {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border-radius: var(--radius);
            padding: 25px;
            text-align: center;
        }
        
        .favorite-food-item {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            padding: 10px 15px;
            margin-bottom: 8px;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .favorite-food-item:hover {
            background: var(--hover);
            border-color: var(--brand);
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
    
<div class="page-header">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">홈</a></li>
                <li class="breadcrumb-item active">푸드다이어리</li>
            </ol>
        </nav>
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="display-5 fw-bold mb-3">푸드다이어리</h1>
                <p class="lead mb-0">건강한 식습관으로 더 나은 내일을 만들어가세요</p>
            </div>
            <div class="col-md-4 text-end">
                <div class="health-score-card">
                    <h3 class="fw-bold mb-1">
                        <c:choose>
                            <c:when test="${not empty healthScore && healthScore.totalScore != null}">
                                ${healthScore.totalScore}점
                            </c:when>
                            <c:otherwise>0점</c:otherwise>
                        </c:choose>
                    </h3>
                    <p class="mb-2">건강 점수</p>
                    <small>
                        <c:choose>
                            <c:when test="${not empty healthScore && healthScore.message != null}">
                                ${healthScore.message}
                            </c:when>
                            <c:otherwise>시작해보세요!</c:otherwise>
                        </c:choose>
                    </small>
                </div>
            </div>
        </div>
    </div>
</div>

<%-- 안전한 변수 초기화 - 수정됨 --%>
<c:set var="safeCurrentCal" value="${(empty todayStats || todayStats.totalCalories == null) ? 0 : todayStats.totalCalories}" />
<c:set var="safeTargetCal" value="${(empty todayStats || todayStats.targetCalories == null) ? 2000 : todayStats.targetCalories}" />
<c:set var="safeProtein" value="${(empty todayStats || todayStats.totalProtein == null) ? 0 : todayStats.totalProtein}" />
<c:set var="safeCarbs" value="${(empty todayStats || todayStats.totalCarbs == null) ? 0 : todayStats.totalCarbs}" />
<c:set var="safeFat" value="${(empty todayStats || todayStats.totalFat == null) ? 0 : todayStats.totalFat}" />
<c:set var="safeMealCount" value="${(empty todayStats || todayStats.mealCount == null) ? 0 : todayStats.mealCount}" />

<div class="container mt-4">
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <div class="row mb-4">
        <div class="col-lg-4 mb-3">
            <div class="stats-card text-center">
                <div class="calorie-circle" id="calorieCircle">
                    <div class="progress-text">
                        <div class="h4" id="currentCalories">${safeCurrentCal}</div>
                        <small id="targetCalories">/ ${safeTargetCal}kcal</small>
                    </div>
                </div>
                <h6 class="text-muted">오늘 섭취 칼로리</h6>
            </div>
        </div>
        
        <div class="col-lg-4 mb-3">
            <div class="stats-card">
                <h6 class="text-muted mb-3">영양소 섭취량</h6>
                <div class="row text-center">
                    <div class="col-4">
                        <div class="h5 text-primary mb-1" id="totalProtein">
                            <fmt:formatNumber value="${safeProtein}" maxFractionDigits="1"/>g
                        </div>
                        <small class="text-muted">단백질</small>
                    </div>
                    <div class="col-4">
                        <div class="h5 text-success mb-1" id="totalCarbs">
                            <fmt:formatNumber value="${safeCarbs}" maxFractionDigits="1"/>g
                        </div>
                        <small class="text-muted">탄수화물</small>
                    </div>
                    <div class="col-4">
                        <div class="h5 text-warning mb-1" id="totalFat">
                            <fmt:formatNumber value="${safeFat}" maxFractionDigits="1"/>g
                        </div>
                        <small class="text-muted">지방</small>
                    </div>
                </div>
                
                <div class="mt-3">
                    <%-- Macro Ratio 안전 처리 --%>
                    <c:choose>
                        <c:when test="${not empty todayStats && todayStats.totalProtein != null && todayStats.totalCarbs != null && todayStats.totalFat != null}">
                            <c:set var="proteinPercent" value="${todayStats.macroRatio.proteinPercent}"/>
                            <c:set var="carbsPercent" value="${todayStats.macroRatio.carbsPercent}"/>
                            <c:set var="fatPercent" value="${todayStats.macroRatio.fatPercent}"/>
                        </c:when>
                        <c:otherwise>
                            <c:set var="proteinPercent" value="0"/>
                            <c:set var="carbsPercent" value="0"/>
                            <c:set var="fatPercent" value="0"/>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="progress" style="height: 8px;" id="macroProgressBar">
                        <div class="progress-bar bg-primary" role="progressbar" style="width: ${proteinPercent}%"></div>
                        <div class="progress-bar bg-success" role="progressbar" style="width: ${carbsPercent}%"></div>
                        <div class="progress-bar bg-warning" role="progressbar" style="width: ${fatPercent}%"></div>
                    </div>
                    <small class="text-muted" id="macroRatioText">
                        탄수화물 ${carbsPercent}% • 단백질 ${proteinPercent}% • 지방 ${fatPercent}%
                    </small>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4 mb-3">
            <div class="stats-card">
                <h6 class="text-muted mb-3">기록 현황</h6>
                <div class="row">
                    <div class="col-6">
                        <div class="h5 mb-1" id="mealCount">${safeMealCount}</div>
                        <small class="text-muted">오늘 기록</small>
                    </div>
                    <div class="col-6">
                        <div class="h5 mb-1">
                            <c:choose>
                                <c:when test="${not empty healthScore && healthScore.recordDays != null}">
                                    ${healthScore.recordDays}
                                </c:when>
                                <c:otherwise>0</c:otherwise>
                            </c:choose>
                        </div>
                        <small class="text-muted">이번 주 기록</small>
                    </div>
                </div>
                
                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/fooddiary/stats" class="btn btn-outline-primary btn-sm w-100">
                        <i class="fas fa-chart-bar me-2"></i>상세 통계 보기
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-lg-8">
            <h4 class="fw-bold mb-3">오늘의 식단 (${todayStr})</h4>
            
            <%-- 아침 --%>
            <div class="meal-section">
                <div class="meal-header">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-sun me-2 text-warning"></i>
                        <h5 class="mb-0">아침</h5>
                    </div>
                    <button class="btn btn-outline-primary btn-sm" onclick="openAddFoodModal('아침')">
                        <i class="fas fa-plus me-1"></i>추가
                    </button>
                </div>
                
                <c:choose>
                    <c:when test="${not empty mealGroups['아침']}">
                        <c:forEach var="food" items="${mealGroups['아침']}">
                            <div class="food-item">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <div class="me-3">
                                        <strong>${food.foodName}</strong>
                                        <div class="small text-muted">
                                            <fmt:formatNumber value="${food.amountGrams}" maxFractionDigits="1"/>g
                                        </div>
                                    </div>
                                </div>
                                <div class="text-end me-3">
                                    <div class="fw-bold text-primary">${food.caloriesConsumed}kcal</div>
                                    <div class="small text-muted">
                                        P <fmt:formatNumber value="${food.proteinConsumed}" maxFractionDigits="1"/>g • 
                                        C <fmt:formatNumber value="${food.carbsConsumed}" maxFractionDigits="1"/>g • 
                                        F <fmt:formatNumber value="${food.fatConsumed}" maxFractionDigits="1"/>g
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
                                        <li><a class="dropdown-item text-danger" href="#" onclick="deleteFood(${food.foodLogNum})">
                                            <i class="fas fa-trash me-2"></i>삭제
                                        </a></li>
                                    </ul>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-meal">
                            <i class="fas fa-utensils fa-2x mb-2 text-muted"></i>
                            <p class="mb-0">아직 아침 기록이 없습니다</p>
                            <small class="text-muted">음식을 추가해보세요</small>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- 점심 --%>
            <div class="meal-section">
                <div class="meal-header">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-sun me-2 text-success"></i>
                        <h5 class="mb-0">점심</h5>
                    </div>
                    <button class="btn btn-outline-primary btn-sm" onclick="openAddFoodModal('점심')">
                        <i class="fas fa-plus me-1"></i>추가
                    </button>
                </div>
                
                <c:choose>
                    <c:when test="${not empty mealGroups['점심']}">
                        <c:forEach var="food" items="${mealGroups['점심']}">
                            <div class="food-item">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <div class="me-3">
                                        <strong>${food.foodName}</strong>
                                        <div class="small text-muted">
                                            <fmt:formatNumber value="${food.amountGrams}" maxFractionDigits="1"/>g
                                        </div>
                                    </div>
                                </div>
                                <div class="text-end me-3">
                                    <div class="fw-bold text-primary">${food.caloriesConsumed}kcal</div>
                                    <div class="small text-muted">
                                        P <fmt:formatNumber value="${food.proteinConsumed}" maxFractionDigits="1"/>g • 
                                        C <fmt:formatNumber value="${food.carbsConsumed}" maxFractionDigits="1"/>g • 
                                        F <fmt:formatNumber value="${food.fatConsumed}" maxFractionDigits="1"/>g
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
                                        <li><a class="dropdown-item text-danger" href="#" onclick="deleteFood(${food.foodLogNum})">
                                            <i class="fas fa-trash me-2"></i>삭제
                                        </a></li>
                                    </ul>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-meal">
                            <i class="fas fa-utensils fa-2x mb-2 text-muted"></i>
                            <p class="mb-0">아직 점심 기록이 없습니다</p>
                            <small class="text-muted">음식을 추가해보세요</small>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- 저녁 --%>
            <div class="meal-section">
                <div class="meal-header">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-moon me-2 text-primary"></i>
                        <h5 class="mb-0">저녁</h5>
                    </div>
                    <button class="btn btn-outline-primary btn-sm" onclick="openAddFoodModal('저녁')">
                        <i class="fas fa-plus me-1"></i>추가
                    </button>
                </div>
                
                <c:choose>
                    <c:when test="${not empty mealGroups['저녁']}">
                        <c:forEach var="food" items="${mealGroups['저녁']}">
                            <div class="food-item">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <div class="me-3">
                                        <strong>${food.foodName}</strong>
                                        <div class="small text-muted">
                                            <fmt:formatNumber value="${food.amountGrams}" maxFractionDigits="1"/>g
                                        </div>
                                    </div>
                                </div>
                                <div class="text-end me-3">
                                    <div class="fw-bold text-primary">${food.caloriesConsumed}kcal</div>
                                    <div class="small text-muted">
                                        P <fmt:formatNumber value="${food.proteinConsumed}" maxFractionDigits="1"/>g • 
                                        C <fmt:formatNumber value="${food.carbsConsumed}" maxFractionDigits="1"/>g • 
                                        F <fmt:formatNumber value="${food.fatConsumed}" maxFractionDigits="1"/>g
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
                                        <li><a class="dropdown-item text-danger" href="#" onclick="deleteFood(${food.foodLogNum})">
                                            <i class="fas fa-trash me-2"></i>삭제
                                        </a></li>
                                    </ul>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-meal">
                            <i class="fas fa-utensils fa-2x mb-2 text-muted"></i>
                            <p class="mb-0">아직 저녁 기록이 없습니다</p>
                            <small class="text-muted">음식을 추가해보세요</small>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- 간식 --%>
            <div class="meal-section">
                <div class="meal-header">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-cookie-bite me-2 text-info"></i>
                        <h5 class="mb-0">간식</h5>
                    </div>
                    <button class="btn btn-outline-primary btn-sm" onclick="openAddFoodModal('간식')">
                        <i class="fas fa-plus me-1"></i>추가
                    </button>
                </div>
                
                <c:choose>
                    <c:when test="${not empty mealGroups['간식']}">
                        <c:forEach var="food" items="${mealGroups['간식']}">
                            <div class="food-item">
                                <div class="d-flex align-items-center flex-grow-1">
                                    <div class="me-3">
                                        <strong>${food.foodName}</strong>
                                        <div class="small text-muted">
                                            <fmt:formatNumber value="${food.amountGrams}" maxFractionDigits="1"/>g
                                        </div>
                                    </div>
                                </div>
                                <div class="text-end me-3">
                                    <div class="fw-bold text-primary">${food.caloriesConsumed}kcal</div>
                                    <div class="small text-muted">
                                        P <fmt:formatNumber value="${food.proteinConsumed}" maxFractionDigits="1"/>g • 
                                        C <fmt:formatNumber value="${food.carbsConsumed}" maxFractionDigits="1"/>g • 
                                        F <fmt:formatNumber value="${food.fatConsumed}" maxFractionDigits="1"/>g
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
                                        <li><a class="dropdown-item text-danger" href="#" onclick="deleteFood(${food.foodLogNum})">
                                            <i class="fas fa-trash me-2"></i>삭제
                                        </a></li>
                                    </ul>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-meal">
                            <i class="fas fa-utensils fa-2x mb-2 text-muted"></i>
                            <p class="mb-0">아직 간식 기록이 없습니다</p>
                            <small class="text-muted">음식을 추가해보세요</small>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <%-- 사이드바 --%>
        <div class="col-lg-4">
            <div class="meal-section">
                <h5 class="fw-bold mb-3">
                    <i class="fas fa-star text-warning me-2"></i>즐겨찾기 음식
                </h5>
                
                <c:choose>
                    <c:when test="${not empty favoriteFoods}">
                        <c:forEach var="favorite" items="${favoriteFoods}" end="4">
                            <div class="favorite-food-item" onclick="quickAddFood(${favorite.foodNum}, '${favorite.foodName}')">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <strong>${favorite.foodName}</strong>
                                        <div class="small text-muted">${favorite.category}</div>
                                    </div>
                                    <div class="text-end">
                                        <small class="text-primary">
                                            <fmt:formatNumber value="${favorite.caloriesPer100g}" maxFractionDigits="0"/>kcal/100g
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <div class="text-center mt-3">
                            <a href="${pageContext.request.contextPath}/fooddiary/favorites" class="btn btn-outline-secondary btn-sm">
                                전체 즐겨찾기 관리
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-3">
                            <i class="fas fa-heart fa-2x text-muted mb-2"></i>
                            <p class="text-muted mb-2">즐겨찾기가 비어있습니다</p>
                            <a href="${pageContext.request.contextPath}/fooddiary/search" class="btn btn-outline-primary btn-sm">
                                음식 검색하기
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="meal-section">
                <h5 class="fw-bold mb-3">
                    <i class="fas fa-chart-line me-2"></i>주간 칼로리
                </h5>
                <div style="position: relative; height: 250px; width: 100%;">
                    <canvas id="weeklyChart"></canvas>
                </div>
            </div>
            
            <div class="meal-section">
                <h5 class="fw-bold mb-3">바로가기</h5>
                <div class="d-grid gap-2">
                    <a href="${pageContext.request.contextPath}/fooddiary/search" class="btn btn-outline-primary">
                        <i class="fas fa-search me-2"></i>음식 검색
                    </a>
                    <a href="${pageContext.request.contextPath}/fooddiary/calendar" class="btn btn-outline-success">
                        <i class="fas fa-calendar-alt me-2"></i>월간 기록
                    </a>
                    <a href="${pageContext.request.contextPath}/fooddiary/profile" class="btn btn-outline-info">
                        <i class="fas fa-user-cog me-2"></i>목표 설정
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<button class="quick-add-btn" onclick="openQuickAddModal()" title="음식 추가">
    <i class="fas fa-plus"></i>
</button>

<%-- 음식 추가 모달 --%>
<div class="modal fade" id="addFoodModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">음식 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="addFoodForm">
                    <div class="mb-3">
                        <label class="form-label">음식 검색</label>
                        <input type="text" class="form-control" id="foodSearch" 
                               placeholder="음식명을 입력하세요" autocomplete="off">
                        <div id="searchResults" class="mt-2"></div>
                    </div>
                    
                    <div id="selectedFoodInfo" class="mb-3" style="display: none;">
                        <div class="card">
                            <div class="card-body">
                                <h6 id="selectedFoodName"></h6>
                                <div id="selectedFoodNutrition" class="small text-muted"></div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">섭취량</label>
                        <div class="input-group">
                            <input type="number" class="form-control" id="amountGrams" 
                                   placeholder="100" min="0.1" max="10000" step="0.1">
                            <span class="input-group-text">g</span>
                        </div>
                        <div id="referenceWeights" class="mt-2"></div>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">식사</label>
                        <select class="form-select" id="mealType" name="mealType">
                            <option value="아침">아침</option>
                            <option value="점심">점심</option>
                            <option value="저녁">저녁</option>
                            <option value="간식">간식</option>
                            <option value="기타">기타</option>
                        </select>
                    </div>
                    
                    <div id="nutritionPreview" class="mb-3" style="display: none;">
                        <div class="card bg-light">
                            <div class="card-body">
                                <h6>영양소 정보</h6>
                                <div class="row text-center">
                                    <div class="col-3">
                                        <div class="fw-bold" id="previewCalories">0</div>
                                        <small>kcal</small>
                                    </div>
                                    <div class="col-3">
                                        <div class="fw-bold" id="previewProtein">0</div>
                                        <small>단백질(g)</small>
                                    </div>
                                    <div class="col-3">
                                        <div class="fw-bold" id="previewCarbs">0</div>
                                        <small>탄수화물(g)</small>
                                    </div>
                                    <div class="col-3">
                                        <div class="fw-bold" id="previewFat">0</div>
                                        <small>지방(g)</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <input type="hidden" id="selectedFoodNum">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="saveFoodLog()">저장</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    var contextPath = '${pageContext.request.contextPath}';
    var todayStr = '${todayStr}';
    
    let searchTimeout;
    let selectedFood = null;
    
    function updateCalorieCircle(currentCalories, targetCalories) {
        const circle = document.getElementById('calorieCircle');
        const currentElement = document.getElementById('currentCalories');
        const targetElement = document.getElementById('targetCalories');
        
        if (!circle || !currentElement || !targetElement) return;
        
        currentCalories = parseInt(currentCalories) || 0;
        targetCalories = parseInt(targetCalories) || 2000;
        
        const achievementPercent = targetCalories > 0 ? Math.min(100, (currentCalories * 100) / targetCalories) : 0;
        const degrees = achievementPercent * 3.6;
        
        const primaryColor = getComputedStyle(document.documentElement).getPropertyValue('--primary-color').trim();
        const borderColor = getComputedStyle(document.documentElement).getPropertyValue('--border-color').trim();
        
        circle.style.background = `conic-gradient(\${primaryColor} \${degrees}deg, \${borderColor} 0deg)`;
        
        currentElement.textContent = currentCalories;
        targetElement.textContent = `/ \${targetCalories}kcal`;
    }
    
    function updateNutritionStats(stats) {
        const safeStats = {
            totalCalories: parseInt(stats.totalCalories) || 0,
            targetCalories: parseInt(stats.targetCalories) || 2000,
            totalProtein: parseFloat(stats.totalProtein) || 0,
            totalCarbs: parseFloat(stats.totalCarbs) || 0,
            totalFat: parseFloat(stats.totalFat) || 0,
            mealCount: parseInt(stats.mealCount) || 0,
            macroRatio: stats.macroRatio || { proteinPercent: 0, carbsPercent: 0, fatPercent: 0 }
        };
        
        updateCalorieCircle(safeStats.totalCalories, safeStats.targetCalories);
        
        const proteinEl = document.getElementById('totalProtein');
        const carbsEl = document.getElementById('totalCarbs');
        const fatEl = document.getElementById('totalFat');
        const mealCountEl = document.getElementById('mealCount');
        
        if (proteinEl) proteinEl.textContent = safeStats.totalProtein.toFixed(1) + 'g';
        if (carbsEl) carbsEl.textContent = safeStats.totalCarbs.toFixed(1) + 'g';
        if (fatEl) fatEl.textContent = safeStats.totalFat.toFixed(1) + 'g';
        if (mealCountEl) mealCountEl.textContent = safeStats.mealCount;
        
        const progressBar = document.getElementById('macroProgressBar');
        const ratioText = document.getElementById('macroRatioText');
        
        if (progressBar) {
            const proteinBar = progressBar.querySelector('.bg-primary');
            const carbsBar = progressBar.querySelector('.bg-success');
            const fatBar = progressBar.querySelector('.bg-warning');
            
            if (proteinBar) proteinBar.style.width = `\${safeStats.macroRatio.proteinPercent || 0}%`;
            if (carbsBar) carbsBar.style.width = `\${safeStats.macroRatio.carbsPercent || 0}%`;
            if (fatBar) fatBar.style.width = `\${safeStats.macroRatio.fatPercent || 0}%`;
        }
        
        if (ratioText) {
            ratioText.textContent = `탄수화물 \${safeStats.macroRatio.carbsPercent || 0}% • 단백질 \${safeStats.macroRatio.proteinPercent || 0}% • 지방 \${safeStats.macroRatio.fatPercent || 0}%`;
        }
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        // 🔍 디버깅: 서버에서 전달된 값 확인
        console.log('=== 디버깅 시작 ===');
        console.log('safeCurrentCal: ${safeCurrentCal}');
        console.log('safeTargetCal: ${safeTargetCal}');
        console.log('safeProtein: ${safeProtein}');
        console.log('safeCarbs: ${safeCarbs}');
        console.log('safeFat: ${safeFat}');
        console.log('proteinPercent: ${proteinPercent}');
        console.log('carbsPercent: ${carbsPercent}');
        console.log('fatPercent: ${fatPercent}');
        
        const initialStats = {
            totalCalories: parseInt('${safeCurrentCal}') || 0,
            targetCalories: parseInt('${safeTargetCal}') || 2000,
            totalProtein: parseFloat('${safeProtein}') || 0,
            totalCarbs: parseFloat('${safeCarbs}') || 0,
            totalFat: parseFloat('${safeFat}') || 0,
            mealCount: parseInt('${safeMealCount}') || 0,
            macroRatio: {
                proteinPercent: ${proteinPercent},
                carbsPercent: ${carbsPercent},
                fatPercent: ${fatPercent}
            }
        };
        
        console.log('initialStats:', initialStats);
        console.log('=== 디버깅 끝 ===');
        
        updateNutritionStats(initialStats);
        initWeeklyChart();
    });
    
    function openAddFoodModal(mealType) {
        var modal = new bootstrap.Modal(document.getElementById('addFoodModal'));
        modal.show();
        
        setTimeout(function() {
            var mealTypeSelect = document.getElementById('mealType');
            if (mealTypeSelect) {
                mealTypeSelect.value = mealType || '기타';
            }
        }, 100);
    }
    
    function openQuickAddModal() {
        var now = new Date();
        var hour = now.getHours();
        var defaultMeal = '간식';
        
        if (hour >= 6 && hour < 10) defaultMeal = '아침';
        else if (hour >= 11 && hour < 15) defaultMeal = '점심';
        else if (hour >= 17 && hour < 21) defaultMeal = '저녁';
        
        openAddFoodModal(defaultMeal);
    }
    
    document.getElementById('foodSearch').addEventListener('input', function(e) {
        var keyword = e.target.value.trim();
        
        clearTimeout(searchTimeout);
        
        if (keyword.length < 1) {
            document.getElementById('searchResults').innerHTML = '';
            return;
        }
        
        searchTimeout = setTimeout(function() {
            searchFoods(keyword);
        }, 300);
    });
    
    function searchFoods(keyword) {
        var encodedKeyword = encodeURIComponent(keyword);
        fetch(contextPath + '/fooddiary/api/search?keyword=' + encodedKeyword)
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.success) {
                    displaySearchResults(data.foods);
                } else {
                    document.getElementById('searchResults').innerHTML = 
                        '<div class="alert alert-warning">검색 중 오류가 발생했습니다.</div>';
                }
            })
            .catch(function(error) {
                console.error('검색 오류:', error);
                document.getElementById('searchResults').innerHTML = 
                    '<div class="alert alert-danger">네트워크 오류가 발생했습니다.</div>';
            });
    }
    
    function displaySearchResults(foods) {
        var resultsDiv = document.getElementById('searchResults');
        
        if (foods.length === 0) {
            resultsDiv.innerHTML = '<div class="text-muted">검색 결과가 없습니다.</div>';
            return;
        }
        
        var html = '<div class="list-group">';
        foods.forEach(function(food) {
            html += '<a href="#" class="list-group-item list-group-item-action" onclick="selectFood(' + 
                    food.foodNum + ', \'' + food.foodName + '\', \'' + food.category + '\', ' + 
                    food.caloriesPer100g + ')">' +
                    '<div class="d-flex justify-content-between align-items-center">' +
                    '<div><strong>' + food.foodName + '</strong>' +
                    '<div class="small text-muted">' + food.category + '</div></div>' +
                    '<span class="badge bg-primary">' + food.caloriesPer100g + 'kcal/100g</span>' +
                    '</div></a>';
        });
        html += '</div>';
        
        resultsDiv.innerHTML = html;
    }
    
    function selectFood(foodNum, foodName, category, calories) {
        selectedFood = { foodNum: foodNum, foodName: foodName, category: category, calories: calories };
        
        document.getElementById('selectedFoodNum').value = foodNum;
        document.getElementById('selectedFoodName').textContent = foodName;
        document.getElementById('selectedFoodNutrition').textContent = category + ' • ' + calories + 'kcal/100g';
        
        document.getElementById('selectedFoodInfo').style.display = 'block';
        document.getElementById('searchResults').innerHTML = '';
        document.getElementById('foodSearch').value = foodName;
        
        loadReferenceWeights(foodNum);
        
        document.getElementById('amountGrams').value = 100;
        updateNutritionPreview();
    }
    
    function loadReferenceWeights(foodNum) {
        fetch(contextPath + '/fooddiary/api/food/' + foodNum)
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.success && data.food.referenceWeights) {
                    displayReferenceWeights(data.food.referenceWeights);
                }
            });
    }
    
    function displayReferenceWeights(weights) {
        var container = document.getElementById('referenceWeights');
        
        if (!weights || weights.length === 0) {
            container.innerHTML = '';
            return;
        }
        
        var html = '<div class="small text-muted mb-2">참고 중량:</div>';
        html += '<div class="btn-group-sm" role="group">';
        
        weights.forEach(function(weight) {
            html += '<button type="button" class="btn btn-outline-secondary btn-sm me-1 mb-1" ' +
                    'onclick="setAmount(' + weight.weightGrams + ')">' +
                    weight.referenceUnit + ' (' + weight.weightGrams + 'g)</button>';
        });
        
        html += '</div>';
        container.innerHTML = html;
    }
    
    function setAmount(grams) {
        document.getElementById('amountGrams').value = grams;
        updateNutritionPreview();
    }
    
    document.getElementById('amountGrams').addEventListener('input', updateNutritionPreview);
    
    function updateNutritionPreview() {
        if (!selectedFood) return;
        
        var grams = parseFloat(document.getElementById('amountGrams').value) || 0;
        
        if (grams <= 0) {
            document.getElementById('nutritionPreview').style.display = 'none';
            return;
        }
        
        fetch(contextPath + '/fooddiary/api/nutrition?foodNum=' + selectedFood.foodNum + '&grams=' + grams)
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.success) {
                    document.getElementById('previewCalories').textContent = data.nutrition.calories;
                    document.getElementById('previewProtein').textContent = data.nutrition.protein.toFixed(1);
                    document.getElementById('previewCarbs').textContent = data.nutrition.carbs.toFixed(1);
                    document.getElementById('previewFat').textContent = data.nutrition.fat.toFixed(1);
                    document.getElementById('nutritionPreview').style.display = 'block';
                }
            });
    }
    
    function saveFoodLog() {
        var foodNum = document.getElementById('selectedFoodNum').value;
        var amountGrams = document.getElementById('amountGrams').value;
        var mealTypeSelect = document.getElementById('mealType');
        var mealType = mealTypeSelect ? mealTypeSelect.value : '기타';
        
        if (!foodNum || !amountGrams) {
            alert('음식과 섭취량을 모두 입력해주세요.');
            return;
        }
        
        var formData = new FormData();
        formData.append('foodNum', foodNum);
        formData.append('amountGrams', amountGrams);
        formData.append('mealType', mealType);
        formData.append('recordDateStr', todayStr);
        
        fetch(contextPath + '/fooddiary/log', {
            method: 'POST',
            body: formData
        })
        .then(function(response) { return response.json(); })
        .then(function(data) {
            if (data.success) {
                var modal = bootstrap.Modal.getInstance(document.getElementById('addFoodModal'));
                if (modal) modal.hide();
                
                location.reload();
            } else {
                alert(data.message || '저장에 실패했습니다.');
            }
        })
        .catch(function(error) {
            console.error('저장 오류:', error);
            alert('저장 중 오류가 발생했습니다.');
        });
    }
    
    function editFood(foodLogNum) {
        alert('수정 기능은 준비 중입니다.');
    }
    
    function deleteFood(foodLogNum) {
        if (confirm('이 기록을 삭제하시겠습니까?')) {
            fetch(contextPath + '/fooddiary/log/' + foodLogNum, {
                method: 'DELETE'
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.success) {
                    location.reload();
                } else {
                    alert(data.message || '삭제에 실패했습니다.');
                }
            })
            .catch(function(error) {
                console.error('삭제 오류:', error);
                alert('삭제 중 오류가 발생했습니다.');
            });
        }
    }
    
    function quickAddFood(foodNum, foodName) {
        selectedFood = { foodNum: foodNum, foodName: foodName };
        
        document.getElementById('selectedFoodNum').value = foodNum;
        document.getElementById('selectedFoodName').textContent = foodName;
        document.getElementById('selectedFoodInfo').style.display = 'block';
        document.getElementById('foodSearch').value = foodName;
        
        document.getElementById('amountGrams').value = 100;
        
        var now = new Date();
        var hour = now.getHours();
        var defaultMeal = '간식';
        
        if (hour >= 6 && hour < 10) defaultMeal = '아침';
        else if (hour >= 11 && hour < 15) defaultMeal = '점심';
        else if (hour >= 17 && hour < 21) defaultMeal = '저녁';
        
        document.getElementById('mealType').value = defaultMeal;
        
        loadReferenceWeights(foodNum);
        updateNutritionPreview();
        
        var modal = new bootstrap.Modal(document.getElementById('addFoodModal'));
        modal.show();
    }
    
    function initWeeklyChart() {
        var ctx = document.getElementById('weeklyChart');
        if (!ctx) return;
        
        try {
            var weeklyData = [];
            <c:choose>
                <c:when test="${not empty weeklyStats}">
                    <c:forEach var="stat" items="${weeklyStats}">
                        weeklyData.push(${stat.totalCalories != null ? stat.totalCalories : 0});
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    weeklyData = [0, 0, 0, 0, 0, 0, 0];
                </c:otherwise>
            </c:choose>
            
            if (weeklyData.length === 0) {
                weeklyData = [0, 0, 0, 0, 0, 0, 0];
            }
            
            var labels = ['월', '화', '수', '목', '금', '토', '일'];
            var targetCalories = ${safeTargetCal};
            
            var displayLabels = labels.slice(-weeklyData.length);
            if (displayLabels.length === 0) {
                displayLabels = ['오늘'];
                weeklyData = [0];
            }
            
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: displayLabels,
                    datasets: [{
                        label: '섭취 칼로리',
                        data: weeklyData,
                        borderColor: '#007bff',
                        backgroundColor: 'rgba(0, 123, 255, 0.1)',
                        tension: 0.4,
                        fill: true
                    }, {
                        label: '목표 칼로리',
                        data: new Array(weeklyData.length).fill(targetCalories),
                        borderColor: '#28a745',
                        borderDash: [5, 5],
                        pointRadius: 0
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
        } catch (e) {
            console.error('차트 초기화 오류:', e);
            ctx.style.display = 'none';
            ctx.parentNode.innerHTML = 
                '<div class="text-center text-muted p-4">차트를 불러올 수 없습니다</div>';
        }
    }
    
    document.getElementById('addFoodModal').addEventListener('hidden.bs.modal', function () {
        document.getElementById('addFoodForm').reset();
        document.getElementById('selectedFoodInfo').style.display = 'none';
        document.getElementById('nutritionPreview').style.display = 'none';
        document.getElementById('searchResults').innerHTML = '';
        document.getElementById('referenceWeights').innerHTML = '';
        selectedFood = null;
    });
</script>
</body>
</html>