<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<<<<<<< HEAD
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
=======
    <title>방문 기록 | 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 - 청록색 */
        .page-header {
            background: linear-gradient(135deg, #17a2b8, #138496);
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
        
        .breadcrumb-item a {
            color: rgba(255,255,255,0.8);
            text-decoration: none;
        }
        
        .breadcrumb-item a:hover {
            color: white;
        }
        
        .breadcrumb-item.active {
            color: white;
        }
        
        .breadcrumb-item + .breadcrumb-item::before {
            color: rgba(255,255,255,0.6);
        }
        
        /* 통계 카드 스타일 */
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 30px 20px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            height: 100%;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }
        
        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(15,23,42,0.15);
            border-color: #17a2b8;
        }
        
        .stat-card h3 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 10px;
        }
        
        .stat-card p {
            font-weight: 600;
            color: #6c757d;
            margin: 0;
        }
        
        .stat-card .text-primary { color: #007bff !important; }
        .stat-card .text-success { color: #28a745 !important; }
        .stat-card .text-warning { color: #ffc107 !important; }
        .stat-card .text-info { color: #17a2b8 !important; }
        
        /* 방문 기록 아이템 스타일 */
        .visit-item {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin: 15px 0;
            box-shadow: 0 5px 15px rgba(15,23,42,0.08);
            transition: all 0.3s ease;
            border-left: 5px solid transparent;
        }
        
        .visit-item:hover {
            transform: translateX(5px);
            box-shadow: 0 8px 25px rgba(15,23,42,0.12);
        }
        
        .visit-success {
            border-left-color: #28a745;
            background: linear-gradient(135deg, #ffffff, #f8fff9);
        }
        
        .visit-failed {
            border-left-color: #dc3545;
            background: linear-gradient(135deg, #ffffff, #fff8f8);
        }
        
        .visit-item h6 {
            font-weight: 700;
            color: #0F172A;
            margin-bottom: 8px;
            font-size: 1.1rem;
        }
        
        .visit-item .text-muted {
            font-size: 0.9rem;
            line-height: 1.5;
        }
        
        .visit-item .badge {
            font-size: 0.85rem;
            padding: 8px 12px;
            font-weight: 600;
        }
        
        /* 차트 컨테이너 스타일 */
        .chart-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin: 30px 0;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            border: 2px solid #f8f9fa;
        }
        
        .chart-container h5 {
            color: #0F172A;
            font-weight: 700;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        /* 빈 상태 스타일 */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: linear-gradient(135deg, #f8f9fa, #ffffff);
            border-radius: 15px;
            border: 2px dashed #dee2e6;
        }
        
        .empty-state i {
            font-size: 4rem;
            color: #6c757d;
            margin-bottom: 20px;
        }
        
        .empty-state h5 {
            color: #6c757d;
            font-weight: 700;
            margin-bottom: 15px;
        }
        
        .empty-state p {
            color: #6c757d;
            margin-bottom: 25px;
        }
        
        .empty-state .btn {
            background: linear-gradient(135deg, #17a2b8, #138496);
            border: none;
            color: white;
            font-weight: 600;
            padding: 12px 30px;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .empty-state .btn:hover {
            background: linear-gradient(135deg, #138496, #117a8b);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(23, 162, 184, 0.3);
        }
        
        /* 섹션 헤더 */
        .section-header {
            background: white;
            border-radius: 15px;
            padding: 25px 30px;
            margin-bottom: 20px;
            box-shadow: 0 5px 15px rgba(15,23,42,0.08);
            border-left: 5px solid #17a2b8;
        }
        
        .section-header h5 {
            color: #0F172A;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
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
            
            .stat-card {
                margin-bottom: 20px;
            }
            
            .stat-card h3 {
                font-size: 2rem;
            }
            
            .visit-item {
                padding: 20px;
                margin: 10px 0;
            }
            
            .chart-container {
                padding: 20px;
            }
            
            .empty-state {
                padding: 40px 15px;
            }
            
            .empty-state i {
                font-size: 3rem;
            }
        }
        
        /* 애니메이션 */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .stat-card, .visit-item, .chart-container {
            animation: fadeInUp 0.6s ease-out;
        }
        
        .stat-card:nth-child(2) { animation-delay: 0.1s; }
        .stat-card:nth-child(3) { animation-delay: 0.2s; }
        .stat-card:nth-child(4) { animation-delay: 0.3s; }
        .stat-card:nth-child(5) { animation-delay: 0.4s; }
        
        /* 차트 스타일링 */
        #topChainsChart {
            max-height: 400px;
        }
        
        /* 버튼 스타일 */
        .btn-outline-light {
            border-color: rgba(255,255,255,0.3);
            color: white;
            font-weight: 600;
        }
        
        .btn-outline-light:hover {
            background: rgba(255,255,255,0.2);
            border-color: white;
            color: white;
        }
        
        .btn-light {
            background: rgba(255,255,255,0.9);
            border: none;
            color: #17a2b8;
            font-weight: 600;
        }
        
        .btn-light:hover {
            background: white;
            color: #138496;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
>>>>>>> b65c320 (Initial commit)
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
<<<<<<< HEAD
    <div class="container mt-4">
        <h2 class="mb-4">방문 기록</h2>
        
        <!-- 통계 카드 -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stat-card">
=======
    <!-- 통일된 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/">홈</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/qr/">QR 서비스</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">방문 기록</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">방문 기록</h2>
                    <p class="lead">나의 피트니스 센터 방문 히스토리를 확인하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/qr/enter" 
                       class="btn btn-light btn-lg me-2">
                        <i class="fas fa-qrcode me-2"></i>QR 관리
                    </a>
                    <a href="${pageContext.request.contextPath}/qr/scan" 
                       class="btn btn-outline-light btn-lg">
                        <i class="fas fa-camera me-2"></i>QR 스캔
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container py-5">
        <!-- 통계 카드 -->
        <div class="row mb-5">
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card">
                    <i class="fas fa-chart-line text-primary mb-3" style="font-size: 2rem;"></i>
>>>>>>> b65c320 (Initial commit)
                    <h3 class="text-primary">${stats.totalVisits}</h3>
                    <p class="mb-0">총 방문 횟수</p>
                </div>
            </div>
<<<<<<< HEAD
            <div class="col-md-3 mb-3">
                <div class="stat-card">
=======
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card">
                    <i class="fas fa-check-circle text-success mb-3" style="font-size: 2rem;"></i>
>>>>>>> b65c320 (Initial commit)
                    <h3 class="text-success">${stats.successVisits}</h3>
                    <p class="mb-0">성공한 방문</p>
                </div>
            </div>
<<<<<<< HEAD
            <div class="col-md-3 mb-3">
                <div class="stat-card">
=======
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card">
                    <i class="fas fa-store text-warning mb-3" style="font-size: 2rem;"></i>
>>>>>>> b65c320 (Initial commit)
                    <h3 class="text-warning">${stats.visitedChains}</h3>
                    <p class="mb-0">방문한 가맹점</p>
                </div>
            </div>
<<<<<<< HEAD
            <div class="col-md-3 mb-3">
                <div class="stat-card">
                    <h3 class="text-info">
                        <fmt:formatNumber value="${stats.successVisits / stats.totalVisits * 100}" maxFractionDigits="1"/>%
=======
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card">
                    <i class="fas fa-percentage text-info mb-3" style="font-size: 2rem;"></i>
                    <h3 class="text-info">
                        <c:choose>
                            <c:when test="${stats.totalVisits > 0}">
                                <fmt:formatNumber value="${stats.successVisits / stats.totalVisits * 100}" maxFractionDigits="1"/>%
                            </c:when>
                            <c:otherwise>0%</c:otherwise>
                        </c:choose>
>>>>>>> b65c320 (Initial commit)
                    </h3>
                    <p class="mb-0">성공률</p>
                </div>
            </div>
        </div>
        
        <!-- 인기 가맹점 차트 -->
        <c:if test="${not empty stats.topChains}">
            <div class="chart-container">
<<<<<<< HEAD
                <h5 class="mb-3">자주 방문한 가맹점</h5>
                <canvas id="topChainsChart" width="400" height="200"></canvas>
=======
                <h5 class="mb-4">
                    <i class="fas fa-trophy text-warning"></i>
                    자주 방문한 가맹점
                </h5>
                <canvas id="topChainsChart"></canvas>
>>>>>>> b65c320 (Initial commit)
            </div>
        </c:if>
        
        <!-- 방문 기록 목록 -->
<<<<<<< HEAD
        <div class="bg-white rounded p-3">
            <h5 class="mb-3">방문 기록</h5>
            
=======
        <div class="section-header">
            <h5 class="mb-0">
                <i class="fas fa-history text-info"></i>
                최근 방문 기록
            </h5>
        </div>
        
        <div class="bg-white rounded-3 p-4 shadow-sm">
>>>>>>> b65c320 (Initial commit)
            <c:choose>
                <c:when test="${not empty visits}">
                    <c:forEach var="visit" items="${visits}">
                        <div class="visit-item ${visit.result == 'SUCCESS' ? 'visit-success' : 'visit-failed'}">
                            <div class="row align-items-center">
                                <div class="col-md-8">
<<<<<<< HEAD
                                    <h6 class="mb-1">${visit.chainName}</h6>
                                    <p class="text-muted small mb-1">${visit.chainAddress}</p>
                                    <small class="text-muted">
=======
                                    <div class="d-flex align-items-center mb-2">
                                        <i class="fas ${visit.result == 'SUCCESS' ? 'fa-check-circle text-success' : 'fa-times-circle text-danger'} me-2"></i>
                                        <h6 class="mb-0">${visit.chainName}</h6>
                                    </div>
                                    <p class="text-muted mb-2">
                                        <i class="fas fa-map-marker-alt me-1"></i>
                                        ${visit.chainAddress}
                                    </p>
                                    <small class="text-muted">
                                        <i class="far fa-clock me-1"></i>
>>>>>>> b65c320 (Initial commit)
                                        <fmt:formatDate value="${visit.visitTime}" pattern="yyyy년 MM월 dd일 HH:mm"/>
                                    </small>
                                </div>
                                <div class="col-md-4 text-end">
                                    <span class="badge ${visit.result == 'SUCCESS' ? 'bg-success' : 'bg-danger'} mb-2">
<<<<<<< HEAD
=======
                                        <i class="fas ${visit.result == 'SUCCESS' ? 'fa-check' : 'fa-times'} me-1"></i>
>>>>>>> b65c320 (Initial commit)
                                        ${visit.resultText}
                                    </span>
                                    <c:if test="${visit.result == 'FAILED' && not empty visit.failureReason}">
                                        <br>
<<<<<<< HEAD
                                        <small class="text-danger">${visit.failureReason}</small>
=======
                                        <small class="text-danger">
                                            <i class="fas fa-exclamation-triangle me-1"></i>
                                            ${visit.failureReason}
                                        </small>
>>>>>>> b65c320 (Initial commit)
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
<<<<<<< HEAD
                    <div class="text-center py-5">
                        <h5 class="text-muted">방문 기록이 없습니다</h5>
                        <p class="text-muted">QR 코드로 입장하여 기록을 남겨보세요!</p>
                        <a href="${pageContext.request.contextPath}/qr/enter" class="btn btn-primary">
                            QR 입장하기
=======
                    <div class="empty-state">
                        <i class="fas fa-clipboard-list"></i>
                        <h5 class="text-muted">방문 기록이 없습니다</h5>
                        <p class="text-muted">QR 코드로 입장하여 기록을 남겨보세요!</p>
                        <a href="${pageContext.request.contextPath}/qr/scan" class="btn">
                            <i class="fas fa-qrcode me-2"></i>QR 스캔하기
>>>>>>> b65c320 (Initial commit)
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    
<<<<<<< HEAD
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
=======
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 인기 가맹점 차트 생성
        <c:if test="${not empty stats.topChains}">
            console.log("=== 차트 데이터 디버깅 ===");
            console.log("Chart.js 로딩:", typeof Chart !== 'undefined');
            console.log("Canvas 존재:", document.getElementById('topChainsChart') !== null);
            
            document.addEventListener('DOMContentLoaded', function() {
                const ctx = document.getElementById('topChainsChart').getContext('2d');
                
                // 차트 데이터 준비
                const chartLabels = [
                    <c:forEach var="chain" items="${stats.topChains}" varStatus="status">
                        '${chain.CHAIN_NAME}'${not status.last ? ',' : ''}
                    </c:forEach>
                ];
                
                const chartData = [
                    <c:forEach var="chain" items="${stats.topChains}" varStatus="status">
                        ${chain.VISIT_COUNT}${not status.last ? ',' : ''}
                    </c:forEach>
                ];
                
                // 그라데이션 생성
                const gradient = ctx.createLinearGradient(0, 0, 0, 400);
                gradient.addColorStop(0, 'rgba(23, 162, 184, 0.8)');
                gradient.addColorStop(1, 'rgba(23, 162, 184, 0.3)');
                
                new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: chartLabels,
                        datasets: [{
                            label: '방문 횟수',
                            data: chartData,
                            backgroundColor: gradient,
                            borderColor: '#17a2b8',
                            borderWidth: 2,
                            borderRadius: 8,
                            borderSkipped: false,
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                display: false
                            },
                            tooltip: {
                                backgroundColor: 'rgba(0, 0, 0, 0.8)',
                                titleColor: 'white',
                                bodyColor: 'white',
                                cornerRadius: 8,
                                displayColors: false,
                                callbacks: {
                                    title: function(context) {
                                        return context[0].label;
                                    },
                                    label: function(context) {
                                        return '방문 횟수: ' + context.parsed.y + '회';
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    stepSize: 1,
                                    color: '#6c757d',
                                    font: {
                                        size: 12,
                                        weight: '600'
                                    }
                                },
                                grid: {
                                    color: 'rgba(0, 0, 0, 0.1)',
                                    lineWidth: 1
                                }
                            },
                            x: {
                                ticks: {
                                    color: '#6c757d',
                                    font: {
                                        size: 12,
                                        weight: '600'
                                    }
                                },
                                grid: {
                                    display: false
                                }
                            }
                        },
                        animation: {
                            duration: 2000,
                            easing: 'easeInOutQuart'
                        }
                    }
                });
            });
        </c:if>
        
        // 페이지 로드 애니메이션
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.stat-card, .visit-item, .chart-container');
            elements.forEach((element, index) => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(30px)';
                
                setTimeout(() => {
                    element.style.transition = 'all 0.6s ease';
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, index * 100);
            });
        });
    </script>
</body>
</html>
>>>>>>> b65c320 (Initial commit)
