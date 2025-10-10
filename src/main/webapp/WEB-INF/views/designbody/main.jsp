<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>디자인바디 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
<<<<<<< HEAD
        :root {
            --primary-gradient: linear-gradient(135deg, #FF6A00, #ff8533);
            --secondary-gradient: linear-gradient(135deg, #28a745, #20c997);
        }
        .hero-section {
            background: var(--primary-gradient);
            color: white;
            padding: 80px 0;
            position: relative;
            overflow: hidden;
        }
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="rgba(255,255,255,0.1)"/><circle cx="75" cy="75" r="1" fill="rgba(255,255,255,0.1)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
=======
        .hero-section {
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            color: white;
            padding: 80px 0;
        }
        .stats-card {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border-radius: 16px;
>>>>>>> b65c320 (Initial commit)
        }
        .program-card {
            transition: all 0.3s ease;
            border-radius: 16px;
<<<<<<< HEAD
            overflow: hidden;
            height: 100%;
        }
        .program-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0,0,0,0.15);
        }
        .program-image {
            height: 200px;
            object-fit: cover;
        }
        .difficulty-badge {
            position: absolute;
            top: 15px;
            right: 15px;
        }
        .stats-card {
            background: var(--secondary-gradient);
            color: white;
            border-radius: 16px;
        }
        .category-btn {
            border-radius: 25px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all 0.3s;
        }
        .category-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
=======
        }
        .program-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.15);
>>>>>>> b65c320 (Initial commit)
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- Hero Section -->
    <div class="hero-section">
<<<<<<< HEAD
        <div class="container position-relative">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">디자인바디</h1>
                    <p class="lead mb-4">전문 트레이너와 함께하는 맞춤형 운동 프로그램으로<br>당신만의 완벽한 몸매를 디자인하세요</p>
                    <div class="d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/designbody/programs" class="btn btn-light btn-lg">
                            프로그램 둘러보기
                        </a>
                        <c:if test="${not empty sessionScope.userNum}">
                            <a href="${pageContext.request.contextPath}/designbody/my" class="btn btn-outline-light btn-lg">
=======
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">디자인바디</h1>
                    <p class="lead mb-4">전국 헬킹 가맹점에서 만나는 전문 디자인바디 프로그램<br>당신만의 완벽한 몸매를 디자인하세요</p>
                    <div class="d-flex gap-3">
                        <a href="${pageContext.request.contextPath}/designbody/chain/programs" class="btn btn-light btn-lg">
                            가맹점 프로그램 보기
                        </a>
                        <c:if test="${not empty sessionScope.userNum}">
                            <a href="${pageContext.request.contextPath}/designbody/chain/my" class="btn btn-outline-light btn-lg">
>>>>>>> b65c320 (Initial commit)
                                내 프로그램
                            </a>
                        </c:if>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <img src="${pageContext.request.contextPath}/resources/images/designbody/hero-image.jpg" 
                         class="img-fluid rounded" alt="디자인바디" style="max-height: 400px;">
                </div>
            </div>
        </div>
    </div>
    
    <!-- 통계 섹션 -->
    <div class="container mt-5 mb-5">
        <div class="row">
<<<<<<< HEAD
            <div class="col-md-4 mb-3">
=======
            <div class="col-md-3 mb-3">
                <div class="stats-card p-4 text-center">
                    <div class="display-5 fw-bold">${chainStats.size()}</div>
                    <p class="mb-0">전국 가맹점</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
>>>>>>> b65c320 (Initial commit)
                <div class="stats-card p-4 text-center">
                    <div class="display-5 fw-bold">${stats.totalPrograms}</div>
                    <p class="mb-0">전문 프로그램</p>
                </div>
            </div>
<<<<<<< HEAD
            <div class="col-md-4 mb-3">
                <div class="stats-card p-4 text-center">
                    <div class="display-5 fw-bold">${stats.activeEnrollments}</div>
                    <p class="mb-0">진행중인 회원</p>
                </div>
            </div>
            <div class="col-md-4 mb-3">
=======
            <div class="col-md-3 mb-3">
                <div class="stats-card p-4 text-center">
                    <div class="display-5 fw-bold">${stats.activeEnrollments}</div>
                    <p class="mb-0">참여 회원</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
>>>>>>> b65c320 (Initial commit)
                <div class="stats-card p-4 text-center">
                    <div class="display-5 fw-bold">98%</div>
                    <p class="mb-0">만족도</p>
                </div>
            </div>
        </div>
    </div>
    
<<<<<<< HEAD
    <!-- 카테고리 섹션 -->
