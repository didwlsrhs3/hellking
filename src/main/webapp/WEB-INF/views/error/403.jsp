<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>접근 권한 없음 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
        }
        .error-card {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem;
            text-align: center;
            border: 1px solid rgba(255,255,255,0.2);
        }
        .error-code {
            font-size: 8rem;
            font-weight: 900;
            opacity: 0.8;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="error-card">
                        <div class="error-code">403</div>
                        <h2 class="mb-4">접근 권한이 없습니다</h2>
                        <p class="lead mb-4">이 페이지에 접근할 권한이 없습니다. 로그인 후 다시 시도해주세요.</p>
                        <div class="d-flex gap-3 justify-content-center">
                            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-light btn-lg">
                                <i class="fas fa-sign-in-alt me-2"></i>로그인
                            </a>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-home me-2"></i>홈으로
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</body>
</html>