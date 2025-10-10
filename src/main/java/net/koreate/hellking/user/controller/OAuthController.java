package net.koreate.hellking.user.controller;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.user.service.OAuthService;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.user.vo.SocialUserVO;
import net.koreate.hellking.user.vo.UserVO;

/**
 * OAuth 소셜 로그인 컨트롤러 - 앱/웹 통합 지원
 */
@Controller
@RequestMapping("/oauth")
@Slf4j
@RequiredArgsConstructor
public class OAuthController {
    
    private final OAuthService oAuthService;
    private final UserService userService;
    
    // === 소셜 로그인 시작 ===
    
    /**
     * 네이버 로그인 시작 - 앱/웹 구분 지원
     */
    @GetMapping("/naver")
    public String naverLogin(@RequestParam(value = "join", required = false) String join,
                            @RequestParam(value = "redirect_uri", required = false) String redirectUri,
                            HttpServletRequest request,
                            HttpSession session) {
        try {
            if ("true".equals(join)) {
                session.setAttribute("socialJoinIntent", true);
                log.info("네이버 소셜 회원가입 의도 감지");
            }
            
            // 동적 redirect URI 결정
            String finalRedirectUri = determineRedirectUri(request, "naver", redirectUri);
            String authUrl = oAuthService.getNaverAuthUrl(finalRedirectUri);
            
            log.info("네이버 로그인 URL 생성: {}", authUrl);
            return "redirect:" + authUrl;
        } catch (Exception e) {
            log.error("네이버 로그인 URL 생성 실패", e);
            return "redirect:/user/login?error=oauth";
        }
    }
    
    /**
     * 카카오 로그인 시작 - 앱/웹 구분 지원
     */
    @GetMapping("/kakao")
    public String kakaoLogin(@RequestParam(value = "join", required = false) String join,
                            @RequestParam(value = "redirect_uri", required = false) String redirectUri,
                            HttpServletRequest request,
                            HttpSession session) {
        try {
            if ("true".equals(join)) {
                session.setAttribute("socialJoinIntent", true);
                log.info("카카오 소셜 회원가입 의도 감지");
            }
            
            String finalRedirectUri = determineRedirectUri(request, "kakao", redirectUri);
            String authUrl = oAuthService.getKakaoAuthUrl(finalRedirectUri);
            
            log.info("카카오 로그인 URL 생성: {}", authUrl);
            return "redirect:" + authUrl;
        } catch (Exception e) {
            log.error("카카오 로그인 URL 생성 실패", e);
            return "redirect:/user/login?error=oauth";
        }
    }
    
    /**
     * 구글 로그인 시작 - 앱/웹 구분 지원
     */
    @GetMapping("/google")
    public String googleLogin(@RequestParam(value = "join", required = false) String join,
                             @RequestParam(value = "redirect_uri", required = false) String redirectUri,
                             HttpServletRequest request,
                             HttpSession session) {
        try {
            if ("true".equals(join)) {
                session.setAttribute("socialJoinIntent", true);
                log.info("구글 소셜 회원가입 의도 감지");
            }
            
            String finalRedirectUri = determineRedirectUri(request, "google", redirectUri);
            String authUrl = oAuthService.getGoogleAuthUrl(finalRedirectUri);
            
            log.info("구글 로그인 URL 생성: {}", authUrl);
            return "redirect:" + authUrl;
        } catch (Exception e) {
            log.error("구글 로그인 URL 생성 실패", e);
            return "redirect:/user/login?error=oauth";
        }
    }
    
