<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>소셜 가입 완료 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 - 초록색 */
        .page-header {
            background: linear-gradient(135deg, #28a745, #20c997);
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
        
        /* 기존 스타일 - 초록색으로 통일 */
        :root {
            --primary-color: #28a745;
            --bg-cream: #F4ECDC;
            --ink: #0F172A;
            --muted: #5B6170;
            --success: #10B981;
            --warning: #F59E0B;
            --danger: #EF4444;
        }
        
        .complete-container { 
            max-width: 500px; 
            margin: 40px auto; 
            background: #fff; 
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(15,23,42,0.1);
        }
        
        .brand-header {
            text-align: center;
            margin-bottom: 35px;
        }
        
        .brand-logo {
            font-size: 32px;
            font-weight: 900;
            color: var(--primary-color);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .brand-dot {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--primary-color);
            box-shadow: 0 0 15px rgba(40, 167, 69, 0.5);
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        
        .subtitle {
            color: var(--muted);
            font-size: 14px;
            margin: 0;
        }
        
        .success-icon {
            font-size: 4rem;
            color: var(--success);
            margin-bottom: 20px;
        }
        
        .social-info-section {
            background: #F8F9FA;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
        }
        
        .social-provider-info {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 15px;
        }
        
        .provider-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 700;
        }
        
        .provider-icon.naver { background: #03C75A; }
        .provider-icon.kakao { background: #FEE500; color: #3C1E1E; }
        .provider-icon.google { background: #4285F4; }
        
        .social-user-info h6 {
            margin: 0;
            color: var(--ink);
        }
        
        .social-user-info p {
            margin: 0;
            color: var(--muted);
            font-size: 14px;
        }
        
        .btn-primary {
            background: var(--primary-color);
            border: none;
            font-weight: 700;
            padding: 14px;
            border-radius: 12px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: #1e7e34;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(40, 167, 69, 0.3);
        }
        
        .form-control {
            border-radius: 12px;
            padding: 12px 16px;
            border: 2px solid #E7E0D6;
            font-size: 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.1);
        }
        
        .form-label {
            font-weight: 600;
            color: var(--ink);
            margin-bottom: 8px;
        }
        
        .verify-btn {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            margin-left: 8px;
            transition: all 0.3s ease;
        }
        
        .verify-btn:hover {
            background: #1e7e34;
        }
        
        .feedback {
            margin: 5px 0;
            padding: 8px 12px;
            border-radius: 8px;
            font-size: 13px;
        }
        
        .feedback.valid {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }
        
        .feedback.invalid {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }
        
        .skip-section {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #E7E0D6;
        }
        
        .btn-outline-secondary {
            border-color: #E7E0D6;
            color: var(--ink);
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
        }
        
        .alert {
            border-radius: 12px;
            border: none;
            padding: 15px 20px;
        }
        
        .alert-success {
            background: rgba(40, 167, 69, 0.1);
            color: var(--primary-color);
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
            .complete-container {
                margin: 20px auto;
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 통일된 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/">홈</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/user/login">회원</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">소셜 가입 완료</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">소셜 가입 완료</h2>
                    <p class="lead">마지막 단계입니다! 추가 정보를 입력하고 가입을 완료하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/" 
                       class="btn btn-light btn-lg">
                        <i class="fas fa-home me-2"></i>홈으로
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="complete-container">
                    <div class="brand-header">
                        <div class="brand-logo">
                            <span class="brand-dot"></span>
                            HELLKING
                            <span class="brand-dot"></span>
                        </div>
                        <p class="subtitle">소셜 가입을 완료해주세요</p>
                    </div>
                    
                    <div class="text-center mb-4">
                        <div class="success-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <h4 class="mb-3">가입이 거의 완료되었습니다!</h4>
                    </div>
                    
                    <!-- 소셜 계정 정보 표시 -->
                    <c:if test="${not empty sessionScope.userInfo}">
                        <div class="social-info-section">
                            <div class="social-provider-info">
                                <div class="provider-icon ${socialProvider.toLowerCase()}">
                                    <c:choose>
                                        <c:when test="${socialProvider == 'NAVER'}">N</c:when>
                                        <c:when test="${socialProvider == 'KAKAO'}"><i class="fas fa-comment"></i></c:when>
                                        <c:when test="${socialProvider == 'GOOGLE'}"><i class="fab fa-google"></i></c:when>
                                    </c:choose>
                                </div>
                                <div class="social-user-info">
                                    <h6>${sessionScope.userInfo.username}</h6>
                                    <p>${socialProvider} 계정으로 가입</p>
                                </div>
                            </div>
                            
                            <div class="alert alert-success">
                                <i class="fas fa-info-circle me-2"></i>
                                소셜 계정으로 성공적으로 가입되었습니다. 추가 정보를 입력하면 더 나은 서비스를 이용할 수 있습니다.
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- 추가 정보 입력 폼 -->
                    <form action="${pageContext.request.contextPath}/user/social/complete" method="post">
                        
                        <!-- 이메일 (선택사항) -->
                        <div class="mb-3">
                            <label class="form-label">
                                이메일 
                                <small class="text-muted">(선택사항)</small>
                            </label>
                            <div class="d-flex">
                                <input type="email" id="email" name="email" class="form-control" 
                                       placeholder="패스권 구매 알림 등을 받을 수 있습니다">
                                <button type="button" class="verify-btn" onclick="sendEmailVerification()" style="display: none;" id="emailVerifyBtn">인증</button>
                            </div>
                            <div id="emailFeedback" class="feedback"></div>
                        </div>
                        
                        <!-- 전화번호 (선택사항) -->
                        <div class="mb-3">
                            <label class="form-label">
                                전화번호 
                                <small class="text-muted">(선택사항)</small>
                            </label>
                            <div class="d-flex">
                                <input type="tel" id="phone" name="phone" class="form-control" 
                                       placeholder="예: 01012345678">
                                <button type="button" class="verify-btn" onclick="sendSMSVerification()" style="display: none;" id="phoneVerifyBtn">인증</button>
                            </div>
                            <div id="phoneFeedback" class="feedback"></div>
                        </div>
                        
                        <!-- 생년월일 (선택사항) -->
                        <div class="mb-3">
                            <label class="form-label">
                                생년월일 
                                <small class="text-muted">(선택사항)</small>
                            </label>
                            <input type="date" id="birthDate" name="birthDate" class="form-control">
                        </div>
                        
                        <!-- 성별 (선택사항) -->
                        <div class="mb-4">
                            <label class="form-label">
                                성별 
                                <small class="text-muted">(선택사항)</small>
                            </label><br>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" value="M" id="genderM">
                                <label class="form-check-label" for="genderM">남성</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" value="F" id="genderF">
                                <label class="form-check-label" for="genderF">여성</label>
                            </div>
                        </div>
                        
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-check me-2"></i>가입 완료
                            </button>
                        </div>
                        
                    </form>
                    
                    <!-- 건너뛰기 섹션 -->
                    <div class="skip-section">
                        <p class="text-muted mb-3">
                            <small>추가 정보는 나중에 마이페이지에서 입력할 수 있습니다.</small>
                        </p>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-right me-2"></i>바로 시작하기
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        console.log('=== 소셜 가입 완료 페이지 초기화 ===');
        
        // 전역 변수
        let emailVerified = false;
        let phoneVerified = false;
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            setupFormValidation();
        });
        
        // 폼 검증 설정
        function setupFormValidation() {
            // 이메일 입력 시 인증 버튼 표시
            document.getElementById('email').addEventListener('input', function() {
                const email = this.value.trim();
                const verifyBtn = document.getElementById('emailVerifyBtn');
                
                if (email && email.includes('@')) {
                    verifyBtn.style.display = 'inline-block';
                } else {
                    verifyBtn.style.display = 'none';
                }
                
                // 이전 인증 상태 초기화
                emailVerified = false;
                document.getElementById('emailFeedback').textContent = '';
            });
            
            // 전화번호 입력 시 인증 버튼 표시
            document.getElementById('phone').addEventListener('input', function() {
                const phone = this.value.trim();
                const verifyBtn = document.getElementById('phoneVerifyBtn');
                
                if (phone && phone.length >= 10) {
                    verifyBtn.style.display = 'inline-block';
                } else {
                    verifyBtn.style.display = 'none';
                }
                
                // 이전 인증 상태 초기화
                phoneVerified = false;
                document.getElementById('phoneFeedback').textContent = '';
            });
        }
        
        // 이메일 인증 발송
        function sendEmailVerification() {
            const email = document.getElementById('email').value.trim();
            
            if (!email) {
                alert('이메일을 입력하세요');
                return;
            }
            
            fetch('${pageContext.request.contextPath}/user/social/sendVerification', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'type=email&contact=' + encodeURIComponent(email)
            })
            .then(response => response.json())
            .then(data => {
                const feedback = document.getElementById('emailFeedback');
                if (data.success) {
                    feedback.className = 'feedback valid';
                    feedback.textContent = '인증번호가 발송되었습니다.';
                    showEmailVerificationInput();
                } else {
                    feedback.className = 'feedback invalid';
                    feedback.textContent = data.message;
                }
            })
            .catch(error => {
                console.error('이메일 인증 발송 실패:', error);
                alert('오류가 발생했습니다.');
            });
        }
        
        // SMS 인증 발송
        function sendSMSVerification() {
            const phone = document.getElementById('phone').value.trim();
            
            if (!phone) {
                alert('전화번호를 입력하세요');
                return;
            }
            
            fetch('${pageContext.request.contextPath}/user/social/sendVerification', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'type=sms&contact=' + encodeURIComponent(phone)
            })
            .then(response => response.json())
            .then(data => {
                const feedback = document.getElementById('phoneFeedback');
                if (data.success) {
                    feedback.className = 'feedback valid';
                    feedback.textContent = '인증번호가 발송되었습니다.';
                    showSMSVerificationInput();
                } else {
                    feedback.className = 'feedback invalid';
                    feedback.textContent = data.message;
                }
            })
            .catch(error => {
                console.error('SMS 인증 발송 실패:', error);
                alert('오류가 발생했습니다.');
            });
        }
        
        // 이메일 인증 입력 필드 표시
        function showEmailVerificationInput() {
            const container = document.getElementById('email').parentElement.parentElement;
            
            // 기존 인증 입력 필드 제거
            const existingVerifyDiv = container.querySelector('.email-verify-section');
            if (existingVerifyDiv) {
                existingVerifyDiv.remove();
            }
            
            // 새 인증 입력 필드 생성
            const verifyDiv = document.createElement('div');
            verifyDiv.className = 'email-verify-section mt-2';
            verifyDiv.innerHTML = `
                <div class="d-flex">
                    <input type="text" id="emailCode" class="form-control" placeholder="6자리 인증번호">
                    <button type="button" class="verify-btn" onclick="verifyEmailCode()">확인</button>
                </div>
            `;
            
            container.appendChild(verifyDiv);
        }
        
        // SMS 인증 입력 필드 표시
        function showSMSVerificationInput() {
            const container = document.getElementById('phone').parentElement.parentElement;
            
            // 기존 인증 입력 필드 제거
            const existingVerifyDiv = container.querySelector('.sms-verify-section');
            if (existingVerifyDiv) {
                existingVerifyDiv.remove();
            }
            
            // 새 인증 입력 필드 생성
            const verifyDiv = document.createElement('div');
            verifyDiv.className = 'sms-verify-section mt-2';
            verifyDiv.innerHTML = `
                <div class="d-flex">
                    <input type="text" id="smsCode" class="form-control" placeholder="6자리 인증번호">
                    <button type="button" class="verify-btn" onclick="verifySMSCode()">확인</button>
                </div>
            `;
            
            container.appendChild(verifyDiv);
        }
        
        // 이메일 인증 확인
        function verifyEmailCode() {
            const email = document.getElementById('email').value.trim();
            const code = document.getElementById('emailCode').value.trim();
            
            if (!code) {
                alert('인증번호를 입력하세요');
                return;
            }
            
            fetch('${pageContext.request.contextPath}/user/social/verifyCode', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'type=email&contact=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(code)
            })
            .then(response => response.json())
            .then(data => {
                const feedback = document.getElementById('emailFeedback');
                if (data.success) {
                    feedback.className = 'feedback valid';
                    feedback.textContent = '이메일 인증이 완료되었습니다.';
                    emailVerified = true;
                    
                    // 인증 입력 필드 숨기기
                    const verifySection = document.querySelector('.email-verify-section');
                    if (verifySection) {
                        verifySection.style.display = 'none';
                    }
                } else {
                    feedback.className = 'feedback invalid';
                    feedback.textContent = data.message;
                    emailVerified = false;
                }
            })
            .catch(error => {
                console.error('이메일 인증 확인 실패:', error);
                alert('오류가 발생했습니다.');
            });
        }
        
        // SMS 인증 확인
        function verifySMSCode() {
            const phone = document.getElementById('phone').value.trim();
            const code = document.getElementById('smsCode').value.trim();
            
            if (!code) {
                alert('인증번호를 입력하세요');
                return;
            }
            
            fetch('${pageContext.request.contextPath}/user/social/verifyCode', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'type=sms&contact=' + encodeURIComponent(phone) + '&code=' + encodeURIComponent(code)
            })
            .then(response => response.json())
            .then(data => {
                const feedback = document.getElementById('phoneFeedback');
                if (data.success) {
                    feedback.className = 'feedback valid';
                    feedback.textContent = 'SMS 인증이 완료되었습니다.';
                    phoneVerified = true;
                    
                    // 인증 입력 필드 숨기기
                    const verifySection = document.querySelector('.sms-verify-section');
                    if (verifySection) {
                        verifySection.style.display = 'none';
                    }
                } else {
                    feedback.className = 'feedback invalid';
                    feedback.textContent = data.message;
                    phoneVerified = false;
                }
            })
            .catch(error => {
                console.error('SMS 인증 확인 실패:', error);
                alert('오류가 발생했습니다.');
            });
        }
        
        console.log('소셜 가입 완료 페이지 초기화 완료');
    </script>
</body>
</html>