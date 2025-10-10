<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>내 문의사항 - 헬킹 피트니스</title>
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
            background: linear-gradient(135deg, #667eea, #764ba2);
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
            position: relative;
        }
        
        .inquiry-card:hover {
            box-shadow: 0 4px 15px rgba(15,23,42,0.1);
            transform: translateY(-2px);
        }
        
        .inquiry-title {
            font-weight: 700;
            font-size: 1.2rem;
            color: var(--ink);
            margin-bottom: 10px;
            line-height: 1.4;
        }
        
        .inquiry-title a {
            color: inherit;
            text-decoration: none;
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
        
        .inquiry-actions {
            display: flex;
            justify-content: between;
            align-items: center;
            border-top: 1px solid var(--line);
            padding-top: 15px;
        }
        
        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
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
        
        .status-completed {
            background: #cce5ff;
            color: #004085;
        }
        
        .privacy-badge {
            background: #f8d7da;
            color: #721c24;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.75rem;
            margin-left: 10px;
        }
        
        .privacy-badge.public {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .reply-count {
            background: var(--brand);
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            margin-left: 10px;
        }
        
        .attachment-indicator {
            color: var(--brand);
            margin-left: 10px;
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
        
        .stats-card {
            background: white;
            border: 1px solid var(--line);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            margin-bottom: 30px;
        }
        
        .stats-number {
            font-size: 2rem;
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
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/support/inquiry" style="color: rgba(255,255,255,0.8);">문의사항</a></li>
                    <li class="breadcrumb-item active" style="color: white;">내 문의사항</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">내 문의사항</h2>
                    <p class="lead">작성하신 문의사항과 답변 현황을 확인하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/support/inquiry/create" class="btn btn-light btn-lg">
                        <i class="fas fa-plus me-2"></i>새 문의 작성
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <!-- 통계 카드 -->
        <c:if test="${result.totalCount > 0}">
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="stats-number">${result.totalCount}</div>
                        <div class="stats-label">총 문의사항</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="stats-number">
                            <c:set var="waitingCount" value="0"/>
                            <c:forEach var="inquiry" items="${result.inquiryList}">
                                <c:if test="${empty inquiry.replies or inquiry.replies.size() == 0}">
                                    <c:set var="waitingCount" value="${waitingCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${waitingCount}
                        </div>
                        <div class="stats-label">답변 대기</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="stats-number">
                            <c:set var="answeredCount" value="0"/>
                            <c:forEach var="inquiry" items="${result.inquiryList}">
                                <c:if test="${not empty inquiry.replies and inquiry.replies.size() > 0}">
                                    <c:set var="answeredCount" value="${answeredCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${answeredCount}
                        </div>
                        <div class="stats-label">답변 완료</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="stats-card">
                        <div class="stats-number">
                            <c:set var="attachmentCount" value="0"/>
                            <c:forEach var="inquiry" items="${result.inquiryList}">
                                <c:if test="${inquiry.hasAttachments()}">
                                    <c:set var="attachmentCount" value="${attachmentCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${attachmentCount}
                        </div>
                        <div class="stats-label">첨부파일 포함</div>
                    </div>
                </div>
            </div>
        </c:if>
        
        <!-- 문의사항 목록 -->
        <c:choose>
            <c:when test="${not empty result.inquiryList}">
                <div class="mb-4">
                    <p class="text-muted">
                        총 <strong>${result.totalCount}</strong>개의 문의사항 
                        (${result.currentPage}/${result.totalPages} 페이지)
                    </p>
                </div>
                
                <c:forEach var="inquiry" items="${result.inquiryList}">
                    <div class="inquiry-card">
                        <!-- 문의사항 제목 -->
                        <h5 class="inquiry-title">
                            <a href="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}">
                                ${inquiry.title}
                            </a>
                            <!-- 상태 및 기타 표시 -->
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
                                <span class="attachment-indicator" title="첨부파일 있음">
                                    <i class="fas fa-paperclip"></i>
                                </span>
                            </c:if>
                        </h5>
                        
                        <!-- 메타 정보 -->
                        <div class="inquiry-meta">
                            <div class="meta-item">
                                <i class="fas fa-calendar meta-icon"></i>
                                <fmt:formatDate value="${inquiry.createdAt}" pattern="yyyy.MM.dd HH:mm"/>
                            </div>
                            <div class="meta-item">
                                <i class="fas fa-eye meta-icon"></i>
                                조회 ${inquiry.viewCount}회
                            </div>
                            <c:if test="${inquiry.updatedAt ne inquiry.createdAt}">
                                <div class="meta-item">
                                    <i class="fas fa-edit meta-icon"></i>
                                    수정됨
                                </div>
                            </c:if>
                        </div>
                        
                        <!-- 문의 내용 미리보기 -->
                        <div class="inquiry-content">
                            ${inquiry.shortContent}
                        </div>
                        
                        <!-- 액션 버튼 -->
                        <div class="inquiry-actions">
                            <div>
                                <span class="status-badge ${empty inquiry.replies or inquiry.replies.size() == 0 ? 'status-waiting' : 'status-answered'}">
                                    ${inquiry.statusDisplayName}
                                </span>
                            </div>
                            <div>
                                <a href="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}" 
                                   class="btn btn-sm btn-outline-primary me-2">
                                    <i class="fas fa-eye me-1"></i>상세보기
                                </a>
                                <a href="${pageContext.request.contextPath}/support/inquiry/${inquiry.inquiryNum}/edit" 
                                   class="btn btn-sm btn-outline-secondary">
                                    <i class="fas fa-edit me-1"></i>수정
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <!-- 페이징 -->
                <c:if test="${result.totalPages > 1}">
                    <nav aria-label="내 문의사항 페이지 네비게이션" class="mt-5">
                        <ul class="pagination justify-content-center">
                            <c:if test="${result.hasPrev}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${result.currentPage - 1}&pageSize=${result.pageSize}">
                                        <i class="fas fa-chevron-left"></i> 이전
                                    </a>
                                </li>
                            </c:if>
                            
                            <c:forEach begin="1" end="${result.totalPages}" var="pageNum">
                                <c:if test="${pageNum >= (result.currentPage - 2) && pageNum <= (result.currentPage + 2)}">
                                    <li class="page-item ${pageNum == result.currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${pageNum}&pageSize=${result.pageSize}">
                                            ${pageNum}
                                        </a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            
                            <c:if test="${result.hasNext}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${result.currentPage + 1}&pageSize=${result.pageSize}">
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
                    <h5 class="fw-bold mb-3">작성한 문의사항이 없습니다</h5>
                    <p class="mb-4">궁금한 사항이나 문제점을 문의해보세요.<br>전문 상담사가 빠르게 답변해드립니다.</p>
                    <a href="${pageContext.request.contextPath}/support/inquiry/create" class="btn btn-brand">
                        <i class="fas fa-plus me-2"></i>첫 문의 작성하기
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
        
        <!-- 하단 네비게이션 -->
        <div class="border-top pt-4 mt-5">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <a href="${pageContext.request.contextPath}/support/inquiry" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-2"></i>전체 문의사항 보기
                    </a>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="${pageContext.request.contextPath}/support/" class="btn btn-outline-primary me-2">
                        <i class="fas fa-home me-2"></i>고객지원 홈
                    </a>
                    <a href="${pageContext.request.contextPath}/support/faq" class="btn btn-outline-info">
                        <i class="fas fa-question-circle me-2"></i>FAQ 보기
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../../common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 문의사항 카드 클릭 시 상세보기로 이동
        document.querySelectorAll('.inquiry-card').forEach(card => {
            const titleLink = card.querySelector('.inquiry-title a');
            if (titleLink) {
                card.addEventListener('click', function(e) {
                    // 버튼 클릭 시에는 카드 클릭 이벤트 방지
                    if (!e.target.closest('.btn')) {
                        window.location.href = titleLink.href;
                    }
                });
                
                // 카드에 hover 커서 표시
                card.style.cursor = 'pointer';
            }
        });
        
        // 키보드 단축키
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey || e.metaKey) {
                switch(e.key) {
                    case 'n':
                        e.preventDefault();
                        window.location.href = '${pageContext.request.contextPath}/support/inquiry/create';
                        break;
                }
            }
        });
        
        // 자동 새로고침 (새 답변 확인)
        function checkNewReplies() {
            // 실제 구현에서는 AJAX로 새 답변 확인 후 알림 표시
            // 여기서는 간단한 예시로 페이지 새로고침
        }
        
        // 답변 상태 실시간 업데이트 (선택사항)
        function updateInquiryStatus() {
            // AJAX로 각 문의사항의 답변 상태 확인
        }
        
        // 페이지 로드 시 최신 답변 상태 확인
        document.addEventListener('DOMContentLoaded', function() {
            // updateInquiryStatus();
        });
        
        // 문의사항 삭제 확인
        function deleteInquiry(inquiryNum, title) {
            if (confirm('정말로 "' + title + '" 문의사항을 삭제하시겠습니까?\n\n삭제된 문의사항은 복구할 수 없습니다.')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/support/inquiry/' + inquiryNum + '/delete';
                document.body.appendChild(form);
                form.submit();
            }
        }
        
        // 상태별 필터링 (클라이언트 사이드)
        function filterByStatus(status) {
            const cards = document.querySelectorAll('.inquiry-card');
            
            cards.forEach(card => {
                const statusBadge = card.querySelector('.status-badge');
                if (status === 'all' || statusBadge.textContent.includes(status)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
        
        // 검색 기능 (클라이언트 사이드)
        function searchInquiries(keyword) {
            const cards = document.querySelectorAll('.inquiry-card');
            const lowerKeyword = keyword.toLowerCase();
            
            cards.forEach(card => {
                const title = card.querySelector('.inquiry-title a').textContent.toLowerCase();
                const content = card.querySelector('.inquiry-content').textContent.toLowerCase();
                
                if (title.includes(lowerKeyword) || content.includes(lowerKeyword)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>
</body>
</html>