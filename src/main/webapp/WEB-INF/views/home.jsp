<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>헬킹 피트니스 - 전국 어디서나 자유롭게</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
        }
        .hero-section {
            background: linear-gradient(135deg, var(--brand), #ff8533);
            color: white;
            padding: 100px 0;
            text-align: center;
        }
        .feature-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            height: 100%;
            transition: transform 0.2s;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 20px;
        }
        .cta-section {
            background: var(--bg-cream);
            padding: 80px 0;
            text-align: center;
        }
        .btn-cta {
            background: var(--brand);
            border: none;
            color: white;
            font-weight: 700;
            padding: 15px 40px;
            border-radius: 50px;
            font-size: 1.2rem;
            text-decoration: none;
        }
        .btn-cta:hover {
            background: #e55a00;
            color: white;
            transform: translateY(-2px);
        }
        .stats-section {
            background: white;
            padding: 60px 0;
        }
        .stat-number {
            font-size: 3rem;
            font-weight: 900;
            color: var(--brand);
        }
    </style>
</head>
<body>
    <jsp:include page="common/header.jsp" />
    
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <h1 class="display-3 fw-bold mb-4">전국 어디서나 자유롭게</h1>
            <p class="lead mb-5">하나의 패스권으로 전국 모든 헬킹 가맹점을 이용하세요</p>
            
            <c:choose>
                <c:when test="${not empty sessionScope.userNum}">
                    <a href="${pageContext.request.contextPath}/qr/enter" class="btn btn-cta me-3">
                        QR 입장하기
                    </a>
                    <a href="${pageContext.request.contextPath}/user/mypage" class="btn btn-outline-light">
                        마이페이지
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/pass/list" class="btn btn-cta me-3">
                        패스권 보기
                    </a>
                    <a href="${pageContext.request.contextPath}/user/join" class="btn btn-outline-light">
                        회원가입
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- Features Section -->
    <div class="container py-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold">헬킹의 특별함</h2>
            <p class="text-muted">왜 헬킹을 선택해야 할까요?</p>
        </div>
        
        <div class="row">
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="feature-card">
                    <div class="feature-icon">🏋️</div>
                    <h5>전국 자유 이용</h5>
                    <p class="text-muted">하나의 패스권으로 전국 모든 가맹점을 자유롭게 이용하세요.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="feature-card">
                    <div class="feature-icon">📱</div>
                    <h5>QR 간편 입장</h5>
                    <p class="text-muted">복잡한 절차 없이 QR 코드만으로 간편하게 입장하세요.</p>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="feature-card">
                    <div class="feature-icon">⏰</div>
                    <h5>24시간 언제든지</h5>
                    <p class="text-muted">새벽이든 심야든, 여러분의 스케줄에 맞춰 운동하세요.</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Stats Section -->
    <div class="stats-section">
        <div class="container">
            <div class="row text-center">
                <div class="col-md-3 mb-4">
                    <div class="stat-number">150+</div>
                    <p class="text-muted">전국 가맹점</p>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-number">50K+</div>
                    <p class="text-muted">활성 회원</p>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-number">1M+</div>
                    <p class="text-muted">월간 방문</p>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-number">4.8★</div>
                    <p class="text-muted">평균 만족도</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- How it Works Section -->
    <div class="container py-5">
        <div class="text-center mb-5">
            <h2 class="fw-bold">이용 방법</h2>
            <p class="text-muted">간단한 3단계로 시작하세요</p>
        </div>
        
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="text-center">
                    <div class="display-4 text-primary mb-3">1</div>
                    <h5>패스권 구매</h5>
                    <p class="text-muted">원하는 기간의 패스권을 선택하고 간편하게 결제하세요.</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="text-center">
                    <div class="display-4 text-primary mb-3">2</div>
                    <h5>가맹점 방문</h5>
                    <p class="text-muted">전국 어느 헬킹 가맹점이든 자유롭게 방문하세요.</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="text-center">
                    <div class="display-4 text-primary mb-3">3</div>
                    <h5>QR 코드 입장</h5>
                    <p class="text-muted">가맹점 코드를 입력하거나 QR 코드로 간편하게 입장하세요.</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- CTA Section -->
    <div class="cta-section">
        <div class="container">
            <h2 class="fw-bold mb-4">지금 시작하세요!</h2>
            <p class="lead mb-4">건강한 삶의 변화가 여기서 시작됩니다</p>
            
            <c:choose>
                <c:when test="${not empty sessionScope.userNum}">
                    <a href="${pageContext.request.contextPath}/pass/list" class="btn btn-cta">
                        패스권 구매하기
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/join" class="btn btn-cta">
                        무료 회원가입
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
