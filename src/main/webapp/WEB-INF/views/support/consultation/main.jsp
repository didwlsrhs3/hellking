<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상담예약 | 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 */
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
        
        .breadcrumb-item a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
        }
        
        .breadcrumb-item a:hover {
            color: white;
        }
        
        .breadcrumb-item.active {
            color: white;
        }
        
        .breadcrumb-item + .breadcrumb-item::before {
            color: rgba(255,255,255,0.6);
        }
        
        /* 기존 스타일 유지 */
        :root {
            --primary-color: #007bff;
            --secondary-color: #F4ECDC;
            --text-color: #0F172A;
            --muted-color: #5B6170;
            --border-color: #E7E0D6;
        }
        
        .consultation-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-bottom: 2rem;
            border: 1px solid var(--border-color);
        }
        
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.875rem;
            font-weight: 600;
        }
        
        .status-confirmed {
            background: #DCFCE7;
            color: #166534;
        }
        
        .status-cancelled {
            background: #FEE2E2;
            color: #991B1B;
        }
        
        .consultation-time {
            background: var(--secondary-color);
            padding: 1rem;
            border-radius: 12px;
            text-align: center;
            margin: 1rem 0;
        }
        
        .btn-primary-custom {
            background: var(--primary-color);
            border: none;
            padding: 0.75rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            color: white;
        }
        
        .btn-primary-custom:hover {
            background: #0056b3;
            transform: translateY(-2px);
            color: white;
        }
        
        .btn-outline-custom {
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
            padding: 0.5rem 1.5rem;
            border-radius: 20px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-outline-custom:hover {
            background: var(--primary-color);
            color: white;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--muted-color);
        }
        
        .consultation-list-item {
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }
        
        .consultation-list-item:hover {
            box-shadow: 0 4px 16px rgba(0, 123, 255, 0.1);
            border-color: var(--primary-color);
        }
        
        .time-info {
            background: #F8FAFC;
            padding: 0.75rem;
            border-radius: 8px;
            font-weight: 600;
            color: var(--text-color);
        }
        
        .info-box {
            background: #F0F9FF;
            border: 1px solid #0EA5E9;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 1rem;
        }
        
        /* 반응형 */
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
            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>
    
    <!-- 통일된 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/">홈</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/support/">고객센터</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">상담예약</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">상담예약</h2>
                    <p class="lead">전문 상담사와 1:1 개인 상담을 받아보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/support/consultation/create" 
                       class="btn btn-light btn-lg">
                        <i class="fas fa-calendar-plus me-2"></i>새 예약하기
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        
        <!-- 메시지 표시 -->
        <c:if test="${not empty message}">
            <div class="alert alert-${messageType == 'error' ? 'danger' : 'success'} alert-dismissible fade show">
                <i class="fas fa-${messageType == 'error' ? 'exclamation-triangle' : 'check-circle'} me-2"></i>
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <div class="row">
            <!-- 왼쪽: 예약 신청 및 안내 -->
            <div class="col-lg-8">
                
                <!-- 예약 신청 카드 -->
                <div class="consultation-card">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h3><i class="fas fa-plus-circle text-primary me-2"></i>새 상담 예약</h3>
                        <a href="${pageContext.request.contextPath}/support/consultation/create" 
                           class="btn btn-primary-custom">
                            <i class="fas fa-calendar-plus me-2"></i>예약하기
                        </a>
                    </div>
                    
                    <div class="info-box">
                        <h5><i class="fas fa-info-circle me-2"></i>상담 안내</h5>
                        <ul class="mb-0">
                            <li><strong>상담시간:</strong> 평일 10:00-12:00, 14:00-17:00 (점심시간 12:00-14:00 제외)</li>
                            <li><strong>예약제한:</strong> 시간당 1명 (선착순)</li>
                            <li><strong>취소정책:</strong> 예약 1시간 전까지 취소 가능</li>
                            <li><strong>휴무일:</strong> 주말 및 공휴일</li>
                        </ul>
                    </div>
                </div>
                
                <!-- 예약 목록 -->
                <div class="consultation-card">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3><i class="fas fa-list me-2"></i>내 예약 목록</h3>
                        <span class="badge bg-secondary">${consultations.size()}개</span>
                    </div>
                    
                    <c:choose>
                        <c:when test="${empty consultations}">
                            <div class="empty-state">
                                <i class="fas fa-calendar-alt fa-3x mb-3" style="color: var(--muted-color);"></i>
                                <h5>예약 내역이 없습니다</h5>
                                <p>첫 상담을 예약해보세요!</p>
                                <a href="${pageContext.request.contextPath}/support/consultation/create" 
                                   class="btn btn-outline-custom">지금 예약하기</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="consultation" items="${consultations}">
                                <div class="consultation-list-item">
                                    <div class="row align-items-center">
                                        <div class="col-md-3">
                                            <div class="time-info">
                                                <div><fmt:formatDate value="${consultation.consultationDate}" pattern="yyyy-MM-dd (E)"/></div>
                                                <div>${consultation.consultationTime}</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <h6 class="mb-1">${consultation.name}</h6>
                                            <p class="text-muted mb-1">
                                                <i class="fas fa-phone me-1"></i>${consultation.phone}
                                            </p>
                                            <c:if test="${not empty consultation.content}">
                                                <p class="text-muted mb-0">
                                                    <i class="fas fa-comment me-1"></i>
                                                    <c:choose>
                                                        <c:when test="${fn:length(consultation.content) > 50}">
                                                            ${fn:substring(consultation.content, 0, 50)}...
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${consultation.content}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </p>
                                            </c:if>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="d-flex flex-column gap-2">
                                                <span class="status-badge status-${consultation.status.toLowerCase()}">
                                                    ${consultation.statusText}
                                                </span>
                                                
                                                <div class="action-buttons">
                                                    <a href="${pageContext.request.contextPath}/support/consultation/detail?consultationNum=${consultation.consultationNum}" 
                                                       class="btn btn-sm btn-outline-secondary">
                                                        <i class="fas fa-eye me-1"></i>상세
                                                    </a>
                                                    
                                                    <c:if test="${consultation.status == 'CONFIRMED' && consultation.canCancel}">
                                                        <button type="button" 
                                                                class="btn btn-sm btn-outline-danger"
                                                                onclick="cancelConsultation(${consultation.consultationNum})">
                                                            <i class="fas fa-times me-1"></i>취소
                                                        </button>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            
            <!-- 오른쪽: 사이드바 -->
            <div class="col-lg-4">
                
                <!-- 연락처 정보 -->
                <div class="consultation-card">
                    <h5><i class="fas fa-headset me-2"></i>고객센터</h5>
                    <hr>
                    <div class="d-flex align-items-center mb-3">
                        <i class="fas fa-phone text-primary me-3"></i>
                        <div>
                            <strong>전화상담</strong><br>
                            <span class="text-muted">1588-0000</span>
                        </div>
                    </div>
                    <div class="d-flex align-items-center mb-3">
                        <i class="fas fa-envelope text-primary me-3"></i>
                        <div>
                            <strong>이메일</strong><br>
                            <span class="text-muted">support@hellking.co.kr</span>
                        </div>
                    </div>
                    <div class="d-flex align-items-center">
                        <i class="fas fa-clock text-primary me-3"></i>
                        <div>
                            <strong>운영시간</strong><br>
                            <span class="text-muted">평일 09:00 - 18:00</span>
                        </div>
                    </div>
                </div>
                
                <!-- 자주 묻는 질문 -->
                <div class="consultation-card">
                    <h5><i class="fas fa-question-circle me-2"></i>자주 묻는 질문</h5>
                    <hr>
                    <div class="accordion" id="faqAccordion">
                        <div class="accordion-item">
                            <h6 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" 
                                        data-bs-toggle="collapse" data-bs-target="#faq1">
                                    상담은 어떻게 진행되나요?
                                </button>
                            </h6>
                            <div id="faq1" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    전문 상담사와 1:1로 개인 맞춤형 상담을 진행합니다. 운동 목표, 건강 상태 등을 종합적으로 분석하여 최적의 운동 플랜을 제안해드립니다.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h6 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" 
                                        data-bs-toggle="collapse" data-bs-target="#faq2">
                                    상담 시간은 얼마나 걸리나요?
                                </button>
                            </h6>
                            <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    일반적으로 30-60분 정도 소요됩니다. 상담 내용에 따라 시간이 달라질 수 있습니다.
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h6 class="accordion-header">
                                <button class="accordion-button collapsed" type="button" 
                                        data-bs-toggle="collapse" data-bs-target="#faq3">
                                    상담 비용이 있나요?
                                </button>
                            </h6>
                            <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion">
                                <div class="accordion-body">
                                    헬킹 회원분들께는 무료로 상담 서비스를 제공해드립니다.
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/support/faq" 
                           class="btn btn-outline-custom w-100">
                            <i class="fas fa-external-link-alt me-2"></i>더 많은 FAQ 보기
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 예약 취소 함수
        function cancelConsultation(consultationNum) {
            if (confirm('정말로 예약을 취소하시겠습니까?')) {
                fetch('${pageContext.request.contextPath}/support/consultation/cancel', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'consultationNum=' + consultationNum
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('취소 처리 중 오류가 발생했습니다.');
                });
            }
        }
    </script>
</body>
</html>