<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- HELLKING 헤더 - Orangetheory 스타일 레퍼런스 반영 버전 --%>

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
  }
  .hk-menu>li:hover>.hk-sub,
  .hk-menu>li:focus-within>.hk-sub{opacity:1;visibility:visible;transform:translateY(0);}
  .hk-sub li a{
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
  .login-btn:active{transform:scale(.98);}
  .login-icon{width:18px;height:18px;position:relative;display:inline-block;}
  .login-icon:before,.login-icon:after{content:"";position:absolute;left:50%;transform:translateX(-50%);border:2px solid var(--ink);border-radius:50%;}
  .login-icon:before{top:1px;width:9px;height:9px;}
  .login-icon:after{bottom:1px;width:14px;height:8px;border-top:none;}
  .login-pop{
    position:absolute;right:0;top:calc(100% + 10px);min-width:220px;background:#fff;border:1px solid var(--line);
    border-radius:var(--radius);box-shadow:0 14px 28px rgba(15,23,42,.08);padding:8px;
    opacity:0;visibility:hidden;transform:translateY(6px);transition:opacity .18s,transform .18s,visibility .18s;
  }
  .login-wrap.open .login-pop{opacity:1;visibility:visible;transform:translateY(0);}
  .login-pop a{display:block;padding:10px 12px;border-radius:10px;font-size:14px;color:var(--ink);}
  .login-pop a:hover{background:#F8FAFC;}

  /* CTA "디자인바디" → 레퍼런스의 Free Class 스타일 */
  .cta{
    display:inline-flex;align-items:center;gap:8px;padding:11px 18px;border-radius:999px;
    font-weight:900;font-size:14px;color:#1A1A1A;background:var(--brand);border:1px solid #DD5C00;
    box-shadow:0 6px 14px rgba(255,106,0,.25);cursor:pointer;transition:transform .08s,box-shadow .18s,filter .18s;
  }
  .cta:hover{transform:translateY(-1px);box-shadow:0 10px 18px rgba(255,106,0,.3);filter:saturate(1.05);}
  .cta:active{transform:translateY(0);}
  .cta .dot{width:8px;height:8px;border-radius:50%;background:#fff;box-shadow:0 0 8px rgba(255,255,255,.9);}

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
    .hk-wrap{grid-template-columns:auto 1fr auto;padding:12px 16px;}
    .hk-menu>li>a{padding:10px 12px;}
  }
  @media (max-width:860px){
    .hk-menu>li>a{font-size:14px;padding:9px 10px;}
    .hk-sub{min-width:200px;}
  }
</style>

<header class="hk-header">
  <div class="hk-wrap">
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
        <li>
          <a href="${pageContext.request.contextPath}/pass/list" aria-haspopup="true" aria-expanded="false">패스권</a>
          <ul class="hk-sub" aria-label="패스권 소메뉴">
            <li><a href="${pageContext.request.contextPath}/pass/list">패스권 안내</a></li>
            <li><a href="${pageContext.request.contextPath}/pass/mypass">내 패스권 관리</a></li>
          </ul>
        </li>
        
        <!-- 4. 게시판 -->
        <li>
          <a href="${pageContext.request.contextPath}/board/boardlist" aria-haspopup="true" aria-expanded="false">게시판</a>
          <ul class="hk-sub" aria-label="게시판 소메뉴">      
            <li><a href="${pageContext.request.contextPath}/board/freeboard">자유게시판</a></li>
            <li><a href="${pageContext.request.contextPath}/board/secretboard">익명게시판</a></li>
            <li><a href="${pageContext.request.contextPath}/board/localboard">지역게시판</a></li>
          </ul>
        </li>
        
        <!-- 5. 고객리뷰 -->
        <li><a href="${pageContext.request.contextPath}/reviews/list">고객리뷰</a></li>
        
        <!-- 6. 고객센터 -->
        <li>
          <a href="#" aria-haspopup="true" aria-expanded="false">고객센터</a>
          <ul class="hk-sub" aria-label="고객센터 소메뉴">
            <li><a href="${pageContext.request.contextPath}/support/faq">FAQ</a></li>
            <li><a href="${pageContext.request.contextPath}/support/search">문의사항 검색</a></li>
            <li><a href="${pageContext.request.contextPath}/support/kakao">카톡상담</a></li>
          </ul>
        </li>
      </ul>
    </nav>

    <!-- 오른쪽: 로그인 아이콘 + CTA -->
    <div class="hk-utils">
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

      <a class="cta" href="${pageContext.request.contextPath}/designbody/" title="디자인바디">
        <span class="dot" aria-hidden="true"></span> 디자인바디
      </a>
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
</script>