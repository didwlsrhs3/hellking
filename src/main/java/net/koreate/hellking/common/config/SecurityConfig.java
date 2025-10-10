package net.koreate.hellking.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeRequests(auth -> auth
                // OAuth 콜백 URL들 허용
                .antMatchers("/oauth/**").permitAll()
                .antMatchers("/oauth/naver/callback").permitAll()
                .antMatchers("/oauth/kakao/callback").permitAll()
                .antMatchers("/oauth/google/callback").permitAll()
                
                // 회원가입, 로그인 페이지 허용
                .antMatchers("/user/login", "/user/join", "/user/findId", "/user/findPassword").permitAll()
                .antMatchers("/user/checkUserId", "/user/checkEmail", "/user/checkPhone").permitAll()
                .antMatchers("/user/sendSMS", "/user/verifySMS", "/user/sendEmail", "/user/verifyEmail").permitAll()
                .antMatchers("/user/findIdPost", "/user/findPasswordPost").permitAll()
                .antMatchers("/user/joinPost").permitAll()
                
                // 테스트 페이지 허용
                .antMatchers("/test/**").permitAll()
                
                // 정적 리소스 허용
                .antMatchers("/resources/**", "/css/**", "/js/**", "/images/**").permitAll()
                .antMatchers("/error/**").permitAll()
                
                // API 엔드포인트
                .antMatchers("/api/**").permitAll()
                
                // 홈페이지 허용
                .antMatchers("/", "/index").permitAll()
                
                // 나머지는 인증 필요
                .anyRequest().authenticated()
            )
            .formLogin(form -> form
                .loginPage("/user/login")
                .defaultSuccessUrl("/", true)
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/user/logout")
                .logoutSuccessUrl("/")
                .permitAll()
            )
            .csrf(csrf -> csrf
                // OAuth 콜백과 AJAX 요청에서 CSRF 비활성화
                .ignoringAntMatchers("/oauth/**", "/api/**", "/user/sendSMS", "/user/verifySMS", "/user/sendEmail", "/user/verifyEmail", "/test/**")
            )
            .sessionManagement(session -> session
                .maximumSessions(1)
                .maxSessionsPreventsLogin(false)
            );
            
        return http.build();
    }
}