package net.koreate.hellking.user.service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Base64;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.user.vo.SocialUserVO;

/**
 * OAuth 소셜 로그인 서비스 - 앱/웹 통합 지원
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class OAuthService {
    
    // OAuth API URL 상수들 정의
    private static final String NAVER_TOKEN_URL = "https://nid.naver.com/oauth2.0/token";
    private static final String NAVER_PROFILE_URL = "https://openapi.naver.com/v1/nid/me";
    
    private static final String KAKAO_TOKEN_URL = "https://kauth.kakao.com/oauth/token";
    private static final String KAKAO_PROFILE_URL = "https://kapi.kakao.com/v2/user/me";
    
    private static final String GOOGLE_TOKEN_URL = "https://oauth2.googleapis.com/token";
    private static final String GOOGLE_PROFILE_URL = "https://www.googleapis.com/oauth2/v2/userinfo";
    
    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;
    
    // 네이버 OAuth 설정
    @Value("${naver.oauth.client_id}")
    private String naverClientId;
    @Value("${naver.oauth.client_secret}")
    private String naverClientSecret;
    @Value("${naver.oauth.redirect_uri}")
    private String naverRedirectUri;
    @Value("${naver.oauth.mobile.redirect_uri}")
    private String naverMobileRedirectUri;
    @Value("${naver.oauth.authorize_url}")
    private String naverAuthorizeUrl;
    @Value("${naver.oauth.token_url}")
    private String naverTokenUrl;
    @Value("${naver.oauth.profile_url}")
    private String naverProfileUrl;
    
    // 카카오 OAuth 설정
    @Value("${kakao.oauth.client_id}")
    private String kakaoClientId;
    @Value("${kakao.oauth.client_secret}")
    private String kakaoClientSecret;
    @Value("${kakao.oauth.redirect_uri}")
    private String kakaoRedirectUri;
    @Value("${kakao.oauth.mobile.redirect_uri}")
    private String kakaoMobileRedirectUri;
    @Value("${kakao.oauth.authorize_url}")
    private String kakaoAuthorizeUrl;
    @Value("${kakao.oauth.token_url}")
    private String kakaoTokenUrl;
    @Value("${kakao.oauth.profile_url}")
    private String kakaoProfileUrl;
    
    // 구글 OAuth 설정
    @Value("${google.oauth.client_id}")
    private String googleClientId;
    @Value("${google.oauth.client_secret}")
    private String googleClientSecret;
    @Value("${google.oauth.redirect_uri}")
    private String googleRedirectUri;
    @Value("${google.oauth.mobile.redirect_uri}")
    private String googleMobileRedirectUri;
    @Value("${google.oauth.authorize_url}")
    private String googleAuthorizeUrl;
    @Value("${google.oauth.token_url}")
    private String googleTokenUrl;
    @Value("${google.oauth.profile_url}")
    private String googleProfileUrl;
    
    @Value("${oauth.state.secret}")
    private String stateSecret;
    
    // === 네이버 OAuth ===
    
    /**
     * 동적 redirect URI를 지원하는 네이버 Auth URL 생성
     */
    public String getNaverAuthUrl(String redirectUri) {
        try {
            String clientId = naverClientId;
            String state = generateState("NAVER");
            
            String authUrl = UriComponentsBuilder.fromHttpUrl(naverAuthorizeUrl)
                    .queryParam("response_type", "code")
                    .queryParam("client_id", clientId)
                    .queryParam("redirect_uri", redirectUri)
                    .queryParam("state", state)
                    .build()
                    .toUriString();
            
            log.info("네이버 Auth URL 생성 - redirect_uri: {}", redirectUri);
            return authUrl;
            
        } catch (Exception e) {
            log.error("네이버 Auth URL 생성 실패", e);
            throw new RuntimeException("네이버 로그인 URL 생성에 실패했습니다.", e);
        }
    }
    
    /**
     * 기존 호환성을 위한 오버로드 메서드
     */
    public String getNaverAuthUrl() {
        return getNaverAuthUrl(naverRedirectUri);
    }
    
    /**
     * 네이버 액세스 토큰 발급 (동적 redirect_uri 지원) - 3개 파라미터 버전
     */
    public String getNaverAccessToken(String code, String state, String redirectUri) throws Exception {
        log.info("네이버 액세스 토큰 요청 시작 (동적 URI 지원)");
        log.info("파라미터 - code: {}, state: {}, redirectUri: {}", code, state, redirectUri);
        
        if (!validateState(state, "NAVER")) {
            throw new Exception("Invalid state parameter");
        }
        
        try {
            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
            params.add("grant_type", "authorization_code");
            params.add("client_id", naverClientId);
            params.add("client_secret", naverClientSecret);
            params.add("redirect_uri", redirectUri); // 전달받은 redirectUri 사용
            params.add("code", code);
            params.add("state", state);
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
            
            log.info("네이버 토큰 요청 URL: {}", NAVER_TOKEN_URL);
            log.info("요청 파라미터:");
            params.forEach((key, value) -> {
                if (key.equals("client_secret")) {
                    log.info("   - {}: ****", key);
                } else {
                    log.info("   - {}: {}", key, value);
                }
            });
            
            HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, headers);
            ResponseEntity<String> response = restTemplate.postForEntity(NAVER_TOKEN_URL, entity, String.class);
            
            log.info("네이버 토큰 응답 상태: {}", response.getStatusCode());
            log.info("응답 본문: {}", response.getBody());
            
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            String accessToken = jsonNode.get("access_token").asText();
            log.info("네이버 액세스 토큰 획득 성공");
            return accessToken;
            
        } catch (HttpClientErrorException e) {
            log.error("네이버 토큰 요청 HTTP 오류: {} - {}", e.getStatusCode(), e.getResponseBodyAsString());
            throw new Exception("네이버 토큰 요청 실패: " + e.getResponseBodyAsString());
        } catch (Exception e) {
            log.error("네이버 토큰 요청 실패: {}", e.getMessage(), e);
            throw e;
        }
    }
    
    /**
     * 네이버 액세스 토큰 발급 (기존 호환성 유지) - 2개 파라미터 버전
     */
    public String getNaverAccessToken(String code, String state) throws Exception {
        return getNaverAccessToken(code, state, naverRedirectUri);
    }
    
    /**
     * 네이버 사용자 정보 조회
     */
    public SocialUserVO getNaverUserInfo(String accessToken) throws Exception {
        try {
            log.info("네이버 사용자 정보 조회 시작");
            
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "Bearer " + accessToken);
            
            HttpEntity<String> entity = new HttpEntity<>(headers);
            ResponseEntity<String> response = restTemplate.exchange(
                NAVER_PROFILE_URL, HttpMethod.GET, entity, String.class);
            
            log.info("네이버 API 응답: {}", response.getBody());
            
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            
            if (jsonNode == null) {
                throw new Exception("네이버 API 응답이 null입니다");
            }
            
            if (!jsonNode.has("response")) {
                throw new Exception("네이버 API 응답에 'response' 필드가 없습니다: " + response.getBody());
            }
            
            JsonNode responseNode = jsonNode.get("response");
            if (responseNode == null) {
                throw new Exception("네이버 API 응답의 'response' 필드가 null입니다");
            }
            
            SocialUserVO socialUser = new SocialUserVO();
            socialUser.setProvider("NAVER");
            
            // 필수 필드 확인 및 안전한 값 추출
            if (responseNode.has("id") && !responseNode.get("id").isNull()) {
                socialUser.setSocialUserId(responseNode.get("id").asText());
            } else {
                throw new Exception("네이버 사용자 ID를 찾을 수 없습니다");
            }
            
            if (responseNode.has("email") && !responseNode.get("email").isNull()) {
                socialUser.setSocialEmail(responseNode.get("email").asText());
            } else {
                throw new Exception("네이버 사용자 이메일을 찾을 수 없습니다");
            }
            
            if (responseNode.has("name") && !responseNode.get("name").isNull()) {
                socialUser.setSocialName(responseNode.get("name").asText());
            } else {
                // 이름이 없으면 닉네임 또는 기본값 사용
                if (responseNode.has("nickname") && !responseNode.get("nickname").isNull()) {
                    socialUser.setSocialName(responseNode.get("nickname").asText());
                } else {
                    socialUser.setSocialName("네이버 사용자");
                }
            }
            
            // 선택적 필드
            if (responseNode.has("profile_image") && !responseNode.get("profile_image").isNull()) {
                socialUser.setSocialProfileImage(responseNode.get("profile_image").asText());
            }
            
            log.info("네이버 사용자 정보 파싱 완료: {}", socialUser.getSocialEmail());
            return socialUser;
            
        } catch (Exception e) {
            log.error("네이버 사용자 정보 조회 실패: {}", e.getMessage(), e);
            throw new Exception("네이버 사용자 정보를 가져올 수 없습니다: " + e.getMessage());
        }
    }
    
    // === 카카오 OAuth ===
    
    /**
     * 카카오용 동적 redirect URI 지원
     */
    public String getKakaoAuthUrl(String redirectUri) {
        try {
            String clientId = kakaoClientId;
            String state = generateState("KAKAO");
            
            String authUrl = UriComponentsBuilder.fromHttpUrl(kakaoAuthorizeUrl)
                    .queryParam("client_id", clientId)
                    .queryParam("redirect_uri", redirectUri)
                    .queryParam("response_type", "code")
                    .queryParam("state", state)
                    .build()
                    .toUriString();
            
            log.info("카카오 Auth URL 생성 - redirect_uri: {}", redirectUri);
            return authUrl;
            
        } catch (Exception e) {
            log.error("카카오 Auth URL 생성 실패", e);
            throw new RuntimeException("카카오 로그인 URL 생성에 실패했습니다.", e);
        }
    }
    
    public String getKakaoAuthUrl() {
        return getKakaoAuthUrl(kakaoRedirectUri);
    }
    
    /**
     * 카카오 액세스 토큰 발급 (redirect_uri 동적 처리)
     */
    public String getKakaoAccessToken(String code, String redirectUri) {
        log.info("카카오 액세스 토큰 요청 시작");
        log.info("파라미터 - code: {}, redirectUri: {}", code, redirectUri);
        
        // 모바일 앱에서 온 요청인지 확인하여 적절한 redirectUri 사용
        String finalRedirectUri;
        if (redirectUri != null && redirectUri.contains("192.168.0.133")) {
            // 모바일 앱에서 온 요청
            finalRedirectUri = kakaoRedirectUri; // application.properties의 기본값 사용
            log.info("모바일 앱 요청 감지 - 기본 redirectUri 사용: {}", finalRedirectUri);
        } else if (redirectUri != null) {
            // 웹에서 온 요청
            finalRedirectUri = redirectUri;
            log.info("웹 요청 감지 - 전달받은 redirectUri 사용: {}", finalRedirectUri);
        } else {
            // 기본값 사용
            finalRedirectUri = kakaoRedirectUri;
            log.info("기본 redirectUri 사용: {}", finalRedirectUri);
        }
        
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
            
            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
            params.add("grant_type", "authorization_code");
            params.add("client_id", kakaoClientId);
            params.add("client_secret", kakaoClientSecret);
            params.add("redirect_uri", finalRedirectUri);
            params.add("code", code);
            
            log.info("카카오 토큰 요청 URL: {}", KAKAO_TOKEN_URL);
            log.info("요청 파라미터:");
            params.forEach((key, value) -> {
                if (key.equals("client_secret")) {
                    log.info("   - {}: ****", key);
                } else {
                    log.info("   - {}: {}", key, value);
                }
            });
            
            HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);
            ResponseEntity<Map> response = restTemplate.postForEntity(KAKAO_TOKEN_URL, request, Map.class);
            
            log.info("카카오 토큰 응답 상태: {}", response.getStatusCode());
            log.info("응답 본문: {}", response.getBody());
            
            if (response.getBody() != null && response.getBody().get("access_token") != null) {
                String accessToken = (String) response.getBody().get("access_token");
                log.info("카카오 액세스 토큰 획득 성공");
                return accessToken;
            } else {
                log.error("액세스 토큰이 응답에 없음");
                return null;
            }
            
        } catch (HttpClientErrorException e) {
            log.error("카카오 토큰 요청 HTTP 오류: {} - {}", e.getStatusCode(), e.getResponseBodyAsString());
            return null;
        } catch (Exception e) {
            log.error("카카오 토큰 요청 실패: {}", e.getMessage(), e);
            return null;
        }
    }

    /**
     * 기존 호환성을 위한 오버로드 메서드
     */
    public String getKakaoAccessToken(String code) throws Exception {
        return getKakaoAccessToken(code, null);
    }
    
    /**
     * 카카오 사용자 정보 조회 - 이메일 권한 없음에 대응하는 개선된 버전
     */
    public SocialUserVO getKakaoUserInfo(String accessToken) throws Exception {
        try {
            log.info("카카오 사용자 정보 조회 시작");
            
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "Bearer " + accessToken);
            
            HttpEntity<String> entity = new HttpEntity<>(headers);
            ResponseEntity<String> response = restTemplate.exchange(
                KAKAO_PROFILE_URL, HttpMethod.GET, entity, String.class);
            
            log.info("카카오 API 응답: {}", response.getBody());
            
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            
            if (jsonNode == null || !jsonNode.has("id")) {
                throw new Exception("카카오 API 응답에 필수 'id' 필드가 없습니다: " + response.getBody());
            }
            
            SocialUserVO socialUser = new SocialUserVO();
            socialUser.setProvider("KAKAO");
            socialUser.setSocialUserId(jsonNode.get("id").asText());
            
            // 기본값 설정 (최소한의 정보만 있는 경우 대비)
            socialUser.setSocialName("카카오 사용자");
            socialUser.setSocialEmail("kakao_" + socialUser.getSocialUserId() + "@kakao.local");
            
            // kakao_account가 있는 경우에만 추가 정보 처리
            if (jsonNode.has("kakao_account") && !jsonNode.get("kakao_account").isNull()) {
                JsonNode kakaoAccount = jsonNode.get("kakao_account");
                
                // 이메일 정보 (권한이 있는 경우에만)
                if (kakaoAccount.has("email") && !kakaoAccount.get("email").isNull()) {
                    socialUser.setSocialEmail(kakaoAccount.get("email").asText());
                    log.info("카카오 이메일 정보 획득 성공: {}", socialUser.getSocialEmail());
                } else {
                    log.warn("카카오 이메일 권한이 없어서 임시 이메일 사용: {}", socialUser.getSocialEmail());
                }
                
                // 프로필 정보
                if (kakaoAccount.has("profile") && !kakaoAccount.get("profile").isNull()) {
                    JsonNode profile = kakaoAccount.get("profile");
                    
                    if (profile.has("nickname") && !profile.get("nickname").isNull()) {
                        socialUser.setSocialName(profile.get("nickname").asText());
                    }
                    
                    if (profile.has("profile_image_url") && !profile.get("profile_image_url").isNull()) {
                        socialUser.setSocialProfileImage(profile.get("profile_image_url").asText());
                    }
                }
            } else {
                log.warn("카카오 API 응답에 kakao_account 정보가 없습니다. 기본값으로 처리합니다.");
            }
            
            log.info("카카오 사용자 정보 파싱 완료: {} ({})", socialUser.getSocialName(), socialUser.getSocialEmail());
            return socialUser;
            
        } catch (Exception e) {
            log.error("카카오 사용자 정보 조회 실패: {}", e.getMessage(), e);
            throw new Exception("카카오 사용자 정보를 가져올 수 없습니다: " + e.getMessage());
        }
    }
    
    // === 구글 OAuth ===
    
    /**
     * 구글용 동적 redirect URI 지원  
     */
    public String getGoogleAuthUrl(String redirectUri) {
        try {
            String clientId = googleClientId;
            
            String authUrl = UriComponentsBuilder.fromHttpUrl(googleAuthorizeUrl)
                    .queryParam("client_id", clientId)
                    .queryParam("redirect_uri", redirectUri)
                    .queryParam("response_type", "code")
                    .queryParam("scope", "openid email profile")
                    .build()
                    .toUriString();
            
            log.info("구글 Auth URL 생성 - redirect_uri: {}", redirectUri);
            return authUrl;
            
        } catch (Exception e) {
            log.error("구글 Auth URL 생성 실패", e);
            throw new RuntimeException("구글 로그인 URL 생성에 실패했습니다.", e);
        }
    }
    
    public String getGoogleAuthUrl() {
        return getGoogleAuthUrl(googleRedirectUri);
    }
    
    /**
     * 구글 액세스 토큰 발급
     */
    public String getGoogleAccessToken(String code) throws Exception {
        log.info("구글 액세스 토큰 요청 시작");
        log.info("파라미터 - code: {}", code);
        
        try {
            MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
            params.add("grant_type", "authorization_code");
            params.add("client_id", googleClientId);
            params.add("client_secret", googleClientSecret);
            params.add("redirect_uri", googleRedirectUri);
            params.add("code", code);
            
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
            
            log.info("구글 토큰 요청 URL: {}", GOOGLE_TOKEN_URL);
            log.info("요청 파라미터:");
            params.forEach((key, value) -> {
                if (key.equals("client_secret")) {
                    log.info("   - {}: ****", key);
                } else {
                    log.info("   - {}: {}", key, value);
                }
            });
            
            HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, headers);
            ResponseEntity<String> response = restTemplate.postForEntity(GOOGLE_TOKEN_URL, entity, String.class);
            
            log.info("구글 토큰 응답 상태: {}", response.getStatusCode());
            log.info("응답 본문: {}", response.getBody());
            
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            String accessToken = jsonNode.get("access_token").asText();
            log.info("구글 액세스 토큰 획득 성공");
            return accessToken;
            
        } catch (HttpClientErrorException e) {
            log.error("구글 토큰 요청 HTTP 오류: {} - {}", e.getStatusCode(), e.getResponseBodyAsString());
            throw new Exception("구글 토큰 요청 실패: " + e.getResponseBodyAsString());
        } catch (Exception e) {
            log.error("구글 토큰 요청 실패: {}", e.getMessage(), e);
            throw e;
        }
    }
    
    /**
     * 구글 사용자 정보 조회
     */
    public SocialUserVO getGoogleUserInfo(String accessToken) throws Exception {
        try {
            log.info("구글 사용자 정보 조회 시작");
            
            HttpHeaders headers = new HttpHeaders();
            headers.set("Authorization", "Bearer " + accessToken);
            
            HttpEntity<String> entity = new HttpEntity<>(headers);
            ResponseEntity<String> response = restTemplate.exchange(
                GOOGLE_PROFILE_URL, HttpMethod.GET, entity, String.class);
            
            log.info("구글 API 응답: {}", response.getBody());
            
            JsonNode jsonNode = objectMapper.readTree(response.getBody());
            
            SocialUserVO socialUser = new SocialUserVO();
            socialUser.setProvider("GOOGLE");
            socialUser.setSocialUserId(jsonNode.get("id").asText());
            socialUser.setSocialEmail(jsonNode.get("email").asText());
            socialUser.setSocialName(jsonNode.get("name").asText());
            
            if (jsonNode.has("picture")) {
                socialUser.setSocialProfileImage(jsonNode.get("picture").asText());
            }
            
            log.info("구글 사용자 정보 파싱 완료: {} ({})", socialUser.getSocialName(), socialUser.getSocialEmail());
            return socialUser;
            
        } catch (Exception e) {
            log.error("구글 사용자 정보 조회 실패: {}", e.getMessage(), e);
            throw new Exception("구글 사용자 정보를 가져올 수 없습니다: " + e.getMessage());
        }
    }
    
    // === 유틸리티 메서드 ===
    
    /**
     * 웹용 redirect URI 반환
     */
    public String getWebRedirectUri(String provider) {
        switch (provider.toLowerCase()) {
            case "naver":
                return naverRedirectUri;
            case "kakao":
                return kakaoRedirectUri;
            case "google":
                return googleRedirectUri;
            default:
                throw new IllegalArgumentException("지원하지 않는 소셜 로그인 제공자: " + provider);
        }
    }
    
    /**
     * 모바일용 redirect URI 반환
     */
    public String getMobileRedirectUri(String provider) {
        switch (provider.toLowerCase()) {
            case "naver":
                return naverMobileRedirectUri;
            case "kakao":
                return kakaoMobileRedirectUri;
            case "google":
                return googleMobileRedirectUri;
            default:
                throw new IllegalArgumentException("지원하지 않는 소셜 로그인 제공자: " + provider);
        }
    }
    
    /**
     * State 매개변수 생성 (CSRF 공격 방지)
     */
    private String generateState(String provider) {
        try {
            String data = provider + ":" + System.currentTimeMillis() + ":" + UUID.randomUUID();
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest((data + stateSecret).getBytes(StandardCharsets.UTF_8));
            return Base64.getUrlEncoder().withoutPadding().encodeToString(hash);
        } catch (Exception e) {
            log.error("State 생성 오류", e);
            return UUID.randomUUID().toString().replace("-", "");
        }
    }
    
    /**
     * State 매개변수 검증
     */
    private boolean validateState(String state, String provider) {
        // 간단한 검증 - 실제 운영환경에서는 더 강력한 검증 구현 권장
        return state != null && state.length() > 10;
    }
    
    /**
     * 소셜 제공자별 인증 URL 반환
     */
    public String getAuthUrl(String provider) {
        switch (provider.toUpperCase()) {
            case "NAVER":
                return getNaverAuthUrl();
            case "KAKAO":
                return getKakaoAuthUrl();
            case "GOOGLE":
                return getGoogleAuthUrl();
            default:
                throw new IllegalArgumentException("지원하지 않는 소셜 로그인 제공자: " + provider);
        }
    }
    
    /**
     * 소셜 제공자별 사용자 정보 조회
     */
    public SocialUserVO getSocialUserInfo(String provider, String accessToken) throws Exception {
        switch (provider.toUpperCase()) {
            case "NAVER":
                return getNaverUserInfo(accessToken);
            case "KAKAO":
                return getKakaoUserInfo(accessToken);
            case "GOOGLE":
                return getGoogleUserInfo(accessToken);
            default:
                throw new IllegalArgumentException("지원하지 않는 소셜 로그인 제공자: " + provider);
        }
    }
}