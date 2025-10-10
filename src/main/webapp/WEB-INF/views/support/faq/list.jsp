<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>자주 묻는 질문 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
            background: white; 
        }
        
        .page-header {
            background: linear-gradient(135deg, #6f42c1, #e83e8c);
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
        
        .faq-item {
            background: white;
            border: 1px solid var(--line);
            border-radius: 12px;
            margin-bottom: 15px;
            overflow: hidden;
            transition: all 0.2s;
        }
        
        .faq-item:hover {
            box-shadow: 0 4px 15px rgba(15,23,42,0.1);
        }
        
        .faq-question {
            padding: 20px;
            background: white;
            border: none;
            width: 100%;
            text-align: left;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            font-weight: 600;
            color: var(--ink);
        }
        
        .faq-question:hover {
            background: var(--hover);
        }
        
        .faq-answer {
            padding: 0 20px 20px;
            color: var(--muted);
            line-height: 1.6;
            display: none;
        }
        
        .faq-answer.show {
            display: block;
        }
        
        .faq-icon {
            color: #6f42c1;
            transition: transform 0.2s;
        }
        
        .faq-icon.rotate {
            transform: rotate(180deg);
        }
        
        .search-box {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 15px rgba(15,23,42,0.1);
            margin-bottom: 30px;
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
        
        .pagination .page-link {
            color: #6f42c1;
            border-color: var(--line);
        }
        
        .pagination .page-link:hover {
            background-color: rgba(111, 66, 193, 0.1);
            border-color: #6f42c1;
        }
        
        .pagination .page-item.active .page-link {
            background-color: #6f42c1;
            border-color: #6f42c1;
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
    
    <!-- FAQ 목록 헤더 -->
    <div class="page-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">자주 묻는 질문</h2>
                    <p class="lead">궁금한 점을 빠르게 해결해보세요. 실제 회원들의 생생한 후기를 확인해보세요.</p>
                </div>
                <div class="col-md-4 text-end">
                    <c:if test="${isAdmin}">
                        <a href="${pageContext.request.contextPath}/support/faq/create" class="btn btn-outline-light">
                            <i class="fas fa-plus me-2"></i>FAQ 등록
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
<%--         <!-- 디버그 정보 (임시) -->
        <div class="alert alert-info">
            <strong>Debug Info:</strong><br>
            Total Count: ${totalCount}<br>
            Current Page: ${currentPage}<br>
            FAQ List Size: ${faqList.size()}<br>
            Search Type: ${searchType}<br>
            Search Keyword: ${searchKeyword}
        </div> --%>
        
        <!-- 검색 -->
        <div class="search-box">
            <form method="get" action="${pageContext.request.contextPath}/support/faq">
                <div class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label class="form-label fw-bold">검색 분류</label>
                        <select name="searchType" class="form-select">
                            <option value="all" ${searchType == 'all' ? 'selected' : ''}>전체</option>
                            <option value="title" ${searchType == 'title' ? 'selected' : ''}>제목</option>
                            <option value="content" ${searchType == 'content' ? 'selected' : ''}>내용</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold">검색어</label>
                        <input type="text" name="searchKeyword" class="form-control" 
                               value="${searchKeyword}" placeholder="검색어를 입력하세요">
                    </div>
                    <div class="col-md-3">
                        <button type="submit" class="btn btn-brand w-100">
                            <i class="fas fa-search me-2"></i>검색
                        </button>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- FAQ 목록 -->
        <c:choose>
            <c:when test="${not empty faqList}">
                <div class="mb-4">
                    <p class="text-muted">총 <strong>${totalCount}</strong>개의 FAQ가 있습니다.</p>
                </div>
                
                <c:forEach var="faq" items="${faqList}" varStatus="status">
                    <div class="faq-item" data-faq-id="${faq.faqNum}">
                        <button class="faq-question" type="button">
                            <span>${faq.title}</span>
                            <i class="fas fa-chevron-down faq-icon"></i>
                        </button>
                        <div class="faq-answer">
                            <div style="white-space: pre-line;">${faq.content}</div>
                            <div class="mt-3 pt-3 border-top d-flex justify-content-between align-items-center">
                                <c:if test="${isAdmin}">
                                    <div>
                                        <a href="${pageContext.request.contextPath}/support/faq/edit?faqNum=${faq.faqNum}" 
                                           class="btn btn-sm btn-outline-secondary me-2">수정</a>
                                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                                onclick="deleteFAQ(${faq.faqNum})">삭제</button>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                
                <!-- 페이징 -->
                <c:if test="${totalPages > 1}">
                    <nav aria-label="FAQ 페이지 네비게이션" class="mt-5">
                        <ul class="pagination justify-content-center">
                            <c:if test="${hasPrev}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage - 1}&searchType=${searchType}&searchKeyword=${searchKeyword}">이전</a>
                                </li>
                            </c:if>
                            
                            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                                <c:if test="${pageNum >= (currentPage - 2) && pageNum <= (currentPage + 2)}">
                                    <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                                        <a class="page-link" href="?page=${pageNum}&searchType=${searchType}&searchKeyword=${searchKeyword}">${pageNum}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            
                            <c:if test="${hasNext}">
                                <li class="page-item">
                                    <a class="page-link" href="?page=${currentPage + 1}&searchType=${searchType}&searchKeyword=${searchKeyword}">다음</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                    <h5 class="text-muted">검색 결과가 없습니다</h5>
                    <p class="text-muted">다른 검색어로 시도해보세요.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <jsp:include page="../../common/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // FAQ 아코디언 기능
        document.querySelectorAll('.faq-question').forEach(button => {
            button.addEventListener('click', function() {
                const faqItem = this.closest('.faq-item');
                const answer = faqItem.querySelector('.faq-answer');
                const icon = this.querySelector('.faq-icon');
                
                // 다른 열린 FAQ 닫기
                document.querySelectorAll('.faq-item').forEach(item => {
                    if (item !== faqItem) {
                        item.querySelector('.faq-answer').classList.remove('show');
                        item.querySelector('.faq-icon').classList.remove('rotate');
                    }
                });
                
                // 현재 FAQ 토글
                answer.classList.toggle('show');
                icon.classList.toggle('rotate');
            });
        });
        
        // FAQ 삭제
        function deleteFAQ(faqNum) {
            if (confirm('정말로 이 FAQ를 삭제하시겠습니까?')) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = '${pageContext.request.contextPath}/support/faq/delete';
                
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'faqNum';
                input.value = faqNum;
                form.appendChild(input);
                
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>