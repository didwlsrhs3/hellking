<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 작성 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .rating-input {
            font-size: 2rem;
            color: #ddd;
            cursor: pointer;
            transition: color 0.2s;
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
            border-color: #FF6A00;
            background-color: #fff5ea;
        }
        .chain-card.selected {
            border-color: #FF6A00;
            background-color: #fff5ea;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card">
                    <div class="card-header">
                        <h4 class="mb-0">리뷰 작성</h4>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/reviews/write" method="post" id="reviewForm">
                            <!-- 가맹점 선택 -->
                            <div class="mb-4">
                                <label class="form-label">가맹점 선택 <span class="text-danger">*</span></label>
                                <c:choose>
                                    <c:when test="${not empty chain}">
                                        <!-- 특정 가맹점이 지정된 경우 -->
                                        <div class="chain-card selected p-3 rounded">
                                            <div class="d-flex align-items-center">
                                                <img src="${pageContext.request.contextPath}/resources/images/chains/${chain.imagePath != null ? chain.imagePath : 'default-chain.jpg'}" 
                                                     class="rounded me-3" width="60" height="60" alt="${chain.chainName}">
                                                <div>
                                                    <h6 class="mb-1">${chain.chainName}</h6>
                                                    <p class="text-muted mb-0 small">${chain.address}</p>
                                                </div>
                                            </div>
                                        </div>
                                        <input type="hidden" name="chainNum" value="${chain.chainNum}">
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 가맹점 검색 -->
                                        <div class="input-group mb-3">
                                            <input type="text" class="form-control" id="chainSearch" 
                                                   placeholder="가맹점명으로 검색하세요...">
                                            <button class="btn btn-outline-secondary" type="button" onclick="searchChains()">
                                                검색
                                            </button>
                                        </div>
                                        <div id="chainResults" class="mb-3"></div>
                                        <input type="hidden" name="chainNum" id="selectedChainNum" required>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <!-- 평점 입력 -->
                            <div class="mb-4">
                                <label class="form-label">평점 <span class="text-danger">*</span></label>
                                <div class="rating-container mb-2">
                                    <c:forEach begin="1" end="5" var="star">
                                        <i class="fas fa-star rating-input" data-rating="${star}"></i>
                                    </c:forEach>
                                </div>
                                <input type="hidden" name="rating" id="ratingValue" required>
                                <small class="form-text text-muted">별표를 클릭하여 평점을 선택하세요</small>
                            </div>
                            
                            <!-- 제목 입력 -->
                            <div class="mb-4">
                                <label for="title" class="form-label">제목 <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="title" name="title" 
                                       placeholder="리뷰 제목을 입력하세요" maxlength="100" required>
                            </div>
                            
                            <!-- 내용 입력 -->
                            <div class="mb-4">
                                <label for="content" class="form-label">내용 <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="content" name="content" rows="8" 
                                          placeholder="가맹점 이용 경험을 자세히 작성해주세요. 다른 회원들에게 도움이 되는 솔직한 후기를 남겨주세요." 
                                          maxlength="2000" required></textarea>
                                <div class="form-text text-end">
                                    <span id="contentCount">0</span> / 2000자
                                </div>
                            </div>
                            
                            <!-- 리뷰 작성 팁 -->
                            <div class="alert alert-info">
                                <h6><i class="fas fa-lightbulb me-2"></i>좋은 리뷰 작성 팁</h6>
                                <ul class="mb-0 small">
                                    <li>시설의 청결도, 장비 상태, 직원 서비스 등을 구체적으로 작성해주세요</li>
                                    <li>운동 환경, 분위기, 접근성 등도 다른 회원들에게 유용한 정보입니다</li>
                                    <li>욕설이나 비방은 삼가주시고, 건설적인 의견을 남겨주세요</li>
                                </ul>
                            </div>
                            
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary">리뷰 등록</button>
                                <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
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
        // 평점 선택
        document.querySelectorAll('.rating-input').forEach((star, index) => {
            star.addEventListener('click', function() {
                const rating = this.dataset.rating;
                document.getElementById('ratingValue').value = rating;
                
                // 별표 표시 업데이트
                document.querySelectorAll('.rating-input').forEach((s, i) => {
                    if (i < rating) {
                        s.classList.add('active');
                    } else {
                        s.classList.remove('active');
                    }
                });
            });
            
            // 호버 효과
            star.addEventListener('mouseenter', function() {
                const rating = this.dataset.rating;
                document.querySelectorAll('.rating-input').forEach((s, i) => {
                    if (i < rating) {
                        s.style.color = '#ffc107';
                    } else {
                        s.style.color = '#ddd';
                    }
                });
            });
        });
        
        // 마우스가 평점 영역을 벗어날 때
        document.querySelector('.rating-container').addEventListener('mouseleave', function() {
            const selectedRating = document.getElementById('ratingValue').value;
            document.querySelectorAll('.rating-input').forEach((s, i) => {
                if (selectedRating && i < selectedRating) {
                    s.style.color = '#ffc107';
                } else {
                    s.style.color = '#ddd';
                }
            });
        });
        
        // 내용 글자수 카운트
        document.getElementById('content').addEventListener('input', function() {
            const count = this.value.length;
            document.getElementById('contentCount').textContent = count;
            
            if (count > 1900) {
                document.getElementById('contentCount').style.color = '#dc3545';
            } else {
                document.getElementById('contentCount').style.color = '#6c757d';
            }
        });
        
        // 가맹점 검색 (특정 가맹점이 지정되지 않은 경우에만)
        <c:if test="${empty chain}">
        function searchChains() {
            const keyword = document.getElementById('chainSearch').value.trim();
            if (keyword.length < 2) {
                alert('검색어를 2글자 이상 입력해주세요.');
                return;
            }
            
            console.log('검색 시작:', keyword);
            
            fetch('${pageContext.request.contextPath}/chain/suggest?keyword=' + encodeURIComponent(keyword))
            .then(response => {
                console.log('응답 상태:', response.status);
                return response.json();
            })
            .then(data => {
                console.log('받은 데이터:', data);
                
                const results = document.getElementById('chainResults');
                if (data.success && data.chains && data.chains.length > 0) {
                    let html = '<div class="row">';
                    data.chains.forEach(chain => {
                        // null 값 처리
                        const chainName = chain.chainName || '가맹점명 없음';
                        const address = chain.address || '주소 없음';
                        const chainNum = chain.chainNum || 0;
                        
                        console.log('가맹점 처리:', {chainNum, chainName, address});
                        
                        html += `
                            <div class="col-md-6 mb-2">
                                <div class="chain-card p-2 rounded" onclick="selectChain(${chainNum}, '${chainName}', '${address}')">
                                    <div class="d-flex align-items-center">
                                        <div class="me-2">
                                            <strong>${chainName}</strong><br>
                                            <small class="text-muted">${address}</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        `;
                    });
                    html += '</div>';
                    results.innerHTML = html;
                } else {
                    results.innerHTML = '<p class="text-muted">검색 결과가 없습니다.</p>';
                }
            })
            .catch(error => {
                console.error('검색 오류:', error);
                alert('검색 중 오류가 발생했습니다.');
            });
        }
        
        function selectChain(chainNum, chainName, address) {
            console.log('가맹점 선택:', {chainNum, chainName, address});
            
            if (!chainNum || chainNum === 0) {
                alert('잘못된 가맹점 정보입니다.');
                return;
            }
            
            document.getElementById('selectedChainNum').value = chainNum;
            
            // 선택된 가맹점 표시
            const results = document.getElementById('chainResults');
            results.innerHTML = `
                <div class="chain-card selected p-3 rounded">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="mb-1">${chainName}</h6>
                            <p class="text-muted mb-0 small">${address}</p>
                        </div>
                        <button type="button" class="btn btn-sm btn-outline-secondary" onclick="clearSelection()">변경</button>
                    </div>
                </div>
            `;
            
            document.getElementById('chainSearch').value = '';
        }
        
        function clearSelection() {
            document.getElementById('selectedChainNum').value = '';
            document.getElementById('chainResults').innerHTML = '';
        }
        </c:if>
        
        // 폼 제출 전 검증
        document.getElementById('reviewForm').addEventListener('submit', function(e) {
            if (!document.getElementById('ratingValue').value) {
                e.preventDefault();
                alert('평점을 선택해주세요.');
                return;
            }
            
            <c:if test="${empty chain}">
            if (!document.getElementById('selectedChainNum').value) {
                e.preventDefault();
                alert('가맹점을 선택해주세요.');
                return;
            }
            </c:if>
        });
    </script>
</body>
</html>