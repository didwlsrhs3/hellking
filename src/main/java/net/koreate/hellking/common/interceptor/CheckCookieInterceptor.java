package net.koreate.hellking.common.interceptor;

import java.util.Base64;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.user.vo.UserVO;

@Slf4j
public class CheckCookieInterceptor implements HandlerInterceptor {
    
    @Autowired
    private UserService userService;
    
    @Override
    public boolean preHandle(HttpServletRequest request, 
                             HttpServletResponse response, Object handler) throws Exception {
        
        HttpSession session = request.getSession();
        
        // 두 버전 모두 체크: 새 버전 (userNum) 또는 팀원 버전 (userInfo)
        if(session.getAttribute("userNum") != null || session.getAttribute("userInfo") != null) {
            log.info("이미 로그인된 상태");
            return true;
        }
        
        // Cookie 확인
        Cookie cookie = WebUtils.getCookie(request, "rememberme");
        if(cookie != null) {
            log.info("rememberme 쿠키 존재 : {} ", cookie.getName());
            
            String value = cookie.getValue();
            log.info("rememberme 쿠키 값 : {} ", value);
            
            // Decoding - Base64
            byte[] decode = Base64.getDecoder().decode(value.getBytes());
            String user_id = new String(decode);
            log.info("decoded user_id : {}" , user_id);
            
            // 통합 UserService 사용
            UserVO user = userService.getUserById(user_id);
            if(user != null) {
                log.info("session 정보 추가 : {}", user);
                
                // 양쪽 버전 모두 지원하도록 세션 설정
                session.setAttribute("userInfo", user); // 팀원 버전 호환
                session.setAttribute("userNum", user.getUserNum()); // 새 버전
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("username", user.getUsername());
            }
        }
        return true;
    }
}
