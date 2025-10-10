package net.koreate.hellking.common.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * OAuth 소셜 로그인 과정에서의 세션 관리 설정
 */
@Configuration
public class OAuthSessionConfig implements WebMvcConfigurer {
    
    @Value("${oauth.session.timeout:3600}")
    private int oauthSessionTimeout; // 1시간 (초 단위)
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new OAuthSessionInterceptor())
                .addPathPatterns("/oauth/**");
    }
    
    /**
     * OAuth 관련 요청에서 세션 타임아웃을 동적으로 조정하는 인터셉터
     */
    private class OAuthSessionInterceptor implements HandlerInterceptor {
        
        @Override
        public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
            HttpSession session = request.getSession(false);
            
            if (session != null) {
                // OAuth 진행 중인지 확인
                boolean isOAuthInProgress = session.getAttribute("pendingSocialUser") != null ||
                                          session.getAttribute("socialChoiceData") != null ||
                                          request.getRequestURI().contains("/oauth/");
                
                if (isOAuthInProgress) {
                    // OAuth 진행 중일 때는 세션 타임아웃을 연장
                    session.setMaxInactiveInterval(oauthSessionTimeout);
                    
                    // OAuth 상태 추적을 위한 타임스탬프
                    session.setAttribute("oauthStartTime", System.currentTimeMillis());
                }
            }
            
            return true;
        }
        
        @Override
        public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
            // OAuth 완료 후 세션 타임아웃을 원래대로 복구
            if (request.getRequestURI().contains("/oauth/link-account") ||
                request.getRequestURI().contains("/oauth/login-existing") ||
                request.getRequestURI().contains("/oauth/create-new-account")) {
                
                HttpSession session = request.getSession(false);
                if (session != null) {
                    // 기본 세션 타임아웃으로 복구 (30분)
                    session.setMaxInactiveInterval(1800);
                    
                    // OAuth 관련 세션 데이터 정리
                    session.removeAttribute("pendingSocialUser");
                    session.removeAttribute("socialChoiceData");
                    session.removeAttribute("oauthStartTime");
                }
            }
        }
    }
}