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
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
        }
        body { background: var(--bg-cream); }
        .profile-header {
            background: linear-gradient(135deg, var(--brand), #ff8533);
            color: white;
            padding: 40px 0;
            border-radius: 20px 20px 0 0;
        }
        .profile-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid white;
            object-fit: cover;
        }
        .pass-card {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            border-radius: 16px;
            padding: 24px;
            margin: 20px 0;
        }
        .pass-expired {
            background: linear-gradient(135deg, #6c757d, #5a6268);
        }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(15,23,42,0.1);
        }
        .quick-action {
            background: white;
            border: 2px solid var(--brand);
            color: var(--brand);
            border-radius: 12px;
            padding: 12px 20px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.2s;
        }
        .quick-action:hover {
            background: var(--brand);
            color: white;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-4">
        <!-- 프로필 헤더 -->
        <div class="row">
            <div class="col-12">
                <div class="profile-header text-center">
                    <img src="${pageContext.request.contextPath}/resources/images/profiles/${user.profileImage}" 
                         alt="프로필" class="profile-img mb-3">
                    <h2>${user.username}님</h2>
                    <p class="mb-0">${user.email}</p>
                    <p class="small">가입일: <fmt:formatDate value="${user.joinDate}" pattern="yyyy.MM.dd"/></p>
                </div>
            </div>
        </div>
        
        <!-- 활성 패스권 정보 -->
        <div class="row mt-4">
            <div class="col-12">
                <c:choose>
                    <c:when test="${not empty user.passName}">
                        <div class="pass-card">
                            <h5>활성 패스권</h5>
                            <h4>${user.passName}</h4>
                            <p class="mb-0">만료일: <fmt:formatDate value="${user.passEndDate}" pattern="yyyy년 MM월 dd일"/></p>
                            <small>전국 모든 헬킹 가맹점에서 자유롭게 이용하세요!</small>
                        </div>
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
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>