    /**
     * 요청 출처에 따라 적절한 redirect URI 결정
     */
    private String determineRedirectUri(HttpServletRequest request, String provider, String requestedRedirectUri) {
        // 1. 요청에서 명시적으로 redirect_uri가 전달된 경우 우선 사용
        if (requestedRedirectUri != null && !requestedRedirectUri.isEmpty()) {
            log.info("요청에서 redirect_uri 파라미터 사용: {}", requestedRedirectUri);
            return requestedRedirectUri;
        }
        
        // 2. User-Agent나 기타 헤더로 모바일 앱 감지
        String userAgent = request.getHeader("User-Agent");
        boolean isFromMobileApp = false;
        
        if (userAgent != null) {
            isFromMobileApp = userAgent.contains("Expo") || 
                             userAgent.contains("ReactNative") ||
                             userAgent.contains("HellkingApp");
        }
        
        // 3. 요청 URL 자체가 192.168.0.133을 포함하는지 확인
        String requestUrl = request.getRequestURL().toString();
        if (requestUrl.contains("192.168.0.133") || requestUrl.contains("10.0.2.2")) {
            isFromMobileApp = true;
        }
        
        // 4. 적절한 redirect URI 반환
        String baseUri = isFromMobileApp ? 
            oAuthService.getMobileRedirectUri(provider) : 
            oAuthService.getWebRedirectUri(provider);
        
        log.info("{}에서 {} OAuth 요청 - redirect URI: {}", 
                 isFromMobileApp ? "모바일 앱" : "웹", provider, baseUri);
        
        return baseUri;
    }
    
    // === OAuth 콜백 처리 ===
    
    /**
     * 네이버 OAuth 콜백 처리 - 수정된 버전
     */
    @GetMapping("/naver/callback")
    public String naverCallback(@RequestParam(value = "code", required = false) String code,
                               @RequestParam(value = "state", required = false) String state,
                               @RequestParam(value = "error", required = false) String error,
                               HttpServletRequest request,
                               HttpSession session,
                               RedirectAttributes rttr) {
        
        // 파라미터 디버깅 로그
        log.info("=== 네이버 콜백 파라미터 ===");
        log.info("code: {}", code);
        log.info("state: {}", state);
        log.info("error: {}", error);
        log.info("전체 파라미터: {}", request.getParameterMap());
        
        // 에러가 있거나 code가 없으면 에러 처리
        if (error != null || code == null || code.isEmpty()) {
            String errorMsg = error != null ? error : "Authorization code not received";
            log.error("네이버 콜백 에러: {}", errorMsg);
            return handleCallbackError("네이버", errorMsg, request);
        }
        
        try {
            // 동적 redirect URI 결정
            String redirectUri = isFromMobileApp(request) ? 
                               oAuthService.getMobileRedirectUri("naver") : 
                               oAuthService.getWebRedirectUri("naver");
            
            log.info("네이버 콜백 처리 - redirect_uri: {}", redirectUri);
            
            // 3개 파라미터 버전의 토큰 요청 메서드 사용
            String accessToken = oAuthService.getNaverAccessToken(code, state, redirectUri);
            SocialUserVO socialUserInfo = oAuthService.getNaverUserInfo(accessToken);
            
            // 요청이 앱에서 온 것인지 확인
            if (isFromMobileApp(request)) {
                return handleMobileCallback(socialUserInfo, "naver", session, request);
            } else {
                return processImprovedSocialLogin(socialUserInfo, session, rttr, "네이버");
            }
            
        } catch (Exception e) {
            log.error("네이버 로그인 처리 중 오류", e);
            return handleCallbackError("네이버", e.getMessage(), request);
        }
    }
    
    /**
     * 카카오 OAuth 콜백 처리 - 앱/웹 구분 지원
     */
    @GetMapping("/kakao/callback")
    public String kakaoCallback(@RequestParam("code") String code,
                               @RequestParam(value = "error", required = false) String error,
                               HttpServletRequest request,
                               HttpSession session,
                               RedirectAttributes rttr) {
        
        if (error != null) {
            return handleCallbackError("카카오", error, request);
        }
        
        try {
            // 동적 redirect_uri 결정
            String redirectUri = isFromMobileApp(request) ? 
                               oAuthService.getMobileRedirectUri("kakao") : 
                               oAuthService.getWebRedirectUri("kakao");
            
            log.info("카카오 콜백 처리 - redirect_uri: {}", redirectUri);
            
            String accessToken = oAuthService.getKakaoAccessToken(code, redirectUri);
            SocialUserVO socialUserInfo = oAuthService.getKakaoUserInfo(accessToken);
            
            if (isFromMobileApp(request)) {
                return handleMobileCallback(socialUserInfo, "kakao", session, request);
            } else {
                return processImprovedSocialLogin(socialUserInfo, session, rttr, "카카오");
            }
            
        } catch (Exception e) {
            log.error("카카오 로그인 처리 중 오류", e);
            return handleCallbackError("카카오", e.getMessage(), request);
        }
    }
    
