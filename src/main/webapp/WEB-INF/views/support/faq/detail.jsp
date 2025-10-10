<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${faq.title} - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        .page-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 60px 0;
        }
        
        :root {
            --brand: #FF6A00;
            --ink: #0F172A;
            --muted: #5B6170;
            --line: #E7E0D6;
            --hover: #FFF5EA;
        }
        
        .faq-container {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            border: 1px solid var(--line);
            margin: 30px 0;
        }
        
        .faq-title {
            color: var(--ink);
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 20px;
            line-height: 1.4;
        }
        
        .faq-meta {
            background: rgba(240,248,255,0.5);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            border: 1px solid rgba(0,123,255,0.1);
        }
        
        .faq-content {
            line-height: 1.8;
            color: var(--ink);
            font-size: 1.1rem;
            white-space: pre-line;
        }
        
        .btn-brand {
            background: var(--brand);
            border-color: var(--brand);
            color: white;
            font-weight: 600;
        }
        
        .btn-brand:hover {
            background: #e55a00;
            border-color: #e55a00;
            color: white;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .meta-item:last-child {
            margin-bottom: 0;
        }
        
        .meta-icon {
            color: #007bff;
            width: 20px;
            margin-right: 10px;
        }
        
        .breadcrumb {
            background: transparent;
            padding: 0;
            margin-bottom: 20px;
        }
        
        .breadcrumb-item + .breadcrumb-item::before {
            color: rgba(255,255,255,0.6);
        }
        
        .breadcrumb-item a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
        }
        
        .breadcrumb-item a:hover {
            color: white;
        }
        
        .breadcrumb-item.active {
            color: rgba(255,255,255,0.9);
        }
        
        .navigation-buttons {
            background: rgba(240,248,255,0.5);
            border-radius: 12px;
            padding: 20px;
            margin-top: 40px;
            border: 1px solid rgba(0,123,255,0.1);
        }
        
        .alert-success {
            background: var(--hover);
            border: 1px solid var(--brand);
            color: var(--ink);
        }
        
        .delete-form {
            display: inline;
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
        }
    </style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />
    
    <!-- FAQ 상세보기 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">홈</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/support/">고객지원</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/support/faq">FAQ</a></li>
                    <li class="breadcrumb-item active">FAQ 상세</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">자주 묻는 질문</h2>
                    <p class="lead">궁금한 점을 빠르게 해결해보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/support/faq" class="btn btn-outline-light">
                        <i class="fas fa-list me-2"></i>FAQ 목록
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <!-- 성공 메시지 -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <!-- 에러 메시지 -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="faq-container">
                    <c:if test="${not empty faq}">
                        <!-- FAQ 제목 -->
                        <h1 class="faq-title">${faq.title}</h1>
                        
                        <!-- FAQ 메타 정보 -->
                        <div class="faq-meta">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="meta-item">
                                        <i class="fas fa-user meta-icon"></i>
                                        <span>작성자: ${faq.createdByName}</span>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fas fa-calendar meta-icon"></i>
                                        <span>등록일: <fmt:formatDate value="${faq.createdAt}" pattern="yyyy.MM.dd"/></span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="meta-item">
                                        <i class="fas fa-eye meta-icon"></i>
                                        <span>조회수: ${faq.viewCount}</span>
                                    </div>
                                    <c:if test="${faq.updatedAt ne faq.createdAt}">
                                        <div class="meta-item">
                                            <i class="fas fa-edit meta-icon"></i>
                                            <span>수정일: <fmt:formatDate value="${faq.updatedAt}" pattern="yyyy.MM.dd"/></span>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        
                        <!-- FAQ 내용 -->
                        <div class="faq-content">
                            ${faq.content}
                        </div>
                        
                        <!-- 관리자 액션 버튼 -->
                        <c:if test="${isAdmin}">
                            <div class="border-top pt-4 mt-4">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="text-muted">
                                        <i class="fas fa-shield-alt me-1"></i>관리자 전용 기능
                                    </span>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/support/faq/${faq.faqNum}/edit" 
                                           class="btn btn-outline-primary me-2">
                                            <i class="fas fa-edit me-2"></i>수정
                                        </a>
                                        <button type="button" class="btn btn-outline-danger" onclick="deleteFAQ()">
                                            <i class="fas fa-trash me-2"></i>삭제
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:if>
                </div>
                
                <!-- 네비게이션 버튼 -->
                <div class="navigation-buttons">
                    <div class="d-flex justify-content-between align-items-center">
                        <a href="${pageContext.request.contextPath}/support/faq" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>FAQ 목록으로
                        </a>
                        <div>
                            <a href="${pageContext.request.contextPath}/support/" class="btn btn-outline-primary me-2">
                                <i class="fas fa-home me-2"></i>고객지원 홈
                            </a>
                            <c:if test="${isAdmin}">
                                <a href="${pageContext.request.contextPath}/support/faq/create" class="btn btn-brand">
                                    <i class="fas fa-plus me-2"></i>새 FAQ 작성
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 삭제 확인 모달 -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle text-danger me-2"></i>FAQ 삭제 확인
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p class="mb-3">정말로 이 FAQ를 삭제하시겠습니까?</p>
                    <div class="alert alert-warning">
                        <strong>주의:</strong> 삭제된 FAQ는 복구할 수 없습니다.
                    </div>
                    <div class="bg-light p-3 rounded">
                        <strong>삭제할 FAQ:</strong><br>
                        ${faq.title}
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <form method="post" action="${pageContext.request.contextPath}/support/faq/${faq.faqNum}/delete" class="delete-form">
                        <button type="submit" class="btn btn-danger">
                            <i class="fas fa-trash me-2"></i>삭제하기
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../../common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // FAQ 삭제 확인
        function deleteFAQ() {
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
        
        // 삭제 폼 제출 시 로딩 표시
        document.querySelector('.delete-form').addEventListener('submit', function() {
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>삭제 중...';
        });
        
        // 뒤로가기 버튼 처리
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape') {
                window.location.href = '${pageContext.request.contextPath}/support/faq';
            }
        });
        
        // 인쇄 기능
        function printFAQ() {
            const printWindow = window.open('', '_blank');
            const faqTitle = '${faq.title}';
            const faqContent = '${faq.content}';
            const createdAt = '<fmt:formatDate value="${faq.createdAt}" pattern="yyyy.MM.dd"/>';
            
            printWindow.document.write(`
                <html>
                <head>
                    <title>FAQ - ${faq.title}</title>
                    <style>
                        body { font-family: Arial, sans-serif; margin: 40px; }
                        .header { border-bottom: 2px solid #007bff; padding-bottom: 20px; margin-bottom: 30px; }
                        .title { font-size: 24px; font-weight: bold; margin-bottom: 10px; }
                        .meta { color: #666; font-size: 14px; }
                        .content { line-height: 1.8; white-space: pre-line; }
                    </style>
                </head>
                <body>
                    <div class="header">
                        <div class="title">${faq.title}</div>
                        <div class="meta">헬킹 피트니스 FAQ · ${createdAt}</div>
                    </div>
                    <div class="content">${faq.content}</div>
                </body>
                </html>
            `);
            printWindow.document.close();
            printWindow.print();
        }
        
        // 공유 기능
        function shareFAQ() {
            if (navigator.share) {
                navigator.share({
                    title: '${faq.title}',
                    text: 'FAQ - ${faq.title}',
                    url: window.location.href
                });
            } else {
                // 클립보드에 URL 복사
                navigator.clipboard.writeText(window.location.href).then(function() {
                    alert('URL이 클립보드에 복사되었습니다.');
                });
            }
        }
        
        // 키보드 단축키
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey || e.metaKey) {
                switch(e.key) {
                    case 'p':
                        e.preventDefault();
                        printFAQ();
                        break;
                    case 'e':
                        if (${isAdmin}) {
                            e.preventDefault();
                            window.location.href = '${pageContext.request.contextPath}/support/faq/${faq.faqNum}/edit';
                        }
                        break;
                }
            }
        });
    </script>
</body>
</html>