<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원정보 수정 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<<<<<<< HEAD
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
        }
        body { background: var(--bg-cream); }
        .edit-container {
            max-width: 500px;
            margin: 50px auto;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(15,23,42,0.1);
        }
        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid var(--brand);
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
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 - 주황색 */
        .page-header {
            background: linear-gradient(135deg, #fd7e14, #f39c12);
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

        /* === 고정 알림 시스템 === */
        .alert-container {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 9999;
            width: 90%;
            max-width: 500px;
            pointer-events: none;
        }

        .alert-container .alert {
            pointer-events: all;
            border: none;
            border-radius: 14px;
            margin-bottom: 10px;
            position: relative;
            box-shadow: 0 8px 25px rgba(15,23,42,0.15);
            backdrop-filter: blur(10px);
            animation: slideInDown 0.5s ease-out;
        }

        .alert-success {
            background: rgba(212, 237, 218, 0.95);
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .alert-info {
            background: rgba(209, 236, 241, 0.95);
            color: #0c5460;
            border-left: 4px solid #17a2b8;
        }

        .alert-warning {
            background: rgba(255, 243, 205, 0.95);
            color: #856404;
            border-left: 4px solid #ffc107;
        }

        .alert-danger {
            background: rgba(248, 215, 218, 0.95);
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .alert i {
            margin-right: 8px;
            font-size: 16px;
        }

        .btn-close {
            background: none;
            border: none;
            font-size: 18px;
            opacity: 0.6;
            cursor: pointer;
            transition: opacity 0.2s ease;
        }

        .btn-close:hover {
            opacity: 1;
        }

        @keyframes slideInDown {
            from {
                transform: translateY(-100%);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        @keyframes fadeOut {
            from {
                opacity: 1;
                transform: translateY(0);
            }
            to {
                opacity: 0;
                transform: translateY(-20px);
            }
        }

        .alert.fade-out {
            animation: fadeOut 0.3s ease-in forwards;
        }

        .alert-progress {
            position: absolute;
            bottom: 0;
            left: 0;
            height: 3px;
            background: rgba(0,0,0,0.2);
            border-radius: 0 0 14px 14px;
            animation: progress 5s linear forwards;
        }

        @keyframes progress {
            from { width: 100%; }
            to { width: 0%; }
        }
        
        /* 기존 스타일 조정 */
        :root {
            --primary-color: #fd7e14;
            --ink: #0F172A;
            --muted: #5B6170;
            --success: #10B981;
            --warning: #F59E0B;
            --danger: #EF4444;
            --line: #E7E0D6;
            --hover: #FFF5EA;
        }
        
        .edit-container {
            max-width: 600px;
            margin: 40px auto;
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(15,23,42,0.1);
        }
        
        .brand-header {
            text-align: center;
            margin-bottom: 35px;
        }
        
        .brand-logo {
            font-size: 28px;
            font-weight: 900;
            color: var(--primary-color);
            margin-bottom: 8px;
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
            box-shadow: 0 0 12px rgba(253, 126, 20, 0.5);
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
        
        /* 프로필 이미지 업로드 스타일 */
        .profile-upload-section {
            text-align: center;
            margin-bottom: 30px;
            padding: 25px;
            background: #F8F9FA;
            border-radius: 16px;
            border: 2px dashed var(--line);
            transition: all 0.3s ease;
            position: relative;
        }
        
        .profile-upload-section:hover {
            border-color: var(--primary-color);
            background: var(--hover);
            transform: translateY(-2px);
        }
        
        .profile-preview {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--primary-color);
            margin-bottom: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            box-shadow: 0 8px 20px rgba(253, 126, 20, 0.2);
        }
        
        .profile-preview:hover {
            transform: scale(1.05);
            box-shadow: 0 12px 30px rgba(253, 126, 20, 0.4);
        }
        
        .profile-overlay {
            position: absolute;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: rgba(253, 126, 20, 0.8);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .profile-preview:hover + .profile-overlay,
        .profile-overlay:hover {
            opacity: 1;
        }
        
        .profile-overlay i {
            font-size: 24px;
            color: white;
        }
        
        .upload-controls {
            display: flex;
            gap: 12px;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .upload-btn {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .upload-btn:hover {
            background: #e55a00;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(253, 126, 20, 0.3);
        }
        
        .upload-btn.secondary {
            background: var(--muted);
        }
        
        .upload-btn.secondary:hover {
            background: #4a5568;
        }
        
        .upload-btn.danger {
            background: var(--danger);
        }
        
        .upload-btn.danger:hover {
            background: #dc2626;
        }
        
        .file-info {
            margin-top: 15px;
            font-size: 13px;
            color: var(--muted);
            line-height: 1.5;
        }
        
        .file-info.success {
            color: var(--success);
            font-weight: 600;
        }
        
        .file-info.error {
            color: var(--danger);
            font-weight: 600;
        }
        
        /* 드래그 앤 드롭 스타일 */
        .profile-upload-section.drag-over {
            border-color: var(--primary-color);
            background: var(--hover);
            border-style: solid;
        }
        
        .drag-hint {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(255, 255, 255, 0.95);
            padding: 20px;
            border-radius: 12px;
            font-weight: 600;
            color: var(--primary-color);
            opacity: 0;
            pointer-events: none;
            transition: all 0.3s ease;
            backdrop-filter: blur(5px);
        }
        
        .profile-upload-section.drag-over .drag-hint {
            opacity: 1;
        }
        
        /* 로딩 스피너 */
        .upload-loading {
            display: none;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(255, 255, 255, 0.95);
            padding: 20px;
            border-radius: 12px;
            backdrop-filter: blur(5px);
        }
        
        .upload-loading.active {
            display: block;
        }
        
        .spinner {
            width: 40px;
            height: 40px;
            border: 4px solid var(--line);
            border-top: 4px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 10px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* 폼 스타일 개선 */
        .btn-primary {
            background: var(--primary-color);
            border: none;
            font-weight: 700;
            padding: 14px;
            border-radius: 12px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover:not(:disabled) {
            background: #e55a00;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(253, 126, 20, 0.3);
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
            box-shadow: 0 0 0 0.2rem rgba(253,126,20,0.1);
        }
        
        .form-label {
            font-weight: 600;
            color: var(--ink);
            margin-bottom: 8px;
        }
        
        .form-label.required::after {
            content: ' *';
            color: var(--danger);
        }
        
        .form-label.optional::after {
            content: ' (선택)';
            color: var(--muted);
            font-size: 12px;
            font-weight: normal;
        }
        
        /* 비밀번호 변경 섹션 */
        .password-change-section {
            background: #F8F9FA;
            padding: 25px;
            border-radius: 16px;
            margin-top: 25px;
            border: 2px solid var(--line);
            transition: all 0.3s ease;
        }
        
        .password-toggle {
            cursor: pointer;
            color: var(--primary-color);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .password-toggle:hover {
            background: var(--hover);
            color: #e55a00;
        }
        
        .password-change-form {
            display: none;
            transition: all 0.3s ease;
        }
        
        .password-change-form.active {
            display: block;
            animation: slideDown 0.3s ease;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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
            color: var(--muted);
            transition: color 0.3s ease;
        }
        
        .requirement.met {
            color: var(--success);
        }
        
        .requirement i {
            width: 16px;
            margin-right: 8px;
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
        
        .btn-password-change {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-password-change:hover:not(:disabled) {
            background: #e55a00;
            transform: translateY(-1px);
        }
        
        .btn-password-change:disabled {
            background: #ccc;
            cursor: not-allowed;
        }
        
        /* 소셜 계정 관리 스타일 개선 */
        .social-account-item {
            transition: all 0.3s ease;
            border-radius: 12px !important;
        }
        
        .social-account-item:hover {
            background-color: var(--hover) !important;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        
        .btn-unlink:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }
        
        .additional-links {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--line);
        }
        
        .additional-links a {
            color: var(--muted);
            text-decoration: none;
            font-size: 14px;
            margin: 0 15px;
            transition: all 0.3s ease;
            padding: 5px 10px;
            border-radius: 6px;
        }
        
        .additional-links a:hover {
            color: var(--primary-color);
            background: var(--hover);
        }
        
        .additional-links a.danger:hover {
            color: var(--danger);
            background: rgba(239, 68, 68, 0.1);
        }
        
        /* 반응형 */
        @media (max-width: 768px) {
            .alert-container {
                width: 95%;
                top: 15px;
            }

            .page-header {
                padding: 40px 0;
            }
            .page-header .row {
                text-align: center;
            }
            .page-header .col-md-4 {
                margin-top: 20px;
            }
            .edit-container {
                margin: 20px auto;
                padding: 30px 20px;
            }
>>>>>>> b65c320 (Initial commit)
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
<<<<<<< HEAD
    
    <div class="edit-container">
        <h2 class="text-center mb-4" style="color: var(--brand);">회원정보 수정</h2>
        
        <c:if test="${not empty message}">
            <div class="alert alert-info" role="alert">${message}</div>
        </c:if>
        
        <!-- 프로필 이미지 -->
        <div class="text-center mb-4">
            <img src="${pageContext.request.contextPath}/resources/images/profiles/${user.profileImage}" 
                 alt="프로필" class="profile-img mb-2">
            <div>
                <button type="button" class="btn btn-sm btn-outline-secondary">프로필 변경</button>
            </div>
        </div>
        
        <form action="${pageContext.request.contextPath}/user/editPost" method="post" enctype="multipart/form-data">
            <!-- 아이디 (수정 불가) -->
            <div class="mb-3">
                <label for="userId" class="form-label">아이디</label>
                <input type="text" class="form-control" id="userId" value="${user.userId}" readonly>
            </div>
            
            <!-- 이름 -->
            <div class="mb-3">
                <label for="username" class="form-label">이름 <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="username" name="username" 
                       value="${user.username}" required>
            </div>
            
            <!-- 이메일 -->
            <div class="mb-3">
                <label for="email" class="form-label">이메일 <span class="text-danger">*</span></label>
                <input type="email" class="form-control" id="email" name="email" 
                       value="${user.email}" required>
            </div>
            
            <!-- 전화번호 -->
            <div class="mb-3">
                <label for="phone" class="form-label">전화번호 <span class="text-danger">*</span></label>
                <input type="tel" class="form-control" id="phone" name="phone" 
                       value="${user.phone}" required>
            </div>
            
            <!-- 생년월일 -->
            <div class="mb-3">
                <label for="birthDate" class="form-label">생년월일</label>
                <input type="date" class="form-control" id="birthDate" name="birthDate" 
                       value="<fmt:formatDate value='${user.birthDate}' pattern='yyyy-MM-dd'/>">
            </div>
            
            <!-- 성별 -->
            <div class="mb-3">
                <label class="form-label">성별</label>
                <div class="d-flex gap-3">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="M" id="genderM"
                               ${user.gender == 'M' ? 'checked' : ''}>
                        <label class="form-check-label" for="genderM">남성</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="F" id="genderF"
                               ${user.gender == 'F' ? 'checked' : ''}>
                        <label class="form-check-label" for="genderF">여성</label>
                    </div>
                </div>
            </div>
            
            <!-- 프로필 이미지 업로드 (숨김) -->
            <input type="file" name="profileImageFile" id="profileImageFile" 
                   accept="image/*" style="display: none;">
            
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">정보 수정</button>
                <a href="${pageContext.request.contextPath}/user/mypage" 
                   class="btn btn-outline-secondary">취소</a>
            </div>
        </form>
        
        <hr class="my-4">
        
        <!-- 추가 메뉴 -->
        <div class="text-center">
            <a href="${pageContext.request.contextPath}/user/changePassword" 
               class="text-decoration-none me-3">비밀번호 변경</a>
            <a href="${pageContext.request.contextPath}/user/withdraw" 
               class="text-decoration-none text-danger">회원탈퇴</a>
        </div>
    </div>
    
    <script>
        // 프로필 이미지 변경
        document.querySelector('.btn-outline-secondary').addEventListener('click', function() {
            document.getElementById('profileImageFile').click();
        });
        
        // 이미지 파일 선택 시 미리보기
        document.getElementById('profileImageFile').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.querySelector('.profile-img').src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
=======

    <!-- 고정 위치 알림 컨테이너 -->
    <div class="alert-container" id="alertContainer">
        <c:if test="${not empty message}">
            <div class="alert alert-info alert-dismissible fade show" role="alert">
                <i class="fas fa-info-circle"></i>${message}
                <button type="button" class="btn-close" aria-label="닫기"></button>
                <div class="alert-progress"></div>
            </div>
        </c:if>
    </div>
    
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
                    <li class="breadcrumb-item active" aria-current="page">정보수정</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">회원정보 수정</h2>
                    <p class="lead">작성한 정보를 수정하여 더 나은 프로필을 완성하세요</p>
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
                <div class="edit-container">
                    <div class="brand-header">
                        <div class="brand-logo">
                            <span class="brand-dot"></span>
                            HELLKING
                            <span class="brand-dot"></span>
                        </div>
                        <p class="subtitle">회원정보 수정</p>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/user/editPost" method="post" enctype="multipart/form-data">
                        <!-- userNum hidden 필드 추가 -->
                        <input type="hidden" name="userNum" value="${user.userNum}">	            
                        <!-- 프로필 이미지 업로드 섹션 -->
                        <div class="profile-upload-section" id="profileUploadArea">
                            <img id="profilePreview" 
                                 src="<c:choose>
                                        <c:when test='${user.profileImage != null and !user.profileImage.startsWith("http")}'>
                                            ${pageContext.request.contextPath}/upload/${user.profileImage}
                                        </c:when>
                                        <c:when test='${user.profileImage != null and user.profileImage.startsWith("http")}'>
                                            ${user.profileImage}
                                        </c:when>
                                        <c:otherwise>
                                            ${pageContext.request.contextPath}/resources/images/profiles/avatar1.png
                                        </c:otherwise>
                                      </c:choose>" 
                                 alt="프로필 미리보기" class="profile-preview" onclick="selectImage()">
                            
                            <div class="profile-overlay" onclick="selectImage()">
                                <i class="fas fa-camera"></i>
                            </div>
                            
                            <div class="upload-controls">
                                <button type="button" class="upload-btn" onclick="selectImage()">
                                    <i class="fas fa-camera"></i>사진 선택
                                </button>
                                <button type="button" class="upload-btn secondary" onclick="resetToDefault()">
                                    <i class="fas fa-user"></i>기본 이미지
                                </button>
                                <button type="button" class="upload-btn danger" onclick="removeImage()" id="removeBtn" 
                                        style="display: ${user.profileImage != null && user.profileImage != 'avatar1.png' ? 'flex' : 'none'}">
                                    <i class="fas fa-trash"></i>삭제
                                </button>
                            </div>
                            
                            <div class="file-info" id="fileInfo">
                                <i class="fas fa-info-circle"></i>
                                JPG, PNG, GIF, WEBP 파일 (최대 5MB)<br>
                                드래그 앤 드롭으로도 업로드 가능합니다
                            </div>
                            
                            <div class="drag-hint">
                                <i class="fas fa-cloud-upload-alt"></i> 이미지를 여기에 드롭하세요
                            </div>
                            
                            <div class="upload-loading" id="uploadLoading">
                                <div class="spinner"></div>
                                <div style="text-align: center; font-weight: 600; color: var(--primary-color);">
                                    이미지 처리 중...
                                </div>
                            </div>
                            
                            <input type="file" id="profileImageFile" name="profileImageFile" accept="image/*" style="display: none;">
                        </div>
                        
                        <!-- 아이디 (수정 불가) -->
                        <div class="mb-3">
                            <label for="userId" class="form-label">아이디</label>
                            <input type="text" class="form-control" id="userId" value="${user.userId}" readonly style="background-color: #f8f9fa;">
                        </div>
                        
                        <!-- 이름 -->
                        <div class="mb-3">
                            <label for="username" class="form-label required">이름</label>
                            <input type="text" class="form-control" id="username" name="username" 
                                   value="${user.username}" required>
                        </div>
                        
                        <!-- 이메일 -->
                        <div class="mb-3">
                            <label for="email" class="form-label optional">이메일</label>
                            <input type="email" class="form-control" id="email" name="email" 
                                   value="${user.email != null ? user.email : ''}" 
                                   placeholder="이메일을 입력하세요">
                        </div>
                        
                        <!-- 전화번호 -->
                        <div class="mb-3">
                            <label for="phone" class="form-label optional">전화번호</label>
                            <input type="tel" class="form-control" id="phone" name="phone" 
                                   value="${user.phone != null ? user.phone : ''}" 
                                   placeholder="전화번호를 입력하세요">
                        </div>
                        
                        <!-- 생년월일 -->
                        <div class="mb-3">
                            <label for="birthDate" class="form-label optional">생년월일</label>
                            <input type="date" class="form-control" id="birthDate" name="birthDate" 
                                   value="<fmt:formatDate value='${user.birthDate}' pattern='yyyy-MM-dd'/>">
                        </div>
                        
                        <!-- 성별 -->
                        <div class="mb-3">
                            <label class="form-label optional">성별</label>
                            <div class="d-flex gap-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender" value="M" id="genderM"
                                           ${user.gender == 'M' ? 'checked' : ''}>
                                    <label class="form-check-label" for="genderM">남성</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender" value="F" id="genderF"
                                           ${user.gender == 'F' ? 'checked' : ''}>
                                    <label class="form-check-label" for="genderF">여성</label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">정보 수정</button>
                            <a href="${pageContext.request.contextPath}/user/mypage" 
                               class="btn btn-outline-secondary">취소</a>
                        </div>
                    </form>
                    
                    <!-- 비밀번호 변경 섹션 (소셜 사용자가 아닌 경우만 표시) -->
                    <c:if test="${!isSocialUser}">
                        <div class="password-change-section">
                            <div class="password-toggle" onclick="togglePasswordChange()">
                                <i class="fas fa-key"></i>
                                <span>비밀번호 변경</span>
                                <i class="fas fa-chevron-down" id="passwordToggleIcon"></i>
                            </div>
                            
                            <div class="password-change-form" id="passwordChangeForm">
                                <form action="${pageContext.request.contextPath}/user/changePassword" method="post">
                                    <!-- 현재 비밀번호 -->
                                    <div class="mb-3">
                                        <label for="currentPassword" class="form-label required">현재 비밀번호</label>
                                        <input type="password" id="currentPassword" name="currentPassword" class="form-control" required>
                                        <div id="currentPasswordFeedback" class="feedback"></div>
                                    </div>
                                    
                                    <!-- 새 비밀번호 -->
                                    <div class="mb-3">
                                        <label for="newPassword" class="form-label required">새 비밀번호</label>
                                        <input type="password" id="newPassword" name="newPassword" class="form-control" required>
                                        
                                        <!-- 비밀번호 강도 표시기 -->
                                        <div id="newPasswordStrength" class="password-strength" style="display:none;">
                                            <div class="d-flex justify-content-between align-items-center mb-2">
                                                <span id="newStrengthText">비밀번호 강도:</span>
                                                <span id="newStrengthLevel"></span>
                                            </div>
                                            <div class="password-strength-bar">
                                                <div id="newStrengthFill" class="strength-fill"></div>
                                            </div>
                                        </div>
                                        
                                        <!-- 비밀번호 요구사항 -->
                                        <div id="newPasswordRequirements" class="password-requirements">
                                            <div class="requirement" id="new-req-length">
                                                <i class="fas fa-times"></i>
                                                8자리 이상
                                            </div>
                                            <div class="requirement" id="new-req-uppercase">
                                                <i class="fas fa-times"></i>
                                                영문 대문자 포함
                                            </div>
                                            <div class="requirement" id="new-req-lowercase">
                                                <i class="fas fa-times"></i>
                                                영문 소문자 포함
                                            </div>
                                            <div class="requirement" id="new-req-number">
                                                <i class="fas fa-times"></i>
                                                숫자 포함
                                            </div>
                                            <div class="requirement" id="new-req-special">
                                                <i class="fas fa-times"></i>
                                                특수문자 포함 (!@#$%^&*)
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- 새 비밀번호 확인 -->
                                    <div class="mb-3">
                                        <label for="confirmNewPassword" class="form-label required">새 비밀번호 확인</label>
                                        <input type="password" id="confirmNewPassword" name="confirmNewPassword" class="form-control" required>
                                        <div id="confirmNewPasswordFeedback" class="feedback"></div>
                                    </div>
                                    
                                    <div class="d-flex gap-2">
                                        <button type="submit" id="changePasswordBtn" class="btn-password-change" disabled>비밀번호 변경</button>
                                        <button type="button" class="btn btn-outline-secondary" onclick="togglePasswordChange()">취소</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </c:if>
                    
                    <!-- 소셜 계정 관리 섹션 -->
                    <div class="card mt-4">
                        <div class="card-header">
                            <h5><i class="fas fa-link me-2"></i>소셜 계정 연동 관리</h5>
                        </div>
                        <div class="card-body">
                            <c:choose>
                                <c:when test="${empty socialAccounts}">
                                    <p class="text-muted">연동된 소셜 계정이 없습니다.</p>
                                    <div class="d-flex gap-2 flex-wrap">
                                        <a href="${pageContext.request.contextPath}/oauth/naver" class="btn btn-success btn-sm">
                                            <i class="fab fa-naver me-1"></i>네이버 연동
                                        </a>
                                        <a href="${pageContext.request.contextPath}/oauth/kakao" class="btn btn-warning btn-sm">
                                            <i class="fab fa-kakao me-1"></i>카카오 연동
                                        </a>
                                        <a href="${pageContext.request.contextPath}/oauth/google" class="btn btn-primary btn-sm">
                                            <i class="fab fa-google me-1"></i>구글 연동
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="social-accounts-list">
                                        <c:forEach items="${socialAccounts}" var="social">
                                            <div class="social-account-item d-flex justify-content-between align-items-center p-3 border rounded mb-2">
                                                <div class="social-info">
                                                    <c:choose>
                                                        <c:when test="${social.provider == 'NAVER'}">
                                                            <i class="fab fa-naver me-2 text-success"></i>
                                                        </c:when>
                                                        <c:when test="${social.provider == 'KAKAO'}">
                                                            <i class="fab fa-kakao me-2 text-warning"></i>
                                                        </c:when>
                                                        <c:when test="${social.provider == 'GOOGLE'}">
                                                            <i class="fab fa-google me-2 text-primary"></i>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <i class="fas fa-user me-2"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <strong>${social.provider}</strong>
                                                    <c:if test="${social.createdAt != null}">
                                                        <small class="text-muted ms-2">
                                                            연동일: <fmt:formatDate value="${social.createdAt}" pattern="yyyy.MM.dd"/>
                                                        </small>
                                                    </c:if>
                                                </div>
                                                <button type="button" 
                                                        class="btn btn-outline-danger btn-sm unlink-social-btn"
                                                        data-provider="${social.provider}"
                                                        ${isSocialUser && socialAccounts.size() <= 1 ? 'disabled title="소셜 전용 계정은 최소 1개 계정이 필요합니다"' : ''}>
                                                    <i class="fas fa-unlink me-1"></i>연동 해제
                                                </button>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    
                                    <!-- 소셜 전용 계정 경고 메시지 -->
                                    <c:if test="${isSocialUser}">
                                        <div class="alert alert-warning mt-3">
                                            <i class="fas fa-info-circle me-2"></i>
                                            <strong>소셜 전용 계정 안내</strong><br>
                                            최소 1개의 소셜 계정이 연결되어 있어야 로그인할 수 있습니다.
                                            <c:if test="${socialAccounts.size() <= 1}">
                                                <br><small>마지막 소셜 계정은 해제할 수 없습니다.</small>
                                            </c:if>
                                        </div>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <div class="additional-links">
                        <c:choose>
                            <c:when test="${isSocialUser}">
                                <span class="text-muted me-3">소셜 전용 계정</span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/user/changePassword">
                                    <i class="fas fa-key me-1"></i>비밀번호 변경
                                </a>
                            </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/user/withdraw" class="danger">
                            <i class="fas fa-user-times me-1"></i>회원탈퇴
                        </a>
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
        let isSocialOnlyUser = ${isSocialUser != null ? isSocialUser : false};
        let connectedSocialCount = ${socialAccounts != null ? socialAccounts.size() : 0};
        
        console.log('회원정보 수정 페이지 초기화 시작');
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            console.log('DOM 로드 완료');
            
            try {
                setupAlertSystem();
                setupProfileImageUpload();
                setupPasswordSecurity();
                setupSocialAccountEvents();
                
                console.log('모든 초기화 완료');
            } catch (error) {
                console.error('초기화 중 오류:', error);
            }
        });

        // 알림 시스템 설정
        function setupAlertSystem() {
            class AlertSystem {
                constructor() {
                    this.container = document.getElementById('alertContainer');
                    this.init();
                }

                init() {
                    // 기존 알림들에 이벤트 리스너 추가
                    this.attachEventListeners();
                    // 자동 사라짐 타이머 시작
                    this.startAutoHide();
                }

                attachEventListeners() {
                    const alerts = this.container.querySelectorAll('.alert');
                    alerts.forEach(alert => {
                        const closeBtn = alert.querySelector('.btn-close');
                        if (closeBtn) {
                            closeBtn.addEventListener('click', () => this.hideAlert(alert));
                        }
                        
                        // 클릭해서 닫기
                        alert.addEventListener('click', (e) => {
                            if (e.target === alert) {
                                this.hideAlert(alert);
                            }
                        });
                    });
                }

                startAutoHide() {
                    const alerts = this.container.querySelectorAll('.alert');
                    alerts.forEach((alert, index) => {
                        setTimeout(() => {
                            if (alert.parentNode) {
                                this.hideAlert(alert);
                            }
                        }, 5000 + (index * 500));
                    });
                }

                hideAlert(alert) {
                    alert.classList.add('fade-out');
                    setTimeout(() => {
                        if (alert.parentNode) {
                            alert.remove();
                        }
                    }, 300);
                }

                showAlert(message, type = 'success', icon = 'check-circle', autoHide = true) {
                    const alertElement = document.createElement('div');
                    alertElement.className = `alert alert-${type} alert-dismissible fade show`;
                    alertElement.setAttribute('role', 'alert');
                    
                    alertElement.innerHTML = `
                        <i class="fas fa-${icon}"></i>${message}
                        <button type="button" class="btn-close" aria-label="닫기"></button>
                        ${autoHide ? '<div class="alert-progress"></div>' : ''}
                    `;
                    
                    this.container.appendChild(alertElement);
                    
                    // 이벤트 리스너 추가
                    const closeBtn = alertElement.querySelector('.btn-close');
                    closeBtn.addEventListener('click', () => this.hideAlert(alertElement));
                    
                    alertElement.addEventListener('click', (e) => {
                        if (e.target === alertElement) {
                            this.hideAlert(alertElement);
                        }
                    });
                    
                    // 자동 사라짐
                    if (autoHide) {
                        setTimeout(() => {
                            if (alertElement.parentNode) {
                                this.hideAlert(alertElement);
                            }
                        }, 5000);
                    }
                    
                    return alertElement;
                }
            }

            // 알림 시스템 초기화
            const alertSystem = new AlertSystem();

            // 전역에서 사용할 수 있도록 window 객체에 추가
            window.showAlert = (message, type, icon, autoHide) => {
                return alertSystem.showAlert(message, type, icon, autoHide);
            };
        }

        // 프로필 이미지 업로드 설정
        function setupProfileImageUpload() {
            const fileInput = document.getElementById('profileImageFile');
            const preview = document.getElementById('profilePreview');
            const uploadArea = document.getElementById('profileUploadArea');
            const fileInfo = document.getElementById('fileInfo');
            const loading = document.getElementById('uploadLoading');
            const removeBtn = document.getElementById('removeBtn');
            
            // 드래그 앤 드롭 이벤트
            ['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
                uploadArea.addEventListener(eventName, preventDefaults, false);
            });
            
            function preventDefaults(e) {
                e.preventDefault();
                e.stopPropagation();
            }
            
            ['dragenter', 'dragover'].forEach(eventName => {
                uploadArea.addEventListener(eventName, highlight, false);
            });
            
            ['dragleave', 'drop'].forEach(eventName => {
                uploadArea.addEventListener(eventName, unhighlight, false);
            });
            
            function highlight() {
                uploadArea.classList.add('drag-over');
            }
            
            function unhighlight() {
                uploadArea.classList.remove('drag-over');
            }
            
            uploadArea.addEventListener('drop', handleDrop, false);
            
            function handleDrop(e) {
                const dt = e.dataTransfer;
                const files = dt.files;
                
                if (files.length > 0) {
                    handleImageFile(files[0]);
                }
            }
            
            // 파일 선택 이벤트
            if (fileInput) {
                fileInput.addEventListener('change', function(e) {
                    const file = e.target.files[0];
                    if (file) {
                        handleImageFile(file);
                    }
                });
            }
            
            function handleImageFile(file) {
                // 파일 크기 검증 (5MB)
                if (file.size > 5242880) {
                    showFileError('파일 크기는 5MB를 초과할 수 없습니다.');
                    return;
                }
                
                // 파일 형식 검증
                const allowedTypes = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
                const extension = file.name.split('.').pop().toLowerCase();
                if (!allowedTypes.includes(extension)) {
                    showFileError('지원하지 않는 파일 형식입니다. (JPG, PNG, GIF, WEBP만 가능)');
                    return;
                }
                
                // 로딩 표시
                loading.classList.add('active');
                
                // 미리보기 표시
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    
                    // 파일 정보 표시
                    const sizeInKB = Math.round(file.size / 1024);
                    showFileSuccess(`선택된 파일: ${file.name} (${sizeInKB}KB)`);
                    
                    // 삭제 버튼 표시
                    removeBtn.style.display = 'flex';
                    
                    // 로딩 숨김
                    setTimeout(() => {
                        loading.classList.remove('active');
                    }, 500);
                };
                reader.readAsDataURL(file);
            }
            
            function showFileError(message) {
                fileInfo.textContent = message;
                fileInfo.className = 'file-info error';
                fileInput.value = '';
            }
            
            function showFileSuccess(message) {
                fileInfo.innerHTML = `<i class="fas fa-check-circle"></i> ${message}`;
                fileInfo.className = 'file-info success';
            }
            
            function resetFileInfo() {
                fileInfo.innerHTML = `<i class="fas fa-info-circle"></i>
                    JPG, PNG, GIF, WEBP 파일 (최대 5MB)<br>
                    드래그 앤 드롭으로도 업로드 가능합니다`;
                fileInfo.className = 'file-info';
            }
            
            // 전역 함수로 노출
            window.selectImage = function() {
                fileInput.click();
            };
            
            window.resetToDefault = function() {
                preview.src = contextPath + '/resources/images/profiles/avatar1.png';
                fileInput.value = '';
                removeBtn.style.display = 'none';
                resetFileInfo();
            };
            
            window.removeImage = function() {
                if (confirm('프로필 이미지를 삭제하시겠습니까?')) {
                    resetToDefault();
                }
            };
        }

        // 비밀번호 강도 검사 함수
        function checkPasswordStrength(password) {
            const requirements = {
                length: password.length >= 8,
                uppercase: /[A-Z]/.test(password),
                lowercase: /[a-z]/.test(password),
                number: /[0-9]/.test(password),
                special: /[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/.test(password)
            };
            
            const metCount = Object.values(requirements).filter(Boolean).length;
            
            let strength = 'weak';
            let strengthText = '약함';
            let strengthColor = 'weak';
            
            if (metCount >= 5) {
                strength = 'strong';
                strengthText = '강함';
                strengthColor = 'strong';
            } else if (metCount >= 3) {
                strength = 'medium';
                strengthText = '보통';
                strengthColor = 'medium';
            }
            
            return {
                strength,
                strengthText,
                strengthColor,
                requirements,
                isValid: metCount >= 5
            };
        }

        // 새 비밀번호 강도 UI 업데이트
        function updateNewPasswordStrength(password) {
            const strengthInfo = checkPasswordStrength(password);
            const strengthElement = document.getElementById('newPasswordStrength');
            const strengthText = document.getElementById('newStrengthText');
            const strengthLevel = document.getElementById('newStrengthLevel');
            const strengthFill = document.getElementById('newStrengthFill');
            
            if (!password) {
                if (strengthElement) strengthElement.style.display = 'none';
                return { isValid: false };
            }
            
            if (strengthElement && strengthText && strengthLevel && strengthFill) {
                strengthElement.style.display = 'block';
                strengthElement.className = `password-strength ${strengthInfo.strengthColor}`;
                strengthText.textContent = '비밀번호 강도:';
                strengthLevel.textContent = strengthInfo.strengthText;
                strengthFill.className = `strength-fill ${strengthInfo.strengthColor}`;
                
                updateNewPasswordRequirements(strengthInfo.requirements);
            }
            
            return strengthInfo;
        }

        // 새 비밀번호 요구사항 체크 표시 업데이트
        function updateNewPasswordRequirements(requirements) {
            const reqElements = {
                length: document.getElementById('new-req-length'),
                uppercase: document.getElementById('new-req-uppercase'),
                lowercase: document.getElementById('new-req-lowercase'),
                number: document.getElementById('new-req-number'),
                special: document.getElementById('new-req-special')
            };
            
            Object.keys(requirements).forEach(key => {
                const element = reqElements[key];
                if (element) {
                    const icon = element.querySelector('i');
                    if (requirements[key]) {
                        element.classList.add('met');
                        icon.className = 'fas fa-check';
                    } else {
                        element.classList.remove('met');
                        icon.className = 'fas fa-times';
                    }
                }
            });
        }

        // 비밀번호 변경 토글
        function togglePasswordChange() {
            const form = document.getElementById('passwordChangeForm');
            const icon = document.getElementById('passwordToggleIcon');
            
            if (form.classList.contains('active')) {
                form.classList.remove('active');
                icon.className = 'fas fa-chevron-down';
                // 폼 초기화
                form.querySelector('form').reset();
                document.getElementById('changePasswordBtn').disabled = true;
                clearPasswordFeedbacks();
            } else {
                form.classList.add('active');
                icon.className = 'fas fa-chevron-up';
            }
        }

        // 피드백 초기화
        function clearPasswordFeedbacks() {
            const feedbacks = ['currentPasswordFeedback', 'confirmNewPasswordFeedback'];
            feedbacks.forEach(id => {
                const element = document.getElementById(id);
                if (element) {
                    element.textContent = '';
                    element.className = 'feedback';
                }
            });
            
            const strengthElement = document.getElementById('newPasswordStrength');
            if (strengthElement) {
                strengthElement.style.display = 'none';
            }
        }

        // 비밀번호 변경 검증
        function validatePasswordChange() {
            const currentPassword = document.getElementById('currentPassword')?.value;
            const newPassword = document.getElementById('newPassword')?.value;
            const confirmPassword = document.getElementById('confirmNewPassword')?.value;
            
            if (!newPassword) return;
            
            // 새 비밀번호 강도 체크
            const strengthInfo = updateNewPasswordStrength(newPassword);
            
            // 비밀번호 확인 체크
            const confirmFeedback = document.getElementById('confirmNewPasswordFeedback');
            if (confirmFeedback && confirmPassword) {
                if (newPassword === confirmPassword) {
                    if (strengthInfo.isValid) {
                        confirmFeedback.className = 'feedback valid';
                        confirmFeedback.textContent = '비밀번호가 일치하며 보안 요구사항을 충족합니다';
                    } else {
                        confirmFeedback.className = 'feedback invalid';
                        confirmFeedback.textContent = '비밀번호가 일치하지만 보안 요구사항을 충족하지 않습니다';
                    }
                } else {
                    confirmFeedback.className = 'feedback invalid';
                    confirmFeedback.textContent = '비밀번호가 일치하지 않습니다';
                }
            }
            
            // 버튼 활성화 조건
            const isValid = currentPassword && 
                           strengthInfo.isValid && 
                           newPassword === confirmPassword;
            
            const changeBtn = document.getElementById('changePasswordBtn');
            if (changeBtn) {
                changeBtn.disabled = !isValid;
            }
        }

        // 비밀번호 보안 설정
        function setupPasswordSecurity() {
            const newPasswordInput = document.getElementById('newPassword');
            const confirmNewPasswordInput = document.getElementById('confirmNewPassword');
            const currentPasswordInput = document.getElementById('currentPassword');
            
            if (newPasswordInput) {
                newPasswordInput.addEventListener('input', validatePasswordChange);
            }
            if (confirmNewPasswordInput) {
                confirmNewPasswordInput.addEventListener('input', validatePasswordChange);
            }
            if (currentPasswordInput) {
                currentPasswordInput.addEventListener('input', validatePasswordChange);
            }
        }

        // 소셜 계정 이벤트 설정
        function setupSocialAccountEvents() {
            // 소셜 계정 연동 해제 이벤트 리스너
            document.querySelectorAll('.unlink-social-btn').forEach(function(btn) {
                btn.addEventListener('click', function() {
                    var provider = this.dataset.provider;
                    
                    var confirmMessage = provider + ' 계정 연동을 해제하시겠습니까?\n\n' +
                                       '해제 후에는 ' + provider + '로 로그인할 수 없습니다.';
                    
                    if (confirm(confirmMessage)) {
                        unlinkSocialAccount(provider);
                    }
                });
            });
        }
        
        // 소셜 계정 연동 해제 함수 - 보안 강화
        function unlinkSocialAccount(provider) {
            // 클라이언트 레벨 보안 검증
            if (isSocialOnlyUser && connectedSocialCount <= 1) {
                alert('소셜 전용 계정은 마지막 소셜 계정을 해제할 수 없습니다.\n\n' +
                      '해결방법:\n' +
                      '1. 다른 소셜 계정을 먼저 연동하거나\n' +
                      '2. 비밀번호를 설정하여 일반 계정으로 전환하세요.');
                return;
            }
            
            fetch(contextPath + '/user/unlinkSocial', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'provider=' + encodeURIComponent(provider)
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.success) {
                    window.showAlert('성공: ' + data.message, 'success');
                    connectedSocialCount--; // 카운트 업데이트
                    location.reload(); // 페이지 새로고침
                } else {
                    // 에러 유형별 맞춤 메시지
                    var errorMsg = '연동 해제 실패\n\n';
                    if (data.isSocialOnly) {
                        errorMsg += '보안 경고: ' + data.message + '\n\n' +
                                   '해결방법:\n' +
                                   '1. 다른 소셜 계정을 먼저 연동하거나\n' +
                                   '2. 일반 로그인용 비밀번호를 설정하세요.';
                    } else {
                        errorMsg += data.message;
                    }
                    alert(errorMsg);
                }
            })
            .catch(function(error) {
                console.error('Error:', error);
                alert('연동 해제 중 오류가 발생했습니다.\n네트워크 연결을 확인해주세요.');
            });
        }
        
        console.log('모든 스크립트 로드 완료');
    </script>
>>>>>>> b65c320 (Initial commit)
</body>
</html>