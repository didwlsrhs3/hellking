<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원 관리 | 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 - 인디고 */
        .page-header {
            background: linear-gradient(135deg, #6610f2, #5a0fcf);
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
            --primary-color: #6610f2;
            --ink: #0F172A;
            --muted: #5B6170;
            --line: #E7E0D6;
        }
        
        .stats-card {
            background: white;
            border-radius: 15px;
            padding: 25px 20px;
            margin-bottom: 25px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            border: 2px solid transparent;
            text-align: center;
            transition: all 0.3s ease;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(15,23,42,0.15);
            border-color: var(--primary-color);
        }
        
        .search-bar {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            border: 2px solid #f8f9fa;
        }
        
        .user-table {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            border: 2px solid #f8f9fa;
        }
        
        .table th {
            border-top: none;
            border-bottom: 3px solid var(--line);
            font-weight: 700;
            color: var(--ink);
            padding: 18px 12px;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            font-size: 0.9rem;
        }
        
        .table td {
            padding: 18px 12px;
            vertical-align: middle;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .table tbody tr:hover {
            background: linear-gradient(135deg, #f8f9ff, #ffffff);
        }
        
        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--line);
        }
        
        .status-badge {
            font-size: 0.8rem;
            padding: 6px 12px;
            border-radius: 15px;
            font-weight: 600;
        }
        
        .btn-action {
            padding: 8px 12px;
            font-size: 0.8rem;
            margin: 2px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.2s ease;
        }
        
        .btn-action:hover {
            transform: translateY(-1px);
        }
        
        .pagination {
            justify-content: center;
            margin-top: 25px;
        }
        
        .page-link {
            color: var(--primary-color);
            border: 2px solid #dee2e6;
            padding: 10px 16px;
            margin: 0 2px;
            border-radius: 8px;
            font-weight: 600;
        }
        
        .page-link:hover {
            color: white;
            background: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .page-item.active .page-link {
            background: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: 900;
            margin-bottom: 8px;
        }
        
        .stat-label {
            color: var(--muted);
            font-weight: 600;
        }
        
        .search-title {
            color: var(--ink);
            font-weight: 700;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .table-title {
            color: var(--ink);
            font-weight: 700;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-control {
            border: 2px solid #dee2e6;
            border-radius: 10px;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(102, 16, 242, 0.15);
        }
        
        .btn-primary {
            background: var(--primary-color);
            border-color: var(--primary-color);
            font-weight: 600;
            padding: 12px 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: #5a0fcf;
            border-color: #5a0fcf;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 16, 242, 0.3);
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
        
        /* 빈 상태 스타일 */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted);
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        .empty-state h5 {
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        /* Toast 스타일 */
        .toast {
            border: none;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        
        .toast-header {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-bottom: 2px solid #dee2e6;
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
            
            .stats-card {
                margin-bottom: 15px;
            }
            
            .stat-number {
                font-size: 1.8rem;
            }
            
            .table-responsive {
                font-size: 0.9rem;
            }
            
            .btn-action {
                font-size: 0.7rem;
                padding: 6px 10px;
            }
            
            .search-bar,
            .user-table {
                padding: 20px 15px;
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
        
        .stats-card, .search-bar, .user-table {
            animation: fadeInUp 0.6s ease-out;
        }
        
        .stats-card:nth-child(2) { animation-delay: 0.1s; }
        .stats-card:nth-child(3) { animation-delay: 0.2s; }
        .stats-card:nth-child(4) { animation-delay: 0.3s; }
        .stats-card:nth-child(5) { animation-delay: 0.4s; }
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
                        <a href="${pageContext.request.contextPath}/admin/dashboard">관리자</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">회원 관리</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">회원 관리</h2>
                    <p class="lead">전체 회원 현황을 관리하고 회원 정보를 확인할 수 있습니다</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" 
                       class="btn btn-light btn-lg me-2">
                        <i class="fas fa-tachometer-alt me-2"></i>대시보드
                    </a>
                    <a href="${pageContext.request.contextPath}/qr/enter" 
                       class="btn btn-outline-light btn-lg">
                        <i class="fas fa-qrcode me-2"></i>QR 관리
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <!-- 회원 통계 -->
        <div class="row mb-4">
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stats-card">
                    <i class="fas fa-user-check text-success mb-3" style="font-size: 2rem;"></i>
                    <div class="stat-number text-success">${userStats.activecount}</div>
                    <div class="stat-label">활성 회원</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stats-card">
                    <i class="fas fa-user-clock text-warning mb-3" style="font-size: 2rem;"></i>
                    <div class="stat-number text-warning">${userStats.suspendedcount}</div>
                    <div class="stat-label">정지 회원</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stats-card">
                    <i class="fas fa-user-minus text-info mb-3" style="font-size: 2rem;"></i>
                    <div class="stat-number text-info">${userStats.inactivecount}</div>
                    <div class="stat-label">비활성 회원</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stats-card">
                    <i class="fas fa-user-times text-danger mb-3" style="font-size: 2rem;"></i>
                    <div class="stat-number text-danger">${userStats.deletedcount}</div>
                    <div class="stat-label">삭제 회원</div>
                </div>
            </div>
        </div>
        
        <!-- 검색 바 -->
        <div class="search-bar">
            <h5 class="search-title">
                <i class="fas fa-search text-primary"></i>
                회원 검색
            </h5>
            <form method="GET" action="${pageContext.request.contextPath}/admin/users">
                <div class="row">
                    <div class="col-md-10">
                        <input type="text" class="form-control" name="keyword" 
                               value="${keyword}" placeholder="회원 ID, 이름, 이메일로 검색하세요...">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-search me-2"></i>검색
                        </button>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- 회원 목록 테이블 -->
        <div class="user-table">
            <h5 class="table-title">
                <i class="fas fa-users" style="color: var(--primary-color);"></i>
                회원 목록 
                <span class="text-muted">(총 ${totalCount}명)</span>
            </h5>
            
            <c:choose>
                <c:when test="${not empty userList}">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>
                                        <i class="fas fa-user me-2"></i>회원정보
                                    </th>
                                    <th>
                                        <i class="fas fa-envelope me-2"></i>연락처
                                    </th>
                                    <th>
                                        <i class="fas fa-calendar me-2"></i>가입일
                                    </th>
                                    <th>
                                        <i class="fas fa-toggle-on me-2"></i>상태
                                    </th>
                                    <th>
                                        <i class="fas fa-chart-bar me-2"></i>활동
                                    </th>
                                    <th>
                                        <i class="fas fa-cogs me-2"></i>관리
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${userList}">
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="me-3">
                                                    <i class="fas fa-user-circle text-muted" style="font-size: 2.5rem;"></i>
                                                </div>
                                                <div>
                                                    <div class="fw-bold">${user.username}</div>
                                                    <div class="d-flex gap-1 mt-1">
                                                        <c:if test="${user.userRole == 'ADMIN'}">
                                                            <span class="badge bg-danger">
                                                                <i class="fas fa-crown me-1"></i>관리자
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${user.accountType == 'SOCIAL'}">
                                                            <span class="badge bg-primary">
                                                                <i class="fas fa-share-alt me-1"></i>소셜
                                                            </span>
                                                        </c:if>
                                                    </div>
                                                    <small class="text-muted">@${user.userId}</small>
                                                </div>
                                            </div>
                                        </td>
                                        
                                        <td>
                                            <div>
                                                <c:if test="${not empty user.email}">
                                                    <div class="mb-1">
                                                        <i class="fas fa-envelope text-primary me-2"></i>
                                                        <span style="font-size: 0.9rem;">${user.email}</span>
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty user.phone}">
                                                    <div>
                                                        <i class="fas fa-phone text-success me-2"></i>
                                                        <span style="font-size: 0.9rem;">${user.phone}</span>
                                                    </div>
                                                </c:if>
                                                <c:if test="${empty user.email and empty user.phone}">
                                                    <span class="text-muted fst-italic">
                                                        <i class="fas fa-minus me-2"></i>미등록
                                                    </span>
                                                </c:if>
                                            </div>
                                        </td>
                                        
                                        <td>
                                            <div class="fw-bold">${user.formattedJoinDate}</div>
                                            <small class="text-muted">#${user.userNum}</small>
                                        </td>
                                        
                                        <td>
                                            <span class="badge status-badge 
                                                ${user.status == 'ACTIVE' ? 'bg-success' : 
                                                  user.status == 'SUSPENDED' ? 'bg-warning text-dark' : 'bg-secondary'}">
                                                <i class="fas ${user.status == 'ACTIVE' ? 'fa-check-circle' : 
                                                               user.status == 'SUSPENDED' ? 'fa-pause-circle' : 'fa-times-circle'} me-1"></i>
                                                ${user.statusDisplayName}
                                            </span>
                                        </td>
                                        
                                        <td>
                                            <div class="small">
                                                <div class="mb-1">
                                                    <i class="fas fa-ticket-alt text-primary me-1"></i>
                                                    패스: <strong>${user.totalPasses}</strong>개
                                                </div>
                                                <div>
                                                    <i class="fas fa-walking text-success me-1"></i>
                                                    방문: <strong>${user.totalVisits}</strong>회
                                                </div>
                                            </div>
                                        </td>
                                        
                                        <td>
                                            <div class="btn-group-vertical" role="group">
                                                <a href="${pageContext.request.contextPath}/admin/users/detail/${user.userNum}" 
                                                   class="btn btn-outline-primary btn-action">
                                                    <i class="fas fa-eye me-1"></i>상세
                                                </a>
                                                
                                                <c:if test="${user.status == 'ACTIVE'}">
                                                    <button class="btn btn-outline-warning btn-action" 
                                                            onclick="updateUserStatus(${user.userNum}, 'SUSPENDED')">
                                                        <i class="fas fa-pause me-1"></i>정지
                                                    </button>
                                                </c:if>
                                                
                                                <c:if test="${user.status == 'SUSPENDED'}">
                                                    <button class="btn btn-outline-success btn-action" 
                                                            onclick="updateUserStatus(${user.userNum}, 'ACTIVE')">
                                                        <i class="fas fa-play me-1"></i>활성
                                                    </button>
                                                </c:if>
                                                
								        <c:if test="${user.userRole != 'ADMIN'}">
								            <button class="btn btn-outline-danger btn-action" 
								                    onclick="console.log('삭제 대상:', ${user.userNum}, '${user.userId}'); deleteUser(${user.userNum})">
								                <i class="fas fa-trash me-1"></i>삭제
								            </button>
								        </c:if>
								    </tr>
								</c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- 페이징 -->
                    <c:if test="${totalPages > 1}">
                        <nav>
                            <ul class="pagination">
                                <c:if test="${currentPage > 1}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage - 1}&keyword=${keyword}">
                                            <i class="fas fa-chevron-left me-1"></i>이전
                                        </a>
                                    </li>
                                </c:if>
                                
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${i}&keyword=${keyword}">${i}</a>
                                    </li>
                                </c:forEach>
                                
                                <c:if test="${currentPage < totalPages}">
                                    <li class="page-item">
                                        <a class="page-link" href="?page=${currentPage + 1}&keyword=${keyword}">
                                            다음<i class="fas fa-chevron-right ms-1"></i>
                                        </a>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-users"></i>
                        <h5>등록된 회원이 없습니다</h5>
                        <p class="text-muted">검색 조건을 변경하거나 새로운 회원 가입을 기다려주세요.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <!-- Toast 알림 -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3">
        <div id="liveToast" class="toast" role="alert">
            <div class="toast-header">
                <i class="fas fa-bell me-2 text-primary"></i>
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
            
            if (isSuccess) {
                toastHeader.className = 'fas fa-check-circle me-2 text-success';
            } else {
                toastHeader.className = 'fas fa-exclamation-triangle me-2 text-danger';
            }
            
            toast.show();
        }
        
        function updateUserStatus(userNum, status) {
            const statusText = status === 'ACTIVE' ? '활성화' : '정지';
            
            if (!confirm(`정말로 이 회원을 ${statusText} 상태로 변경하시겠습니까?`)) {
                return;
            }
            
            fetch('${pageContext.request.contextPath}/admin/users/updateStatus', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
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
        
        function deleteUser(userNum) {
            console.log('deleteUser 호출됨:', userNum); // 디버깅용
            
            if (!confirm('정말로 이 회원을 삭제하시겠습니까?')) {
                return;
            }
            
            // JSP 변수를 JavaScript 변수로 먼저 할당
            var contextPath = '<c:out value="${pageContext.request.contextPath}" />';
            
            fetch(contextPath + '/admin/users/delete', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'userNum=' + userNum
            })
            .then(response => response.json())
            .then(data => {
                console.log('응답:', data); // 디버깅용
                if (data.success) {
                    alert('삭제되었습니다.');
                    location.reload();
                } else {
                    alert('삭제 실패: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다.');
            });
        }
        
        // 페이지 로드 애니메이션
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.stats-card, .search-bar, .user-table');
            elements.forEach((element, index) => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(30px)';
                
                setTimeout(() => {
                    element.style.transition = 'all 0.6s ease';
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
        
        console.log('회원 관리 페이지 로드 완료');
    </script>
</body>
</html>