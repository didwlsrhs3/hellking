<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
<<<<<<< HEAD
        :root {
            --brand: #FF6A00;
            --bg-cream: #F4ECDC;
        }
        body { background: var(--bg-cream); }
=======
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
        }
        
>>>>>>> b65c320 (Initial commit)
        .rating-input {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
            user-select: none;
        }
        .rating-input.active, .rating-input:hover {
            color: #ffc107;
        }
<<<<<<< HEAD
        .chain-card {
            border: 2px solid #e9ecef;
            transition: border-color 0.2s;
            cursor: pointer;
        }
        .chain-card:hover {
            border-color: var(--brand);
            background-color: #fff5ea;
        }
        .chain-card.selected {
            border-color: var(--brand);
            background-color: #fff5ea;
        }
=======
        
>>>>>>> b65c320 (Initial commit)
        .btn-primary {
            background: var(--brand);
            border-color: var(--brand);
        }
        .btn-primary:hover {
            background: #e55a00;
            border-color: #e55a00;
        }
<<<<<<< HEAD
=======
        
        /* 이미지 업로드 영역 스타일 */
        .image-upload-area {
            border: 2px dashed #ddd;
            border-radius: 12px;
            padding: 40px;
            text-align: center;
            background: #fafafa;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            min-height: 150px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .image-upload-area:hover, .image-upload-area.dragover {
            border-color: var(--brand);
            background: #fff5ea;
            transform: translateY(-2px);
        }
        
        .image-upload-area.dragover {
            border-style: solid;
        }
        
        .upload-icon {
            font-size: 3rem;
            color: #ccc;
            margin-bottom: 15px;
        }
        
        .image-upload-area:hover .upload-icon {
            color: var(--brand);
        }
        
        /* 이미지 미리보기 */
        .image-preview {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 20px;
        }
        
        .image-preview-item {
            position: relative;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            overflow: hidden;
            width: 150px;
            height: 150px;
            background: #f8f9fa;
            cursor: move;
            transition: all 0.2s ease;
        }
        
        .image-preview-item:hover {
            border-color: var(--brand);
            transform: scale(1.05);
        }
        
        .image-preview-item.dragging {
            opacity: 0.5;
            transform: rotate(5deg);
        }
        
        .image-preview-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .image-delete-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            background: rgba(220, 53, 69, 0.9);
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.2s ease;
        }
        
        .image-delete-btn:hover {
            background: #dc3545;
            transform: scale(1.1);
        }
        
        .image-order-badge {
            position: absolute;
            bottom: 5px;
            left: 5px;
            background: rgba(0, 0, 0, 0.7);
            color: white;
            border-radius: 12px;
            padding: 2px 8px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .loading-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255, 255, 255, 0.9);
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 8px;
        }
        
        .upload-progress {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-top: 10px;
            display: none;
        }
        
        .progress-bar-custom {
            background: var(--brand);
        }
        
        /* 파일 정보 */
        .file-info {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            padding: 5px;
            font-size: 11px;
            text-align: center;
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
            
            .image-preview-item {
                width: 120px;
                height: 120px;
            }
            
            .image-upload-area {
                padding: 20px;
                min-height: 120px;
            }
        }
>>>>>>> b65c320 (Initial commit)
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
<<<<<<< HEAD
=======
    <!-- 리뷰 작성 헤더 -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">리뷰 작성</h2>
                    <p class="lead">소중한 경험을 다른 회원들과 공유해주세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="text-center p-3" style="background: rgba(255,255,255,0.2); border-radius: 12px;">
                        <div class="h5 mb-1">새 리뷰</div>
                        <small>평점과 상세 후기 작성</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
>>>>>>> b65c320 (Initial commit)
    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-white">
                        <h4 class="mb-0"><i class="fas fa-edit me-2"></i>리뷰 작성</h4>
                    </div>
                    <div class="card-body">
<<<<<<< HEAD
                        <form action="${pageContext.request.contextPath}/reviews/write" method="post" id="reviewForm">
                            <!-- 사용자 번호 -->
