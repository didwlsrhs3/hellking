<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${typeText} 프로그램 - 디자인바디</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .category-hero {
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            color: white;
            padding: 60px 0;
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
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 카테고리 히어로 -->
    <div class="category-hero">
        <div class="container">
            <div class="text-center">
                <h1 class="display-4 fw-bold mb-3">${typeText} 프로그램</h1>
                <p class="lead">전문적인 ${typeText} 프로그램으로 목표를 달성하세요</p>
            </div>
        </div>
    </div>
    
    <div class="container mt-5">
        <!-- 프로그램 목록 -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h3 class="fw-bold">${typeText} 프로그램 목록</h3>
                <p class="text-muted">총 ${programs.size()}개의 프로그램이 있습니다</p>
            </div>
            <div class="col-md-6 text-end">
                <a href="${pageContext.request.contextPath}/designbody/programs" class="btn btn-outline-primary">
                    전체 프로그램 보기
                </a>
            </div>
        </div>
        
        <div class="row">
            <c:choose>
                <c:when test="${not empty programs}">
                    <c:forEach var="program" items="${programs}">
                        <div class="col-lg-4 col-md-6 mb-4">
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
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="text-center py-5">
                            <i class="fas fa-search fa-3x text-muted mb-3"></i>
                            <h5 class="text-muted">${typeText} 프로그램이 준비 중입니다</h5>
                            <p class="text-muted">곧 다양한 프로그램을 만나보실 수 있습니다</p>
                            <a href="${pageContext.request.contextPath}/designbody/programs" class="btn btn-primary">
                                다른 프로그램 보기
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
        <!-- 추천 프로그램 -->
        <div class="mt-5 pt-5 border-top">
            <h4 class="fw-bold mb-4">다른 카테고리도 확인해보세요</h4>
            <div class="row">
                <div class="col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/designbody/type/diet" 
                       class="btn btn-outline-danger w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4">
                        <i class="fas fa-weight-scale fa-2x mb-2"></i>
                        <h6>다이어트</h6>
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/designbody/type/muscle" 
                       class="btn btn-outline-primary w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4">
                        <i class="fas fa-dumbbell fa-2x mb-2"></i>
                        <h6>근력강화</h6>
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/designbody/type/cardio" 
                       class="btn btn-outline-success w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4">
                        <i class="fas fa-heart-pulse fa-2x mb-2"></i>
                        <h6>유산소</h6>
                    </a>
                </div>
                <div class="col-md-3 mb-3">
                    <a href="${pageContext.request.contextPath}/designbody/type/rehab" 
                       class="btn btn-outline-warning w-100 h-100 d-flex flex-column align-items-center justify-content-center p-4">
                        <i class="fas fa-user-doctor fa-2x mb-2"></i>
                        <h6>재활운동</h6>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>