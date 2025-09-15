<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>잘못된 요청 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .error-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #f093fb, #f5576c);
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
                        <div class="error-code">400</div>
                        <h2 class="mb-4">잘못된 요청</h2>
                        <p class="lead mb-4">요청하신 내용에 문제가 있습니다. 입력 정보를 확인해주세요.</p>
                        <div class="d-flex gap-3 justify-content-center">
                            <button class="btn btn-light btn-lg" onclick="history.back()">
                                <i class="fas fa-arrow-left me-2"></i>이전 페이지
                            </button>
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