=======
                        <form action="${pageContext.request.contextPath}/reviews/writeWithImages" 
                              method="post" id="reviewForm" enctype="multipart/form-data">
                            
                            <!-- 숨겨진 필드들 -->
>>>>>>> b65c320 (Initial commit)
                            <input type="hidden" name="userNum" value="${sessionScope.user.userNum}">
                            
                            <!-- 가맹점 선택 -->
                            <div class="mb-4">
                                <label class="form-label fw-bold">가맹점 선택 <span class="text-danger">*</span></label>
                                <c:choose>
                                    <c:when test="${not empty chain}">
<<<<<<< HEAD
                                        <!-- 특정 가맹점이 지정된 경우 -->
                                        <div class="chain-card selected p-3 rounded">
=======
                                        <div class="chain-card selected p-3 rounded border" style="border-color: var(--brand); background-color: #fff5ea;">
>>>>>>> b65c320 (Initial commit)
                                            <div class="d-flex align-items-center">
                                                <div class="me-3">
                                                    <i class="fas fa-dumbbell fa-2x text-primary"></i>
                                                </div>
                                                <div>
                                                    <h6 class="mb-1">${chain.chainName}</h6>
                                                    <p class="text-muted mb-0 small">${chain.address}</p>
                                                </div>
                                                <div class="ms-auto">
                                                    <span class="badge bg-success">선택됨</span>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="chainNum" value="${chain.chainNum}">
                                    </c:when>
                                    <c:otherwise>
<<<<<<< HEAD
                                        <!-- 가맹점 직접 선택 -->
=======
>>>>>>> b65c320 (Initial commit)
                                        <select class="form-select" name="chainNum" id="chainSelect" required>
                                            <option value="">가맹점을 선택하세요</option>
                                            <option value="1">헬킹 강남점 - 서울시 강남구 테헤란로 123</option>
                                            <option value="2">헬킹 홍대점 - 서울시 마포구 홍익로 456</option>
                                            <option value="3">헬킹 잠실점 - 서울시 송파구 잠실동 789</option>
                                            <option value="4">헬킹 부산점 - 부산시 해운대구 해운대로 321</option>
                                            <option value="5">헬킹 대구점 - 대구시 수성구 범어동 654</option>
                                        </select>
<<<<<<< HEAD
                                        <div class="form-text text-muted">
                                            <i class="fas fa-info-circle me-1"></i>
                                            리뷰를 작성할 가맹점을 선택해주세요.
                                        </div>
=======
>>>>>>> b65c320 (Initial commit)
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <!-- 평점 입력 -->
                            <div class="mb-4">
                                <label class="form-label fw-bold">평점 <span class="text-danger">*</span></label>
                                <div class="rating-container mb-2">
                                    <i class="fas fa-star rating-input" data-rating="1"></i>
                                    <i class="fas fa-star rating-input" data-rating="2"></i>
                                    <i class="fas fa-star rating-input" data-rating="3"></i>
                                    <i class="fas fa-star rating-input" data-rating="4"></i>
                                    <i class="fas fa-star rating-input" data-rating="5"></i>
                                </div>
                                <input type="hidden" name="rating" id="ratingValue" required>
                                <div class="form-text text-muted">
                                    <i class="fas fa-star text-warning me-1"></i>
                                    별표를 클릭하여 평점을 선택하세요 (1-5점)
                                </div>
                            </div>
                            
                            <!-- 제목 입력 -->
                            <div class="mb-4">
                                <label for="title" class="form-label fw-bold">제목 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="title" name="title" 
                                       placeholder="리뷰 제목을 입력하세요" maxlength="100" required>
                                <div class="form-text text-end">
                                    <span id="titleCount">0</span> / 100자
                                </div>
                            </div>
                            
