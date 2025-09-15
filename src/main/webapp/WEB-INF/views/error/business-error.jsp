<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>처리 오류 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #ff9a9e, #fecfef);
            color: white;
        }
        .error-card {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 3rem;
            text-align: center;
            border: 1px solid rgba(255,255,255,0.2);
            max-width: 600px;
        }
        .error-icon {
            font-size: 4rem;
            opacity: 0.8;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="error-card">
                        <div class="error-icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                        <h2 class="mb-4">요청을 처리할 수 없습니다</h2>
                        <p class="lead mb-4">
                            ${errorMessage != null ? errorMessage : '요청하신 작업을 처리하는 중 문제가 발생했습니다.'}
                        </p>
                        <div class="d-flex gap-3 justify-content-center flex-wrap">
                            <button class="btn btn-light btn-lg" onclick="history.back()">
                                <i class="fas fa-arrow-left me-2"></i>이전 페이지
                            </button>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-home me-2"></i>홈으로
                            </a>
                            <a href="${pageContext.request.contextPath}/support" class="btn btn-outline-light btn-lg">
                                <i class="fas fa-question-circle me-2"></i>고객센터
                            </a>
                        </div>
                        
                        <div class="mt-4">
                            <small class="text-muted">
                                문제가 계속 발생하면 고객센터(1588-0000)로 문의해주세요.
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</body>
</html>