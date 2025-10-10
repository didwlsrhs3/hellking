<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 패스권 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
<<<<<<< HEAD
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
        }
        body { background: var(--bg-cream); }
=======
        body { 
            background: white; 
        }
        
        .page-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 60px 0;
        }
        
>>>>>>> b65c320 (Initial commit)
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(15,23,42,0.1);
            height: 100%;
        }
        .active-pass {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 20px;
        }
        .expired-pass {
            background: linear-gradient(135deg, #6c757d, #5a6268);
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
<<<<<<< HEAD
    <div class="container mt-4">
        <h2 class="mb-4">내 패스권 관리</h2>
        
=======
    <!-- 내 패스권 헤더 -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">내 패스권 관리</h2>
                    <p class="lead">패스권 이용 현황 및 히스토리 관리</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="row text-center">
                        <div class="col-4">
                            <div class="stats-card" style="background: rgba(255,255,255,0.2); border-radius: 12px; padding: 15px;">
                                <div class="h4 mb-1">${stats.activeCount}</div>
                                <small>활성</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="stats-card" style="background: rgba(255,255,255,0.2); border-radius: 12px; padding: 15px;">
                                <div class="h4 mb-1">${stats.totalCount}</div>
                                <small>총 구매</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="stats-card" style="background: rgba(255,255,255,0.2); border-radius: 12px; padding: 15px;">
                                <div class="h4 mb-1">
                                    <fmt:formatNumber value="${stats.totalSpent / 10000}" maxFractionDigits="0"/>만
                                </div>
                                <small>총 결제</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">        
>>>>>>> b65c320 (Initial commit)
        <!-- 통계 카드 -->
        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <h3 class="text-primary">${stats.totalCount}</h3>
                    <p class="mb-0">총 구매한 패스권</p>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <h3 class="text-success">${stats.activeCount}</h3>
                    <p class="mb-0">현재 활성 패스권</p>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <h3 class="text-warning"><fmt:formatNumber value="${stats.totalSpent}" pattern="#,###"/>원</h3>
                    <p class="mb-0">총 결제 금액</p>
                </div>
            </div>
        </div>
        
        <!-- 활성 패스권 -->
        <div class="row mb-4">
            <div class="col-12">
                <h4>활성 패스권</h4>
                <c:choose>
                    <c:when test="${not empty activePasses}">
                        <c:forEach var="pass" items="${activePasses}">
                            <div class="active-pass ${pass.isExpired ? 'expired-pass' : ''}">
                                <div class="row align-items-center">
                                    <div class="col-md-8">
                                        <h5 class="mb-2">${pass.passName}</h5>
                                        <p class="mb-1">시작일: <fmt:formatDate value="${pass.startDate}" pattern="yyyy.MM.dd"/></p>
                                        <p class="mb-1">만료일: <fmt:formatDate value="${pass.endDate}" pattern="yyyy.MM.dd"/></p>
                                        <p class="mb-0">
                                            남은 일수: 
                                            <span class="badge bg-light text-dark">${pass.remainingDays}일</span>
                                            <span class="badge ${pass.isExpired ? 'bg-danger' : 'bg-success'} ms-2">
                                                ${pass.statusText}
                                            </span>
                                        </p>
                                    </div>
                                    <div class="col-md-4 text-end">
<<<<<<< HEAD
                                        <c:if test="${pass.canRefund}">
                                            <button class="btn btn-outline-light btn-sm" 
                                                    onclick="requestRefund(${pass.userPassNum})">
                                                환불 신청
                                            </button>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/pass/detail/${pass.userPassNum}" 
                                           class="btn btn-light btn-sm ms-2">상세</a>
=======
                                        <a href="${pageContext.request.contextPath}/pass/detail/${pass.userPassNum}"
                                           class="btn btn-outline-light btn-sm me-2">상세보기</a>
                                        <c:if test="${pass.canRefund}">
                                        <a href="${pageContext.request.contextPath}/pass/refund/${pass.userPassNum}"
                                           class="btn btn-outline-light btn-sm">                                         
                                                환불 신청</a>
                                        </c:if>
>>>>>>> b65c320 (Initial commit)
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info">
                            현재 활성화된 패스권이 없습니다.
                            <a href="${pageContext.request.contextPath}/pass/list" class="alert-link">패스권 구매하기</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- 패스권 이용 내역 -->
        <div class="row">
            <div class="col-12">
                <h4>패스권 이용 내역</h4>
                <div class="bg-white rounded p-3">
                    <div class="table-responsive">
                        <table class="table table-striped mb-0">
                            <thead>
                                <tr>
                                    <th>패스권명</th>
                                    <th>구매일</th>
                                    <th>기간</th>
                                    <th>금액</th>
                                    <th>상태</th>
                                    <th>관리</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty userPasses}">
                                        <c:forEach var="pass" items="${userPasses}">
                                            <tr>
                                                <td><strong>${pass.passName}</strong></td>
                                                <td><fmt:formatDate value="${pass.purchaseDate}" pattern="yyyy.MM.dd"/></td>
                                                <td>
                                                    <small>
                                                        <fmt:formatDate value="${pass.startDate}" pattern="MM.dd"/> ~ 
                                                        <fmt:formatDate value="${pass.endDate}" pattern="MM.dd"/>
                                                    </small>
                                                </td>
                                                <td>${pass.formattedPrice}</td>
                                                <td>
                                                    <span class="badge ${pass.status == 'ACTIVE' ? 'bg-success' : 
                                                                      pass.status == 'EXPIRED' ? 'bg-secondary' :
                                                                      pass.status == 'REFUNDED' ? 'bg-warning' : 'bg-danger'}">
                                                        ${pass.statusText}
                                                    </span>
                                                </td>
                                                <td>
                                                    <a href="${pageContext.request.contextPath}/pass/detail/${pass.userPassNum}" 
                                                       class="btn btn-sm btn-outline-primary">상세</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="6" class="text-center text-muted py-4">
                                                구매한 패스권이 없습니다.
                                                <a href="${pageContext.request.contextPath}/pass/list" class="text-decoration-none ms-2">
                                                    패스권 구매하기 →
                                                </a>
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 환불 내역 -->
        <c:if test="${not empty refunds}">
            <div class="row mt-4">
                <div class="col-12">
                    <h4>환불 내역</h4>
                    <div class="bg-white rounded p-3">
                        <div class="table-responsive">
                            <table class="table table-striped mb-0">
                                <thead>
                                    <tr>
                                        <th>패스권명</th>
                                        <th>환불 금액</th>
                                        <th>신청일</th>
                                        <th>사유</th>
                                        <th>상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="refund" items="${refunds}">
                                        <tr>
                                            <td>${refund.passName}</td>
                                            <td class="fw-bold">${refund.formattedRefundAmount}</td>
                                            <td><fmt:formatDate value="${refund.requestDate}" pattern="yyyy.MM.dd"/></td>
                                            <td><small>${refund.reason}</small></td>
                                            <td>
                                                <span class="badge ${refund.status == 'COMPLETED' ? 'bg-success' : 
<<<<<<< HEAD
                                                                  refund.status == 'APPROVED' ? 'bg-primary' :
                                                                  refund.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">
=======
                                                              refund.status == 'APPROVED' ? 'bg-primary' :
                                                              refund.status == 'REJECTED' ? 'bg-danger' : 'bg-warning'}">
>>>>>>> b65c320 (Initial commit)
                                                    ${refund.statusText}
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
    
    <script>
        function requestRefund(userPassNum) {
            if(confirm('정말로 환불을 신청하시겠습니까?\n환불 수수료 10%가 차감됩니다.')) {
                const reason = prompt('환불 사유를 입력해주세요:');
                if(reason && reason.trim()) {
                    fetch('${pageContext.request.contextPath}/pass/requestRefund', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                        body: 'userPassNum=' + userPassNum + '&reason=' + encodeURIComponent(reason.trim())
                    })
                    .then(response => response.json())
                    .then(data => {
                        alert(data.message);
                        if(data.success) {
                            location.reload();
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('환불 신청 중 오류가 발생했습니다.');
                    });
                }
            }
        }
    </script>
    
<<<<<<< HEAD
=======
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
>>>>>>> b65c320 (Initial commit)
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>