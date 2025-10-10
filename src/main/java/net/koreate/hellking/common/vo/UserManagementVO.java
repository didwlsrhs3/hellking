package net.koreate.hellking.common.vo;

import lombok.Data;
import java.util.Date;

@Data
public class UserManagementVO {
    private Long userNum;
    private String userId;
    private String username;
    private String email;
    private String phone;
    private String userRole;
    private String status;
    private String accountType;
    private Date joinDate;
    private String profileImage;
    private Date birthDate;
    private String gender;
    
    // 추가 정보 (계산된 필드)
    private String formattedJoinDate;
    private int totalPasses;
    private int totalVisits;
    
    // 유틸리티 메서드들
    
    /**
     * 관리자 여부 확인
     */
    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(this.userRole);
    }
    
    /**
     * 활성 사용자 여부 확인
     */
    public boolean isActive() {
        return "ACTIVE".equals(this.status);
    }
    
    /**
     * 소셜 계정 여부 확인
     */
    public boolean isSocialAccount() {
        return "SOCIAL".equals(this.accountType);
    }
    
    /**
     * 프로필 이미지 경로 반환 (기본 이미지 처리)
     */
    public String getProfileImagePath() {
        if (profileImage == null || profileImage.trim().isEmpty()) {
            return "avatar1.png";
        }
        return profileImage;
    }
    
    /**
     * 상태 표시명 반환
     */
    public String getStatusDisplayName() {
        if (status == null) return "알 수 없음";
        
        switch (status.toUpperCase()) {
            case "ACTIVE": return "활성";
            case "INACTIVE": return "비활성";
            case "SUSPENDED": return "정지";
            case "DELETED": return "삭제";
            default: return status;
        }
    }
    
    /**
     * 역할 표시명 반환
     */
    public String getUserRoleDisplayName() {
        if (userRole == null) return "일반";
        
        switch (userRole.toUpperCase()) {
            case "ADMIN": return "관리자";
            case "USER": return "일반";
            default: return userRole;
        }
    }
    
    /**
     * 계정 유형 표시명 반환
     */
    public String getAccountTypeDisplayName() {
        if (accountType == null) return "일반";
        
        switch (accountType.toUpperCase()) {
            case "SOCIAL": return "소셜";
            case "REGULAR": return "일반";
            default: return accountType;
        }
    }
    
    /**
     * 유효한 이메일이 있는지 확인
     */
    public boolean hasValidEmail() {
        return email != null && !email.trim().isEmpty() && email.contains("@");
    }
    
    /**
     * 유효한 전화번호가 있는지 확인
     */
    public boolean hasValidPhone() {
        return phone != null && !phone.trim().isEmpty();
    }
    
    /**
     * 디버깅용 문자열 표현
     */
    @Override
    public String toString() {
        return String.format("UserManagementVO{userNum=%d, userId='%s', username='%s', status='%s', userRole='%s'}", 
                           userNum, userId, username, status, userRole);
    }
}