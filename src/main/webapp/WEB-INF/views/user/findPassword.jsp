<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>비밀번호 찾기 - 헬킹 피트니스</title>
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
        
        .step-indicator {
            display: flex;
            justify-content: center;
            margin-bottom: 30px;
            gap: 10px;
        }
        
        .step {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #E7E0D6;
            transition: background 0.3s;
        }
        
        .step.active {
            background: var(--primary-color);
        }
        
        .auth-method-selector {
            background: #F8F9FA;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            border: 2px solid #E7E0D6;
            display: none;
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
        
        .password-requirements {
            background: #F8F9FA;
            border-left: 4px solid var(--primary-color);
            padding: 15px;
            border-radius: 8px;
            margin: 15px 0;
        }
        
        .password-requirements h6 {
            color: var(--primary-color);
            margin-bottom: 10px;
            font-size: 14px;
        }
        
        .password-requirements ul {
            margin: 0;
            padding-left: 20px;
            font-size: 13px;
            color: var(--muted);
        }
        
        .password-strength {
            height: 6px;
            background: #E7E0D6;
            border-radius: 3px;
            margin: 8px 0;
            overflow: hidden;
        }
        
        .password-strength-fill {
            height: 100%;
            width: 0%;
            transition: all 0.3s;
            border-radius: 3px;
        }
        
        .strength-weak { background: #dc3545; width: 33%; }
        .strength-medium { background: #ffc107; width: 66%; }
        .strength-strong { background: #28a745; width: 100%; }
        
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
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 25px;
            border-radius: 15px;
            margin: 20px 0;
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
        
        .password-toggle {
            position: absolute;
            right: 50px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--muted);
            cursor: pointer;
            font-size: 14px;
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
                    <li class="breadcrumb-item active" aria-current="page">비밀번호 찾기</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">비밀번호 찾기</h2>
                    <p class="lead">아이디를 입력하고 인증을 통해 비밀번호를 재설정하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/user/findId" 
                       class="btn btn-light btn-lg">
                        <i class="fas fa-user-search me-2"></i>아이디 찾기
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
                        <h3 class="mb-2">비밀번호 찾기</h3>
                        <p class="text-muted mb-0">아이디를 입력 후 이메일 또는 SMS 인증으로 비밀번호를 재설정하세요</p>
                    </div>
                    
                    <!-- 단계 표시 -->
                    <div class="step-indicator">
                        <span class="step active" id="step1"></span>
                        <span class="step" id="step2"></span>
                        <span class="step" id="step3"></span>
                        <span class="step" id="step4"></span>
                    </div>
                    
                    <!-- 로딩 영역 -->
                    <div class="loading" id="loadingSection">
                        <div class="spinner"></div>
                        <p class="text-muted">비밀번호를 재설정하고 있습니다...</p>
                    </div>
                    
                    <!-- 입력 폼 -->
                    <form id="findPasswordForm">
                        <!-- 1단계: 아이디 입력 -->
                        <div id="userIdSection">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-user me-2"></i>아이디
                                </label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="userId" name="userId" 
                                           placeholder="아이디를 입력하세요" required>
                                    <button type="button" class="btn btn-verify" id="userIdCheckBtn">
                                        확인
                                    </button>
                                </div>
                                <div class="feedback" id="userIdFeedback"></div>
                            </div>
                        </div>
                        
                        <!-- 2단계: 인증 방법 선택 -->
                        <div class="auth-method-selector" id="authMethodSelector">
                            <h6 class="mb-3"><i class="fas fa-shield-alt me-2"></i>인증 방법 선택</h6>
                            <div class="auth-option" data-method="email" id="emailOption">
                                <input type="radio" name="authMethod" value="email" id="authEmail">
                                <label for="authEmail" class="mb-0" style="cursor: pointer;">
                                    <i class="fas fa-envelope me-2 text-primary"></i>
                                    <strong>이메일 인증</strong>
                                    <br><small class="text-muted">등록한 이메일로 인증번호 발송</small>
                                </label>
                            </div>
                            <div class="auth-option" data-method="sms" id="smsOption">
                                <input type="radio" name="authMethod" value="sms" id="authSMS">
                                <label for="authSMS" class="mb-0" style="cursor: pointer;">
                                    <i class="fas fa-mobile-alt me-2 text-success"></i>
                                    <strong>SMS 인증</strong>
                                    <br><small class="text-muted">등록한 휴대폰으로 인증번호 발송</small>
                                </label>
                            </div>
                        </div>
                        
                        <!-- 3단계: 이메일 인증 섹션 -->
                        <div class="auth-section" id="emailAuthSection">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-envelope me-2"></i>이메일 주소
                                </label>
                                <div class="input-group">
                                    <input type="email" class="form-control" id="email" name="email" 
                                           placeholder="등록한 이메일을 입력하세요">
                                    <button type="button" class="btn btn-verify" id="emailVerifyBtn">
                                        인증요청
                                    </button>
                                </div>
                                <div class="feedback" id="emailFeedback"></div>
                            </div>
                            
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
                        
                        <!-- 3단계: SMS 인증 섹션 -->
                        <div class="auth-section" id="smsAuthSection">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-mobile-alt me-2"></i>휴대폰번호
                                </label>
                                <div class="input-group">
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           placeholder="등록한 휴대폰번호를 입력하세요">
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
                        
                        <!-- 4단계: 새 비밀번호 설정 -->
                        <div id="passwordSection" style="display: none;">
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-lock me-2"></i>새 비밀번호
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" 
                                           placeholder="새 비밀번호 입력" required autocomplete="new-password">
                                    <button type="button" class="password-toggle" id="passwordToggle1">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="password-strength">
                                    <div class="password-strength-fill" id="passwordStrength"></div>
                                </div>
                                <div class="feedback" id="passwordFeedback"></div>
                            </div>
                            
                            <div class="form-group">
                                <label class="form-label">
                                    <i class="fas fa-lock me-2"></i>비밀번호 확인
                                </label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="confirmPassword" 
                                           placeholder="비밀번호 다시 입력" required autocomplete="new-password">
                                    <button type="button" class="password-toggle" id="passwordToggle2">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <div class="feedback" id="confirmFeedback"></div>
                            </div>
                            
                            <!-- 비밀번호 요구사항 -->
                            <div class="password-requirements">
                                <h6><i class="fas fa-shield-alt me-2"></i>비밀번호 요구사항</h6>
                                <ul>
                                    <li>8자 이상 16자 이하</li>
                                    <li>영문 대소문자, 숫자, 특수문자 중 3가지 이상 조합</li>
                                    <li>연속된 문자나 숫자 사용 금지</li>
                                    <li>아이디와 동일하거나 포함된 내용 사용 금지</li>
                                </ul>
                            </div>
                        </div>
                        
                        <!-- 제출 버튼 -->
                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" class="btn btn-primary" id="submitBtn" disabled>
                                <i class="fas fa-key me-2"></i>비밀번호 재설정
                            </button>
                        </div>
                    </form>
                    
                    <!-- 결과 표시 영역 -->
                    <div class="result-section" id="resultSection">
                        <div class="success-icon">
                            <i class="fas fa-check"></i>
                        </div>
                        <h4>비밀번호 재설정 완료!</h4>
                        <div class="result-card">
                            <h5><i class="fas fa-check-circle me-2"></i>성공적으로 변경되었습니다</h5>
                            <p class="mb-0">새로운 비밀번호로 안전하게 로그인하세요</p>
                        </div>
                        
                        <div class="d-grid gap-2 mt-3">
                            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary">
                                <i class="fas fa-sign-in-alt me-2"></i>로그인하기
                            </a>
                            <a href="${pageContext.request.contextPath}/user/findId" class="btn btn-outline-secondary">
                                <i class="fas fa-search me-2"></i>아이디 찾기
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
                        <a href="${pageContext.request.contextPath}/user/findId">
                            <i class="fas fa-search me-1"></i>아이디 찾기
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 전역 변수
        let userIdVerified = false;
        let emailVerified = false;
        let phoneVerified = false;
        let passwordValid = false;
        let confirmValid = false;
        let currentAuthMethod = '';
        let emailTimer = null;
        let phoneTimer = null;
        
        // 아이디 확인
        document.getElementById('userIdCheckBtn').addEventListener('click', function() {
            const userId = document.getElementById('userId').value.trim();
            
            if (!userId) {
                showFeedback('userIdFeedback', '아이디를 입력해주세요', 'invalid');
                return;
            }
            
            this.disabled = true;
            this.textContent = '확인중...';
            
            fetch('${pageContext.request.contextPath}/user/checkUserExists', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'userId=' + encodeURIComponent(userId)
            })
            .then(response => response.json())
            .then(data => {
                if (data.exists) {
                    showFeedback('userIdFeedback', '아이디 확인 완료', 'valid');
                    userIdVerified = true;
                    document.getElementById('authMethodSelector').style.display = 'block';
                    updateStep(2);
                } else {
                    showFeedback('userIdFeedback', '존재하지 않는 아이디입니다', 'invalid');
                    this.disabled = false;
                    this.textContent = '확인';
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showFeedback('userIdFeedback', '오류가 발생했습니다', 'invalid');
                this.disabled = false;
                this.textContent = '확인';
            });
        });
        
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
            resetAuthValidationState();
            updateStep(3);
        }
        
        // 인증 검증 상태 초기화
        function resetAuthValidationState() {
            emailVerified = false;
            phoneVerified = false;
            clearInterval(emailTimer);
            clearInterval(phoneTimer);
            
            // 피드백 초기화
            document.querySelectorAll('[id$="Feedback"]:not(#userIdFeedback)').forEach(fb => fb.textContent = '');
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
                    document.getElementById('passwordSection').style.display = 'block';
                    updateStep(4);
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
                    document.getElementById('passwordSection').style.display = 'block';
                    updateStep(4);
                    checkFormValid();
                } else {
                    showFeedback('phoneCodeFeedback', data.message, 'invalid');
                }
            });
        });
        
        // 비밀번호 강도 체크
        document.getElementById('newPassword').addEventListener('input', function() {
            const password = this.value;
            const userId = document.getElementById('userId').value;
            const strength = checkPasswordStrength(password, userId);
            
            updatePasswordStrength(strength);
            passwordValid = strength.valid;
            checkFormValid();
        });
        
        // 비밀번호 확인
        document.getElementById('confirmPassword').addEventListener('input', function() {
            const password = document.getElementById('newPassword').value;
            const confirm = this.value;
            
            if (!confirm) {
                document.getElementById('confirmFeedback').textContent = '';
                confirmValid = false;
            } else if (password === confirm) {
                showFeedback('confirmFeedback', '비밀번호가 일치합니다', 'valid');
                confirmValid = true;
            } else {
                showFeedback('confirmFeedback', '비밀번호가 일치하지 않습니다', 'invalid');
                confirmValid = false;
            }
            
            checkFormValid();
        });
        
        // 비밀번호 보기/숨기기 토글
        document.getElementById('passwordToggle1').addEventListener('click', function() {
            togglePasswordVisibility('newPassword', this);
        });
        
        document.getElementById('passwordToggle2').addEventListener('click', function() {
            togglePasswordVisibility('confirmPassword', this);
        });
        
        // 폼 제출
        document.getElementById('findPasswordForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            if (!userIdVerified) {
                alert('아이디 확인을 먼저 해주세요');
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
            
            if (!passwordValid || !confirmValid) {
                alert('비밀번호 설정을 완료해주세요');
                return;
            }
            
            const userId = document.getElementById('userId').value.trim();
            const newPassword = document.getElementById('newPassword').value;
            
            // 로딩 표시
            document.getElementById('findPasswordForm').style.display = 'none';
            document.getElementById('loadingSection').style.display = 'block';
            
            fetch('${pageContext.request.contextPath}/user/resetPasswordByUserId', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'userId=' + encodeURIComponent(userId) + '&newPassword=' + encodeURIComponent(newPassword)
            })
            .then(response => response.json())
            .then(data => {
                document.getElementById('loadingSection').style.display = 'none';
                
                if (data.success) {
                    document.getElementById('resultSection').style.display = 'block';
                } else {
                    document.getElementById('findPasswordForm').style.display = 'block';
                    alert(data.message || '비밀번호 재설정에 실패했습니다');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                document.getElementById('loadingSection').style.display = 'none';
                document.getElementById('findPasswordForm').style.display = 'block';
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
        
        function updateStep(step) {
            document.querySelectorAll('.step').forEach((el, index) => {
                if (index < step) {
                    el.classList.add('active');
                } else {
                    el.classList.remove('active');
                }
            });
        }
        
        function checkFormValid() {
            const submitBtn = document.getElementById('submitBtn');
            
            const authVerified = (currentAuthMethod === 'email' && emailVerified) || 
                                (currentAuthMethod === 'sms' && phoneVerified);
            
            if (userIdVerified && authVerified && passwordValid && confirmValid) {
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
        
        function checkPasswordStrength(password, userId) {
            const result = {
                score: 0,
                valid: false,
                message: ''
            };
            
            if (password.length < 8) {
                result.message = '8자 이상 입력해주세요';
                return result;
            }
            if (password.length > 16) {
                result.message = '16자 이하로 입력해주세요';
                return result;
            }
            
            if (userId && password.toLowerCase().includes(userId.toLowerCase())) {
                result.message = '아이디를 포함할 수 없습니다';
                return result;
            }
            
            if (/(.)\1{2,}/.test(password) || /012|123|234|345|456|567|678|789|890|abc|bcd|cde/.test(password.toLowerCase())) {
                result.message = '연속된 문자나 숫자는 사용할 수 없습니다';
                return result;
            }
            
            let complexity = 0;
            if (/[a-z]/.test(password)) complexity++;
            if (/[A-Z]/.test(password)) complexity++;
            if (/[0-9]/.test(password)) complexity++;
            if (/[^A-Za-z0-9]/.test(password)) complexity++;
            
            if (complexity < 3) {
                result.message = '영문 대소문자, 숫자, 특수문자 중 3가지 이상 사용해주세요';
                return result;
            }
            
            result.score = Math.min(complexity * 25, 100);
            result.valid = true;
            
            if (result.score >= 75) {
                result.message = '강력한 비밀번호입니다';
            } else if (result.score >= 50) {
                result.message = '보통 강도의 비밀번호입니다';
            } else {
                result.message = '약한 비밀번호입니다';
            }
            
            return result;
        }
        
        function updatePasswordStrength(strength) {
            const strengthBar = document.getElementById('passwordStrength');
            
            strengthBar.className = 'password-strength-fill';
            
            if (strength.score >= 75) {
                strengthBar.classList.add('strength-strong');
            } else if (strength.score >= 50) {
                strengthBar.classList.add('strength-medium');
            } else if (strength.score > 0) {
                strengthBar.classList.add('strength-weak');
            }
            
            if (strength.valid) {
                showFeedback('passwordFeedback', strength.message, 'valid');
            } else {
                showFeedback('passwordFeedback', strength.message, 'invalid');
            }
        }
        
        function togglePasswordVisibility(inputId, toggleBtn) {
            const input = document.getElementById(inputId);
            const icon = toggleBtn.querySelector('i');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.className = 'fas fa-eye-slash';
            } else {
                input.type = 'password';
                icon.className = 'fas fa-eye';
            }
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
    </script>
</body>
</html>