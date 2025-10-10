<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원탈퇴 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 - 빨간색 */
        .page-header {
            background: linear-gradient(135deg, #dc3545, #c82333);
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
            --primary-color: #dc3545;
            --ink: #0F172A;
            --danger: #dc3545;
        }
        
        .withdraw-container { 
            max-width: 600px; 
            margin: 40px auto; 
            background: #fff; 
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(15,23,42,0.1);
            overflow: hidden;
        }
        
        .withdraw-header {
            background: linear-gradient(135deg, var(--primary-color), #c82333);
            color: white;
            padding: 40px;
            text-align: center;
        }
        
        .withdraw-header .icon {
            font-size: 48px;
            margin-bottom: 20px;
            opacity: 0.9;
        }
        
        .withdraw-header h2 {
            margin: 0;
            font-size: 28px;
            font-weight: 700;
        }
        
        .withdraw-header p {
            margin: 10px 0 0;
            opacity: 0.9;
            font-size: 16px;
        }
        
        .withdraw-content {
            padding: 40px;
        }
        
        .warning-box {
            background: #fff3cd;
            border: 2px solid #ffc107;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .warning-box .warning-icon {
            color: #f0ad4e;
            font-size: 24px;
            margin-bottom: 15px;
        }
        
        .warning-box h5 {
            color: #856404;
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        .warning-list {
            color: #856404;
            margin: 0;
            padding-left: 0;
            list-style: none;
        }
        
        .warning-list li {
            padding: 8px 0;
            padding-left: 25px;
            position: relative;
        }
        
        .warning-list li:before {
            content: "⚠️";
            position: absolute;
            left: 0;
            top: 8px;
        }
        
        .social-account-notice {
            background: #e7f3ff;
            border: 2px solid #0066cc;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .social-account-notice .info-icon {
            color: #0066cc;
            font-size: 24px;
            margin-bottom: 10px;
        }
        
        .social-account-notice p {
            color: #004085;
            margin: 0;
            font-size: 14px;
            line-height: 1.5;
        }
        
        .password-section {
            margin-bottom: 30px;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--ink);
            margin-bottom: 8px;
        }
        
        .form-control {
            border-radius: 12px;
            padding: 12px 16px;
            border: 2px solid #E7E0D6;
            font-size: 16px;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(220,53,69,0.25);
        }
        
        .checkbox-section {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .form-check {
            margin-bottom: 12px;
        }
        
        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .form-check-label {
            color: var(--ink);
            font-weight: 500;
        }
        
        .btn-danger-custom {
            background: var(--primary-color);
            border: none;
            color: white;
            font-weight: 700;
            padding: 15px 30px;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        
        .btn-danger-custom:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(220,53,69,0.3);
        }
        
        .btn-danger-custom:disabled {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }
        
        .btn-secondary-custom {
            background: #6c757d;
            border: none;
            color: white;
            font-weight: 600;
            padding: 15px 30px;
            border-radius: 12px;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .btn-secondary-custom:hover {
            background: #5a6268;
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }
        
        .button-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }
        
        .feedback {
            font-size: 14px;
            margin-top: 8px;
        }
        
        .feedback.invalid {
            color: var(--primary-color);
        }
        
        .feedback.valid {
            color: #28a745;
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
            .withdraw-container {
                margin: 20px;
                border-radius: 15px;
            }
            
            .withdraw-header,
            .withdraw-content {
                padding: 30px 20px;
            }
            
            .button-group {
                flex-direction: column;
            }
            
            .btn-danger-custom,
            .btn-secondary-custom {
                width: 100%;
                text-align: center;
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
                        <a href="${pageContext.request.contextPath}/user/mypage">마이페이지</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">회원탈퇴</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">회원탈퇴</h2>
                    <p class="lead">정말로 헬킹 피트니스를 떠나시겠습니까?</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/user/mypage" 
                       class="btn btn-light btn-lg">
                        <i class="fas fa-arrow-left me-2"></i>마이페이지
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="withdraw-container">
                    <!-- 헤더 -->
                    <div class="withdraw-header">
                        <i class="fas fa-user-times icon"></i>
                        <h2>회원탈퇴</h2>
                        <p>정말로 헬킹 피트니스를 떠나시겠습니까?</p>
                    </div>
                    
                    <!-- 컨텐츠 -->
                    <div class="withdraw-content">
                        <!-- 경고 메시지 -->
                        <div class="warning-box">
                            <div class="text-center">
                                <i class="fas fa-exclamation-triangle warning-icon"></i>
                            </div>
                            <h5 class="text-center">탈퇴 시 삭제되는 정보</h5>
                            <ul class="warning-list">
                                <li>회원 정보 및 프로필</li>
                                <li>보유 중인 패스권 및 이용권</li>
                                <li>작성한 게시글 및 댓글</li>
                                <li>적립된 포인트 및 쿠폰</li>
                                <li>운동 기록 및 통계 데이터</li>
                            </ul>
                        </div>
                        
                        <!-- 소셜 계정 연동 안내 -->
                        <div class="social-account-notice">
                            <div class="text-center">
                                <i class="fas fa-info-circle info-icon"></i>
                            </div>
                            <p class="text-center">
                                <strong>소셜 로그인 연동 해제:</strong><br>
                                네이버, 카카오, 구글 등 연동된 소셜 계정도 함께 해제됩니다.<br>
                                동일한 소셜 계정으로 재가입 시 기존 데이터는 복구되지 않습니다.
                            </p>
                        </div>
                        
                        <!-- 탈퇴 폼 -->
                        <form id="withdrawForm" action="${pageContext.request.contextPath}/user/withdrawPost" method="post">
                            <!-- 비밀번호 확인 (소셜 로그인 사용자가 아닌 경우만 표시) -->
                            <c:if test="${!isSocialOnly}">
                                <div class="password-section" id="passwordSection">
                                    <label for="password" class="form-label">
                                        <i class="fas fa-lock me-2"></i>비밀번호 확인
                                    </label>
                                    <input type="password" class="form-control" id="password" name="password" 
                                           placeholder="계정 비밀번호를 입력해주세요" required>
                                    <div class="feedback" id="passwordFeedback"></div>
                                </div>
                            </c:if>
                            
                            <!-- 소셜 전용 계정 안내 -->
                            <c:if test="${isSocialOnly}">
                                <div class="social-account-notice">
                                    <div class="text-center">
                                        <i class="fas fa-users info-icon"></i>
                                    </div>
                                    <p class="text-center">
                                        <strong>소셜 로그인 계정</strong><br>
                                        소셜 로그인으로 가입하신 계정은 별도 비밀번호 확인 없이 탈퇴 처리됩니다.
                                    </p>
                                </div>
                            </c:if>
                            
                            <!-- 동의 체크박스 -->
                            <div class="checkbox-section">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="agreeDataDelete" required>
                                    <label class="form-check-label" for="agreeDataDelete">
                                        회원탈퇴 시 모든 데이터가 삭제됨을 이해했습니다.
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="agreeNoRecovery" required>
                                    <label class="form-check-label" for="agreeNoRecovery">
                                        탈퇴 후에는 데이터 복구가 불가능함을 이해했습니다.
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="agreeFinal" required>
                                    <label class="form-check-label" for="agreeFinal">
                                        <strong>정말로 회원탈퇴를 진행하겠습니다.</strong>
                                    </label>
                                </div>
                            </div>
                            
                            <!-- 버튼 그룹 -->
                            <div class="button-group">
                                <a href="${pageContext.request.contextPath}/user/mypage" class="btn-secondary-custom">
                                    <i class="fas fa-arrow-left me-2"></i>취소
                                </a>
                                <button type="submit" class="btn-danger-custom" id="withdrawBtn" disabled>
                                    <i class="fas fa-user-times me-2"></i>회원탈퇴
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('withdrawForm');
            const withdrawBtn = document.getElementById('withdrawBtn');
            const checkboxes = document.querySelectorAll('input[type="checkbox"]');
            const passwordInput = document.getElementById('password');
            
            // 체크박스 상태 확인
            function checkFormValidity() {
                const allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked);
                const passwordSection = document.getElementById('passwordSection');
                let passwordValid = true;
                
                // 비밀번호 섹션이 있는 경우에만 비밀번호 확인
                if (passwordSection && passwordSection.style.display !== 'none') {
                    passwordValid = passwordInput.value.trim().length > 0;
                }
                
                withdrawBtn.disabled = !(allChecked && passwordValid);
            }
            
            // 체크박스 이벤트 리스너
            checkboxes.forEach(checkbox => {
                checkbox.addEventListener('change', checkFormValidity);
            });
            
            // 비밀번호 입력 이벤트 리스너 (비밀번호 섹션이 있는 경우에만)
            if (passwordInput) {
                passwordInput.addEventListener('input', checkFormValidity);
            }
            
            // 폼 제출 처리
            form.addEventListener('submit', function(e) {
                e.preventDefault();
                
                // 최종 확인
                const confirmMessage = '정말로 회원탈퇴를 진행하시겠습니까?\n\n' +
                                     '• 모든 데이터가 즉시 삭제됩니다\n' +
                                     '• 복구가 불가능합니다\n' +
                                     '• 보유 중인 패스권도 모두 소멸됩니다\n\n' +
                                     '이 작업은 되돌릴 수 없습니다.';
                
                if (!confirm(confirmMessage)) {
                    return;
                }
                
                // 버튼 비활성화 및 로딩 상태
                withdrawBtn.disabled = true;
                withdrawBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>탈퇴 처리 중...';
                
                // 폼 제출
                form.submit();
            });
            
            // 페이지 이탈 경고 (폼이 수정된 경우)
            let formModified = false;
            
            form.addEventListener('input', function() {
                formModified = true;
            });
            
            window.addEventListener('beforeunload', function(e) {
                if (formModified) {
                    e.preventDefault();
                    e.returnValue = '작성 중인 내용이 있습니다. 정말 페이지를 떠나시겠습니까?';
                }
            });
            
            // 폼 제출 시에는 경고 해제
            form.addEventListener('submit', function() {
                formModified = false;
            });
        });
        
        // 취소 버튼 클릭 시 경고 해제
        document.querySelector('.btn-secondary-custom').addEventListener('click', function() {
            window.removeEventListener('beforeunload', function() {});
        });
    </script>
</body>
</html>