    /**
     * 구글 OAuth 콜백 처리 - 앱/웹 구분 지원
     */
    @GetMapping("/google/callback")
    public String googleCallback(@RequestParam("code") String code,
                                @RequestParam(value = "error", required = false) String error,
                                HttpServletRequest request,
                                HttpSession session,
                                RedirectAttributes rttr) {
        
        if (error != null) {
            return handleCallbackError("구글", error, request);
        }
        
        try {
            String accessToken = oAuthService.getGoogleAccessToken(code);
            SocialUserVO socialUserInfo = oAuthService.getGoogleUserInfo(accessToken);
            
            if (isFromMobileApp(request)) {
                return handleMobileCallback(socialUserInfo, "google", session, request);
            } else {
                return processImprovedSocialLogin(socialUserInfo, session, rttr, "구글");
            }
            
        } catch (Exception e) {
            log.error("구글 로그인 처리 중 오류", e);
            return handleCallbackError("구글", e.getMessage(), request);
        }
    }
    
    /**
     * 모바일 앱에서 온 요청인지 확인
     */
    private boolean isFromMobileApp(HttpServletRequest request) {
        // 1. 요청 URL이 192.168.0.133을 포함하면 앱에서 온 요청
        String requestUrl = request.getRequestURL().toString();
        if (requestUrl.contains("192.168.0.133")) {
            log.info("모바일 앱 감지 - IP 주소: {}", requestUrl);
            return true;
        }
        
        // 2. Host 헤더 확인
        String host = request.getHeader("Host");
        if (host != null && host.contains("192.168.0.133")) {
            log.info("모바일 앱 감지 - Host 헤더: {}", host);
            return true;
        }
        
        // 3. User-Agent 확인
        String userAgent = request.getHeader("User-Agent");
        if (userAgent != null) {
            boolean isApp = userAgent.contains("Expo") || 
                           userAgent.contains("ReactNative") ||
                           userAgent.contains("HellkingApp") ||
                           userAgent.contains("okhttp");
            if (isApp) {
                log.info("모바일 앱 감지 - User-Agent: {}", userAgent);
                return true;
            }
        }
        
        // 4. 기존 10.0.2.2 로직도 유지 (에뮬레이터용)
        if (requestUrl.contains("10.0.2.2")) {
            log.info("모바일 앱 감지 - 에뮬레이터 IP: {}", requestUrl);
            return true;
        }
        
        log.info("웹 브라우저로 판단됨");
        return false;
    }
    
