<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>패스권 상세보기 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        .page-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 60px 0;
        }
        
        .detail-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(15,23,42,0.1);
        }
        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 14px;
        }
        .status-active { background: #d4edda; color: #155724; }
        .status-expired { background: #f8d7da; color: #721c24; }
        .status-cancelled { background: #d1ecf1; color: #0c5460; }
        .status-refunded { background: #fff3cd; color: #856404; }
        
        .info-row {
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }
        .info-row:last-child {
            border-bottom: none;
        }
        .info-label {
            font-weight: 600;
            color: #0F172A;
            margin-bottom: 5px;
        }
        .info-value {
            color: #666;
        }
        .btn-refund {
            background: #dc3545;
            border: none;
            color: white;
            font-weight: 600;
            padding: 12px 24px;
            border-radius: 12px;
        }
        .btn-refund:hover {
            background: #c82333;
            color: white;
        }
        .remaining-days {
            font-size: 2rem;
            font-weight: 900;
            color: #FF6A00;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 패스권 상세 헤더 -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">패스권 상세정보</h2>
                    <p class="lead">나의 패스권 이용 현황과 상세정보</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/pass/mypass" class="btn btn-outline-light">
                        <i class="fas fa-list me-2"></i>패스권 목록
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- 뒤로가기 버튼 -->
                <div class="mb-3">
                    <a href="${pageContext.request.contextPath}/pass/mypass" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>내 패스권으로 돌아가기
                    </a>
                </div>
                
                <div class="detail-card">
                    <div class="text-center mb-4">
                        <h2 class="mb-3">${userPass.passName}</h2>
                        <span class="status-badge status-${userPass.status.toLowerCase()}">${userPass.statusText}</span>
                    </div>
                    
                    <!-- 남은 일수 표시 (활성 패스권인 경우) -->
                    <c:if test="${userPass.status == 'ACTIVE' && !userPass.isExpired}">
                        <div class="text-center mb-4 p-4 bg-light rounded">
                            <div class="remaining-days">${userPass.remainingDays}</div>
                            <div class="text-muted">일 남음</div>
                        </div>
                    </c:if>
                    
                    <!-- 패스권 상세 정보 -->
                    <div class="row">
                        <div class="col-md-6">
                            <div class="info-row">
                                <div class="info-label">패스권 번호</div>
                                <div class="info-value">${userPass.userPassNum}</div>
                            </div>
                            
                            <div class="info-row">
                                <div class="info-label">패스권 종류</div>
                                <div class="info-value">${userPass.passName}</div>
                            </div>
                            
                            <div class="info-row">
                                <div class="info-label">결제 금액</div>
                                <div class="info-value">${userPass.formattedPrice}</div>
                            </div>
                            
                            <div class="info-row">
                                <div class="info-label">총 이용 기간</div>
                                <div class="info-value">${userPass.durationDays}일</div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="info-row">
                                <div class="info-label">구매일</div>
                                <div class="info-value">
                                    <fmt:formatDate value="${userPass.purchaseDate}" pattern="yyyy-MM-dd HH:mm" />
                                </div>
                            </div>
                            
                            <div class="info-row">
                                <div class="info-label">시작일</div>
                                <div class="info-value">
                                    <fmt:formatDate value="${userPass.startDate}" pattern="yyyy-MM-dd" />
                                </div>
                            </div>
                            
                            <div class="info-row">
                                <div class="info-label">종료일</div>
                                <div class="info-value">
                                    <fmt:formatDate value="${userPass.endDate}" pattern="yyyy-MM-dd" />
                                </div>
                            </div>
                            
                            <div class="info-row">
                                <div class="info-label">현재 상태</div>
                                <div class="info-value">${userPass.statusText}</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 결제 정보 -->
                    <c:if test="${not empty userPass.paymentId}">
                        <hr class="my-4">
                        <h5 class="mb-3">결제 정보</h5>
                        <div class="info-row">
                            <div class="info-label">결제 ID</div>
                            <div class="info-value">${userPass.paymentId}</div>
                        </div>
                    </c:if>
                    
                    <!-- 액션 버튼들 -->
                    <div class="mt-4 text-center">
                        <c:choose>
                            <c:when test="${userPass.canRefund}">
                                <a href="${pageContext.request.contextPath}/pass/refund/${userPass.userPassNum}" 
                                   class="btn btn-refund me-2">
                                    <i class="fas fa-undo me-2"></i>환불 신청
                                </a>
                                <div class="text-muted small mt-2">
                                    결제 후 언제든지 환불 신청이 가능합니다.
                                </div>
                            </c:when>
                            <c:when test="${userPass.status == 'REFUND_REQUESTED'}">
                                <div class="alert alert-warning">
                                    <i class="fas fa-clock me-2"></i>환불 신청이 진행 중입니다.
                                </div>
                            </c:when>
                            <c:when test="${userPass.status == 'REFUNDED'}">
                                <div class="alert alert-success">
                                    <i class="fas fa-check-circle me-2"></i>환불이 완료되었습니다.
                                </div>
                            </c:when>
                        </c:choose>
                        
                        <a href="${pageContext.request.contextPath}/pass/mypass" class="btn btn-outline-primary">
                            <i class="fas fa-list me-2"></i>내 패스권 목록
                        </a>
                    </div>
                    
                    <!-- QR 코드 표시 (활성 패스권인 경우) -->
                    <c:if test="${userPass.status == 'ACTIVE' && !userPass.isExpired}">
                        <hr class="my-4">
                        <div class="text-center">
                            <h5 class="mb-3">입장용 QR 코드</h5>
                            <div class="bg-light p-4 rounded d-inline-block">
                                <!-- QR 코드 라이브러리를 사용하여 생성하거나, 이미지로 대체 -->
                                <div class="qr-placeholder bg-white border" style="width: 200px; height: 200px; display: flex; align-items: center; justify-content: center;">
                                    <div class="text-center">
                                        <i class="fas fa-qrcode fa-3x text-muted mb-2"></i>
                                        <div class="small text-muted">QR 코드<br>패스권 번호: ${userPass.userPassNum}</div>
                                    </div>
                                </div>
                            </div>
                            <div class="text-muted small mt-2">
                                가맹점 입장 시 이 QR 코드를 스캔해주세요.
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>