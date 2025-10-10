<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<<<<<<< HEAD
    <title>회원가입 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
        }
        body { background: var(--bg-cream); }
        .join-container { 
            max-width: 500px; 
            margin: 50px auto; 
            background: #fff; 
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(15,23,42,0.1);
        }
        .brand-logo {
            text-align: center;
            font-size: 28px;
            font-weight: 900;
            color: var(--brand);
            margin-bottom: 30px;
        }
        .btn-primary {
            background: var(--brand);
            border: none;
            font-weight: 700;
            padding: 12px;
            border-radius: 12px;
        }
        .btn-primary:disabled {
            background: #6c757d;
            opacity: 0.65;
        }
        .form-control {
            border-radius: 12px;
            padding: 12px 16px;
            border: 2px solid #E7E0D6;
        }
        .form-control:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 0.2rem rgba(255,106,0,0.1);
        }
        .btn-check {
            background: #6c757d;
            font-size: 14px;
            padding: 8px 12px;
        }
        .btn-verify {
            background: var(--brand);
=======
    <title>회원가입 | 헬킹 피트니스</title>
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
            --muted-color: #5B6170;
            --success: #10B981;
            --warning: #F59E0B;
            --danger: #EF4444;
            --line: #E7E0D6;
            --hover: #FFF5EA;
        }
        
        .join-container { 
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
            box-shadow: 0 0 15px rgba(0, 123, 255, 0.5);
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        
        .subtitle {
            color: var(--muted-color);
            font-size: 14px;
            margin: 0;
        }
        
        /* 프로필 이미지 업로드 스타일 */
        .profile-upload-section {
            text-align: center;
            margin-bottom: 25px;
            padding: 20px;
            background: #F8F9FA;
            border-radius: 12px;
            border: 2px dashed var(--line);
        }
        
        .profile-preview {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--primary-color);
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .profile-preview:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
        }
        
        .upload-btn {
            background: var(--primary-color);
>>>>>>> b65c320 (Initial commit)
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
<<<<<<< HEAD
            font-size: 14px;
        }
        .valid-feedback {
            color: #198754;
        }
        .invalid-feedback {
            color: #dc3545;
=======
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .upload-btn:hover {
            background: #0056b3;
        }
        
        .file-info {
            margin-top: 10px;
            font-size: 12px;
            color: var(--muted-color);
        }
        
        /* 소셜 버튼 스타일 */
        .social-join-section {
            margin-bottom: 25px;
        }
        
        .social-buttons {
            display: flex;
            gap: 12px;
            margin-bottom: 15px;
        }
        
        .btn-social {
            flex: 1;
            padding: 12px;
            border-radius: 12px;
            border: 2px solid var(--line);
            background: white;
            color: #0F172A;
            font-weight: 600;
            font-size: 14px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            cursor: pointer;
            text-decoration: none;
        }
        
        .btn-social:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            color: #0F172A;
            text-decoration: none;
        }
        
        .btn-naver { border-color: #03C75A; }
        .btn-naver:hover { background: #03C75A; color: white; }
        
        .btn-kakao { border-color: #FEE500; }
        .btn-kakao:hover { background: #FEE500; color: #3C1E1E; }
        
        .btn-google { border-color: #4285F4; }
        .btn-google:hover { background: #4285F4; color: white; }
        
        .social-status {
            text-align: center;
            font-size: 12px;
            color: var(--muted-color);
        }
        
        .social-status.loading {
            color: var(--primary-color);
        }
        
        .divider {
            display: flex;
            align-items: center;
            margin: 30px 0;
        }
        
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: var(--line);
        }
        
        .divider span {
            padding: 0 20px;
            color: var(--muted-color);
            font-size: 14px;
        }
        
        /* 폼 스타일 */
        .btn-primary {
            background: var(--primary-color);
            border: none;
            font-weight: 700;
            padding: 14px;
            border-radius: 12px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover:not(:disabled) {
            background: #0056b3;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
        }
        
        .btn-primary:disabled {
            background: #ccc;
            cursor: not-allowed;
        }
        
        .form-control {
            border-radius: 12px;
            padding: 12px 16px;
            border: 2px solid var(--line);
            font-size: 15px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.1);
        }
        
        .form-label {
            font-weight: 600;
            color: #0F172A;
            margin-bottom: 8px;
        }
        
        .form-label.required::after {
            content: ' *';
            color: var(--danger);
        }
        
        .form-label.optional::after {
            content: ' (선택)';
            color: var(--muted-color);
            font-size: 12px;
            font-weight: normal;
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
            white-space: nowrap;
        }
        
        .verify-btn:hover {
            background: #0056b3;
        }
        
        .verify-section {
            margin-top: 15px;
            padding: 20px;
            background: #F8F9FA;
            border-radius: 12px;
            border: 2px dashed var(--line);
        }
        
        .additional-links {
            text-align: center;
            margin-top: 25px;
        }
        
        .additional-links a {
            color: var(--muted-color);
            text-decoration: none;
            font-size: 14px;
            margin: 0 12px;
            transition: color 0.3s;
        }
        
        .additional-links a:hover {
            color: var(--primary-color);
        }
        
        .alert {
            border-radius: 12px;
            border: none;
            padding: 15px 20px;
        }
        
        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }
        
        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid #f3f3f3;
            border-top: 3px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* 연락처 선택적 필수 안내 */
        .contact-notice {
            background: rgba(0, 123, 255, 0.1);
            border: 1px solid rgba(0, 123, 255, 0.3);
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 20px;
            font-size: 14px;
            color: var(--primary-color);
        }
        
        .contact-notice i {
            margin-right: 8px;
        }
        
        /* 비밀번호 강도 표시기 */
        .password-strength {
            margin-top: 8px;
            padding: 10px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .password-strength.weak {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }
        
        .password-strength.medium {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.2);
        }
        
        .password-strength.strong {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.2);
        }
        
        .password-requirements {
            margin-top: 8px;
            font-size: 12px;
        }
        
        .requirement {
            display: flex;
            align-items: center;
            margin: 4px 0;
            color: var(--muted-color);
            transition: color 0.3s ease;
        }
        
        .requirement.met {
            color: var(--success);
        }
        
        .requirement i {
            width: 16px;
            margin-right: 6px;
            font-size: 10px;
        }
        
        .password-strength-bar {
            width: 100%;
            height: 4px;
            background: #E7E0D6;
            border-radius: 2px;
            margin: 8px 0;
            overflow: hidden;
        }
        
        .strength-fill {
            height: 100%;
            width: 0%;
            transition: all 0.3s ease;
            border-radius: 2px;
        }
        
        .strength-fill.weak {
            width: 33%;
            background: var(--danger);
        }
        
        .strength-fill.medium {
            width: 66%;
            background: var(--warning);
        }
        
        .strength-fill.strong {
            width: 100%;
            background: var(--success);
        }
        
        /* 모달 스타일 */
        .modal-content {
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        
        .modal-header {
            border-bottom: 2px solid #F8F9FA;
            padding: 25px;
            border-radius: 20px 20px 0 0;
        }
        
        .modal-title {
            font-weight: 700;
            color: #0F172A;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .modal-body {
            padding: 30px 25px;
        }
        
        .social-info-section {
            background: #F8F9FA;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
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
            color: #0F172A;
        }
        
        .social-user-info p {
            margin: 0;
            color: var(--muted-color);
            font-size: 14px;
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
            .join-container {
                margin: 20px auto;
                padding: 30px 20px;
            }
>>>>>>> b65c320 (Initial commit)
        }
    </style>
</head>
<body>
<<<<<<< HEAD
    <div class="join-container">
        <div class="brand-logo">🏋️ HELLKING 회원가입</div>
        
        <c:if test="${not empty message}">
            <div class="alert alert-danger" role="alert">${message}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/user/joinPost" method="post" id="joinForm">
            <!-- 아이디 -->
            <div class="mb-3">
                <label for="userId" class="form-label">아이디 <span class="text-danger">*</span></label>
                <div class="input-group">
                    <input type="text" class="form-control" id="userId" name="userId" required>
                    <button type="button" class="btn btn-check" onclick="checkUserId()">중복확인</button>
                </div>
                <div class="form-text" id="userIdFeedback"></div>
            </div>
            
            <!-- 이름 -->
            <div class="mb-3">
                <label for="username" class="form-label">이름 <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            
            <!-- 이메일 -->
            <div class="mb-3">
                <label for="email" class="form-label">이메일 <span class="text-danger">*</span></label>
                <div class="input-group">
                    <input type="email" class="form-control" id="email" name="email" required>
                    <button type="button" class="btn btn-check" onclick="checkEmail()">중복확인</button>
                </div>
                <div class="form-text" id="emailFeedback"></div>
            </div>
            
            <!-- 전화번호 -->
            <div class="mb-3">
                <label for="phone" class="form-label">전화번호 <span class="text-danger">*</span></label>
                <div class="input-group">
                    <input type="tel" class="form-control" id="phone" name="phone" placeholder="01012345678" required>
                    <button type="button" class="btn btn-verify" onclick="sendSMS()">인증발송</button>
                </div>
                <div class="form-text" id="phoneFeedback"></div>
            </div>
            
            <!-- SMS 인증 -->
            <div class="mb-3" id="smsVerifySection" style="display:none;">
                <label for="smsCode" class="form-label">SMS 인증번호</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="smsCode" placeholder="6자리 숫자">
                    <button type="button" class="btn btn-verify" onclick="verifySMS()">인증확인</button>
                </div>
                <div class="form-text" id="smsFeedback"></div>
            </div>
            
            <!-- 비밀번호 -->
            <div class="mb-3">
                <label for="password" class="form-label">비밀번호 <span class="text-danger">*</span></label>
                <input type="password" class="form-control" id="password" name="password" required>
                <div class="form-text">8자 이상, 영문+숫자+특수문자 조합</div>
            </div>
            
            <!-- 비밀번호 확인 -->
            <div class="mb-3">
                <label for="passwordConfirm" class="form-label">비밀번호 확인 <span class="text-danger">*</span></label>
                <input type="password" class="form-control" id="passwordConfirm" required>
                <div class="form-text" id="passwordFeedback"></div>
            </div>
            
            <!-- 생년월일 -->
            <div class="mb-3">
                <label for="birthDate" class="form-label">생년월일</label>
                <input type="date" class="form-control" id="birthDate" name="birthDate">
            </div>
            
            <!-- 성별 -->
            <div class="mb-3">
                <label class="form-label">성별</label>
                <div class="d-flex gap-3">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="M" id="genderM">
                        <label class="form-check-label" for="genderM">남성</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="F" id="genderF">
                        <label class="form-check-label" for="genderF">여성</label>
                    </div>
                </div>
            </div>
            
            <!-- 약관 동의 -->
            <div class="mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                    <label class="form-check-label" for="agreeTerms">
                        <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">이용약관</a> 및 
                        <a href="#" data-bs-toggle="modal" data-bs-target="#privacyModal">개인정보처리방침</a>에 동의합니다.
                    </label>
                </div>
            </div>
            
            <!-- 디버깅 정보 -->
            <div class="mb-3 alert alert-warning">
                <strong>현재 상황:</strong>
                <div>1. 생년월일 필드를 완전 제거했습니다</div>
                <div>2. "테스트용: 검증 건너뛰기" 버튼을 클릭하세요</div>
                <div>3. 필수 정보만 입력해서 테스트하세요</div>
                <div>4. 여전히 오류가 발생하면 데이터베이스 문제일 수 있습니다</div>
            </div>
            <div class="mb-3">
                <button type="button" class="btn btn-warning w-100 mb-2" onclick="skipValidation()">
                    테스트용: 검증 건너뛰기
                </button>
            </div>
            
            <button type="submit" class="btn btn-primary w-100 mb-3" id="submitBtn" disabled>회원가입</button>
            
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/user/login" class="text-decoration-none">이미 계정이 있으신가요? 로그인</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let userIdChecked = false;
        let emailChecked = false;
        let phoneVerified = false;
        
        // 테스트용: 모든 검증을 건너뛰고 버튼 활성화
        function skipValidation() {
            userIdChecked = true;
            emailChecked = true;
            phoneVerified = true;
            
            // 피드백 메시지 표시
            document.getElementById('userIdFeedback').className = 'form-text valid-feedback';
            document.getElementById('userIdFeedback').textContent = '테스트용: 아이디 확인됨';
            
            document.getElementById('emailFeedback').className = 'form-text valid-feedback';
            document.getElementById('emailFeedback').textContent = '테스트용: 이메일 확인됨';
            
            document.getElementById('phoneFeedback').className = 'form-text valid-feedback';
            document.getElementById('phoneFeedback').textContent = '테스트용: 전화번호 확인됨';
            
            updateSubmitButton();
        }
        
        // 아이디 중복 확인
        function checkUserId() {
            const userId = document.getElementById('userId').value;
            if(!userId) {
                alert('아이디를 입력해주세요.');
                return;
            }
            
            fetch('${pageContext.request.contextPath}/user/checkUserId?userId=' + encodeURIComponent(userId))
                .then(response => response.json())
                .then(data => {
                    const feedback = document.getElementById('userIdFeedback');
                    if(data.available) {
                        feedback.className = 'form-text valid-feedback';
                        feedback.textContent = data.message;
                        userIdChecked = true;
                    } else {
                        feedback.className = 'form-text invalid-feedback';
                        feedback.textContent = data.message;
                        userIdChecked = false;
                    }
                    updateSubmitButton();
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('서버 연결 오류가 발생했습니다.');
                });
        }
        
        // 이메일 중복 확인
        function checkEmail() {
            const email = document.getElementById('email').value;
            if(!email) {
                alert('이메일을 입력해주세요.');
                return;
            }
            
            fetch('${pageContext.request.contextPath}/user/checkEmail?email=' + encodeURIComponent(email))
                .then(response => response.json())
                .then(data => {
                    const feedback = document.getElementById('emailFeedback');
                    if(data.available) {
                        feedback.className = 'form-text valid-feedback';
                        feedback.textContent = data.message;
                        emailChecked = true;
                    } else {
                        feedback.className = 'form-text invalid-feedback';
                        feedback.textContent = data.message;
                        emailChecked = false;
=======
    <jsp:include page="../common/header.jsp" />
    
    <!-- 통일된 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/">홈</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">회원가입</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">회원가입</h2>
                    <p class="lead">피트니스 라이프의 새로운 시작</p>
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
                <div class="join-container">
                    <div class="brand-header">
                        <div class="brand-logo">
                            <span class="brand-dot"></span>
                            HELLKING
                            <span class="brand-dot"></span>
                        </div>
                        <p class="subtitle">안전하고 간편한 회원가입</p>
                    </div>
                    
                    <!-- 에러/성공 메시지 -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${message}
                        </div>
                    </c:if>
                    
                    <!-- 소셜 가입 섹션 -->
                    <div class="social-join-section">
                        <div class="social-buttons">
                            <a href="#" class="btn-social btn-naver" data-provider="naver">
                                <i class="fas fa-n" style="background: #03C75A; color: white; width: 16px; height: 16px; border-radius: 2px; display: flex; align-items: center; justify-content: center; font-size: 10px; font-weight: 700;"></i>
                                네이버
                            </a>
                            <a href="#" class="btn-social btn-kakao" data-provider="kakao">
                                <i class="fas fa-comment" style="color: #3C1E1E;"></i>
                                카카오
                            </a>
                            <a href="#" class="btn-social btn-google" data-provider="google">
                                <i class="fab fa-google" style="color: #4285F4;"></i>
                                구글
                            </a>
                        </div>
                        <div class="social-status" id="socialStatus">
                            간편하게 소셜 계정으로 가입하세요
                        </div>
                    </div>
                    
                    <div class="divider">
                        <span>또는</span>
                    </div>
                    
                    <!-- 일반 가입 폼 -->
                    <form action="${pageContext.request.contextPath}/user/joinPost" method="post" enctype="multipart/form-data">
                        
                        <!-- 프로필 이미지 업로드 섹션 -->
                        <div class="profile-upload-section">
                            <img id="profilePreview" src="${pageContext.request.contextPath}/resources/images/profiles/avatar1.png" 
                                 alt="프로필 미리보기" class="profile-preview" onclick="document.getElementById('profileImageFile').click()">
                            <div>
                                <button type="button" class="upload-btn" onclick="document.getElementById('profileImageFile').click()">
                                    <i class="fas fa-camera me-1"></i>사진 선택
                                </button>
                                <input type="file" id="profileImageFile" name="profileImageFile" accept="image/*" style="display: none;">
                            </div>
                            <div class="file-info" id="fileInfo">
                                JPG, PNG, GIF 파일 (최대 5MB)
                            </div>
                        </div>
                        
                        <!-- 아이디 -->
                        <div class="mb-3">
                            <label class="form-label required">아이디</label>
                            <div class="d-flex">
                                <input type="text" id="userId" name="userId" class="form-control" required>
                                <button type="button" class="verify-btn" onclick="checkUserId()">중복확인</button>
                            </div>
                            <div id="userIdFeedback" class="feedback"></div>
                        </div>
                        
                        <!-- 이름 -->
                        <div class="mb-3">
                            <label class="form-label required">이름</label>
                            <input type="text" id="username" name="username" class="form-control" required>
                        </div>
                        
                        <!-- 연락처 안내 -->
                        <div class="contact-notice">
                            <i class="fas fa-info-circle"></i>
                            <strong>연락처 정보:</strong> 이메일 또는 휴대폰 번호 중 최소 하나는 입력해주세요. (본인 확인 및 비밀번호 찾기용)
                        </div>
                        
                        <!-- 이메일 -->
                        <div class="mb-3">
                            <label class="form-label optional">이메일</label>
                            <div class="d-flex">
                                <input type="email" id="email" name="email" class="form-control">
                                <button type="button" class="verify-btn" onclick="checkEmailAndSend()" id="emailVerifyBtn" disabled>인증발송</button>
                            </div>
                            <div id="emailFeedback" class="feedback"></div>
                            
                            <!-- 이메일 인증 -->
                            <div id="emailVerifySection" class="verify-section" style="display:none;">
                                <label class="form-label">이메일 인증번호</label>
                                <div class="d-flex">
                                    <input type="text" id="emailCode" class="form-control" placeholder="6자리 숫자">
                                    <button type="button" class="verify-btn" onclick="verifyEmail()">인증확인</button>
                                </div>
                                <div id="emailCodeFeedback" class="feedback"></div>
                            </div>
                        </div>
                        
                        <!-- 휴대폰 번호 -->
                        <div class="mb-3">
                            <label class="form-label optional">휴대폰 번호</label>
                            <div class="d-flex">
                                <input type="tel" id="phone" name="phone" class="form-control" placeholder="01012345678">
                                <button type="button" class="verify-btn" onclick="sendSMS()" id="smsVerifyBtn" disabled>SMS발송</button>
                            </div>
                            <div id="phoneFeedback" class="feedback"></div>
                            
                            <!-- SMS 인증 -->
                            <div id="smsVerifySection" class="verify-section" style="display:none;">
                                <label class="form-label">SMS 인증번호</label>
                                <div class="d-flex">
                                    <input type="text" id="smsCode" class="form-control" placeholder="6자리 숫자">
                                    <button type="button" class="verify-btn" onclick="verifySMS()">인증확인</button>
                                </div>
                                <div id="smsFeedback" class="feedback"></div>
                            </div>
                        </div>
                        
                        <!-- 비밀번호 -->
                        <div class="mb-3">
                            <label class="form-label required">비밀번호</label>
                            <input type="password" id="password" name="password" class="form-control" required>
                            
                            <!-- 비밀번호 강도 표시기 -->
                            <div id="passwordStrength" class="password-strength" style="display:none;">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span id="strengthText">비밀번호 강도:</span>
                                    <span id="strengthLevel"></span>
                                </div>
                                <div class="password-strength-bar">
                                    <div id="strengthFill" class="strength-fill"></div>
                                </div>
                            </div>
                            
                            <!-- 비밀번호 요구사항 -->
                            <div id="passwordRequirements" class="password-requirements">
                                <div class="requirement" id="req-length">
                                    <i class="fas fa-times"></i>
                                    8자리 이상
                                </div>
                                <div class="requirement" id="req-uppercase">
                                    <i class="fas fa-times"></i>
                                    영문 대문자 포함
                                </div>
                                <div class="requirement" id="req-lowercase">
                                    <i class="fas fa-times"></i>
                                    영문 소문자 포함
                                </div>
                                <div class="requirement" id="req-number">
                                    <i class="fas fa-times"></i>
                                    숫자 포함
                                </div>
                                <div class="requirement" id="req-special">
                                    <i class="fas fa-times"></i>
                                    특수문자 포함 (!@#$%^&*)
                                </div>
                            </div>
                        </div>
                        
                        <!-- 비밀번호 확인 -->
                        <div class="mb-3">
                            <label class="form-label required">비밀번호 확인</label>
                            <input type="password" id="passwordConfirm" class="form-control" required>
                            <div id="passwordFeedback" class="feedback"></div>
                        </div>
                        
                        <!-- 생년월일 -->
                        <div class="mb-3">
                            <label class="form-label optional">생년월일</label>
                            <input type="date" id="birthDate" name="birthDate" class="form-control">
                        </div>
                        
                        <!-- 성별 -->
                        <div class="mb-3">
                            <label class="form-label optional">성별</label><br>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" value="M" id="genderM">
                                <label class="form-check-label" for="genderM">남성</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="gender" value="F" id="genderF">
                                <label class="form-check-label" for="genderF">여성</label>
                            </div>
                        </div>
                        
                        <!-- 약관 동의 -->
                        <div class="mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                                <label class="form-check-label" for="agreeTerms">
                                    이용약관 및 개인정보처리방침에 동의합니다.
                                </label>
                            </div>
                        </div>
                        
                        <!-- 테스트용 버튼 -->
                        <c:if test="${param.debug == 'true'}">
                            <div class="mb-3">
                                <button type="button" class="btn btn-outline-secondary" onclick="skipValidation()">테스트용: 검증 건너뛰기</button>
                            </div>
                        </c:if>
                        
                        <div class="d-grid">
                            <button type="submit" id="submitBtn" class="btn btn-primary" disabled>회원가입</button>
                        </div>
                        
                    </form>
                    
                    <div class="additional-links">
                        <a href="${pageContext.request.contextPath}/user/login">
                            <i class="fas fa-sign-in-alt me-1"></i>로그인
                        </a>
                        <a href="${pageContext.request.contextPath}/user/findId">
                            <i class="fas fa-search me-1"></i>아이디 찾기
                        </a>
                        <a href="${pageContext.request.contextPath}/user/findPassword">
                            <i class="fas fa-key me-1"></i>비밀번호 찾기
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 신규 소셜 계정 생성 확인 모달 -->
    <div class="modal fade" id="socialCreateModal" tabindex="-1" aria-labelledby="socialCreateModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="socialCreateModalLabel">
                        <i class="fas fa-user-plus text-success"></i>
                        새 계정 생성
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="socialCreateInfo" class="social-info-section">
                        <div class="social-provider-info">
                            <div id="createProviderIcon" class="provider-icon"></div>
                            <div class="social-user-info">
                                <h6 id="createSocialName">소셜 사용자</h6>
                                <p id="createSocialEmail">이메일 정보</p>
                            </div>
                        </div>
                    </div>
                    
                    <p class="text-muted mb-4">
                        <i class="fas fa-info-circle me-2"></i>
                        새로운 헬킹 계정을 생성하시겠습니까?
                    </p>
                    
                    <div class="d-flex gap-3 justify-content-center">
                        <button type="button" class="btn btn-primary" id="confirmCreateBtn">
                            <i class="fas fa-check me-2"></i>계정 생성
                        </button>
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            <i class="fas fa-times me-2"></i>취소
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 컨텍스트 패스를 JavaScript 변수로 설정
        const contextPath = '${pageContext.request.contextPath}';
        
        // 전역 변수
        let userIdChecked = false;
        let emailChecked = false;
        let emailVerified = false;
        let phoneChecked = false;
        let phoneVerified = false;
        let hasContactInfo = false;
        let pendingSocialData = null;
        let socialCreateModal;

        console.log('=== 회원가입 페이지 초기화 시작 ===');
        console.log('Context Path:', contextPath);

        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            console.log('DOM 로드 완료');
            
            // 모달 초기화
            const modalElement = document.getElementById('socialCreateModal');
            if (modalElement) {
                socialCreateModal = new bootstrap.Modal(modalElement);
                console.log('소셜 생성 모달 초기화 완료');
            }
            
            // 초기화 함수들 실행
            try {
                setupSocialButtons();
                setupFormValidation();
                setupProfileImageUpload();
                setupContactValidation();
                setupPasswordSecurity();
                
                console.log('모든 초기화 완료');
            } catch (error) {
                console.error('초기화 중 오류:', error);
            }
        });

        // 소셜 버튼 설정
        function setupSocialButtons() {
            console.log('소셜 버튼 설정 시작');
            
            try {
                const socialButtons = document.querySelectorAll('.btn-social');
                console.log('소셜 버튼 개수:', socialButtons.length);
                
                socialButtons.forEach((button, index) => {
                    const provider = button.getAttribute('data-provider');
                    console.log(`소셜 버튼 ${index}: ${provider}`);
                    
                    if (!provider) {
                        console.error('data-provider 속성이 없는 버튼:', button);
                        return;
                    }
                    
                    button.addEventListener('click', function(e) {
                        e.preventDefault();
                        console.log('소셜 버튼 클릭:', provider);
                        startSocialJoin(provider);
                    });
                });
                
                console.log('소셜 버튼 설정 완료');
            } catch (error) {
                console.error('소셜 버튼 설정 중 오류:', error);
            }
        }

        // 소셜 가입 시작
        function startSocialJoin(provider) {
            console.log('소셜 가입 시작:', provider);
            
            try {
                const statusElement = document.getElementById('socialStatus');
                if (statusElement) {
                    statusElement.innerHTML = '<span class="loading-spinner"></span> ' + provider + ' 인증 중...';
                    statusElement.classList.add('loading');
                }
                
                const joinUrl = contextPath + '/oauth/' + provider + '?join=true';
                console.log('이동할 URL:', joinUrl);
                
                window.location.href = joinUrl;
                
            } catch (error) {
                console.error('소셜 가입 시작 중 오류:', error);
                alert('소셜 가입 중 오류가 발생했습니다.');
            }
        }

        // 프로필 이미지 업로드 설정
        function setupProfileImageUpload() {
            const fileInput = document.getElementById('profileImageFile');
            const preview = document.getElementById('profilePreview');
            const fileInfo = document.getElementById('fileInfo');
            
            if (fileInput) {
                fileInput.addEventListener('change', function(e) {
                    const file = e.target.files[0];
                    if (file) {
                        // 파일 크기 검증 (5MB)
                        if (file.size > 5242880) {
                            alert('파일 크기는 5MB를 초과할 수 없습니다.');
                            fileInput.value = '';
                            return;
                        }
                        
                        // 파일 형식 검증
                        const allowedTypes = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
                        const extension = file.name.split('.').pop().toLowerCase();
                        if (!allowedTypes.includes(extension)) {
                            alert('지원하지 않는 파일 형식입니다. (JPG, PNG, GIF, WEBP만 가능)');
                            fileInput.value = '';
                            return;
                        }
                        
                        // 미리보기 표시
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            preview.src = e.target.result;
                        };
                        reader.readAsDataURL(file);
                        
                        // 파일 정보 표시
                        const sizeInKB = Math.round(file.size / 1024);
                        fileInfo.textContent = `선택된 파일: ${file.name} (${sizeInKB}KB)`;
                        fileInfo.style.color = '#10B981';
                    }
                });
            }
        }

        // 연락처 선택적 필수 검증 설정
        function setupContactValidation() {
            const emailInput = document.getElementById('email');
            const phoneInput = document.getElementById('phone');
            const emailVerifyBtn = document.getElementById('emailVerifyBtn');
            const smsVerifyBtn = document.getElementById('smsVerifyBtn');
            
            function updateContactValidation() {
                const hasEmail = emailInput.value.trim().length > 0;
                const hasPhone = phoneInput.value.trim().length > 0;
                hasContactInfo = hasEmail || hasPhone;
                
                emailVerifyBtn.disabled = !hasEmail;
                smsVerifyBtn.disabled = !hasPhone;
                
                updateSubmitButton();
            }
            
            if (emailInput) {
                emailInput.addEventListener('input', updateContactValidation);
            }
            
            if (phoneInput) {
                phoneInput.addEventListener('input', updateContactValidation);
            }
        }

        // 비밀번호 보안 설정
        function setupPasswordSecurity() {
            const passwordInput = document.getElementById('password');
            const passwordConfirmInput = document.getElementById('passwordConfirm');
            
            if (passwordInput) {
                passwordInput.addEventListener('input', function() {
                    updatePasswordStrength(this.value);
                    checkPasswordMatch();
                });
            }
            
            if (passwordConfirmInput) {
                passwordConfirmInput.addEventListener('input', checkPasswordMatch);
            }
        }

        // 비밀번호 강도 검사 및 업데이트
        function updatePasswordStrength(password) {
            const strengthSection = document.getElementById('passwordStrength');
            const strengthFill = document.getElementById('strengthFill');
            const strengthLevel = document.getElementById('strengthLevel');
            
            if (!password) {
                strengthSection.style.display = 'none';
                return { isValid: false };
            }
            
            strengthSection.style.display = 'block';
            
            // 요구사항 체크
            const checks = {
                length: password.length >= 8,
                uppercase: /[A-Z]/.test(password),
                lowercase: /[a-z]/.test(password),
                number: /[0-9]/.test(password),
                special: /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)
            };
            
            // 요구사항 UI 업데이트
            updateRequirements(checks);
            
            // 강도 계산
            const metRequirements = Object.values(checks).filter(Boolean).length;
            let strength = 'weak';
            let level = '약함';
            
            if (metRequirements >= 4) {
                strength = 'strong';
                level = '강함';
            } else if (metRequirements >= 3) {
                strength = 'medium';
                level = '보통';
            }
            
            // UI 업데이트
            strengthFill.className = `strength-fill ${strength}`;
            strengthLevel.textContent = level;
            strengthSection.className = `password-strength ${strength}`;
            
            return { 
                isValid: metRequirements >= 5,
                strength: strength,
                metRequirements: metRequirements
            };
        }

        // 요구사항 업데이트
        function updateRequirements(checks) {
            const reqElements = {
                length: document.getElementById('req-length'),
                uppercase: document.getElementById('req-uppercase'),
                lowercase: document.getElementById('req-lowercase'),
                number: document.getElementById('req-number'),
                special: document.getElementById('req-special')
            };
            
            Object.keys(checks).forEach(key => {
                const element = reqElements[key];
                if (element) {
                    const icon = element.querySelector('i');
                    if (checks[key]) {
                        element.classList.add('met');
                        icon.className = 'fas fa-check';
                    } else {
                        element.classList.remove('met');
                        icon.className = 'fas fa-times';
                    }
                }
            });
        }

        // 비밀번호 일치 확인
        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const passwordConfirm = document.getElementById('passwordConfirm').value;
            const feedback = document.getElementById('passwordFeedback');
            
            if (!passwordConfirm) {
                feedback.textContent = '';
                feedback.className = 'feedback';
                updateSubmitButton();
                return;
            }
            
            const strengthInfo = updatePasswordStrength(password);
            
            if (password === passwordConfirm) {
                if (strengthInfo.isValid || strengthInfo.metRequirements >= 4) {
                    feedback.textContent = '비밀번호가 일치합니다.';
                    feedback.className = 'feedback valid';
                } else {
                    feedback.textContent = '비밀번호가 일치하지만 보안 요구사항을 충족하지 않습니다.';
                    feedback.className = 'feedback invalid';
                }
            } else {
                feedback.textContent = '비밀번호가 일치하지 않습니다.';
                feedback.className = 'feedback invalid';
            }
            
            updateSubmitButton();
        }

        // 폼 검증 설정
        function setupFormValidation() {
            const agreeTermsInput = document.getElementById('agreeTerms');
            const userIdInput = document.getElementById('userId');
            const usernameInput = document.getElementById('username');
            
            if (agreeTermsInput) agreeTermsInput.addEventListener('change', updateSubmitButton);
            
            if (userIdInput) {
                userIdInput.addEventListener('input', function() {
                    if (userIdChecked) {
                        userIdChecked = false;
                        const feedback = document.getElementById('userIdFeedback');
                        if (feedback) feedback.textContent = '';
                    }
                    updateSubmitButton();
                });
            }
            
            if (usernameInput) {
                usernameInput.addEventListener('input', updateSubmitButton);
            }
        }
        
        // 제출 버튼 상태 업데이트
        function updateSubmitButton() {
            const userId = document.getElementById('userId').value.trim();
            const username = document.getElementById('username').value.trim();
            const email = document.getElementById('email').value.trim();
            const phone = document.getElementById('phone').value.trim();
            const password = document.getElementById('password').value;
            const confirm = document.getElementById('passwordConfirm').value;
            const terms = document.getElementById('agreeTerms').checked;
            
            const hasContactInfo = email.length > 0 || phone.length > 0;
            const passwordsMatch = password && confirm && (password === confirm);
            
            // 비밀번호 강도 체크 (최소 4개 조건 충족)
            const checks = {
                length: password.length >= 8,
                uppercase: /[A-Z]/.test(password),
                lowercase: /[a-z]/.test(password),
                number: /[0-9]/.test(password),
                special: /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)
            };
            const metRequirements = Object.values(checks).filter(Boolean).length;
            const passwordValid = metRequirements >= 4;
            
            const allRequiredFieldsFilled = userId && 
                                           username && 
                                           password && 
                                           confirm && 
                                           passwordsMatch &&
                                           passwordValid &&
                                           hasContactInfo && 
                                           terms;
            
            document.getElementById('submitBtn').disabled = !allRequiredFieldsFilled;
        }
        
        // API 호출 함수들
        function checkUserId() {
            const userId = document.getElementById('userId').value.trim();
            
            if (!userId) {
                alert('아이디를 입력하세요');
                return;
            }
            
            fetch(contextPath + '/user/checkUserId?userId=' + encodeURIComponent(userId))
                .then(response => response.json())
                .then(data => {
                    const feedback = document.getElementById('userIdFeedback');
                    if (feedback) {
                        if (data.available) {
                            feedback.className = 'feedback valid';
                            feedback.textContent = data.message;
                            userIdChecked = true;
                        } else {
                            feedback.className = 'feedback invalid';
                            feedback.textContent = data.message;
                            userIdChecked = false;
                        }
                        updateSubmitButton();
                    }
                })
                .catch(error => {
                    console.error('오류:', error);
                    alert('오류 발생: ' + error.message);
                });
        }

        function checkEmailAndSend() {
            const email = document.getElementById('email').value.trim();
            
            if (!email) {
                alert('이메일을 입력하세요');
                return;
            }
            
            fetch(contextPath + '/user/checkEmail?email=' + encodeURIComponent(email))
                .then(response => response.json())
                .then(data => {
                    if (data.available) {
                        const feedback = document.getElementById('emailFeedback');
                        feedback.className = 'feedback valid';
                        feedback.textContent = '중복확인 완료. 인증번호 발송 중...';
                        emailChecked = true;
                        
                        return fetch(contextPath + '/user/sendEmail', {
                            method: 'POST',
                            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                            body: 'email=' + encodeURIComponent(email)
                        });
                    } else {
                        const feedback = document.getElementById('emailFeedback');
                        feedback.className = 'feedback invalid';
                        feedback.textContent = data.message;
                        emailChecked = false;
                        throw new Error('이메일 중복');
                    }
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        document.getElementById('emailVerifySection').style.display = 'block';
                        const feedback = document.getElementById('emailFeedback');
                        feedback.className = 'feedback valid';
                        feedback.textContent = '인증번호가 발송되었습니다.';
                    } else {
                        const feedback = document.getElementById('emailFeedback');
                        feedback.className = 'feedback invalid';
                        feedback.textContent = '발송 실패: ' + data.message;
>>>>>>> b65c320 (Initial commit)
                    }
                    updateSubmitButton();
                })
                .catch(error => {
<<<<<<< HEAD
                    console.error('Error:', error);
                    alert('서버 연결 오류가 발생했습니다.');
                });
        }
        
        // SMS 발송
        function sendSMS() {
            const phone = document.getElementById('phone').value;
            if(!phone) {
                alert('전화번호를 입력해주세요.');
                return;
            }
            
            fetch('${pageContext.request.contextPath}/user/sendSMS', {
=======
                    if (error.message !== '이메일 중복') {
                        alert('오류 발생');
                    }
                });
        }

        function verifyEmail() {
            const email = document.getElementById('email').value.trim();
            const code = document.getElementById('emailCode').value.trim();
            
            if (!code) {
                alert('인증번호를 입력하세요');
                return;
            }
            
            fetch(contextPath + '/user/verifyEmail', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'email=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(code)
            })
                .then(response => response.json())
                .then(data => {
                    const feedback = document.getElementById('emailCodeFeedback');
                    if (data.success) {
                        feedback.className = 'feedback valid';
                        feedback.textContent = data.message;
                        emailVerified = true;
                        document.getElementById('emailVerifySection').style.display = 'none';
                    } else {
                        feedback.className = 'feedback invalid';
                        feedback.textContent = data.message;
                        emailVerified = false;
                    }
                    updateSubmitButton();
                })
                .catch(error => {
                    alert('인증 오류');
                });
        }

        function sendSMS() {
            const phone = document.getElementById('phone').value.trim();
            if (!phone) {
                alert('휴대폰 번호를 입력하세요');
                return;
            }
            
            fetch(contextPath + '/user/sendSMS', {
>>>>>>> b65c320 (Initial commit)
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'phone=' + encodeURIComponent(phone)
            })
                .then(response => response.json())
                .then(data => {
<<<<<<< HEAD
                    if(data.success) {
                        document.getElementById('smsVerifySection').style.display = 'block';
                        document.getElementById('phoneFeedback').className = 'form-text valid-feedback';
                        document.getElementById('phoneFeedback').textContent = data.message;
                    } else {
                        document.getElementById('phoneFeedback').className = 'form-text invalid-feedback';
                        document.getElementById('phoneFeedback').textContent = data.message;
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('SMS 발송 중 오류가 발생했습니다.');
                });
        }
        
        // SMS 인증 확인
        function verifySMS() {
            console.log('verifySMS 함수 호출됨');
            const phone = document.getElementById('phone').value;
            const code = document.getElementById('smsCode').value;
            console.log('인증번호:', code);
            
            if(!code) {
                alert('인증번호를 입력해주세요.');
                return;
            }
            
            // 테스트용: 실제 인증 대신 임시 처리
            const feedback = document.getElementById('smsFeedback');
            if(code === '123456') {
                feedback.className = 'form-text valid-feedback';
                feedback.textContent = '전화번호 인증이 완료되었습니다.';
                phoneVerified = true;
                console.log('전화번호 인증 통과');
            } else {
                feedback.className = 'form-text invalid-feedback';
                feedback.textContent = '인증번호가 일치하지 않습니다. (테스트: 123456)';
                phoneVerified = false;
            }
            updateSubmitButton();
            
            /* 실제 인증 확인 코드 (아래 주석 해제하고 위의 테스트 코드 주석 처리)
            const contextPath = '<%=request.getContextPath()%>';
=======
                    if (data.success) {
                        document.getElementById('smsVerifySection').style.display = 'block';
                        document.getElementById('phoneFeedback').className = 'feedback valid';
                        document.getElementById('phoneFeedback').textContent = data.message;
                        phoneChecked = true;
                    } else {
                        document.getElementById('phoneFeedback').className = 'feedback invalid';
                        document.getElementById('phoneFeedback').textContent = data.message;
                        phoneChecked = false;
                    }
                    updateSubmitButton();
                })
                .catch(error => {
                    alert('SMS 오류');
                });
        }

        function verifySMS() {
            const phone = document.getElementById('phone').value.trim();
            const code = document.getElementById('smsCode').value.trim();
            
            if (!code) {
                alert('인증번호를 입력하세요');
                return;
            }
            
>>>>>>> b65c320 (Initial commit)
            fetch(contextPath + '/user/verifySMS', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'phone=' + encodeURIComponent(phone) + '&code=' + encodeURIComponent(code)
            })
                .then(response => response.json())
                .then(data => {
                    const feedback = document.getElementById('smsFeedback');
<<<<<<< HEAD
                    if(data.success) {
                        feedback.className = 'form-text valid-feedback';
                        feedback.textContent = data.message;
                        phoneVerified = true;
                    } else {
                        feedback.className = 'form-text invalid-feedback';
=======
                    if (data.success) {
                        feedback.className = 'feedback valid';
                        feedback.textContent = data.message;
                        phoneVerified = true;
                        document.getElementById('smsVerifySection').style.display = 'none';
                    } else {
                        feedback.className = 'feedback invalid';
>>>>>>> b65c320 (Initial commit)
                        feedback.textContent = data.message;
                        phoneVerified = false;
                    }
                    updateSubmitButton();
                })
                .catch(error => {
<<<<<<< HEAD
                    console.error('Error:', error);
                    alert('인증 확인 중 오류가 발생했습니다.');
                });
            */
        }
        
        // 제출 버튼 활성화 체크
        function updateSubmitButton() {
            const userId = document.getElementById('userId').value;
            const username = document.getElementById('username').value;
            const email = document.getElementById('email').value;
            const phone = document.getElementById('phone').value;
            const password = document.getElementById('password').value;
            const confirm = document.getElementById('passwordConfirm').value;
            const terms = document.getElementById('agreeTerms').checked;
            
            // 모든 필수 조건 체크
            const allValid = userIdChecked && 
                           emailChecked && 
                           phoneVerified && 
                           userId && 
                           username && 
                           email && 
                           phone && 
                           password && 
                           confirm && 
                           (password === confirm) && 
                           terms;
            
            document.getElementById('submitBtn').disabled = !allValid;
            
            // 디버깅용 콘솔 출력
            console.log('검증 상태:', {
                userIdChecked,
                emailChecked,
                phoneVerified,
                userId: !!userId,
                username: !!username,
                email: !!email,
                phone: !!phone,
                password: !!password,
                confirm: !!confirm,
                passwordMatch: password === confirm,
                terms,
                allValid
            });
        }
        
        // 비밀번호 확인
        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const confirm = document.getElementById('passwordConfirm').value;
            const feedback = document.getElementById('passwordFeedback');
            
            if(confirm === '') {
                feedback.textContent = '';
                feedback.className = 'form-text';
                updateSubmitButton();
                return;
            }
            
            if(password === confirm) {
                feedback.className = 'form-text valid-feedback';
                feedback.textContent = '비밀번호가 일치합니다.';
            } else {
                feedback.className = 'form-text invalid-feedback';
                feedback.textContent = '비밀번호가 일치하지 않습니다.';
            }
            updateSubmitButton();
        }
        
        // 이벤트 리스너 등록
        document.getElementById('password').addEventListener('input', checkPasswordMatch);
        document.getElementById('passwordConfirm').addEventListener('input', checkPasswordMatch);
        document.getElementById('agreeTerms').addEventListener('change', updateSubmitButton);
        
        // 필수 입력 필드에 이벤트 리스너 추가
        document.getElementById('userId').addEventListener('input', function() {
            // 아이디가 변경되면 중복확인 상태 초기화
            if(userIdChecked) {
                userIdChecked = false;
                document.getElementById('userIdFeedback').textContent = '아이디 중복확인이 필요합니다.';
                document.getElementById('userIdFeedback').className = 'form-text';
                updateSubmitButton();
            }
        });
        
        document.getElementById('email').addEventListener('input', function() {
            // 이메일이 변경되면 중복확인 상태 초기화
            if(emailChecked) {
                emailChecked = false;
                document.getElementById('emailFeedback').textContent = '이메일 중복확인이 필요합니다.';
                document.getElementById('emailFeedback').className = 'form-text';
                updateSubmitButton();
            }
        });
        
        document.getElementById('username').addEventListener('input', updateSubmitButton);
        document.getElementById('phone').addEventListener('input', updateSubmitButton);
=======
                    alert('SMS 인증 오류');
                });
        }

        function skipValidation() {
            // 테스트용 데이터 자동 입력
            document.getElementById('userId').value = 'test' + Date.now();
            document.getElementById('username').value = '테스트사용자';
            document.getElementById('email').value = 'test' + Date.now() + '@test.com';
            document.getElementById('password').value = 'Test123!@#';
            document.getElementById('passwordConfirm').value = 'Test123!@#';
            document.getElementById('agreeTerms').checked = true;
            
            // 모든 검증 상태를 true로 설정
            userIdChecked = true;
            emailVerified = true;
            hasContactInfo = true;
            
            // 피드백 업데이트
            document.getElementById('userIdFeedback').className = 'feedback valid';
            document.getElementById('userIdFeedback').textContent = '테스트: 아이디 확인';
            
            document.getElementById('emailFeedback').className = 'feedback valid';
            document.getElementById('emailFeedback').textContent = '테스트: 이메일 확인';
            
            // 비밀번호 강도 및 일치 확인
            updatePasswordStrength('Test123!@#');
            checkPasswordMatch();
            
            // 폼 유효성 재검사
            updateSubmitButton();
            
            alert('테스트용 데이터가 입력되었습니다.');
        }

        console.log('모든 스크립트 로드 완료');
>>>>>>> b65c320 (Initial commit)
    </script>
</body>
</html>