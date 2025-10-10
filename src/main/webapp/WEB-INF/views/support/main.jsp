<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>고객지원 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
            --muted: #5B6170;
            --line: #E7E0D6;
            --hover: #FFF5EA;
        }
        
        .page-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 60px 0;
        }
        
        .page-header h2 {
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
        
        @media (max-width: 768px) {
            .page-header {
                padding: 40px 0;
            }
            .page-header .row {
                text-align: center;
            }
            .page-header .col-md-4 {
                margin-top: 20px;
            }
        }
        
        .support-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            height: 100%;
            transition: transform 0.2s;
            border: 1px solid var(--line);
        }
        
        .support-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(15,23,42,0.15);
        }
        
        .support-icon {
            font-size: 3rem;
            color: var(--brand);
            margin-bottom: 20px;
        }
        
        .btn-support {
            background: var(--brand);
            border: none;
            color: white;
            font-weight: 700;
            padding: 12px 30px;
            border-radius: 50px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.2s;
        }
        
        .btn-support:hover {
            background: #e55a00;
            color: white;
            transform: translateY(-2px);
        }
        
        .recent-section {
            background: var(--bg-cream);
            padding: 60px 0;
        }
        
        .faq-item {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            border: 1px solid var(--line);
            transition: all 0.2s;
        }
        
        .faq-item:hover {
            box-shadow: 0 4px 15px rgba(15,23,42,0.1);
        }
        
        .faq-title {
            color: var(--ink);
            font-weight: 600;
            margin: 0;
            font-size: 1.1rem;
        }
        
        .faq-preview {
            color: var(--muted);
            margin: 10px 0 0;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 통일된 헤더 섹션 -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">고객지원</h2>
                    <p class="lead">궁금한 점이 있으시면 언제든지 문의해주세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <!-- 빠른 검색 버튼 -->
                    <a href="${pageContext.request.contextPath}/support/search" class="btn btn-light btn-lg">
                        <i class="fas fa-search me-2"></i>빠른 검색
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Support Services -->
    <div class="container py-5">
        <div class="row">
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="support-card">
                    <div class="support-icon">
                        <i class="fas fa-question-circle"></i>
                    </div>
                    <h5 class="fw-bold mb-3">자주 묻는 질문</h5>
                    <p class="text-muted mb-4">가장 많이 문의하시는 질문들의 답변을 확인해보세요.</p>
                    <a href="${pageContext.request.contextPath}/support/faq" class="btn-support">FAQ 보기</a>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="support-card">
                    <div class="support-icon">
                        <i class="fas fa-comments"></i>
                    </div>
                    <h5 class="fw-bold mb-3">문의사항</h5>
                    <p class="text-muted mb-4">1:1 문의를 통해 자세한 답변을 받아보세요.</p>
                    <c:choose>
                        <c:when test="${isLoggedIn}">
                            <a href="${pageContext.request.contextPath}/support/inquiry" class="btn-support">문의하기</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/login" class="btn-support">로그인 후 이용</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <div class="col-lg-4 col-md-6 mb-4">
                <div class="support-card">
                    <div class="support-icon">
                        <i class="fas fa-calendar-check"></i>
                    </div>
                    <h5 class="fw-bold mb-3">상담예약</h5>
                    <p class="text-muted mb-4">전문 상담사와 1:1 상담을 예약하세요.</p>
                    <c:choose>
                        <c:when test="${isLoggedIn}">
                            <a href="${pageContext.request.contextPath}/support/consultation" class="btn-support">예약하기</a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/login" class="btn-support">로그인 후 이용</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Recent FAQs -->
    <c:if test="${not empty recentFAQs}">
        <div class="recent-section">
            <div class="container">
                <h3 class="text-center fw-bold mb-5">최근 등록된 FAQ</h3>
                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <c:forEach var="faq" items="${recentFAQs}" varStatus="status">
                            <div class="faq-item">
                                <h6 class="faq-title">
                                    <a href="${pageContext.request.contextPath}/support/faq/${faq.faqNum}" 
                                       style="color: inherit; text-decoration: none;">
                                        ${faq.title}
                                    </a>
                                </h6>
                                <p class="faq-preview">${faq.shortContent}</p>
                            </div>
                        </c:forEach>
                        
                        <div class="text-center mt-4">
                            <a href="${pageContext.request.contextPath}/support/faq" class="btn-support">
                                모든 FAQ 보기
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
    
    <!-- Contact Info -->
    <div class="container py-5">
        <div class="row">
            <div class="col-lg-8 mx-auto text-center">
                <h3 class="fw-bold mb-4">직접 문의</h3>
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <div class="support-card">
                            <i class="fas fa-phone support-icon" style="font-size: 2rem;"></i>
                            <h6 class="fw-bold">전화 문의</h6>
                            <p class="text-muted mb-0">1588-0000</p>
                            <small class="text-muted">평일 10:00-17:00</small>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="support-card">
                            <i class="fas fa-envelope support-icon" style="font-size: 2rem;"></i>
                            <h6 class="fw-bold">이메일 문의</h6>
                            <p class="text-muted mb-0">support@hellking.co.kr</p>
                            <small class="text-muted">24시간 접수</small>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <div class="support-card">
                            <i class="fas fa-clock support-icon" style="font-size: 2rem;"></i>
                            <h6 class="fw-bold">운영시간</h6>
                            <p class="text-muted mb-0">평일 10:00-17:00</p>
                            <small class="text-muted">점심시간 12:00-14:00</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>