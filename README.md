# hellking

> Spring MVC 기반의 게시판/회원/파일 관리 웹 애플리케이션

## 📖 프로젝트 개요

**hellking** 는 Java Spring MVC + MyBatis 기반으로 구성된 웹 애플리케이션입니다. 
주요 기능으로는 게시판(자유/비밀/지역), 댓글·답글, 파일 업로드/다운로드, 회원/로그인, 문의/상담, FAQ 등이 포함됩니다.

## ⚙️ 기술 스택

- **Language**: Java
- **Framework**: Spring MVC, MyBatis
- **View**: JSP, JSTL
- **Server**: Apache Tomcat
- **Database**: Oracle (SQL 스크립트 포함 시 적용)
- **Build**: Maven (pom.xml)

## 🧱 프로젝트 구조

아래는 주요 디렉토리 트리 요약입니다.

```text
hellking_extracted/
├── .apt_generated/
├── .apt_generated_tests/
├── .settings/
│   ├── org.eclipse.jdt.apt.core.prefs
│   ├── org.eclipse.jdt.core.prefs
│   ├── org.eclipse.ltk.core.refactoring.prefs
│   ├── org.eclipse.m2e.core.prefs
│   ├── org.eclipse.wst.common.component
│   ├── org.eclipse.wst.common.project.facet.core.xml
│   ├── org.eclipse.wst.validation.prefs
│   ├── org.springframework.ide.eclipse.beans.core.prefs
│   ├── org.springframework.ide.eclipse.core.prefs
│   └── org.springframework.ide.eclipse.prefs
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── net/
│   │   ├── resources/
│   │   │   ├── META-INF/
│   │   │   ├── mybatis/
│   │   │   ├── prop/
│   │   │   ├── spring/
│   │   │   └── log4j.xml
│   │   └── webapp/
│   │       ├── resources/
│   │       ├── upload/
│   │       └── WEB-INF/
│   └── test/
│       ├── java/
│       │   └── net/
│       └── resources/
│           └── log4j.xml
├── target/
│   ├── classes/
│   │   ├── mybatis/
│   │   │   └── sql/
│   │   ├── net/
│   │   │   └── koreate/
│   │   ├── prop/
│   │   │   ├── application.properties
│   │   │   ├── db.properties
│   │   │   ├── mail.properties
│   │   │   ├── payment.properties
│   │   │   └── sms.properties
│   │   ├── spring/
│   │   │   ├── appServlet/
│   │   │   └── root-context.xml
│   │   └── log4j.xml
│   ├── m2e-wtp/
│   │   └── web-resources/
│   │       └── META-INF/
│   └── test-classes/
│       ├── net/
│       │   └── koreate/
│       └── log4j.xml
├── .classpath
├── .factorypath
├── .project
├── .springBeans
├── hk_board.sql
├── hk_chain.sql
├── hk_designbody.sql
├── hk_food.sql
├── hk_pass.sql
├── hk_program.sql
├── hk_qr.sql
├── hk_review.sql
├── hk_support.sql
├── hk_user.sql
└── pom.xml
```

## 🧩 주요 설정 파일

- `pom.xml` — Maven 의존성 및 빌드 설정
- `WEB-INF/web.xml` — 서블릿, 필터, 리스너 및 디스패처 설정
- MyBatis 매퍼:
  - `src/main/resources/mybatis/sql/boardMapper.xml`
  - `src/main/resources/mybatis/sql/commentMapper.xml`
  - `src/main/resources/mybatis/sql/localMapper.xml`
  - `src/main/resources/mybatis/sql/secretMapper.xml`

## ✨ 주요 기능

- FAQ
- 문의/상담
- 비밀게시판
- 자유게시판
- 지역게시판
- 체인/지점
- 파일 업/다운로드
- 회원/로그인

## 📦 패키지 및 레이어

- Controller: 20개
- Service: 28개
- DAO/Repository: 23개
- VO: 39개

주요 패키지(상위 10개):
- `net.koreate.hellking.board.dao`: 8 파일
- `net.koreate.hellking.board.service`: 8 파일
- `net.koreate.hellking.common.utils`: 8 파일
- `net.koreate.hellking.fooddiary.vo`: 8 파일
- `net.koreate.hellking.board.util`: 6 파일
- `net.koreate.hellking.support.vo`: 6 파일
- `net.koreate.hellking.board.vo`: 5 파일
- `net.koreate.hellking.common.config`: 5 파일
- `net.koreate.hellking.common.service`: 5 파일
- `net.koreate.hellking.support.dao`: 5 파일

## 🖼️ View & 정적 리소스

- JSP Views (총 87개): 예) `src/main/webapp/WEB-INF/views/home.jsp` 등
- CSS 파일 (총 5개): 예) `src/main/webapp/resources/css/boardstyle.css` 등

## 💾 데이터베이스

- 포함된 SQL 스크립트 (총 10개):
  - `hk_board.sql`
  - `hk_chain.sql`
  - `hk_designbody.sql`
  - `hk_food.sql`
  - `hk_pass.sql`
  - `hk_program.sql`
  - `hk_qr.sql`
  - `hk_review.sql`
  - `hk_support.sql`
  - `hk_user.sql`

## 🚀 실행 방법

- 1. **환경 준비**
   - JDK 11 이상 설치
   - Apache Tomcat 9.x 설치
   - Maven 3.x 설치 (필요 시)
2. **DB 설정**
   - 데이터베이스 생성 (예: Oracle 21c 또는 MySQL 8.x)
   - 제공된 SQL 스크립트가 있다면 실행하여 스키마/테이블 생성
   - `datasource` 설정을 프로젝트의 Spring/MyBatis 설정 파일에서 실제 DB 접속 정보로 수정
3. **프로젝트 Import**
   - STS3 / Eclipse: `File > Import > Existing Maven Projects` 로 가져오기
4. **서버 등록 및 실행**
   - STS3: `Servers` 뷰에서 Tomcat 9 추가 → 프로젝트 Add → Run
   - 또는 `mvn clean package` 후 생성된 WAR를 Tomcat `webapps/`에 배포
5. **접속**
   - 기본 컨텍스트 기준: `http://localhost:8080/<context-path>`

## 🌐 대표 URL 예시

- `/board/freeboard` — 자유게시판 목록/조회/작성
- `/board/secretboard` — 비밀게시판
- `/board/localboard` — 지역게시판
- `/user/login`, `/user/join` — 로그인/회원가입
- `/board/download` — 파일 다운로드

> 실제 URL은 Controller 매핑에 따라 다를 수 있으니 `controller` 코드를 참고하세요.

## 🧰 빌드 & 의존성

- groupId: `net.koreate`
- artifactId: `hellking`
- version: `1.0.0-BUILD-SNAPSHOT`
- properties:
  - `java-version`: 11
  - `org.springframework-version`: 5.3.39
  - `org.aspectj-version`: 1.9.24
  - `org.slf4j-version`: 2.0.17
  - `jackson.version`: 2.19.2
  - `httpclient.version`: 4.5.14

## 👤 개발자

- Author: 양진곤, 이지황!, 이희승
