<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상담예약 상세 | 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 - 파란색 */
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
        
        /* 기존 스타일 조정 */
        :root {
            --primary-color: #007bff;
            --secondary-color: #F4ECDC;
            --text-color: #0F172A;
            --muted-color: #5B6170;
            --border-color: #E7E0D6;
        }
        
        .detail-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            padding: 2.5rem;
            border: 1px solid var(--border-color);
        }
        
        .status-badge {
            padding: 0.75rem 1.5rem;
            border-radius: 25px;
            font-size: 1rem;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        .status-confirmed {
            background: #DCFCE7;
            color: #166534;
        }
        
        .status-cancelled {
            background: #FEE2E2;
            color: #991B1B;
        }
        
        .info-section {
            background: #F8FAFC;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.75rem 0;
            border-bottom: 1px solid #E2E8F0;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: var(--muted-color);
            flex: 0 0 140px;
        }
        
        .info-value {
            flex: 1;
            color: var(--text-color);
            font-weight: 500;
        }
        
        .time-highlight {
            background: linear-gradient(135deg, var(--primary-color), #0056b3);
            color: white;
            padding: 1.5rem;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 2rem;
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
            padding: 0.75rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-outline-custom:hover {
            background: var(--primary-color);
            color: white;
        }
        
        .btn-danger-custom {
            background: #EF4444;
            border: none;
            color: white;
            padding: 0.75rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-danger-custom:hover {
            background: #DC2626;
            transform: translateY(-2px);
        }
        
        .alert-custom {
            border: none;
            border-radius: 12px;
            padding: 1.25rem;
        }
        
        .content-box {
            background: #FFFBEB;
            border: 1px solid #FCD34D;
            border-radius: 12px;
            padding: 1.5rem;
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
            .detail-card {
                padding: 1.5rem;
            }
            .info-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
            .info-label {
                flex: none;
            }
            .time-highlight {
                padding: 1rem;
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
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/support/consultation">상담예약</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">예약상세</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">상담예약 상세정보</h2>
                    <p class="lead">예약번호: ${consultation.consultationNum}</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/support/consultation" 
                       class="btn btn-light btn-lg">
                        <i class="fas fa-arrow-left me-2"></i>목록으로
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
        
        <div class="row justify-content-center">
            <div class="col-lg-8">
                
                <div class="detail-card">
                    
                    <!-- 상태 및 예약 시간 -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h3>상담예약 정보</h3>
                        <span class="status-badge status-${consultation.status.toLowerCase()}">
                            ${consultation.statusText}
                        </span>
                    </div>
                    
                    <!-- 예약 시간 하이라이트 -->
                    <div class="time-highlight">
                        <h4 class="mb-2">
                            <i class="fas fa-calendar-alt me-2"></i>
                            <fmt:formatDate value="${consultation.consultationDate}" pattern="yyyy년 MM월 dd일 (E)"/>
                        </h4>
                        <h5 class="mb-0">
                            <i class="fas fa-clock me-2"></i>
                            ${consultation.consultationTime}
                        </h5>
                    </div>
                    
                    <!-- 예약자 정보 -->
                    <div class="info-section">
                        <h5 class="mb-3"><i class="fas fa-user me-2"></i>예약자 정보</h5>
                        
                        <div class="info-row">
                            <div class="info-label">예약자명</div>
                            <div class="info-value">${consultation.name}</div>
                        </div>
                        
                        <div class="info-row">
                            <div class="info-label">연락처</div>
                            <div class="info-value">
                                <i class="fas fa-phone me-2"></i>${consultation.phone}
                            </div>
                        </div>
                        
                        <div class="info-row">
                            <div class="info-label">이메일</div>
                            <div class="info-value">
                                <i class="fas fa-envelope me-2"></i>${consultation.email}
                            </div>
                        </div>
                        
                        <c:if test="${not empty consultation.userName}">
                            <div class="info-row">
                                <div class="info-label">회원정보</div>
                                <div class="info-value">
                                    <i class="fas fa-id-card me-2"></i>
                                    ${consultation.userName} (${consultation.userId})
                                </div>
                            </div>
                        </c:if>
                    </div>
                    
                    <!-- 상담 내용 -->
                    <c:if test="${not empty consultation.content}">
                        <div class="mb-4">
                            <h5 class="mb-3"><i class="fas fa-comment-dots me-2"></i>상담 내용</h5>
                            <div class="content-box">
                                <p class="mb-0">${consultation.content}</p>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- 예약 정보 -->
                    <div class="info-section">
                        <h5 class="mb-3"><i class="fas fa-info-circle me-2"></i>예약 정보</h5>
                        
                        <div class="info-row">
                            <div class="info-label">예약일시</div>
                            <div class="info-value">
                                <fmt:formatDate value="${consultation.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                            </div>
                        </div>
                        
                        <div class="info-row">
                            <div class="info-label">마지막 수정</div>
                            <div class="info-value">
                                <fmt:formatDate value="${consultation.updatedAt}" pattern="yyyy-MM-dd HH:mm"/>
                            </div>
                        </div>
                        
                        <c:if test="${consultation.status == 'CONFIRMED'}">
                            <div class="info-row">
                                <div class="info-label">취소 가능</div>
                                <div class="info-value">
                                    <c:choose>
                                        <c:when test="${consultation.canCancel}">
                                            <span class="text-success">
                                                <i class="fas fa-check-circle me-1"></i>예약 1시간 전까지 가능
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-danger">
                                                <i class="fas fa-times-circle me-1"></i>취소 불가 (1시간 이내)
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:if>
                    </div>
                    
                    <!-- 취소된 예약 안내 -->
                    <c:if test="${consultation.status == 'CANCELLED'}">
                        <div class="alert alert-custom alert-secondary">
                            <div class="d-flex">
                                <i class="fas fa-info-circle me-3 mt-1"></i>
                                <div>
                                    <strong>취소된 예약</strong>
                                    <p class="mb-0 mt-2">
                                        이 예약은 취소되었습니다. 
                                        새로운 상담을 원하시면 다시 예약해주세요.
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- 버튼 영역 -->
                    <div class="d-flex justify-content-between flex-wrap gap-3 mt-4">
                        <a href="${pageContext.request.contextPath}/support/consultation" 
                           class="btn btn-outline-custom">
                            <i class="fas fa-arrow-left me-2"></i>목록으로
                        </a>
                        
                        <div class="d-flex gap-3">
                            <c:if test="${consultation.status == 'CONFIRMED' && consultation.canCancel}">
                                <button type="button" 
                                        class="btn btn-danger-custom"
                                        onclick="cancelConsultation()">
                                    <i class="fas fa-times me-2"></i>예약 취소
                                </button>
                            </c:if>
                            
                            <c:if test="${consultation.status == 'CANCELLED'}">
                                <a href="${pageContext.request.contextPath}/support/consultation/create" 
                                   class="btn btn-primary-custom">
                                    <i class="fas fa-plus me-2"></i>새 예약하기
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 예약 취소 함수
        function cancelConsultation() {
            if (confirm('정말로 예약을 취소하시겠습니까?\n\n취소된 예약은 복구할 수 없습니다.')) {
                fetch('${pageContext.request.contextPath}/support/consultation/cancel', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'consultationNum=${consultation.consultationNum}'
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