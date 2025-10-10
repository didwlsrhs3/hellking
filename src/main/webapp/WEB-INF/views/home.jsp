<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>헬킹 피트니스 - 전국 어디서나 자유롭게</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<<<<<<< HEAD
=======
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
>>>>>>> b65c320 (Initial commit)
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
<<<<<<< HEAD
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
=======
            --muted: #5B6170;
            --line: #E7E0D6;
            --hover: #FFF5EA;
            --radius: 14px;
        }
        
        body {
            background: white;
            color: var(--ink);
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }
        
        /* Hero Section - 헤더와 통일된 색상 사용 */
        .hero-section {
            background: linear-gradient(135deg, var(--brand), #ff8533);
            color: white;
            padding: 120px 0 80px;
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
            background: radial-gradient(circle at 30% 50%, rgba(255,255,255,0.1) 0%, transparent 50%);
            pointer-events: none;
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
            text-align: center;
            max-width: 800px;
            margin: 0 auto;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 900;
            margin-bottom: 1.5rem;
            line-height: 1.2;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 2.5rem;
            opacity: 0.95;
            font-weight: 400;
        }
        
        .hero-buttons {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .btn-hero-primary {
            background: white;
            color: var(--brand);
            border: 2px solid white;
            font-weight: 700;
            padding: 15px 35px;
            border-radius: 50px;
            font-size: 1.1rem;
            text-decoration: none;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .btn-hero-primary:hover {
            background: transparent;
            color: white;
            border-color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,0,0,0.2);
        }
        
        .btn-hero-secondary {
            background: transparent;
            color: white;
            border: 2px solid rgba(255,255,255,0.5);
            font-weight: 600;
            padding: 15px 35px;
            border-radius: 50px;
            font-size: 1.1rem;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .btn-hero-secondary:hover {
            background: rgba(255,255,255,0.1);
            border-color: white;
            color: white;
            transform: translateY(-2px);
        }
        
        /* Features Section - 다른 페이지와 통일된 카드 스타일 */
        .features-section {
            padding: 80px 0;
            background: white;
        }
        
        .section-header {
            text-align: center;
            margin-bottom: 4rem;
        }
        
        .section-title {
            font-size: 2.5rem;
            font-weight: 900;
            color: var(--ink);
            margin-bottom: 1rem;
        }
        
        .section-subtitle {
            font-size: 1.2rem;
            color: var(--muted);
            max-width: 600px;
            margin: 0 auto;
        }
        
        .feature-card {
            background: white;
            border: 1px solid var(--line);
            border-radius: var(--radius);
            padding: 2.5rem;
            text-align: center;
            height: 100%;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(15,23,42,0.1);
            border-color: var(--brand);
        }
        
        .feature-icon {
            font-size: 3.5rem;
            color: var(--brand);
            margin-bottom: 1.5rem;
            display: block;
        }
        
        .feature-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--ink);
            margin-bottom: 1rem;
        }
        
        .feature-description {
            color: var(--muted);
            line-height: 1.6;
            font-size: 1rem;
        }
        
        /* Stats Section - 크림 배경으로 변경 */
        .stats-section {
            background: var(--bg-cream);
            padding: 80px 0;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 2rem;
        }
        
        .stat-item {
            text-align: center;
            padding: 1.5rem;
        }
        
        .stat-number {
            font-size: 3.5rem;
            font-weight: 900;
            color: var(--brand);
            display: block;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            color: var(--muted);
            font-size: 1.1rem;
            font-weight: 500;
        }
        
        /* How it Works - 개선된 스텝 디자인 */
        .steps-section {
            padding: 80px 0;
            background: white;
        }
        
        .step-item {
            text-align: center;
            position: relative;
        }
        
        .step-number {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, var(--brand), #ff8533);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            font-weight: 900;
            margin: 0 auto 1.5rem;
            box-shadow: 0 8px 25px rgba(255,106,0,0.3);
        }
        
        .step-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--ink);
            margin-bottom: 1rem;
        }
        
        .step-description {
            color: var(--muted);
            line-height: 1.6;
        }
        
        /* CTA Section - 다른 페이지와 유사한 헤더 스타일 적용 */
        .cta-section {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 100px 0;
            text-align: center;
            position: relative;
        }
        
        .cta-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 70% 50%, rgba(255,255,255,0.1) 0%, transparent 50%);
            pointer-events: none;
        }
        
        .cta-content {
            position: relative;
            z-index: 2;
            max-width: 700px;
            margin: 0 auto;
        }
        
        .cta-title {
            font-size: 2.8rem;
            font-weight: 900;
            margin-bottom: 1.5rem;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .cta-subtitle {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }
        
        .btn-cta {
            background: var(--brand);
            border: 2px solid var(--brand);
            color: white;
            font-weight: 700;
            padding: 18px 40px;
            border-radius: 50px;
            font-size: 1.2rem;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
            box-shadow: 0 6px 20px rgba(255,106,0,0.3);
        }
        
        .btn-cta:hover {
            background: white;
            color: var(--brand);
            border-color: white;
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(255,106,0,0.4);
        }
        
        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-subtitle {
                font-size: 1.1rem;
            }
            
            .hero-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn-hero-primary,
            .btn-hero-secondary {
                width: 280px;
                text-align: center;
            }
            
            .section-title {
                font-size: 2rem;
            }
            
            .cta-title {
                font-size: 2.2rem;
            }
            
            .feature-card {
                margin-bottom: 2rem;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 1rem;
            }
        }
        
        /* 알림 메시지 스타일 개선 */
        .alert {
            border: none;
            border-radius: var(--radius);
            margin-bottom: 0;
            position: relative;
            z-index: 10;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }
        
        /* 로딩 애니메이션 */
        .feature-card,
        .stat-item,
        .step-item {
            opacity: 0;
            transform: translateY(30px);
            animation: fadeInUp 0.6s ease forwards;
        }
        
        .feature-card:nth-child(1) { animation-delay: 0.1s; }
        .feature-card:nth-child(2) { animation-delay: 0.2s; }
        .feature-card:nth-child(3) { animation-delay: 0.3s; }
        
        @keyframes fadeInUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