=======
    <!-- 프로그램 카테고리 -->
>>>>>>> b65c320 (Initial commit)
    <div class="container mb-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold">프로그램 카테고리</h2>
            <p class="text-muted">목표에 맞는 완벽한 프로그램을 선택하세요</p>
        </div>
        
        <div class="row justify-content-center">
            <div class="col-lg-3 col-md-6 mb-3">
<<<<<<< HEAD
                <a href="${pageContext.request.contextPath}/designbody/type/diet" 
                   class="btn btn-outline-primary category-btn w-100 h-100 d-flex flex-column align-items-center justify-content-center">
=======
                <a href="${pageContext.request.contextPath}/designbody/chain/type/diet" 
                   class="btn btn-outline-primary w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4">
>>>>>>> b65c320 (Initial commit)
                    <i class="fas fa-weight-scale fa-2x mb-3 text-danger"></i>
                    <h5>다이어트</h5>
                    <p class="small text-muted mb-0">체중감량 & 체지방 관리</p>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
<<<<<<< HEAD
                <a href="${pageContext.request.contextPath}/designbody/type/muscle" 
                   class="btn btn-outline-primary category-btn w-100 h-100 d-flex flex-column align-items-center justify-content-center">
=======
                <a href="${pageContext.request.contextPath}/designbody/chain/type/muscle" 
                   class="btn btn-outline-primary w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4">
>>>>>>> b65c320 (Initial commit)
                    <i class="fas fa-dumbbell fa-2x mb-3 text-primary"></i>
                    <h5>근력강화</h5>
                    <p class="small text-muted mb-0">근육량 증가 & 체형 교정</p>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
<<<<<<< HEAD
                <a href="${pageContext.request.contextPath}/designbody/type/cardio" 
                   class="btn btn-outline-primary category-btn w-100 h-100 d-flex flex-column align-items-center justify-content-center">
=======
                <a href="${pageContext.request.contextPath}/designbody/chain/type/cardio" 
                   class="btn btn-outline-primary w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4">
>>>>>>> b65c320 (Initial commit)
                    <i class="fas fa-heart-pulse fa-2x mb-3 text-success"></i>
                    <h5>유산소</h5>
                    <p class="small text-muted mb-0">심폐기능 & 지구력 향상</p>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 mb-3">
<<<<<<< HEAD
                <a href="${pageContext.request.contextPath}/designbody/type/rehab" 
                   class="btn btn-outline-primary category-btn w-100 h-100 d-flex flex-column align-items-center justify-content-center">
=======
                <a href="${pageContext.request.contextPath}/designbody/chain/type/rehab" 
                   class="btn btn-outline-primary w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4">
>>>>>>> b65c320 (Initial commit)
                    <i class="fas fa-user-doctor fa-2x mb-3 text-warning"></i>
                    <h5>재활운동</h5>
                    <p class="small text-muted mb-0">부상 예방 & 관리</p>
                </a>
            </div>
        </div>
    </div>
    
<<<<<<< HEAD
    <!-- 추천 프로그램 -->
    <div class="container mb-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold">추천 프로그램</h2>
            <p class="text-muted">전문가가 엄선한 인기 프로그램</p>
        </div>
        
        <div class="row">
            <c:forEach var="program" items="${recommended.popular}" end="2">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card program-card position-relative">
                        <img src="${pageContext.request.contextPath}/resources/images/designbody/programs/${program.imagePath != null ? program.imagePath : 'default-program.jpg'}" 
                             class="card-img-top program-image" alt="${program.programName}">
                        <div class="difficulty-badge">
                            <span class="badge bg-primary">${program.difficultyText}</span>
                        </div>
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <span class="badge bg-secondary">${program.typeText}</span>
                                <strong class="text-primary">${program.formattedPrice}</strong>
=======
    <!-- 인기 가맹점 프로그램 -->
    <div class="container mb-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold">인기 가맹점 프로그램</h2>
            <p class="text-muted">전국에서 가장 인기있는 프로그램들</p>
        </div>
        
        <div class="row">
            <c:forEach var="program" items="${chainRecommended.popular}" end="2">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="card program-card h-100">
                        <img src="${pageContext.request.contextPath}/resources/images/designbody/programs/${program.imagePath != null ? program.imagePath : 'default-program.jpg'}" 
                             class="card-img-top" style="height: 200px; object-fit: cover;" alt="${program.programName}">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <span class="badge bg-primary">${program.chainName}</span>
                                <strong class="text-primary">${program.formattedFinalPrice}</strong>
