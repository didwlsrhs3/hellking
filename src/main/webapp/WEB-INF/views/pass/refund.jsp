<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>환불 신청 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        .page-header {
            background: linear-gradient(135deg, #6f42c1, #5a2d91);
            color: white;
            padding: 60px 0;
        }
        
        .refund-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(15,23,42,0.1);
        }
        .pass-info {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
        }
        .account-info {
            background: #e3f2fd;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            border-left: 4px solid #2196f3;
        }
        .btn-submit {
            background: #dc3545;
            border: none;
            color: white;
            font-weight: 600;
            padding: 12px 30px;
            border-radius: 12px;
        }
        .btn-submit:hover {
            background: #c82333;
            color: white;
        }
        .security-notice {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
        }
        .btn-submit:disabled {
            background: #6c757d;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 환불 신청 헤더 -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">패스권 환불 신청</h2>
                    <p class="lead">간편하고 투명한 환불 처리 시스템</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="stats-card text-center p-3" style="background: rgba(255,255,255,0.2); border: 1px solid rgba(255,255,255,0.3); border-radius: 12px;">
                        <h5 class="mb-1">환불 정책</h5>
                        <p class="mb-0 small">수수료 10%<br>3-5일 처리</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- 뒤로가기 버튼 -->
                <div class="mb-3">
                    <a href="${pageContext.request.contextPath}/pass/detail/${userPass.userPassNum}" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>상세보기로 돌아가기
                    </a>
                </div>
                
                <div class="refund-card">
                    <div class="text-center mb-4">
                        <h2>환불 신청</h2>
                        <p class="text-muted">패스권 환불을 신청하시겠습니까?</p>
                    </div>
                    
                    <!-- 패스권 정보 -->
                    <div class="pass-info">
                        <h5 class="mb-3">환불 대상 패스권</h5>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <strong>패스권명:</strong> ${userPass.passName}
                                </div>
                                <div class="mb-2">
                                    <strong>결제금액:</strong> ${userPass.formattedPrice}
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-2">
                                    <strong>구매일:</strong> 
                                    <fmt:formatDate value="${userPass.purchaseDate}" pattern="yyyy-MM-dd" />
                                </div>
                                <div class="mb-2">
                                    <strong>남은기간:</strong> ${userPass.remainingDays}일
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 보안 안내 -->
                    <div class="security-notice">
                        <h6><i class="fas fa-shield-alt me-2"></i>개인정보 보호 안내</h6>
                        <ul class="mb-0 small">
                            <li>입력하신 계좌 정보는 환불 처리 목적으로만 사용됩니다</li>
                            <li>환불 완료 후 계좌 정보는 30일 후 자동 삭제됩니다</li>
                            <li>관리자만 계좌 정보를 확인할 수 있습니다</li>
                        </ul>
                    </div>
                    
                    <!-- 환불 계좌 정보 -->
                    <div class="account-info">
                        <h5 class="mb-3"><i class="fas fa-university me-2"></i>환불 받을 계좌 정보</h5>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label for="bankName" class="form-label fw-bold">은행명 <span class="text-danger">*</span></label>
                                <select class="form-select" id="bankName" name="bankName" required>
                                    <option value="">은행 선택</option>
                                    <option value="KB국민은행">KB국민은행</option>
                                    <option value="신한은행">신한은행</option>
                                    <option value="우리은행">우리은행</option>
                                    <option value="하나은행">하나은행</option>
                                    <option value="농협은행">농협은행</option>
                                    <option value="기업은행">기업은행</option>
                                    <option value="SC제일은행">SC제일은행</option>
                                    <option value="씨티은행">씨티은행</option>
                                    <option value="대구은행">대구은행</option>
                                    <option value="부산은행">부산은행</option>
                                    <option value="광주은행">광주은행</option>
                                    <option value="제주은행">제주은행</option>
                                    <option value="전북은행">전북은행</option>
                                    <option value="경남은행">경남은행</option>
                                    <option value="카카오뱅크">카카오뱅크</option>
                                    <option value="케이뱅크">케이뱅크</option>
                                    <option value="토스뱅크">토스뱅크</option>
                                </select>
                            </div>
                            <div class="col-md-5 mb-3">
                                <label for="accountNumber" class="form-label fw-bold">계좌번호 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="accountNumber" name="accountNumber" 
                                       placeholder="'-' 없이 숫자만 입력" 
                                       pattern="[0-9]+" 
                                       maxlength="20" required>
                                <div class="form-text">하이픈(-)을 제외하고 숫자만 입력해주세요</div>
                            </div>
                            <div class="col-md-3 mb-3">
                                <label for="accountHolder" class="form-label fw-bold">예금주명 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="accountHolder" name="accountHolder" 
                                       placeholder="예금주명" 
                                       maxlength="20" required>
                            </div>
                        </div>
                        <div class="alert alert-info">
                            <small><i class="fas fa-info-circle me-2"></i>계좌 정보는 환불 처리 완료 후 개인정보 보호를 위해 자동 삭제됩니다.</small>
                        </div>
                    </div>
                    
                    <!-- 환불 정책 안내 -->
                    <div class="alert alert-warning">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>환불 정책</h6>
                        <ul class="mb-0 small">
                            <li>사용한 날짜만큼 차감 후 환불됩니다.</li>
                            <li>환불 수수료 10%가 적용됩니다.</li>
                            <li>환불 처리는 영업일 기준 3-5일 소요됩니다.</li>
                        </ul>
                    </div>
                    
                    <!-- 환불 신청 폼 -->
                    <form id="refundForm">
                        <input type="hidden" name="userPassNum" value="${userPass.userPassNum}">
                        
                        <div class="mb-4">
                            <label for="reason" class="form-label fw-bold">환불 사유 <span class="text-danger">*</span></label>
                            <select class="form-select mb-3" id="reasonSelect" onchange="handleReasonChange()">
                                <option value="">환불 사유를 선택해주세요</option>
                                <option value="서비스 불만족">서비스 불만족</option>
                                <option value="시설 문제">시설 문제</option>
                                <option value="개인 사정">개인 사정</option>
                                <option value="기타">기타</option>
                            </select>
                            
                            <textarea class="form-control" id="reason" name="reason" rows="4" 
                                      placeholder="환불 사유를 상세히 작성해주세요. (최소 10글자 이상)" 
                                      maxlength="500" required></textarea>
                            <div class="form-text text-end">
                                <span id="reasonCount">0</span> / 500자
                            </div>
                        </div>
                        
                        <!-- 동의 체크박스 -->
                        <div class="mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="agreeRefund" required>
                                <label class="form-check-label" for="agreeRefund">
                                    위 환불 정책에 동의하며, 환불 신청을 진행합니다.
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="agreePrivacy" required>
                                <label class="form-check-label" for="agreePrivacy">
                                    계좌 정보 수집 및 이용에 동의합니다. (환불 완료 후 30일 후 자동 삭제)
                                </label>
                            </div>
                        </div>
                        
                        <div class="text-center">
                            <button type="submit" class="btn btn-submit me-2" id="submitBtn" disabled>
                                <i class="fas fa-check me-2"></i>환불 신청
                            </button>
                            <a href="${pageContext.request.contextPath}/pass/detail/${userPass.userPassNum}" 
                               class="btn btn-outline-secondary">
                                <i class="fas fa-times me-2"></i>취소
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 계좌번호 숫자만 입력 허용
        document.getElementById('accountNumber').addEventListener('input', function(e) {
            e.target.value = e.target.value.replace(/[^0-9]/g, '');
        });
        
        // 사유 선택 시 텍스트에어리어에 기본 내용 설정
        function handleReasonChange() {
            const select = document.getElementById('reasonSelect');
            const textarea = document.getElementById('reason');
            
            if (select.value && select.value !== '기타') {
                textarea.value = select.value + ': ';
                updateCharCount();
                updateSubmitButton();
            } else {
                textarea.value = '';
                updateCharCount();
                updateSubmitButton();
            }
            
            textarea.focus();
        }
        
        // 글자수 카운트
        document.getElementById('reason').addEventListener('input', function() {
            updateCharCount();
            updateSubmitButton();
        });
        
        function updateCharCount() {
            const textarea = document.getElementById('reason');
            const count = textarea.value.length;
            document.getElementById('reasonCount').textContent = count;
            
            if (count > 450) {
                document.getElementById('reasonCount').style.color = '#dc3545';
            } else {
                document.getElementById('reasonCount').style.color = '#6c757d';
            }
        }
        
        // 동의 체크박스들
        document.getElementById('agreeRefund').addEventListener('change', updateSubmitButton);
        document.getElementById('agreePrivacy').addEventListener('change', updateSubmitButton);
        
        // 계좌 정보 입력 이벤트
        document.getElementById('bankName').addEventListener('change', updateSubmitButton);
        document.getElementById('accountNumber').addEventListener('input', updateSubmitButton);
        document.getElementById('accountHolder').addEventListener('input', updateSubmitButton);
        
        // 제출 버튼 활성화
        function updateSubmitButton() {
            const reason = document.getElementById('reason').value.trim();
            const bankName = document.getElementById('bankName').value;
            const accountNumber = document.getElementById('accountNumber').value.trim();
            const accountHolder = document.getElementById('accountHolder').value.trim();
            const agreeRefund = document.getElementById('agreeRefund').checked;
            const agreePrivacy = document.getElementById('agreePrivacy').checked;
            
            const isValid = reason.length >= 10 && 
                           bankName && 
                           accountNumber.length >= 8 && 
                           accountHolder && 
                           agreeRefund && 
                           agreePrivacy;
            
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = !isValid;
            
            if (isValid) {
                submitBtn.classList.remove('btn-secondary');
                submitBtn.classList.add('btn-submit');
            } else {
                submitBtn.classList.remove('btn-submit');
                submitBtn.classList.add('btn-secondary');
            }
        }
        
        // 폼 제출
        document.getElementById('refundForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = {
                userPassNum: document.querySelector('input[name="userPassNum"]').value,
                reason: document.getElementById('reason').value.trim(),
                bankName: document.getElementById('bankName').value,
                accountNumber: document.getElementById('accountNumber').value,
                accountHolder: document.getElementById('accountHolder').value
            };
            
            if (!confirm('환불 신청을 진행하시겠습니까?\n\n신청 후에는 취소할 수 없습니다.')) {
                return;
            }
            
            // 제출 버튼 비활성화
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>처리 중...';
            
            // FormData 생성
            const requestData = new FormData();
            requestData.append('userPassNum', formData.userPassNum);
            requestData.append('reason', formData.reason);
            requestData.append('bankName', formData.bankName);
            requestData.append('accountNumber', formData.accountNumber);
            requestData.append('accountHolder', formData.accountHolder);
            
            fetch('${pageContext.request.contextPath}/pass/requestRefundWithAccount', {
                method: 'POST',
                body: requestData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('환불 신청이 완료되었습니다.\n\n관리자 검토 후 처리됩니다.');
                    window.location.href = '${pageContext.request.contextPath}/pass/mypass';
                } else {
                    alert('환불 신청에 실패했습니다.\n\n' + (data.message || '다시 시도해주세요.'));
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = '<i class="fas fa-check me-2"></i>환불 신청';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('환불 신청 중 오류가 발생했습니다.');
                submitBtn.disabled = false;
                submitBtn.innerHTML = '<i class="fas fa-check me-2"></i>환불 신청';
            });
        });
        
        // 페이지 로드 시 초기화
        updateCharCount();
        updateSubmitButton();
    </script>
</body>
</html>