<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>아이디 찾기 - 헬킹 피트니스</title>
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
        
        /* 기존 스타일 조정 */
        :root {
            --primary-color: #28a745;
            --ink: #0F172A;
            --muted: #5B6170;
        }
        
        .find-container {
            max-width: 500px;
            margin: 40px auto;
            background: white;
            padding: 50px 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(15, 23, 42, 0.1);
        }
        
        .brand-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .brand-logo {
            color: var(--primary-color);
            font-size: 28px;
            font-weight: 900;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .brand-dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: var(--primary-color);
            box-shadow: 0 0 12px rgba(40, 167, 69, 0.5);
        }
        
        .auth-method-selector {
            background: #F8F9FA;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            border: 2px solid #E7E0D6;
        }
        
        .auth-option {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 10px;
            border: 2px solid transparent;
        }
        
        .auth-option:hover {
            background: rgba(40, 167, 69, 0.05);
        }
        
        .auth-option.selected {
            background: rgba(40, 167, 69, 0.1);
            border-color: var(--primary-color);
        }
        
        .auth-option input[type="radio"] {
            margin: 0;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            color: var(--ink);
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }
        
        .form-control {
            border-radius: 12px;
            padding: 15px 20px;
            border: 2px solid #E7E0D6;
            font-size: 16px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.1);
            outline: none;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-group .btn {
            position: absolute;
            right: 5px;
            top: 50%;
            transform: translateY(-50%);
            height: calc(100% - 10px);
            border-radius: 8px;
            padding: 0 16px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .btn-verify {
            background: var(--primary-color);
            color: white;
            border: none;
            transition: background 0.3s;
        }
        
        .btn-verify:hover {
            background: #1e7e34;
        }
        
        .btn-verify:disabled {
            background: #ccc;
            cursor: not-allowed;
        }
        
        .btn-primary {
            background: var(--primary-color);
            border: none;
            padding: 15px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 16px;
            transition: all 0.3s;
        }
        
        .btn-primary:hover {
            background: #1e7e34;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
        }
        
        .btn-primary:disabled {
            background: #ccc;
            transform: none;
            box-shadow: none;
            cursor: not-allowed;
        }
        
        .feedback {
            margin-top: 8px;
            font-size: 13px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .feedback.valid {
            color: #28a745;
        }
        
        .feedback.invalid {
            color: #dc3545;
        }
        
        .result-section {
            display: none;
            text-align: center;
            padding: 30px 0;
        }
        
        .success-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #28a745, #20c997);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            color: white;
            font-size: 32px;
        }
        
        .result-card {
            background: #F4ECDC;
            padding: 25px;
            border-radius: 15px;
            margin: 20px 0;
            border-left: 5px solid var(--primary-color);
        }
        
        .found-id {
            font-size: 24px;
            font-weight: bold;
            color: var(--primary-color);
            margin: 10px 0;
        }
        
        .additional-links {
            margin-top: 30px;
            text-align: center;
            padding-top: 20px;
            border-top: 1px solid #E7E0D6;
        }
        
        .additional-links a {
            color: var(--muted);
            text-decoration: none;
            font-size: 14px;
            margin: 0 15px;
            transition: color 0.3s;
        }
        
        .additional-links a:hover {
            color: var(--primary-color);
        }
        
        .timer {
            color: var(--primary-color);
            font-weight: bold;
            font-size: 13px;
        }
        
        .loading {
            display: none;
            text-align: center;
            padding: 20px;
        }
        
        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid #E7E0D6;
            border-top: 4px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 15px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .auth-section {
            display: none;
        }
        
        .auth-section.active {
            display: block;
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
            .find-container {
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
                    <li class="breadcrumb-item active" aria-current="page">아이디 찾기</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">아이디 찾기</h2>
                    <p class="lead">이메일 또는 SMS 인증을 통해 아이디를 찾을 수 있습니다</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/user/login" 
                       class="btn btn-light btn-lg">
                        <i class="fas fa-sign-in-alt me-2"></i>로그인
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="find-container">
                    <!-- 브랜드 헤더 -->
                    <div class="brand-header">
                        <div class="brand-logo">
                            <span class="brand-dot"></span>
                            HELLKING
                        </div>
                        <h3 class="mb-2">아이디 찾기</h3>
                        <p class="text-muted mb-0">이메일 또는 SMS 인증을 통해 아이디를 찾을 수 있습니다</p>
                    </div>
                    
                    <!-- 인증 방법 선택 -->
                    <div class="auth-method-selector">
                        <h6 class="mb-3"><i class="fas fa-shield-alt me-2"></i>인증 방법 선택</h6>
                        <div class="auth-option" data-method="email" id="emailOption">
                            <input type="radio" name="authMethod" value="email" id="authEmail">
                            <label for="authEmail" class="mb-0" style="cursor: pointer;">
                                <i class="fas fa-envelope me-2 text-primary"></i>
                                <strong>이메일로 찾기</strong>
                                <br><small class="text-muted">등록하신 이메일로 아이디 찾기</small>
                            </label>
                        </div>
                        <div class="auth-option" data-method="sms" id="smsOption">
                            <input type="radio" name="authMethod" value="sms" id="authSMS">
                            <label for="authSMS" class="mb-0" style="cursor: pointer;">
                                <i class="fas fa-mobile-alt me-2 text-success"></i>
                                <strong>휴대폰으로 찾기</strong>
                                <br><small class="text-muted">등록하신 휴대폰번호로 아이디 찾기</small>
                            </label>
                        </div>
                    </div>
                    
                    <!-- 로딩 영역 -->
                    <div class="loading" id="loadingSection">
                        <div class="spinner"></div>
                        <p class="text-muted">아이디를 찾고 있습니다...</p>
                    </div>
                    
                    <!-- 입력 폼 -->
                    <form id="findIdForm">
                        <!-- 이메일 인증 섹션 -->
                        <div class="auth-section" id="emailAuthSection">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-envelope me-2"></i>이메일 주소
                                </label>
                                <div class="input-group">
                                    <input type="email" class="form-control" id="email" name="email" 
                                           placeholder="등록하신 이메일을 입력하세요">
                                    <button type="button" class="btn btn-verify" id="emailVerifyBtn">
                                        인증요청
                                    </button>
                                </div>
                                <div class="feedback" id="emailFeedback"></div>
                            </div>
                            
                            <!-- 이메일 인증 코드 -->
                            <div class="form-group" id="emailCodeGroup" style="display: none;">
                                <label class="form-label">
                                    <i class="fas fa-key me-2"></i>이메일 인증번호
                                </label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="emailCode" 
                                           placeholder="인증번호 6자리 입력" maxlength="6">
                                    <button type="button" class="btn btn-verify" id="emailCodeVerifyBtn">
                                        확인
                                    </button>
                                </div>
                                <div class="feedback" id="emailCodeFeedback"></div>
                                <div class="timer" id="emailTimer"></div>
                            </div>
                        </div>
                        
                        <!-- SMS 인증 섹션 -->
                        <div class="auth-section" id="smsAuthSection">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-mobile-alt me-2"></i>휴대폰번호
                                </label>
                                <div class="input-group">
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           placeholder="등록하신 휴대폰번호를 입력하세요">
                                    <button type="button" class="btn btn-verify" id="phoneVerifyBtn">
                                        인증요청
                                    </button>
                                </div>
                                <div class="feedback" id="phoneFeedback"></div>
                            </div>
                            
                            <div class="form-group" id="phoneCodeGroup" style="display: none;">
                                <label class="form-label">
                                    <i class="fas fa-key me-2"></i>SMS 인증번호
                                </label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="phoneCode" 
                                           placeholder="인증번호 6자리 입력" maxlength="6">
                                    <button type="button" class="btn btn-verify" id="phoneCodeVerifyBtn">
                                        확인
                                    </button>
                                </div>
                                <div class="feedback" id="phoneCodeFeedback"></div>
                                <div class="timer" id="phoneTimer"></div>
                            </div>
                        </div>
                        
                        <!-- 제출 버튼 -->
                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" class="btn btn-primary" id="submitBtn" disabled>
                                <i class="fas fa-search me-2"></i>아이디 찾기
                            </button>
                        </div>
                    </form>
                    
                    <!-- 결과 표시 영역 -->
                    <div class="result-section" id="resultSection">
                        <div class="success-icon">
                            <i class="fas fa-check"></i>
                        </div>
                        <h4>아이디를 찾았습니다!</h4>
                        <div class="result-card">
                            <p class="mb-2">고객님의 아이디는</p>
                            <div class="found-id" id="foundUserId"></div>
                            <p class="mb-0 text-muted">입니다.</p>
                        </div>
                        
                        <div class="d-grid gap-2 mt-3">
                            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary">
                                <i class="fas fa-sign-in-alt me-2"></i>로그인하기
                            </a>
                            <a href="${pageContext.request.contextPath}/user/findPassword" class="btn btn-outline-secondary">
                                <i class="fas fa-lock me-2"></i>비밀번호 찾기
                            </a>
                        </div>
                    </div>
                    
                    <!-- 추가 링크 -->
                    <div class="additional-links">
                        <a href="${pageContext.request.contextPath}/user/login">
                            <i class="fas fa-sign-in-alt me-1"></i>로그인
                        </a>
                        <a href="${pageContext.request.contextPath}/user/join">
                            <i class="fas fa-user-plus me-1"></i>회원가입
                        </a>
                        <a href="${pageContext.request.contextPath}/user/findPassword">
                            <i class="fas fa-lock me-1"></i>비밀번호 찾기
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 전역 변수
        let emailVerified = false;
        let phoneVerified = false;
        let emailTimer = null;
        let phoneTimer = null;
        let currentAuthMethod = '';
        
        // 인증 방법 선택 - 클릭 이벤트로 변경
        document.getElementById('emailOption').addEventListener('click', function() {
            selectAuthMethod('email');
        });
        
        document.getElementById('smsOption').addEventListener('click', function() {
            selectAuthMethod('sms');
        });
        
        // 인증 방법 선택
        function selectAuthMethod(method) {
            currentAuthMethod = method;
            
            // 라디오 버튼 체크
            document.getElementById('authEmail').checked = (method === 'email');
            document.getElementById('authSMS').checked = (method === 'sms');
            
            // 선택 스타일 적용
            document.querySelectorAll('.auth-option').forEach(option => {
                option.classList.remove('selected');
            });
            document.getElementById(method + 'Option').classList.add('selected');
            
            // 해당 섹션 표시
            document.querySelectorAll('.auth-section').forEach(section => {
                section.classList.remove('active');
            });
            document.getElementById(method + 'AuthSection').classList.add('active');
            
            // 검증 상태 초기화
            resetValidationState();
        }
        
        // 검증 상태 초기화
        function resetValidationState() {
            emailVerified = false;
            phoneVerified = false;
            clearInterval(emailTimer);
            clearInterval(phoneTimer);
            
            // 피드백 초기화
            document.querySelectorAll('.feedback').forEach(fb => fb.textContent = '');
            document.querySelectorAll('[id$="CodeGroup"]').forEach(group => group.style.display = 'none');
            document.querySelectorAll('[id$="Timer"]').forEach(timer => timer.textContent = '');
            
            checkFormValid();
        }
        
        // 이메일 인증 요청
        document.getElementById('emailVerifyBtn').addEventListener('click', function() {
            const email = document.getElementById('email').value.trim();
            
            if (!email || !isValidEmail(email)) {
                showFeedback('emailFeedback', '올바른 이메일 주소를 입력해주세요', 'invalid');
                return;
            }
            
            this.disabled = true;
            this.textContent = '발송중...';
            
            fetch('${pageContext.request.contextPath}/user/sendEmail', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'email=' + encodeURIComponent(email)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showFeedback('emailFeedback', data.message, 'valid');
                    document.getElementById('emailCodeGroup').style.display = 'block';
                    startEmailTimer();
                } else {
                    showFeedback('emailFeedback', data.message, 'invalid');
                    this.disabled = false;
                    this.textContent = '인증요청';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showFeedback('emailFeedback', '오류가 발생했습니다', 'invalid');
                this.disabled = false;
                this.textContent = '인증요청';
            });
        });
        
        // 이메일 인증번호 확인
        document.getElementById('emailCodeVerifyBtn').addEventListener('click', function() {
            const email = document.getElementById('email').value.trim();
            const code = document.getElementById('emailCode').value.trim();
            
            if (!code || code.length !== 6) {
                showFeedback('emailCodeFeedback', '6자리 인증번호를 입력해주세요', 'invalid');
                return;
            }
            
            fetch('${pageContext.request.contextPath}/user/verifyEmail', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'email=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(code)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    emailVerified = true;
                    showFeedback('emailCodeFeedback', data.message, 'valid');
                    clearInterval(emailTimer);
                    document.getElementById('emailTimer').textContent = '';
                    checkFormValid();
                } else {
                    showFeedback('emailCodeFeedback', data.message, 'invalid');
                }
            });
        });
        
        // SMS 인증 요청
        document.getElementById('phoneVerifyBtn').addEventListener('click', function() {
            const phone = document.getElementById('phone').value.trim();
            
            if (!phone || !isValidPhone(phone)) {
                showFeedback('phoneFeedback', '올바른 휴대폰번호를 입력해주세요', 'invalid');
                return;
            }
            
            this.disabled = true;
            this.textContent = '발송중...';
            
            fetch('${pageContext.request.contextPath}/user/sendSMS', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'phone=' + encodeURIComponent(phone)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showFeedback('phoneFeedback', data.message, 'valid');
                    document.getElementById('phoneCodeGroup').style.display = 'block';
                    startPhoneTimer();
                } else {
                    showFeedback('phoneFeedback', data.message, 'invalid');
                    this.disabled = false;
                    this.textContent = '인증요청';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showFeedback('phoneFeedback', '오류가 발생했습니다', 'invalid');
                this.disabled = false;
                this.textContent = '인증요청';
            });
        });
        
        // SMS 인증번호 확인
        document.getElementById('phoneCodeVerifyBtn').addEventListener('click', function() {
            const phone = document.getElementById('phone').value.trim();
            const code = document.getElementById('phoneCode').value.trim();
            
            if (!code || code.length !== 6) {
                showFeedback('phoneCodeFeedback', '6자리 인증번호를 입력해주세요', 'invalid');
                return;
            }
            
            fetch('${pageContext.request.contextPath}/user/verifySMS', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'phone=' + encodeURIComponent(phone) + '&code=' + encodeURIComponent(code)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    phoneVerified = true;
                    showFeedback('phoneCodeFeedback', data.message, 'valid');
                    clearInterval(phoneTimer);
                    document.getElementById('phoneTimer').textContent = '';
                    checkFormValid();
                } else {
                    showFeedback('phoneCodeFeedback', data.message, 'invalid');
                }
            });
        });
        
        // 아이디 찾기 제출
        document.getElementById('findIdForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (!currentAuthMethod) {
                alert('인증 방법을 선택해주세요');
                return;
            }
            
            if (currentAuthMethod === 'email' && !emailVerified) {
                alert('이메일 인증을 완료해주세요');
                return;
            }
            
            if (currentAuthMethod === 'sms' && !phoneVerified) {
                alert('SMS 인증을 완료해주세요');
                return;
            }
            
            // 로딩 표시
            document.getElementById('findIdForm').style.display = 'none';
            document.getElementById('loadingSection').style.display = 'block';
            
            // 단일 값으로 요청
            let requestBody = '';
            if (currentAuthMethod === 'email') {
                const email = document.getElementById('email').value.trim();
                requestBody = 'email=' + encodeURIComponent(email);
            } else {
                const phone = document.getElementById('phone').value.trim();
                requestBody = 'phone=' + encodeURIComponent(phone);
            }
            
            fetch('${pageContext.request.contextPath}/user/findIdBy' + (currentAuthMethod === 'email' ? 'Email' : 'Phone'), {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: requestBody
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loadingSection').style.display = 'none';
                
                if (data.success && data.userId) {
                    document.getElementById('foundUserId').textContent = data.userId;
                    document.getElementById('resultSection').style.display = 'block';
                } else {
                    document.getElementById('findIdForm').style.display = 'block';
                    alert(data.message || '일치하는 회원정보가 없습니다');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('loadingSection').style.display = 'none';
                document.getElementById('findIdForm').style.display = 'block';
                alert('오류가 발생했습니다. 다시 시도해주세요');
            });
        });
        
        // 유틸리티 함수들
        function showFeedback(elementId, message, type) {
            const feedback = document.getElementById(elementId);
            feedback.textContent = message;
            feedback.className = `feedback ${type}`;
            
            if (type === 'valid') {
                feedback.innerHTML = '<i class="fas fa-check-circle me-1"></i>' + message;
            } else if (type === 'invalid') {
                feedback.innerHTML = '<i class="fas fa-exclamation-circle me-1"></i>' + message;
            }
        }
        
        function isValidEmail(email) {
            return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
        }
        
        function isValidPhone(phone) {
            return /^01[0-9]{8,9}$/.test(phone);
        }
        
        function checkFormValid() {
            const submitBtn = document.getElementById('submitBtn');
            
            if (currentAuthMethod === 'email' && emailVerified) {
                submitBtn.disabled = false;
            } else if (currentAuthMethod === 'sms' && phoneVerified) {
                submitBtn.disabled = false;
            } else {
                submitBtn.disabled = true;
            }
        }
        
        function startEmailTimer() {
            let seconds = 300; // 5분
            emailTimer = setInterval(() => {
                const minutes = Math.floor(seconds / 60);
                const remainingSeconds = seconds % 60;
                document.getElementById('emailTimer').textContent = 
                    `남은 시간: ${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
                
                if (seconds <= 0) {
                    clearInterval(emailTimer);
                    document.getElementById('emailTimer').textContent = '인증시간이 만료되었습니다';
                    document.getElementById('emailVerifyBtn').disabled = false;
                    document.getElementById('emailVerifyBtn').textContent = '재발송';
                }
                seconds--;
            }, 1000);
        }
        
        function startPhoneTimer() {
            let seconds = 180; // 3분
            phoneTimer = setInterval(() => {
                const minutes = Math.floor(seconds / 60);
                const remainingSeconds = seconds % 60;
                document.getElementById('phoneTimer').textContent = 
                    `남은 시간: ${minutes}:${remainingSeconds.toString().padStart(2, '0')}`;
                
                if (seconds <= 0) {
                    clearInterval(phoneTimer);
                    document.getElementById('phoneTimer').textContent = '인증시간이 만료되었습니다';
                    document.getElementById('phoneVerifyBtn').disabled = false;
                    document.getElementById('phoneVerifyBtn').textContent = '재발송';
                }
                seconds--;
            }, 1000);
        }
        
        // 입력 필드 자동 포맷
        document.getElementById('phone').addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
        
        document.getElementById('emailCode').addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
        
        document.getElementById('phoneCode').addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
        });
        
        // 초기 상태: 이메일 인증 선택
        selectAuthMethod('email');
    </script>
</body>
</html>