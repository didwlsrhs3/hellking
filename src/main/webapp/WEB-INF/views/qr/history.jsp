<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>방문 기록 - 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        :root {
            --bg-cream: #F4ECDC;
            --brand: #FF6A00;
            --ink: #0F172A;
        }
        body { background: var(--bg-cream); }
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(15,23,42,0.1);
            height: 100%;
        }
        .visit-item {
            background: white;
            border-radius: 10px;
            padding: 15px;
            margin: 10px 0;
            box-shadow: 0 2px 8px rgba(15,23,42,0.08);
        }
        .visit-success {
            border-left: 4px solid #28a745;
        }
        .visit-failed {
            border-left: 4px solid #dc3545;
        }
        .chart-container {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin: 20px 0;
            box-shadow: 0 2px 10px rgba(15,23,42,0.1);
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container mt-4">
        <h2 class="mb-4">방문 기록</h2>
        
        <!-- 통계 카드 -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <h3 class="text-primary">${stats.totalVisits}</h3>
                    <p class="mb-0">총 방문 횟수</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <h3 class="text-success">${stats.successVisits}</h3>
                    <p class="mb-0">성공한 방문</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <h3 class="text-warning">${stats.visitedChains}</h3>
                    <p class="mb-0">방문한 가맹점</p>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <h3 class="text-info">
                        <fmt:formatNumber value="${stats.successVisits / stats.totalVisits * 100}" maxFractionDigits="1"/>%
                    </h3>
                    <p class="mb-0">성공률</p>
                </div>
            </div>
        </div>
        
        <!-- 인기 가맹점 차트 -->
        <c:if test="${not empty stats.topChains}">
            <div class="chart-container">
                <h5 class="mb-3">자주 방문한 가맹점</h5>
                <canvas id="topChainsChart" width="400" height="200"></canvas>
            </div>
        </c:if>
        
        <!-- 방문 기록 목록 -->
        <div class="bg-white rounded p-3">
            <h5 class="mb-3">방문 기록</h5>
            
            <c:choose>
                <c:when test="${not empty visits}">
                    <c:forEach var="visit" items="${visits}">
                        <div class="visit-item ${visit.result == 'SUCCESS' ? 'visit-success' : 'visit-failed'}">
                            <div class="row align-items-center">
                                <div class="col-md-8">
                                    <h6 class="mb-1">${visit.chainName}</h6>
                                    <p class="text-muted small mb-1">${visit.chainAddress}</p>
                                    <small class="text-muted">
                                        <fmt:formatDate value="${visit.visitTime}" pattern="yyyy년 MM월 dd일 HH:mm"/>
                                    </small>
                                </div>
                                <div class="col-md-4 text-end">
                                    <span class="badge ${visit.result == 'SUCCESS' ? 'bg-success' : 'bg-danger'} mb-2">
                                        ${visit.resultText}
                                    </span>
                                    <c:if test="${visit.result == 'FAILED' && not empty visit.failureReason}">
                                        <br>
                                        <small class="text-danger">${visit.failureReason}</small>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="text-center py-5">
                        <h5 class="text-muted">방문 기록이 없습니다</h5>
                        <p class="text-muted">QR 코드로 입장하여 기록을 남겨보세요!</p>
                        <a href="${pageContext.request.contextPath}/qr/enter" class="btn btn-primary">
                            QR 입장하기
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
    <script>
        // 인기 가맹점 차트 생성
        <c:if test="${not empty stats.topChains}">
            const ctx = document.getElementById('topChainsChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: [
                        <c:forEach var="chain" items="${stats.topChains}" varStatus="status">
                            '${chain.chain_name}'${not status.last ? ',' : ''}
                        </c:forEach>
                    ],
                    datasets: [{
                        label: '방문 횟수',
                        data: [
                            <c:forEach var="chain" items="${stats.topChains}" varStatus="status">
                                ${chain.visit_count}${not status.last ? ',' : ''}
                            </c:forEach>
                        ],
                        backgroundColor: '#FF6A00',
                        borderColor: '#e55a00',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 1
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        </c:if>
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