<<<<<<< HEAD
=======
                            <!-- 이미지 업로드 영역 -->
                            <div class="mb-4">
                                <label class="form-label fw-bold">이미지 첨부 <span class="text-muted">(선택사항)</span></label>
                                <div class="image-upload-area" id="imageUploadArea">
                                    <i class="fas fa-cloud-upload-alt upload-icon"></i>
                                    <h5 class="mb-2">이미지를 드래그하여 업로드하세요</h5>
                                    <p class="text-muted mb-2">또는 <strong>클릭하여 파일 선택</strong></p>
                                    <small class="text-muted">JPG, PNG, GIF 파일만 가능 (최대 10MB, 5개까지)</small>
                                </div>
                                
                                <input type="file" id="imageInput" name="images" multiple accept="image/*" style="display: none;">
                                
                                <!-- 업로드 진행률 -->
                                <div class="upload-progress" id="uploadProgress">
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>업로드 중...</span>
                                        <span id="progressText">0%</span>
                                    </div>
                                    <div class="progress">
                                        <div class="progress-bar progress-bar-custom" role="progressbar" 
                                             style="width: 0%" id="progressBar"></div>
                                    </div>
                                </div>
                                
                                <!-- 이미지 미리보기 -->
                                <div class="image-preview" id="imagePreview"></div>
                                
                                <div class="form-text mt-2">
                                    <i class="fas fa-info-circle me-1"></i>
                                    이미지를 드래그하여 순서를 변경할 수 있습니다. 첫 번째 이미지가 대표 이미지로 표시됩니다.
                                </div>
                            </div>
                            
>>>>>>> b65c320 (Initial commit)
                            <!-- 내용 입력 -->
                            <div class="mb-4">
                                <label for="content" class="form-label fw-bold">내용 <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="content" name="content" rows="8" 
                                          placeholder="가맹점 이용 경험을 자세히 작성해주세요. 다른 회원들에게 도움이 되는 솔직한 후기를 남겨주세요." 
                                          maxlength="2000" required></textarea>
                                <div class="form-text text-end">
                                    <span id="contentCount">0</span> / 2000자
                                </div>
                            </div>
                            
                            <!-- 리뷰 작성 팁 -->
                            <div class="alert alert-light border">
                                <h6 class="text-primary"><i class="fas fa-lightbulb me-2"></i>좋은 리뷰 작성 팁</h6>
                                <ul class="mb-0 small">
                                    <li><strong>시설 정보:</strong> 청결도, 장비 상태, 넓이, 샤워실 등</li>
                                    <li><strong>서비스:</strong> 직원 친절도, 트레이너 전문성, 회원 관리</li>
                                    <li><strong>분위기:</strong> 운동 환경, 음악, 회원들의 분위기</li>
                                    <li><strong>접근성:</strong> 위치, 주차, 대중교통 접근성</li>
<<<<<<< HEAD
                                    <li><strong>주의사항:</strong> 욕설이나 비방은 삼가하고, 건설적인 의견을 남겨주세요</li>
                                </ul>
                            </div>
                            
                            <!-- 테스트용 버튼 -->
                            <div class="mb-3">
                                <button type="button" class="btn btn-warning me-2" onclick="fillTestData()">
                                    <i class="fas fa-flask me-1"></i>테스트 데이터 채우기
                                </button>
                                <button type="button" class="btn btn-info" onclick="showDebugInfo()">
                                    <i class="fas fa-bug me-1"></i>디버그 정보
                                </button>
                            </div>
                            
=======
                                    <li><strong>이미지:</strong> 시설 사진, 운동기구, 라커룸 등의 실제 모습</li>
                                </ul>
                            </div>
                            
>>>>>>> b65c320 (Initial commit)
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary" id="submitBtn" disabled>
                                    <i class="fas fa-save me-1"></i>리뷰 등록
                                </button>
                                <button type="button" class="btn btn-secondary" onclick="history.back()">
                                    <i class="fas fa-arrow-left me-1"></i>취소
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 전역 변수
        let selectedRating = 0;
