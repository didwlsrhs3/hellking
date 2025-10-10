
<p align="center">
  <h1 style="color:#ff7b00;">🔥 HELLKING 🔥</h1>
  <p><strong>SPRING MVC COMMUNITY PROJECT</strong></p>
  <p>Developed by 양진곤</p>
  <p>Developed by 이지황</p>
  <p>Developed by 이희승</p>
</p>

---

## 🏰 프로젝트 개요
**HELLKING**은 Spring MVC 기반의 커뮤니티 웹 애플리케이션으로,  
자유게시판 · 비밀게시판 · 지역게시판 · 댓글 · 파일 업로드/다운로드 · 회원관리 · 문의/상담 등  
다양한 기능을 하나의 통합 플랫폼으로 제공합니다.  

> **목표:** 안정적인 MVC 구조와 명확한 계층 분리를 통해 유지보수성과 확장성을 확보한 커뮤니티 서비스

---

## ✨ 주요 기능
| 구분 | 설명 |
|------|------|
| 📰 자유/비밀/지역 게시판 | 게시판 CRUD, 페이징, 검색, 정렬, 파일 첨부 기능 |
| 💬 댓글 & 답글 | 계층형 댓글 구조, 로그인 사용자 식별, 본인 확인 버튼 제어 |
| 📂 파일 업/다운로드 | 업로드 시 중복 방지 및 파일명 인코딩 처리 |
| 👤 회원 관리 | 회원가입, 로그인, 세션 인증, 권한 기반 접근 제어 |
| 🧾 문의/상담 관리 | 문의글 작성 및 상담 요청 관리 (관리자용 포함) |
| 🧠 FAQ | 자주 묻는 질문 등록/조회/검색 |
| 🏪 체인 관리 | 매장/지점 정보 등록 및 조회 기능 (hk_chain) |
| 📊 관리자 모드 | 회원·게시글·상담 현황 관리 및 통계 |

---

## ⚙️ 기술 스택
| 구분 | 기술 |
|------|------|
| Language | Java 11 |
| Framework | Spring MVC, MyBatis |
| View | JSP, JSTL, CSS |
| Server | Apache Tomcat 9 |
| Database | Oracle 21c |
| Build Tool | Maven |
| IDE | Spring Tool Suite 3 (STS3) |

---

## 🧱 프로젝트 구조
```text
hellking/
├── src/
│   ├── main/java/net/koreate/hellking/
│   │   ├── board/        # 게시판, 댓글, 파일 관련 로직
│   │   ├── user/         # 회원 로그인/가입 서비스
│   │   ├── support/      # 문의, 상담, FAQ
│   │   └── chain/        # 체인/지점 관리
│   ├── resources/
│   │   └── mybatis/sql/  # MyBatis 매퍼 XML
│   └── webapp/WEB-INF/views/
│       ├── board/        # 게시판 JSP
│       ├── user/         # 회원 관련 JSP
│       ├── support/      # 문의/FAQ JSP
│       └── common/       # header, footer, error 페이지
├── pom.xml               # Maven 빌드 설정
├── web.xml               # 서블릿/필터 매핑
└── README.md
```

---

## 💾 데이터베이스 구조
**DB:** Oracle 21c  

대표 테이블 구성 예시:
| 테이블명 | 설명 |
|-----------|------|
| `hk_users` | 회원 정보 저장 |
| `hell_board` | 게시판 메인 테이블 |
| `hell_comment` | 댓글/답글 테이블 |
| `hk_inquiry`, `hk_consultation` | 문의 및 상담 데이터 |
| `hk_faq` | FAQ 게시판 |
| `hk_chains` | 체인/지점 정보 |

> 모든 테이블은 **`user_id` 또는 `user_num`** 을 외래키로 연결하여 사용자 참조 무결성을 보장합니다.

---

## 🚀 실행 방법
1. **환경 준비**
   - JDK 11 이상, Apache Tomcat 9.x, Oracle 21c 설치
2. **DB 세팅**
   - `sql/` 폴더 내 초기화 스크립트 실행
   - `root-context.xml` 또는 `mybatis-context.xml`에서 DB 연결 정보 수정
3. **프로젝트 Import**
   - STS3 → *File > Import > Existing Maven Projects* 선택
4. **서버 배포 및 실행**
   - Tomcat Run → `http://localhost:8080/hellking` 접속

---

## 🌐 대표 URL 예시
| 경로 | 설명 |
|------|------|
| `/board/freeboard` | 자유게시판 |
| `/board/secretboard` | 비밀게시판 |
| `/board/localboard` | 지역게시판 |
| `/user/login`, `/user/join` | 로그인/회원가입 |
| `/board/download` | 파일 다운로드 |
| `/support/inquiry` | 문의글 작성/조회 |

---

## 🧰 빌드 정보
- **groupId:** `net.koreate`
- **artifactId:** `hellking`
- **version:** `1.0.0-BUILD-SNAPSHOT`

주요 의존성:
- spring-webmvc, spring-jdbc, mybatis-spring, oracle-driver, jstl, commons-fileupload 등

---

## 👑 개발자 정보
**Developed by 양진곤**  
**Developed by 이지황**  
**Developed by 이희승**  

> 지속적인 개선과 유지보수를 목표로 하는 Spring MVC 기반 포트폴리오 프로젝트입니다.

---

<p align="center" style="color:#ff7b00;">© 2025 HELLKING PROJECT. All Rights Reserved.</p>
