<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>문의사항 수정 - 헬킹 피트니스</title>
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
            background: linear-gradient(135deg, #fd7e14, #f39c12);
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
        
        .form-container {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            border: 1px solid var(--line);
            margin: 30px 0;
        }
        
        .btn-brand {
            background: var(--brand);
            border-color: var(--brand);
            color: white;
            font-weight: 600;
            padding: 12px 30px;
            border-radius: 8px;
        }
        
        .btn-brand:hover {
            background: #e55a00;
            border-color: #e55a00;
            color: white;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--ink);
            margin-bottom: 8px;
        }
        
        .form-control {
            border: 2px solid var(--line);
            border-radius: 8px;
            padding: 12px 16px;
        }
        
        .form-control:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 0.2rem rgba(255, 106, 0, 0.25);
        }
        
        .alert-info {
            background: var(--hover);
            border: 1px solid var(--brand);
            color: var(--ink);
        }
        
        .content-editor {
            min-height: 200px;
            resize: vertical;
        }
        
        .char-counter {
            font-size: 0.875rem;
            color: var(--muted);
            text-align: right;
            margin-top: 5px;
        }
        
        .required {
            color: var(--brand);
        }
        
        .inquiry-meta {
            background: var(--bg-cream);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
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
        
        .current-attachments {
            background: var(--hover);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
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
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}" style="color: rgba(255,255,255,0.8);">문의 상세</a></li>
                    <li class="breadcrumb-item active" style="color: white;">수정</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">문의사항 수정</h2>
                    <p class="lead">작성한 문의사항을 수정하여 더 나은 후기를 완성하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}" class="btn btn-light btn-lg">
                        <i class="fas fa-arrow-left me-2"></i>상세보기로
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- 문의사항 정보 -->
                <div class="inquiry-meta">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <h6 class="fw-bold mb-0">문의사항 정보</h6>
                        <div>
                            <span class="privacy-badge ${inquiry.isPrivate == 'Y' ? 'private' : ''}">
                                <i class="fas fa-${inquiry.isPrivate == 'Y' ? 'lock' : 'globe'} me-1"></i>
                                ${inquiry.isPrivate == 'Y' ? '비공개' : '공개'}
                            </span>
                            <span class="status-badge status-active ms-2">
                                ${inquiry.statusDisplayName}
                            </span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="meta-item">
                                <i class="fas fa-user meta-icon"></i>
                                <span>작성자: ${inquiry.createdByName}</span>
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
                                    <span>최종 수정: <fmt:formatDate value="${inquiry.updatedAt}" pattern="yyyy.MM.dd HH:mm"/></span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
                
                <!-- 기존 첨부파일 -->
                <c:if test="${inquiry.hasAttachments() && not empty inquiry.attachments}">
                    <div class="current-attachments">
                        <h6 class="fw-bold mb-3">
                            <i class="fas fa-paperclip me-2"></i>현재 첨부파일 (${inquiry.attachments.size()}개)
                        </h6>
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <strong>참고:</strong> 기존 첨부파일은 수정할 수 없습니다. 새로운 파일이 필요한 경우 새 문의를 작성해주세요.
                        </div>
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
                
                <div class="form-container">
                    <form method="post" action="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}/edit" id="inquiryEditForm">
                        <!-- 제목 -->
                        <div class="mb-4">
                            <label for="title" class="form-label">
                                문의 제목 <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="title" name="title" 
                                   value="${inquiry.title}" placeholder="문의 제목을 간단명료하게 입력해주세요" maxlength="200" required>
                            <div class="char-counter">
                                <span id="titleCount">${inquiry.title.length()}</span>/200자
                            </div>
                        </div>
                        
                        <!-- 내용 -->
                        <div class="mb-4">
                            <label for="content" class="form-label">
                                문의 내용 <span class="required">*</span>
                            </label>
                            <textarea class="form-control content-editor" id="content" name="content" 
                                      placeholder="문의하실 내용을 자세히 작성해주세요." required>${inquiry.content}</textarea>
                            <div class="char-counter">
                                <span id="contentCount">${inquiry.content.length()}</span>자
                            </div>
                        </div>
                        
                        <!-- 수정 안내 -->
                        <div class="alert alert-info">
                            <h6 class="fw-bold mb-2">
                                <i class="fas fa-info-circle me-2"></i>문의사항 수정 안내
                            </h6>
                            <ul class="mb-0">
                                <li><strong>제목과 내용만 수정 가능:</strong> 공개 설정과 첨부파일은 수정할 수 없습니다</li>
                                <li><strong>답변 후 수정 시:</strong> 기존 답변과 맞지 않을 수 있으니 신중히 수정해주세요</li>
                                <li><strong>중요한 변경사항:</strong> 새로운 파일이나 완전히 다른 문의는 새 문의로 작성을 권장합니다</li>
                                <li><strong>수정 기록:</strong> 수정 시간이 기록되어 관리자가 확인할 수 있습니다</li>
                            </ul>
                        </div>
                        
                        <!-- 답변 확인 -->
                        <c:if test="${not empty inquiry.replies}">
                            <div class="alert alert-warning">
                                <h6 class="fw-bold mb-2">
                                    <i class="fas fa-comments me-2"></i>답변 확인 필요
                                </h6>
                                <p class="mb-0">이 문의사항에는 이미 <strong>${inquiry.replies.size()}개의 답변</strong>이 있습니다. 
                                수정 시 기존 답변과 내용이 맞지 않을 수 있으니 신중히 검토 후 수정해주세요.</p>
                            </div>
                        </c:if>
                        
                        <!-- 버튼 -->
                        <div class="d-flex justify-content-between">
                            <div>
                                <a href="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>취소
                                </a>
                                <button type="button" class="btn btn-outline-danger ms-2" onclick="resetForm()">
                                    <i class="fas fa-undo me-2"></i>원래대로
                                </button>
                            </div>
                            <div>
                                <button type="button" class="btn btn-outline-primary me-2" onclick="previewInquiry()">
                                    <i class="fas fa-eye me-2"></i>미리보기
                                </button>
                                <button type="submit" class="btn btn-brand">
                                    <i class="fas fa-save me-2"></i>수정 완료
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 미리보기 모달 -->
    <div class="modal fade" id="previewModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">문의사항 미리보기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="preview-content">
                        <div class="mb-3">
                            <h6 class="fw-bold text-primary">제목</h6>
                            <p id="previewTitle" class="border-bottom pb-2"></p>
                        </div>
                        
                        <div class="mb-3">
                            <h6 class="fw-bold text-primary">공개 설정</h6>
                            <p>${inquiry.isPrivate == 'Y' ? '🔒 비공개' : '🌍 공개'}</p>
                        </div>
                        
                        <div class="mb-3">
                            <h6 class="fw-bold text-primary">내용</h6>
                            <div id="previewContent" style="white-space: pre-line; border: 1px solid #dee2e6; padding: 15px; border-radius: 8px; background: #f8f9fa;"></div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-brand" onclick="submitForm()">이대로 수정</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 원래대로 되돌리기 확인 모달 -->
    <div class="modal fade" id="resetModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-exclamation-triangle text-warning me-2"></i>원래대로 되돌리기
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <p>현재 수정 중인 내용을 모두 취소하고 원래 내용으로 되돌리시겠습니까?</p>
                    <div class="alert alert-warning">
                        <strong>주의:</strong> 수정 중인 모든 내용이 사라집니다.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-warning" onclick="confirmReset()">
                        <i class="fas fa-undo me-2"></i>원래대로
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../../common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 원본 데이터 저장
        const originalTitle = '${inquiry.title}';
        const originalContent = '${inquiry.content}';
        
        // 글자수 카운터
        document.addEventListener('DOMContentLoaded', function() {
            const titleInput = document.getElementById('title');
            const contentInput = document.getElementById('content');
            const titleCount = document.getElementById('titleCount');
            const contentCount = document.getElementById('contentCount');
            
            titleInput.addEventListener('input', function() {
                titleCount.textContent = this.value.length;
                if (this.value.length > 190) {
                    titleCount.style.color = 'var(--brand)';
                } else {
                    titleCount.style.color = 'var(--muted)';
                }
            });
            
            contentInput.addEventListener('input', function() {
                contentCount.textContent = this.value.length;
            });
        });
        
        // 미리보기 기능
        function previewInquiry() {
            const title = document.getElementById('title').value;
            const content = document.getElementById('content').value;
            
            if (!title.trim()) {
                alert('제목을 입력해주세요.');
                document.getElementById('title').focus();
                return;
            }
            
            if (!content.trim()) {
                alert('내용을 입력해주세요.');
                document.getElementById('content').focus();
                return;
            }
            
            document.getElementById('previewTitle').textContent = title;
            document.getElementById('previewContent').textContent = content;
            
            new bootstrap.Modal(document.getElementById('previewModal')).show();
        }
        
        // 폼 제출
        function submitForm() {
            document.getElementById('inquiryEditForm').submit();
        }
        
        // 원래대로 되돌리기
        function resetForm() {
            const currentTitle = document.getElementById('title').value;
            const currentContent = document.getElementById('content').value;
            
            if (currentTitle !== originalTitle || currentContent !== originalContent) {
                new bootstrap.Modal(document.getElementById('resetModal')).show();
            } else {
                alert('변경된 내용이 없습니다.');
            }
        }
        
        function confirmReset() {
            document.getElementById('title').value = originalTitle;
            document.getElementById('content').value = originalContent;
            
            // 글자수 카운터 업데이트
            document.getElementById('titleCount').textContent = originalTitle.length;
            document.getElementById('contentCount').textContent = originalContent.length;
            
            // 모달 닫기
            bootstrap.Modal.getInstance(document.getElementById('resetModal')).hide();
            
            // 변경 상태 초기화
            formChanged = false;
            
            alert('원래 내용으로 되돌렸습니다.');
        }
        
        // 폼 유효성 검사
        document.getElementById('inquiryEditForm').addEventListener('submit', function(e) {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            
            if (!title) {
                e.preventDefault();
                alert('제목을 입력해주세요.');
                document.getElementById('title').focus();
                return;
            }
            
            if (!content) {
                e.preventDefault();
                alert('내용을 입력해주세요.');
                document.getElementById('content').focus();
                return;
            }
            
            if (title.length > 200) {
                e.preventDefault();
                alert('제목은 200자를 초과할 수 없습니다.');
                document.getElementById('title').focus();
                return;
            }
            
            // 변경사항 확인
            if (title === originalTitle && content === originalContent) {
                e.preventDefault();
                alert('변경된 내용이 없습니다.');
                return;
            }
            
            // 제출 버튼 비활성화
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>수정 중...';
        });
        
        // 페이지 벗어날 때 확인
        let formChanged = false;
        
        document.getElementById('title').addEventListener('input', function() {
            formChanged = this.value !== originalTitle;
        });
        
        document.getElementById('content').addEventListener('input', function() {
            formChanged = this.value !== originalContent;
        });
        
        window.addEventListener('beforeunload', function(e) {
            if (formChanged) {
                e.preventDefault();
                e.returnValue = '';
            }
        });
        
        // 폼 제출 시에는 경고 해제
        document.getElementById('inquiryEditForm').addEventListener('submit', () => formChanged = false);
        
        // 키보드 단축키
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey || e.metaKey) {
                switch(e.key) {
                    case 's':
                        e.preventDefault();
                        document.getElementById('inquiryEditForm').submit();
                        break;
                    case 'p':
                        e.preventDefault();
                        previewInquiry();
                        break;
                    case 'z':
                        if (e.shiftKey) {
                            e.preventDefault();
                            resetForm();
                        }
                        break;
                }
            }
        });
    </script>
</body>
</html>