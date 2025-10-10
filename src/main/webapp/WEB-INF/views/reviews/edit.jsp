<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 수정 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        }
        
        .rating-input {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
        }
        .rating-input.active, .rating-input:hover {
            color: #ffc107;
        }
        
        /* 기존 이미지 스타일 */
        .existing-image {
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
        
        .existing-image:hover {
            border-color: var(--brand);
            transform: scale(1.05);
        }
        
        .existing-image.marked-delete {
            opacity: 0.5;
            border-color: #dc3545;
            background: #f8d7da;
        }
        
        .existing-image.marked-delete::after {
            content: '삭제 예정';
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: rgba(220, 53, 69, 0.9);
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .existing-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .image-error {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: #f8d7da;
            color: #721c24;
            font-size: 11px;
            text-align: center;
            padding: 10px;
        }
        
        .image-action-btn {
            position: absolute;
            top: 5px;
            background: rgba(0, 0, 0, 0.7);
            color: white;
            border: none;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 12px;
            transition: all 0.2s ease;
            z-index: 10;
        }
        
        .image-delete-btn {
            right: 5px;
            background: rgba(220, 53, 69, 0.9);
        }
        
        .image-restore-btn {
            right: 5px;
            background: rgba(40, 167, 69, 0.9);
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
            z-index: 10;
        }
        
        /* 새 이미지 업로드 영역 */
        .new-image-upload {
            border: 2px dashed #ddd;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            background: #fafafa;
            cursor: pointer;
            transition: all 0.3s ease;
            min-height: 100px;
        }
        
        .new-image-upload:hover {
            border-color: var(--brand);
            background: #fff5ea;
        }
        
        .image-preview-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        /* 새 이미지 미리보기 */
        .new-image-preview {
            position: relative;
            border: 2px solid #28a745;
            border-radius: 8px;
            overflow: hidden;
            width: 150px;
            height: 150px;
            background: #d4edda;
        }
        
        .new-image-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .new-label {
            position: absolute;
            top: 5px;
            left: 5px;
            background: #28a745;
            color: white;
            padding: 2px 6px;
            border-radius: 10px;
            font-size: 10px;
            font-weight: bold;
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
    <jsp:include page="../common/header.jsp" />
    
    <!-- 리뷰 수정 헤더 -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">리뷰 수정</h2>
                    <p class="lead">작성한 리뷰를 수정하여 더 나은 후기를 완성하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <div class="text-center p-3" style="background: rgba(255,255,255,0.2); border-radius: 12px;">
                        <div class="h5 mb-1">수정 중</div>
                        <small>${review.chainName}<br>리뷰 업데이트</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-white">
                        <h4 class="mb-0"><i class="fas fa-edit me-2"></i>리뷰 수정</h4>
                    </div>
                    <div class="card-body">
                        <!-- 오류 메시지 표시 -->
                        <c:if test="${not empty message}">
                            <div class="alert alert-danger" role="alert">${message}</div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/reviews/editWithImages" 
                              method="post" id="editForm" enctype="multipart/form-data">
                            
                            <!-- 숨겨진 필드들 -->
                            <input type="hidden" name="reviewNum" value="${review.reviewNum}">
                            <input type="hidden" name="userNum" value="${review.userNum}">
                            <input type="hidden" name="chainNum" value="${review.chainNum}">
                            <input type="hidden" name="deleteImages" id="deleteImagesInput">
                            
                            <!-- 가맹점 정보 (읽기 전용) -->
                            <div class="mb-4">
                                <label class="form-label fw-bold">가맹점</label>
                                <div class="p-3 bg-light rounded border">
                                    <div class="d-flex align-items-center">
                                        <img src="${pageContext.request.contextPath}/resources/images/chains/default-chain.jpg" 
                                             class="rounded me-3" width="60" height="60" alt="${review.chainName}"
                                             onerror="this.src='${pageContext.request.contextPath}/resources/images/default-chain.jpg'">
                                        <div>
                                            <h6 class="mb-1">${review.chainName}</h6>
                                            <p class="text-muted mb-0 small">${review.chainAddress}</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 평점 입력 -->
                            <div class="mb-4">
                                <label class="form-label fw-bold">평점 <span class="text-danger">*</span></label>
                                <div class="rating-container mb-2">
                                    <c:forEach begin="1" end="5" var="star">
                                        <i class="fas fa-star rating-input" data-rating="${star}"></i>
                                    </c:forEach>
                                </div>
                                <input type="hidden" name="rating" id="ratingValue" value="${review.rating}" required>
                                <div class="form-text text-muted">
                                    <i class="fas fa-star text-warning me-1"></i>
                                    현재 평점: ${review.formattedRating}점
                                </div>
                            </div>
                            
                            <!-- 제목 입력 -->
                            <div class="mb-4">
                                <label for="title" class="form-label fw-bold">제목 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="title" name="title" 
                                       value="${review.title}" placeholder="리뷰 제목을 입력하세요" 
                                       maxlength="100" required>
                                <div class="form-text text-end">
                                    <span id="titleCount">0</span> / 100자
                                </div>
                            </div>
                            
                            <!-- 기존 이미지 관리 -->
                            <c:if test="${review.hasImages()}">
                                <div class="mb-4">
                                    <label class="form-label fw-bold">기존 이미지 <span class="text-muted">(${review.imageCount}개)</span></label>
                                    <div class="image-preview-container" id="existingImages">
                                        <c:forEach var="image" items="${review.images}">
                                            <div class="existing-image" data-image-id="${image.imageNum}" data-original-order="${image.imageOrder}">
                                                <!-- 이미지 표시 -->
                                                <img src="${pageContext.request.contextPath}/displayFile?fileName=${image.imagePath}" 
                                                     alt="${image.originalName}"
                                                     onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                
                                                <!-- 이미지 로드 실패 시 대체 표시 -->
                                                <div class="image-error" style="display: none;">
                                                    <i class="fas fa-exclamation-triangle mb-1"></i>
                                                    <div>이미지 로드 실패</div>
                                                    <small>${image.originalName}</small>
                                                </div>
                                                
                                                <button type="button" class="image-action-btn image-delete-btn" 
                                                        onclick="toggleDeleteImage(${image.imageNum})" 
                                                        title="삭제 표시">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                                <div class="image-order-badge">${image.imageOrder}</div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div class="form-text">
                                        <i class="fas fa-info-circle me-1"></i>
                                        삭제할 이미지를 클릭하여 삭제 표시하세요. 이미지를 드래그하여 순서를 변경할 수 있습니다.
                                    </div>
                                </div>
                            </c:if>
                            
                            <!-- 새 이미지 추가 -->
                            <div class="mb-4">
                                <label class="form-label fw-bold">새 이미지 추가 <span class="text-muted">(선택사항)</span></label>
                                <div class="new-image-upload" id="newImageUpload">
                                    <i class="fas fa-plus-circle fa-2x text-muted mb-2"></i>
                                    <p class="mb-1">새 이미지 추가</p>
                                    <small class="text-muted">클릭 또는 드래그앤드롭 (최대 ${5 - review.imageCount}개 추가 가능)</small>
                                </div>
                                <input type="file" id="newImageInput" name="newImages" multiple accept="image/*" style="display: none;">
                                
                                <!-- 새 이미지 미리보기 -->
                                <div class="image-preview-container" id="newImagePreview"></div>
                            </div>
                            
                            <!-- 내용 입력 -->
                            <div class="mb-4">
                                <label for="content" class="form-label fw-bold">내용 <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="content" name="content" rows="8" 
                                          placeholder="가맹점 이용 경험을 자세히 작성해주세요." 
                                          maxlength="2000" required>${review.content}</textarea>
                                <div class="form-text text-end">
                                    <span id="contentCount">0</span> / 2000자
                                </div>
                            </div>
                            
                            <!-- 수정 팁 -->
                            <div class="alert alert-light border">
                                <h6 class="text-primary"><i class="fas fa-lightbulb me-2"></i>리뷰 수정 안내</h6>
                                <ul class="mb-0 small">
                                    <li>수정된 내용은 즉시 반영됩니다</li>
                                    <li>가맹점은 변경할 수 없습니다</li>
                                    <li>평점, 제목, 내용, 이미지를 수정할 수 있습니다</li>
                                    <li>이미지는 기존 이미지 포함 최대 5개까지 가능합니다</li>
                                    <li>욕설이나 비방은 삼가해주세요</li>
                                </ul>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary" id="submitBtn">
                                    <i class="fas fa-save me-1"></i>수정 완료
                                </button>
                                <a href="${pageContext.request.contextPath}/reviews/detail/${review.reviewNum}" 
                                   class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-1"></i>취소
                                </a>
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
        let selectedRating = ${review.rating};
        let deletedImageIds = [];
        let newImages = [];
        const maxTotalImages = 5;
        const currentImageCount = ${review.imageCount};
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            console.log('=== 리뷰 수정 페이지 로드됨 ===');
            console.log('기존 평점:', selectedRating);
            console.log('기존 이미지 개수:', currentImageCount);
            
            // DOM 상태 확인
            console.log('기존 이미지 요소들:', document.querySelectorAll('[data-image-id]'));
            document.querySelectorAll('[data-image-id]').forEach(el => {
                console.log('이미지 ID:', el.getAttribute('data-image-id'), '요소:', el);
            });
            
            // 기존 평점 표시
            updateStarDisplay(selectedRating);
            document.getElementById('ratingValue').value = selectedRating;
            
            // 글자수 초기화
            updateCharacterCounts();
            
            // 이벤트 리스너 설정
            initRatingSystem();
            initNewImageUpload();
            setupEventListeners();
        });
        
        // ===== 평점 시스템 =====
        function initRatingSystem() {
            const stars = document.querySelectorAll('.rating-input');
            
            stars.forEach((star, index) => {
                star.addEventListener('click', function(e) {
                    e.preventDefault();
                    selectedRating = parseInt(this.dataset.rating);
                    document.getElementById('ratingValue').value = selectedRating;
                    updateStarDisplay(selectedRating);
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
        
        // ===== 기존 이미지 관리 (완전 수정 버전) =====
        function toggleDeleteImage(imageId) {
            console.log('=== toggleDeleteImage 시작 ===');
            console.log('전달받은 imageId:', imageId, '타입:', typeof imageId);
            
            // imageId를 숫자로 변환 (문자열로 전달될 수 있음)
            const numericImageId = parseInt(imageId);
            if (isNaN(numericImageId)) {
                console.error('잘못된 imageId:', imageId);
                alert('잘못된 이미지 ID입니다.');
                return;
            }
            
            // 1. DOM 요소 존재 확인
            console.log('DOM 검색 중...');
            const imageElement = document.querySelector('[data-image-id="' + numericImageId + '"]');
            console.log('선택자 [data-image-id="' + numericImageId + '"]로 찾은 요소:', imageElement);
            
            if (!imageElement) {
                console.error('이미지 요소를 찾을 수 없습니다.');
                console.log('페이지의 모든 data-image-id 속성들:');
                document.querySelectorAll('[data-image-id]').forEach(el => {
                    console.log('  -', el.getAttribute('data-image-id'), el);
                });
                
                alert('이미지 요소를 찾을 수 없습니다 (ID: ' + numericImageId + '). 페이지를 새로고침 해보세요.');
                return;
            }
            
            // 2. 버튼 요소 찾기
            const deleteBtn = imageElement.querySelector('.image-action-btn');
            if (!deleteBtn) {
                console.error('삭제 버튼을 찾을 수 없습니다.');
                return;
            }
            
            console.log('현재 deletedImageIds 상태:', deletedImageIds);
            
            // 3. 삭제 상태 토글
            const isCurrentlyMarked = deletedImageIds.includes(numericImageId);
            
            if (isCurrentlyMarked) {
                // 삭제 표시 해제
                deletedImageIds = deletedImageIds.filter(id => id !== numericImageId);
                imageElement.classList.remove('marked-delete');
                deleteBtn.innerHTML = '<i class="fas fa-trash"></i>';
                deleteBtn.title = '삭제 표시';
                deleteBtn.className = 'image-action-btn image-delete-btn';
                console.log('삭제 표시 해제됨');
            } else {
                // 삭제 표시
                deletedImageIds.push(numericImageId);
                imageElement.classList.add('marked-delete');
                deleteBtn.innerHTML = '<i class="fas fa-undo"></i>';
                deleteBtn.title = '삭제 취소';
                deleteBtn.className = 'image-action-btn image-restore-btn';
                console.log('삭제 표시됨');
            }
            
            // 4. 상태 업데이트
            updateDeleteImagesInput();
            updateNewImageUploadStatus();
            
            console.log('업데이트된 deletedImageIds:', deletedImageIds);
            console.log('=== toggleDeleteImage 완료 ===');
        }
        
        function updateDeleteImagesInput() {
            const input = document.getElementById('deleteImagesInput');
            if (input) {
                input.value = deletedImageIds.join(',');
                console.log('삭제 이미지 입력 필드 업데이트:', input.value);
            }
        }
        
        // ===== 새 이미지 업로드 =====
        function initNewImageUpload() {
            const uploadArea = document.getElementById('newImageUpload');
            const imageInput = document.getElementById('newImageInput');
            
            uploadArea.addEventListener('click', function() {
                if (canAddMoreImages()) {
                    imageInput.click();
                }
            });
            
            imageInput.addEventListener('change', function(e) {
                handleNewImages(e.target.files);
            });
            
            // 드래그앤드롭
            uploadArea.addEventListener('dragover', function(e) {
                e.preventDefault();
                if (canAddMoreImages()) {
                    uploadArea.style.borderColor = 'var(--brand)';
                    uploadArea.style.backgroundColor = '#fff5ea';
                }
            });
            
            uploadArea.addEventListener('dragleave', function(e) {
                e.preventDefault();
                uploadArea.style.borderColor = '#ddd';
                uploadArea.style.backgroundColor = '#fafafa';
            });
            
            uploadArea.addEventListener('drop', function(e) {
                e.preventDefault();
                uploadArea.style.borderColor = '#ddd';
                uploadArea.style.backgroundColor = '#fafafa';
                
                if (canAddMoreImages()) {
                    handleNewImages(e.dataTransfer.files);
                }
            });
        }
        
        function canAddMoreImages() {
            const remainingSlots = maxTotalImages - (currentImageCount - deletedImageIds.length + newImages.length);
            return remainingSlots > 0;
        }
        
        function updateNewImageUploadStatus() {
            const uploadArea = document.getElementById('newImageUpload');
            const remainingSlots = maxTotalImages - (currentImageCount - deletedImageIds.length + newImages.length);
            
            if (remainingSlots <= 0) {
                uploadArea.style.display = 'none';
            } else {
                uploadArea.style.display = 'block';
                const smallText = uploadArea.querySelector('small');
                if (smallText) {
                    smallText.textContent = '클릭 또는 드래그앤드롭 (최대 ' + remainingSlots + '개 추가 가능)';
                }
            }
        }
        
        function handleNewImages(files) {
            const remainingSlots = maxTotalImages - (currentImageCount - deletedImageIds.length + newImages.length);
            const fileArray = Array.from(files);
            const filesToProcess = fileArray.slice(0, remainingSlots);
            
            if (fileArray.length > remainingSlots) {
                alert(remainingSlots + '개 파일만 업로드됩니다. (최대 ' + maxTotalImages + '개 제한)');
            }
            
            filesToProcess.forEach(file => {
                if (validateImageFile(file)) {
                    addNewImagePreview(file);
                }
            });
            
            updateNewImageUploadStatus();
        }
        
        function validateImageFile(file) {
            if (!file.type.startsWith('image/')) {
                alert(file.name + ': 이미지 파일만 업로드 가능합니다.');
                return false;
            }
            
            if (file.size > 10 * 1024 * 1024) {
                alert(file.name + ': 파일 크기가 10MB를 초과합니다.');
                return false;
            }
            
            return true;
        }
        
        function addNewImagePreview(file) {
            const previewContainer = document.getElementById('newImagePreview');
            const previewId = 'new_' + Date.now();
            
            const previewDiv = document.createElement('div');
            previewDiv.className = 'new-image-preview';
            previewDiv.id = previewId;
            
            const reader = new FileReader();
            reader.onload = function(e) {
                previewDiv.innerHTML = 
                    '<img src="' + e.target.result + '" alt="새 이미지">' +
                    '<div class="new-label">NEW</div>' +
                    '<button type="button" class="image-action-btn image-delete-btn" ' +
                            'onclick="removeNewImage(\'' + previewId + '\')" title="제거">' +
                        '<i class="fas fa-times"></i>' +
                    '</button>' +
                    '<div class="image-order-badge">' + (currentImageCount - deletedImageIds.length + newImages.length + 1) + '</div>';
            };
            reader.readAsDataURL(file);
            
            previewContainer.appendChild(previewDiv);
            newImages.push({ id: previewId, file: file });
        }
        
        function removeNewImage(previewId) {
            document.getElementById(previewId).remove();
            newImages = newImages.filter(img => img.id !== previewId);
            updateNewImageUploadStatus();
        }
        
        // ===== 이벤트 리스너 =====
        function setupEventListeners() {
            // 제목 글자수 카운트
            document.getElementById('title').addEventListener('input', function() {
                const count = this.value.length;
                document.getElementById('titleCount').textContent = count;
                document.getElementById('titleCount').style.color = count > 90 ? '#dc3545' : '#6c757d';
            });
            
            // 내용 글자수 카운트
            document.getElementById('content').addEventListener('input', function() {
                const count = this.value.length;
                document.getElementById('contentCount').textContent = count;
                document.getElementById('contentCount').style.color = count > 1900 ? '#dc3545' : '#6c757d';
            });
        }
        
        function updateCharacterCounts() {
            const title = document.getElementById('title');
            const content = document.getElementById('content');
            
            document.getElementById('titleCount').textContent = title.value.length;
            document.getElementById('contentCount').textContent = content.value.length;
        }
        
        // ===== 폼 제출 처리 =====
        document.getElementById('editForm').addEventListener('submit', function(e) {
            // 평점 확인
            const ratingValue = document.getElementById('ratingValue').value;
            if (!ratingValue || ratingValue < 1 || ratingValue > 5) {
                e.preventDefault();
                alert('평점을 선택해주세요 (1-5점).');
                return;
            }
            
            // 제목 확인
            const title = document.getElementById('title').value.trim();
            if (!title) {
                e.preventDefault();
                alert('제목을 입력해주세요.');
                document.getElementById('title').focus();
                return;
            }
            
            // 내용 확인
            const content = document.getElementById('content').value.trim();
            if (content.length < 10) {
                e.preventDefault();
                alert('리뷰 내용을 10글자 이상 입력해주세요.');
                document.getElementById('content').focus();
                return;
            }
            
            // 최종 확인
            let confirmMessage = '리뷰를 수정하시겠습니까?';
            if (deletedImageIds.length > 0) {
                confirmMessage += '\n삭제될 이미지: ' + deletedImageIds.length + '개';
            }
            if (newImages.length > 0) {
                confirmMessage += '\n추가될 이미지: ' + newImages.length + '개';
            }
            
            if (!confirm(confirmMessage)) {
                e.preventDefault();
                return;
            }
            
            console.log('리뷰 수정 폼 제출 승인');
            
            // 제출 버튼 비활성화
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>수정 중...';
        });
        
        // ===== 디버깅 함수 (개발용) =====
        window.debugReviewEdit = function() {
            console.log('=== 디버깅 정보 ===');
            console.log('선택된 평점:', selectedRating);
            console.log('삭제 예정 이미지 IDs:', deletedImageIds);
            console.log('새 이미지 개수:', newImages.length);
            console.log('현재 이미지 개수:', currentImageCount);
            console.log('기존 이미지 요소들:', document.querySelectorAll('[data-image-id]'));
        };
    </script>
</body>
</html>