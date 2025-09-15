<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>내 프로그램 - 디자인바디</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .progress-card {
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            color: white;
            border-radius: 16px;
        }
        .program-card {
            border-radius: 12px;
            transition: transform 0.2s;
        }
        .program-card:hover {
            transform: translateY(-2px);
        }
        .progress-ring {
            transform: rotate(-90deg);
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-4">
        <!-- 페이지 헤더 -->
        <div class="row mb-4">
            <div class="col-md-6">
                <h2 class="fw-bold">내 프로그램 관리</h2>
                <p class="text-muted">진행중인 프로그램과 완료한 프로그램을 확인하세요</p>
            </div>
            <div class="col-md-6 text-end">
                <a href="${pageContext.request.contextPath}/designbody/programs" class="btn btn-primary">
                    <i class="fas fa-plus me-2"></i>새 프로그램 찾기
                </a>
            </div>
        </div>
        
        <!-- 통계 카드 -->
        <div class="stats-grid mb-5">
            <div class="progress-card p-4 text-center">
                <div class="display-6 fw-bold">${stats.totalCount}</div>
                <p class="mb-0">총 신청 프로그램</p>
            </div>
            <div class="card p-4 text-center">
                <div class="display-6 fw-bold text-success">${stats.activeCount}</div>
                <p class="mb-0 text-muted">진행중인 프로그램</p>
            </div>
            <div class="card p-4 text-center">
                <div class="display-6 fw-bold text-primary">${stats.completedCount}</div>
                <p class="mb-0 text-muted">완료한 프로그램</p>
            </div>
        </div>
        
        <!-- 진행중인 프로그램 -->
        <div class="row mb-5">
            <div class="col-12">
                <h4 class="fw-bold mb-4">진행중인 프로그램</h4>
                <c:choose>
                    <c:when test="${not empty activeEnrollments}">
                        <div class="row">
                            <c:forEach var="enrollment" items="${activeEnrollments}">
                                <div class="col-lg-6 mb-4">
                                    <div class="card program-card">
                                        <div class="card-body">
                                            <div class="row align-items-center">
                                                <div class="col-md-8">
                                                    <div class="d-flex align-items-center mb-2">
                                                        <span class="badge bg-primary me-2">${enrollment.programType}</span>
                                                        <span class="badge bg-success">${enrollment.statusText}</span>
                                                    </div>
                                                    <h5 class="card-title mb-2">${enrollment.programName}</h5>
                                                    <p class="text-muted mb-2">
                                                        <i class="fas fa-user me-2"></i>${enrollment.instructor}
                                                    </p>
                                                    <div class="d-flex justify-content-between text-muted small mb-3">
                                                        <span>
                                                            시작: <fmt:formatDate value="${enrollment.startDate}" pattern="MM.dd"/>
                                                        </span>
                                                        <span>
                                                            종료: <fmt:formatDate value="${enrollment.endDate}" pattern="MM.dd"/>
                                                        </span>
                                                    </div>
                                                    <div class="progress mb-2">
                                                        <div class="progress-bar bg-success" role="progressbar" 
                                                             style="width: ${enrollment.progressPercent}%"></div>
                                                    </div>
                                                    <small class="text-muted">진행률: ${enrollment.progressPercent}%</small>
                                                </div>
                                                <div class="col-md-4 text-center">
                                                    <svg class="progress-ring" width="80" height="80">
                                                        <circle cx="40" cy="40" r="35" stroke="#e9ecef" stroke-width="8" fill="transparent"/>
                                                        <circle cx="40" cy="40" r="35" stroke="#28a745" stroke-width="8" fill="transparent"
                                                                stroke-dasharray="${220 * enrollment.progressPercent / 100} 220"
                                                                stroke-linecap="round"/>
                                                    </svg>
                                                    <div class="mt-2">
                                                        <strong class="text-success">${enrollment.progressPercent}%</strong>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="d-flex gap-2 mt-3">
                                                <button class="btn btn-sm btn-primary flex-fill" 
                                                        onclick="viewProgress(${enrollment.enrollNum})">
                                                    진행상황 보기
                                                </button>
                                                <button class="btn btn-sm btn-outline-secondary" 
                                                        onclick="pauseProgram(${enrollment.enrollNum})">
                                                    일시정지
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card">
                            <div class="card-body text-center py-5">
                                <i class="fas fa-play-circle fa-3x text-muted mb-3"></i>
                                <h5 class="text-muted">진행중인 프로그램이 없습니다</h5>
                                <p class="text-muted mb-4">새로운 프로그램을 시작해보세요!</p>
                                <a href="${pageContext.request.contextPath}/designbody/programs" 
                                   class="btn btn-primary">프로그램 둘러보기</a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- 전체 신청 내역 -->
        <div class="row">
            <div class="col-12">
                <h4 class="fw-bold mb-4">전체 신청 내역</h4>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>프로그램명</th>
                                <th>카테고리</th>
                                <th>트레이너</th>
                                <th>신청일</th>
                                <th>진행기간</th>
                                <th>상태</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="enrollment" items="${myEnrollments}">
                                <tr>
                                    <td>
                                        <strong>${enrollment.programName}</strong>
                                    </td>
                                    <td>
                                        <span class="badge bg-secondary">${enrollment.programType}</span>
                                    </td>
                                    <td>${enrollment.instructor}</td>
                                    <td>
                                        <fmt:formatDate value="${enrollment.enrollDate}" pattern="yyyy.MM.dd"/>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${enrollment.startDate}" pattern="MM.dd"/> ~ 
                                        <fmt:formatDate value="${enrollment.endDate}" pattern="MM.dd"/>
                                    </td>
                                    <td>
                                        <span class="badge ${enrollment.status == 'ACTIVE' ? 'bg-success' : 
                                                           enrollment.status == 'COMPLETED' ? 'bg-primary' : 'bg-secondary'}">
                                            ${enrollment.statusText}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <c:choose>
                                                <c:when test="${enrollment.status == 'ACTIVE'}">
                                                    <button class="btn btn-outline-primary" 
                                                            onclick="viewProgress(${enrollment.enrollNum})">
                                                        진행상황
                                                    </button>
                                                </c:when>
                                                <c:when test="${enrollment.status == 'COMPLETED'}">
                                                    <button class="btn btn-outline-success" 
                                                            onclick="viewCertificate(${enrollment.enrollNum})">
                                                        수료증
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-outline-secondary" disabled>
                                                        ${enrollment.statusText}
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty myEnrollments}">
                                <tr>
                                    <td colspan="7" class="text-center py-5">
                                        <div class="text-muted">
                                            <i class="fas fa-inbox fa-2x mb-3"></i>
                                            <p>신청한 프로그램이 없습니다.</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function viewProgress(enrollNum) {
            // 진행상황 상세 페이지로 이동 (추후 구현)
            alert('진행상황 상세 보기 기능은 추후 업데이트 예정입니다.');
        }
        
        function pauseProgram(enrollNum) {
            if (confirm('프로그램을 일시정지하시겠습니까?')) {
                fetch('${pageContext.request.contextPath}/designbody/pause', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'enrollNum=' + enrollNum
                })
                .then(response => response.json())
                .then(data => {
                    alert(data.message);
                    if (data.success) {
                        location.reload();
                    }
                });
            }
        }
        
        function viewCertificate(enrollNum) {
            // 수료증 보기 (추후 구현)
            alert('수료증 발급 기능은 추후 업데이트 예정입니다.');
        }
    </script>
</body>
</html>