>>>>>>> b65c320 (Initial commit)
        }
    </style>
</head>
<body>
    <jsp:include page="common/header.jsp" />
<<<<<<< HEAD
    
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
=======

    <!-- 알림 메시지들 -->
    <c:if test="${param.debug == 'true'}">
        <div class="container mt-3">
            <div class="alert alert-info">
                <h6>디버깅 정보:</h6>
                <p>successMessage: ${sessionScope.successMessage}</p>
                <p>userNum: ${sessionScope.userNum}</p>
                <p>userId: ${sessionScope.userId}</p>
            </div>
        </div>
    </c:if>
    
    <c:if test="${not empty sessionScope.successMessage}">
        <div class="container mt-3">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
        <c:remove var="successMessage" scope="session" />
    </c:if>
    
    <c:if test="${not empty message}">
        <div class="container mt-3">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </div>
    </c:if>
    
    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="hero-content">
                <h1 class="hero-title">전국 어디서나 자유롭게</h1>
                <p class="hero-subtitle">하나의 패스권으로 전국 모든 헬킹 가맹점을 이용하세요</p>
                
                <div class="hero-buttons">
                    <c:choose>
                        <c:when test="${not empty sessionScope.userNum}">
                            <a href="${pageContext.request.contextPath}/chain/nearby" class="btn-hero-primary">
                                <i class="fas fa-qrcode me-2"></i>내 인근 가맹점 찾기
                            </a>
                            <a href="${pageContext.request.contextPath}/user/mypage" class="btn-hero-secondary">
                                <i class="fas fa-user me-2"></i>마이페이지
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/chain/list" class="btn-hero-primary">
                                <i class="fas fa-ticket-alt me-2"></i>가맹점 소개
                            </a>
                            <a href="${pageContext.request.contextPath}/user/join" class="btn-hero-secondary">
                                <i class="fas fa-user-plus me-2"></i>회원가입
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Features Section -->
    <section class="features-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">헬킹의 특별함</h2>
                <p class="section-subtitle">왜 헬킹을 선택해야 할까요?</p>
            </div>
            
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="feature-card">
                        <i class="fas fa-dumbbell feature-icon"></i>
                        <h5 class="feature-title">전국 자유 이용</h5>
                        <p class="feature-description">하나의 패스권으로 전국 모든 가맹점을 자유롭게 이용하세요.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="feature-card">
                        <i class="fas fa-qrcode feature-icon"></i>
                        <h5 class="feature-title">QR 간편 입장</h5>
                        <p class="feature-description">복잡한 절차 없이 QR 코드만으로 간편하게 입장하세요.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="feature-card">
                        <i class="fas fa-clock feature-icon"></i>
                        <h5 class="feature-title">24시간 언제든지</h5>
                        <p class="feature-description">새벽이든 심야든, 여러분의 스케줄에 맞춰 운동하세요.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="stats-grid">
                <div class="stat-item">
                    <span class="stat-number">150+</span>
                    <p class="stat-label">전국 가맹점</p>
                </div>
                <div class="stat-item">
                    <span class="stat-number">50K+</span>
                    <p class="stat-label">활성 회원</p>
                </div>
                <div class="stat-item">
                    <span class="stat-number">1M+</span>
                    <p class="stat-label">월간 방문</p>
                </div>
                <div class="stat-item">
                    <span class="stat-number">4.8★</span>
                    <p class="stat-label">평균 만족도</p>
                </div>
            </div>
        </div>
    </section>
    
    <!-- How it Works Section -->
    <section class="steps-section">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">이용 방법</h2>
                <p class="section-subtitle">간단한 3단계로 시작하세요</p>
            </div>
            
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="step-item">
                        <div class="step-number">1</div>
                        <h5 class="step-title">패스권 구매</h5>
                        <p class="step-description">원하는 기간의 패스권을 선택하고 간편하게 결제하세요.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="step-item">
                        <div class="step-number">2</div>
                        <h5 class="step-title">가맹점 방문</h5>
                        <p class="step-description">전국 어느 헬킹 가맹점이든 자유롭게 방문하세요.</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="step-item">
                        <div class="step-number">3</div>
                        <h5 class="step-title">QR 코드 입장</h5>
                        <p class="step-description">가맹점 코드를 입력하거나 QR 코드로 간편하게 입장하세요.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- CTA Section -->
    <section class="cta-section">
        <div class="container">
            <div class="cta-content">
                <h2 class="cta-title">지금 시작하세요!</h2>
                <p class="cta-subtitle">건강한 삶의 변화가 여기서 시작됩니다</p>
                
                <c:choose>
                    <c:when test="${not empty sessionScope.userNum}">
                        <a href="${pageContext.request.contextPath}/pass/list" class="btn-cta">
                            <i class="fas fa-shopping-cart me-2"></i>패스권 구매하기
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/user/join" class="btn-cta">
                            <i class="fas fa-user-plus me-2"></i>무료 회원가입
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>
    
	<jsp:include page="common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 스크롤 애니메이션
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.animationPlayState = 'running';
                }
            });
        }, observerOptions);

        // 애니메이션 대상 요소들 관찰
        document.querySelectorAll('.feature-card, .stat-item, .step-item').forEach(el => {
            observer.observe(el);
        });

        // 숫자 카운트 애니메이션
        function animateNumbers() {
            const numbers = document.querySelectorAll('.stat-number');
            
            numbers.forEach(number => {
                const text = number.textContent;
                const isStars = text.includes('★');
                
                if (!isStars) {
                    const finalNumber = parseInt(text.replace(/[^\d]/g, ''));
                    const increment = finalNumber / 100;
                    let current = 0;
                    
                    const timer = setInterval(() => {
                        current += increment;
                        if (current >= finalNumber) {
                            number.textContent = text;
                            clearInterval(timer);
                        } else {
                            const suffix = text.includes('K') ? 'K+' : text.includes('M') ? 'M+' : '+';
                            number.textContent = Math.floor(current) + suffix;
                        }
                    }, 20);
                }
            });
        }

        // 스탯 섹션이 보일 때 숫자 애니메이션 실행
        const statsObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    animateNumbers();
                    statsObserver.unobserve(entry.target);
                }
            });
        });

        const statsSection = document.querySelector('.stats-section');
        if (statsSection) {
            statsObserver.observe(statsSection);
        }

        // 부드러운 스크롤
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    </script>
</body>
</html>
>>>>>>> b65c320 (Initial commit)
