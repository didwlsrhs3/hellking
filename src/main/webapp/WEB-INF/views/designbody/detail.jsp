<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${program.programName} - 디자인바디</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .program-hero {
            height: 400px;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)),
                        url('${pageContext.request.contextPath}/resources/images/designbody/programs/${program.imagePath != null ? program.imagePath : "default-program.jpg"}');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            color: white;
        }
        .enroll-card {
            position: sticky;
            top: 20px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }
        .feature-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #FF6A00, #ff8533);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 프로그램 히어로 -->
    <div class="program-hero">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="mb-3">
                        <span class="badge bg-primary me-2">${program.typeText}</span>
                        <span class="badge bg-secondary">${program.difficultyText}</span>
                    </div>
                    <h1 class="display-4 fw-bold mb-3">${program.programName}</h1>
                    <p class="lead">${program.description}</p>
                    <div class="d-flex gap-4 mt-4">
                        <div class="text-center">
                            <div class="fw-bold fs-4">${program.duration}</div>
                            <small>일 과정</small>
                        </div>
                        <div class="text-center">
                            <div class="fw-bold fs-4">${program.formattedPrice}</div>
                            <small>프로그램 비용</small>
                        </div>
                        <div class="text-center">
                            <div class="fw-bold fs-4">${program.instructor}</div>
                            <small>전문 트레이너</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-5">
        <div class="row">
            <div class="col-lg-8">
                <!-- 프로그램 소개 -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="mb-4">프로그램 소개</h4>
                        <p style="white-space: pre-line;">${program.description}</p>
                        
                        <c:if test="${not empty program.targetAudience}">
                            <h6 class="mt-4">이런 분들에게 추천</h6>
                            <p>${program.targetAudience}</p>
                        </c:if>
                        
                        <c:if test="${not empty program.equipment}">
                            <h6 class="mt-4">필요한 장비</h6>
                            <p>${program.equipment}</p>
                        </c:if>
                    </div>
                </div>
                
                <!-- 프로그램 특징 -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h4 class="mb-4">프로그램 특징</h4>
                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <div class="d-flex align-items-center">
                                    <div class="feature-icon me-3">
                                        <i class="fas fa-user-tie"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">전문 트레이너</h6>
                                        <small class="text-muted">경험 풍부한 전문가의 1:1 지도</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="d-flex align-items-center">
                                    <div class="feature-icon me-3">
                                        <i class="fas fa-chart-line"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">체계적인 관리</h6>
                                        <small class="text-muted">단계별 목표 설정 및 진도 관리</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="d-flex align-items-center">
                                    <div class="feature-icon me-3">
                                        <i class="fas fa-mobile-alt"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">앱 연동</h6>
                                        <small class="text-muted">모바일로 언제든지 진행상황 확인</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">
                                <div class="d-flex align-items-center">
                                    <div class="feature-icon me-3">
                                        <i class="fas fa-users"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-1">커뮤니티</h6>
                                        <small class="text-muted">같은 목표를 가진 회원들과 소통</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 스케줄 정보 -->
                <c:if test="${not empty program.schedule}">
                    <div class="card mb-4">
                        <div class="card-body">
                            <h4 class="mb-4">운동 스케줄</h4>
                            <p style="white-space: pre-line;">${program.schedule}</p>
                        </div>
                    </div>
                </c:if>
            </div>
            
            <!-- 사이드바 - 신청 카드 -->
            <div class="col-lg-4">
                <div class="enroll-card p-4">
                    <div class="text-center mb-4">
                        <div class="display-6 fw-bold text-primary">${program.formattedPrice}</div>
                        <small class="text-muted">${program.duration}일 프로그램</small>
                    </div>
                    
                    <c:choose>
                        <c:when test="${empty sessionScope.userNum}">
                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary btn-lg">
                                    로그인하고 신청하기
                                </a>
                                <small class="text-muted text-center">회원만 신청 가능합니다</small>
                            </div>
                        </c:when>
                        <c:when test="${alreadyEnrolled}">
                            <div class="alert alert-success text-center">
                                <i class="fas fa-check-circle me-2"></i>이미 신청한 프로그램입니다
                            </div>
                            <div class="d-grid">
                                <a href="${pageContext.request.contextPath}/designbody/my" class="btn btn-outline-primary">
                                    내 프로그램 보기
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="d-grid gap-2">
                                <button class="btn btn-primary btn-lg" onclick="enrollProgram()">
                                    지금 신청하기
                                </button>
                                <button class="btn btn-outline-secondary" onclick="addToWishlist()">
                                    관심목록 추가
                                </button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <hr class="my-4">
                    
                    <div class="program-info">
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">카테고리</span>
                            <span>${program.typeText}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">난이도</span>
                            <span>${program.difficultyText}</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">기간</span>
                            <span>${program.duration}일</span>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span class="text-muted">트레이너</span>
                            <span>${program.instructor}</span>
                        </div>
                    </div>
                </div>
                
                <!-- 비슷한 프로그램 -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h6 class="mb-0">비슷한 프로그램</h6>
                    </div>
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <img src="${pageContext.request.contextPath}/resources/images/designbody/programs/sample1.jpg" 
                                 class="rounded me-3" width="60" height="60" alt="프로그램">
                            <div>
                                <h6 class="mb-1">홈 트레이닝 30일</h6>
                                <small class="text-muted">초급 · 45,000원</small>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-3">
                            <img src="${pageContext.request.contextPath}/resources/images/designbody/programs/sample2.jpg" 
                                 class="rounded me-3" width="60" height="60" alt="프로그램">
                            <div>
                                <h6 class="mb-1">체중감량 집중과정</h6>
                                <small class="text-muted">중급 · 75,000원</small>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/designbody/type/${program.programType}" 
                           class="btn btn-sm btn-outline-primary w-100">더 많은 프로그램 보기</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    
    <script>
        // 포트원 초기화 (실제 환경에서는 API 키 설정)
        // IMP.init('your_portone_key');
        
        function enrollProgram() {
            if (confirm('${program.programName} 프로그램을 신청하시겠습니까?')) {
                // 무료 프로그램인 경우 바로 신청
                if (${program.price == 0}) {
                    processEnrollment(null);
                } else {
                    // 결제 진행
                    requestPayment();
                }
            }
        }
        
        function requestPayment() {
            // 실제 환경에서는 포트원 결제 구현
            alert('결제 기능은 실제 배포 환경에서 구현됩니다.');
            
            // 데모용 - 임시 결제 ID로 신청 처리
            const paymentId = 'demo_payment_' + Date.now();
            processEnrollment(paymentId);
        }
        
        function processEnrollment(paymentId) {
            fetch('${pageContext.request.contextPath}/designbody/enroll', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'programNum=${program.programNum}&paymentId=' + (paymentId || '')
            })
            .then(response => response.json())
            .then(data => {
                alert(data.message);
                if (data.success) {
                    location.reload();
                }
            })
            .catch(error => {
                alert('신청 처리 중 오류가 발생했습니다.');
            });
        }
        
        function addToWishlist() {
            alert('관심목록 기능은 추후 업데이트 예정입니다.');
        }
    </script>
</body>
</html>