<<<<<<< HEAD
        const hasChain = ${not empty chain ? 'true' : 'false'};
        console.log('페이지 초기화, hasChain:', hasChain);
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            console.log('리뷰 작성 페이지 로드됨');
            initRatingSystem();
=======
        let uploadedImages = [];
        let draggedElement = null;
        const MAX_IMAGES = 5;
        const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
        
        const hasChain = ${not empty chain ? 'true' : 'false'};
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            console.log('이미지 업로드 기능을 포함한 리뷰 작성 페이지 로드');
            initRatingSystem();
            initImageUpload();
>>>>>>> b65c320 (Initial commit)
            setupEventListeners();
            updateSubmitButton();
        });
        
<<<<<<< HEAD
        // 평점 시스템 초기화
        function initRatingSystem() {
            const stars = document.querySelectorAll('.rating-input');
            console.log('별 개수:', stars.length);
=======
        // ===== 평점 시스템 =====
        function initRatingSystem() {
            const stars = document.querySelectorAll('.rating-input');
>>>>>>> b65c320 (Initial commit)
            
            stars.forEach((star, index) => {
                star.addEventListener('click', function(e) {
                    e.preventDefault();
                    selectedRating = parseInt(this.dataset.rating);
                    document.getElementById('ratingValue').value = selectedRating;
<<<<<<< HEAD
                    console.log('평점 선택됨:', selectedRating);
=======
>>>>>>> b65c320 (Initial commit)
                    updateStarDisplay(selectedRating);
                    updateSubmitButton();
                });
                
                star.addEventListener('mouseenter', function() {
                    const hoverRating = parseInt(this.dataset.rating);
                    updateStarDisplay(hoverRating);
                });
            });
            
            document.querySelector('.rating-container').addEventListener('mouseleave', function() {
                updateStarDisplay(selectedRating);
            });
        }
        
<<<<<<< HEAD
        // 별표 표시 업데이트
=======
>>>>>>> b65c320 (Initial commit)
        function updateStarDisplay(rating) {
            document.querySelectorAll('.rating-input').forEach((star, index) => {
                if (index < rating) {
                    star.style.color = '#ffc107';
                    star.classList.add('active');
                } else {
                    star.style.color = '#ddd';
                    star.classList.remove('active');
                }
            });
        }
        
<<<<<<< HEAD
        // 이벤트 리스너 설정
=======
        // ===== 이미지 업로드 시스템 =====
        function initImageUpload() {
            const uploadArea = document.getElementById('imageUploadArea');
            const imageInput = document.getElementById('imageInput');
            
            // 클릭으로 파일 선택
            uploadArea.addEventListener('click', function(e) {
                if (e.target === uploadArea || e.target.closest('.upload-icon, h5, p, small')) {
                    imageInput.click();
                }
            });
            
            // 파일 선택 시
            imageInput.addEventListener('change', function(e) {
                handleFiles(e.target.files);
            });
            
            // 드래그 앤 드롭
            uploadArea.addEventListener('dragover', function(e) {
                e.preventDefault();
                uploadArea.classList.add('dragover');
            });
            
            uploadArea.addEventListener('dragleave', function(e) {
                e.preventDefault();
                uploadArea.classList.remove('dragover');
            });
            
            uploadArea.addEventListener('drop', function(e) {
                e.preventDefault();
                uploadArea.classList.remove('dragover');
                handleFiles(e.dataTransfer.files);
            });
        }
        
        function handleFiles(files) {
            if (uploadedImages.length >= MAX_IMAGES) {
                alert('최대 ' + MAX_IMAGES + '개까지 업로드할 수 있습니다.');
                return;
            }
            
            const fileArray = Array.from(files);
            const remainingSlots = MAX_IMAGES - uploadedImages.length;
            const filesToProcess = fileArray.slice(0, remainingSlots);
            
            if (fileArray.length > remainingSlots) {
                alert(remainingSlots + '개 파일만 업로드됩니다. (최대 ' + MAX_IMAGES + '개 제한)');
            }
            
            filesToProcess.forEach((file, index) => {
                if (validateFile(file)) {
                    uploadImage(file);
                }
            });
        }
        
        function validateFile(file) {
            // 파일 타입 검사
            if (!file.type.startsWith('image/')) {
                alert(file.name + ': 이미지 파일만 업로드 가능합니다.');
                return false;
            }
            
            // 파일 크기 검사
            if (file.size > MAX_FILE_SIZE) {
                alert(file.name + ': 파일 크기가 10MB를 초과합니다.');
                return false;
            }
            
            return true;
        }
        
        function uploadImage(file) {
            const formData = new FormData();
            formData.append('image', file);
            
            // 미리보기 생성
            const previewId = 'preview_' + Date.now();
            createImagePreview(file, previewId);
            
            // AJAX 업로드
            fetch('${pageContext.request.contextPath}/reviews/uploadImage', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 업로드 성공 시 이미지 정보 저장
                    const imageInfo = {
                        id: previewId,
                        fileName: data.fileName,
                        originalName: data.originalName,
                        fileSize: data.fileSize
                    };
                    
                    uploadedImages.push(imageInfo);
                    updateImagePreview(previewId, imageInfo);
                    updateSubmitButton();
                    
                    console.log('이미지 업로드 성공:', data.fileName);
                } else {
                    removeImagePreview(previewId);
                    alert('업로드 실패: ' + data.message);
                }
            })
            .catch(error => {
                removeImagePreview(previewId);
                console.error('업로드 오류:', error);
                alert('업로드 중 오류가 발생했습니다.');
            });
        }
        
        function createImagePreview(file, previewId) {
            const previewContainer = document.getElementById('imagePreview');
            const previewItem = document.createElement('div');
            previewItem.className = 'image-preview-item';
            previewItem.id = previewId;
            previewItem.draggable = true;
            
            // 이미지 미리보기 생성
            const reader = new FileReader();
            reader.onload = function(e) {
                previewItem.innerHTML = 
                    '<img src="' + e.target.result + '" alt="미리보기">' +
                    '<button type="button" class="image-delete-btn" onclick="deleteImage(\'' + previewId + '\')">' +
                        '<i class="fas fa-times"></i>' +
                    '</button>' +
                    '<div class="image-order-badge">' + (uploadedImages.length + 1) + '</div>' +
                    '<div class="loading-overlay">' +
                        '<div class="spinner-border text-primary" role="status">' +
                            '<span class="visually-hidden">업로드 중...</span>' +
                        '</div>' +
                    '</div>' +
                    '<div class="file-info">' +
                        file.name + ' (' + formatFileSize(file.size) + ')' +
                    '</div>';
            };
            reader.readAsDataURL(file);
            
            // 드래그 앤 드롭 이벤트
            previewItem.addEventListener('dragstart', handleDragStart);
            previewItem.addEventListener('dragover', handleDragOver);
            previewItem.addEventListener('drop', handleDrop);
            previewItem.addEventListener('dragend', handleDragEnd);
            
            previewContainer.appendChild(previewItem);
        }
        
        function updateImagePreview(previewId, imageInfo) {
            const previewItem = document.getElementById(previewId);
            if (previewItem) {
                // 로딩 오버레이 제거
                const loadingOverlay = previewItem.querySelector('.loading-overlay');
                if (loadingOverlay) {
                    loadingOverlay.remove();
                }
                
                // 파일 정보 업데이트
                const fileInfo = previewItem.querySelector('.file-info');
                if (fileInfo) {
                    fileInfo.textContent = imageInfo.originalName + ' (' + formatFileSize(imageInfo.fileSize) + ')';
                }
            }
        }
        
        function deleteImage(previewId) {
            if (!confirm('이미지를 삭제하시겠습니까?')) {
                return;
            }
            
            // uploadedImages에서 해당 이미지 정보 찾기
            const imageIndex = uploadedImages.findIndex(img => img.id === previewId);
            if (imageIndex === -1) {
                removeImagePreview(previewId);
                return;
            }
            
            const imageInfo = uploadedImages[imageIndex];
            
            // 서버에서 파일 삭제
            fetch('${pageContext.request.contextPath}/reviews/deleteImage', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'fileName=' + encodeURIComponent(imageInfo.fileName)
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 배열에서 제거
                    uploadedImages.splice(imageIndex, 1);
                    removeImagePreview(previewId);
                    updateImageOrders();
                    updateSubmitButton();
                    console.log('이미지 삭제 성공:', imageInfo.fileName);
                } else {
                    alert('삭제 실패: ' + data.message);
                }
            })
            .catch(error => {
                console.error('삭제 오류:', error);
                alert('삭제 중 오류가 발생했습니다.');
            });
        }
        
        function removeImagePreview(previewId) {
            const previewItem = document.getElementById(previewId);
            if (previewItem) {
                previewItem.remove();
            }
        }
        
        function updateImageOrders() {
            const previewItems = document.querySelectorAll('.image-preview-item');
            previewItems.forEach((item, index) => {
                const orderBadge = item.querySelector('.image-order-badge');
                if (orderBadge) {
                    orderBadge.textContent = index + 1;
                }
            });
        }
        
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 B';
            const k = 1024;
            const sizes = ['B', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(1)) + ' ' + sizes[i];
        }
        
        // ===== 드래그 앤 드롭으로 순서 변경 =====
        function handleDragStart(e) {
            draggedElement = this;
            this.classList.add('dragging');
            e.dataTransfer.effectAllowed = 'move';
        }
        
        function handleDragOver(e) {
            if (e.preventDefault) {
                e.preventDefault();
            }
            e.dataTransfer.dropEffect = 'move';
            return false;
        }
        
        function handleDrop(e) {
            if (e.stopPropagation) {
                e.stopPropagation();
            }
            
            if (draggedElement !== this) {
                const allItems = Array.from(document.querySelectorAll('.image-preview-item'));
                const draggedIndex = allItems.indexOf(draggedElement);
                const targetIndex = allItems.indexOf(this);
                
                if (draggedIndex < targetIndex) {
                    this.parentNode.insertBefore(draggedElement, this.nextSibling);
                } else {
                    this.parentNode.insertBefore(draggedElement, this);
                }
                
                // 배열 순서도 업데이트
                const draggedItem = uploadedImages[draggedIndex];
                uploadedImages.splice(draggedIndex, 1);
                uploadedImages.splice(targetIndex, 0, draggedItem);
                
                updateImageOrders();
            }
            return false;
        }
        
        function handleDragEnd(e) {
            this.classList.remove('dragging');
            draggedElement = null;
        }
        
        // ===== 이벤트 리스너 및 폼 검증 =====
