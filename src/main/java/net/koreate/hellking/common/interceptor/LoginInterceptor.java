package net.koreate.hellking.common.interceptor;

import java.util.Base64;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.user.vo.UserVO;

@Slf4j
public class LoginInterceptor implements HandlerInterceptor {
    
    @Override
    public void postHandle(HttpServletRequest request, 
                           HttpServletResponse response, 
                           Object handler,
                           ModelAndView modelAndView) throws Exception {
        
        String method = request.getMethod();
        log.info("전송방식 : {} " , method);
        
        if(method.equalsIgnoreCase("GET")) {
            log.info("get 요청 postHandle 종료");
            return;
        }
        
        // POST - 로그인 요청 처리 완료 후
        HttpSession session = request.getSession();
        
        // 두 버전 모두 지원: userInfo 또는 userNum 체크
        UserVO user = (UserVO)session.getAttribute("userInfo");
        Long userNum = (Long)session.getAttribute("userNum");
        
        if(user != null || userNum != null) {
            // 로그인 성공
            String rememberme = request.getParameter("rememberme");
            log.info("rememberme : {} " , rememberme);
            
            if(rememberme != null) {
                String user_id = null;
                
                if (user != null) {
                    user_id = user.getUserId(); // 새 통합 방식
                } else {
                    // userNum으로만 세션이 있는 경우는 거의 없지만 방어코드
                    user_id = (String) session.getAttribute("userId");
                }
                
                if (user_id != null) {
                    // Base64 인코딩
                    byte[] encodedId = Base64.getEncoder().encode(user_id.getBytes());
                    String encodedText = new String(encodedId);
                    
                    Cookie cookie = new Cookie("rememberme", encodedText);
                    cookie.setPath("/");
                    cookie.setMaxAge(60 * 60 * 24 * 15); // 15일
                    response.addCookie(cookie);
                    
                    log.info("Remember me 쿠키 설정 완료: {}", user_id);
                }
            }
        }
    }
}