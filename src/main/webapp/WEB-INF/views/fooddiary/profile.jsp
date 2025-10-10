<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>목표 설정 - 푸드다이어리</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #FF6A00;
            --secondary-color: #F4ECDC;
            --text-color: #0F172A;
            --muted-color: #5B6170;
            --border-color: #E7E0D6;
            --brand: #FF6A00;
            --hover: #FFF5EA;
            --radius: 14px;
        }
        
        body {
            background: white;
        }
        
        /* 통일된 헤더 스타일 */
        .page-header {
            background: linear-gradient(135deg, var(--primary-color), #e55a00);
            color: white;
            padding: 60px 0;
        }
        
        .page-header h1, .page-header h2 {
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
        
        .profile-card {
            background: white;
            border-radius: var(--radius);
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }
        
        .form-section {
            margin-bottom: 30px;
            padding-bottom: 25px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .form-section:last-child {
            border-bottom: none;
        }
        
        .info-box {
            background: var(--secondary-color);
            border-radius: 8px;
            padding: 20px;
            margin: 20px 0;
        }
        
        .warning-box {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 8px;
            padding: 15px;
            margin: 15px 0;
        }
        
        .bmi-result {
            text-align: center;
            padding: 20px;
            background: var(--hover);
            border-radius: 8px;
            margin: 15px 0;
        }
        
        .activity-level-card {
            border: 2px solid var(--border-color);
            border-radius: 8px;
            padding: 15px;
            margin: 10px 0;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .activity-level-card:hover {
            border-color: var(--primary-color);
            background: var(--hover);
        }
        
        .activity-level-card.selected {
            border-color: var(--primary-color);
            background: var(--hover);
        }
        
        .calorie-preview {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            border-radius: var(--radius);
            padding: 25px;
            text-align: center;
            margin: 20px 0;
        }
        
        .input-group-text {
            background: var(--secondary-color);
            border-color: var(--border-color);
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(255, 106, 0, 0.25);
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 40px 0;
            }
            .page-header h1 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <!-- 통일된 페이지 헤더 -->
    <div class="page-header">
        <div class="container">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="/">홈</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/fooddiary/">푸드다이어리</a></li>
                    <li class="breadcrumb-item active">목표 설정</li>
                </ol>
            </nav>
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="display-6 fw-bold mb-3">건강 목표 설정</h1>
                    <p class="lead mb-0">개인 정보를 바탕으로 맞춤형 칼로리 목표를 설정해보세요</p>
                </div>
                <div class="col-md-4 text-end">
                    <i class="fas fa-user-cog fa-4x opacity-75"></i>
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-4">
        <!-- 성공/오류 메시지 -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle me-2"></i>${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <div class="row">
            <!-- 메인 설정 폼 -->
            <div class="col-lg-8">
                <div class="profile-card">
                    <form method="POST" action="${pageContext.request.contextPath}/fooddiary/profile" id="profileForm">
                        
                        <!-- 기본 정보 섹션 -->
                        <div class="form-section">
                            <h5 class="fw-bold mb-4">
                                <i class="fas fa-user me-2"></i>기본 정보
                            </h5>
                            
                            <div class="info-box">
                                <i class="fas fa-info-circle text-primary me-2"></i>
                                <strong>개인정보 보호 안내</strong><br>
                                <small class="text-muted">
                                    모든 정보는 선택사항이며, 더 정확한 칼로리 계산을 위해 사용됩니다. 
                                    정보를 입력하지 않아도 서비스를 이용할 수 있습니다.
                                </small>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">성별</label>
                                    <select class="form-control" name="gender" id="gender">
                                        <option value="">선택 안함</option>
                                        <option value="M" ${profile.gender == 'M' ? 'selected' : ''}>남성</option>
                                        <option value="F" ${profile.gender == 'F' ? 'selected' : ''}>여성</option>
                                    </select>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">나이</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" name="age" id="age" 
                                               value="${profile.age}" min="10" max="120" placeholder="예: 30">
                                        <span class="input-group-text">세</span>
                                    </div>
                                    <small class="text-muted">10세 ~ 120세 범위에서 입력하세요</small>
                                </div>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">키</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" name="heightCm" id="heightCm" 
                                               value="${profile.heightCm}" min="100" max="250" step="0.1" placeholder="예: 170">
                                        <span class="input-group-text">cm</span>
                                    </div>
                                </div>
                                
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">체중</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" name="weightKg" id="weightKg" 
                                               value="${profile.weightKg}" min="20" max="300" step="0.1" placeholder="예: 70">
                                        <span class="input-group-text">kg</span>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- BMI 표시 -->
                            <div id="bmiResult" class="bmi-result" style="display: none;">
                                <h6 class="fw-bold">BMI 지수</h6>
                                <div class="h4" id="bmiValue">-</div>
                                <small id="bmiStatus" class="text-muted"></small>
                            </div>
                        </div>
                        
                        <!-- 활동량 섹션 -->
                        <div class="form-section">
                            <h5 class="fw-bold mb-4">
                                <i class="fas fa-running me-2"></i>활동량 수준
                            </h5>
                            
                            <input type="hidden" name="activityLevel" id="activityLevel" value="${profile.activityLevel}">
                            
                            <div class="activity-level-card" data-level="LOW">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-chair fa-2x text-secondary me-3"></i>
                                    <div class="flex-grow-1">
                                        <h6 class="fw-bold mb-1">낮음 (좌식 생활)</h6>
                                        <small class="text-muted">사무직, 집에서 대부분의 시간을 보냄</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="activity-level-card" data-level="MODERATE">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-walking fa-2x text-primary me-3"></i>
                                    <div class="flex-grow-1">
                                        <h6 class="fw-bold mb-1">보통 (적당한 활동)</h6>
                                        <small class="text-muted">주 3-4회 가벼운 운동, 일상적인 활동</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="activity-level-card" data-level="HIGH">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-running fa-2x text-success me-3"></i>
                                    <div class="flex-grow-1">
                                        <h6 class="fw-bold mb-1">높음 (활발한 활동)</h6>
                                        <small class="text-muted">주 5회 이상 운동, 신체 활동이 많은 직업</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- 목표 칼로리 섹션 -->
                        <div class="form-section">
                            <h5 class="fw-bold mb-4">
                                <i class="fas fa-target me-2"></i>목표 칼로리 설정
                            </h5>
                            
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">일일 목표 칼로리</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" name="targetCalories" id="targetCalories" 
                                               value="${profile.targetCalories}" min="800" max="4000" step="50" placeholder="2000">
                                        <span class="input-group-text">kcal</span>
                                    </div>
                                    <div class="mt-2">
                                        <button type="button" class="btn btn-outline-primary btn-sm" onclick="calculateRecommended()">
                                            권장 칼로리 계산
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div id="caloriePreview" class="calorie-preview" style="display: none;">
                                        <h6 class="mb-2">권장 칼로리</h6>
                                        <div class="h4 fw-bold" id="recommendedCalories">-</div>
                                        <small>개인 정보 기반 계산 결과</small>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="warning-box">
                                <i class="fas fa-exclamation-triangle text-warning me-2"></i>
                                <strong>안전 안내:</strong><br>
                                <small>
                                    건강을 위해 최소 칼로리 제한을 적용합니다. 
                                    성인 남성 1,500kcal, 성인 여성 1,200kcal 미만은 설정할 수 없습니다.
                                    특수한 상황이 있으시면 전문가와 상담하시길 권합니다.
                                </small>
                            </div>
                        </div>
                        
                        <!-- 저장 버튼 -->
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary btn-lg px-5">
                                <i class="fas fa-save me-2"></i>설정 저장
                            </button>
                            <a href="${pageContext.request.contextPath}/fooddiary/" class="btn btn-outline-secondary btn-lg px-5 ms-3">
                                <i class="fas fa-arrow-left me-2"></i>돌아가기
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- 사이드바 -->
            <div class="col-lg-4">
                <!-- 현재 설정 요약 -->
                <div class="profile-card">
                    <h5 class="fw-bold mb-3">
                        <i class="fas fa-clipboard-list me-2"></i>현재 설정
                    </h5>
                    
                    <div class="list-group list-group-flush">
                        <div class="list-group-item d-flex justify-content-between px-0">
                            <span>목표 칼로리</span>
                            <strong class="text-primary">${profile.targetCalories != null ? profile.targetCalories : 2000}kcal</strong>
                        </div>
                        <div class="list-group-item d-flex justify-content-between px-0">
                            <span>활동량</span>
                            <span class="badge bg-secondary">${profile.activityLevelDisplayName}</span>
                        </div>
                        <c:if test="${profile.weightKg != null and profile.heightCm != null}">
                            <div class="list-group-item d-flex justify-content-between px-0">
                                <span>BMI</span>
                                <strong>${profile.calculateBMI()}</strong>
                            </div>
                        </c:if>
                    </div>
                </div>
                
                <!-- 건강한 목표 설정 가이드 -->
                <div class="profile-card">
                    <h5 class="fw-bold mb-3">
                        <i class="fas fa-lightbulb me-2"></i>목표 설정 가이드
                    </h5>
                    
                    <div class="list-group list-group-flush">
                        <div class="list-group-item px-0 border-0">
                            <i class="fas fa-check-circle text-success me-2"></i>
                            <small>지속 가능한 목표를 세우세요</small>
                        </div>
                        <div class="list-group-item px-0 border-0">
                            <i class="fas fa-check-circle text-success me-2"></i>
                            <small>급격한 변화보다 점진적 개선을 추구하세요</small>
                        </div>
                        <div class="list-group-item px-0 border-0">
                            <i class="fas fa-check-circle text-success me-2"></i>
                            <small>완벽한 기록보다 꾸준한 기록이 중요합니다</small>
                        </div>
                        <div class="list-group-item px-0 border-0">
                            <i class="fas fa-check-circle text-success me-2"></i>
                            <small>몸의 신호를 잘 들으세요</small>
                        </div>
                    </div>
                </div>
                
                <!-- BMI 참고표 -->
                <div class="profile-card">
                    <h5 class="fw-bold mb-3">
                        <i class="fas fa-chart-bar me-2"></i>BMI 참고표
                    </h5>
                    
                    <div class="small">
                        <div class="d-flex justify-content-between py-2 border-bottom">
                            <span>저체중</span>
                            <span class="text-info">18.5 미만</span>
                        </div>
                        <div class="d-flex justify-content-between py-2 border-bottom">
                            <span>정상체중</span>
                            <span class="text-success">18.5 ~ 24.9</span>
                        </div>
                        <div class="d-flex justify-content-between py-2 border-bottom">
                            <span>과체중</span>
                            <span class="text-warning">25.0 ~ 29.9</span>
                        </div>
                        <div class="d-flex justify-content-between py-2">
                            <span>비만</span>
                            <span class="text-danger">30.0 이상</span>
                        </div>
                    </div>
                    
                    <div class="mt-3 p-2 bg-light rounded">
                        <small class="text-muted">
                            <i class="fas fa-info-circle me-1"></i>
                            BMI는 참고용이며, 개인차가 있을 수 있습니다.
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // 현재 활동량 선택 상태 표시
            const currentActivity = '${profile.activityLevel}' || 'MODERATE';
            document.querySelector(`.activity-level-card[data-level="${currentActivity}"]`).classList.add('selected');
            
            // BMI 계산
            calculateBMI();
            
            // 이벤트 리스너 등록
            document.getElementById('heightCm').addEventListener('input', calculateBMI);
            document.getElementById('weightKg').addEventListener('input', calculateBMI);
            document.getElementById('targetCalories').addEventListener('input', validateCalories);
        });
        
        // 활동량 선택
        document.querySelectorAll('.activity-level-card').forEach(card => {
            card.addEventListener('click', function() {
                // 기존 선택 제거
                document.querySelectorAll('.activity-level-card').forEach(c => c.classList.remove('selected'));
                
                // 새로운 선택 추가
                this.classList.add('selected');
                
                // 숨겨진 필드에 값 설정
                document.getElementById('activityLevel').value = this.dataset.level;
            });
        });
        
        // BMI 계산
        function calculateBMI() {
            const height = parseFloat(document.getElementById('heightCm').value);
            const weight = parseFloat(document.getElementById('weightKg').value);
            
            if (height && weight && height > 0 && weight > 0) {
                const heightM = height / 100;
                const bmi = weight / (heightM * heightM);
                const bmiRounded = Math.round(bmi * 10) / 10;
                
                document.getElementById('bmiValue').textContent = bmiRounded;
                document.getElementById('bmiStatus').textContent = getBMIStatus(bmi);
                document.getElementById('bmiResult').style.display = 'block';
            } else {
                document.getElementById('bmiResult').style.display = 'none';
            }
        }
        
        function getBMIStatus(bmi) {
            if (bmi < 18.5) return '저체중';
            else if (bmi < 25) return '정상체중';
            else if (bmi < 30) return '과체중';
            else return '비만';
        }
        
        // 권장 칼로리 계산
        function calculateRecommended() {
            const gender = document.getElementById('gender').value;
            const age = parseInt(document.getElementById('age').value);
            const height = parseFloat(document.getElementById('heightCm').value);
            const weight = parseFloat(document.getElementById('weightKg').value);
            const activity = document.getElementById('activityLevel').value || 'MODERATE';
            
            if (!gender || !age || !height || !weight) {
                alert('기본 정보를 모두 입력해주세요.');
                return;
            }
            
            // Harris-Benedict 공식
            let bmr;
            if (gender === 'M') {
                bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
            } else {
                bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
            }
            
            // 활동량 계수 적용
            let activityMultiplier;
            switch(activity) {
                case 'LOW': activityMultiplier = 1.2; break;
                case 'HIGH': activityMultiplier = 1.9; break;
                default: activityMultiplier = 1.55; break;
            }
            
            let recommendedCalories = Math.round(bmr * activityMultiplier);
            
            // 최소 칼로리 제한 적용
            const minCalories = gender === 'M' ? 1500 : 1200;
            recommendedCalories = Math.max(recommendedCalories, minCalories);
            
            document.getElementById('recommendedCalories').textContent = recommendedCalories;
            document.getElementById('caloriePreview').style.display = 'block';
            
            // 입력 필드에도 반영
            document.getElementById('targetCalories').value = recommendedCalories;
            validateCalories();
        }
        
        // 칼로리 유효성 검사
        function validateCalories() {
            const calories = parseInt(document.getElementById('targetCalories').value);
            const gender = document.getElementById('gender').value;
            
            if (calories) {
                const minCalories = gender === 'M' ? 1500 : (gender === 'F' ? 1200 : 1200);
                const maxCalories = 4000;
                
                const input = document.getElementById('targetCalories');
                
                if (calories < minCalories) {
                    input.classList.add('is-invalid');
                    input.title = `최소 ${minCalories}kcal 이상 입력해주세요.`;
                } else if (calories > maxCalories) {
                    input.classList.add('is-invalid');
                    input.title = `최대 ${maxCalories}kcal 이하로 입력해주세요.`;
                } else {
                    input.classList.remove('is-invalid');
                    input.title = '';
                }
            }
        }
        
        // 폼 제출 전 검증
        document.getElementById('profileForm').addEventListener('submit', function(e) {
            const calories = parseInt(document.getElementById('targetCalories').value);
            const gender = document.getElementById('gender').value;
            
            if (calories) {
                const minCalories = gender === 'M' ? 1500 : (gender === 'F' ? 1200 : 1200);
                const maxCalories = 4000;
                
                if (calories < minCalories || calories > maxCalories) {
                    e.preventDefault();
                    alert(`목표 칼로리는 ${minCalories} ~ ${maxCalories}kcal 범위에서 설정해주세요.`);
                    return;
                }
            }
            
            // 활동량이 선택되지 않은 경우 기본값 설정
            if (!document.getElementById('activityLevel').value) {
                document.getElementById('activityLevel').value = 'MODERATE';
            }
        });
    </script>
</body>
</html>