<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>문의사항 - 헬킹 피트니스</title>
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
        
        .inquiry-card {
            background: white;
            border: 1px solid var(--line);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            transition: all 0.2s;
            cursor: pointer;
        }
        
        .inquiry-card:hover {
            box-shadow: 0 4px 15px rgba(15,23,42,0.1);
            transform: translateY(-2px);
        }
        
        .inquiry-title {
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--ink);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .inquiry-title a {
            color: inherit;
            text-decoration: none;
            flex: 1;
        }
        
        .inquiry-title a:hover {
            color: var(--brand);
        }
        
        .inquiry-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
            margin-bottom: 15px;
            font-size: 0.9rem;
            color: var(--muted);
        }
        
        .meta-item {
            display: flex;
            align-items: center;
        }
        
        .meta-icon {
            margin-right: 5px;
            width: 14px;
        }
        
        .inquiry-content {
            color: var(--muted);
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .inquiry-badges {
            display: flex;
            gap: 8px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .status-badge {
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        
        .status-waiting {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-answered {
            background: #d4edda;
            color: #155724;
        }
        
        .privacy-badge {
            background: #f8d7da;
            color: #721c24;
            padding: 4px 8px;
            border-radius: 10px;
            font-size: 0.7rem;
        }
        
        .privacy-badge.public {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .reply-count {
            background: var(--brand);
            color: white;
            padding: 2px 6px;
            border-radius: 10px;
            font-size: 0.7rem;
        }
        
        .attachment-indicator {
            color: var(--brand);
            font-size: 0.8rem;
        }
        
        .search-form {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            box-shadow: 0 2px 10px rgba(15,23,42,0.1);
            border: 1px solid var(--line);
        }
        
        .filter-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        .filter-tab {
            padding: 8px 16px;
            border: 1px solid var(--line);
            background: white;
            border-radius: 20px;
            cursor: pointer;
            font-size: 0.9rem;
            font-weight: 500;
            transition: all 0.2s;
            text-decoration: none;
            color: var(--ink);
        }
        
        .filter-tab:hover {
            border-color: var(--brand);
            color: var(--brand);
        }
        
        .filter-tab.active {
            background: var(--brand);
            border-color: var(--brand);
            color: white;
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
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted);
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: var(--line);
        }
        
        .pagination .page-link {
            color: var(--brand);
            border-color: var(--line);
        }
        
        .pagination .page-link:hover {
            background-color: var(--hover);
            border-color: var(--brand);
        }
        
        .pagination .page-item.active .page-link {
            background-color: var(--brand);
            border-color: var(--brand);
        }
        
        .stats-summary {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 30px;
            border: 1px solid var(--line);
        }
        
        .stats-item {
            text-align: center;
            padding: 15px;
        }
        
        .stats-number {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--brand);
        }
        
        .stats-label {
            color: var(--muted);
            font-size: 0.9rem;
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
                    <li class="breadcrumb-item active" style="color: white;">문의사항</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">문의사항</h2>
                    <p class="lead">회원들의 다양한 문의사항과 답변을 확인하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <c:choose>
                        <c:when test="${not empty currentUserNum}">
                            <a href="${pageContext.request.contextPath}/support/inquiry/create" class="btn btn-light btn-lg">
                                <i class="fas fa-plus me-2"></i>문의 작성
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/login" class="btn btn-light btn-lg">
                                <i class="fas fa-sign-in-alt me-2"></i>로그인 후 문의
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <!-- 통계 요약 -->
        <c:if test="${not empty inquiryStats}">
            <div class="stats-summary">
                <div class="row">
                    <div class="col-md-3">
                        <div class="stats-item">
                            <div class="stats-number">${inquiryStats.totalCount}</div>
                            <div class="stats-label">전체 문의</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-item">
                            <div class="stats-number">${inquiryStats.waitingCount}</div>
                            <div class="stats-label">답변 대기</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-item">
                            <div class="stats-number">${inquiryStats.answeredCount}</div>
                            <div class="stats-label">답변 완료</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-item">
                            <div class="stats-number">${inquiryStats.todayCount}</div>
                            <div class="stats-label">오늘 문의</div>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        
        <!-- 검색 및 필터 -->
        <div class="search-form">
            <form method="get" action="${pageContext.request.contextPath}/support/inquiry" id="searchForm">
                <div class="row align-items-end">
                    <div class="col-md-8 mb-3">
                        <label for="searchKeyword" class="form-label">검색</label>
                        <div class="input-group">
                            <input type="text" class="form-control" id="searchKeyword" name="searchKeyword" 
                                   value="${searchKeyword}" placeholder="제목이나 내용으로 검색하세요...">
                            <button class="btn btn-outline-primary" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="status" class="form-label">상태 필터</label>
                        <select class="form-select" name="status" id="status" onchange="document.getElementById('searchForm').submit()">
                            <option value="all" ${statusFilter == 'all' ? 'selected' : ''}>전체</option>
                            <option value="waiting" ${statusFilter == 'waiting' ? 'selected' : ''}>답변 대기</option>
                            <option value="answered" ${statusFilter == 'answered' ? 'selected' : ''}>답변 완료</option>
                        </select>
                    </div>
                </div>
                
                <!-- 공개/비공개 필터 -->
                <div class="filter-tabs">
                    <a href="?searchKeyword=${searchKeyword}&status=${statusFilter}&privacy=all" 
                       class="filter-tab ${privacyFilter == 'all' or empty privacyFilter ? 'active' : ''}">
                        전체
                    </a>
                    <a href="?searchKeyword=${searchKeyword}&status=${statusFilter}&privacy=public" 
                       class="filter-tab ${privacyFilter == 'public' ? 'active' : ''}">
                        공개만
                    </a>
                    <c:if test="${not empty currentUserNum}">
                        <a href="?searchKeyword=${searchKeyword}&status=${statusFilter}&privacy=my" 
                           class="filter-tab ${privacyFilter == 'my' ? 'active' : ''}">
                            내 문의
                        </a>
                    </c:if>
                </div>
            </form>
        </div>
        
        <!-- 문의사항 목록 -->
        <c:choose>
            <c:when test="${not empty inquiryList}">
                <div class="mb-3">
                    <p class="text-muted">
                        총 <strong>${totalCount}</strong>개의 문의사항 
                        <c:if test="${not empty searchKeyword}">
                            - '<strong>${searchKeyword}</strong>' 검색 결과
                        </c:if>
                    </p>
                </div>
                
                <c:forEach var="inquiry" items="${inquiryList}">
                    <!-- 비공개 문의는 작성자나 관리자만 볼 수 있도록 처리 -->
                    <c:if test="${inquiry.isPrivate != 'Y' or isAdmin or inquiry.createdBy == currentUserNum}">
                        <div class="inquiry-card" onclick="location.href='${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}'">
                            <div class="inquiry-title">
                                <a href="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}">
                                    ${inquiry.title}
                                </a>
                                <div class="inquiry-badges">
                                    <span class="privacy-badge ${inquiry.isPrivate == 'Y' ? '' : 'public'}">
                                        <i class="fas fa-${inquiry.isPrivate == 'Y' ? 'lock' : 'globe'} me-1"></i>
                                        ${inquiry.isPrivate == 'Y' ? '비공개' : '공개'}
                                    </span>
                                    <c:if test="${not empty inquiry.replies and inquiry.replies.size() > 0}">
                                        <span class="reply-count">
                                            <i class="fas fa-comment me-1"></i>${inquiry.replies.size()}
                                        </span>
                                    </c:if>
                                    <c:if test="${inquiry.hasAttachments()}">
                                        <span class="attachment-indicator">
                                            <i class="fas fa-paperclip" title="첨부파일"></i>
                                        </span>
                                    </c:if>
                                </div>
                            </div>
                            
                            <div class="inquiry-meta">
                                <div class="meta-item">
                                    <i class="fas fa-user meta-icon"></i>
                                    ${inquiry.createdByName}
                                </div>
                                <div class="meta-item">
                                    <i class="fas fa-calendar meta-icon"></i>
                                    <fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
                                </div>
                                <div class="meta-item">
                                    <i class="fas fa-eye meta-icon"></i>
                                    ${inquiry.viewCount}회
                                </div>
                                <div class="meta-item">
                                    <span class="status-badge ${empty inquiry.replies or inquiry.replies.size() == 0 ? 'status-waiting' : 'status-answered'}">
                                        ${inquiry.statusDisplayName}
                                    </span>
                                </div>
                            </div>
                            
                            <div class="inquiry-content">
                                ${inquiry.shortContent}
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
                
                <!-- 페이징 -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="문의사항 페이지 네비게이션" class="mt-5">
                        <ul class="pagination justify-content-center">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link" href="?searchKeyword=${searchKeyword}&status=${statusFilter}&privacy=${privacyFilter}&page=${currentPage - 1}">
                                        <i class="fas fa-chevron-left"></i> 이전
                                    </a>
                                </li>
                            </c:if>
                            
                            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                <c:if test="${pageNum >= (currentPage - 2) && pageNum <= (currentPage + 2)}">
                                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?searchKeyword=${searchKeyword}&status=${statusFilter}&privacy=${privacyFilter}&page=${pageNum}">
                                            ${pageNum}
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            
                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link" href="?searchKeyword=${searchKeyword}&status=${statusFilter}&privacy=${privacyFilter}&page=${currentPage + 1}">
                                        다음 <i class="fas fa-chevron-right"></i>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </c:when>
            <c:otherwise>
                <!-- 빈 상태 -->
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <h5 class="fw-bold mb-3">
                        <c:choose>
                            <c:when test="${not empty searchKeyword}">
                                '${searchKeyword}' 검색 결과가 없습니다
                            </c:when>
                            <c:otherwise>
                                등록된 문의사항이 없습니다
                            </c:otherwise>
                        </c:choose>
                    </h5>
                    <p class="mb-4">
                        <c:choose>
                            <c:when test="${not empty searchKeyword}">
                                다른 키워드로 검색해보시거나 새로운 문의를 작성해보세요.
                            </c:when>
                            <c:otherwise>
                                첫 번째 문의사항을 작성해보세요!
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <c:if test="${not empty currentUserNum}">
                        <a href="${pageContext.request.contextPath}/support/inquiry/create" class="btn btn-brand">
                            <i class="fas fa-plus me-2"></i>문의 작성하기
                        </a>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
        
        <!-- 하단 네비게이션 -->
        <div class="border-top pt-4 mt-5">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <div class="d-flex gap-2 flex-wrap">
                        <a href="${pageContext.request.contextPath}/support/" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left me-2"></i>고객지원 홈
                        </a>
                        <a href="${pageContext.request.contextPath}/support/faq" class="btn btn-outline-info">
                            <i class="fas fa-question-circle me-2"></i>FAQ 보기
                        </a>
                    </div>
                </div>
                <div class="col-md-6 text-md-end">
                    <c:if test="${not empty currentUserNum}">
                        <a href="${pageContext.request.contextPath}/support/inquiry/my" class="btn btn-outline-primary me-2">
                            <i class="fas fa-user me-2"></i>내 문의사항
                        </a>
                        <a href="${pageContext.request.contextPath}/support/inquiry/create" class="btn btn-brand">
                            <i class="fas fa-plus me-2"></i>새 문의 작성
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../../common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 문의사항 카드 클릭 시 상세보기로 이동
        document.querySelectorAll('.inquiry-card').forEach(card => {
            card.addEventListener('click', function(e) {
                // 링크 클릭은 기본 동작 허용
                if (e.target.tagName === 'A' || e.target.closest('a')) {
                    return;
                }
                
                const titleLink = this.querySelector('.inquiry-title a');
                if (titleLink) {
                    window.location.href = titleLink.href;
                }
            });
        });
        
        // 키보드 단축키
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey || e.metaKey) {
                switch(e.key) {
                    case 'f':
                        e.preventDefault();
                        document.getElementById('searchKeyword').focus();
                        break;
                    case 'n':
                        if (${not empty currentUserNum}) {
                            e.preventDefault();
                            window.location.href = '${pageContext.request.contextPath}/support/inquiry/create';
                        }
                        break;
                }
            }
        });
        
        // 검색 폼 자동 제출 (상태 변경 시)
        document.getElementById('status').addEventListener('change', function() {
            // 페이지를 1로 리셋
            const form = document.getElementById('searchForm');
            const pageInput = form.querySelector('input[name="page"]');
            if (pageInput) {
                pageInput.value = '1';
            } else {
                const newPageInput = document.createElement('input');
                newPageInput.type = 'hidden';
                newPageInput.name = 'page';
                newPageInput.value = '1';
                form.appendChild(newPageInput);
            }
            form.submit();
        });
        
        // 검색어 하이라이트
        function highlightSearchTerms() {
            const searchTerm = '${searchKeyword}';
            if (!searchTerm) return;
            
            const elements = document.querySelectorAll('.inquiry-title a, .inquiry-content');
            elements.forEach(element => {
                const regex = new RegExp(`(${searchTerm})`, 'gi');
                element.innerHTML = element.innerHTML.replace(regex, '<mark>$1</mark>');
            });
        }
        
        // 페이지 로드 시 검색어 하이라이트
        if ('${searchKeyword}') {
            highlightSearchTerms();
        }
        
        // 실시간 검색 (디바운스)
        let searchTimeout;
        document.getElementById('searchKeyword').addEventListener('input', function() {
            clearTimeout(searchTimeout);
            const query = this.value.trim();
            
            if (query.length >= 2) {
                searchTimeout = setTimeout(() => {
                    // AJAX로 실시간 검색 결과 표시 (선택사항)
                    // 현재는 엔터키나 검색 버튼으로만 검색
                }, 500);
            }
        });
        
        // 카드 호버 효과 개선
        document.querySelectorAll('.inquiry-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.borderColor = 'var(--brand)';
                this.style.boxShadow = '0 8px 25px rgba(255, 106, 0, 0.1)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.borderColor = 'var(--line)';
                this.style.boxShadow = '0 4px 15px rgba(15,23,42,0.1)';
            });
        });
    </script>
</body>
</html>