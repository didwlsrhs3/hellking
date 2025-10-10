<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<<<<<<< HEAD
    <title>로그인 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
        }
        body { background: var(--bg-cream); }
        .login-container { 
            max-width: 400px; 
            margin: 100px auto; 
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
        .form-control {
            border-radius: 12px;
            padding: 12px 16px;
            border: 2px solid #E7E0D6;
        }
        .form-control:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 0.2rem rgba(255,106,0,0.1);
=======
    <title>로그인 | 헬킹 피트니스</title>
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
        }
        
        .login-container { 
            max-width: 420px; 
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
        
        .btn-primary {
            background: var(--primary-color);
            border: none;
            font-weight: 700;
            padding: 14px;
            border-radius: 12px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: #0056b3;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
        }
        
        .form-control {
            border-radius: 12px;
            padding: 14px 16px;
            border: 2px solid #E7E0D6;
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
            background: #E7E0D6;
        }
        
        .divider span {
            padding: 0 20px;
            color: var(--muted-color);
            font-size: 14px;
        }
        
        .social-login-section {
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
            border: 2px solid #E7E0D6;
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
        
        .account-option {
            border: 2px solid #E7E0D6;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }
        
        .account-option:hover {
            border-color: var(--primary-color);
            background: rgba(0, 123, 255, 0.05);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.15);
        }
        
        .account-option.recommended {
            border-color: var(--success);
            background: rgba(16, 185, 129, 0.05);
        }
        
        .account-option.recommended::before {
            content: '추천';
            position: absolute;
            top: -8px;
            right: 15px;
            background: var(--success);
            color: white;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 700;
        }
        
        .option-title {
            font-weight: 700;
            color: #0F172A;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .option-desc {
            color: var(--muted-color);
            font-size: 14px;
            margin: 0;
        }
        
        .account-info {
            background: #F8F9FA;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
        
        .account-info h6 {
            color: #0F172A;
            margin-bottom: 5px;
            font-weight: 600;
        }
        
        .account-info p {
            color: var(--muted-color);
            margin: 0;
            font-size: 14px;
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
        
        .alert {
            border-radius: 12px;
            border: none;
            padding: 15px 20px;
        }
        
        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }
        
        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }
        
        /* 신규 계정 생성 모달 스타일 */
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
            .login-container {
                margin: 20px auto;
                padding: 30px 20px;
            }
>>>>>>> b65c320 (Initial commit)
        }
    </style>
</head>
<body>
<<<<<<< HEAD
    <div class="login-container">
        <div class="brand-logo">🏋️ HELLKING</div>
        
        <c:if test="${not empty message}">
            <div class="alert alert-danger" role="alert">${message}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/user/login" method="post">
            <div class="mb-3">
                <label for="userId" class="form-label">아이디</label>
                <input type="text" class="form-control" id="userId" name="userId" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary w-100 mb-3">로그인</button>
            
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/user/join" class="text-decoration-none me-3">회원가입</a>
                <a href="${pageContext.request.contextPath}/user/findId" class="text-decoration-none me-3">아이디 찾기</a>
                <a href="${pageContext.request.contextPath}/user/findPassword" class="text-decoration-none">비밀번호 찾기</a>
            </div>
        </form>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
                    <li class="breadcrumb-item active" aria-current="page">로그인</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">로그인</h2>
                    <p class="lead">피트니스 라이프의 새로운 시작</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/user/join" 
                       class="btn btn-light btn-lg">
                        <i class="fas fa-user-plus me-2"></i>회원가입
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="login-container">
                    <div class="brand-header">
                        <div class="brand-logo">
                            <span class="brand-dot"></span>
                            HELLKING
                            <span class="brand-dot"></span>
                        </div>
                        <p class="subtitle">안전하고 간편한 로그인</p>
                    </div>
                    
                    <!-- 에러/성공 메시지 -->
                    <c:if test="${not empty message}">
                        <div class="alert alert-danger" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${message}
                        </div>
                    </c:if>
                            
                    <!-- 소셜 로그인 섹션 -->
                    <div class="social-login-section">
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
                            간편하게 소셜 계정으로 로그인하세요
                        </div>
                    </div>
                    
                    <div class="divider">
                        <span>또는</span>
                    </div>
                    
                    <!-- 일반 로그인 폼 -->
                    <form action="${pageContext.request.contextPath}/user/login" method="post">
                        <div class="mb-3">
                            <label for="userId" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="userId" name="userId" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">비밀번호</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        
                        <div class="mb-3 form-check">
                            <input type="checkbox" class="form-check-input" name="rememberme" id="rememberme">
                            <label class="form-check-label" for="rememberme">로그인 정보 저장</label>
                        </div>
                        
                        <button type="submit" class="btn btn-primary w-100 mb-3">로그인</button>
                    </form>
                    
                    <div class="additional-links">
                        <a href="${pageContext.request.contextPath}/user/join">
                            <i class="fas fa-user-plus me-1"></i>회원가입
                        </a>
                        <a href="${pageContext.request.contextPath}/user/findId">
                            <i class="fas fa-search me-1"></i>ID 찾기
                        </a>
                        <a href="${pageContext.request.contextPath}/user/findPassword">
                            <i class="fas fa-key me-1"></i>비밀번호 찾기
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 계정 선택 모달 (기존) -->
    <div class="modal fade" id="accountChoiceModal" tabindex="-1" aria-labelledby="accountChoiceModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="accountChoiceModalLabel">
                        <i class="fas fa-user-friends text-warning"></i>
                        계정 선택
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="accountInfo" class="account-info">
                        <h6><i class="fas fa-envelope me-2 text-primary"></i>확인된 이메일</h6>
                        <p id="modalEmail">${socialChoiceData.email}</p>
                        
                        <h6><i class="fab fa-${socialChoiceData.provider.toLowerCase()} me-2 text-info"></i>추가할 소셜 계정</h6>
                        <p id="modalProvider">${socialChoiceData.provider} 계정</p>
                        
                        <c:if test="${socialChoiceData.hasSocialAccounts}">
                            <div class="alert alert-info mt-2">
                                <h6><i class="fas fa-link me-2"></i>이미 연동된 소셜 계정</h6>
                                <p class="mb-0">
                                    <c:forEach var="account" items="${socialChoiceData.existingSocialAccounts}">
                                        <span class="badge bg-primary me-1">${account.provider}</span>
                                    </c:forEach>
                                </p>
                            </div>
                        </c:if>
                    </div>
                    
                    <p class="text-muted mb-4">
                        <i class="fas fa-info-circle me-2"></i>
                        동일한 이메일로 가입된 계정이 있습니다. 어떻게 진행하시겠습니까?
                    </p>
                    
                    <div class="account-option recommended" data-option="link">
                        <div class="option-title">
                            <i class="fas fa-link text-primary"></i>
                            기존 계정에 소셜 로그인 연결하기
                        </div>
                        <p class="option-desc">
                            기존 계정에 소셜 로그인을 추가하여 다음부터 간편하게 로그인할 수 있습니다. (추천)
                        </p>
                    </div>
                    
                    <div class="account-option" data-option="login">
                        <div class="option-title">
                            <i class="fas fa-sign-in-alt text-success"></i>
                            기존 계정으로 로그인하기
                        </div>
                        <p class="option-desc">
                            기존 계정 정보를 그대로 유지하며 로그인합니다.
                        </p>
                    </div>
                    
                    <div class="text-center mt-3">
                        <small class="text-muted">
                            <i class="fas fa-shield-alt me-1"></i>
                            선택하신 방법에 따라 안전하게 처리됩니다.
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 신규 소셜 계정 생성 선택 모달 -->
    <div class="modal fade" id="newAccountChoiceModal" tabindex="-1" aria-labelledby="newAccountChoiceModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="newAccountChoiceModalLabel">
                        <i class="fas fa-user-plus text-success"></i>
                        새 계정 생성
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="newAccountInfo" class="social-info-section">
                        <div class="social-provider-info">
                            <div id="newProviderIcon" class="provider-icon"></div>
                            <div class="social-user-info">
                                <h6 id="newSocialName">소셜 사용자</h6>
                                <p id="newSocialEmail">이메일 정보</p>
                            </div>
                        </div>
                    </div>
                    
                    <p class="text-muted mb-4">
                        <i class="fas fa-info-circle me-2"></i>
                        이 소셜 계정으로 새로운 헬킹 계정을 생성하시겠습니까?
                    </p>
                    
                    <div class="account-option recommended" data-option="create">
                        <div class="option-title">
                            <i class="fas fa-user-plus text-success"></i>
                            새 계정 생성하기
                        </div>
                        <p class="option-desc">
                            이 소셜 계정으로 새로운 헬킹 계정을 생성하고 바로 로그인합니다. (추천)
                        </p>
                    </div>
                    
                    <div class="account-option" data-option="cancel">
                        <div class="option-title">
                            <i class="fas fa-times text-warning"></i>
                            취소하기
                        </div>
                        <p class="option-desc">
                            계정 생성을 취소하고 로그인 페이지로 돌아갑니다.
                        </p>
                    </div>
                    
                    <div class="text-center mt-3">
                        <small class="text-muted">
                            <i class="fas fa-info-circle me-1"></i>
                            계정 생성 후 언제든지 추가 정보를 입력할 수 있습니다.
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 전역 변수
        let accountChoiceModal;
        let newAccountChoiceModal;
        let socialChoiceData = null;
        
        document.addEventListener('DOMContentLoaded', function() {
            // 모달 초기화
            accountChoiceModal = new bootstrap.Modal(document.getElementById('accountChoiceModal'));
            newAccountChoiceModal = new bootstrap.Modal(document.getElementById('newAccountChoiceModal'));
            
            // 소셜 버튼에 이벤트 리스너 추가
            setupSocialButtons();
            
            // 계정 선택 옵션에 이벤트 리스너 추가
            setupAccountOptions();
            
            // 서버에서 전달된 socialChoiceData 확인
            <c:if test="${not empty socialChoiceData}">
                socialChoiceData = {
                    email: '${socialChoiceData.email}',
                    provider: '${socialChoiceData.provider}',
                    socialUserId: '${socialChoiceData.socialUserId}',
                    socialName: '${socialChoiceData.socialName}',
                    socialProfileImage: '${socialChoiceData.socialProfileImage}',
                    existingUserNum: ${socialChoiceData.existingUserNum},
                    existingUserName: '${socialChoiceData.existingUserName}',
                    hasSocialAccounts: ${socialChoiceData.hasSocialAccounts},
                    isNewAccount: ${socialChoiceData.isNewAccount != null ? socialChoiceData.isNewAccount : false}
                };
            </c:if>
            
            // URL 파라미터 확인하여 모달 표시
            checkForSocialModal();
            
            // 모달 닫기 이벤트 리스너
            setupModalEvents();
            
            // 소셜 로그인 상태 확인
            checkSocialLoginStatus();
        });
        
        function setupSocialButtons() {
            document.querySelectorAll('.btn-social').forEach(button => {
                button.addEventListener('click', function(e) {
                    e.preventDefault();
                    const provider = this.getAttribute('data-provider');
                    if (provider) {
                        startSocialLogin(provider);
                    }
                });
            });
        }
        
        function setupAccountOptions() {
            document.querySelectorAll('#accountChoiceModal .account-option').forEach(option => {
                option.addEventListener('click', function() {
                    const optionType = this.getAttribute('data-option');
                    if (optionType) {
                        selectAccountOption(optionType);
                    }
                });
            });
            
            document.querySelectorAll('#newAccountChoiceModal .account-option').forEach(option => {
                option.addEventListener('click', function() {
                    const optionType = this.getAttribute('data-option');
                    if (optionType) {
                        selectNewAccountOption(optionType);
                    }
                });
            });
        }
        
        function setupModalEvents() {
            const accountModal = document.getElementById('accountChoiceModal');
            const newAccountModal = document.getElementById('newAccountChoiceModal');
            
            if (accountModal) {
                accountModal.addEventListener('hidden.bs.modal', function() {
                    clearUrlParams();
                });
            }
            
            if (newAccountModal) {
                newAccountModal.addEventListener('hidden.bs.modal', function() {
                    clearUrlParams();
                });
            }
        }
        
        function clearUrlParams() {
            const url = new URL(window.location);
            url.searchParams.delete('socialChoice');
            url.searchParams.delete('newAccount');
            url.searchParams.delete('reconnect');
            window.history.replaceState({}, document.title, url.pathname);
        }
        
        function startSocialLogin(provider) {
            const statusElement = document.getElementById('socialStatus');
            if (statusElement) {
                statusElement.innerHTML = '<span class="loading-spinner"></span> ' + provider + ' 인증 중...';
                statusElement.classList.add('loading');
            }
            
            window.location.href = '${pageContext.request.contextPath}/oauth/' + provider;
        }
        
        function checkSocialLoginStatus() {
            fetch('${pageContext.request.contextPath}/oauth/social-status')
                .then(response => response.json())
                .then(data => {
                    if (data.available) {
                        updateSocialButtons(data.available);
                    }
                })
                .catch(error => {
                    console.error('소셜 로그인 상태 확인 실패:', error);
                });
        }
        
        function updateSocialButtons(available) {
            const buttons = {
                'naver': document.querySelector('.btn-naver'),
                'kakao': document.querySelector('.btn-kakao'),
                'google': document.querySelector('.btn-google')
            };
            
            Object.keys(buttons).forEach(provider => {
                const button = buttons[provider];
                if (button && !available[provider]) {
                    button.style.opacity = '0.5';
                    button.style.pointerEvents = 'none';
                    button.title = provider + ' 로그인이 현재 사용할 수 없습니다';
                }
            });
        }
        
        function checkForSocialModal() {
            const urlParams = new URLSearchParams(window.location.search);
            const socialChoice = urlParams.get('socialChoice');
            const isNewAccount = urlParams.get('newAccount');
            const isReconnect = urlParams.get('reconnect');
            
            if (socialChoice === 'true') {
                if (isReconnect === 'true') {
                    showReconnectModal();
                } else if (isNewAccount === 'true') {
                    showNewAccountChoiceModal();
                } else {
                    showAccountChoiceModal();
                }
            }
        }
        
        function showAccountChoiceModal() {
            if (accountChoiceModal) {
                accountChoiceModal.show();
            }
        }
        
        function showNewAccountChoiceModal() {
            if (!socialChoiceData) return;
            
            const providerIcon = document.getElementById('newProviderIcon');
            const socialName = document.getElementById('newSocialName');
            const socialEmail = document.getElementById('newSocialEmail');
            
            providerIcon.className = `provider-icon ${socialChoiceData.provider.toLowerCase()}`;
            if (socialChoiceData.provider === 'NAVER') {
                providerIcon.textContent = 'N';
            } else if (socialChoiceData.provider === 'KAKAO') {
                providerIcon.innerHTML = '<i class="fas fa-comment"></i>';
            } else if (socialChoiceData.provider === 'GOOGLE') {
                providerIcon.innerHTML = '<i class="fab fa-google"></i>';
            }
            
            socialName.textContent = socialChoiceData.socialName || socialChoiceData.provider + ' 사용자';
            socialEmail.textContent = socialChoiceData.socialEmail || '이메일 정보 없음';
            
            if (newAccountChoiceModal) {
                newAccountChoiceModal.show();
            }
        }
        
        function selectAccountOption(option) {
            if (!socialChoiceData) return;
            
            let endpoint = '';
            
            switch(option) {
                case 'link':
                    endpoint = '/oauth/link-account';
                    break;
                case 'login':
                    endpoint = '/oauth/login-existing';
                    break;
                case 'create':
                    endpoint = '/oauth/create-new-account';
                    break;
                default:
                    return;
            }
            
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}' + endpoint;
            document.body.appendChild(form);
            form.submit();
        }
        
        function selectNewAccountOption(option) {
            switch(option) {
                case 'create':
                    const form = document.createElement('form');
                    form.method = 'POST';
                    form.action = '${pageContext.request.contextPath}/oauth/create-new-account';
                    document.body.appendChild(form);
                    form.submit();
                    break;
                case 'cancel':
                    newAccountChoiceModal.hide();
                    const statusElement = document.getElementById('socialStatus');
                    if (statusElement) {
                        statusElement.innerHTML = '간편하게 소셜 계정으로 로그인하세요';
                        statusElement.classList.remove('loading');
                    }
                    break;
            }
        }
    </script>
>>>>>>> b65c320 (Initial commit)
</body>
</html>