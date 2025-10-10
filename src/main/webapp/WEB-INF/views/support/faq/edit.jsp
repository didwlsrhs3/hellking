<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FAQ 수정 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        .page-header {
            background: linear-gradient(135deg, #fd7e14, #f39c12);
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
            min-height: 300px;
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
        
        .faq-meta {
            background: rgba(253,126,20,0.1);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            border: 1px solid rgba(253,126,20,0.2);
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
            color: #fd7e14;
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
    
    <!-- FAQ 수정 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">홈</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/support/">고객지원</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/support/faq">FAQ</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/support/faq/${faq.faqNum}">FAQ 상세</a></li>
                    <li class="breadcrumb-item active">수정</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">FAQ 수정</h2>
                    <p class="lead">기존 FAQ 내용을 수정하여 최신 정보로 업데이트하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/support/faq/${faq.faqNum}" class="btn btn-outline-light">
                        <i class="fas fa-arrow-left me-2"></i>상세보기로
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <!-- FAQ 정보 -->
                <div class="faq-meta">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="meta-item">
                                <i class="fas fa-user meta-icon"></i>
                                <span>작성자: ${faq.createdByName}</span>
                            </div>
                            <div class="meta-item">
                                <i class="fas fa-calendar meta-icon"></i>
                                <span>등록일: <fmt:formatDate value="${faq.createdAt}" pattern="yyyy.MM.dd HH:mm"/></span>
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
                                    <span>최종 수정: <fmt:formatDate value="${faq.updatedAt}" pattern="yyyy.MM.dd HH:mm"/></span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
                
                <div class="form-container">
                    <form method="post" action="${pageContext.request.contextPath}/support/faq/${faq.faqNum}/edit" id="faqEditForm">
                        <!-- 제목 -->
                        <div class="mb-4">
                            <label for="title" class="form-label">
                                제목 <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="title" name="title" 
                                   value="${faq.title}" placeholder="FAQ 제목을 입력하세요" maxlength="200" required>
                            <div class="char-counter">
                                <span id="titleCount">${faq.title.length()}</span>/200자
                            </div>
                        </div>
                        
                        <!-- 내용 -->
                        <div class="mb-4">
                            <label for="content" class="form-label">
                                내용 <span class="required">*</span>
                            </label>
                            <textarea class="form-control content-editor" id="content" name="content" 
                                      placeholder="FAQ 내용을 상세히 작성해주세요. 고객이 이해하기 쉽도록 구체적으로 설명해주세요." 
                                      required>${faq.content}</textarea>
                            <div class="char-counter">
                                <span id="contentCount">${faq.content.length()}</span>자
                            </div>
                        </div>
                        
                        <!-- 수정 가이드 -->
                        <div class="alert alert-info">
                            <h6 class="fw-bold mb-2">
                                <i class="fas fa-lightbulb me-2"></i>FAQ 수정 가이드
                            </h6>
                            <ul class="mb-0">
                                <li>최신 정보와 정책을 반영하여 수정해주세요</li>
                                <li>고객이 이해하기 쉽도록 명확하고 정확한 표현을 사용해주세요</li>
                                <li>변경된 내용이 있다면 구체적으로 안내해주세요</li>
                                <li>오타나 문법 오류가 없는지 확인해주세요</li>
                            </ul>
                        </div>
                        
                        <!-- 버튼 -->
                        <div class="d-flex justify-content-between">
                            <div>
                                <a href="${pageContext.request.contextPath}/support/faq/${faq.faqNum}" class="btn btn-outline-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>취소
                                </a>
                                <button type="button" class="btn btn-outline-danger ms-2" onclick="resetForm()">
                                    <i class="fas fa-undo me-2"></i>원래대로
                                </button>
                            </div>
                            <div>
                                <button type="button" class="btn btn-outline-primary me-2" onclick="previewFAQ()">
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
                    <h5 class="modal-title">FAQ 미리보기</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="preview-content">
                        <h6 class="fw-bold text-primary">제목</h6>
                        <p id="previewTitle" class="border-bottom pb-2"></p>
                        
                        <h6 class="fw-bold text-primary mt-3">내용</h6>
                        <div id="previewContent" style="white-space: pre-line;"></div>
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
        const originalTitle = '${faq.title}';
        const originalContent = '${faq.content}';
        
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
        function previewFAQ() {
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
            document.getElementById('faqEditForm').submit();
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
        document.getElementById('faqEditForm').addEventListener('submit', function(e) {
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
        document.getElementById('faqEditForm').addEventListener('submit', () => formChanged = false);
        
        // 키보드 단축키
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey || e.metaKey) {
                switch(e.key) {
                    case 's':
                        e.preventDefault();
                        document.getElementById('faqEditForm').submit();
                        break;
                    case 'p':
                        e.preventDefault();
                        previewFAQ();
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