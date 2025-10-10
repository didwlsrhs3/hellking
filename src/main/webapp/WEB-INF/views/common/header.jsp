<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<<<<<<< HEAD
<%-- HELLKING 헤더 - Orangetheory 스타일 레퍼런스 반영 버전 --%>
=======
<%-- HELLKING 클린 헤더 - 푸드다이어리 통합 버전 --%>

<%
  // 관리자 권한 체크
  String userRole = (String) session.getAttribute("userRole");
  boolean isAdmin = "ADMIN".equalsIgnoreCase(userRole);
  request.setAttribute("isAdmin", isAdmin);
%>
>>>>>>> b65c320 (Initial commit)

<style>
  :root{
    --bg-cream:#F4ECDC;      /* 상단 베이지톤 */
    --ink:#0F172A;           /* 본문 진한 잉크색 */
    --muted:#5B6170;         /* 보조 텍스트 */
    --line:#E7E0D6;          /* 얇은 라인 */
    --brand:#FF6A00;         /* 오렌지 포인트 */
    --hover:#FFF5EA;         /* 호버 배경 */
    --radius:14px;
  }
  .hk-header{position:sticky;top:0;z-index:1000;background:var(--bg-cream);border-bottom:1px solid var(--line);}
<<<<<<< HEAD
  .hk-wrap{max-width:1240px;margin:0 auto;padding:14px 20px;display:grid;grid-template-columns:auto 1fr auto;align-items:center;gap:16px;}
  /* 브랜드 로고 */
  .hk-brand{
    font-weight:900;letter-spacing:.4px;color:var(--brand);font-size:22px;
    display:inline-flex;align-items:center;gap:8px;
  }
  .hk-dot{width:8px;height:8px;border-radius:50%;background:var(--brand);box-shadow:0 0 10px rgba(255,106,0,.5);}
  /* 가운데 GNB (참조 디자인처럼 중앙 정렬) */
  .hk-gnb{display:flex;justify-content:center;}
  .hk-menu{display:flex;gap:6px;}
  .hk-menu>li{position:relative;}
  .hk-menu>li>a{
    display:inline-flex;align-items:center;gap:8px;padding:12px 16px;border-radius:12px;
    font-weight:700;font-size:15px;color:var(--ink);
  }
  /* 하단 호버바 */
  .hk-menu>li>a::after{
    content:"";position:absolute;left:16px;right:16px;bottom:6px;height:3px;border-radius:3px;background:var(--brand);
    opacity:0;transform:scaleX(.4);transform-origin:left;transition:opacity .18s,transform .18s;
  }
  .hk-menu>li:hover>a,
  .hk-menu>li:focus-within>a{background:var(--hover);}
  .hk-menu>li:hover>a::after,
  .hk-menu>li:focus-within>a::after{opacity:1;transform:scaleX(1);}

  /* 드롭다운 */
  .hk-sub{
    position:absolute;top:calc(100% + 10px);left:8px;min-width:240px;
    background:#fff;border:1px solid var(--line);border-radius:var(--radius);
    box-shadow:0 14px 28px rgba(15,23,42,.08);
    padding:8px;opacity:0;visibility:hidden;transform:translateY(6px);
    transition:opacity .18s,transform .18s,visibility .18s;
=======
  .hk-wrap{max-width:1240px;margin:0 auto;padding:16px 20px;display:grid;grid-template-columns:auto 1fr auto;align-items:center;gap:24px;}
  
  /* 브랜드 로고 - 왼쪽 끝에 완전히 정렬 */
  .hk-brand{
    font-weight:900;letter-spacing:.2px;color:var(--brand);font-size:24px;
    display:inline-flex;align-items:center;text-decoration:none;
    margin-left:-20px; /* 컨테이너 패딩만큼 왼쪽으로 당기기 */
  }
  
  /* 가운데 GNB */
  .hk-gnb{display:flex;justify-content:center;}
  .hk-menu{display:flex;gap:8px;list-style:none;margin:0;padding:0;}
  .hk-menu>li{position:relative;}
  .hk-menu>li>a{
    display:inline-flex;align-items:center;gap:8px;padding:12px 20px;border-radius:12px;
    font-weight:600;font-size:15px;color:var(--ink);text-decoration:none;transition:all .2s ease;
  }
  
  /* 호버 효과 */
  .hk-menu>li:hover>a,
  .hk-menu>li:focus-within>a{
    background:var(--hover);transform:translateY(-1px);box-shadow:0 4px 12px rgba(255,106,0,0.1);
  }

  /* 드롭다운 */
  .hk-sub{
    position:absolute;top:calc(100% + 12px);left:8px;min-width:240px;
    background:#fff;border:1px solid var(--line);border-radius:var(--radius);
    box-shadow:0 16px 32px rgba(15,23,42,.12);
    padding:8px;opacity:0;visibility:hidden;transform:translateY(8px);
    transition:all .2s ease;list-style:none;margin:0;
>>>>>>> b65c320 (Initial commit)
  }
  .hk-menu>li:hover>.hk-sub,
  .hk-menu>li:focus-within>.hk-sub{opacity:1;visibility:visible;transform:translateY(0);}
  .hk-sub li a{
<<<<<<< HEAD
    display:block;padding:11px 12px;border-radius:10px;font-size:14px;color:var(--ink);
  }
  .hk-sub li a:hover{background:#F8FAFC;}

  /* 오른쪽 유틸: 로그인 아이콘 + CTA */
  .hk-utils{display:flex;align-items:center;gap:12px;justify-content:flex-end;}
  .login-wrap{position:relative;}
  .login-btn{
    width:38px;height:38px;border-radius:50%;border:1px solid var(--line);background:#fff;cursor:pointer;
    display:inline-flex;align-items:center;justify-content:center;transition:background .2s,transform .06s;
  }
  .login-btn:hover{background:#FFF;}
=======
    display:block;padding:12px 16px;border-radius:10px;font-size:14px;color:var(--ink);
    text-decoration:none;transition:background .15s ease;
  }
  .hk-sub li a:hover{background:#F8FAFC;}

  /* 오른쪽 유틸: 로그인 아이콘 + 푸드다이어리 CTA - 오른쪽 끝 정렬 */
  .hk-utils{
    display:flex;align-items:center;gap:16px;justify-content:flex-end;
    margin-right:-20px; /* 컨테이너 패딩만큼 오른쪽으로 당기기 */
  }
  .login-wrap{position:relative;}
  .login-btn{
    width:40px;height:40px;border-radius:50%;border:1px solid var(--line);background:#fff;cursor:pointer;
    display:inline-flex;align-items:center;justify-content:center;transition:all .2s ease;
  }
  .login-btn:hover{background:var(--hover);transform:scale(1.05);}
>>>>>>> b65c320 (Initial commit)
  .login-btn:active{transform:scale(.98);}
  .login-icon{width:18px;height:18px;position:relative;display:inline-block;}
  .login-icon:before,.login-icon:after{content:"";position:absolute;left:50%;transform:translateX(-50%);border:2px solid var(--ink);border-radius:50%;}
  .login-icon:before{top:1px;width:9px;height:9px;}
  .login-icon:after{bottom:1px;width:14px;height:8px;border-top:none;}
  .login-pop{
    position:absolute;right:0;top:calc(100% + 10px);min-width:220px;background:#fff;border:1px solid var(--line);
<<<<<<< HEAD
    border-radius:var(--radius);box-shadow:0 14px 28px rgba(15,23,42,.08);padding:8px;
    opacity:0;visibility:hidden;transform:translateY(6px);transition:opacity .18s,transform .18s,visibility .18s;
=======
    border-radius:var(--radius);box-shadow:0 16px 32px rgba(15,23,42,.12);padding:8px;
    opacity:0;visibility:hidden;transform:translateY(6px);transition:all .2s ease;
>>>>>>> b65c320 (Initial commit)
  }
  .login-wrap.open .login-pop{opacity:1;visibility:visible;transform:translateY(0);}
  .login-pop a{display:block;padding:10px 12px;border-radius:10px;font-size:14px;color:var(--ink);}
  .login-pop a:hover{background:#F8FAFC;}

<<<<<<< HEAD
  /* CTA "디자인바디" → 레퍼런스의 Free Class 스타일 */
  .cta{
    display:inline-flex;align-items:center;gap:8px;padding:11px 18px;border-radius:999px;
    font-weight:900;font-size:14px;color:#1A1A1A;background:var(--brand);border:1px solid #DD5C00;
    box-shadow:0 6px 14px rgba(255,106,0,.25);cursor:pointer;transition:transform .08s,box-shadow .18s,filter .18s;
  }
  .cta:hover{transform:translateY(-1px);box-shadow:0 10px 18px rgba(255,106,0,.3);filter:saturate(1.05);}
  .cta:active{transform:translateY(0);}
  .cta .dot{width:8px;height:8px;border-radius:50%;background:#fff;box-shadow:0 0 8px rgba(255,255,255,.9);}
=======
  /* 푸드다이어리 CTA를 일반 메뉴처럼 변경 */
  .cta-wrap {
    position: relative;
    display: inline-block;
  }
  
  .cta{
    display:inline-flex;align-items:center;gap:10px;padding:12px 24px;border-radius:999px;
    font-weight:700;font-size:14px;color:#1A1A1A;background:var(--brand);border:1px solid #DD5C00;
    box-shadow:0 6px 16px rgba(255,106,0,.25);cursor:pointer;transition:all .2s ease;text-decoration:none;
    position:relative;
  }
  .cta:hover{
    transform:translateY(-2px);box-shadow:0 12px 24px rgba(255,106,0,.35);filter:saturate(1.1);
    color:#1A1A1A;
  }
  
  .cta-icon{
    font-size:16px;
    transition:transform .2s ease;
  }
  
  .cta-wrap:hover .cta-icon{
    transform:scale(1.1);
  }

  /* 푸드다이어리 드롭다운 - 다른 메뉴와 동일한 스타일 */
  .cta-pop{
    position:absolute;
    top:calc(100% + 12px);
    left:8px;
    min-width:260px;
    background:#fff;
    border:1px solid var(--line);
    border-radius:var(--radius);
    box-shadow:0 16px 32px rgba(15,23,42,.12);
    padding:8px;
    opacity:0;
    visibility:hidden;
    transform:translateY(8px);
    transition:all .2s ease;
    list-style:none;
    margin:0;
  }
  
  .cta-wrap:hover .cta-pop,
  .cta-wrap:focus-within .cta-pop{
    opacity:1;
    visibility:visible;
    transform:translateY(0);
  }
  
  .cta-pop a{
    display:flex;
    align-items:center;
    gap:10px;
    padding:12px 16px;
    border-radius:10px;
    font-size:14px;
    color:var(--ink);
    text-decoration:none;
    transition:background .15s ease;
    margin-bottom:2px;
  }
  
  .cta-pop a:hover{
    background:#F8FAFC;
  }
  
  .cta-pop a i{
    font-size:16px;
    color:var(--brand);
    width:20px;
    text-align:center;
    opacity:0.8;
  }
  
  .cta-pop a:hover i{
    opacity:1;
  }
  
  .cta-pop a strong{
    color:var(--brand);
  }
  
  /* 드롭다운 구분선 */
  .cta-pop hr{
    margin:8px 0;
    border:none;
    height:1px;
    background:var(--line);
  }
>>>>>>> b65c320 (Initial commit)

  /* QR 메뉴 특별 스타일링 */
  .qr-menu > a {
    background: linear-gradient(135deg, #4CAF50, #45a049) !important;
    color: white !important;
  }
  .qr-menu > a:hover {
    background: linear-gradient(135deg, #45a049, #4CAF50) !important;
  }

  /* 반응형 */
  @media (max-width:1024px){
<<<<<<< HEAD
    .hk-wrap{grid-template-columns:auto 1fr auto;padding:12px 16px;}
    .hk-menu>li>a{padding:10px 12px;}
  }
  @media (max-width:860px){
    .hk-menu>li>a{font-size:14px;padding:9px 10px;}
    .hk-sub{min-width:200px;}
=======
    .hk-wrap{grid-template-columns:auto 1fr auto;padding:14px 16px;gap:16px;}
    .hk-menu>li>a{padding:10px 16px;}
  }
  @media (max-width:860px){
    .hk-menu>li>a{font-size:14px;padding:9px 12px;}
    .hk-sub{min-width:200px;}
    .hk-utils{gap:12px;}
>>>>>>> b65c320 (Initial commit)
  }
</style>

<header class="hk-header">
  <div class="hk-wrap">
<<<<<<< HEAD
    <!-- 좌측 로고 -->
    <a class="hk-brand" href="${pageContext.request.contextPath}/">
      <span class="hk-dot" aria-hidden="true"></span> HELLKING
    </a>

    <!-- 가운데 내비 (대메뉴 6개 - QR 추가) -->
    <nav class="hk-gnb" aria-label="Global">
      <ul class="hk-menu">
        <!-- 1. QR 입장 (테스트용 - 눈에 띄게) -->
        <li class="qr-menu">
          <a href="${pageContext.request.contextPath}/qr/enter" aria-haspopup="true" aria-expanded="false">
            ⚡ QR입장
          </a>
          <ul class="hk-sub" aria-label="QR 관련 메뉴">
            <li><a href="${pageContext.request.contextPath}/qr/enter">QR 코드 입장</a></li>
            <li><a href="${pageContext.request.contextPath}/qr/history">방문 기록</a></li>
          </ul>
        </li>
        
        <!-- 2. 안내말씀 -->
        <li>
          <a href="#" aria-haspopup="true" aria-expanded="false">안내말씀</a>
          <ul class="hk-sub" aria-label="안내말씀 소메뉴">
            <li><a href="${pageContext.request.contextPath}/about/company">자사소개</a></li>
            <li><a href="${pageContext.request.contextPath}/chain/list">가맹점 소개</a></li>
            <li><a href="${pageContext.request.contextPath}/chain/nearby">내인근 가맹점 찾기</a></li>
          </ul>
        </li>
        
        <!-- 3. 패스권 -->
=======
    <!-- 왼쪽 로고 -->
    <a class="hk-brand" href="${pageContext.request.contextPath}/">
      HELLKING
    </a>

    <!-- 가운데 내비 (대메뉴 6개) -->
    <nav class="hk-gnb" aria-label="Global">
      <ul class="hk-menu">

        <!-- 1. 가맹점 안내 -->
        <li>
          <a href="${pageContext.request.contextPath}/chain/list" aria-haspopup="true" aria-expanded="false">가맹점 안내</a>
          <ul class="hk-sub" aria-label="가맹점 안내 소메뉴">
            <li><a href="${pageContext.request.contextPath}/chain/list">가맹점 소개</a></li>
            <li><a href="${pageContext.request.contextPath}/chain/nearby">내인근 가맹점 찾기</a></li>
<%--             <!-- 체인점 프로그램 메뉴 추가 -->
            <hr style="margin: 6px 0; border-color: var(--line);">
            <li><a href="${pageContext.request.contextPath}/designbody/chain/">체인점 프로그램</a></li>
            <li><a href="${pageContext.request.contextPath}/designbody/chain/programs">전체 프로그램</a></li>
            <li><a href="${pageContext.request.contextPath}/designbody/chain/nearby">근처 프로그램</a></li>
            <c:if test="${not empty sessionScope.userNum}">
              <li><a href="${pageContext.request.contextPath}/designbody/chain/my">내 참여 프로그램</a></li>
            </c:if> --%>
          </ul>
        </li>
        
        <!-- 2. 패스권 -->
>>>>>>> b65c320 (Initial commit)
        <li>
          <a href="${pageContext.request.contextPath}/pass/list" aria-haspopup="true" aria-expanded="false">패스권</a>
          <ul class="hk-sub" aria-label="패스권 소메뉴">
            <li><a href="${pageContext.request.contextPath}/pass/list">패스권 안내</a></li>
            <li><a href="${pageContext.request.contextPath}/pass/mypass">내 패스권 관리</a></li>
          </ul>
        </li>
        
<<<<<<< HEAD
        <!-- 4. 게시판 -->
        <li>
          <a href="${pageContext.request.contextPath}/board/boardlist" aria-haspopup="true" aria-expanded="false">게시판</a>
=======
        <!-- 3. 게시판 -->
        <li>
          <a href="${pageContext.request.contextPath}/board/freeboard" aria-haspopup="true" aria-expanded="false">게시판</a>
>>>>>>> b65c320 (Initial commit)
          <ul class="hk-sub" aria-label="게시판 소메뉴">      
            <li><a href="${pageContext.request.contextPath}/board/freeboard">자유게시판</a></li>
            <li><a href="${pageContext.request.contextPath}/board/secretboard">익명게시판</a></li>
            <li><a href="${pageContext.request.contextPath}/board/localboard">지역게시판</a></li>
          </ul>
        </li>
        
<<<<<<< HEAD
=======
<%--         <!-- 4. 디자인바디 -->
        <li>
          <a href="${pageContext.request.contextPath}/designbody/" aria-haspopup="true" aria-expanded="false">디자인바디</a>
          <ul class="hk-sub" aria-label="디자인바디 소메뉴">
            <li><a href="${pageContext.request.contextPath}/designbody/">디자인바디 홈</a></li>
            <li><a href="${pageContext.request.contextPath}/designbody/programs">프로그램 안내</a></li>
            <li><a href="${pageContext.request.contextPath}/designbody/trainers">트레이너 소개</a></li>
            <c:if test="${not empty sessionScope.userNum}">
              <hr style="margin: 6px 0; border-color: var(--line);">
              <li><a href="${pageContext.request.contextPath}/designbody/my">내 프로그램</a></li>
              <li><a href="${pageContext.request.contextPath}/designbody/schedule">수업 예약</a></li>
            </c:if>
          </ul>
        </li> --%>
        
>>>>>>> b65c320 (Initial commit)
        <!-- 5. 고객리뷰 -->
        <li><a href="${pageContext.request.contextPath}/reviews/list">고객리뷰</a></li>
        
        <!-- 6. 고객센터 -->
        <li>
<<<<<<< HEAD
          <a href="#" aria-haspopup="true" aria-expanded="false">고객센터</a>
          <ul class="hk-sub" aria-label="고객센터 소메뉴">
            <li><a href="${pageContext.request.contextPath}/support/faq">FAQ</a></li>
            <li><a href="${pageContext.request.contextPath}/support/search">문의사항 검색</a></li>
            <li><a href="${pageContext.request.contextPath}/support/kakao">카톡상담</a></li>
=======
          <a href="${pageContext.request.contextPath}/support/" aria-haspopup="true" aria-expanded="false">고객센터</a>
          <ul class="hk-sub" aria-label="고객센터 소메뉴">
            <li><a href="${pageContext.request.contextPath}/support/faq">FAQ</a></li>
            <li><a href="${pageContext.request.contextPath}/support/search">문의사항 검색</a></li>
            <li><a href="${pageContext.request.contextPath}/support/consultation">상담예약</a></li>
>>>>>>> b65c320 (Initial commit)
          </ul>
        </li>
      </ul>
    </nav>

<<<<<<< HEAD
    <!-- 오른쪽: 로그인 아이콘 + CTA -->
    <div class="hk-utils">
=======
    <!-- 오른쪽: 로그인 아이콘 + 푸드다이어리 CTA -->
    <div class="hk-utils">
      <!-- 로그인 버튼 -->
>>>>>>> b65c320 (Initial commit)
      <div class="login-wrap" id="hkLogin">
        <button type="button" class="login-btn" aria-haspopup="true" aria-controls="login-pop" aria-expanded="false" title="로그인 메뉴">
          <i class="login-icon" aria-hidden="true"></i>
        </button>
        <div class="login-pop" id="login-pop" role="menu" aria-label="로그인 관련 메뉴">
          <!-- 로그인 상태에 따라 동적으로 표시 -->
          <c:choose>
            <c:when test="${not empty sessionScope.userNum}">
              <!-- 로그인된 경우 -->
              <a href="${pageContext.request.contextPath}/user/mypage" role="menuitem">마이페이지</a>
              <a href="${pageContext.request.contextPath}/user/edit" role="menuitem">회원 정보 수정</a>
              <a href="${pageContext.request.contextPath}/pass/mypass" role="menuitem">내 패스권</a>
              <a href="${pageContext.request.contextPath}/designbody/my" role="menuitem">내 프로그램</a>
              <a href="${pageContext.request.contextPath}/reviews/my" role="menuitem">내 리뷰</a>
<<<<<<< HEAD
=======
              
              <hr style="margin: 8px 0; border-color: #ddd;">
              <!-- QR 관련 메뉴 -->
              <a href="${pageContext.request.contextPath}/qr/history" role="menuitem" style="color: #4CAF50;">
                방문 기록
              </a>
              
              <!-- 관리자 메뉴 (userRole이 ADMIN인 경우만 표시) -->
              <c:if test="${isAdmin}">
                <hr style="margin: 8px 0; border-color: var(--brand);">
                <a href="${pageContext.request.contextPath}/qr/enter" role="menuitem" style="color: var(--brand); font-weight: bold;">
                  QR 관리
                </a>
                <a href="${pageContext.request.contextPath}/pass/admin/refund/list" role="menuitem" style="color: var(--brand); font-weight: bold;">
                  환불 관리
                </a>
                <a href="${pageContext.request.contextPath}/admin/dashboard" role="menuitem" style="color: var(--brand); font-weight: bold;">
                  관리자 대시보드
                </a>
              </c:if>
              
>>>>>>> b65c320 (Initial commit)
              <hr style="margin: 8px 0;">
              <a href="${pageContext.request.contextPath}/user/logout" role="menuitem">로그아웃</a>
            </c:when>
            <c:otherwise>
              <!-- 비로그인된 경우 -->
              <a href="${pageContext.request.contextPath}/user/login" role="menuitem">로그인</a>
              <a href="${pageContext.request.contextPath}/user/join" role="menuitem">회원가입</a>
              <a href="${pageContext.request.contextPath}/user/findId" role="menuitem">아이디 찾기</a>
              <a href="${pageContext.request.contextPath}/user/findPassword" role="menuitem">비밀번호 찾기</a>
            </c:otherwise>
          </c:choose>
        </div>
      </div>

<<<<<<< HEAD
      <a class="cta" href="${pageContext.request.contextPath}/designbody/" title="디자인바디">
        <span class="dot" aria-hidden="true"></span> 디자인바디
      </a>
=======
      <!-- 푸드다이어리 CTA (드롭다운 포함) -->
      <div class="cta-wrap" id="hkFooddiary">
        <a class="cta" href="${pageContext.request.contextPath}/fooddiary/" title="푸드다이어리" 
           onclick="event.preventDefault(); document.getElementById('hkFooddiary').classList.toggle('open');">
          <i class="fas fa-apple-alt cta-icon"></i>
          푸드다이어리
        </a>
        <div class="cta-pop" id="cta-pop" role="menu" aria-label="푸드다이어리 메뉴">
          <c:choose>
            <c:when test="${not empty sessionScope.userNum}">
              <!-- 로그인된 경우 -->
              <a href="${pageContext.request.contextPath}/fooddiary/" role="menuitem">
                <i class="fas fa-utensils"></i>
                <strong>오늘의 식단</strong>
              </a>
              <a href="${pageContext.request.contextPath}/fooddiary/search" role="menuitem">
                <i class="fas fa-search"></i>
                음식 검색하기
              </a>
              <a href="${pageContext.request.contextPath}/fooddiary/stats" role="menuitem">
                <i class="fas fa-chart-line"></i>
                나의 식습관 분석
              </a>
              <hr>
              <a href="${pageContext.request.contextPath}/fooddiary/calendar" role="menuitem">
                <i class="fas fa-calendar-alt"></i>
                월간 기록 보기
              </a>
              <a href="${pageContext.request.contextPath}/fooddiary/favorites" role="menuitem">
                <i class="fas fa-heart"></i>
                즐겨찾기 관리
              </a>
              <a href="${pageContext.request.contextPath}/fooddiary/profile" role="menuitem">
                <i class="fas fa-bullseye"></i>
                건강 목표 설정
              </a>
            </c:when>
            <c:otherwise>
              <!-- 비로그인된 경우 -->
              <a href="${pageContext.request.contextPath}/fooddiary/" role="menuitem">
                <i class="fas fa-play-circle"></i>
                <strong>푸드다이어리 시작</strong>
              </a>
              <a href="${pageContext.request.contextPath}/fooddiary/search" role="menuitem">
                <i class="fas fa-search"></i>
                음식 영양정보 검색
              </a>
              <hr>
              <a href="${pageContext.request.contextPath}/user/login" role="menuitem" style="color: var(--brand);">
                <i class="fas fa-sign-in-alt"></i>
                로그인하고 기록하기
              </a>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
>>>>>>> b65c320 (Initial commit)
    </div>
  </div>
</header>

<script>
  // 드롭다운: 포커스 접근성(키보드) 유지
  document.querySelectorAll('.hk-menu > li').forEach(li=>{
    const link = li.querySelector(':scope > a');
    const sub  = li.querySelector(':scope > .hk-sub');
    if(!sub) return;
    link.addEventListener('focus',()=> li.classList.add('focus'));
    sub.addEventListener('focusout',(e)=>{ if(!li.contains(e.relatedTarget)) li.classList.remove('focus'); });
  });

  // 로그인 팝업: 클릭 토글 + 바깥 클릭/ESC 닫기
  (function(){
    const wrap = document.getElementById('hkLogin'); if(!wrap) return;
    const btn  = wrap.querySelector('.login-btn'); const pop = wrap.querySelector('.login-pop');
    const open = ()=>{ wrap.classList.add('open'); btn.setAttribute('aria-expanded','true'); };
    const close= ()=>{ wrap.classList.remove('open'); btn.setAttribute('aria-expanded','false'); };
    btn.addEventListener('click', (e)=>{ e.stopPropagation(); wrap.classList.contains('open')?close():open(); });
    document.addEventListener('click',(e)=>{ if(!wrap.contains(e.target)) close(); });
    document.addEventListener('keydown',(e)=>{ if(e.key==='Escape') close(); });
  })();
<<<<<<< HEAD
=======

  // 푸드다이어리 CTA 팝업: 호버/클릭 토글 + 바깥 클릭/ESC 닫기
  (function(){
    const wrap = document.getElementById('hkFooddiary'); if(!wrap) return;
    const cta  = wrap.querySelector('.cta'); const pop = wrap.querySelector('.cta-pop');
    const open = ()=>{ wrap.classList.add('open'); };
    const close= ()=>{ wrap.classList.remove('open'); };
    
    // 호버 이벤트
    wrap.addEventListener('mouseenter', open);
    wrap.addEventListener('mouseleave', close);
    
    // 바깥 클릭으로 닫기
    document.addEventListener('click',(e)=>{ if(!wrap.contains(e.target)) close(); });
    document.addEventListener('keydown',(e)=>{ if(e.key==='Escape') close(); });
  })();
>>>>>>> b65c320 (Initial commit)
</script>