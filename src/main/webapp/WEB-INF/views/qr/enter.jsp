<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<<<<<<< HEAD
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
=======
>>>>>>> b65c320 (Initial commit)
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<<<<<<< HEAD
    <title>QR 입장 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
        }
        body { background: var(--bg-cream); }
        .qr-container {
            max-width: 600px;
            margin: 0 auto;
        }
        .qr-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(15,23,42,0.1);
            margin-bottom: 20px;
        }
        .chain-input {
            font-size: 2rem;
            text-align: center;
            letter-spacing: 0.5rem;
            border: 3px solid var(--brand);
            border-radius: 15px;
            padding: 20px;
            text-transform: uppercase;
        }
        .chain-input:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 0.2rem rgba(255,106,0,0.2);
        }
        .btn-enter {
            background: var(--brand);
            border: none;
            color: white;
            font-weight: 700;
            padding: 15px 40px;
            border-radius: 15px;
            font-size: 1.2rem;
        }
        .pass-status {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
        }
        .pass-expired {
            background: linear-gradient(135deg, #dc3545, #c82333);
        }
        .recent-visit {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin: 10px 0;
            text-align: left;
        }
        .qr-display {
            border: 3px solid var(--brand);
            border-radius: 15px;
            padding: 20px;
            margin: 20px 0;
            display: none;
=======
    <title>QR 코드 관리 | 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 - 보라색 */
        .page-header {
            background: linear-gradient(135deg, #6f42c1, #5a34a1);
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
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            transition: all 0.3s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(15,23,42,0.15);
        }
        
        .card-header {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-bottom: 2px solid #dee2e6;
            border-radius: 15px 15px 0 0 !important;
            padding: 20px;
        }
        
        .card-header h5 {
            color: #0F172A;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #6f42c1, #5a34a1);
            border: none;
            border-radius: 10px;
            font-weight: 600;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #5a34a1, #4a2c87);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(111, 66, 193, 0.3);
        }
        
        .btn-outline-primary {
            color: #6f42c1;
            border-color: #6f42c1;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-outline-primary:hover {
            background: #6f42c1;
            border-color: #6f42c1;
            transform: translateY(-2px);
        }
        
        .btn-outline-success {
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-outline-success:hover {
            transform: translateY(-2px);
        }
        
        .btn-outline-info {
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-outline-info:hover {
            transform: translateY(-2px);
        }
        
        .btn-warning {
            background: linear-gradient(135deg, #ffc107, #e0a800);
            border: none;
            color: #0F172A;
            border-radius: 10px;
            font-weight: 600;
            padding: 12px 25px;
            transition: all 0.3s ease;
        }
        
        .btn-warning:hover {
            background: linear-gradient(135deg, #e0a800, #cc9900);
            color: #0F172A;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 193, 7, 0.3);
        }
        
        .form-control {
            border-radius: 10px;
            border: 2px solid #dee2e6;
            padding: 12px 16px;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #6f42c1;
            box-shadow: 0 0 0 0.2rem rgba(111, 66, 193, 0.15);
        }
        
        .form-label {
            font-weight: 600;
            color: #0F172A;
            margin-bottom: 8px;
        }
        
        /* QR 표시 영역 스타일 */
        #newQRDisplay {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 30px;
            border: 2px dashed #6f42c1;
        }
        
        #newQRImage {
            border-radius: 10px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
        }
        
        /* 가맹점 카드 스타일 */
        .chain-card {
            border: 2px solid #e9ecef;
            border-radius: 15px;
            transition: all 0.3s ease;
            background: white;
        }
        
        .chain-card:hover {
            border-color: #6f42c1;
            background: linear-gradient(135deg, #f8f9ff, #ffffff);
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(111, 66, 193, 0.1);
        }
        
        .chain-card h6 {
            color: #0F172A;
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        /* 모달 스타일 */
        .modal-content {
            border: none;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        
        .modal-header {
            background: linear-gradient(135deg, #6f42c1, #5a34a1);
            color: white;
            border-radius: 20px 20px 0 0;
            padding: 25px;
        }
        
        .modal-title {
            font-weight: 700;
            margin: 0;
        }
        
        .btn-close {
            filter: invert(1);
        }
        
        .modal-body {
            padding: 30px;
        }
        
        .modal-footer {
            border-top: 2px solid #f8f9fa;
            padding: 25px 30px;
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
            
            .btn {
                font-size: 14px;
                padding: 8px 16px;
            }
            
            .card-body {
                padding: 15px;
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
        
        .card {
            animation: fadeInUp 0.6s ease-out;
        }
        
        .card:nth-child(2) {
            animation-delay: 0.1s;
        }
        
        .card:nth-child(3) {
            animation-delay: 0.2s;
>>>>>>> b65c320 (Initial commit)
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
<<<<<<< HEAD
    <div class="container mt-4">
        <div class="qr-container">
            <h2 class="text-center mb-4">QR 코드 입장</h2>
            
            <!-- 패스권 상태 -->
            <c:choose>
                <c:when test="${not empty activePasses}">
                    <c:forEach var="pass" items="${activePasses}">
                        <div class="pass-status">
                            <h5 class="mb-2">활성 패스권</h5>
                            <h4>${pass.passName}</h4>
                            <p class="mb-0">만료일: <fmt:formatDate value="${pass.endDate}" pattern="yyyy.MM.dd"/></p>
                            <small>남은 일수: ${pass.remainingDays}일</small>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="pass-status pass-expired">
                        <h5>활성 패스권 없음</h5>
                        <p class="mb-0">패스권을 먼저 구매해주세요.</p>
                        <a href="${pageContext.request.contextPath}/pass/list" class="btn btn-light mt-2">패스권 구매하기</a>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <!-- QR 입장 폼 -->
            <div class="qr-card">
                <!-- 방법 1: 코드 입력 -->
                <div class="mb-4">
                    <h5 class="mb-3">가맹점 코드 입력</h5>
                    <form id="enterForm">
                        <div class="mb-3">
                            <input type="text" class="form-control chain-input" 
                                   id="chainCode" maxlength="4" placeholder="0000"
                                   ${empty activePasses ? 'disabled' : ''}>
                            <div class="form-text">가맹점에 표시된 4자리 코드를 입력하세요</div>
                        </div>
                        <button type="submit" class="btn btn-enter" 
                                ${empty activePasses ? 'disabled' : ''}>
                            입장하기
                        </button>
                    </form>
                </div>
                
                <hr class="my-4">
                
                <!-- 방법 2: QR 코드 생성 -->
                <div class="mb-4">
                    <h5 class="mb-3">QR 코드 생성</h5>
                    <button type="button" class="btn btn-outline-primary" onclick="generateQR()"
                            ${empty activePasses ? 'disabled' : ''}>
                        내 QR 코드 생성
                    </button>
                    
                    <div id="qrDisplay" class="qr-display">
                        <img id="qrImage" src="" alt="QR Code" style="max-width: 200px;">
                        <p class="mt-2">가맹점에서 이 QR 코드를 스캔해주세요</p>
                        <button type="button" class="btn btn-sm btn-secondary" onclick="downloadQR()">
                            QR 코드 저장
                        </button>
                    </div>
                </div>
            </div>
            
            <!-- 통계 정보 -->
            <div class="qr-card">
                <h5 class="mb-3">나의 이용 현황</h5>
                <div class="row text-center">
                    <div class="col-4">
                        <h4 class="text-primary">${stats.totalVisits}</h4>
                        <small>총 방문</small>
                    </div>
                    <div class="col-4">
                        <h4 class="text-success">${stats.successVisits}</h4>
                        <small>성공</small>
                    </div>
                    <div class="col-4">
                        <h4 class="text-warning">${stats.visitedChains}</h4>
                        <small>방문 가맹점</small>
                    </div>
                </div>
            </div>
            
            <!-- 최근 방문 기록 -->
            <c:if test="${not empty recentVisits}">
                <div class="qr-card">
                    <h5 class="mb-3">최근 방문</h5>
                    <c:forEach var="visit" items="${recentVisits}">
                        <div class="recent-visit">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <strong>${visit.chainName}</strong>
                                    <br>
                                    <small class="text-muted">${visit.visitTimeText}</small>
                                </div>
                                <span class="badge ${visit.result == 'SUCCESS' ? 'bg-success' : 'bg-danger'}">
                                    ${visit.resultText}
                                </span>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <div class="mt-3">
                        <a href="${pageContext.request.contextPath}/qr/history" 
                           class="text-decoration-none">전체 기록 보기 →</a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
    
    <!-- 결과 모달 -->
    <div class="modal fade" id="resultModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" id="modalHeader">
                    <h5 class="modal-title" id="modalTitle">입장 결과</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="modalBody">
                    <!-- 결과 내용 -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>
=======
    <!-- 통일된 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/">홈</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/qr/">QR 서비스</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">QR 코드 관리</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">QR 코드 관리</h2>
                    <p class="lead">가맹점 QR 코드를 생성하고 관리하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/qr/history" 
                       class="btn btn-light btn-lg me-2">
                        <i class="fas fa-history me-2"></i>방문 기록
                    </a>
                    <a href="${pageContext.request.contextPath}/qr/scan" 
                       class="btn btn-outline-light btn-lg">
                        <i class="fas fa-qrcode me-2"></i>QR 스캔
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <!-- 새 가맹점 QR 생성 -->
        <div class="card mb-5">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-plus-circle text-primary me-2"></i>
                    가맹점 QR 코드 생성
                </h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="newChainCode" class="form-label">
                                <i class="fas fa-tag me-2 text-primary"></i>가맹점 코드
                            </label>
                            <input type="text" class="form-control" id="newChainCode" 
                                   maxlength="4" placeholder="예: GN01" style="text-transform: uppercase;">
                            <div class="form-text">4자리 영문+숫자 조합으로 입력해주세요</div>
                        </div>
                        <div class="mb-4">
                            <label for="chainName" class="form-label">
                                <i class="fas fa-store me-2 text-success"></i>가맹점명 (선택사항)
                            </label>
                            <input type="text" class="form-control" id="chainName" placeholder="예: 강남점">
                        </div>
                        <button class="btn btn-primary btn-lg" onclick="generateNewQR()">
                            <i class="fas fa-magic me-2"></i>QR 생성
                        </button>
                    </div>
                    <div class="col-md-6">
                        <div id="newQRDisplay" style="display: none; text-align: center;">
                            <h6 class="mb-3 text-muted">생성된 QR 코드</h6>
                            <img id="newQRImage" src="" alt="QR Code" style="max-width: 200px;">
                            <div class="mt-4">
                                <button class="btn btn-success me-2" onclick="downloadNewQR()">
                                    <i class="fas fa-download me-1"></i> 다운로드
                                </button>
                                <button class="btn btn-info" onclick="printNewQR()">
                                    <i class="fas fa-print me-1"></i> 인쇄
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 기존 가맹점 QR 코드 목록 -->
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-list-alt text-info me-2"></i>
                    등록된 가맹점 QR 코드
                </h5>
            </div>
            <div class="card-body">
                <div class="row" id="existingQRList">
                    <!-- 기본 가맹점들 -->
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card chain-card h-100">
                            <div class="card-body text-center">
                                <div class="mb-3">
                                    <i class="fas fa-dumbbell text-primary" style="font-size: 2rem;"></i>
                                </div>
                                <h6>GN01 - 헬킹 체육관</h6>
                                <div class="btn-group-vertical w-100 gap-2">
                                    <button class="btn btn-outline-primary btn-sm" onclick="generateChainQR('GN01')">
                                        <i class="fas fa-eye me-1"></i>미리보기
                                    </button>
                                    <button class="btn btn-outline-success btn-sm" onclick="downloadChainQR('GN01')">
                                        <i class="fas fa-download me-1"></i>다운로드
                                    </button>
                                    <button class="btn btn-outline-info btn-sm" onclick="printChainQR('GN01', '헬킹 체육관')">
                                        <i class="fas fa-print me-1"></i>인쇄
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card chain-card h-100">
                            <div class="card-body text-center">
                                <div class="mb-3">
                                    <i class="fas fa-city text-success" style="font-size: 2rem;"></i>
                                </div>
                                <h6>GN02 - 강남점</h6>
                                <div class="btn-group-vertical w-100 gap-2">
                                    <button class="btn btn-outline-primary btn-sm" onclick="generateChainQR('GN02')">
                                        <i class="fas fa-eye me-1"></i>미리보기
                                    </button>
                                    <button class="btn btn-outline-success btn-sm" onclick="downloadChainQR('GN02')">
                                        <i class="fas fa-download me-1"></i>다운로드
                                    </button>
                                    <button class="btn btn-outline-info btn-sm" onclick="printChainQR('GN02', '강남점')">
                                        <i class="fas fa-print me-1"></i>인쇄
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card chain-card h-100">
                            <div class="card-body text-center">
                                <div class="mb-3">
                                    <i class="fas fa-building text-warning" style="font-size: 2rem;"></i>
                                </div>
                                <h6>GN03 - 홍대점</h6>
                                <div class="btn-group-vertical w-100 gap-2">
                                    <button class="btn btn-outline-primary btn-sm" onclick="generateChainQR('GN03')">
                                        <i class="fas fa-eye me-1"></i>미리보기
                                    </button>
                                    <button class="btn btn-outline-success btn-sm" onclick="downloadChainQR('GN03')">
                                        <i class="fas fa-download me-1"></i>다운로드
                                    </button>
                                    <button class="btn btn-outline-info btn-sm" onclick="printChainQR('GN03', '홍대점')">
                                        <i class="fas fa-print me-1"></i>인쇄
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- 일괄 다운로드 -->
                <div class="text-center mt-4">
                    <button class="btn btn-warning btn-lg" onclick="downloadAllQR()">
                        <i class="fas fa-download me-2"></i>모든 QR 코드 일괄 다운로드
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- QR 미리보기 모달 -->
    <div class="modal fade" id="qrPreviewModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="qrModalTitle">
                        <i class="fas fa-qrcode me-2"></i>QR 코드 미리보기
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center">
                    <img id="modalQRImage" src="" alt="QR Code" style="max-width: 300px;" class="rounded">
                    <p class="mt-3 text-muted" id="modalQRInfo"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" onclick="downloadModalQR()">
                        <i class="fas fa-download me-2"></i>다운로드
                    </button>
                    <button type="button" class="btn btn-info" onclick="printModalQR()">
                        <i class="fas fa-print me-2"></i>인쇄
                    </button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times me-2"></i>닫기
                    </button>
>>>>>>> b65c320 (Initial commit)
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
<<<<<<< HEAD
        let currentQRData = '';
        
        // 입장 처리
        document.getElementById('enterForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const chainCode = document.getElementById('chainCode').value.trim();
            if(!chainCode) {
                alert('가맹점 코드를 입력해주세요.');
                return;
            }
            
            if(chainCode.length !== 4) {
                alert('4자리 코드를 정확히 입력해주세요.');
                return;
            }
            
            processEnter(chainCode);
        });
        
        // 입장 처리 함수
        function processEnter(chainCode) {
            fetch('${pageContext.request.contextPath}/qr/processEnter', {
=======
        let currentModalChainCode = '';
        let currentModalChainName = '';
        let newGeneratedChainCode = '';
        
        // 새 QR 생성
        function generateNewQR() {
            const chainCode = document.getElementById('newChainCode').value.trim().toUpperCase();
            const chainName = document.getElementById('chainName').value.trim();
            
            if (!chainCode) {
                alert('가맹점 코드를 입력해주세요.');
                return;
            }
            if (chainCode.length !== 4) {
                alert('4자리 코드를 입력해주세요.');
                return;
            }
            
            generateQRCode(chainCode, function(qrCodeBase64) {
                document.getElementById('newQRImage').src = qrCodeBase64;
                document.getElementById('newQRDisplay').style.display = 'block';
                newGeneratedChainCode = chainCode;
            });
        }
        
        // QR 코드 생성 공통 함수
        function generateQRCode(chainCode, callback) {
            fetch('/hellking/qr/generateChainQR', {
>>>>>>> b65c320 (Initial commit)
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'chainCode=' + encodeURIComponent(chainCode)
            })
<<<<<<< HEAD
                .then(response => response.json())
                .then(data => {
                    showResult(data);
                    if(data.success) {
                        // 성공 시 폼 리셋하고 페이지 새로고침 (통계 업데이트)
                        document.getElementById('chainCode').value = '';
                        setTimeout(() => {
                            location.reload();
                        }, 2000);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showResult({
                        success: false,
                        message: '처리 중 오류가 발생했습니다.'
                    });
                });
        }
        
        // QR 코드 생성
        function generateQR() {
            fetch('${pageContext.request.contextPath}/qr/generateQR', {
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'data=ENTRY'
            })
                .then(response => response.json())
                .then(data => {
                    if(data.success) {
                        document.getElementById('qrImage').src = data.qrCode;
                        document.getElementById('qrDisplay').style.display = 'block';
                        currentQRData = 'ENTRY';
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('QR 코드 생성에 실패했습니다.');
                });
        }
        
        // QR 코드 다운로드
        function downloadQR() {
            if(currentQRData) {
                window.open('${pageContext.request.contextPath}/qr/downloadQR?data=' + encodeURIComponent(currentQRData));
            }
        }
        
        // 결과 표시
        function showResult(data) {
            const modal = new bootstrap.Modal(document.getElementById('resultModal'));
            const header = document.getElementById('modalHeader');
            const title = document.getElementById('modalTitle');
            const body = document.getElementById('modalBody');
            
            if(data.success) {
                header.className = 'modal-header bg-success text-white';
                title.textContent = '입장 성공';
                body.innerHTML = `
                    <div class="text-center">
                        <div class="display-1 text-success mb-3">✓</div>
                        <h4>${data.chainName}</h4>
                        <p class="text-muted">${data.chainAddress || ''}</p>
                        <p class="mt-3">${data.message}</p>
                    </div>
                `;
            } else {
                header.className = 'modal-header bg-danger text-white';
                title.textContent = '입장 실패';
                body.innerHTML = `
                    <div class="text-center">
                        <div class="display-1 text-danger mb-3">✗</div>
                        <p class="lead">${data.message}</p>
                        ${data.failureReason ? '<small class="text-muted">사유: ' + data.failureReason + '</small>' : ''}
                    </div>
                `;
            }
            
            modal.show();
        }
        
        // 코드 입력 시 자동 대문자 변환 및 숫자/문자만 허용
        document.getElementById('chainCode').addEventListener('input', function() {
            this.value = this.value.toUpperCase().replace(/[^A-Z0-9]/g, '');
        });
=======
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    callback(data.qrCode);
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('QR 코드 생성에 실패했습니다.');
            });
        }
        
        // 기존 가맹점 QR 생성 (모달로 표시)
        function generateChainQR(chainCode) {
            generateQRCode(chainCode, function(qrCodeBase64) {
                document.getElementById('modalQRImage').src = qrCodeBase64;
                document.getElementById('qrModalTitle').innerHTML = '<i class="fas fa-qrcode me-2"></i>' + chainCode + ' QR 코드';
                document.getElementById('modalQRInfo').textContent = chainCode + ' 가맹점 QR 코드';
                currentModalChainCode = chainCode;
                new bootstrap.Modal(document.getElementById('qrPreviewModal')).show();
            });
        }
        
        // 다운로드 함수들
        function downloadNewQR() {
            if (newGeneratedChainCode) {
                window.open('/hellking/qr/downloadChainQR?chainCode=' + encodeURIComponent(newGeneratedChainCode));
            }
        }
        
        function downloadChainQR(chainCode) {
            window.open('/hellking/qr/downloadChainQR?chainCode=' + encodeURIComponent(chainCode));
        }
        
        function downloadModalQR() {
            if (currentModalChainCode) {
                window.open('/hellking/qr/downloadChainQR?chainCode=' + encodeURIComponent(currentModalChainCode));
            }
        }
        
        // 인쇄 함수들
        function printNewQR() {
            if (newGeneratedChainCode) {
                const chainName = document.getElementById('chainName').value.trim() || newGeneratedChainCode + ' 가맹점';
                printQRCode(newGeneratedChainCode, chainName, document.getElementById('newQRImage').src);
            }
        }
        
        function printChainQR(chainCode, chainName) {
            generateQRCode(chainCode, function(qrCodeBase64) {
                printQRCode(chainCode, chainName, qrCodeBase64);
            });
        }
        
        function printModalQR() {
            if (currentModalChainCode) {
                printQRCode(currentModalChainCode, currentModalChainCode + ' 가맹점', document.getElementById('modalQRImage').src);
            }
        }
        
        // 공통 인쇄 함수
        function printQRCode(chainCode, chainName, qrImageSrc) {
            const printWindow = window.open('', '_blank');
            printWindow.document.write(`
                <html>
                <head>
                    <title>${chainCode} 가맹점 QR 코드</title>
                    <style>
                        body { 
                            display: flex; 
                            flex-direction: column; 
                            align-items: center; 
                            justify-content: center; 
                            min-height: 100vh; 
                            margin: 0; 
                            font-family: Arial, sans-serif;
                        }
                        .qr-container {
                            text-align: center;
                            border: 3px solid #6f42c1;
                            padding: 40px;
                            border-radius: 15px;
                            background: white;
                            box-shadow: 0 10px 30px rgba(111, 66, 193, 0.2);
                        }
                        .qr-title {
                            font-size: 28px;
                            font-weight: bold;
                            color: #6f42c1;
                            margin-bottom: 10px;
                        }
                        .qr-subtitle {
                            font-size: 20px;
                            color: #333;
                            margin-bottom: 30px;
                        }
                        .qr-image {
                            max-width: 350px;
                            margin-bottom: 30px;
                            border: 2px solid #eee;
                            padding: 10px;
                            border-radius: 10px;
                        }
                        .qr-instruction {
                            font-size: 16px;
                            color: #666;
                            line-height: 1.5;
                        }
                        .qr-code-text {
                            font-size: 24px;
                            font-weight: bold;
                            color: #6f42c1;
                            margin: 20px 0;
                            letter-spacing: 3px;
                        }
                    </style>
                </head>
                <body>
                    <div class="qr-container">
                        <div class="qr-title">헬킹 피트니스</div>
                        <div class="qr-subtitle">${chainName}</div>
                        <div class="qr-code-text">${chainCode}</div>
                        <img src="${qrImageSrc}" alt="QR Code" class="qr-image">
                        <div class="qr-instruction">
                            헬킹 피트니스 앱으로<br>
                            QR 코드를 스캔하여<br>
                            간편하게 입장하세요
                        </div>
                    </div>
                </body>
                </html>
            `);
            printWindow.document.close();
            printWindow.print();
        }
        
        // 모든 QR 코드 일괄 다운로드
        function downloadAllQR() {
            const chainCodes = ['GN01', 'GN02', 'GN03']; // 필요한 가맹점 코드들
            chainCodes.forEach((code, index) => {
                setTimeout(() => {
                    downloadChainQR(code);
                }, index * 500); // 0.5초 간격으로 다운로드
            });
        }
        
        // 입력 필드 이벤트
        document.getElementById('newChainCode').addEventListener('input', function() {
            this.value = this.value.toUpperCase().replace(/[^A-Z0-9]/g, '');
        });
        
        document.getElementById('newChainCode').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                generateNewQR();
            }
        });
        
        // 페이지 로드 애니메이션
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.card');
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(30px)';
                    card.style.transition = 'all 0.6s ease';
                    
                    requestAnimationFrame(() => {
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    });
                }, index * 100);
            });
        });
>>>>>>> b65c320 (Initial commit)
    </script>
</body>
</html>