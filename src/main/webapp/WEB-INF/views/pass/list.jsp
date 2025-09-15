<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>패스권 목록 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
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
            left: 50%;
            transform: translateX(-50%);
            background: var(--brand);
            color: white;
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
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
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
                        </c:if>
                        
                        <div class="duration">${pass.durationText}</div>
                        <div class="price">${pass.formattedPrice}</div>
                        
                        <ul class="features">
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
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>