>>>>>>> b65c320 (Initial commit)
        function setupEventListeners() {
            // 제목 글자수 카운트
            document.getElementById('title').addEventListener('input', function() {
                const count = this.value.length;
                document.getElementById('titleCount').textContent = count;
                document.getElementById('titleCount').style.color = count > 90 ? '#dc3545' : '#6c757d';
                updateSubmitButton();
            });
            
            // 내용 글자수 카운트
            document.getElementById('content').addEventListener('input', function() {
                const count = this.value.length;
                document.getElementById('contentCount').textContent = count;
                document.getElementById('contentCount').style.color = count > 1900 ? '#dc3545' : '#6c757d';
                updateSubmitButton();
            });
            
            // 가맹점 선택 (드롭다운)
            const chainSelect = document.getElementById('chainSelect');
            if (chainSelect) {
                chainSelect.addEventListener('change', updateSubmitButton);
            }
        }
        
<<<<<<< HEAD
        // 제출 버튼 활성화 체크
=======
>>>>>>> b65c320 (Initial commit)
        function updateSubmitButton() {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            const rating = document.getElementById('ratingValue').value;
            
            // 가맹점 선택 확인
            let chainSelected = hasChain;
            if (!hasChain) {
                const chainSelect = document.getElementById('chainSelect');
                chainSelected = chainSelect && chainSelect.value !== '';
            }
            
            const isValid = title && content && rating && chainSelected && 
                           title.length <= 100 && content.length <= 2000;
            
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = !isValid;
            
<<<<<<< HEAD
            console.log('폼 검증 상태:', {
                title: !!title,
                content: !!content,
                rating: !!rating,
                chainSelected: chainSelected,
                isValid: isValid
            });
        }
        
        // 테스트 데이터 채우기
        function fillTestData() {
            document.getElementById('title').value = '테스트 리뷰 제목';
            document.getElementById('content').value = '테스트용 리뷰 내용입니다. 시설이 깨끗하고 직원분들이 친절했습니다. 운동기구도 최신이라 만족스럽습니다.';
            
            // 평점 4점 선택
            selectedRating = 4;
            document.getElementById('ratingValue').value = 4;
            updateStarDisplay(4);
            
            // 가맹점 선택 (첫 번째 옵션)
            const chainSelect = document.getElementById('chainSelect');
            if (chainSelect) {
                chainSelect.value = '1';
            }
            
            // 글자수 업데이트
            document.getElementById('titleCount').textContent = document.getElementById('title').value.length;
            document.getElementById('contentCount').textContent = document.getElementById('content').value.length;
            
            updateSubmitButton();
            alert('테스트 데이터가 입력되었습니다!');
        }
        
        // 디버그 정보 표시
        function showDebugInfo() {
            const info = {
                hasChain: hasChain,
                userNum: '${sessionScope.user.userNum}',
                chainNum: hasChain ? '${chain.chainNum}' : document.getElementById('chainSelect')?.value,
                rating: document.getElementById('ratingValue').value,
                title: document.getElementById('title').value,
                content: document.getElementById('content').value.substring(0, 50) + '...'
            };
            
            alert('디버그 정보:\n' + JSON.stringify(info, null, 2));
            console.log('현재 폼 상태:', info);
        }
        
        // 폼 제출 전 최종 검증
        document.getElementById('reviewForm').addEventListener('submit', function(e) {
            console.log('폼 제출 시도');
            
=======
            // 버튼 텍스트 업데이트
            if (uploadedImages.length > 0) {
                submitBtn.innerHTML = '<i class="fas fa-save me-1"></i>리뷰 등록 (이미지 ' + uploadedImages.length + '개)';
            } else {
                submitBtn.innerHTML = '<i class="fas fa-save me-1"></i>리뷰 등록';
            }
        }
        
        // ===== 폼 제출 처리 =====
        document.getElementById('reviewForm').addEventListener('submit', function(e) {
            console.log('리뷰 폼 제출 시도');
            
            // 기본 검증
>>>>>>> b65c320 (Initial commit)
            if (!document.getElementById('ratingValue').value) {
                e.preventDefault();
                alert('평점을 선택해주세요.');
                return;
            }
            
            if (!hasChain) {
                const chainSelect = document.getElementById('chainSelect');
                if (!chainSelect || !chainSelect.value) {
                    e.preventDefault();
                    alert('가맹점을 선택해주세요.');
                    return;
                }
            }
            
            const title = document.getElementById('title').value.trim();
            if (!title) {
                e.preventDefault();
                alert('제목을 입력해주세요.');
                document.getElementById('title').focus();
                return;
            }
            
            const content = document.getElementById('content').value.trim();
            if (content.length < 10) {
                e.preventDefault();
                alert('리뷰 내용을 10글자 이상 입력해주세요.');
                document.getElementById('content').focus();
                return;
            }
            
<<<<<<< HEAD
            if (!confirm('리뷰를 등록하시겠습니까?')) {
=======
            // 이미지 파일명을 폼에 추가
            if (uploadedImages.length > 0) {
                uploadedImages.forEach((img, index) => {
                    const input = document.createElement('input');
                    input.type = 'hidden';
                    input.name = 'imageFileNames';
                    input.value = img.fileName;
                    this.appendChild(input);
                });
            }
            
            var confirmMessage = '리뷰를 등록하시겠습니까?';
            if (uploadedImages.length > 0) {
                confirmMessage += ' (이미지 ' + uploadedImages.length + '개 포함)';
            }
            
            if (!confirm(confirmMessage)) {
>>>>>>> b65c320 (Initial commit)
                e.preventDefault();
                return;
            }
            
<<<<<<< HEAD
            console.log('폼 제출 승인');
            
=======
            console.log('리뷰 폼 제출 승인');
            console.log('업로드된 이미지:', uploadedImages.length + '개');
            
            // 제출 버튼 비활성화 (중복 제출 방지)
>>>>>>> b65c320 (Initial commit)
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>등록 중...';
        });
<<<<<<< HEAD
    </script>
</body>
</html>
=======
        
        // ===== 테스트 및 디버그 함수 =====
        function fillTestData() {
            document.getElementById('title').value = '테스트 리뷰 제목 (이미지 포함)';
            document.getElementById('content').value = '테스트용 리뷰 내용입니다. 시설이 깨끗하고 직원분들이 친절했습니다. 운동기구도 최신이라 만족스럽습니다. 이미지 업로드 기능도 잘 작동하네요!';
            
            // 평점 4점 선택
            selectedRating = 4;
            document.getElementById('ratingValue').value = 4;
            updateStarDisplay(4);
            
            // 가맹점 선택 (첫 번째 옵션)
            const chainSelect = document.getElementById('chainSelect');
            if (chainSelect) {
                chainSelect.value = '1';
            }
            
            // 글자수 업데이트
            document.getElementById('titleCount').textContent = document.getElementById('title').value.length;
            document.getElementById('contentCount').textContent = document.getElementById('content').value.length;
            
            updateSubmitButton();
            alert('테스트 데이터가 입력되었습니다! 이미지도 드래그앤드롭으로 추가해보세요.');
        }
        
        function showDebugInfo() {
            const info = {
                hasChain: hasChain,
                userNum: '${sessionScope.user.userNum}',
                chainNum: hasChain ? '${chain.chainNum}' : (document.getElementById('chainSelect') ? document.getElementById('chainSelect').value : null),
                rating: document.getElementById('ratingValue').value,
                title: document.getElementById('title').value,
                content: document.getElementById('content').value.substring(0, 50) + '...',
                uploadedImages: uploadedImages.length,
                imageList: uploadedImages.map(img => img.originalName)
            };
            
            console.log('현재 폼 상태:', info);
            alert('디버그 정보:\n' + JSON.stringify(info, null, 2));
        }
        
        // ===== 키보드 단축키 =====
        document.addEventListener('keydown', function(e) {
            // Ctrl+Enter: 폼 제출
            if (e.ctrlKey && e.key === 'Enter') {
                const submitBtn = document.getElementById('submitBtn');
                if (!submitBtn.disabled) {
                    document.getElementById('reviewForm').submit();
                }
            }
            
            // ESC: 이미지 업로드 취소 (업로드 중일 때)
            if (e.key === 'Escape') {
                // TODO: 업로드 중인 요청 취소 로직
            }
        });
        
        // ===== 브라우저 떠날 때 확인 =====
        let formChanged = false;
        
        ['input', 'change', 'paste'].forEach(eventType => {
            document.addEventListener(eventType, function() {
                formChanged = true;
            });
        });
        
        window.addEventListener('beforeunload', function(e) {
            if (formChanged && (document.getElementById('title').value || 
                              document.getElementById('content').value || 
                              uploadedImages.length > 0)) {
                e.preventDefault();
                e.returnValue = '작성 중인 내용이 있습니다. 정말 페이지를 떠나시겠습니까?';
                return e.returnValue;
            }
        });
        
        // 폼 제출 시에는 경고 비활성화
        document.getElementById('reviewForm').addEventListener('submit', function() {
            formChanged = false;
        });
    </script>
</body>
</html>	
>>>>>>> b65c320 (Initial commit)
