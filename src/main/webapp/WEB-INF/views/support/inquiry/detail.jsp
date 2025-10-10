<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${inquiry.title} - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }
        
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
            --muted: #5B6170;
            --line: #E7E0D6;
            --hover: #FFF5EA;
        }
        
        .page-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
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
        
        .inquiry-container {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            border: 1px solid var(--line);
            margin: 30px 0;
        }
        
        .inquiry-title {
            color: var(--ink);
            font-weight: 700;
            font-size: 1.5rem;
            margin-bottom: 20px;
            line-height: 1.4;
        }
        
        .inquiry-meta {
            background: var(--bg-cream);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .inquiry-content {
            line-height: 1.8;
            color: var(--ink);
            font-size: 1.1rem;
            white-space: pre-line;
            border: 1px solid var(--line);
            border-radius: 12px;
            padding: 20px;
            background: #fafafa;
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
            color: var(--brand);
            width: 20px;
            margin-right: 10px;
        }
        
        .breadcrumb {
            background: transparent;
            padding: 0;
            margin-bottom: 20px;
        }
        
        .breadcrumb-item + .breadcrumb-item::before {
            color: var(--muted);
        }
        
        .attachment-list {
            background: var(--hover);
            border-radius: 12px;
            padding: 20px;
            margin-top: 20px;
        }
        
        .attachment-item {
            display: flex;
            align-items: center;
            padding: 10px;
            background: white;
            border-radius: 8px;
            margin-bottom: 10px;
            border: 1px solid var(--line);
        }
        
        .attachment-item:last-child {
            margin-bottom: 0;
        }
        
        .attachment-icon {
            color: var(--brand);
            margin-right: 10px;
            width: 20px;
        }
        
        .attachment-info {
            flex: 1;
        }
        
        .attachment-name {
            font-weight: 500;
            color: var(--ink);
        }
        
        .attachment-size {
            font-size: 0.875rem;
            color: var(--muted);
        }
        
        .reply-section {
            border-top: 2px solid var(--line);
            margin-top: 40px;
            padding-top: 30px;
        }
        
        .reply-item {
            background: #f8f9fa;
            border: 1px solid var(--line);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            position: relative;
        }
        
        .reply-item.admin-reply {
            background: var(--hover);
            border-color: var(--brand);
        }
        
        .reply-item.nested-reply {
            margin-left: 30px;
            border-left: 3px solid var(--brand);
        }
        
        .reply-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            font-size: 0.9rem;
            color: var(--muted);
        }
        
        .reply-author {
            font-weight: 600;
            color: var(--ink);
        }
        
        .reply-author.admin {
            color: var(--brand);
        }
        
        .reply-content {
            white-space: pre-line;
            line-height: 1.6;
        }
        
        .reply-actions {
            margin-top: 15px;
            border-top: 1px solid var(--line);
            padding-top: 15px;
        }
        
        .reply-form {
            background: var(--bg-cream);
            border-radius: 12px;
            padding: 25px;
            margin-top: 20px;
        }
        
        .reply-form.nested {
            margin-left: 30px;
            background: #f0f9ff;
            border-left: 3px solid var(--brand);
        }
        
        .form-control {
            border: 2px solid var(--line);
            border-radius: 8px;
        }
        
        .form-control:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 0.2rem rgba(255, 106, 0, 0.25);
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        
        .status-active {
            background: #d4edda;
            color: #155724;
        }
        
        .status-completed {
            background: #cce5ff;
            color: #004085;
        }
        
        .privacy-badge {
            background: #fff3cd;
            color: #856404;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
        }
        
        .privacy-badge.private {
            background: #f8d7da;
            color: #721c24;
        }
        
        .admin-badge {
            background: var(--brand);
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.7rem;
            margin-left: 8px;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        
        .btn-sm {
            padding: 5px 12px;
            font-size: 0.8rem;
        }
    </style>
</head>
<body>
    <jsp:include page="../../common/header.jsp" />
    
    <!-- 통일된 헤더 섹션 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" style="color: rgba(255,255,255,0.8);">홈</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/support/" style="color: rgba(255,255,255,0.8);">고객지원</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/support/inquiry" style="color: rgba(255,255,255,0.8);">문의사항</a></li>
                    <li class="breadcrumb-item active" style="color: white;">문의 상세</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">문의사항 상세정보</h2>
                    <p class="lead">회원들의 소중한 문의사항과 답변 내역</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/support/inquiry" class="btn btn-light btn-lg">
                        <i class="fas fa-list me-2"></i>문의 목록
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
                <div class="inquiry-container">
                    <c:if test="${not empty inquiry}">
                        <!-- 문의사항 제목 -->
                        <div class="d-flex justify-content-between align-items-start mb-3">
                            <h1 class="inquiry-title">${inquiry.title}</h1>
                            <div>
                                <span class="privacy-badge ${inquiry.isPrivate == 'Y' ? 'private' : ''}">
                                    <i class="fas fa-${inquiry.isPrivate == 'Y' ? 'lock' : 'globe'} me-1"></i>
                                    ${inquiry.isPrivate == 'Y' ? '비공개' : '공개'}
                                </span>
                                <span class="status-badge ${inquiry.replies != null && !inquiry.replies.isEmpty() ? 'status-completed' : 'status-active'}">
                                    ${inquiry.statusDisplayName}
                                </span>
                            </div>
                        </div>
                        
                        <!-- 문의사항 메타 정보 -->
                        <div class="inquiry-meta">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="meta-item">
                                        <i class="fas fa-user meta-icon"></i>
                                        <span>작성자: ${inquiry.createdByName}
                                            <c:if test="${inquiry.createdById == 'admin' || inquiry.createdById == 'aqunasl22'}">
                                                <span class="admin-badge">관리자</span>
                                            </c:if>
                                        </span>
                                    </div>
                                    <div class="meta-item">
                                        <i class="fas fa-calendar meta-icon"></i>
                                        <span>등록일: <fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy.MM.dd HH:mm"/></span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="meta-item">
                                        <i class="fas fa-eye meta-icon"></i>
                                        <span>조회수: ${inquiry.viewCount}</span>
                                    </div>
                                    <c:if test="${inquiry.updatedAt ne inquiry.createdAt}">
                                        <div class="meta-item">
                                            <i class="fas fa-edit meta-icon"></i>
                                            <span>수정일: <fmt:formatDate value="${inquiry.updatedAt}" pattern="yyyy.MM.dd HH:mm"/></span>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        
                        <!-- 문의사항 내용 -->
                        <div class="inquiry-content">
                            ${inquiry.content}
                        </div>
                        
                        <!-- 첨부파일 -->
                        <c:if test="${inquiry.hasAttachments() && not empty inquiry.attachments}">
                            <div class="attachment-list">
                                <h6 class="fw-bold mb-3">
                                    <i class="fas fa-paperclip me-2"></i>첨부파일 (${inquiry.attachments.size()}개)
                                </h6>
                                <c:forEach var="attachment" items="${inquiry.attachments}">
                                    <div class="attachment-item">
                                        <i class="fas fa-file attachment-icon"></i>
                                        <div class="attachment-info">
                                            <div class="attachment-name">${attachment.originalFilename}</div>
                                            <div class="attachment-size">${attachment.fileSizeDisplay}</div>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/support/inquiry/download/${attachment.attachmentNum}" 
                                           class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-download me-1"></i>다운로드
                                        </a>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                        
                        <!-- 원글 작성자/관리자 액션 버튼 -->
                        <c:if test="${inquiry.createdBy == currentUserNum || isAdmin}">
                            <div class="border-top pt-4 mt-4">
                                <div class="d-flex justify-content-between align-items-center">
                                    <span class="text-muted">
                                        <i class="fas fa-tools me-1"></i>
                                        <c:choose>
                                            <c:when test="${isAdmin && inquiry.createdBy != currentUserNum}">관리자 기능</c:when>
                                            <c:otherwise>작성자 기능</c:otherwise>
                                        </c:choose>
                                    </span>
                                    <div class="action-buttons">
                                        <!-- 수정은 본인만 가능 -->
                                        <c:if test="${inquiry.createdBy == currentUserNum}">
                                            <a href="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}/edit" 
                                               class="btn btn-outline-primary">
                                                <i class="fas fa-edit me-2"></i>수정
                                            </a>
                                        </c:if>
                                        <!-- 삭제는 본인 또는 관리자 -->
                                        <button type="button" class="btn btn-outline-danger" onclick="deleteInquiry()">
                                            <i class="fas fa-trash me-2"></i>삭제
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                        <!-- 답글 섹션 -->
                        <div class="reply-section" id="replies">
                            <h5 class="fw-bold mb-4">
                                <i class="fas fa-comments me-2"></i>답변 
                                <c:if test="${not empty inquiry.replies}">
                                    <span class="badge bg-primary">${inquiry.replies.size()}</span>
                                </c:if>
                            </h5>
                            
                            <!-- 답글 목록 -->
                            <c:choose>
                                <c:when test="${not empty inquiry.replies}">
                                    <c:forEach var="reply" items="${inquiry.replies}" varStatus="status">
                                        <div class="reply-item ${reply.createdById == 'admin' || reply.createdById == 'aqunasl22' ? 'admin-reply' : ''}" 
                                             id="reply-${reply.inquiryNum}">
                                            <div class="reply-meta">
                                                <div>
                                                    <span class="reply-author ${reply.createdById == 'admin' || reply.createdById == 'aqunasl22' ? 'admin' : ''}">
                                                        ${reply.createdByName}
                                                        <c:if test="${reply.createdById == 'admin' || reply.createdById == 'aqunasl22'}">
                                                            <span class="admin-badge">관리자</span>
                                                        </c:if>
                                                    </span>
                                                    <span class="ms-2">
                                                        <fmt:formatDate value="${reply.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
                                                    </span>
                                                </div>
                                                <span class="badge bg-secondary">#${status.count}</span>
                                            </div>
                                            <div class="reply-content">${reply.content}</div>
                                            
                                            <!-- 답글 액션 버튼 -->
                                            <div class="reply-actions">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <div>
                                                        <button type="button" class="btn btn-sm btn-outline-primary" 
                                                                onclick="showReplyForm(${reply.inquiryNum})">
                                                            <i class="fas fa-reply me-1"></i>답글
                                                        </button>
                                                        <!-- 본인 답글만 수정/삭제 가능 -->
                                                        <c:if test="${reply.createdBy == currentUserNum}">
                                                            <button type="button" class="btn btn-sm btn-outline-secondary ms-2" 
                                                                    onclick="editReply(${reply.inquiryNum})">
                                                                <i class="fas fa-edit me-1"></i>수정
                                                            </button>
                                                            <button type="button" class="btn btn-sm btn-outline-danger ms-2" 
                                                                    onclick="deleteReply(${reply.inquiryNum})">
                                                                <i class="fas fa-trash me-1"></i>삭제
                                                            </button>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                
                                                <!-- 답글의 답글 폼 (숨김 상태) -->
                                                <div id="reply-form-${reply.inquiryNum}" class="reply-form nested" style="display: none;">
                                                    <h6 class="fw-bold mb-3">
                                                        <i class="fas fa-reply me-2"></i>${reply.createdByName}님에게 답글
                                                    </h6>
                                                    <form method="post" action="${pageContext.request.contextPath}/support/inquiry/${reply.inquiryNum}/reply">
                                                        <div class="mb-3">
                                                            <textarea class="form-control" name="content" rows="3"
                                                                      placeholder="답글을 입력해주세요..." required></textarea>
                                                        </div>
                                                        <div class="d-flex justify-content-end gap-2">
                                                            <button type="button" class="btn btn-sm btn-secondary" 
                                                                    onclick="hideReplyForm(${reply.inquiryNum})">취소</button>
                                                            <button type="submit" class="btn btn-sm btn-brand">
                                                                <i class="fas fa-paper-plane me-1"></i>답글 등록
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-4 text-muted">
                                        <i class="fas fa-comment-slash fa-2x mb-3"></i>
                                        <p>아직 답변이 없습니다.</p>
                                        <c:if test="${isAdmin}">
                                            <p class="mb-0">관리자 권한으로 첫 번째 답변을 작성해보세요.</p>
                                        </c:if>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            
                            <!-- 메인 답글 작성 폼 (로그인한 사용자만) -->
                            <c:if test="${not empty currentUserNum}">
                                <div class="reply-form">
                                    <h6 class="fw-bold mb-3">
                                        <i class="fas fa-reply me-2"></i>답변 작성
                                    </h6>
                                    <form method="post" action="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}/reply" id="replyForm">
                                        <div class="mb-3">
                                            <textarea class="form-control" id="replyContent" name="content" rows="4"
                                                      placeholder="답변 내용을 입력해주세요..." required></textarea>
                                            <div class="char-counter text-end mt-2">
                                                <span id="replyCount">0</span>자
                                            </div>
                                        </div>
                                        <div class="d-flex justify-content-end">
                                            <button type="submit" class="btn btn-brand">
                                                <i class="fas fa-paper-plane me-2"></i>답변 등록
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                    </c:if>
                </div>
                
                <!-- 네비게이션 버튼 -->
                <div class="d-flex justify-content-between align-items-center">
                    <a href="${pageContext.request.contextPath}/support/inquiry" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>문의사항 목록
                    </a>
                    <div>
                        <a href="${pageContext.request.contextPath}/support/" class="btn btn-outline-primary me-2">
                            <i class="fas fa-home me-2"></i>고객지원 홈
                        </a>
                        <a href="${pageContext.request.contextPath}/support/inquiry/create" class="btn btn-brand">
                            <i class="fas fa-plus me-2"></i>새 문의 작성
                        </a>
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
                        <i class="fas fa-exclamation-triangle text-danger me-2"></i>문의사항 삭제 확인
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p class="mb-3">정말로 이 문의사항을 삭제하시겠습니까?</p>
                    <div class="alert alert-warning">
                        <strong>주의:</strong> 삭제된 문의사항과 모든 답변은 복구할 수 없습니다.
                    </div>
                    <div class="bg-light p-3 rounded">
                        <strong>삭제할 문의사항:</strong><br>
                        ${inquiry.title}
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <form method="post" action="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}/delete" style="display: inline;">
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
        // 답글 글자수 카운터
        document.addEventListener('DOMContentLoaded', function() {
            const replyContent = document.getElementById('replyContent');
            const replyCount = document.getElementById('replyCount');
            
            if (replyContent && replyCount) {
                replyContent.addEventListener('input', function() {
                    replyCount.textContent = this.value.length;
                });
            }
        });
        
        // 문의사항 삭제 확인
        function deleteInquiry() {
            new bootstrap.Modal(document.getElementById('deleteModal')).show();
        }
        
        // 답글 폼 표시/숨김
        function showReplyForm(parentId) {
            // 모든 답글 폼 숨김
            document.querySelectorAll('[id^="reply-form-"]').forEach(form => {
                form.style.display = 'none';
            });
            
            // 해당 답글 폼 표시
            const form = document.getElementById('reply-form-' + parentId);
            if (form) {
                form.style.display = 'block';
                form.querySelector('textarea').focus();
            }
        }
        
        function hideReplyForm(parentId) {
            const form = document.getElementById('reply-form-' + parentId);
            if (form) {
                form.style.display = 'none';
                form.querySelector('textarea').value = '';
            }
        }
        
        // 답글 수정 (향후 구현)
        function editReply(replyId) {
            alert('답글 수정 기능은 곧 구현될 예정입니다.');
            // 실제 구현시에는 인라인 에디터나 별도 페이지로 이동
        }
        
        // 답글 삭제
        function deleteReply(replyId) {
            if (confirm('이 답글을 삭제하시겠습니까?\n삭제된 답글은 복구할 수 없습니다.')) {
                // AJAX로 삭제 요청 또는 폼 제출
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/support/inquiry/' + replyId + '/delete';
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // 답글 폼 유효성 검사
        const replyForm = document.getElementById('replyForm');
        if (replyForm) {
            replyForm.addEventListener('submit', function(e) {
                const content = document.getElementById('replyContent').value.trim();
                
                if (!content) {
                    e.preventDefault();
                    alert('답변 내용을 입력해주세요.');
                    document.getElementById('replyContent').focus();
                    return;
                }
                
                // 제출 버튼 비활성화
                const submitBtn = this.querySelector('button[type="submit"]');
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>등록 중...';
            });
        }
        
        // 첨부파일 다운로드 로그
        document.querySelectorAll('a[href*="/download/"]').forEach(link => {
            link.addEventListener('click', function() {
                console.log('파일 다운로드:', this.href);
            });
        });
        
        // 키보드 단축키
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey || e.metaKey) {
                switch(e.key) {
                    case 'r':
                        e.preventDefault();
                        const replyTextarea = document.getElementById('replyContent');
                        if (replyTextarea) {
                            replyTextarea.focus();
                        }
                        break;
                    case 'e':
                        if (${inquiry.createdBy == currentUserNum}) {
                            e.preventDefault();
                            window.location.href = '${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}/edit';
                        }
                        break;
                }
            }
            
            if (e.key === 'Escape') {
                // 열린 답글 폼들 모두 닫기
                document.querySelectorAll('[id^="reply-form-"]').forEach(form => {
                    form.style.display = 'none';
                });
            }
        });
        
        // 답글 스크롤 애니메이션
        function scrollToReplies() {
            document.querySelector('.reply-section').scrollIntoView({ 
                behavior: 'smooth' 
            });
        }
        
        // URL에 #replies가 있으면 답글 섹션으로 스크롤
        if (window.location.hash === '#replies') {
            setTimeout(scrollToReplies, 100);
        }
    </script>
</body>
</html>