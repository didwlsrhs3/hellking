<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>문의사항 등록 - 헬킹 피트니스</title>
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
            background: linear-gradient(135deg, #28a745, #20c997);
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
        
        .file-upload-area {
            border: 2px dashed var(--line);
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
        }
        
        .file-upload-area:hover {
            border-color: var(--brand);
            background: var(--hover);
        }
        
        .file-upload-area.dragover {
            border-color: var(--brand);
            background: var(--hover);
        }
        
        .file-list {
            margin-top: 15px;
        }
        
        .file-item {
            display: flex;
            align-items: center;
            justify-content: between;
            padding: 10px;
            background: var(--bg-cream);
            border-radius: 8px;
            margin-bottom: 10px;
        }
        
        .file-info {
            flex: 1;
            display: flex;
            align-items: center;
        }
        
        .file-icon {
            color: var(--brand);
            margin-right: 10px;
        }
        
        .file-name {
            font-weight: 500;
        }
        
        .file-size {
            color: var(--muted);
            font-size: 0.875rem;
            margin-left: 10px;
        }
        
        .file-remove {
            color: #dc3545;
            cursor: pointer;
            padding: 5px;
        }
        
        .file-remove:hover {
            color: #b02a37;
        }
        
        .privacy-notice {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
        }
        
        .breadcrumb {
            background: transparent;
            padding: 0;
            margin-bottom: 20px;
        }
        
        .breadcrumb-item + .breadcrumb-item::before {
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
                    <li class="breadcrumb-item active" style="color: white;">문의 등록</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">문의사항 등록</h2>
                    <p class="lead">궁금한 사항이나 문제점을 자세히 작성해주세요. 빠른 시일 내에 답변드리겠습니다.</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/support/inquiry" class="btn btn-light btn-lg">
                        <i class="fas fa-list me-2"></i>문의사항 목록
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="form-container">
                    <form method="post" action="${pageContext.request.contextPath}/support/inquiry/create" 
                          enctype="multipart/form-data" id="inquiryForm">
                        
                        <!-- 개인정보 안내 -->
                        <div class="privacy-notice">
                            <h6 class="fw-bold mb-2">
                                <i class="fas fa-shield-alt me-2"></i>개인정보 처리 안내
                            </h6>
                            <p class="mb-0">문의사항 처리를 위해 필요한 최소한의 개인정보만 수집하며, 답변 완료 후 관련 법령에 따라 안전하게 처리됩니다.</p>
                        </div>
                        
                        <!-- 제목 -->
                        <div class="mb-4">
                            <label for="title" class="form-label">
                                문의 제목 <span class="required">*</span>
                            </label>
                            <input type="text" class="form-control" id="title" name="title" 
                                   placeholder="문의 제목을 간단명료하게 입력해주세요" maxlength="200" required>
                            <div class="char-counter">
                                <span id="titleCount">0</span>/200자
                            </div>
                        </div>
                        
                        <!-- 내용 -->
                        <div class="mb-4">
                            <label for="content" class="form-label">
                                문의 내용 <span class="required">*</span>
                            </label>
                            <textarea class="form-control content-editor" id="content" name="content" 
                                      placeholder="문의하실 내용을 자세히 작성해주세요.&#10;&#10;예시:&#10;- 언제 발생한 문제인가요?&#10;- 어떤 상황에서 발생했나요?&#10;- 오류 메시지나 증상은 무엇인가요?&#10;- 원하시는 해결 방법이 있나요?&#10;&#10;자세한 설명을 해주실수록 정확한 답변을 드릴 수 있습니다." 
                                      required></textarea>
                            <div class="char-counter">
                                <span id="contentCount">0</span>자
                            </div>
                        </div>
                        
                        <!-- 공개 설정 -->
                        <div class="mb-4">
                            <label class="form-label">공개 설정</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="isPrivate" id="private" value="Y" checked>
                                <label class="form-check-label" for="private">
                                    <i class="fas fa-lock me-2 text-warning"></i>
                                    <strong>비공개</strong> - 작성자와 관리자만 확인 가능 (권장)
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="isPrivate" id="public" value="N">
                                <label class="form-check-label" for="public">
                                    <i class="fas fa-globe me-2 text-info"></i>
                                    <strong>공개</strong> - 모든 사용자가 확인 가능
                                </label>
                            </div>
                            <small class="text-muted">개인정보가 포함된 문의는 반드시 비공개로 설정해주세요.</small>
                        </div>
                        
                        <!-- 첨부파일 - 중요: name을 fileUploads로 변경 -->
                        <div class="mb-4">
                            <label class="form-label">
                                첨부파일 <span class="text-muted">(선택사항)</span>
                            </label>
                            <div class="file-upload-area" id="fileUploadArea">
                                <i class="fas fa-cloud-upload-alt fa-2x text-primary mb-3"></i>
                                <h6>파일을 여기로 드래그하거나 클릭하여 선택하세요</h6>
                                <p class="text-muted mb-0">
                                    최대 5개 파일, 개당 10MB 이하<br>
                                    지원 형식: jpg, png, gif, pdf, doc, docx, txt, zip
                                </p>
                                <!-- 핵심 수정: name을 fileUploads로 변경 -->
                                <input type="file" id="fileUploads" name="fileUploads" multiple 
                                       accept=".jpg,.jpeg,.png,.gif,.pdf,.doc,.docx,.txt,.zip" style="display: none;">
                            </div>
                            <div class="file-list" id="fileList"></div>
                        </div>
                        
                        <!-- 문의 작성 가이드 -->
                        <div class="alert alert-info">
                            <h6 class="fw-bold mb-2">
                                <i class="fas fa-lightbulb me-2"></i>효과적인 문의 작성 팁
                            </h6>
                            <ul class="mb-0">
                                <li><strong>구체적으로 작성하세요:</strong> 언제, 어디서, 무엇을, 어떻게 등을 포함해주세요</li>
                                <li><strong>스크린샷 첨부:</strong> 오류 화면이나 문제 상황의 이미지를 첨부하면 더 빠른 해결이 가능합니다</li>
                                <li><strong>연락처 확인:</strong> 답변 알림을 위해 정확한 연락처를 입력해주세요</li>
                                <li><strong>개인정보 주의:</strong> 비밀번호, 카드번호 등 민감한 정보는 입력하지 마세요</li>
                            </ul>
                        </div>
                        
                        <!-- 버튼 -->
                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/support/inquiry" class="btn btn-outline-secondary">
                                <i class="fas fa-arrow-left me-2"></i>취소
                            </a>
                            <div>
                                <button type="button" class="btn btn-outline-primary me-2" onclick="previewInquiry()">
                                    <i class="fas fa-eye me-2"></i>미리보기
                                </button>
                                <button type="submit" class="btn btn-brand">
                                    <i class="fas fa-paper-plane me-2"></i>문의 등록
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
                            <p id="previewPrivacy"></p>
                        </div>
                        
                        <div class="mb-3">
                            <h6 class="fw-bold text-primary">내용</h6>
                            <div id="previewContent" style="white-space: pre-line; border: 1px solid #dee2e6; padding: 15px; border-radius: 8px; background: #f8f9fa;"></div>
                        </div>
                        
                        <div id="previewFiles" style="display: none;">
                            <h6 class="fw-bold text-primary">첨부파일</h6>
                            <div id="previewFileList"></div>
                        </div>
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
        let selectedFiles = [];
        const maxFiles = 5;
        const maxFileSize = 10 * 1024 * 1024; // 10MB
        const allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'application/pdf', 
                             'application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                             'text/plain', 'application/zip'];
        
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
            
            // 파일 업로드 영역 이벤트
            setupFileUpload();
        });
        
        // 파일 업로드 설정 - 수정: fileUploads로 변경
        function setupFileUpload() {
            const uploadArea = document.getElementById('fileUploadArea');
            const fileInput = document.getElementById('fileUploads'); // 변경된 ID
            
            uploadArea.addEventListener('click', () => fileInput.click());
            
            uploadArea.addEventListener('dragover', function(e) {
                e.preventDefault();
                this.classList.add('dragover');
            });
            
            uploadArea.addEventListener('dragleave', function(e) {
                e.preventDefault();
                this.classList.remove('dragover');
            });
            
            uploadArea.addEventListener('drop', function(e) {
                e.preventDefault();
                this.classList.remove('dragover');
                handleFiles(e.dataTransfer.files);
            });
            
            fileInput.addEventListener('change', function(e) {
                handleFiles(e.target.files);
            });
        }
        
        // 파일 처리
        function handleFiles(files) {
            for (let file of files) {
                if (selectedFiles.length >= maxFiles) {
                    alert(`최대 ${maxFiles}개의 파일만 첨부할 수 있습니다.`);
                    break;
                }
                
                if (file.size > maxFileSize) {
                    alert(`${file.name}은(는) 파일 크기가 너무 큽니다. (최대 10MB)`);
                    continue;
                }
                
                if (!allowedTypes.includes(file.type)) {
                    alert(`${file.name}은(는) 지원하지 않는 파일 형식입니다.`);
                    continue;
                }
                
                selectedFiles.push(file);
            }
            
            updateFileList();
        }
        
        // 파일 목록 업데이트
        function updateFileList() {
            const fileList = document.getElementById('fileList');
            fileList.innerHTML = '';
            
            selectedFiles.forEach((file, index) => {
                const fileItem = document.createElement('div');
                fileItem.className = 'file-item';
                fileItem.innerHTML = 
                    '<div class="file-info">' +
                        '<i class="fas fa-file file-icon"></i>' +
                        '<span class="file-name">' + file.name + '</span>' +
                        '<span class="file-size">(' + formatFileSize(file.size) + ')</span>' +
                    '</div>' +
                    '<i class="fas fa-times file-remove" onclick="removeFile(' + index + ')"></i>';
                fileList.appendChild(fileItem);
            });
        }
        
        // 파일 제거
        function removeFile(index) {
            selectedFiles.splice(index, 1);
            updateFileList();
        }
        
        // 파일 크기 포맷
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 Bytes';
            const k = 1024;
            const sizes = ['Bytes', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }
        
        // 미리보기 기능
        function previewInquiry() {
            const title = document.getElementById('title').value;
            const content = document.getElementById('content').value;
            const isPrivate = document.querySelector('input[name="isPrivate"]:checked').value;
            
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
            
            const privacyText = isPrivate === 'Y' ? 
                '🔒 비공개 - 작성자와 관리자만 확인 가능' : 
                '🌍 공개 - 모든 사용자가 확인 가능';
            document.getElementById('previewPrivacy').textContent = privacyText;
            
            // 첨부파일 미리보기
            const previewFiles = document.getElementById('previewFiles');
            const previewFileList = document.getElementById('previewFileList');
            
            if (selectedFiles.length > 0) {
                previewFiles.style.display = 'block';
                previewFileList.innerHTML = '';
                selectedFiles.forEach(file => {
                    const fileDiv = document.createElement('div');
                    fileDiv.className = 'mb-1';
                    fileDiv.innerHTML = '<i class="fas fa-paperclip me-2"></i>' + file.name + ' (' + formatFileSize(file.size) + ')';
                    previewFileList.appendChild(fileDiv);
                });
            } else {
                previewFiles.style.display = 'none';
            }
            
            new bootstrap.Modal(document.getElementById('previewModal')).show();
        }
        
        // 폼 제출 - 수정: fileUploads로 변경
        function submitForm() {
            // 선택된 파일들을 실제 파일 input에 설정
            const fileInput = document.getElementById('fileUploads'); // 변경된 ID
            const dt = new DataTransfer();
            selectedFiles.forEach(file => dt.items.add(file));
            fileInput.files = dt.files;
            
            document.getElementById('inquiryForm').submit();
        }
        
        // 폼 유효성 검사 - 수정: fileUploads로 변경
        document.getElementById('inquiryForm').addEventListener('submit', function(e) {
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
            
            // 파일 입력 설정
            const fileInput = document.getElementById('fileUploads'); // 변경된 ID
            const dt = new DataTransfer();
            selectedFiles.forEach(file => dt.items.add(file));
            fileInput.files = dt.files;
            
            // 제출 버튼 비활성화
            const submitBtn = this.querySelector('button[type="submit"]');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>등록 중...';
        });
        
        // 페이지 벗어날 때 확인
        let formChanged = false;
        
        document.getElementById('title').addEventListener('input', () => formChanged = true);
        document.getElementById('content').addEventListener('input', () => formChanged = true);
        document.querySelectorAll('input[name="isPrivate"]').forEach(radio => {
            radio.addEventListener('change', () => formChanged = true);
        });
        
        document.querySelector('button[type="submit"]').addEventListener('click', () => {
            formChanged = false;
        });
        
        // 폼 제출 시에는 경고 해제
        document.getElementById('inquiryForm').addEventListener('submit', () => formChanged = false);
    </script>
</body>
</html>