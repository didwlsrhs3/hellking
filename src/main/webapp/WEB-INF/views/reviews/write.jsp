<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --brand: #FF6A00;
            --bg-cream: #F4ECDC;
        }
        body { background: var(--bg-cream); }
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
        .btn-primary {
            background: var(--brand);
            border-color: var(--brand);
        }
        .btn-primary:hover {
            background: #e55a00;
            border-color: #e55a00;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-4 mb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card shadow">
                    <div class="card-header bg-white">
                        <h4 class="mb-0"><i class="fas fa-edit me-2"></i>리뷰 작성</h4>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/reviews/write" method="post" id="reviewForm">
                            <!-- 사용자 번호 -->
                            <input type="hidden" name="userNum" value="${sessionScope.user.userNum}">
                            
                            <!-- 가맹점 선택 -->
                            <div class="mb-4">
                                <label class="form-label fw-bold">가맹점 선택 <span class="text-danger">*</span></label>
                                <c:choose>
                                    <c:when test="${not empty chain}">
                                        <!-- 특정 가맹점이 지정된 경우 -->
                                        <div class="chain-card selected p-3 rounded">
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
                                        <!-- 가맹점 직접 선택 -->
                                        <select class="form-select" name="chainNum" id="chainSelect" required>
                                            <option value="">가맹점을 선택하세요</option>
                                            <option value="1">헬킹 강남점 - 서울시 강남구 테헤란로 123</option>
                                            <option value="2">헬킹 홍대점 - 서울시 마포구 홍익로 456</option>
                                            <option value="3">헬킹 잠실점 - 서울시 송파구 잠실동 789</option>
                                            <option value="4">헬킹 부산점 - 부산시 해운대구 해운대로 321</option>
                                            <option value="5">헬킹 대구점 - 대구시 수성구 범어동 654</option>
                                        </select>
                                        <div class="form-text text-muted">
                                            <i class="fas fa-info-circle me-1"></i>
                                            리뷰를 작성할 가맹점을 선택해주세요.
                                        </div>
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
        const hasChain = ${not empty chain ? 'true' : 'false'};
        console.log('페이지 초기화, hasChain:', hasChain);
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            console.log('리뷰 작성 페이지 로드됨');
            initRatingSystem();
            setupEventListeners();
            updateSubmitButton();
        });
        
        // 평점 시스템 초기화
        function initRatingSystem() {
            const stars = document.querySelectorAll('.rating-input');
            console.log('별 개수:', stars.length);
            
            stars.forEach((star, index) => {
                star.addEventListener('click', function(e) {
                    e.preventDefault();
                    selectedRating = parseInt(this.dataset.rating);
                    document.getElementById('ratingValue').value = selectedRating;
                    console.log('평점 선택됨:', selectedRating);
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
        
        // 별표 표시 업데이트
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
        
        // 이벤트 리스너 설정
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
        
        // 제출 버튼 활성화 체크
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
            
            if (!confirm('리뷰를 등록하시겠습니까?')) {
                e.preventDefault();
                return;
            }
            
            console.log('폼 제출 승인');
            
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>등록 중...';
        });
    </script>
</body>
</html>