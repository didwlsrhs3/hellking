<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<<<<<<< HEAD
=======
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

>>>>>>> b65c320 (Initial commit)
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>패스권 목록 - 헬킹 피트니스</title>
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
        body { background: var(--bg-cream); }
        .pass-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
            height: 100%;
        }
        .pass-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(15,23,42,0.15);
        }
        .pass-popular {
            border: 2px solid var(--brand);
            position: relative;
        }
        .popular-badge {
            position: absolute;
            top: -10px;
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
        
        .page-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 60px 0;
            position: relative;
        }
        
        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 30% 50%, rgba(255,255,255,0.1) 0%, transparent 50%);
            pointer-events: none;
        }
        
        .page-header h2 {
            font-size: 2.5rem;
            font-weight: 900;
            margin-bottom: 15px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }
        
        .page-header p {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        /* 패스권 카드 섹션 */
        .pass-cards-section {
            padding: 100px 0 60px;
            background: linear-gradient(180deg, #fafbfc 0%, white 100%);
        }
        
        .section-intro {
            text-align: center;
            margin-bottom: 4rem;
        }
        
        .section-intro h3 {
            font-size: 2.2rem;
            font-weight: 900;
            color: var(--ink);
            margin-bottom: 1rem;
        }
        
        .section-intro p {
            font-size: 1.1rem;
            color: var(--muted);
            max-width: 600px;
            margin: 0 auto;
        }
        
        /* 패스권 카드 - 모든 카드 동일한 레이아웃 */
        .pass-cards-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            padding-top: 3rem;
            justify-items: center;
        }
        
        .pass-card {
            background: white;
            border: 1px solid var(--line);
            border-radius: var(--radius);
            padding: 2.5rem 1.8rem 2rem;
            text-align: center;
            box-shadow: 0 8px 25px rgba(15,23,42,0.08);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: visible; /* 배지가 보이도록 변경 */
            width: 100%;
            max-width: 280px;
            height: 400px; /* 고정 높이 설정 */
            display: flex;
            flex-direction: column;
        }
        
        .pass-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--line), var(--line));
            transition: all 0.3s ease;
        }
        
        .pass-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px rgba(15,23,42,0.15);
            border-color: var(--brand);
        }
        
        .pass-card:hover::before {
            background: linear-gradient(90deg, var(--brand), #ff8533);
        }
        
        .pass-popular {
            border: 2px solid var(--brand);
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(255,106,0,0.15);
        }
        
        .pass-popular::before {
            background: linear-gradient(90deg, var(--brand), #ff8533);
            height: 5px;
        }
        
        /* 추천 배지 - 카드 외부에 배치하여 내부 레이아웃에 영향 없도록 */
        .popular-badge {
            position: absolute;
            top: -12px; /* 카드 외부 상단에 배치 */
>>>>>>> b65c320 (Initial commit)
            left: 50%;
            transform: translateX(-50%);
            background: var(--brand);
            color: white;
<<<<<<< HEAD
            padding: 4px 16px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 700;
        }
        .price {
            font-size: 2.5rem;
            font-weight: 900;
            color: var(--brand);
        }
        .duration {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--ink);
            margin-bottom: 10px;
        }
        .features {
            list-style: none;
            padding: 0;
            margin: 20px 0;
        }
        .features li {
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }
        .features li:last-child {
            border-bottom: none;
        }
        .btn-purchase {
            background: var(--brand);
            border: none;
            color: white;
            font-weight: 700;
            padding: 12px 30px;
            border-radius: 12px;
            font-size: 1.1rem;
            width: 100%;
        }
        .btn-purchase:hover {
            background: #e55a00;
            color: white;
        }
        .hero-section {
            background: linear-gradient(135deg, var(--brand), #ff8533);
            color: white;
            padding: 60px 0;
            text-align: center;
            margin-bottom: 50px;
=======
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            box-shadow: 0 6px 20px rgba(255,106,0,0.4);
            display: flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
            z-index: 15;
        }
        
        /* 모든 카드 동일한 내부 구조 */
        .duration {
            font-size: 1.4rem;
            font-weight: 800;
            color: var(--ink);
            margin-bottom: 1rem;
            margin-top: 0.5rem; /* 모든 카드 동일한 상단 여백 */
        }
        
        .price {
            font-size: 2.4rem;
            font-weight: 900;
            color: var(--brand);
            margin-bottom: 1.5rem;
            line-height: 1;
        }
        
        .features {
            list-style: none;
            padding: 0;
            margin: 0;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-bottom: 1.5rem;
        }
        
        .features li {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 14px;
            background: var(--hover);
            border-radius: 10px;
            font-size: 0.9rem;
            color: var(--ink);
            font-weight: 500;
        }
        
        .features li i {
            color: var(--brand);
            width: 16px;
            text-align: center;
            font-size: 1rem;
        }
        
        .btn-purchase {
            background: var(--brand);
            border: 2px solid var(--brand);
            color: white;
            font-weight: 700;
            padding: 14px 20px;
            border-radius: 50px;
            font-size: 1rem;
            width: 100%;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            margin-top: auto; /* 하단에 고정 */
        }
        
        .btn-purchase:hover {
            background: white;
            color: var(--brand);
            border-color: var(--brand);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255,106,0,0.25);
        }
        
        .pass-popular .btn-purchase {
            background: linear-gradient(135deg, var(--brand), #ff8533);
            border: none;
            box-shadow: 0 6px 20px rgba(255,106,0,0.3);
        }
        
        .pass-popular .btn-purchase:hover {
            background: white;
            color: var(--brand);
            border: 2px solid var(--brand);
            transform: translateY(-2px);
        }
        
        /* 정보 섹션 */
        .info-section {
            background: var(--bg-cream);
            padding: 80px 0;
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 3rem;
            max-width: 1000px;
            margin: 0 auto;
        }
        
        .info-card {
            background: white;
            border-radius: var(--radius);
            padding: 3rem 2.5rem;
            box-shadow: 0 8px 25px rgba(15,23,42,0.08);
            border: 1px solid var(--line);
        }
        
        .info-card h5 {
            color: var(--brand);
            font-weight: 800;
            font-size: 1.4rem;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .info-card i {
            font-size: 1.5rem;
        }
        
        .info-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        
        .info-list li {
            color: var(--muted);
            font-size: 1.05rem;
            line-height: 1.6;
            display: flex;
            align-items: flex-start;
            gap: 12px;
            padding-left: 24px;
            position: relative;
        }
        
        .info-list li::before {
            content: "✓";
            color: var(--brand);
            font-weight: bold;
            position: absolute;
            left: 0;
            top: 2px;
        }
        
        /* 반응형 디자인 */
        @media (max-width: 1200px) {
            .pass-cards-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 2rem;
                max-width: 800px;
            }
            
            .pass-popular {
                transform: none;
            }
        }
        
        @media (max-width: 768px) {
            .pass-cards-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
                max-width: 400px;
            }
            
            .pass-cards-section {
                padding: 60px 0;
            }
            
            .page-header {
                padding: 40px 0;
            }
            
            .page-header h2 {
                font-size: 2rem;
            }
            
            .pass-card {
                padding: 2rem 1.5rem;
                min-height: auto;
            }
            
            .price {
                font-size: 2.4rem;
            }
        }
        
        @media (max-width: 480px) {
            .pass-card {
                padding: 1.5rem;
            }
            
            .section-intro h3 {
                font-size: 1.8rem;
            }
            
            .popular-badge {
                font-size: 11px;
                padding: 5px 14px;
                top: -10px;
            }
>>>>>>> b65c320 (Initial commit)
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
<<<<<<< HEAD
    <!-- Hero Section -->
    <div class="hero-section">
        <div class="container">
            <h1 class="display-4 fw-bold mb-4">전국 어디서나 자유롭게</h1>
            <p class="lead mb-0">하나의 패스권으로 전국 모든 헬킹 가맹점을 이용하세요</p>
        </div>
    </div>
    
    <div class="container">
        <div class="row">
            <c:forEach var="pass" items="${passes}" varStatus="status">
                <div class="col-lg-4 col-md-6 mb-4">
                    <div class="pass-card ${status.index == 1 ? 'pass-popular' : ''}">
                        <c:if test="${status.index == 1}">
                            <div class="popular-badge">인기</div>
=======
    <!-- 패스권 안내 헤더 -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">패스권 안내</h2>
                    <p class="lead">전국 어디서나 자유롭게 이용하는 헬킹 패스권</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="btn-group" role="group">
                        <button class="btn btn-outline-light" onclick="scrollToInfo()">
                            <i class="fas fa-info-circle me-2"></i>이용 안내
                        </button>
                        <button class="btn btn-light" onclick="scrollToRecommended()">
                            <i class="fas fa-star me-2"></i>추천
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 패스권 카드 섹션 -->
    <div class="pass-cards-section">
        <div class="container">
            <div class="section-intro">
                <h3>나에게 맞는 패스권을 선택하세요</h3>
                <p>모든 패스권은 전국 가맹점 자유 이용, 24시간 무제한 출입이 가능합니다</p>
            </div>
            
            <div class="pass-cards-grid">
                <c:forEach var="pass" items="${passes}" varStatus="status">
                    <div class="pass-card ${status.index == 1 ? 'pass-popular' : ''}">
                        <c:if test="${status.index == 1}">
                            <div class="popular-badge">
                                <i class="fas fa-crown"></i>
                                추천
                            </div>
>>>>>>> b65c320 (Initial commit)
                        </c:if>
                        
                        <div class="duration">${pass.durationText}</div>
                        <div class="price">${pass.formattedPrice}</div>
                        
                        <ul class="features">
<<<<<<< HEAD
                            <li>전국 모든 가맹점 이용</li>
                            <li>무제한 출입</li>
                            <li>24시간 언제든지</li>
                            <li>QR코드 간편 입장</li>
                            <c:if test="${pass.durationDays >= 90}">
                                <li class="text-primary fw-bold">7일 무료 환불 보장</li>
                            </c:if>
                        </ul>
                        
                        <p class="text-muted small mb-4">${pass.description}</p>
                        
                        <a href="${pageContext.request.contextPath}/pass/purchase/${pass.passNum}" 
                           class="btn btn-purchase">
                            구매하기
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="container">
    <!-- 디버깅 섹션 -->
    <div class="alert alert-info">
        <h4>🔍 시스템 진단</h4>
        
        <div class="row">
            <div class="col-md-6">
                <h6>기본 정보:</h6>
                <ul>
                    <li><strong>passes 객체:</strong> ${passes}</li>
                    <li><strong>데이터 타입:</strong> java.util.List</li>
                    <li><strong>크기:</strong> ${fn:length(passes)}</li>
                    <li><strong>비어있음:</strong> ${empty passes ? 'YES' : 'NO'}</li>
                </ul>
            </div>
            
            <div class="col-md-6">
                <h6>상세 진단:</h6>
                <c:choose>
                    <c:when test="${passes == null}">
                        <div class="text-danger">❌ passes가 null입니다</div>
                    </c:when>
                    <c:when test="${empty passes}">
                        <div class="text-warning">⚠️ passes가 비어있습니다</div>
                    </c:when>
                    <c:otherwise>
                        <div class="text-success">✅ ${fn:length(passes)}개 패스권 로드됨</div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- 패스권 상세 정보 -->
        <c:if test="${not empty passes}">
            <hr>
            <h6>📋 패스권 목록:</h6>
            <div class="row">
                <c:forEach var="pass" items="${passes}" varStatus="status">
                    <div class="col-md-6 mb-2">
                        <div class="border p-2">
                            <strong>패스권 ${status.index + 1}</strong><br>
                            <small>
                                passNum: ${pass.passNum}<br>
                                passName: ${pass.passName}<br>
                                price: ${pass.price}<br>
                                durationDays: ${pass.durationDays}<br>
                                formattedPrice: ${pass.formattedPrice}<br>
                                URL: ${pageContext.request.contextPath}/pass/purchase/${pass.passNum}
                            </small>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
        
        <!-- 디버깅용 정보 (임시) -->
<div class="alert alert-info">
    <small>
        디버깅: passNum=${pass.passNum}, 
        price=${pass.price}, 
        durationDays=${pass.durationDays},
        formattedPrice=${pass.formattedPrice}
    </small>
</div>
        
        <!-- 추가 정보 섹션 -->
        <div class="row mt-5">
            <div class="col-12">
                <div class="bg-white p-4 rounded">
                    <h4 class="mb-4">패스권 이용 안내</h4>
                    <div class="row">
                        <div class="col-md-6">
                            <h6>이용 방법</h6>
                            <ul class="list-unstyled">
                                <li>1. 원하는 패스권 구매</li>
                                <li>2. QR 코드로 간편 입장</li>
                                <li>3. 전국 어느 가맹점이든 자유 이용</li>
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <h6>환불 정책</h6>
                            <ul class="list-unstyled">
                                <li>• 구매 후 7일 이내 환불 가능</li>
                                <li>• 사용한 날짜만큼 차감 후 환불</li>
                                <li>• 환불 수수료 10% 적용</li>
                            </ul>
                        </div>
                    </div>
=======
                            <li>
                                <i class="fas fa-map-marker-alt"></i>
                                전국 가맹점 이용
                            </li>
                            <li>
                                <i class="fas fa-infinity"></i>
                                무제한 출입
                            </li>
                            <li>
                                <i class="fas fa-qrcode"></i>
                                QR 간편 입장
                            </li>
                        </ul>
                        
                        <a href="${pageContext.request.contextPath}/pass/purchase/${pass.passNum}" 
                           class="btn-purchase">
                            구매하기
                        </a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <!-- 이용 안내 섹션 -->
    <div class="info-section" id="info-section">
        <div class="container">
            <div class="text-center mb-5">
                <h3 class="fw-bold" style="color: var(--ink); font-size: 2.2rem; margin-bottom: 1rem;">
                    패스권 이용 안내
                </h3>
                <p style="color: var(--muted); font-size: 1.1rem;">
                    헬킹 패스권으로 더 자유롭고 편리하게 운동하세요
                </p>
            </div>
            
            <div class="info-grid">
                <div class="info-card">
                    <h5>
                        <i class="fas fa-play-circle"></i>
                        이용 방법
                    </h5>
                    <ul class="info-list">
                        <li>원하는 패스권 선택 및 온라인 구매</li>
                        <li>앱에서 QR 코드 확인</li>
                        <li>전국 어느 가맹점이든 QR로 입장</li>
                        <li>24시간 언제든지 무제한 이용</li>
                    </ul>
                </div>
                
                <div class="info-card">
                    <h5>
                        <i class="fas fa-shield-alt"></i>
                        환불 정책
                    </h5>
                    <ul class="info-list">
                        <li>구매 후 7일 이내 무조건 환불</li>
                        <li>사용 후에도 남은 기간 비례 환불</li>
                        <li>환불 수수료 10% (7일 이내 제외)</li>
                        <li>환불 처리 기간 영업일 기준 3-5일</li>
                    </ul>
>>>>>>> b65c320 (Initial commit)
                </div>
            </div>
        </div>
    </div>
    
<<<<<<< HEAD
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
=======
    <jsp:include page="../common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 이용 안내 섹션으로 스크롤
        function scrollToInfo() {
            document.getElementById('info-section').scrollIntoView({
                behavior: 'smooth'
            });
        }
        
        // 추천 패스권으로 스크롤
        function scrollToRecommended() {
            const popularCard = document.querySelector('.pass-popular');
            if (popularCard) {
                popularCard.scrollIntoView({
                    behavior: 'smooth',
                    block: 'center'
                });
                
                // 하이라이트 효과
                popularCard.style.boxShadow = '0 30px 60px rgba(255,106,0,0.25)';
                setTimeout(() => {
                    popularCard.style.boxShadow = '';
                }, 2000);
            }
        }
        
        // 패스권 카드 애니메이션
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach((entry, index) => {
                if (entry.isIntersecting) {
                    setTimeout(() => {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = entry.target.classList.contains('pass-popular') ? 
                            'translateY(-8px)' : 'translateY(0)';
                    }, index * 100);
                }
            });
        }, observerOptions);

        // 카드들을 관찰 대상에 추가
        document.querySelectorAll('.pass-card').forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';
            card.style.transition = 'all 0.6s cubic-bezier(0.4, 0, 0.2, 1)';
            observer.observe(card);
        });
    </script>
>>>>>>> b65c320 (Initial commit)
</body>
</html>