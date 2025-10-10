<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    // 권한 체크 (userNum이 1인지 확인)
String userRole = (String) session.getAttribute("userRole");
System.out.println("세션에서 가져온 userRole: [" + userRole + "]");
System.out.println("DB에 저장된 값과 비교해보세요");

if (!"ADMIN".equals(userRole)) {
    response.sendRedirect(request.getContextPath() + "/");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>환불 관리 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        .admin-header {
            background: linear-gradient(135deg, #495057, #343a40);
            color: white;
            padding: 60px 0;
        }
        
        .stats-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(15,23,42,0.1);
            height: 100%;
            transition: transform 0.2s;
        }
        .stats-card:hover {
            transform: translateY(-2px);
        }
        
        .stats-number {
            font-size: 2.5rem;
            font-weight: 900;
            margin-bottom: 10px;
        }
        .stats-requested { color: #ffc107; }
        .stats-approved { color: #198754; }
        .stats-rejected { color: #dc3545; }
        .stats-completed { color: #0d6efd; }
        
        .refund-card {
            background: white;
            border-radius: 16px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(15,23,42,0.1);
            border-left: 5px solid #ddd;
            transition: all 0.2s;
        }
        .refund-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(15,23,42,0.15);
        }
        
        .refund-requested { border-left-color: #ffc107; }
        .refund-approved { border-left-color: #198754; }
        .refund-rejected { border-left-color: #dc3545; }
        .refund-completed { border-left-color: #0d6efd; }
        
        .account-info {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 8px;
            margin: 10px 0;
            border-left: 3px solid #2196f3;
        }
        
        .account-info h6 {
            color: #1565c0;
            margin-bottom: 10px;
        }
        
        .account-detail {
            background: white;
            padding: 10px;
            border-radius: 6px;
            margin: 5px 0;
            font-family: 'Courier New', monospace;
            font-weight: bold;
        }
        
        .btn-copy {
            background: #f8f9fa;
            border: 1px solid #dee2e6;
            color: #6c757d;
            padding: 4px 8px;
            font-size: 12px;
            border-radius: 4px;
            margin-left: 10px;
        }
        
        .btn-copy:hover {
            background: #e9ecef;
            color: #495057;
        }
        
        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 600;
            font-size: 13px;
            display: inline-block;
        }
        .status-requested { background: #fff3cd; color: #856404; }
        .status-approved { background: #d4edda; color: #155724; }
        .status-rejected { background: #f8d7da; color: #721c24; }
        .status-completed { background: #cce7ff; color: #004085; }
        
        .btn-approve { 
            background: #198754; 
            border-color: #198754;
            color: white;
        }
        .btn-approve:hover {
            background: #157347;
            border-color: #146c43;
            color: white;
        }
        
        .btn-reject { 
            background: #dc3545; 
            border-color: #dc3545;
            color: white;
        }
        .btn-reject:hover {
            background: #bb2d3b;
            border-color: #b02a37;
            color: white;
        }
        
        .btn-complete { 
            background: #0d6efd; 
            border-color: #0d6efd;
            color: white;
        }
        .btn-complete:hover {
            background: #0b5ed7;
            border-color: #0a58ca;
            color: white;
        }
        
        .action-buttons .btn {
            margin: 3px;
            font-size: 14px;
            padding: 8px 16px;
            border-radius: 8px;
        }
        
        .filter-btn-group {
            background: white;
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 25px;
            box-shadow: 0 2px 10px rgba(15,23,42,0.05);
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 15px rgba(15,23,42,0.1);
        }
        
        .reason-section {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin: 10px 0;
        }
        
        .completed-account-info {
            opacity: 0.6;
        }
        
        .completed-account-info .account-detail {
            background: #f8f9fa;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 관리자 헤더 -->
    <div class="admin-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="mb-2">
                        <i class="fas fa-undo me-3"></i>환불 관리 시스템
                    </h1>
                    <p class="mb-0 opacity-85 fs-5">패스권 환불 신청 검토 및 처리</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/pass/list" class="btn btn-light btn-lg me-2">
                        <i class="fas fa-ticket-alt me-2"></i>패스권 관리
                    </a>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-light btn-lg">
                        <i class="fas fa-home me-2"></i>홈
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4 mb-5">
        <!-- 오류 메시지 표시 -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>${error}
            </div>
        </c:if>
        
        <!-- 통계 카드 -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-number stats-requested">${requestedCount}</div>
                    <div class="text-muted fw-bold">신청 대기</div>
                    <div class="small text-muted mt-1">검토 필요</div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-number stats-approved">${approvedCount}</div>
                    <div class="text-muted fw-bold">승인됨</div>
                    <div class="small text-muted mt-1">환불 대기</div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-number stats-rejected">${rejectedCount}</div>
                    <div class="text-muted fw-bold">거절됨</div>
                    <div class="small text-muted mt-1">처리 완료</div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stats-card">
                    <div class="stats-number stats-completed">${completedCount}</div>
                    <div class="text-muted fw-bold">완료됨</div>
                    <div class="small text-muted mt-1">환불 완료</div>
                </div>
            </div>
        </div>
        
        <!-- 필터 버튼 -->
        <div class="filter-btn-group">
            <div class="btn-group w-100" role="group">
                <button type="button" class="btn btn-outline-secondary active" onclick="filterRefunds('ALL')">
                    <i class="fas fa-list me-2"></i>전체 (${requestedCount + approvedCount + rejectedCount + completedCount})
                </button>
                <button type="button" class="btn btn-outline-warning" onclick="filterRefunds('REQUESTED')">
                    <i class="fas fa-clock me-2"></i>신청 대기 (${requestedCount})
                </button>
                <button type="button" class="btn btn-outline-success" onclick="filterRefunds('APPROVED')">
                    <i class="fas fa-check me-2"></i>승인됨 (${approvedCount})
                </button>
                <button type="button" class="btn btn-outline-danger" onclick="filterRefunds('REJECTED')">
                    <i class="fas fa-times me-2"></i>거절됨 (${rejectedCount})
                </button>
                <button type="button" class="btn btn-outline-primary" onclick="filterRefunds('COMPLETED')">
                    <i class="fas fa-check-double me-2"></i>완료됨 (${completedCount})
                </button>
            </div>
        </div>
        
        <!-- 환불 신청 목록 -->
        <div class="row">
            <div class="col-12">
                <c:choose>
                    <c:when test="${not empty refunds}">
                        <c:forEach var="refund" items="${refunds}">
                            <div class="refund-card refund-${refund.status.toLowerCase()}" data-status="${refund.status}">
                                <div class="row align-items-start">
                                    <!-- 사용자 정보 -->
                                    <div class="col-md-2">
                                        <div class="fw-bold fs-6">${refund.username}</div>
                                        <div class="small text-muted">환불번호: ${refund.refundNum}</div>
                                        <div class="small text-muted">패스번호: ${refund.userPassNum}</div>
                                    </div>
                                    
                                    <!-- 패스권 정보 -->
                                    <div class="col-md-2">
                                        <div class="fw-bold text-primary">${refund.passName}</div>
                                        <div class="fs-5 fw-bold text-success">${refund.formattedRefundAmount}</div>
                                    </div>
                                    
                                    <!-- 환불 사유 및 계좌 정보 -->
                                    <div class="col-md-4">
                                        <div class="reason-section">
                                            <div class="small text-muted mb-1 fw-bold">신청 사유:</div>
                                            <div class="text-truncate" title="${refund.reason}" style="max-width: 250px;">
                                                ${refund.reason}
                                            </div>
                                        </div>
                                        
                                        <!-- 거절 사유 표시 -->
                                        <c:if test="${not empty refund.rejectReason}">
                                            <div class="small text-danger mt-2">
                                                <strong>거절 사유:</strong> ${refund.rejectReason}
                                            </div>
                                        </c:if>
                                        
                                        <!-- 계좌 정보 표시 -->
                                        <c:if test="${refund.hasAccountInfo()}">
                                            <div class="account-info ${refund.status == 'COMPLETED' ? 'completed-account-info' : ''}">
                                                <h6><i class="fas fa-university me-2"></i>환불 계좌 정보</h6>
                                                
                                                <c:choose>
                                                    <c:when test="${refund.status == 'COMPLETED'}">
                                                        <!-- 완료된 건은 마스킹 처리 -->
                                                        <div class="account-detail">
                                                            <i class="fas fa-building me-2"></i>${refund.bankName}
                                                        </div>
                                                        <div class="account-detail">
                                                            <i class="fas fa-credit-card me-2"></i>${refund.maskedAccountNumber}
                                                        </div>
                                                        <div class="account-detail">
                                                            <i class="fas fa-user me-2"></i>${refund.maskedAccountHolder}
                                                        </div>
                                                        <div class="small text-success mt-2">
                                                            <i class="fas fa-check-circle me-1"></i>환불 완료 - 개인정보 보호를 위해 마스킹 처리됨
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- 진행중인 건은 전체 정보 표시 (관리자만) -->
                                                        <div class="account-detail">
                                                            <i class="fas fa-building me-2"></i>${refund.bankName}
                                                            <button class="btn-copy" onclick="copyToClipboard('${refund.bankName}')">복사</button>
                                                        </div>
                                                        <div class="account-detail">
                                                            <i class="fas fa-credit-card me-2"></i>${refund.accountNumber}
                                                            <button class="btn-copy" onclick="copyToClipboard('${refund.accountNumber}')">복사</button>
                                                        </div>
                                                        <div class="account-detail">
                                                            <i class="fas fa-user me-2"></i>${refund.accountHolder}
                                                            <button class="btn-copy" onclick="copyToClipboard('${refund.accountHolder}')">복사</button>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:if>
                                    </div>
                                    
                                    <!-- 날짜 및 상태 -->
                                    <div class="col-md-2">
                                        <div class="small text-muted mb-1">신청일</div>
                                        <div class="fw-bold"><fmt:formatDate value="${refund.requestDate}" pattern="MM-dd HH:mm" /></div>
                                        <c:if test="${not empty refund.processDate}">
                                            <div class="small text-muted mt-1">처리일</div>
                                            <div class="small"><fmt:formatDate value="${refund.processDate}" pattern="MM-dd HH:mm" /></div>
                                        </c:if>
                                        <div class="mt-2">
                                            <span class="status-badge status-${refund.status.toLowerCase()}">${refund.statusText}</span>
                                        </div>
                                    </div>
                                    
                                    <!-- 액션 버튼 -->
                                    <div class="col-md-2 text-end">
                                        <div class="action-buttons">
                                            <c:choose>
                                                <c:when test="${refund.status == 'REQUESTED'}">
                                                    <button class="btn btn-approve btn-sm" 
                                                            onclick="approveRefund(${refund.refundNum})">
                                                        <i class="fas fa-check me-1"></i>승인
                                                    </button>
                                                    <button class="btn btn-reject btn-sm" 
                                                            onclick="showRejectModal(${refund.refundNum})">
                                                        <i class="fas fa-times me-1"></i>거절
                                                    </button>
                                                </c:when>
                                                <c:when test="${refund.status == 'APPROVED'}">
                                                    <button class="btn btn-complete btn-sm" 
                                                            onclick="completeRefund(${refund.refundNum})">
                                                        <i class="fas fa-check-double me-1"></i>완료 처리
                                                    </button>
                                                    <div class="small text-muted mt-1">실제 환불 후 클릭</div>
                                                </c:when>
                                                <c:when test="${refund.status == 'REJECTED'}">
                                                    <span class="text-muted">
                                                        <i class="fas fa-ban me-1"></i>거절됨
                                                    </span>
                                                </c:when>
                                                <c:when test="${refund.status == 'COMPLETED'}">
                                                    <span class="text-primary">
                                                        <i class="fas fa-check-circle me-1"></i>환불 완료
                                                    </span>
                                                    <c:if test="${refund.hasAccountInfo()}">
                                                        <div class="mt-2">
                                                            <button class="btn btn-outline-danger btn-sm" 
                                                                    onclick="deleteAccountInfo(${refund.refundNum})">
                                                                <i class="fas fa-trash me-1"></i>계좌정보 즉시삭제
                                                            </button>
                                                        </div>
                                                    </c:if>
                                                </c:when>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <i class="fas fa-inbox fa-4x text-muted mb-4"></i>
                            <h4 class="text-muted mb-3">환불 신청이 없습니다</h4>
                            <p class="text-muted mb-4">현재 처리할 환불 신청이 없습니다.</p>
                            <a href="${pageContext.request.contextPath}/pass/list" class="btn btn-primary">
                                <i class="fas fa-ticket-alt me-2"></i>패스권 관리로 이동
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <!-- 거절 사유 입력 모달 -->
    <div class="modal fade" id="rejectModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-times-circle text-danger me-2"></i>환불 거절
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        거절 사유는 사용자에게 전달되므로 명확하고 정중하게 작성해주세요.
                    </div>
                    <div class="mb-3">
                        <label for="rejectReason" class="form-label fw-bold">거절 사유 <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="rejectReason" rows="5" 
                                  placeholder="환불 거절 사유를 상세히 입력해주세요. (최소 10글자 이상)" 
                                  maxlength="500" required></textarea>
                        <div class="form-text text-end">
                            <span id="reasonCount">0</span> / 500자
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">거절 사유 예시:</label>
                        <div class="btn-group-vertical w-100" role="group">
                            <button type="button" class="btn btn-outline-secondary btn-sm text-start" 
                                    onclick="setRejectReason('환불 신청 기간이 경과되었습니다. (구매 후 7일 이내)')">
                                환불 신청 기간 경과
                            </button>
                            <button type="button" class="btn btn-outline-secondary btn-sm text-start" 
                                    onclick="setRejectReason('패스권을 이미 상당 기간 사용하여 환불이 어렵습니다.')">
                                이미 상당 기간 사용
                            </button>
                            <button type="button" class="btn btn-outline-secondary btn-sm text-start" 
                                    onclick="setRejectReason('환불 사유가 불충분하거나 부정확합니다.')">
                                환불 사유 불충분
                            </button>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-arrow-left me-2"></i>취소
                    </button>
                    <button type="button" class="btn btn-danger" onclick="confirmReject()" id="confirmRejectBtn">
                        <i class="fas fa-ban me-2"></i>거절 확정
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let currentRefundNum = 0;
        const rejectModal = new bootstrap.Modal(document.getElementById('rejectModal'));
        
        // 페이지 로드시 디버깅 정보
        console.log('관리자 환불 관리 페이지 로드됨');
        console.log('총 환불 건수:', ${requestedCount + approvedCount + rejectedCount + completedCount});
        
        // 상태별 필터링
        function filterRefunds(status) {
            const cards = document.querySelectorAll('.refund-card');
            const buttons = document.querySelectorAll('.btn-group .btn');
            
            // 버튼 활성화 상태 변경
            buttons.forEach(btn => btn.classList.remove('active'));
            event.target.classList.add('active');
            
            // 카드 필터링
            cards.forEach(card => {
                if (status === 'ALL' || card.dataset.status === status) {
                    card.style.display = 'block';
                    setTimeout(() => {
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, 100);
                } else {
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(-10px)';
                    setTimeout(() => {
                        card.style.display = 'none';
                    }, 200);
                }
            });
        }
        
        // 클립보드 복사 기능 (호환성 개선)
        function copyToClipboard(text) {
            // 방법 1: 최신 Clipboard API 시도
            if (navigator.clipboard && window.isSecureContext) {
                navigator.clipboard.writeText(text).then(function() {
                    showCopySuccess();
                }).catch(function(err) {
                    console.error('Clipboard API 실패:', err);
                    fallbackCopyToClipboard(text);
                });
            } else {
                // 방법 2: 백업 방법 사용
                fallbackCopyToClipboard(text);
            }
        }

        // 백업 복사 방법
        function fallbackCopyToClipboard(text) {
            const textArea = document.createElement("textarea");
            textArea.value = text;
            textArea.style.position = "fixed";
            textArea.style.left = "-999999px";
            textArea.style.top = "-999999px";
            document.body.appendChild(textArea);
            textArea.focus();
            textArea.select();
            
            try {
                const result = document.execCommand('copy');
                if (result) {
                    showCopySuccess();
                } else {
                    showCopyError();
                }
            } catch (err) {
                console.error('백업 복사 방법도 실패:', err);
                showCopyError();
            } finally {
                document.body.removeChild(textArea);
            }
        }

        // 복사 성공 표시
        function showCopySuccess() {
            const btn = event.target;
            const originalText = btn.textContent;
            btn.textContent = '복사됨!';
            btn.style.background = '#28a745';
            btn.style.color = 'white';
            
            setTimeout(() => {
                btn.textContent = originalText;
                btn.style.background = '#f8f9fa';
                btn.style.color = '#6c757d';
            }, 2000);
        }

        // 복사 실패 표시
        function showCopyError() {
            const btn = event.target;
            const originalText = btn.textContent;
            btn.textContent = '복사실패';
            btn.style.background = '#dc3545';
            btn.style.color = 'white';
            
            setTimeout(() => {
                btn.textContent = originalText;
                btn.style.background = '#f8f9fa';
                btn.style.color = '#6c757d';
            }, 2000);
            
            // 수동 복사 안내
            alert('자동 복사에 실패했습니다.\n텍스트를 드래그하여 수동으로 복사해주세요:\n\n' + text);
        }
        
        // 환불 승인
        function approveRefund(refundNum) {
            console.log('승인 시도:', refundNum);
            
            if (!confirm('이 환불을 승인하시겠습니까?\n\n승인 후에는 실제 환불 처리를 진행해야 합니다.')) {
                return;
            }
            
            // 버튼 비활성화
            const approveBtn = event.target;
            approveBtn.disabled = true;
            approveBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>처리중...';
            
            fetch('${pageContext.request.contextPath}/pass/admin/refund/approve', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'refundNum=' + refundNum
            })
            .then(response => response.json())
            .then(data => {
                console.log('승인 응답:', data);
                alert(data.message);
                if (data.success) {
                    location.reload();
                } else {
                    // 실패시 버튼 복원
                    approveBtn.disabled = false;
                    approveBtn.innerHTML = '<i class="fas fa-check me-1"></i>승인';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('승인 처리 중 오류가 발생했습니다.');
                // 오류시 버튼 복원
                approveBtn.disabled = false;
                approveBtn.innerHTML = '<i class="fas fa-check me-1"></i>승인';
            });
        }
        
        // 거절 모달 표시
        function showRejectModal(refundNum) {
            console.log('거절 모달 표시:', refundNum);
            currentRefundNum = refundNum;
            document.getElementById('rejectReason').value = '';
            updateReasonCount();
            rejectModal.show();
        }
        
        // 거절 사유 예시 설정
        function setRejectReason(reason) {
            document.getElementById('rejectReason').value = reason;
            updateReasonCount();
        }
        
        // 글자수 카운트 업데이트
        function updateReasonCount() {
            const reason = document.getElementById('rejectReason').value;
            const count = reason.length;
            document.getElementById('reasonCount').textContent = count;
            
            // 버튼 활성화/비활성화
            const btn = document.getElementById('confirmRejectBtn');
            btn.disabled = count < 10;
            
            if (count < 10) {
                btn.classList.add('btn-secondary');
                btn.classList.remove('btn-danger');
            } else {
                btn.classList.remove('btn-secondary');
                btn.classList.add('btn-danger');
            }
        }
        
        // 거절 사유 입력 이벤트
        document.getElementById('rejectReason').addEventListener('input', updateReasonCount);
        
        // 환불 거절 확정
        function confirmReject() {
            const reason = document.getElementById('rejectReason').value.trim();
            
            console.log('거절 확정 시도:', currentRefundNum, reason);
            
            if (!reason) {
                alert('거절 사유를 입력해주세요.');
                return;
            }
            
            if (reason.length < 10) {
                alert('거절 사유를 10글자 이상 입력해주세요.');
                return;
            }
            
            if (!confirm('이 환불을 거절하시겠습니까?\n\n거절 사유: ' + reason)) {
                return;
            }
            
            // 버튼 비활성화
            const btn = document.getElementById('confirmRejectBtn');
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>처리중...';
            
            fetch('${pageContext.request.contextPath}/pass/admin/refund/reject', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'refundNum=' + currentRefundNum + '&rejectReason=' + encodeURIComponent(reason)
            })
            .then(response => response.json())
            .then(data => {
                console.log('거절 응답:', data);
                alert(data.message);
                if (data.success) {
                    rejectModal.hide();
                    location.reload();
                } else {
                    // 실패시 버튼 복원
                    btn.disabled = false;
                    btn.innerHTML = '<i class="fas fa-ban me-2"></i>거절 확정';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('거절 처리 중 오류가 발생했습니다.');
                // 오류시 버튼 복원
                btn.disabled = false;
                btn.innerHTML = '<i class="fas fa-ban me-2"></i>거절 확정';
            });
        }
        
        // 환불 완료
        function completeRefund(refundNum) {
            console.log('완료 처리 시도:', refundNum);
            
            if (!confirm('환불 처리를 완료하시겠습니까?\n\n실제 환불이 완료된 후에만 클릭해주세요.')) {
                return;
            }
            
            // 버튼 비활성화
            const completeBtn = event.target;
            completeBtn.disabled = true;
            completeBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>처리중...';
            
            fetch('${pageContext.request.contextPath}/pass/admin/refund/complete', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'refundNum=' + refundNum
            })
            .then(response => response.json())
            .then(data => {
                console.log('완료 응답:', data);
                alert(data.message);
                if (data.success) {
                    location.reload();
                } else {
                    // 실패시 버튼 복원
                    completeBtn.disabled = false;
                    completeBtn.innerHTML = '<i class="fas fa-check-double me-1"></i>완료 처리';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('완료 처리 중 오류가 발생했습니다.');
                // 오류시 버튼 복원
                completeBtn.disabled = false;
                completeBtn.innerHTML = '<i class="fas fa-check-double me-1"></i>완료 처리';
            });
        }
        
        // 계좌 정보 즉시 삭제
        function deleteAccountInfo(refundNum) {
            if (!confirm('계좌 정보를 즉시 삭제하시겠습니까?\n\n삭제된 정보는 복구할 수 없습니다.')) {
                return;
            }
            
            fetch('${pageContext.request.contextPath}/pass/admin/refund/deleteAccount', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'refundNum=' + refundNum
            })
            .then(response => response.json())
            .then(data => {
                alert(data.message);
                if (data.success) {
                    location.reload();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('계좌 정보 삭제 중 오류가 발생했습니다.');
            });
        }
        
        // 초기 상태 설정
        updateReasonCount();
    </script>
</body>
</html>