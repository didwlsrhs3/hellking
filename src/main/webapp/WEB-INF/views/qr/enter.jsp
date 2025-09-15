<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
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
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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
                method: 'POST',
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                body: 'chainCode=' + encodeURIComponent(chainCode)
            })
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
    </script>
</body>
</html>