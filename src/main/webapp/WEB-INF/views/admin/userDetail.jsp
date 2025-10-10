<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원 상세 정보 | 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 - 틸 */
        .page-header {
            background: linear-gradient(135deg, #20c997, #17a085);
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
        
        /* 기본 스타일 */
        :root {
            --primary-color: #20c997;
            --ink: #0F172A;
            --muted: #5B6170;
            --line: #E7E0D6;
            --shadow: 0 8px 25px rgba(15,23,42,0.1);
        }
        
        .detail-card {
            background: white;
            border-radius: 20px;
            padding: 35px;
            margin-bottom: 30px;
            box-shadow: var(--shadow);
            border: 2px solid #f8f9fa;
            transition: all 0.3s ease;
        }
        
        .detail-card:hover {
            border-color: var(--primary-color);
            box-shadow: 0 12px 35px rgba(15,23,42,0.15);
        }
        
        .profile-section {
            text-align: center;
            padding: 50px 0;
            border-bottom: 3px solid #f8f9fa;
            margin-bottom: 35px;
            background: linear-gradient(135deg, #f8f9ff, #ffffff);
            border-radius: 15px;
        }
        
        .profile-icon {
            font-size: 8rem;
            color: var(--primary-color);
            opacity: 0.8;
            margin-bottom: 25px;
        }
        
        .profile-name {
            font-size: 2rem;
            font-weight: 800;
            color: var(--ink);
            margin-bottom: 10px;
        }
        
        .profile-username {
            font-size: 1.2rem;
            color: var(--muted);
            margin-bottom: 20px;
        }
        
        .badge-container {
            display: flex;
            justify-content: center;
            gap: 12px;
            flex-wrap: wrap;
        }
        
        .custom-badge {
            font-size: 0.9rem;
            padding: 10px 18px;
            border-radius: 25px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .info-grid {
            display: grid;
            gap: 20px;
        }
        
        .info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
            border-bottom: 2px solid #f8f9fa;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 700;
            color: var(--ink);
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1rem;
        }
        
        .info-value {
            color: var(--muted);
            text-align: right;
            font-weight: 600;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
        }
        
        .stat-card {
            text-align: center;
            padding: 30px 25px;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 15px;
            border: 2px solid transparent;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(15,23,42,0.08);
        }
        
        .stat-card:hover {
            border-color: var(--primary-color);
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(15,23,42,0.15);
        }
        
        .stat-number {
            font-size: 2.8rem;
            font-weight: 900;
            color: var(--primary-color);
            margin-bottom: 12px;
        }
        
        .stat-label {
            color: var(--muted);
            font-weight: 600;
            font-size: 1rem;
        }
        
        .section-title {
            color: var(--ink);
            font-weight: 800;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 4px solid var(--primary-color);
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.3rem;
        }
        
        .action-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }
        
        .btn {
            border-radius: 12px;
            font-weight: 700;
            padding: 15px 25px;
            transition: all 0.3s ease;
            border-width: 2px;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        
        .btn-success {
            background: linear-gradient(135deg, #28a745, #20c997);
            border-color: transparent;
        }
        
        .btn-success:hover {
            background: linear-gradient(135deg, #20c997, #17a085);
            border-color: transparent;
        }
        
        .btn-warning {
            background: linear-gradient(135deg, #ffc107, #fd7e14);
            border-color: transparent;
            color: #0F172A;
        }
        
        .btn-warning:hover {
            background: linear-gradient(135deg, #fd7e14, #e5650a);
            border-color: transparent;
            color: white;
        }
        
        .btn-info {
            background: linear-gradient(135deg, #17a2b8, #6610f2);
            border-color: transparent;
        }
        
        .btn-info:hover {
            background: linear-gradient(135deg, #6610f2, #5a0fcf);
            border-color: transparent;
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #6c757d, #495057);
            border-color: transparent;
        }
        
        .btn-secondary:hover {
            background: linear-gradient(135deg, #495057, #343a40);
            border-color: transparent;
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #dc3545, #c82333);
            border-color: transparent;
        }
        
        .btn-danger:hover {
            background: linear-gradient(135deg, #c82333, #bd2130);
            border-color: transparent;
        }
        
        .btn-outline-light {
            border-color: rgba(255,255,255,0.3);
            color: white;
            font-weight: 600;
        }
        
        .btn-outline-light:hover {
            background: rgba(255,255,255,0.2);
            border-color: white;
            color: white;
        }
        
        .btn-light {
            background: rgba(255,255,255,0.9);
            border: none;
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .btn-light:hover {
            background: white;
            color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        
        .btn-outline-secondary {
            color: #6c757d;
            border-color: #6c757d;
            font-weight: 600;
        }
        
        .btn-outline-secondary:hover {
            background: #6c757d;
            border-color: #6c757d;
        }
        
        .empty-info {
            color: var(--muted);
            font-style: italic;
            opacity: 0.8;
        }
        
        /* Toast 스타일 */
        .toast {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .toast-header {
            background: linear-gradient(135deg, var(--primary-color), #17a085);
            color: white;
            border-bottom: none;
            border-radius: 15px 15px 0 0;
        }
        
        .toast-header .btn-close {
            filter: invert(1);
        }
        
        .toast-body {
            padding: 20px;
            font-weight: 600;
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
            
            .profile-section {
                padding: 40px 20px;
            }
            
            .profile-icon {
                font-size: 6rem;
            }
            
            .profile-name {
                font-size: 1.6rem;
            }
            
            .profile-username {
                font-size: 1rem;
            }
            
            .info-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
            
            .info-value {
                text-align: left;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
            
            .detail-card {
                padding: 25px 20px;
            }
            
            .stat-card {
                padding: 25px 20px;
            }
            
            .stat-number {
                font-size: 2.2rem;
            }
        }
        
        /* 애니메이션 */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .detail-card {
            animation: fadeInUp 0.6s ease-out;
        }
        
        .detail-card:nth-child(2) { animation-delay: 0.1s; }
        .detail-card:nth-child(3) { animation-delay: 0.2s; }
        .detail-card:nth-child(4) { animation-delay: 0.3s; }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div style="background: yellow; padding: 10px; margin: 10px 0;">
    <strong>디버깅 정보:</strong><br>
    URL userNum: ${param.userNum}<br>
    Model user.userNum: ${user.userNum}<br>
    Model user.userId: ${user.userId}<br>
    Session userNum: ${sessionScope.userNum}<br>
    Session userId: ${sessionScope.userId}
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
                        <a href="${pageContext.request.contextPath}/admin/dashboard">관리자</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/admin/users">회원 관리</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">회원 상세정보</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">회원 상세 정보</h2>
                    <p class="lead">회원의 상세 정보와 활동 현황을 확인할 수 있습니다</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/admin/users" 
                       class="btn btn-light btn-lg me-2">
                        <i class="fas fa-users me-2"></i>회원 목록
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" 
                       class="btn btn-outline-light btn-lg">
                        <i class="fas fa-tachometer-alt me-2"></i>대시보드
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <!-- 프로필 정보 -->
        <div class="detail-card">
            <div class="profile-section">
                <i class="fas fa-user-circle profile-icon"></i>
                <h3 class="profile-name">${user.username}</h3>
                <p class="profile-username">@${user.userId}</p>
                
                <div class="badge-container">
                    <span class="badge custom-badge ${user.userRole == 'ADMIN' ? 'bg-danger text-white' : 'bg-info text-white'}">
                        <i class="fas ${user.userRole == 'ADMIN' ? 'fa-crown' : 'fa-user'}"></i>
                        ${user.userRole == 'ADMIN' ? '관리자' : '일반회원'}
                    </span>
                    
                    <span class="badge custom-badge ${user.status == 'ACTIVE' ? 'bg-success text-white' : 
                          user.status == 'SUSPENDED' ? 'bg-warning text-dark' : 'bg-secondary text-white'}">
                        <i class="fas ${user.status == 'ACTIVE' ? 'fa-check-circle' : 
                               user.status == 'SUSPENDED' ? 'fa-pause-circle' : 'fa-times-circle'}"></i>
                        <c:choose>
                            <c:when test="${user.status == 'ACTIVE'}">활성</c:when>
                            <c:when test="${user.status == 'SUSPENDED'}">정지</c:when>
                            <c:otherwise>비활성</c:otherwise>
                        </c:choose>
                    </span>
                    
                    <c:if test="${user.accountType == 'SOCIAL'}">
                        <span class="badge custom-badge bg-primary text-white">
                            <i class="fas fa-share-alt"></i>
                            소셜 계정
                        </span>
                    </c:if>
                </div>
            </div>
            
            <!-- 기본 정보 -->
            <h5 class="section-title">
                <i class="fas fa-info-circle"></i>기본 정보
            </h5>
            
            <div class="info-grid">
                <div class="info-row">
                    <span class="info-label">
                        <i class="fas fa-hashtag text-muted"></i>사용자 번호
                    </span>
                    <span class="info-value fw-bold">#${user.userNum}</span>
                </div>
                
                <div class="info-row">
                    <span class="info-label">
                        <i class="fas fa-envelope text-muted"></i>이메일
                    </span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${not empty user.email}">${user.email}</c:when>
                            <c:otherwise><span class="empty-info">등록되지 않음</span></c:otherwise>
                        </c:choose>
                    </span>
                </div>
                
                <div class="info-row">
                    <span class="info-label">
                        <i class="fas fa-phone text-muted"></i>전화번호
                    </span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${not empty user.phone}">${user.phone}</c:when>
                            <c:otherwise><span class="empty-info">등록되지 않음</span></c:otherwise>
                        </c:choose>
                    </span>
                </div>
                
                <div class="info-row">
                    <span class="info-label">
                        <i class="fas fa-venus-mars text-muted"></i>성별
                    </span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${user.gender == 'M'}">남성</c:when>
                            <c:when test="${user.gender == 'F'}">여성</c:when>
                            <c:otherwise><span class="empty-info">등록되지 않음</span></c:otherwise>
                        </c:choose>
                    </span>
                </div>
                
                <div class="info-row">
                    <span class="info-label">
                        <i class="fas fa-calendar-plus text-muted"></i>가입일
                    </span>
                    <span class="info-value">${user.formattedJoinDate}</span>
                </div>
                
                <div class="info-row">
                    <span class="info-label">
                        <i class="fas fa-credit-card text-muted"></i>계정 유형
                    </span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${user.accountType == 'SOCIAL'}">소셜 계정</c:when>
                            <c:otherwise>일반 계정</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </div>
        
        <!-- 활동 통계 -->
        <div class="detail-card">
            <h5 class="section-title">
                <i class="fas fa-chart-bar"></i>활동 통계
            </h5>
            
            <div class="stats-grid">
                <div class="stat-card">
                    <i class="fas fa-ticket-alt text-primary mb-3" style="font-size: 2.5rem;"></i>
                    <div class="stat-number">${user.totalPasses}</div>
                    <div class="stat-label">보유 패스권</div>
                </div>
                
                <div class="stat-card">
                    <i class="fas fa-walking text-success mb-3" style="font-size: 2.5rem;"></i>
                    <div class="stat-number">${user.totalVisits}</div>
                    <div class="stat-label">총 방문 횟수</div>
                </div>
                
                <div class="stat-card">
                    <i class="fas fa-calendar-week text-warning mb-3" style="font-size: 2.5rem;"></i>
                    <div class="stat-number">
                        <c:choose>
                            <c:when test="${user.totalVisits > 0}">
                                <fmt:formatNumber value="${(user.totalVisits / 30.0)}" pattern="#.#" />
                            </c:when>
                            <c:otherwise>0</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-label">월평균 방문</div>
                </div>
                
                <div class="stat-card">
                    <i class="fas ${user.status == 'ACTIVE' ? 'fa-heart text-success' : 'fa-heart-broken text-danger'} mb-3" style="font-size: 2.5rem;"></i>
                    <div class="stat-number">
                        <c:choose>
                            <c:when test="${user.status == 'ACTIVE'}">
                                <i class="fas fa-check-circle text-success"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="fas fa-times-circle text-danger"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-label">계정 상태</div>
                </div>
            </div>
        </div>
        
        <!-- 관리 기능 -->
        <div class="detail-card">
            <h5 class="section-title">
                <i class="fas fa-cogs"></i>관리 기능
            </h5>
            
            <div class="action-buttons">
                <button class="btn btn-success" onclick="updateStatus(${user.userNum}, 'ACTIVE')">
                    <i class="fas fa-check-circle me-2"></i>계정 활성화
                </button>
                
                <button class="btn btn-warning" onclick="updateStatus(${user.userNum}, 'SUSPENDED')">
                    <i class="fas fa-pause-circle me-2"></i>계정 정지
                </button>
                
                <c:if test="${user.userRole != 'ADMIN'}">
                    <button class="btn btn-info" onclick="updateRole(${user.userNum}, 'ADMIN')">
                        <i class="fas fa-crown me-2"></i>관리자로 승격
                    </button>
                </c:if>
                
                <c:if test="${user.userRole == 'ADMIN'}">
                    <button class="btn btn-secondary" onclick="updateRole(${user.userNum}, 'USER')">
                        <i class="fas fa-user me-2"></i>일반회원으로 변경
                    </button>
                </c:if>
                
                <button class="btn btn-danger" onclick="deleteUser(${user.userNum})">
                    <i class="fas fa-trash me-2"></i>계정 삭제
                </button>
            </div>
        </div>
    </div>
    
    <!-- Toast 알림 -->
    <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 11;">
        <div id="liveToast" class="toast" role="alert">
            <div class="toast-header">
                <i class="fas fa-bell me-2"></i>
                <strong class="me-auto">알림</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast"></button>
            </div>
            <div class="toast-body" id="toastMessage"></div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function showToast(message, isSuccess = true) {
            const toast = new bootstrap.Toast(document.getElementById('liveToast'));
            const toastHeader = document.querySelector('#liveToast .toast-header i');
            const toastMessage = document.getElementById('toastMessage');
            
            toastMessage.textContent = message;
            toastHeader.className = isSuccess ? 
                'fas fa-check-circle me-2' : 
                'fas fa-exclamation-triangle me-2';
            
            toast.show();
        }
        
        function updateStatus(userNum, status) {
            const statusText = status === 'ACTIVE' ? '활성화' : '정지';
            
            if (!confirm(`정말로 이 회원을 ${statusText} 상태로 변경하시겠습니까?`)) {
                return;
            }
            
            fetch('${pageContext.request.contextPath}/admin/users/updateStatus', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: `userNum=${userNum}&status=${status}`
            })
            .then(response => response.json())
            .then(data => {
                showToast(data.message, data.success);
                if (data.success) {
                    setTimeout(() => location.reload(), 1500);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('오류가 발생했습니다.', false);
            });
        }
        
        function updateRole(userNum, userRole) {
            const roleText = userRole === 'ADMIN' ? '관리자' : '일반회원';
            
            if (!confirm(`정말로 이 회원의 역할을 ${roleText}로 변경하시겠습니까?`)) {
                return;
            }
            
            fetch('${pageContext.request.contextPath}/admin/users/updateRole', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: `userNum=${userNum}&userRole=${userRole}`
            })
            .then(response => response.json())
            .then(data => {
                showToast(data.message, data.success);
                if (data.success) {
                    setTimeout(() => location.reload(), 1500);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('오류가 발생했습니다.', false);
            });
        }
        
        function deleteUser(userNum) {
            if (!confirm('정말로 이 회원을 삭제하시겠습니까?\n삭제된 회원은 복구할 수 없습니다.')) {
                return;
            }
            
            if (!confirm('삭제 작업은 되돌릴 수 없습니다. 정말 진행하시겠습니까?')) {
                return;
            }
            
            fetch('${pageContext.request.contextPath}/admin/users/delete', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: `userNum=${userNum}`
            })
            .then(response => response.json())
            .then(data => {
                showToast(data.message, data.success);
                if (data.success) {
                    setTimeout(() => {
                        window.location.href = '${pageContext.request.contextPath}/admin/users';
                    }, 2000);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showToast('오류가 발생했습니다.', false);
            });
        }
        
        // 페이지 로드 애니메이션
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.detail-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(30px)';
                
                setTimeout(() => {
                    card.style.transition = 'all 0.6s ease';
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }, index * 150);
            });
        });
    </script>
</body>
</html>