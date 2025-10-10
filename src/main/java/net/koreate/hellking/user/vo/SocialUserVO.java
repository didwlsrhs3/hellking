package net.koreate.hellking.user.vo;

import lombok.Data;
import java.util.Date;

/**
 * 소셜 로그인 사용자 정보 VO
 */
@Data
public class SocialUserVO {
    
    // === hk_social_users 테이블 매핑 ===
    private Long socialNum;        // social_num (Primary Key)
    private Long userNum;          // user_num (FK to hk_users)
    private String provider;       // provider (NAVER, KAKAO, GOOGLE)
    private String socialUserId;   // social_user_id (소셜 서비스의 사용자 ID)
    private Date createdAt;        // created_at (생성일)
    
    // === 소셜 API에서 받아온 추가 정보 (DB 저장 안됨) ===
    private String socialName;     // 소셜에서 받은 사용자 이름
    private String socialEmail;    // 소셜에서 받은 이메일
    private String socialProfileImage; // 소셜에서 받은 프로필 이미지 URL
    
    // === 유틸리티 메서드 ===
    
    /**
     * 프로바이더명을 대문자로 정규화
     */
    public void setProvider(String provider) {
        this.provider = provider != null ? provider.toUpperCase() : null;
    }
    
    /**
     * 소셜 이메일이 유효한지 확인
     */
    public boolean hasValidEmail() {
        return socialEmail != null && 
               !socialEmail.trim().isEmpty() && 
               socialEmail.contains("@") &&
               !socialEmail.endsWith("@kakao.local"); // 카카오 임시 이메일 제외
    }
    
    /**
     * 소셜 프로필 이미지가 있는지 확인
     */
    public boolean hasProfileImage() {
        return socialProfileImage != null && 
               !socialProfileImage.trim().isEmpty() &&
               (socialProfileImage.startsWith("http://") || socialProfileImage.startsWith("https://"));
    }
    
    /**
     * 임시 이메일인지 확인 (카카오 이메일 권한 없을 때)
     */
    public boolean isTemporaryEmail() {
        return socialEmail != null && 
               (socialEmail.startsWith("kakao_") || 
                socialEmail.startsWith("naver_") || 
                socialEmail.startsWith("google_")) &&
               socialEmail.endsWith(".local");
    }
    
    /**
     * 소셜 제공자 표시명 반환
     */
    public String getProviderDisplayName() {
        if (provider == null) return "알 수 없음";
        
        switch (provider.toUpperCase()) {
            case "NAVER": return "네이버";
            case "KAKAO": return "카카오";
            case "GOOGLE": return "구글";
            default: return provider;
        }
    }
    
    /**
     * 소셜 사용자 정보 유효성 검증
     */
    public boolean isValid() {
        return provider != null && 
               !provider.trim().isEmpty() &&
               socialUserId != null && 
               !socialUserId.trim().isEmpty() &&
               socialName != null && 
               !socialName.trim().isEmpty();
    }
    
    /**
     * 디버깅용 문자열 표현
     */
    @Override
    public String toString() {
        return String.format("SocialUserVO{provider='%s', socialUserId='%s', socialName='%s', socialEmail='%s', userNum=%d}", 
                           provider, socialUserId, socialName, socialEmail, userNum);
    }
}