    /**
     * 모바일 앱용 콜백 처리 - JSP 리다이렉트 방식
     */
    private String handleMobileCallback(SocialUserVO socialUser, String provider, HttpSession session, HttpServletRequest request) {
        try {
            log.info("모바일 앱 콜백 처리 시작: provider={}, socialId={}", provider, socialUser.getSocialUserId());
            
            String deepLink;
            
            // 기존 소셜 계정 확인
            UserVO existingUser = userService.getUserBySocialId(socialUser.getProvider(), socialUser.getSocialUserId());
            
            if (existingUser != null && "ACTIVE".equals(existingUser.getStatus())) {
                // 기존 사용자 로그인 성공
                userService.setUserSession(existingUser, session);
                
                deepLink = "hellking://oauth/callback" +
                       "?success=true" +
                       "&provider=" + provider +
                       "&userNum=" + existingUser.getUserNum() +
                       "&userId=" + URLEncoder.encode(existingUser.getUserId(), "UTF-8") +
                       "&userName=" + URLEncoder.encode(existingUser.getUsername(), "UTF-8");
                
                log.info("기존 사용자 딥링크 생성 완료");
                log.info("딥링크 전체: {}", deepLink);
                
            } else {
                // 신규 사용자 - 계정 생성 필요
                log.info("신규 사용자 계정 생성 시작");
                UserVO newUser = userService.createSocialUser(socialUser);
                if (newUser != null) {
                    userService.setUserSession(newUser, session);
                    
                    deepLink = "hellking://oauth/callback" +
                           "?success=true" +
                           "&provider=" + provider +
                           "&userNum=" + newUser.getUserNum() +
                           "&userId=" + URLEncoder.encode(newUser.getUserId(), "UTF-8") +
                           "&userName=" + URLEncoder.encode(newUser.getUsername(), "UTF-8") +
                           "&newUser=true";
                    
                    log.info("신규 사용자 딥링크 생성 완료");
                    log.info("딥링크 전체: {}", deepLink);
                    
                } else {
                    throw new Exception("계정 생성에 실패했습니다.");
                }
            }
            
            System.out.println("=== 컨트롤러 디버깅 ===");
            System.out.println("deepLink 생성: " + deepLink);
            System.out.println("request에 설정 완료");
            System.out.println("JSP 페이지로 forward 시작");
            
            // 성공 시 JSP로 딥링크 전달
            request.setAttribute("deepLink", deepLink);
            session.setAttribute("deepLink", deepLink);
            return "oauth/callback";
            
        } catch (Exception e) {
            log.error("모바일 콜백 처리 실패: {}", e.getMessage(), e);
            try {
                String errorMessage = "로그인 처리 중 오류가 발생했습니다: " + e.getMessage();
                String errorDeepLink = "hellking://oauth/callback" +
                       "?success=false" +
                       "&error=" + URLEncoder.encode(errorMessage, "UTF-8");
                
                log.info("에러 딥링크 생성: {}", errorDeepLink);
                
                request.setAttribute("deepLink", errorDeepLink);
                return "oauth/callback";
                
            } catch (Exception encodingError) {
                String fallbackDeepLink = "hellking://oauth/callback?success=false&error=encoding_error";
                log.info("폴백 딥링크 생성: {}", fallbackDeepLink);
                
                request.setAttribute("deepLink", fallbackDeepLink);
                return "oauth/callback";
            }
        }
    }
    
    /**
     * 콜백 에러 처리 (웹/앱 구분)
     */
    private String handleCallbackError(String provider, String error, HttpServletRequest request) {
        log.error("=== {} 콜백 에러 처리 ===", provider);
        log.error("에러 내용: {}", error);
        log.error("요청 URL: {}", request.getRequestURL());
        log.error("파라미터: {}", request.getParameterMap());
        
        if (isFromMobileApp(request)) {
            String deepLink;
            try {
                deepLink = "hellking://oauth/callback" +
                           "?success=false" +
                           "&error=" + URLEncoder.encode(provider + " 로그인이 취소되었습니다.", "UTF-8");
            } catch (Exception e) {
                deepLink = "hellking://oauth/callback?success=false&error=login_cancelled";
            }
            
            log.info("에러 딥링크 생성: {}", deepLink);
            request.setAttribute("deepLink", deepLink);
            return "oauth/callback";
        } else {
            return "redirect:/user/login?error=oauth&message=" + provider + "_cancelled";
        }
    }
    
    // === 나머지 메서드들은 기존과 동일하게 유지 ===
    // processImprovedSocialLogin, showReconnectChoiceModal 등의 메서드들은 그대로 유지
    
    /**
     * 소셜 로그인 상태 확인 API (누락된 엔드포인트)
     */
    @GetMapping("/social-status")
    @ResponseBody
    public Map<String, Object> getSocialLoginStatus() {
        Map<String, Object> result = new HashMap<>();
        
        // 각 소셜 서비스 상태 확인
        Map<String, Boolean> available = new HashMap<>();
        available.put("naver", true);
        available.put("kakao", true); 
        available.put("google", true);
        
        result.put("available", available);
        result.put("status", "ok");
        
        return result;
    }
    
