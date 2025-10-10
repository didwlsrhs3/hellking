<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>소셜 로그인 오류 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
        }
        
        .error-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--bg-cream);
            padding: 20px;
        }
        
        .error-card {
            background: white;
            border-radius: 20px;
            padding: 3rem;
            text-align: center;
            max-width: 600px;
            box-shadow: 0 15px 35px rgba(15,23,42,0.1);
        }
        
        .error-icon {
            font-size: 4rem;
            color: var(--brand);
            margin-bottom: 1.5rem;
        }
        
        .btn-primary {
            background: var(--brand);
            border: none;
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
        }
        
        .btn-outline-secondary {
            border-color: #E7E0D6;
            color: var(--ink);
            border-radius: 12px;
            padding: 12px 24px;
            font-weight: 600;
        }
        
        .social-providers {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin: 20px 0;
        }
        
        .social-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            font-size: 18px;
            transition: transform 0.2s;
        }
        
        .social-btn:hover {
            transform: scale(1.1);
        }
        
        .social-naver {
            background: #03C75A;
            color: white;
        }
        
        .social-kakao {
            background: #FEE500;
            color: #191919;
        }
        
        .social-google {
            background: #4285F4;
            color: white;
        }
        
        .error-details {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-card">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            
            <h2 class="mb-3" style="color: var(--ink);">소셜 로그인 중 오류가 발생했습니다</h2>
            
            <!-- 에러 메시지 표시 -->
            <c:choose>
                <c:when test="${param.error == 'oauth'}">
                    <p class="lead text-muted mb-4">
                        소셜 로그인 연결 중 문제가 발생했습니다. 다시 시도해주세요.
                    </p>
                </c:when>
                <c:when test="${param.error == 'duplicate_social'}">
                    <p class="lead text-muted mb-4">
                        이미 다른 계정에 연결된 소셜 계정입니다.
                    </p>
                    <div class="error-details">
                        <h6><i class="fas fa-info-circle me-2"></i>해결 방법</h6>
                        <ul class="text-start">
                            <li>기존 계정으로 로그인한 후 연동을 해제하거나</li>
                            <li>다른 소셜 계정으로 로그인을 시도해보세요</li>
                        </ul>
                    </div>
                </c:when>
                <c:when test="${param.error == 'access_denied'}">
                    <p class="lead text-muted mb-4">
                        소셜 로그인 인증이 취소되었습니다.
                    </p>
                </c:when>
                <c:when test="${param.error == 'invalid_request'}">
                    <p class="lead text-muted mb-4">
                        잘못된 요청입니다. 다시 시도해주세요.
                    </p>
                </c:when>
                <c:otherwise>
                    <p class="lead text-muted mb-4">
                        ${not empty param.message ? param.message : '알 수 없는 오류가 발생했습니다.'}
                    </p>
                </c:otherwise>
            </c:choose>
            
            <!-- 다시 시도 버튼들 -->
            <div class="social-providers">
                <a href="${pageContext.request.contextPath}/oauth/naver" class="social-btn social-naver" title="네이버로 로그인">
                    <span style="font-weight: bold; font-size: 14px;">N</span>
                </a>
                <a href="${pageContext.request.contextPath}/oauth/kakao" class="social-btn social-kakao" title="카카오로 로그인">
                    <i class="fas fa-comment"></i>
                </a>
                <a href="${pageContext.request.contextPath}/oauth/google" class="social-btn social-google" title="구글로 로그인">
                    <i class="fab fa-google"></i>
                </a>
            </div>
            
            <div class="d-flex gap-3 justify-content-center flex-wrap">
                <a href="${pageContext.request.contextPath}/user/login" class="btn btn-primary">
                    <i class="fas fa-sign-in-alt me-2"></i>로그인 페이지로
                </a>
                <a href="${pageContext.request.contextPath}/user/join" class="btn btn-outline-secondary">
                    <i class="fas fa-user-plus me-2"></i>일반 회원가입
                </a>
                <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">
                    <i class="fas fa-home me-2"></i>홈으로
                </a>
            </div>
            
            <div class="mt-4">
                <small class="text-muted">
                    <i class="fas fa-question-circle me-1"></i>
                    문제가 계속 발생하면 고객센터(1588-0000)로 문의해주세요.
                </small>
            </div>
        </div>
    </div>
</body>
</html>