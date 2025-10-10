<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>헬킹 - 로그인 처리 중</title>
    <style>
        body { 
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            text-align: center; 
            padding: 50px 20px; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        
        .container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            max-width: 400px;
            width: 100%;
        }
        
        .logo {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 20px;
            background: linear-gradient(45deg, #fff, #f0f0f0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .loading { 
            font-size: 18px;
            margin: 20px 0;
            opacity: 0.9;
        }
        
        .spinner {
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-top: 3px solid white;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
            margin: 20px auto;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .app-link {
            display: inline-block;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: 600;
            margin: 20px 0;
            border: 2px solid rgba(255, 255, 255, 0.3);
            transition: all 0.3s ease;
        }
        
        .app-link:hover {
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-2px);
        }
        
        .fallback-text {
            font-size: 14px;
            opacity: 0.7;
            margin-top: 20px;
            line-height: 1.5;
        }
        
        .success-icon {
            font-size: 48px;
            margin-bottom: 20px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.1); opacity: 0.8; }
        }
        
        .debug-info {
            background: rgba(0,0,0,0.3);
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            font-size: 12px;
            margin-top: 20px;
            text-align: left;
            font-family: monospace;
        }
        
        /* 모바일 최적화 */
        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
                margin: 20px;
            }
            
            .logo {
                font-size: 28px;
            }
            
            .loading {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <!-- JSP에서 JavaScript 변수로 데이터 전달 -->
    <script type="text/javascript">
        // 서버에서 전달받은 딥링크를 JavaScript 변수에 저장
        var serverDeepLink = '<c:out value="${deepLink}" default="" />';
        var sessionDeepLink = '<c:out value="${sessionScope.deepLink}" default="" />';
        var requestDeepLink = '<%= request.getAttribute("deepLink") != null ? request.getAttribute("deepLink").toString() : "" %>';
        var sessionScriptlet = '<%= session.getAttribute("deepLink") != null ? session.getAttribute("deepLink").toString() : "" %>';
    </script>

    <div class="container">
        <div class="logo">헬킹</div>
        <div class="success-icon">✅</div>
        <div class="spinner"></div>
        <div class="loading" id="loadingMessage">앱으로 돌아가는 중...</div>
        
        <div id="fallbackContent" style="display: none;">
            <div class="loading">앱이 자동으로 열리지 않았습니다</div>
            <a href="#" class="app-link" id="manualLink">헬킹 앱 열기</a>
            <div class="fallback-text">
                위 버튼을 클릭하거나<br>
                헬킹 앱을 직접 실행해주세요
            </div>
        </div>
        
        <!-- 개발용 디버그 정보 -->
        <div class="debug-info" id="debugInfo"></div>
    </div>
    
    <script>
        console.log('=== OAuth 콜백 페이지 로드 시작 ===');
        console.log('현재 시각:', new Date().toISOString());
        console.log('User Agent:', navigator.userAgent);
        console.log('브라우저:', navigator.userAgent.includes('SamsungBrowser') ? 'Samsung' : 'Chrome');
        
        console.log('=== 디버깅 시작 ===');
        console.log('Server 딥링크:', serverDeepLink);
        console.log('Session EL:', sessionDeepLink);
        console.log('Request 스크립틀릿:', requestDeepLink);
        console.log('Session 스크립틀릿:', sessionScriptlet);
        console.log('=== 디버깅 끝 ===');
        
        // 우선순위에 따라 딥링크 결정
        var deepLink = '';
        
        if (sessionDeepLink && sessionDeepLink !== '') {
            deepLink = sessionDeepLink;
            console.log('✅ Session EL에서 딥링크 획득:', deepLink);
        } else if (requestDeepLink && requestDeepLink !== '') {
            deepLink = requestDeepLink;
            console.log('✅ Request 스크립틀릿에서 딥링크 획득:', deepLink);
        } else if (sessionScriptlet && sessionScriptlet !== '') {
            deepLink = sessionScriptlet;
            console.log('✅ Session 스크립틀릿에서 딥링크 획득:', deepLink);
        } else if (serverDeepLink && serverDeepLink !== '') {
            deepLink = serverDeepLink;
            console.log('✅ Server EL에서 딥링크 획득:', deepLink);
        }
        
        console.log('최종 딥링크:', deepLink);
        console.log('딥링크 타입:', typeof deepLink);
        console.log('딥링크 길이:', deepLink.length);
        
        // 디버그 정보 표시
        var debugInfo = document.getElementById('debugInfo');
        debugInfo.innerHTML = 
            'DeepLink: ' + deepLink + '<br>' +
            'Browser: ' + (navigator.userAgent.includes('SamsungBrowser') ? 'Samsung' : 'Chrome') + '<br>' +
            'Time: ' + new Date().toLocaleString();
        
        // 딥링크 유효성 검증
        if (!deepLink || deepLink === '') {
            console.error('❌ 딥링크가 서버에서 전달되지 않음');
            showError('로그인 정보가 전달되지 않았습니다.');
            return;
        }
        
        // 딥링크 유효성 검증
        if (!deepLink.startsWith('hellking://')) {
            console.error('❌ 유효하지 않은 딥링크 스키마:', deepLink);
            showError('잘못된 링크 형식입니다.');
            return;
        }
        
        console.log('✅ 딥링크 유효성 검증 통과');
        
        // 앱 열기 시도 함수
        function openApp(link) {
            console.log('📱 앱 열기 시도:', link);
            
            // 방법 1: 직접 이동
            try {
                window.location.href = link;
                console.log('✅ window.location.href 실행');
            } catch (e) {
                console.error('❌ window.location.href 실패:', e);
            }
            
            // 방법 2: 짧은 지연 후 재시도 (Samsung Browser 호환)
            setTimeout(function() {
                try {
                    document.location = link;
                    console.log('✅ document.location 실행 (100ms 후)');
                } catch (e) {
                    console.error('❌ document.location 실패:', e);
                }
            }, 100);
            
            // 방법 3: iframe을 통한 시도 (Samsung Browser에서 효과적)
            setTimeout(function() {
                try {
                    var iframe = document.createElement('iframe');
                    iframe.style.display = 'none';
                    iframe.style.width = '1px';
                    iframe.style.height = '1px';
                    iframe.src = link;
                    document.body.appendChild(iframe);
                    console.log('✅ iframe 방식 실행 (200ms 후)');
                    
                    // iframe 정리
                    setTimeout(function() {
                        try {
                            document.body.removeChild(iframe);
                            console.log('✅ iframe 정리 완료');
                        } catch (e) {
                            console.log('iframe 정리 실패:', e);
                        }
                    }, 1000);
                } catch (e) {
                    console.error('❌ iframe 방식 실패:', e);
                }
            }, 200);
        }
        
        // 에러 표시 함수
        function showError(message) {
            document.querySelector('.spinner').style.display = 'none';
            document.getElementById('loadingMessage').innerHTML = message;
            document.getElementById('loadingMessage').style.color = '#ffcccb';
        }
        
        // 폴백 UI 표시 함수
        function showFallback() {
            console.log('🔄 폴백 UI 표시');
            document.querySelector('.spinner').style.display = 'none';
            document.getElementById('loadingMessage').style.display = 'none';
            document.getElementById('fallbackContent').style.display = 'block';
        }
        
        // 메인 딥링크 처리
        console.log('🚀 딥링크 처리 시작');
        
        // 수동 링크에 딥링크 설정
        document.getElementById('manualLink').href = deepLink;
        document.getElementById('manualLink').onclick = function() {
            openApp(deepLink);
            return false; // 기본 동작 방지
        };
        
        // 즉시 앱 열기 시도
        openApp(deepLink);
        
        // 페이지 가시성 변경 감지 (앱으로 전환되었는지 확인)
        var pageHidden = false;
        var visibilityChangeHandler = function() {
            if (document.hidden && !pageHidden) {
                pageHidden = true;
                console.log('👍 페이지가 숨겨짐 - 앱으로 전환된 것 같음');
                clearTimeout(fallbackTimer);
            } else if (!document.hidden && pageHidden) {
                console.log('👎 페이지가 다시 보임 - 앱 전환 실패');
                showFallback();
            }
        };
        
        // 가시성 변경 이벤트 등록
        document.addEventListener('visibilitychange', visibilityChangeHandler);
        
        // 3초 후 폴백 UI 표시 (앱이 열리지 않은 경우)
        var fallbackTimer = setTimeout(function() {
            if (!document.hidden) {
                console.log('⏰ 3초 경과 - 앱이 열리지 않았음');
                showFallback();
            }
        }, 3000);
        
        // 페이지 로드 완료
        console.log('=== 콜백 페이지 로드 완료 ===');
    </script>
</body>
</html>