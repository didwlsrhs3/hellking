<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>패스권 구매 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
        }
        body { background: var(--bg-cream); }
        .purchase-container {
            max-width: 600px;
            margin: 50px auto;
        }
        .pass-info {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            margin-bottom: 20px;
        }
        .price-highlight {
            font-size: 2rem;
            font-weight: 900;
            color: var(--brand);
        }
        .btn-purchase {
            background: var(--brand);
            border: none;
            color: white;
            font-weight: 700;
            padding: 15px;
            border-radius: 12px;
            font-size: 1.2rem;
        }
        .btn-purchase:hover {
            background: #e55a00;
            color: white;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-4">
        <div class="purchase-container">
            <h2 class="text-center mb-4">패스권 구매</h2>
            
            <!-- 선택한 패스권 정보 -->
            <div class="pass-info">
                <h4>${pass.passName}</h4>
                <p class="text-muted mb-3">${pass.description}</p>
                
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <span class="h5 mb-0">결제 금액</span>
                    <span class="price-highlight">${pass.formattedPrice}</span>
                </div>
                
                <div class="border-top pt-3">
                    <small class="text-muted">
                        • 구매 즉시 사용 가능<br>
                        • 전국 모든 헬킹 가맹점 이용<br>
                        • 구매 후 7일 이내 환불 가능
                    </small>
                </div>
            </div>
            
            <!-- 기존 패스권 알림 -->
            <c:if test="${not empty activePasses}">
                <div class="alert alert-warning">
                    <strong>주의:</strong> 현재 활성화된 패스권이 있습니다. 
                    새로운 패스권 구매 시 기존 패스권은 자동으로 취소됩니다.
                    
                    <div class="mt-2">
                        <c:forEach var="activePass" items="${activePasses}">
                            <div class="small">
                                현재: ${activePass.passName} (만료일: <fmt:formatDate value="${activePass.endDate}" pattern="yyyy.MM.dd"/>)
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
            
            <!-- 결제 버튼 -->
            <div class="d-grid gap-2">
                <button type="button" class="btn btn-purchase" onclick="requestPay()">
                    ${pass.formattedPrice} 결제하기
                </button>
                <button type="button" class="btn btn-outline-secondary" onclick="history.back()">
                    취소
                </button>
            </div>
        </div>
    </div>
    
    <script>
        // 포트원 초기화
        IMP.init('imp22408658'); // 실제 가맹점 식별코드로 교체 필요
        
        function requestPay() {
            // 주문번호 생성 요청
            fetch('${pageContext.request.contextPath}/pass/createOrder', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'passNum=${pass.passNum}'
            })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    // 포트원 결제 요청
                    IMP.request_pay({
                        pg: 'kakaopay.TC0ONETIME',  // 카카오페이 설정
                        pay_method: 'card',
                        merchant_uid: data.merchantUid,
                        name: '${pass.passName}',
                        amount: ${pass.price},
                        buyer_email: '${sessionScope.userEmail}',
                        buyer_name: '${sessionScope.username}',
                        buyer_tel: '${sessionScope.userPhone}'
                    }, function(rsp) {
                        if (rsp.success) {
                            // 결제 완료 처리
                            completePurchase(rsp.imp_uid);
                        } else {
                            alert('결제에 실패했습니다: ' + rsp.error_msg);
                        }
                    });
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('주문 생성에 실패했습니다.');
            });
        }
        
        function completePurchase(paymentId) {
            fetch('${pageContext.request.contextPath}/pass/completePurchase', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'passNum=${pass.passNum}&paymentId=' + paymentId
            })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    alert('패스권 구매가 완료되었습니다!');
                    location.href = '${pageContext.request.contextPath}/pass/mypass';
                } else {
                    alert('구매 처리에 실패했습니다: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('구매 처리 중 오류가 발생했습니다.');
            });
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
