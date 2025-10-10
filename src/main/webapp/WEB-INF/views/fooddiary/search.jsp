<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>음식 검색 - 푸드다이어리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #28a745;
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
            background: linear-gradient(135deg, var(--primary-color), #1e7e34);
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
        
        .search-card {
            background: white;
            border-radius: var(--radius);
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            padding: 25px;
            margin-bottom: 20px;
        }
        
        .food-card {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.2s;
            cursor: pointer;
            position: relative;
        }
        
        .food-card:hover {
            border-color: var(--primary-color);
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.1);
            transform: translateY(-2px);
        }
        
        .category-filter {
            background: var(--secondary-color);
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .category-btn {
            border-radius: 25px;
            margin: 3px;
            transition: all 0.2s;
        }
        
        .category-btn.active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        .favorite-btn {
            position: absolute;
            top: 15px;
            right: 15px;
            background: white;
            border: 1px solid var(--border-color);
            border-radius: 50%;
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
            z-index: 10;
        }
        
        .favorite-btn:hover {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        .favorite-btn.active {
            background: #ffc107;
            color: white;
            border-color: #ffc107;
        }
        
        .nutrition-info {
            background: var(--hover);
            border-radius: 8px;
            padding: 15px;
            margin-top: 15px;
        }
        
        .search-empty {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted-color);
        }
        
        .loading {
            display: none;
            text-align: center;
            padding: 20px;
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
                    <li class="breadcrumb-item active">음식 검색</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-6 fw-bold mb-3">음식 검색</h1>
                    <p class="lead mb-0">다양한 음식의 영양소 정보를 검색하고 기록해보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <i class="fas fa-search fa-4x opacity-75"></i>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 검색 영역 -->
        <div class="search-card">
            <form method="GET" action="${pageContext.request.contextPath}/fooddiary/search" id="searchForm">
                <div class="row">
                    <div class="col-md-8">
                        <div class="input-group">
                            <span class="input-group-text">
                                <i class="fas fa-search"></i>
                            </span>
                            <input type="text" class="form-control form-control-lg" 
                                   name="keyword" value="${keyword}"
                                   placeholder="음식명을 입력하세요 (예: 밥, 사과, 닭가슴살)"
                                   id="searchKeyword">
                            <button class="btn btn-primary btn-lg" type="submit">
                                검색
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4 mt-3 mt-md-0">
                        <a href="${pageContext.request.contextPath}/fooddiary/favorites" 
                           class="btn btn-outline-warning btn-lg w-100">
                            <i class="fas fa-star me-2"></i>즐겨찾기 보기
                        </a>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- 카테고리 필터 -->
        <div class="category-filter">
            <h6 class="fw-bold mb-3">카테고리별 찾기</h6>
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/fooddiary/search" 
                   class="btn category-btn ${empty category ? 'active' : 'btn-outline-secondary'}">
                    전체
                </a>
                <c:forEach var="cat" items="${categories}">
                    <a href="${pageContext.request.contextPath}/fooddiary/search?category=${cat}" 
                       class="btn category-btn ${category == cat ? 'active' : 'btn-outline-secondary'}">
                        ${cat}
                    </a>
                </c:forEach>
            </div>
        </div>
        
        <div class="row">
            <!-- 메인 검색 결과 -->
            <div class="col-lg-9">
                <!-- 로딩 표시 -->
                <div class="loading" id="loading">
                    <i class="fas fa-spinner fa-spin fa-2x"></i>
                    <p>검색 중...</p>
                </div>
                
                <c:choose>
                    <c:when test="${not empty foods}">
                        <!-- 검색 결과 헤더 -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold">
                                <c:choose>
                                    <c:when test="${not empty keyword}">
                                        "${keyword}" 검색 결과 (${foods.size()}개)
                                    </c:when>
                                    <c:when test="${not empty category}">
                                        ${category} (${foods.size()}개)
                                    </c:when>
                                    <c:otherwise>
                                        전체 음식 (${foods.size()}개)
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                            <div class="dropdown">
                                <button class="btn btn-outline-secondary dropdown-toggle btn-sm" type="button" data-bs-toggle="dropdown">
                                    정렬
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="#" onclick="sortFoods('name')">이름순</a></li>
                                    <li><a class="dropdown-item" href="#" onclick="sortFoods('calories')">칼로리순</a></li>
                                    <li><a class="dropdown-item" href="#" onclick="sortFoods('protein')">단백질순</a></li>
                                </ul>
                            </div>
                        </div>
                        
                        <!-- 음식 목록 -->
                        <div id="foodList">
                            <c:forEach var="food" items="${foods}" varStatus="status">
                                <div class="food-card" onclick="addFood(${food.foodNum}, '${food.foodName}')" data-food-id="${food.foodNum}">
                                    <div class="favorite-btn" 
                                         onclick="event.stopPropagation(); toggleFavorite(${food.foodNum}, this)"
                                         data-food-id="${food.foodNum}">
                                        <i class="fas fa-star"></i>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-8">
                                            <h5 class="fw-bold mb-2">${food.foodName}</h5>
                                            <span class="badge bg-secondary mb-2">${food.category}</span>
                                            
                                            <div class="nutrition-info">
                                                <div class="row text-center">
                                                    <div class="col-3">
                                                        <div class="fw-bold text-primary">${food.caloriesPer100g}</div>
                                                        <small class="text-muted">칼로리</small>
                                                    </div>
                                                    <div class="col-3">
                                                        <div class="fw-bold text-success">${food.proteinPer100g}</div>
                                                        <small class="text-muted">단백질(g)</small>
                                                    </div>
                                                    <div class="col-3">
                                                        <div class="fw-bold text-warning">${food.carbsPer100g}</div>
                                                        <small class="text-muted">탄수화물(g)</small>
                                                    </div>
                                                    <div class="col-3">
                                                        <div class="fw-bold text-info">${food.fatPer100g}</div>
                                                        <small class="text-muted">지방(g)</small>
                                                    </div>
                                                </div>
                                                <div class="text-center mt-2">
                                                    <small class="text-muted">100g당 영양소</small>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="col-md-4 text-end">
                                            <div class="mt-3">
                                                <button class="btn btn-primary btn-sm w-100 mb-2" 
                                                        onclick="event.stopPropagation(); addFood(${food.foodNum}, '${food.foodName}')">
                                                    <i class="fas fa-plus me-2"></i>기록 추가
                                                </button>
                                                <button class="btn btn-outline-info btn-sm w-100" 
                                                        onclick="event.stopPropagation(); viewDetail(${food.foodNum})">
                                                    <i class="fas fa-info-circle me-2"></i>상세 보기
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:when test="${not empty keyword or not empty category}">
                        <div class="search-empty">
                            <i class="fas fa-search fa-3x mb-3"></i>
                            <h5>검색 결과가 없습니다</h5>
                            <p class="mb-4">다른 키워드로 검색해보세요</p>
                            <a href="${pageContext.request.contextPath}/fooddiary/search" class="btn btn-primary">
                                전체 음식 보기
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="search-empty">
                            <i class="fas fa-utensils fa-3x mb-3"></i>
                            <h5>음식을 검색해보세요</h5>
                            <p class="mb-4">위의 검색창에 음식명을 입력하거나 카테고리를 선택해주세요</p>
                            <div class="row justify-content-center">
                                <div class="col-md-6">
                                    <input type="text" class="form-control mb-3" id="quickSearch" 
                                           placeholder="빠른 검색..." onkeypress="quickSearchEnter(event)">
                                    <button class="btn btn-primary w-100" onclick="quickSearch()">
                                        검색하기
                                    </button>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- 사이드바 -->
            <div class="col-lg-3">
                <!-- 즐겨찾기 음식 -->
                <div class="search-card">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-star text-warning me-2"></i>즐겨찾기
                    </h6>
                    
                    <c:choose>
                        <c:when test="${not empty favoriteFoods}">
                            <c:forEach var="favorite" items="${favoriteFoods}" end="4">
                                <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                                    <div>
                                        <div class="fw-bold small">${favorite.foodName}</div>
                                        <div class="text-muted" style="font-size: 0.75rem;">${favorite.category}</div>
                                    </div>
                                    <button class="btn btn-outline-primary btn-sm" 
                                            onclick="addFood(${favorite.foodNum}, '${favorite.foodName}')">
                                        추가
                                    </button>
                                </div>
                            </c:forEach>
                            
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/fooddiary/favorites" 
                                   class="btn btn-outline-warning btn-sm">
                                    전체 보기
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-3">
                                <i class="fas fa-heart text-muted mb-2"></i>
                                <p class="text-muted small mb-0">즐겨찾기가 비어있습니다</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- 인기 검색어 -->
                <div class="search-card">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-fire text-danger me-2"></i>인기 음식
                    </h6>
                    <div class="d-flex flex-wrap gap-1">
                        <span class="badge bg-light text-dark border p-2 cursor-pointer" 
                              onclick="searchKeyword('밥')">밥</span>
                        <span class="badge bg-light text-dark border p-2 cursor-pointer" 
                              onclick="searchKeyword('닭가슴살')">닭가슴살</span>
                        <span class="badge bg-light text-dark border p-2 cursor-pointer" 
                              onclick="searchKeyword('사과')">사과</span>
                        <span class="badge bg-light text-dark border p-2 cursor-pointer" 
                              onclick="searchKeyword('계란')">계란</span>
                        <span class="badge bg-light text-dark border p-2 cursor-pointer" 
                              onclick="searchKeyword('우유')">우유</span>
                        <span class="badge bg-light text-dark border p-2 cursor-pointer" 
                              onclick="searchKeyword('바나나')">바나나</span>
                    </div>
                </div>
                
                <!-- 도움말 -->
                <div class="search-card">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-lightbulb text-warning me-2"></i>검색 팁
                    </h6>
                    <ul class="small text-muted mb-0" style="line-height: 1.6;">
                        <li>정확한 음식명으로 검색하세요</li>
                        <li>카테고리별로 찾아보세요</li>
                        <li>자주 먹는 음식은 즐겨찾기에 추가하세요</li>
                        <li>영양소 정보는 100g 기준입니다</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 음식 추가 모달 (메인 페이지와 동일) -->
    <div class="modal fade" id="addFoodModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">음식 기록 추가</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="addFoodForm">
                        <div class="mb-3">
                            <label class="form-label">선택한 음식</label>
                            <div id="selectedFoodInfo" class="card">
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
                                       placeholder="100" min="0.1" max="10000" step="0.1" value="100">
                                <span class="input-group-text">g</span>
                            </div>
                            <div id="referenceWeights" class="mt-2"></div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">식사</label>
                            <select class="form-control" id="mealType">
                                <option value="아침">아침</option>
                                <option value="점심">점심</option>
                                <option value="저녁">저녁</option>
                                <option value="간식">간식</option>
                                <option value="기타">기타</option>
                            </select>
                        </div>
                        
                        <div id="nutritionPreview" class="mb-3">
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
    
    <script>
        // JSP 변수를 JavaScript로 전달
        const contextPath = '${pageContext.request.contextPath}';
        
        let selectedFood = null;
        let userFavorites = new Set(); // 사용자 즐겨찾기 상태 관리
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            initializePage();
            setupEventListeners();
        });
        
        // 페이지 초기화
        function initializePage() {
            // 서버에서 전달받은 즐겨찾기 정보로 초기화
            <c:if test="${not empty favoriteFoods}">
                <c:forEach var="favorite" items="${favoriteFoods}">
                    userFavorites.add(${favorite.foodNum});
                </c:forEach>
            </c:if>
            
            // 즐겨찾기 버튼 상태 업데이트
            updateFavoriteButtons();
        }
        
        // 이벤트 리스너 설정
        function setupEventListeners() {
            // 섭취량 변경시 영양소 미리보기 업데이트
            const amountInput = document.getElementById('amountGrams');
            if (amountInput) {
                amountInput.addEventListener('input', updateNutritionPreview);
            }
        }
        
        // 즐겨찾기 버튼 상태 업데이트
        function updateFavoriteButtons() {
            document.querySelectorAll('.favorite-btn').forEach(btn => {
                const foodId = parseInt(btn.dataset.foodId);
                if (userFavorites.has(foodId)) {
                    btn.classList.add('active');
                } else {
                    btn.classList.remove('active');
                }
            });
        }
        
        // ✅ 수정된 toggleFavorite 함수
        function toggleFavorite(foodNum, btn) {
            const isActive = btn.classList.contains('active');
            const action = isActive ? 'remove' : 'add';
            
            // UI 즉시 반영
            btn.style.opacity = '0.5';
            btn.style.pointerEvents = 'none';
            
            fetch(contextPath + '/fooddiary/favorites/' + foodNum, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    'Accept': 'application/json'
                },
                body: 'action=' + encodeURIComponent(action)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('HTTP error! status: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                btn.style.opacity = '1';
                btn.style.pointerEvents = 'auto';
                
                if (data.success) {
                    // 상태 업데이트
                    if (action === 'add') {
                        userFavorites.add(foodNum);
                        btn.classList.add('active');
                    } else {
                        userFavorites.delete(foodNum);
                        btn.classList.remove('active');
                    }
                    
                    // 성공 메시지 (옵션)
                    if (data.message) {
                        showToast(data.message, 'success');
                    }
                } else {
                    // 실패 시 원상복구
                    showToast(data.message || '처리에 실패했습니다.', 'error');
                }
            })
            .catch(error => {
                btn.style.opacity = '1';
                btn.style.pointerEvents = 'auto';
                
                console.error('즐겨찾기 오류:', error);
                showToast('처리 중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.', 'error');
            });
        }
        
        // 간단한 토스트 알림
        function showToast(message, type = 'info') {
            const toast = document.createElement('div');
            const alertClass = type === 'success' ? 'alert-success' : 'alert-danger';
            toast.className = 'alert ' + alertClass + ' position-fixed';
            toast.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 250px;';
            toast.innerHTML = message + 
                '<button type="button" class="btn-close" onclick="this.parentElement.remove()"></button>';
            
            document.body.appendChild(toast);
            
            // 3초 후 자동 제거
            setTimeout(() => {
                if (toast.parentElement) {
                    toast.remove();
                }
            }, 3000);
        }
        
        // 음식 추가 모달 열기
        function addFood(foodNum, foodName) {
            selectedFood = { foodNum, foodName };
            
            document.getElementById('selectedFoodNum').value = foodNum;
            document.getElementById('selectedFoodName').textContent = foodName;
            
            // 현재 시간에 따른 기본 식사 설정
            const now = new Date();
            const hour = now.getHours();
            let defaultMeal = '간식';
            
            if (hour >= 6 && hour < 10) defaultMeal = '아침';
            else if (hour >= 11 && hour < 15) defaultMeal = '점심';
            else if (hour >= 17 && hour < 21) defaultMeal = '저녁';
            
            document.getElementById('mealType').value = defaultMeal;
            document.getElementById('amountGrams').value = 100;
            
            loadFoodDetails(foodNum);
            updateNutritionPreview();
            
            new bootstrap.Modal(document.getElementById('addFoodModal')).show();
        }
        
        // 음식 상세정보 로드
        function loadFoodDetails(foodNum) {
            fetch(contextPath + '/fooddiary/api/food/' + foodNum)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        const food = data.food;
                        document.getElementById('selectedFoodNutrition').textContent = 
                            food.category + ' • ' + food.caloriesPer100g + 'kcal/100g';
                        
                        if (food.referenceWeights) {
                            displayReferenceWeights(food.referenceWeights);
                        }
                    }
                })
                .catch(error => {
                    console.error('음식 상세 정보 로드 실패:', error);
                });
        }
        
        // 참고 중량 표시
        function displayReferenceWeights(weights) {
            const container = document.getElementById('referenceWeights');
            
            if (!weights || weights.length === 0) {
                container.innerHTML = '';
                return;
            }
            
            let html = '<div class="small text-muted mb-2">참고 중량:</div>';
            html += '<div class="btn-group-sm" role="group">';
            
            weights.forEach(weight => {
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
        
        // 영양소 미리보기 업데이트
        function updateNutritionPreview() {
            if (!selectedFood) return;
            
            const grams = parseFloat(document.getElementById('amountGrams').value) || 0;
            
            if (grams <= 0) {
                ['previewCalories', 'previewProtein', 'previewCarbs', 'previewFat'].forEach(id => {
                    document.getElementById(id).textContent = '0';
                });
                return;
            }
            
            fetch(contextPath + '/fooddiary/api/nutrition?foodNum=' + selectedFood.foodNum + '&grams=' + grams)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById('previewCalories').textContent = data.nutrition.calories || '0';
                        document.getElementById('previewProtein').textContent = data.nutrition.protein || '0';
                        document.getElementById('previewCarbs').textContent = data.nutrition.carbs || '0';
                        document.getElementById('previewFat').textContent = data.nutrition.fat || '0';
                    }
                })
                .catch(error => {
                    console.error('영양소 계산 실패:', error);
                });
        }
        
        // 음식 기록 저장
        function saveFoodLog() {
            const foodNum = document.getElementById('selectedFoodNum').value;
            const amountGrams = document.getElementById('amountGrams').value;
            const mealType = document.getElementById('mealType').value;
            
            if (!foodNum || !amountGrams || parseFloat(amountGrams) <= 0) {
                alert('음식과 섭취량을 모두 입력해주세요.');
                return;
            }
            
            const formData = new FormData();
            formData.append('foodNum', foodNum);
            formData.append('amountGrams', amountGrams);
            formData.append('mealType', mealType);
            
            fetch(contextPath + '/fooddiary/log', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    bootstrap.Modal.getInstance(document.getElementById('addFoodModal')).hide();
                    showToast('음식이 기록되었습니다!', 'success');
                } else {
                    alert(data.message || '저장에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('저장 오류:', error);
                alert('저장 중 오류가 발생했습니다.');
            });
        }
        
        // 빠른 검색
        function quickSearch() {
            const keyword = document.getElementById('quickSearch').value.trim();
            if (keyword) {
                location.href = contextPath + '/fooddiary/search?keyword=' + encodeURIComponent(keyword);
            }
        }
        
        function quickSearchEnter(event) {
            if (event.key === 'Enter') {
                quickSearch();
            }
        }
        
        function searchKeyword(keyword) {
            location.href = contextPath + '/fooddiary/search?keyword=' + encodeURIComponent(keyword);
        }
        
        // 정렬 기능
        function sortFoods(sortType) {
            const foodList = document.getElementById('foodList');
            if (!foodList) return;
            
            const foods = Array.from(foodList.children);
            
            foods.sort((a, b) => {
                switch(sortType) {
                    case 'name':
                        const aName = a.querySelector('h5').textContent;
                        const bName = b.querySelector('h5').textContent;
                        return aName.localeCompare(bName, 'ko');
                    case 'calories':
                        const aCalories = parseFloat(a.querySelector('.text-primary').textContent) || 0;
                        const bCalories = parseFloat(b.querySelector('.text-primary').textContent) || 0;
                        return bCalories - aCalories;
                    case 'protein':
                        const aProtein = parseFloat(a.querySelector('.text-success').textContent) || 0;
                        const bProtein = parseFloat(b.querySelector('.text-success').textContent) || 0;
                        return bProtein - aProtein;
                    default:
                        return 0;
                }
            });
            
            foodList.innerHTML = '';
            foods.forEach(food => foodList.appendChild(food));
        }
        
        // 상세보기 (추후 구현)
        function viewDetail(foodNum) {
            // TODO: 상세보기 모달 구현
            alert('상세보기 기능은 준비 중입니다.');
        }
        
        // 모달 초기화
        document.getElementById('addFoodModal').addEventListener('hidden.bs.modal', function () {
            document.getElementById('addFoodForm').reset();
            document.getElementById('referenceWeights').innerHTML = '';
            selectedFood = null;
            
            // 영양소 미리보기 초기화
            ['previewCalories', 'previewProtein', 'previewCarbs', 'previewFat'].forEach(id => {
                document.getElementById(id).textContent = '0';
            });
        });
    </script>
</body>
</html>