    /**
     * 개선된 소셜 로그인 처리 메서드 (실제 로그인 처리 구현)
     */
    private String processImprovedSocialLogin(SocialUserVO socialUser, HttpSession session, 
            RedirectAttributes rttr, String provider) {
        try {
            log.info("웹 소셜 로그인 처리 시작: provider={}, socialId={}", provider, socialUser.getSocialUserId());
            
            // 1. 기존 소셜 계정 확인
            UserVO existingUser = userService.getUserBySocialId(socialUser.getProvider(), socialUser.getSocialUserId());
            
            if (existingUser != null && "ACTIVE".equals(existingUser.getStatus())) {
                // 기존 사용자 로그인
                userService.setUserSession(existingUser, session);
                log.info("기존 소셜 사용자 로그인 성공: userId={}", existingUser.getUserId());
                rttr.addFlashAttribute("message", provider + " 로그인이 완료되었습니다.");
                return "redirect:/";
                
            } else if (existingUser != null && "INACTIVE".equals(existingUser.getStatus())) {
                // 비활성 계정 재활성화
                if (userService.reactivateUser(existingUser.getUserNum())) {
                    existingUser.setStatus("ACTIVE");
                    userService.setUserSession(existingUser, session);
                    log.info("소셜 계정 재활성화 로그인 성공: userId={}", existingUser.getUserId());
                    rttr.addFlashAttribute("message", "계정이 재활성화되었습니다. 다시 오신 것을 환영합니다!");
                    return "redirect:/";
                } else {
                    log.error("계정 재활성화 실패: socialId={}", socialUser.getSocialUserId());
                    rttr.addFlashAttribute("message", "계정 재활성화에 실패했습니다. 고객센터에 문의해주세요.");
                    return "redirect:/user/login";
                }
            }
            
            // 2. 이메일로 기존 계정 확인 (소셜 연동)
            if (socialUser.hasValidEmail()) {
                UserVO emailUser = userService.getUserByEmail(socialUser.getSocialEmail());
                
                if (emailUser != null && "ACTIVE".equals(emailUser.getStatus())) {
                    // 기존 이메일 계정에 소셜 연동
                    socialUser.setUserNum(emailUser.getUserNum());
                    if (userService.linkSocialAccount(socialUser)) {
                        userService.setUserSession(emailUser, session);
                        log.info("기존 계정에 소셜 연동 후 로그인: userId={}, provider={}", 
                                 emailUser.getUserId(), provider);
                        rttr.addFlashAttribute("message", provider + " 계정이 연동되었습니다.");
                        return "redirect:/";
                    } else {
                        log.warn("소셜 계정 연동 실패: email={}, provider={}", socialUser.getSocialEmail(), provider);
                        rttr.addFlashAttribute("message", "계정 연동에 실패했습니다.");
                        return "redirect:/user/login";
                    }
                } else if (emailUser != null && "INACTIVE".equals(emailUser.getStatus())) {
                    // 비활성 이메일 계정 재활성화 후 소셜 연동
                    if (userService.reactivateUser(emailUser.getUserNum())) {
                        socialUser.setUserNum(emailUser.getUserNum());
                        userService.linkSocialAccount(socialUser);
                        emailUser.setStatus("ACTIVE");
                        userService.setUserSession(emailUser, session);
                        log.info("비활성 계정 재활성화 후 소셜 연동: userId={}, provider={}", 
                                 emailUser.getUserId(), provider);
                        rttr.addFlashAttribute("message", "계정이 재활성화되고 " + provider + "가 연동되었습니다.");
                        return "redirect:/";
                    }
                }
            }
            
            // 3. 신규 소셜 계정 생성
            UserVO newUser = userService.createSocialUser(socialUser);
            if (newUser != null) {
                userService.setUserSession(newUser, session);
                log.info("신규 소셜 계정 생성 후 로그인: userId={}, provider={}", 
                         newUser.getUserId(), provider);
                rttr.addFlashAttribute("message", provider + " 계정으로 가입이 완료되었습니다. 환영합니다!");
                return "redirect:/";
            } else {
                log.error("신규 소셜 계정 생성 실패: provider={}, socialId={}", provider, socialUser.getSocialUserId());
                rttr.addFlashAttribute("message", "계정 생성에 실패했습니다. 다시 시도해주세요.");
                return "redirect:/user/login";
            }
            
        } catch (Exception e) {
            log.error("소셜 로그인 처리 중 오류: provider={}, error={}", provider, e.getMessage(), e);
            rttr.addFlashAttribute("message", "로그인 처리 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/user/login";
        }
    }
}