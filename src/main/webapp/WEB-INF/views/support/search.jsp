<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>통합 검색 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
            --muted: #5B6170;
            --line: #E7E0D6;
            --hover: #FFF5EA;
        }
        
        .page-header {
            background: var(--bg-cream);
            padding: 40px 0;
            border-bottom: 1px solid var(--line);
        }
        
        .search-hero {
            background: linear-gradient(135deg, var(--brand), #ff8533);
            color: white;
            padding: 60px 0;
            text-align: center;
        }
        
        .search-box {
            background: white;
            border-radius: 16px;
            padding: 40px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            margin-top: -30px;
            position: relative;
            z-index: 10;
            border: 1px solid var(--line);
        }
        
        .search-input {
            border: 2px solid var(--line);
            border-radius: 50px;
            padding: 15px 25px;
            font-size: 1.1rem;
        }
        
        .search-input:focus {
            border-color: var(--brand);
            box-shadow: 0 0 0 0.2rem rgba(255, 106, 0, 0.25);
        }
        
        .btn-search {
            background: var(--brand);
            border-color: var(--brand);
            color: white;
            font-weight: 600;
            padding: 15px 30px;
            border-radius: 50px;
        }
        
        .btn-search:hover {
            background: #e55a00;
            border-color: #e55a00;
            color: white;
        }
        
        .search-filters {
            margin-top: 30px;
            padding-top: 30px;
            border-top: 1px solid var(--line);
        }
        
        .filter-tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        
        .filter-tab {
            padding: 10px 20px;
            border: 2px solid var(--line);
            background: white;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
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
        
        .result-section {
            margin-bottom: 40px;
        }
        
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--brand);
        }
        
        .section-title {
            color: var(--ink);
            font-weight: 700;
            margin: 0;
        }
        
        .result-count {
            color: var(--muted);
            font-size: 0.9rem;
        }
        
        .result-item {
            background: white;
            border: 1px solid var(--line);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.2s;
        }
        
        .result-item:hover {
            box-shadow: 0 4px 15px rgba(15,23,42,0.1);
            transform: translateY(-2px);
        }
        
        .result-title {
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--ink);
            margin-bottom: 10px;
        }
        
        .result-title a {
            color: inherit;
            text-decoration: none;
        }
        
        .result-title a:hover {
            color: var(--brand);
        }
        
        .result-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 10px;
            font-size: 0.9rem;
            color: var(--muted);
        }
        
        .result-snippet {
            color: var(--muted);
            line-height: 1.6;
        }
        
        .highlight {
            background: yellow;
            padding: 1px 2px;
            border-radius: 2px;
        }
        
        .empty-results {
            text-align: center;
            padding: 60px 20px;
            color: var(--muted);
        }
        
        .empty-results i {
            font-size: 4rem;
            margin-bottom: 20px;
            color: var(--line);
        }
        
        .suggested-actions {
            background: var(--bg-cream);
            border-radius: 12px;
            padding: 30px;
            margin-top: 30px;
        }
        
        .action-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }
        
        .action-card {
            background: white;
            border: 1px solid var(--line);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            transition: all 0.2s;
        }
        
        .action-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(15,23,42,0.1);
        }
        
        .action-icon {
            font-size: 2rem;
            color: var(--brand);
            margin-bottom: 15px;
        }
        
        .breadcrumb {
            background: transparent;
            padding: 0;
            margin-bottom: 20px;
        }
        
        .breadcrumb-item + .breadcrumb-item::before {
            color: var(--muted);
        }
        
        .debug-info {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- Search Hero -->
    <div class="search-hero">
        <div class="container">
            <h1 class="display-4 fw-bold mb-3">통합 검색</h1>
            <p class="lead mb-0">FAQ와 문의사항을 한 번에 검색하세요</p>
        </div>
    </div>
    
    <!-- Search Box -->
    <div class="container">
        <div class="search-box">
            <form method="get" action="${pageContext.request.contextPath}/support/search" id="searchForm">
                <div class="row align-items-center">
                    <div class="col-md-8 mb-3 mb-md-0">
                        <input type="text" name="q" class="form-control search-input" 
                               value="${searchKeyword}" placeholder="궁금한 내용을 검색해보세요..."
                               id="searchInput">
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-search w-100">
                            <i class="fas fa-search me-2"></i>검색
                        </button>
                    </div>
                </div>
                
                <!-- 필터 탭 -->
                <div class="search-filters">
                    <div class="filter-tabs">
                        <a href="?q=${searchKeyword}&type=all" 
                           class="filter-tab ${searchType == 'all' or empty searchType ? 'active' : ''}">
                            전체
                        </a>
                        <a href="?q=${searchKeyword}&type=faq" 
                           class="filter-tab ${searchType == 'faq' ? 'active' : ''}">
                            FAQ
                        </a>
                        <a href="?q=${searchKeyword}&type=inquiry" 
                           class="filter-tab ${searchType == 'inquiry' ? 'active' : ''}">
                            문의사항
                        </a>
                    </div>
                </div>
                
                <input type="hidden" name="type" value="${searchType}">
                <input type="hidden" name="page" value="${currentPage}">
            </form>
        </div>
    </div>
    
    <div class="container py-5">
        <!-- 디버그 정보 -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
            </div>
        </c:if>
       
        
        <!-- 검색어 입력된 경우에만 결과 표시 -->
        <c:if test="${not empty searchKeyword}">
            <!-- 검색 결과 -->
            <div class="mb-4">
                <h4 class="fw-bold">'${searchKeyword}' 검색 결과</h4>
            </div>
            
            <!-- FAQ 결과 -->
            <c:if test="${searchType == 'all' or searchType == 'faq'}">
                <c:if test="${not empty faqResult.faqList}">
                    <div class="result-section">
                        <div class="section-header">
                            <h5 class="section-title">
                                <i class="fas fa-question-circle me-2"></i>FAQ
                            </h5>
                            <span class="result-count">${faqResult.totalCount}건</span>
                        </div>
                        
                        <c:forEach var="faq" items="${faqResult.faqList}" end="4">
                            <div class="result-item">
                                <h6 class="result-title">
                                    <a href="${pageContext.request.contextPath}/support/faq/detail?faqNum=${faq.faqNum}">
                                        ${faq.title}
                                    </a>
                                </h6>
                                <div class="result-meta">
                                    <span><i class="fas fa-user me-1"></i>${faq.createdByName}</span>
                                    <span><i class="fas fa-calendar me-1"></i><fmt:formatDate value="${faq.createdAt}" pattern="yyyy.MM.dd"/></span>
                                    <span><i class="fas fa-eye me-1"></i>${faq.viewCount}회</span>
                                </div>
                                <p class="result-snippet">${faq.shortContent}</p>
                            </div>
                        </c:forEach>
                        
                        <c:if test="${faqResult.totalCount > 5}">
                            <div class="text-center">
                                <a href="${pageContext.request.contextPath}/support/faq?searchKeyword=${searchKeyword}" 
                                   class="btn btn-outline-primary">
                                    FAQ에서 더보기 (${faqResult.totalCount - 5}건)
                                </a>
                            </div>
                        </c:if>
                    </div>
                </c:if>
            </c:if>
            
            <!-- 문의사항 결과 -->
			<!-- 문의사항 결과 섹션 - HTML 이스케이프 처리 추가 -->
			<c:if test="${searchType == 'all' or searchType == 'inquiry'}">
			    <c:if test="${not empty inquiryResult.inquiryList}">
			        <div class="result-section">
			            <div class="section-header">
			                <h5 class="section-title">
			                    <i class="fas fa-comments me-2"></i>문의사항
			                </h5>
			                <span class="result-count">${inquiryResult.totalCount}건</span>
			            </div>
			            
			            <c:forEach var="inquiry" items="${inquiryResult.inquiryList}" end="4">
			                <c:if test="${inquiry.isPrivate != 'Y' or isAdmin or inquiry.createdBy == currentUserNum}">
			                    <div class="result-item">
			                        <h6 class="result-title">
			                            <a href="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}">
			                                <c:out value="${inquiry.title}" escapeXml="true"/>
			                            </a>
			                            <c:if test="${inquiry.isPrivate == 'Y'}">
			                                <i class="fas fa-lock text-warning ms-2" title="비공개"></i>
			                            </c:if>
			                            <c:if test="${not empty inquiry.replies and inquiry.replies.size() > 0}">
			                                <span class="badge bg-primary ms-2">${inquiry.replies.size()}</span>
			                            </c:if>
			                        </h6>
			                        <div class="result-meta">
			                            <span><i class="fas fa-user me-1"></i><c:out value="${inquiry.createdByName}" escapeXml="true"/></span>
			                            <span><i class="fas fa-calendar me-1"></i><fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy.MM.dd"/></span>
			                            <span><i class="fas fa-eye me-1"></i>${inquiry.viewCount}회</span>
			                            <span class="badge bg-${empty inquiry.replies or inquiry.replies.size() == 0 ? 'warning' : 'success'} ms-2">
			                                ${inquiry.statusDisplayName}
			                            </span>
			                        </div>
			                        <p class="result-snippet"><c:out value="${inquiry.shortContent}" escapeXml="true"/></p>
			                    </div>
			                </c:if>
			            </c:forEach>
			            
			            <c:if test="${inquiryResult.totalCount > 5}">
			                <div class="text-center">
			                    <a href="${pageContext.request.contextPath}/support/inquiry?searchKeyword=${searchKeyword}" 
			                       class="btn btn-outline-primary">
			                        문의사항에서 더보기 (${inquiryResult.totalCount - 5}건)
			                    </a>
			                </div>
			            </c:if>
			        </div>
			    </c:if>
			</c:if>
            
            <!-- 검색 결과가 없는 경우 -->
            <c:if test="${(empty faqResult or empty faqResult.faqList) and (empty inquiryResult or empty inquiryResult.inquiryList)}">
                <div class="empty-results">
                    <i class="fas fa-search"></i>
                    <h5 class="fw-bold mb-3">'${searchKeyword}' 검색 결과가 없습니다</h5>
                    <p class="mb-4">
                        다른 키워드로 검색해보시거나, 아래 추천 기능을 이용해보세요.
                    </p>
                </div>
                
                <!-- 추천 액션 -->
                <div class="suggested-actions">
                    <h6 class="fw-bold text-center mb-4">이런 방법은 어떠세요?</h6>
                    <div class="action-grid">
                        <a href="${pageContext.request.contextPath}/support/faq" class="action-card text-decoration-none">
                            <div class="action-icon">
                                <i class="fas fa-question-circle"></i>
                            </div>
                            <h6 class="fw-bold">전체 FAQ 보기</h6>
                            <p class="text-muted mb-0">자주 묻는 질문들을 둘러보세요</p>
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/support/inquiry/create" class="action-card text-decoration-none">
                            <div class="action-icon">
                                <i class="fas fa-edit"></i>
                            </div>
                            <h6 class="fw-bold">새 문의 작성</h6>
                            <p class="text-muted mb-0">직접 문의사항을 남겨보세요</p>
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/support/consultation" class="action-card text-decoration-none">
                            <div class="action-icon">
                                <i class="fas fa-calendar-check"></i>
                            </div>
                            <h6 class="fw-bold">상담예약</h6>
                            <p class="text-muted mb-0">전문 상담사와 직접 상담하세요</p>
                        </a>
                    </div>
                </div>
            </c:if>
        </c:if>
        
        <!-- 검색어가 없는 경우 -->
        <c:if test="${empty searchKeyword}">
            <div class="text-center py-5">
                <h4 class="fw-bold mb-3">무엇을 도와드릴까요?</h4>
                <p class="text-muted mb-4">궁금한 내용을 검색해보세요</p>
                
                <!-- 인기 검색어 -->
                <div class="mb-4">
                    <h6 class="fw-bold mb-3">인기 검색어</h6>
                    <div class="d-flex justify-content-center flex-wrap gap-2">
                        <a href="?q=패스권" class="btn btn-outline-secondary btn-sm">패스권</a>
                        <a href="?q=환불" class="btn btn-outline-secondary btn-sm">환불</a>
                        <a href="?q=회원가입" class="btn btn-outline-secondary btn-sm">회원가입</a>
                        <a href="?q=이용시간" class="btn btn-outline-secondary btn-sm">이용시간</a>
                        <a href="?q=QR" class="btn btn-outline-secondary btn-sm">QR</a>
                        <a href="?q=가맹점" class="btn btn-outline-secondary btn-sm">가맹점</a>
                    </div>
                </div>
                
                <!-- 카테고리별 바로가기 -->
                <div class="action-grid">
                    <a href="${pageContext.request.contextPath}/support/faq" class="action-card text-decoration-none">
                        <div class="action-icon">
                            <i class="fas fa-question-circle"></i>
                        </div>
                        <h6 class="fw-bold">FAQ</h6>
                        <p class="text-muted mb-0">자주 묻는 질문</p>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/support/inquiry" class="action-card text-decoration-none">
                        <div class="action-icon">
                            <i class="fas fa-comments"></i>
                        </div>
                        <h6 class="fw-bold">문의사항</h6>
                        <p class="text-muted mb-0">1:1 문의하기</p>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/support/consultation" class="action-card text-decoration-none">
                        <div class="action-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h6 class="fw-bold">상담예약</h6>
                        <p class="text-muted mb-0">전문가 상담</p>
                    </a>
                </div>
            </div>
        </c:if>
        
        <!-- 테스트 데이터 로드 버튼 (개발용) -->
        <div class="text-center mt-4">
            <button type="button" class="btn btn-outline-info btn-sm" onclick="testDataLoad()">
                <i class="fas fa-database me-1"></i>테스트 데이터 조회
            </button>
        </div>
    </div>
    
    <jsp:include page="../common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 테스트용 데이터 로드 함수
        function testDataLoad() {
            window.location.href = '${pageContext.request.contextPath}/support/search?q=test&type=all';
        }
        
        // 검색 입력 필드에 포커스
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            if (searchInput && !searchInput.value) {
                searchInput.focus();
            }
        });
        
        // 검색어 하이라이트
        function highlightSearchTerms() {
            const searchTerm = '${searchKeyword}';
            if (!searchTerm) return;
            
            const elements = document.querySelectorAll('.result-snippet, .result-title');
            elements.forEach(element => {
                const regex = new RegExp(`(${searchTerm})`, 'gi');
                element.innerHTML = element.innerHTML.replace(regex, '<span class="highlight">$1</span>');
            });
        }
        
        // 페이지 로드 시 하이라이트 적용
        if ('${searchKeyword}') {
            highlightSearchTerms();
        }
        
        // 키보드 단축키
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.key === 'k') {
                e.preventDefault();
                document.getElementById('searchInput').focus();
            }
        });
        
        // 검색 히스토리 관리 (로컬 스토리지)
        function saveSearchHistory(query) {
            if (!query.trim()) return;
            
            let history = JSON.parse(localStorage.getItem('searchHistory') || '[]');
            
            // 중복 제거
            history = history.filter(item => item !== query);
            
            // 최신 검색어를 맨 앞에 추가
            history.unshift(query);
            
            // 최대 10개까지만 저장
            if (history.length > 10) {
                history = history.slice(0, 10);
            }
            
            localStorage.setItem('searchHistory', JSON.stringify(history));
        }
        
        // 검색 시 히스토리 저장
        document.getElementById('searchForm').addEventListener('submit', function() {
            const query = document.getElementById('searchInput').value;
            saveSearchHistory(query);
        });
    </script>
</body>
</html>