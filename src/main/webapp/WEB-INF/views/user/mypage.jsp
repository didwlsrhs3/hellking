<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>마이페이지 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<<<<<<< HEAD
    <style>
        :root {
=======
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 - 보라색 */
        .page-header {
            background: linear-gradient(135deg, #667eea, #764ba2);
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
            --primary-color: #667eea;
>>>>>>> b65c320 (Initial commit)
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
        }
<<<<<<< HEAD
        body { background: var(--bg-cream); }
        .profile-header {
            background: linear-gradient(135deg, var(--brand), #ff8533);
=======
        
        .profile-header {
            background: linear-gradient(135deg, var(--primary-color), #764ba2);
>>>>>>> b65c320 (Initial commit)
            color: white;
            padding: 40px 0;
            border-radius: 20px 20px 0 0;
        }
<<<<<<< HEAD
=======
        
>>>>>>> b65c320 (Initial commit)
        .profile-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid white;
            object-fit: cover;
        }
<<<<<<< HEAD
=======
        
>>>>>>> b65c320 (Initial commit)
        .pass-card {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            border-radius: 16px;
            padding: 24px;
            margin: 20px 0;
        }
<<<<<<< HEAD
        .pass-expired {
            background: linear-gradient(135deg, #6c757d, #5a6268);
        }
=======
        
        .pass-expired {
            background: linear-gradient(135deg, #6c757d, #5a6268);
        }
        
>>>>>>> b65c320 (Initial commit)
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(15,23,42,0.1);
        }
<<<<<<< HEAD
        .quick-action {
            background: white;
            border: 2px solid var(--brand);
            color: var(--brand);
=======
        
        .quick-action {
            background: white;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
>>>>>>> b65c320 (Initial commit)
            border-radius: 12px;
            padding: 12px 20px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s;
        }
<<<<<<< HEAD
        .quick-action:hover {
            background: var(--brand);
            color: white;
        }
=======
        
        .quick-action:hover {
            background: var(--primary-color);
            color: white;
        }
        
        /* 소셜 계정 관리 스타일 */
        .social-accounts-section {
            background: white;
            border-radius: 16px;
            padding: 24px;
            margin: 20px 0;
            box-shadow: 0 2px 10px rgba(15,23,42,0.1);
        }
        
        .social-account-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 16px;
            border: 1px solid #E7E0D6;
            border-radius: 12px;
            margin-bottom: 8px;
            transition: all 0.2s;
        }
        
        .social-account-item:hover {
            border-color: var(--primary-color);
            background: rgba(102, 126, 234, 0.05);
        }
        
        .social-account-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .social-icon {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            font-weight: bold;
        }
        
        .social-icon-naver {
            background: #03C75A;
            color: white;
        }
        
        .social-icon-kakao {
            background: #FEE500;
            color: #191919;
        }
        
        .social-icon-google {
            background: #4285F4;
            color: white;
        }
        
        .social-account-connected {
            color: #28a745;
            font-weight: 600;
            font-size: 14px;
        }
        
        .social-account-not-connected {
            color: #6c757d;
            font-size: 14px;
        }
        
        .btn-unlink {
            background: #dc3545;
            border: none;
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
        }
        
        .btn-unlink:hover {
            background: #c82333;
        }
        
        .btn-link-social {
            background: var(--primary-color);
            border: none;
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            cursor: pointer;
        }
        
        .btn-link-social:hover {
            background: #5a6fd8;
        }
        
        .btn-unlink:disabled {
            background: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
        }
        
        .btn-unlink:disabled:hover {
            background: #6c757d;
        }
        
        .badge {
            font-size: 10px;
            padding: 3px 6px;
        }
        
        .alert-info {
            background-color: #e3f2fd;
            border-color: #2196f3;
            color: #1976d2;
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
        }
>>>>>>> b65c320 (Initial commit)
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
<<<<<<< HEAD
    <div class="container mt-4">
=======
    <!-- 통일된 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/">홈</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">마이페이지</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">마이페이지</h2>
                    <p class="lead">작성하신 정보와 활동 현황을 확인하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/user/edit" 
                       class="btn btn-light btn-lg">
                        <i class="fas fa-edit me-2"></i>정보수정
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
>>>>>>> b65c320 (Initial commit)
        <!-- 프로필 헤더 -->
        <div class="row">
            <div class="col-12">
                <div class="profile-header text-center">
<<<<<<< HEAD
                    <img src="${pageContext.request.contextPath}/resources/images/profiles/${user.profileImage}" 
                         alt="프로필" class="profile-img mb-3">
                    <h2>${user.username}님</h2>
                    <p class="mb-0">${user.email}</p>
=======
                    <c:choose>
                        <c:when test="${user.profileImage != null and !user.profileImage.startsWith('http')}">
                            <img src="${pageContext.request.contextPath}/upload/${user.profileImage}" 
                                 alt="프로필" class="profile-img mb-3">
                        </c:when>
                        <c:when test="${user.profileImage != null and user.profileImage.startsWith('http')}">
                            <img src="${user.profileImage}" 
                                 alt="프로필" class="profile-img mb-3" 
                                 onerror="this.src='${pageContext.request.contextPath}/resources/images/profiles/avatar1.png'">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/resources/images/profiles/avatar1.png" 
                                 alt="프로필" class="profile-img mb-3">
                        </c:otherwise>
                    </c:choose>
                    <h2>${user.username}님</h2>
                    <c:if test="${not empty user.email}">
                        <p class="mb-0">${user.email}</p>
                    </c:if>
>>>>>>> b65c320 (Initial commit)
                    <p class="small">가입일: <fmt:formatDate value="${user.joinDate}" pattern="yyyy.MM.dd"/></p>
                </div>
            </div>
        </div>
        
        <!-- 활성 패스권 정보 -->
        <div class="row mt-4">
            <div class="col-12">
                <c:choose>
<<<<<<< HEAD
                    <c:when test="${not empty user.passName}">
                        <div class="pass-card">
                            <h5>활성 패스권</h5>
                            <h4>${user.passName}</h4>
                            <p class="mb-0">만료일: <fmt:formatDate value="${user.passEndDate}" pattern="yyyy년 MM월 dd일"/></p>
                            <small>전국 모든 헬킹 가맹점에서 자유롭게 이용하세요!</small>
                        </div>
=======
                    <c:when test="${not empty activePasses}">
                        <c:forEach var="pass" items="${activePasses}" begin="0" end="0">
                            <div class="pass-card">
                                <h5>활성 패스권</h5>
                                <h4>${pass.passName}</h4>
                                <p class="mb-0">만료일: <fmt:formatDate value="${pass.endDate}" pattern="yyyy년 MM월 dd일"/></p>
                                <small>전국 모든 헬킹 가맹점에서 자유롭게 이용하세요!</small>
                            </div>
                        </c:forEach>
>>>>>>> b65c320 (Initial commit)
                    </c:when>
                    <c:otherwise>
                        <div class="pass-card pass-expired">
                            <h5>패스권 없음</h5>
                            <p class="mb-0">현재 활성화된 패스권이 없습니다.</p>
                            <a href="${pageContext.request.contextPath}/pass/list" class="btn btn-light mt-2">패스권 구매하기</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
<<<<<<< HEAD
=======
        <!-- 소셜 계정 관리 섹션 -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="social-accounts-section">
                    <h5 class="mb-3">연동된 소셜 계정</h5>
                    <div id="socialAccountsList">
                        <!-- 소셜 계정 목록이 JavaScript로 동적 로드됩니다 -->
                        <div class="text-center p-3">
                            <div class="spinner-border text-primary" role="status">
                                <span class="visually-hidden">로딩중...</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
>>>>>>> b65c320 (Initial commit)
        <!-- 통계 카드 -->
        <div class="row mt-4">
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <h3 class="text-primary">12</h3>
                    <p class="mb-0">이번 달 방문</p>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <h3 class="text-success">8</h3>
                    <p class="mb-0">방문한 가맹점</p>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="stat-card">
                    <h3 class="text-warning">36</h3>
                    <p class="mb-0">총 운동일</p>
                </div>
            </div>
        </div>
        
        <!-- 퀵 액션 -->
        <div class="row mt-4">
            <div class="col-12">
                <h5 class="mb-3">빠른 액션</h5>
            </div>
            <div class="col-md-3 mb-2">
                <a href="${pageContext.request.contextPath}/qr/enter" class="quick-action d-block text-center">
                    QR 입장
                </a>
            </div>
            <div class="col-md-3 mb-2">
                <a href="${pageContext.request.contextPath}/pass/mypass" class="quick-action d-block text-center">
                    내 패스권
                </a>
            </div>
            <div class="col-md-3 mb-2">
                <a href="${pageContext.request.contextPath}/qr/history" class="quick-action d-block text-center">
                    방문 기록
                </a>
            </div>
            <div class="col-md-3 mb-2">
                <a href="${pageContext.request.contextPath}/user/edit" class="quick-action d-block text-center">
                    정보 수정
                </a>
            </div>
        </div>
        
        <!-- 최근 활동 -->
        <div class="row mt-5">
            <div class="col-12">
                <h5 class="mb-3">최근 활동</h5>
                <div class="bg-white p-3 rounded">
<<<<<<< HEAD
                    <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                        <div>
                            <strong>강남점</strong> 방문
                            <small class="text-muted">2시간 전</small>
                        </div>
                        <span class="badge bg-success">완료</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                        <div>
                            <strong>30일권</strong> 구매
                            <small class="text-muted">1일 전</small>
                        </div>
                        <span class="badge bg-primary">결제완료</span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center py-2">
                        <div>
                            <strong>홍대점</strong> 방문
                            <small class="text-muted">3일 전</small>
                        </div>
                        <span class="badge bg-success">완료</span>
                    </div>
=======
                    <c:choose>
                        <c:when test="${not empty recentPasses}">
                            <c:forEach var="pass" items="${recentPasses}" end="2">
                                <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                                    <div>
                                        <strong>${pass.passName}</strong> 구매
                                        <small class="text-muted">
                                            <fmt:formatDate value="${pass.purchaseDate}" pattern="MM월 dd일"/>
                                        </small>
                                    </div>
                                    <span class="badge bg-primary">결제완료</span>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center text-muted py-4">
                                아직 활동 기록이 없습니다.
                            </div>
                        </c:otherwise>
                    </c:choose>
>>>>>>> b65c320 (Initial commit)
                </div>
            </div>
        </div>
    </div>
    
<<<<<<< HEAD
=======
    <script>
        // 페이지 로드 시 소셜 계정 목록 로드
        document.addEventListener('DOMContentLoaded', function() {
            loadSocialAccounts();
        });
        
        // 소셜 계정 목록 로드
        function loadSocialAccounts() {
            fetch('${pageContext.request.contextPath}/user/getSocialAccounts')
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        displaySocialAccounts(data.socialAccounts || [], data.currentProvider, data.isSocialUser);
                    } else {
                        console.error('소셜 계정 목록 로드 실패:', data.message);
                        displaySocialAccountsError();
                    }
                })
                .catch(error => {
                    console.error('소셜 계정 목록 로드 오류:', error);
                    displaySocialAccountsError();
                });
        }
        
        // 소셜 계정 목록 표시 - 보안 강화 버전
        function displaySocialAccounts(accounts, currentProvider, isSocialUser) {
            var container = document.getElementById('socialAccountsList');
            var providers = [
                { name: 'NAVER', display: '네이버', icon: 'N', cssClass: 'naver' },
                { name: 'KAKAO', display: '카카오', icon: 'K', cssClass: 'kakao' },
                { name: 'GOOGLE', display: '구글', icon: 'G', cssClass: 'google' }
            ];
            
            var html = '';
            var connectedCount = accounts.length;
            
            providers.forEach(function(provider) {
                var account = accounts.find(function(acc) { return acc.provider === provider.name; });
                var isCurrentProvider = currentProvider && currentProvider.toUpperCase() === provider.name;
                var isLastSocialAccount = isSocialUser && connectedCount === 1 && account;
                
                html += '<div class="social-account-item">' +
                    '<div class="social-account-info">' +
                        '<div class="social-icon social-icon-' + provider.cssClass + '">' + provider.icon + '</div>' +
                        '<div>' +
                            '<div class="fw-bold">' +
                                provider.display +
                                (isCurrentProvider ? '<span class="current-provider">현재 로그인</span>' : '') +
                                (isLastSocialAccount ? '<span class="badge bg-warning text-dark ms-2">마지막 계정</span>' : '') +
                            '</div>' +
                            (account ? 
                                '<div class="social-account-connected">연동됨' +
                                    (account.createdAt ? ' <small class="text-muted">(' + formatDate(account.createdAt) + ')</small>' : '') +
                                '</div>' : 
                                '<div class="social-account-not-connected">연동되지 않음</div>'
                            ) +
                        '</div>' +
                    '</div>' +
                    '<div>' +
                        (account ? 
                            (isCurrentProvider ? 
                                '<span class="text-muted small">현재 계정</span>' :
                                (isLastSocialAccount ? 
                                    '<button class="btn-unlink" disabled title="마지막 소셜 계정은 해제할 수 없습니다">해제불가</button>' :
                                    '<button class="btn-unlink" onclick="unlinkSocialAccount(\'' + provider.name + '\')">연동해제</button>'
                                )
                            ) :
                            '<button class="btn-link-social" onclick="linkSocialAccount(\'' + provider.name.toLowerCase() + '\')">연동하기</button>'
                        ) +
                    '</div>' +
                '</div>';
            });
            
            // 소셜 전용 계정인 경우 안내 메시지 추가
            if (isSocialUser) {
                html += '<div class="alert alert-info mt-3">' +
                    '<small><i class="fas fa-info-circle"></i> ' +
                    '소셜 전용 계정입니다. 최소 하나의 소셜 계정은 연결되어 있어야 로그인할 수 있습니다.' +
                    '</small></div>';
            }
            
            container.innerHTML = html;
        }
        
        // 소셜 계정 목록 로드 오류 표시
        function displaySocialAccountsError() {
            const container = document.getElementById('socialAccountsList');
            container.innerHTML = '<div class="text-center text-muted p-3">' +
                '소셜 계정 정보를 불러올 수 없습니다.' +
                '<br>' +
                '<button class="btn btn-sm btn-outline-primary mt-2" onclick="loadSocialAccounts()">다시 시도</button>' +
            '</div>';
        }
        
        // 소셜 계정 연동 해제 함수 - 보안 강화 버전
        function unlinkSocialAccount(provider) {
            var displayName = getProviderDisplayName(provider);
            
            // 추가 확인 메시지
            var confirmMessage = displayName + ' 계정 연동을 해제하시겠습니까?\n\n' +
                '⚠️ 주의: 소셜 전용 계정의 경우 마지막 소셜 계정을 해제하면 로그인할 수 없게 됩니다.';
            
            if (!confirm(confirmMessage)) {
                return;
            }
            
            var formData = new FormData();
            formData.append('provider', provider);
            
            fetch('${pageContext.request.contextPath}/user/unlinkSocial', {
                method: 'POST',
                body: formData
            })
            .then(function(response) {
                return response.json();
            })
            .then(function(data) {
                if (data.success) {
                    alert('✅ ' + data.message);
                    loadSocialAccounts(); // 목록 새로고침
                } else {
                    // 에러 유형별 다른 메시지
                    var errorMsg = '❌ 연동 해제 실패\n\n';
                    if (data.isSocialOnly) {
                        errorMsg += '🔒 ' + data.message + '\n\n' +
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
                console.error('연동 해제 오류:', error);
                alert('❌ 연동 해제 중 오류가 발생했습니다.\n네트워크 연결을 확인해주세요.');
            });
        }
        
        // 날짜 포맷팅 함수 추가
        function formatDate(dateString) {
            try {
                var date = new Date(dateString);
                var year = date.getFullYear();
                var month = String(date.getMonth() + 1).padStart(2, '0');
                var day = String(date.getDate()).padStart(2, '0');
                return year + '.' + month + '.' + day;
            } catch (e) {
                return '';
            }
        }
        
        // 소셜 계정 연동 시작 함수 수정
        function linkSocialAccount(provider) {
            window.location.href = '${pageContext.request.contextPath}/oauth/' + provider;
        }
        
        // 소셜 제공자 표시명 반환 함수 수정
        function getProviderDisplayName(provider) {
            if (provider === 'NAVER') return '네이버';
            if (provider === 'KAKAO') return '카카오';
            if (provider === 'GOOGLE') return '구글';
            return provider;
        }
    </script>
    
>>>>>>> b65c320 (Initial commit)
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>