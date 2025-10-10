<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>FAQ 등록 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        .page-header {
            background: linear-gradient(135deg, #28a745, #20c997);
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
    
    <!-- FAQ 등록 헤더 -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">FAQ 등록</h2>
                    <p class="lead">자주 묻는 질문을 등록하여 고객들에게 유용한 정보를 제공하세요</p>
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
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-container">
                    <!-- 성공/에러 메시지 표시 -->
                    <c:if test="${not empty successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <form method="post" action="${pageContext.request.contextPath}/support/faq/create" id="faqForm">
                        <!-- 제목 -->
                        <div class="mb-4">
                            <label for="title" class="form-label">
                                제목 <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="title" name="title" 
                                   placeholder="FAQ 제목을 입력하세요" maxlength="200" required>
                            <div class="char-counter">
                                <span id="titleCount">0</span>/200자
                            </div>
                        </div>
                        
                        <!-- 내용 -->
                        <div class="mb-4">
                            <label for="content" class="form-label">
                                내용 <span class="required">*</span>
                            </label>
                            <textarea class="form-control content-editor" id="content" name="content" 
                                      placeholder="FAQ 내용을 상세히 작성해주세요. 고객이 이해하기 쉽도록 구체적으로 설명해주세요." 
                                      required></textarea>
                            <div class="char-counter">
                                <span id="contentCount">0</span>자
                            </div>
                        </div>
                        
                        <!-- 작성 가이드 -->
                        <div class="alert alert-info">
                            <h6 class="fw-bold mb-2">
                                <i class="fas fa-lightbulb me-2"></i>FAQ 작성 가이드
                            </h6>
                            <ul class="mb-0">
                                <li>고객이 자주 묻는 질문을 명확하고 이해하기 쉽게 작성해주세요</li>
                                <li>단계별 설명이나 예시를 포함하면 더욱 유용합니다</li>
                                <li>관련 정책이나 규정이 있다면 함께 안내해주세요</li>
                                <li>답변은 정확하고 최신 정보를 바탕으로 작성해주세요</li>
                            </ul>
                        </div>
                        
                        <!-- 버튼 -->
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/support/faq" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>취소
                            </a>
                            <div>
                                <button type="button" class="btn btn-outline-primary me-2" onclick="previewFAQ()">
                                    <i class="fas fa-eye me-2"></i>미리보기
                                </button>
                                <button type="submit" class="btn btn-brand">
                                    <i class="fas fa-save me-2"></i>등록하기
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
                    <button type="button" class="btn btn-brand" onclick="submitForm()">이대로 등록</button>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../../common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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
            document.getElementById('faqForm').submit();
        }
        
        // 폼 유효성 검사
        document.getElementById('faqForm').addEventListener('submit', function(e) {
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
            
            // 제출 버튼 비활성화
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>등록 중...';
        });
        
        // 페이지 벗어날 때 확인
        let formChanged = false;
        
        document.getElementById('title').addEventListener('input', () => formChanged = true);
        document.getElementById('content').addEventListener('input', () => formChanged = true);
        
        window.addEventListener('beforeunload', function(e) {
            if (formChanged) {
                e.preventDefault();
                e.returnValue = '';
            }
        });
        
        // 폼 제출 시에는 경고 해제
        document.getElementById('faqForm').addEventListener('submit', () => formChanged = false);
    </script>
</body>
</html>