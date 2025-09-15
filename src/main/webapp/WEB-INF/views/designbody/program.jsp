<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>프로그램 목록 - 디자인바디</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .filter-card {
            background: #f8f9fa;
            border-radius: 12px;
            position: sticky;
            top: 20px;
        }
        .program-card {
            transition: all 0.3s ease;
            border-radius: 12px;
            overflow: hidden;
        }
        .program-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
        }
        .program-image {
            height: 200px;
            object-fit: cover;
        }
        .difficulty-badge {
            position: absolute;
            top: 12px;
            right: 12px;
        }
        .filter-btn {
            border-radius: 20px;
            margin: 2px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-4">
        <!-- 페이지 헤더 -->
        <div class="row mb-4">
            <div class="col-md-8">
                <h2 class="fw-bold">디자인바디 프로그램</h2>
                <p class="text-muted">목표에 맞는 완벽한 프로그램을 찾아보세요</p>
            </div>
            <div class="col-md-4 text-end">
                <div class="btn-group" role="group">
                    <input type="radio" class="btn-check" name="viewOptions" id="gridView" checked>
                    <label class="btn btn-outline-secondary" for="gridView">
                        <i class="fas fa-th"></i>
                    </label>
                    <input type="radio" class="btn-check" name="viewOptions" id="listView">
                    <label class="btn btn-outline-secondary" for="listView">
                        <i class="fas fa-list"></i>
                    </label>
                </div>
            </div>
        </div>
        
        <div class="row">
            <!-- 필터 사이드바 -->
            <div class="col-lg-3 mb-4">
                <div class="filter-card p-4">
                    <h5 class="mb-4">필터</h5>
                    
                    <!-- 카테고리 필터 -->
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3">카테고리</h6>
                        <div class="d-flex flex-wrap">
                            <button class="btn btn-outline-primary filter-btn ${empty currentType ? 'active' : ''}" 
                                    onclick="filterByType('')">전체</button>
                            <button class="btn btn-outline-danger filter-btn ${currentType == 'DIET' ? 'active' : ''}" 
                                    onclick="filterByType('DIET')">다이어트</button>
                            <button class="btn btn-outline-primary filter-btn ${currentType == 'MUSCLE' ? 'active' : ''}" 
                                    onclick="filterByType('MUSCLE')">근력강화</button>
                            <button class="btn btn-outline-success filter-btn ${currentType == 'CARDIO' ? 'active' : ''}" 
                                    onclick="filterByType('CARDIO')">유산소</button>
                            <button class="btn btn-outline-warning filter-btn ${currentType == 'REHAB' ? 'active' : ''}" 
                                    onclick="filterByType('REHAB')">재활운동</button>
                        </div>
                    </div>
                    
                    <!-- 난이도 필터 -->
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3">난이도</h6>
                        <div class="d-flex flex-wrap">
                            <button class="btn btn-outline-secondary filter-btn ${empty currentDifficulty ? 'active' : ''}" 
                                    onclick="filterByDifficulty('')">전체</button>
                            <button class="btn btn-outline-info filter-btn ${currentDifficulty == 'BEGINNER' ? 'active' : ''}" 
                                    onclick="filterByDifficulty('BEGINNER')">초급</button>
                            <button class="btn btn-outline-warning filter-btn ${currentDifficulty == 'INTERMEDIATE' ? 'active' : ''}" 
                                    onclick="filterByDifficulty('INTERMEDIATE')">중급</button>
                            <button class="btn btn-outline-danger filter-btn ${currentDifficulty == 'ADVANCED' ? 'active' : ''}" 
                                    onclick="filterByDifficulty('ADVANCED')">고급</button>
                        </div>
                    </div>
                    
                    <!-- 가격 필터 -->
                    <div class="mb-4">
                        <h6 class="fw-bold mb-3">가격</h6>
                        <div class="d-flex flex-column gap-2">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="freePrograms">
                                <label class="form-check-label" for="freePrograms">무료</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="paidPrograms">
                                <label class="form-check-label" for="paidPrograms">유료</label>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 필터 초기화 -->
                    <div class="d-grid">
                        <button class="btn btn-outline-secondary" onclick="resetFilters()">
                            <i class="fas fa-refresh me-2"></i>필터 초기화
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- 프로그램 목록 -->
            <div class="col-lg-9">
                <!-- 정렬 옵션 -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <span class="text-muted">총 ${programs.size()}개 프로그램</span>
                    </div>
                    <div class="dropdown">
                        <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                            정렬
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#" onclick="sortPrograms('latest')">최신순</a></li>
                            <li><a class="dropdown-item" href="#" onclick="sortPrograms('popular')">인기순</a></li>
                            <li><a class="dropdown-item" href="#" onclick="sortPrograms('price_low')">가격 낮은순</a></li>
                            <li><a class="dropdown-item" href="#" onclick="sortPrograms('price_high')">가격 높은순</a></li>
                        </ul>
                    </div>
                </div>
                
                <!-- 프로그램 그리드 -->
                <div class="row" id="programGrid">
                    <c:forEach var="program" items="${programs}">
                        <div class="col-lg-4 col-md-6 mb-4 program-item" 
                             data-type="${program.programType}" 
                             data-difficulty="${program.difficulty}"
                             data-price="${program.price}">
                            <div class="card program-card h-100 position-relative">
                                <img src="${pageContext.request.contextPath}/resources/images/designbody/programs/${program.imagePath != null ? program.imagePath : 'default-program.jpg'}" 
                                     class="card-img-top program-image" alt="${program.programName}">
                                <div class="difficulty-badge">
                                    <span class="badge bg-primary">${program.difficultyText}</span>
                                </div>
                                <div class="card-body d-flex flex-column">
                                    <div class="d-flex justify-content-between align-items-start mb-2">
                                        <span class="badge bg-secondary">${program.typeText}</span>
                                        <strong class="text-primary">${program.formattedPrice}</strong>
                                    </div>
                                    <h5 class="card-title">${program.programName}</h5>
                                    <p class="card-text text-muted flex-grow-1">${program.description}</p>
                                    
                                    <div class="program-meta mb-3">
                                        <div class="d-flex justify-content-between text-muted small">
                                            <span><i class="fas fa-clock me-1"></i>${program.duration}일</span>
                                            <span><i class="fas fa-user me-1"></i>${program.instructor}</span>
                                        </div>
                                    </div>
                                    
                                    <div class="mt-auto">
                                        <div class="d-grid">
                                            <a href="${pageContext.request.contextPath}/designbody/detail/${program.programNum}" 
                                               class="btn btn-primary">자세히 보기</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <!-- 프로그램이 없는 경우 -->
                <c:if test="${empty programs}">
                    <div class="text-center py-5">
                        <i class="fas fa-search fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">조건에 맞는 프로그램이 없습니다</h5>
                        <p class="text-muted">다른 조건으로 검색해보세요</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function filterByType(type) {
            const url = new URL(window.location);
            if (type) {
                url.searchParams.set('type', type);
            } else {
                url.searchParams.delete('type');
            }
            url.searchParams.delete('difficulty');
            window.location.href = url.toString();
        }
        
        function filterByDifficulty(difficulty) {
            const url = new URL(window.location);
            if (difficulty) {
                url.searchParams.set('difficulty', difficulty);
            } else {
                url.searchParams.delete('difficulty');
            }
            url.searchParams.delete('type');
            window.location.href = url.toString();
        }
        
        function resetFilters() {
            window.location.href = '${pageContext.request.contextPath}/designbody/programs';
        }
        
        function sortPrograms(sortType) {
            // 클라이언트 사이드 정렬 (실제로는 서버에서 처리하는 것이 좋음)
            const grid = document.getElementById('programGrid');
            const items = Array.from(grid.children);
            
            items.sort((a, b) => {
                switch(sortType) {
                    case 'price_low':
                        return parseInt(a.dataset.price) - parseInt(b.dataset.price);
                    case 'price_high':
                        return parseInt(b.dataset.price) - parseInt(a.dataset.price);
                    default:
                        return 0;
                }
            });
            
            items.forEach(item => grid.appendChild(item));
        }
        
        // 보기 방식 변경
        document.getElementById('listView').addEventListener('change', function() {
            document.getElementById('programGrid').classList.remove('row');
            document.getElementById('programGrid').classList.add('list-view');
        });
        
        document.getElementById('gridView').addEventListener('change', function() {
            document.getElementById('programGrid').classList.remove('list-view');
            document.getElementById('programGrid').classList.add('row');
        });
    </script>
</body>
</html>