>>>>>>> b65c320 (Initial commit)
                            </div>
                            <h5 class="card-title">${program.programName}</h5>
                            <p class="card-text text-muted">${program.description}</p>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <small class="text-muted">
<<<<<<< HEAD
                                    <i class="fas fa-clock me-1"></i>${program.duration}일 과정
                                </small>
                                <small class="text-muted">
                                    <i class="fas fa-user me-1"></i>${program.instructor}
                                </small>
                            </div>
                            <div class="d-grid">
                                <a href="${pageContext.request.contextPath}/designbody/detail/${program.programNum}" 
=======
                                    <i class="fas fa-user me-1"></i>${program.instructor}
                                </small>
                                <span class="badge ${program.statusBadgeClass}">${program.statusText}</span>
                            </div>
                            <div class="d-grid">
                                <a href="${pageContext.request.contextPath}/designbody/chain/detail/${program.programNum}" 
>>>>>>> b65c320 (Initial commit)
                                   class="btn btn-primary">자세히 보기</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <!-- 더보기 카드 -->
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="card program-card h-100 d-flex align-items-center justify-content-center">
                    <div class="card-body text-center">
                        <i class="fas fa-plus-circle fa-3x text-muted mb-3"></i>
                        <h5 class="text-muted">더 많은 프로그램</h5>
<<<<<<< HEAD
                        <a href="${pageContext.request.contextPath}/designbody/programs" class="btn btn-outline-primary">
=======
                        <a href="${pageContext.request.contextPath}/designbody/chain/programs" class="btn btn-outline-primary">
>>>>>>> b65c320 (Initial commit)
                            전체 프로그램 보기
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
<<<<<<< HEAD
    <!-- 특별 추천 프로그램 -->
    <div class="bg-light py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="fw-bold">이런 분들께 추천</h2>
            </div>
            
            <div class="row">
                <c:if test="${not empty recommended.diet}">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-weight-scale fa-3x text-danger mb-3"></i>
                                <h5>체중감량이 목표라면</h5>
                                <p class="text-muted">${recommended.diet.programName}</p>
                                <a href="${pageContext.request.contextPath}/designbody/detail/${recommended.diet.programNum}" 
                                   class="btn btn-outline-danger">시작하기</a>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty recommended.muscle}">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-dumbbell fa-3x text-primary mb-3"></i>
                                <h5>근육을 키우고 싶다면</h5>
                                <p class="text-muted">${recommended.muscle.programName}</p>
                                <a href="${pageContext.request.contextPath}/designbody/detail/${recommended.muscle.programNum}" 
                                   class="btn btn-outline-primary">시작하기</a>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <c:if test="${not empty recommended.cardio}">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-heart-pulse fa-3x text-success mb-3"></i>
                                <h5>체력을 기르고 싶다면</h5>
                                <p class="text-muted">${recommended.cardio.programName}</p>
                                <a href="${pageContext.request.contextPath}/designbody/detail/${recommended.cardio.programNum}" 
                                   class="btn btn-outline-success">시작하기</a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
=======
>>>>>>> b65c320 (Initial commit)
    <!-- CTA 섹션 -->
    <div class="container py-5">
        <div class="text-center">
            <h2 class="fw-bold mb-4">지금 시작하세요</h2>
<<<<<<< HEAD
            <p class="lead text-muted mb-4">전문적인 프로그램으로 목표를 달성하세요</p>
            <c:choose>
                <c:when test="${not empty sessionScope.userNum}">
                    <a href="${pageContext.request.contextPath}/designbody/programs" class="btn btn-primary btn-lg me-3">
                        프로그램 선택하기
                    </a>
                    <a href="${pageContext.request.contextPath}/designbody/my" class="btn btn-outline-primary btn-lg">
=======
            <p class="lead text-muted mb-4">가장 가까운 헬킹 가맹점에서 전문적인 프로그램으로 목표를 달성하세요</p>
            <c:choose>
                <c:when test="${not empty sessionScope.userNum}">
                    <a href="${pageContext.request.contextPath}/designbody/chain/programs" class="btn btn-primary btn-lg me-3">
                        프로그램 선택하기
                    </a>
                    <a href="${pageContext.request.contextPath}/designbody/chain/my" class="btn btn-outline-primary btn-lg">
>>>>>>> b65c320 (Initial commit)
                        내 진행상황 보기
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary btn-lg me-3">
                        로그인하고 시작하기
                    </a>
                    <a href="${pageContext.request.contextPath}/user/join" class="btn btn-outline-primary btn-lg">
                        회원가입
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
<<<<<<< HEAD
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
=======
>>>>>>> b65c320 (Initial commit)
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>