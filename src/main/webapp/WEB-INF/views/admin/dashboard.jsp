<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>관리자 대시보드 | 헬킹 피트니스</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 - 다크 그라데이션 */
        .page-header {
            background: linear-gradient(135deg, #343a40, #495057);
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
        
        /* 기본 스타일 */
        :root {
            --primary-color: #343a40;
            --brand: #FF6A00;
            --ink: #0F172A;
            --muted: #5B6170;
            --line: #E7E0D6;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 30px 25px;
            text-align: center;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            height: 100%;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(15,23,42,0.15);
            border-color: var(--brand);
        }
        
        .stat-number {
            font-size: 2.8rem;
            font-weight: 900;
            margin-bottom: 12px;
        }
        
        .stat-label {
            color: var(--muted);
            font-weight: 600;
            font-size: 1rem;
        }
        
        .chart-container {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.1);
            border: 2px solid #f8f9fa;
            transition: all 0.3s ease;
        }
        
        .chart-container:hover {
            border-color: var(--brand);
            box-shadow: 0 12px 30px rgba(15,23,42,0.15);
        }
        
        .chart-container h5 {
            color: var(--ink);
            font-weight: 700;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .admin-actions {
            background: linear-gradient(135deg, var(--brand), #ff8533);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 8px 25px rgba(255, 106, 0, 0.2);
        }
        
        .admin-actions h5 {
            color: white;
            font-weight: 700;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        .admin-btn {
            background: rgba(255,255,255,0.15);
            border: 2px solid rgba(255,255,255,0.3);
            color: white;
            font-weight: 600;
            margin: 8px 0;
            padding: 12px 20px;
            border-radius: 10px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        .admin-btn:hover {
            background: rgba(255,255,255,0.25);
            border-color: rgba(255,255,255,0.5);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
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
            color: var(--primary-color);
            font-weight: 600;
        }
        
        .btn-light:hover {
            background: white;
            color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        
        /* 차트 스타일 */
        canvas {
            border-radius: 8px;
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
            
            .stat-number {
                font-size: 2.2rem;
            }
            
            .chart-container {
                padding: 20px;
            }
            
            .admin-actions {
                padding: 25px 20px;
            }
            
            .admin-btn {
                margin: 5px 0;
                font-size: 14px;
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
        
        .stat-card, .chart-container, .admin-actions {
            animation: fadeInUp 0.6s ease-out;
        }
        
        .stat-card:nth-child(2) { animation-delay: 0.1s; }
        .stat-card:nth-child(3) { animation-delay: 0.2s; }
        .stat-card:nth-child(4) { animation-delay: 0.3s; }
        .stat-card:nth-child(5) { animation-delay: 0.4s; }
        
        /* 로딩 스피너 */
        .chart-loading {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 300px;
            color: var(--muted);
        }
        
        .spinner-border {
            width: 3rem;
            height: 3rem;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 통일된 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="${pageContext.request.contextPath}/">홈</a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">관리자 대시보드</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h2 class="fw-bold">관리자 대시보드</h2>
                    <p class="lead">헬킹 피트니스 전체 현황을 한눈에 확인하세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <a href="${pageContext.request.contextPath}/admin/users" 
                       class="btn btn-light btn-lg me-2">
                        <i class="fas fa-users me-2"></i>회원 관리
                    </a>
                    <a href="${pageContext.request.contextPath}/qr/enter" 
                       class="btn btn-outline-light btn-lg">
                        <i class="fas fa-qrcode me-2"></i>QR 관리
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="container py-5">
        <!-- 주요 통계 카드 -->
        <div class="row mb-5">
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card">
                    <i class="fas fa-users text-primary mb-3" style="font-size: 2.5rem;"></i>
                    <div class="stat-number text-primary">${stats.totalUsers}</div>
                    <div class="stat-label">총 회원수</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card">
                    <i class="fas fa-ticket-alt text-success mb-3" style="font-size: 2.5rem;"></i>
                    <div class="stat-number text-success">${stats.activePasses}</div>
                    <div class="stat-label">활성 패스권</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card">
                    <i class="fas fa-won-sign text-warning mb-3" style="font-size: 2.5rem;"></i>
                    <div class="stat-number text-warning">
                        <fmt:formatNumber value="${stats.monthlyRevenue}" pattern="#,###"/>원
                    </div>
                    <div class="stat-label">이번달 매출</div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 mb-4">
                <div class="stat-card">
                    <i class="fas fa-chart-line text-info mb-3" style="font-size: 2.5rem;"></i>
                    <div class="stat-number text-info">${stats.totalVisits}</div>
                    <div class="stat-label">총 방문 횟수</div>
                </div>
            </div>
        </div>

        <!-- 관리 기능 바로가기 -->
        <div class="admin-actions">
            <h5>
                <i class="fas fa-tools"></i>
                관리 기능 바로가기
            </h5>
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-3">
                    <a href="${pageContext.request.contextPath}/qr/enter" class="btn admin-btn w-100">
                        <i class="fas fa-qrcode"></i>
                        QR 코드 관리
                    </a>
                </div>
                <div class="col-lg-4 col-md-6 mb-3">
                    <a href="${pageContext.request.contextPath}/pass/admin/refund/list" class="btn admin-btn w-100">
                        <i class="fas fa-undo"></i>
                        환불 관리
                    </a>
                </div>
                <div class="col-lg-4 col-md-6 mb-3">
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn admin-btn w-100">
                        <i class="fas fa-users"></i>
                        회원 관리
                    </a>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- 패스권 판매 현황 차트 -->
            <div class="col-lg-8 mb-4">
                <div class="chart-container">
                    <h5>
                        <i class="fas fa-chart-bar" style="color: var(--brand);"></i>
                        패스권 판매 현황
                    </h5>
                    <div style="height: 350px; position: relative;">
                        <canvas id="passChart"></canvas>
                    </div>
                </div>
            </div>
            
            <!-- 환불 상태 차트 -->
            <div class="col-lg-4 mb-4">
                <div class="chart-container">
                    <h5>
                        <i class="fas fa-chart-doughnut" style="color: var(--brand);"></i>
                        환불 현황
                    </h5>
                    <div style="height: 350px; position: relative;">
                        <canvas id="refundChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- 가맹점별 방문 통계 -->
            <div class="col-12 mb-4">
                <div class="chart-container">
                    <h5>
                        <i class="fas fa-store" style="color: var(--brand);"></i>
                        가맹점별 방문 통계
                    </h5>
                    <div style="height: 400px; position: relative;">
                        <canvas id="chainVisitChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // 차트 색상 팔레트
        const colors = {
            primary: '#007bff',
            success: '#28a745',
            warning: '#ffc107',
            danger: '#dc3545',
            info: '#17a2b8',
            brand: '#FF6A00'
        };
        
        // 패스권 판매 현황 차트
        document.addEventListener('DOMContentLoaded', function() {
            const passCtx = document.getElementById('passChart').getContext('2d');
            
            // 그라데이션 생성
            const passGradient = passCtx.createLinearGradient(0, 0, 0, 400);
            passGradient.addColorStop(0, 'rgba(255, 106, 0, 0.8)');
            passGradient.addColorStop(1, 'rgba(255, 106, 0, 0.3)');
            
            new Chart(passCtx, {
                type: 'bar',
                data: {
                    labels: [
                        <c:choose>
                            <c:when test="${not empty passStats}">
                                <c:forEach var="pass" items="${passStats}" varStatus="status">
                                    '${pass.passName}'${not status.last ? ',' : ''}
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                '데이터 없음'
                            </c:otherwise>
                        </c:choose>
                    ],
                    datasets: [{
                        label: '판매량',
                        data: [
                            <c:choose>
                                <c:when test="${not empty passStats}">
                                    <c:forEach var="pass" items="${passStats}" varStatus="status">
                                        ${pass.soldCount}${not status.last ? ',' : ''}
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    0
                                </c:otherwise>
                            </c:choose>
                        ],
                        backgroundColor: passGradient,
                        borderColor: colors.brand,
                        borderWidth: 2,
                        borderRadius: 8,
                        borderSkipped: false,
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                            titleColor: 'white',
                            bodyColor: 'white',
                            cornerRadius: 8
                        }
                    },
                    scales: {
                        y: { 
                            beginAtZero: true,
                            ticks: { 
                                stepSize: 1, 
                                maxTicksLimit: 8,
                                color: '#6c757d'
                            },
                            grid: {
                                color: 'rgba(0, 0, 0, 0.1)'
                            }
                        },
                        x: {
                            ticks: {
                                color: '#6c757d'
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

            // 환불 현황 도넛 차트
            const refundCtx = document.getElementById('refundChart').getContext('2d');
            new Chart(refundCtx, {
                type: 'doughnut',
                data: {
                    labels: ['대기중', '승인됨', '완료', '거절'],
                    datasets: [{
                        data: [
                            <c:choose><c:when test="${refundStats != null && refundStats.requested != null}">${refundStats.requested}</c:when><c:otherwise>0</c:otherwise></c:choose>,
                            <c:choose><c:when test="${refundStats != null && refundStats.approved != null}">${refundStats.approved}</c:when><c:otherwise>0</c:otherwise></c:choose>,
                            <c:choose><c:when test="${refundStats != null && refundStats.completed != null}">${refundStats.completed}</c:when><c:otherwise>0</c:otherwise></c:choose>,
                            <c:choose><c:when test="${refundStats != null && refundStats.rejected != null}">${refundStats.rejected}</c:when><c:otherwise>0</c:otherwise></c:choose>
                        ],
                        backgroundColor: [colors.warning, colors.info, colors.success, colors.danger],
                        borderWidth: 3,
                        borderColor: '#fff',
                        hoverBorderWidth: 5
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: '60%',
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: { 
                                boxWidth: 15, 
                                padding: 20,
                                font: {
                                    size: 12,
                                    weight: '600'
                                }
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                            titleColor: 'white',
                            bodyColor: 'white',
                            cornerRadius: 8
                        }
                    },
                    animation: {
                        animateRotate: true,
                        duration: 2000
                    }
                }
            });

            // 가맹점별 방문 통계 차트
            const chainCtx = document.getElementById('chainVisitChart').getContext('2d');
            new Chart(chainCtx, {
                type: 'bar',
                data: {
                    labels: [
                        <c:choose>
                            <c:when test="${not empty chainVisitStats}">
                                <c:forEach var="chain" items="${chainVisitStats}" varStatus="status">
                                    '${chain.chainName}'${not status.last ? ',' : ''}
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                '데이터 없음'
                            </c:otherwise>
                        </c:choose>
                    ],
                    datasets: [
                        {
                            label: '성공',
                            data: [
                                <c:choose>
                                    <c:when test="${not empty chainVisitStats}">
                                        <c:forEach var="chain" items="${chainVisitStats}" varStatus="status">
                                            ${chain.successCount}${not status.last ? ',' : ''}
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        0
                                    </c:otherwise>
                                </c:choose>
                            ],
                            backgroundColor: colors.success,
                            borderRadius: 4,
                            borderSkipped: false
                        },
                        {
                            label: '실패',
                            data: [
                                <c:choose>
                                    <c:when test="${not empty chainVisitStats}">
                                        <c:forEach var="chain" items="${chainVisitStats}" varStatus="status">
                                            ${chain.failCount}${not status.last ? ',' : ''}
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        0
                                    </c:otherwise>
                                </c:choose>
                            ],
                            backgroundColor: colors.danger,
                            borderRadius: 4,
                            borderSkipped: false
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        x: { 
                            stacked: true,
                            ticks: {
                                color: '#6c757d'
                            },
                            grid: {
                                display: false
                            }
                        },
                        y: { 
                            stacked: true, 
                            beginAtZero: true,
                            ticks: { 
                                stepSize: 1, 
                                maxTicksLimit: 8,
                                color: '#6c757d'
                            },
                            grid: {
                                color: 'rgba(0, 0, 0, 0.1)'
                            }
                        }
                    },
                    plugins: {
                        legend: { 
                            position: 'top',
                            labels: {
                                boxWidth: 15,
                                padding: 20,
                                font: {
                                    size: 12,
                                    weight: '600'
                                }
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                            titleColor: 'white',
                            bodyColor: 'white',
                            cornerRadius: 8
                        }
                    },
                    animation: {
                        duration: 2000,
                        easing: 'easeInOutQuart'
                    }
                }
            });
        });

        console.log('관리자 대시보드 로드 완료');
    </script>
</body>
</html>