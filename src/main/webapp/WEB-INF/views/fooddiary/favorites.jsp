<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>즐겨찾기 관리 - 푸드다이어리</title>
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
        
        .favorite-card {
            background: white;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.2s;
            position: relative;
        }
        
        .favorite-card:hover {
            border-color: var(--primary-color);
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.1);
            transform: translateY(-2px);
        }
        
        .favorite-star {
            position: absolute;
            top: 15px;
            right: 15px;
            color: #ffc107;
            font-size: 20px;
        }
        
        .remove-favorite {
            position: absolute;
            top: 15px;
            right: 50px;
            color: var(--muted-color);
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .remove-favorite:hover {
            color: #dc3545;
            transform: scale(1.1);
        }
        
        .section-card {
            background: white;
            border-radius: var(--radius);
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }
        
        .nutrition-preview {
            background: var(--hover);
            border-radius: 8px;
            padding: 15px;
            margin-top: 15px;
        }
        
        .quick-add-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--primary-color);
            color: white;
            border-radius: 50%;
            width: 25px;
            height: 25px;
            font-size: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .frequent-food-item {
            background: linear-gradient(135deg, #e3f2fd, #f3e5f5);
            border: 1px solid #bbdefb;
            border-radius: var(--radius);
            padding: 15px;
            margin-bottom: 10px;
            position: relative;
        }
        
        .usage-count {
            background: #2196f3;
            color: white;
            border-radius: 12px;
            padding: 2px 8px;
            font-size: 11px;
            margin-left: 8px;
        }
        
        .empty-favorites {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted-color);
        }
        
        .category-filter-btn {
            border-radius: 25px;
            margin: 3px;
            border: 1px solid var(--border-color);
            background: white;
            color: var(--text-color);
            transition: all 0.2s;
        }
        
        .category-filter-btn.active {
            background: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
        
        .category-filter-btn:hover {
            background: var(--hover);
            border-color: var(--primary-color);
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
            margin-top: 10px;
        }
        
        .search-box {
            background: var(--secondary-color);
            border-radius: var(--radius);
            padding: 20px;
            margin-bottom: 25px;
        }
        
        .food-recommendation {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-left: 4px solid var(--primary-color);
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 0 var(--radius) var(--radius) 0;
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
                    <li class="breadcrumb-item active">즐겨찾기</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-6 fw-bold mb-3">나의 즐겨찾기</h1>
                    <p class="lead mb-0">자주 먹는 음식들을 관리하고 빠르게 기록해보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <i class="fas fa-star fa-4x opacity-75"></i>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 검색 및 필터 -->
        <div class="search-box">
            <div class="row">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="fas fa-search"></i>
                        </span>
                        <input type="text" class="form-control" id="searchFavorites" 
                               placeholder="즐겨찾기에서 음식을 검색하세요">
                        <button class="btn btn-outline-secondary" type="button" onclick="clearSearch()">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
                <div class="col-md-4">
                    <a href="${pageContext.request.contextPath}/fooddiary/search" 
                       class="btn btn-primary w-100">
                        <i class="fas fa-plus me-2"></i>새 음식 추가
                    </a>
                </div>
            </div>
        </div>
        
        <div class="row">
            <!-- 메인 컨텐츠 -->
            <div class="col-lg-8">
                <!-- 카테고리 필터 -->
                <div class="section-card">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 class="fw-bold mb-0">
                            <i class="fas fa-star text-warning me-2"></i>
                            내 즐겨찾기 (<span id="favoriteCount">${favoriteFoods != null ? favoriteFoods.size() : 0}</span>)
                        </h5>
                        <div class="dropdown">
                            <button class="btn btn-outline-secondary dropdown-toggle btn-sm" type="button" data-bs-toggle="dropdown">
                                정렬
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#" onclick="sortFavorites('name')">이름순</a></li>
                                <li><a class="dropdown-item" href="#" onclick="sortFavorites('date')">추가일순</a></li>
                                <li><a class="dropdown-item" href="#" onclick="sortFavorites('calories')">칼로리순</a></li>
                                <li><a class="dropdown-item" href="#" onclick="sortFavorites('category')">카테고리순</a></li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- 카테고리 필터 버튼 -->
                    <div class="mb-4 text-center">
                        <button class="category-filter-btn active" data-category="all">전체</button>
                        <button class="category-filter-btn" data-category="곡류">곡류</button>
                        <button class="category-filter-btn" data-category="채소류">채소류</button>
                        <button class="category-filter-btn" data-category="과일류">과일류</button>
                        <button class="category-filter-btn" data-category="육류">육류</button>
                        <button class="category-filter-btn" data-category="유제품">유제품</button>
                        <button class="category-filter-btn" data-category="음료">음료</button>
                        <button class="category-filter-btn" data-category="간식">간식</button>
                    </div>
                    
                    <!-- 즐겨찾기 음식 목록 -->
                    <div id="favoritesList">
                        <c:choose>
                            <c:when test="${not empty favoriteFoods}">
                                <c:forEach var="favorite" items="${favoriteFoods}" varStatus="status">
                                    <div class="favorite-card" data-category="${favorite.category}" data-food-name="${favorite.foodName}">
                                        <i class="fas fa-star favorite-star"></i>
                                        <i class="fas fa-times remove-favorite" 
                                           onclick="removeFavorite(${favorite.foodNum}, '${favorite.foodName}')"></i>
                                        
                                        <div class="row">
                                            <div class="col-md-8">
                                                <h6 class="fw-bold mb-2">${favorite.foodName}</h6>
                                                <span class="badge bg-secondary mb-2">${favorite.category}</span>
                                                
                                                <div class="nutrition-preview">
                                                    <div class="row text-center">
                                                        <div class="col-3">
                                                            <div class="fw-bold text-primary">${favorite.caloriesPer100g}</div>
                                                            <small class="text-muted">칼로리</small>
                                                        </div>
                                                        <div class="col-3">
                                                            <div class="fw-bold text-success">-</div>
                                                            <small class="text-muted">단백질(g)</small>
                                                        </div>
                                                        <div class="col-3">
                                                            <div class="fw-bold text-warning">-</div>
                                                            <small class="text-muted">탄수화물(g)</small>
                                                        </div>
                                                        <div class="col-3">
                                                            <div class="fw-bold text-info">-</div>
                                                            <small class="text-muted">지방(g)</small>
                                                        </div>
                                                    </div>
                                                    <div class="text-center mt-2">
                                                        <small class="text-muted">100g당 영양소</small>
                                                    </div>
                                                </div>
                                                
                                                <c:if test="${favorite.recentUsageCount != null && favorite.recentUsageCount > 0}">
                                                    <div class="mt-2">
                                                        <small class="text-muted">
                                                            <i class="fas fa-chart-line me-1"></i>
                                                            최근 7일간 ${favorite.recentUsageCount}회 기록
                                                        </small>
                                                    </div>
                                                </c:if>
                                            </div>
                                            
                                            <div class="col-md-4">
                                                <div class="action-buttons">
                                                    <button class="btn btn-primary btn-sm flex-fill" 
                                                            onclick="quickAdd(${favorite.foodNum}, '${favorite.foodName}')">
                                                        <i class="fas fa-plus me-1"></i>빠른 추가
                                                    </button>
                                                </div>
                                                <div class="action-buttons">
                                                    <button class="btn btn-outline-info btn-sm flex-fill" 
                                                            onclick="viewDetail(${favorite.foodNum})">
                                                        <i class="fas fa-info-circle me-1"></i>상세보기
                                                    </button>
                                                </div>
                                                
                                                <div class="mt-3 text-center">
                                                    <fmt:formatDate value="${favorite.addedDate}" pattern="MM/dd 추가"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-favorites">
                                    <i class="fas fa-heart fa-3x mb-3 text-muted"></i>
                                    <h5>아직 즐겨찾기가 비어있습니다</h5>
                                    <p class="mb-4">자주 먹는 음식을 즐겨찾기에 추가하면<br>더욱 편리하게 기록할 수 있어요</p>
                                    <a href="${pageContext.request.contextPath}/fooddiary/search" 
                                       class="btn btn-primary">
                                        음식 검색하여 추가하기
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            
            <!-- 사이드바 -->
            <div class="col-lg-4">
                <!-- 자주 사용하는 음식 (즐겨찾기 추천) -->
                <div class="section-card">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-fire text-danger me-2"></i>즐겨찾기 추천
                    </h6>
                    
                    <c:choose>
                        <c:when test="${not empty frequentFoods}">
                            <p class="small text-muted mb-3">최근 자주 드시는 음식들이에요</p>
                            
                            <c:forEach var="frequent" items="${frequentFoods}" end="4">
                                <div class="frequent-food-item">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <strong>${frequent.foodName}</strong>
                                            <span class="usage-count">최근 ${frequent.recentUsageCount}회</span>
                                            <div class="small text-muted">${frequent.category}</div>
                                        </div>
                                        <button class="btn btn-outline-warning btn-sm" 
                                                onclick="addToFavorites(${frequent.foodNum}, '${frequent.foodName}')">
                                            <i class="fas fa-star"></i>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-3">
                                <i class="fas fa-utensils text-muted mb-2"></i>
                                <p class="text-muted small mb-0">음식을 기록하면<br>추천 목록이 나타납니다</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <!-- 사용 통계 -->
                <div class="section-card">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-chart-pie me-2"></i>즐겨찾기 통계
                    </h6>
                    
                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <span class="small">총 즐겨찾기</span>
                            <strong class="text-primary">${favoriteFoods != null ? favoriteFoods.size() : 0}개</strong>
                        </div>
                        
                        <c:if test="${not empty favoriteFoods}">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="small">이번 주 사용</span>
                                <strong class="text-success">-회</strong>
                            </div>
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span class="small">가장 많이 사용</span>
                                <strong class="text-warning">-</strong>
                            </div>
                        </c:if>
                    </div>
                    
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/fooddiary/stats" 
                           class="btn btn-outline-primary btn-sm w-100">
                            <i class="fas fa-chart-bar me-2"></i>상세 통계 보기
                        </a>
                    </div>
                </div>
                
                <!-- 빠른 도움말 -->
                <div class="section-card">
                    <h6 class="fw-bold mb-3">
                        <i class="fas fa-question-circle me-2"></i>이용 팁
                    </h6>
                    
                    <div class="food-recommendation">
                        <strong class="small">빠른 추가 사용하기</strong>
                        <p class="small mb-0 mt-1">즐겨찾기에서 "빠른 추가" 버튼을 누르면 기본 100g으로 바로 기록됩니다.</p>
                    </div>
                    
                    <div class="food-recommendation">
                        <strong class="small">카테고리별 정리</strong>
                        <p class="small mb-0 mt-1">카테고리 필터를 사용해서 원하는 음식을 더 쉽게 찾아보세요.</p>
                    </div>
                    
                    <div class="food-recommendation">
                        <strong class="small">자동 추천 활용</strong>
                        <p class="small mb-0 mt-1">자주 먹는 음식들이 자동으로 추천되니 즐겨찾기에 추가해보세요.</p>
                    </div>
                </div>
                
                <!-- 빠른 링크 -->
                <div class="section-card">
                    <h6 class="fw-bold mb-3">바로가기</h6>
                    <div class="d-grid gap-2">
                        <a href="${pageContext.request.contextPath}/fooddiary/" class="btn btn-primary btn-sm">
                            <i class="fas fa-home me-2"></i>메인으로
                        </a>
                        <a href="${pageContext.request.contextPath}/fooddiary/search" class="btn btn-outline-primary btn-sm">
                            <i class="fas fa-search me-2"></i>음식 검색
                        </a>
                        <a href="${pageContext.request.contextPath}/fooddiary/calendar" class="btn btn-outline-success btn-sm">
                            <i class="fas fa-calendar me-2"></i>캘린더 보기
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 빠른 추가 모달 -->
    <div class="modal fade" id="quickAddModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">빠른 음식 추가</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="quickAddForm">
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
                                       value="100" min="0.1" max="10000" step="0.1">
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
        let selectedFood = null;
        
        document.addEventListener('DOMContentLoaded', function() {
            setupEventListeners();
            updateFavoriteCount();
        });
        
        function setupEventListeners() {
            // 검색 기능
            document.getElementById('searchFavorites').addEventListener('input', function(e) {
                const keyword = e.target.value.toLowerCase();
                filterFavorites(keyword);
            });
            
            // 카테고리 필터
            document.querySelectorAll('.category-filter-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    document.querySelectorAll('.category-filter-btn').forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    
                    const category = this.dataset.category;
                    filterByCategory(category);
                });
            });
            
            // 섭취량 변경시 영양소 미리보기 업데이트
            const amountInput = document.getElementById('amountGrams');
            if (amountInput) {
                amountInput.addEventListener('input', updateNutritionPreview);
            }
        }
        
        function filterFavorites(keyword) {
            const favoriteCards = document.querySelectorAll('.favorite-card');
            
            favoriteCards.forEach(card => {
                const foodName = card.dataset.foodName.toLowerCase();
                if (keyword === '' || foodName.includes(keyword)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
            
            updateVisibleCount();
        }
        
        function filterByCategory(category) {
            const favoriteCards = document.querySelectorAll('.favorite-card');
            
            favoriteCards.forEach(card => {
                if (category === 'all' || card.dataset.category === category) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
            
            updateVisibleCount();
        }
        
        function clearSearch() {
            document.getElementById('searchFavorites').value = '';
            document.querySelectorAll('.favorite-card').forEach(card => {
                card.style.display = 'block';
            });
            updateVisibleCount();
        }
        
        function updateVisibleCount() {
            const visibleCards = document.querySelectorAll('.favorite-card[style="display: block;"], .favorite-card:not([style])');
            document.getElementById('favoriteCount').textContent = visibleCards.length;
        }
        
        function updateFavoriteCount() {
            const totalCards = document.querySelectorAll('.favorite-card').length;
            document.getElementById('favoriteCount').textContent = totalCards;
        }
        
        function sortFavorites(type) {
            const container = document.getElementById('favoritesList');
            const cards = Array.from(container.querySelectorAll('.favorite-card'));
            
            cards.sort((a, b) => {
                switch(type) {
                    case 'name':
                        return a.dataset.foodName.localeCompare(b.dataset.foodName);
                    case 'category':
                        return a.dataset.category.localeCompare(b.dataset.category);
                    case 'calories':
                        const aCalories = parseFloat(a.querySelector('.text-primary').textContent);
                        const bCalories = parseFloat(b.querySelector('.text-primary').textContent);
                        return bCalories - aCalories;
                    case 'date':
                        return 0;
                    default:
                        return 0;
                }
            });
            
            cards.forEach(card => container.appendChild(card));
        }
        
        function quickAdd(foodNum, foodName) {
            selectedFood = { foodNum, foodName };
            
            document.getElementById('selectedFoodNum').value = foodNum;
            document.getElementById('selectedFoodName').textContent = foodName;
            
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
            
            new bootstrap.Modal(document.getElementById('quickAddModal')).show();
        }
        
        function loadFoodDetails(foodNum) {
            fetch(`${pageContext.request.contextPath}/fooddiary/api/food/${foodNum}`)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        const food = data.food;
                        document.getElementById('selectedFoodNutrition').textContent = 
                            `${food.category} • ${food.caloriesPer100g}kcal/100g`;
                        
                        if (food.referenceWeights) {
                            displayReferenceWeights(food.referenceWeights);
                        }
                    }
                })
                .catch(error => {
                    console.error('음식 상세 정보 로드 실패:', error);
                });
        }
        
        function displayReferenceWeights(weights) {
            const container = document.getElementById('referenceWeights');
            
            if (!weights || weights.length === 0) {
                container.innerHTML = '';
                return;
            }
            
            let html = '<div class="small text-muted mb-2">참고 중량:</div>';
            html += '<div class="btn-group-sm" role="group">';
            
            weights.forEach(weight => {
                html += `
                    <button type="button" class="btn btn-outline-secondary btn-sm me-1 mb-1" 
                            onclick="setAmount(${weight.weightGrams})">
                        ${weight.referenceUnit} (${weight.weightGrams}g)
                    </button>
                `;
            });
            
            html += '</div>';
            container.innerHTML = html;
        }
        
        function setAmount(grams) {
            document.getElementById('amountGrams').value = grams;
            updateNutritionPreview();
        }
        
        function updateNutritionPreview() {
            if (!selectedFood) return;
            
            const grams = parseFloat(document.getElementById('amountGrams').value) || 0;
            
            if (grams <= 0) return;
            
            fetch(`${pageContext.request.contextPath}/fooddiary/api/nutrition?foodNum=${selectedFood.foodNum}&grams=${grams}`)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById('previewCalories').textContent = data.nutrition.calories;
                        document.getElementById('previewProtein').textContent = data.nutrition.protein;
                        document.getElementById('previewCarbs').textContent = data.nutrition.carbs;
                        document.getElementById('previewFat').textContent = data.nutrition.fat;
                    }
                })
                .catch(error => {
                    console.error('영양소 계산 실패:', error);
                });
        }
        
        function saveFoodLog() {
            const foodNum = document.getElementById('selectedFoodNum').value;
            const amountGrams = document.getElementById('amountGrams').value;
            const mealType = document.getElementById('mealType').value;
            
            if (!foodNum || !amountGrams) {
                alert('음식과 섭취량을 모두 입력해주세요.');
                return;
            }
            
            const formData = new FormData();
            formData.append('foodNum', foodNum);
            formData.append('amountGrams', amountGrams);
            formData.append('mealType', mealType);
            
            fetch('${pageContext.request.contextPath}/fooddiary/log', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    bootstrap.Modal.getInstance(document.getElementById('quickAddModal')).hide();
                    alert('음식이 기록되었습니다!');
                } else {
                    alert(data.message || '저장에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('저장 오류:', error);
                alert('저장 중 오류가 발생했습니다.');
            });
        }
        
        function removeFavorite(foodNum, foodName) {
            if (confirm(`'${foodName}'을(를) 즐겨찾기에서 제거하시겠습니까?`)) {
                fetch(`${pageContext.request.contextPath}/fooddiary/favorites/${foodNum}`, {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'action=remove'
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert(data.message || '제거에 실패했습니다.');
                    }
                })
                .catch(error => {
                    console.error('즐겨찾기 제거 오류:', error);
                    alert('처리 중 오류가 발생했습니다.');
                });
            }
        }
        
        function addToFavorites(foodNum, foodName) {
            fetch(`${pageContext.request.contextPath}/fooddiary/favorites/${foodNum}`, {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'action=add'
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(`'${foodName}'이(가) 즐겨찾기에 추가되었습니다!`);
                    location.reload();
                } else {
                    alert(data.message || '추가에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error('즐겨찾기 추가 오류:', error);
                alert('처리 중 오류가 발생했습니다.');
            });
        }
        
        function viewDetail(foodNum) {
            fetch(`${pageContext.request.contextPath}/fooddiary/api/food/${foodNum}`)
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        showFoodDetail(data.food);
                    } else {
                        alert('상세 정보를 불러올 수 없습니다.');
                    }
                })
                .catch(error => {
                    console.error('상세 정보 로드 실패:', error);
                    alert('정보를 불러오는 중 오류가 발생했습니다.');
                });
        }
        
        function showFoodDetail(food) {
            let info = `음식명: ${food.foodName}\n`;
            info += `카테고리: ${food.category}\n`;
            info += `칼로리: ${food.caloriesPer100g}kcal/100g\n`;
            if (food.proteinPer100g) info += `단백질: ${food.proteinPer100g}g/100g\n`;
            if (food.carbsPer100g) info += `탄수화물: ${food.carbsPer100g}g/100g\n`;
            if (food.fatPer100g) info += `지방: ${food.fatPer100g}g/100g\n`;
            
            alert(info);
        }
        
        document.getElementById('quickAddModal').addEventListener('hidden.bs.modal', function () {
            document.getElementById('quickAddForm').reset();
            document.getElementById('referenceWeights').innerHTML = '';
            selectedFood = null;
        });
    </script>
</body>
</html>