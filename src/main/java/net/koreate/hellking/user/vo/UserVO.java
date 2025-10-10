package net.koreate.hellking.user.vo;

import lombok.Data;
import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;

<<<<<<< HEAD
@Data
public class UserVO {
    private Long userNum;        
    private String userId;       
    private String username;
    private String email;
    private String phone;
    private String password;
    private String profileImage;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthDate;      // 이 부분에 어노테이션 추가
    
    private String gender;
    private Date joinDate;
    private String status;
    
    // 조인용 추가 필드
    private String passName;     
    private Date passEndDate;    
    private String passStatus;   
=======
/**
 * 통합 사용자 VO 클래스 - account_type 필드 추가
 * - 팀원 버전과 호환성 유지
 * - 소셜 계정 관리 기능 강화
 */
@Data
public class UserVO {
    
    // === 기본 사용자 정보 ===
    private Long userNum;        // user_num (Primary Key)
    private String userId;       // user_id (로그인용 아이디)
    private String username;     // username (실명)
    private String email;        // email (분리된 이메일 필드)
    private String phone;        // phone (전화번호)
    private String password;     // password (BCrypt 암호화)
    private String profileImage; // profile_image (프로필 이미지)
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date birthDate;      // birth_date (생년월일)
    
    private String gender;       // gender (성별: M/F)
    private Date joinDate;       // join_date (가입일)
    private String status;       // status (계정 상태: ACTIVE/INACTIVE)
    
    // ✅ 새로 추가: 계정 유형 관리
    private String accountType;  // account_type (REGULAR/SOCIAL)
    
    // === 팀원 버전 호환성을 위한 메서드 ===
    
    /**
     * 팀원 버전 호환: user_id getter
     * @deprecated getUserId() 사용 권장
     */
    public String getUser_id() {
        return this.userId;
    }
    
    /**
     * 팀원 버전 호환: user_id setter  
     * @deprecated setUserId() 사용 권장
     */
    public void setUser_id(String userId) {
        this.userId = userId;
    }
    
    /**
     * 팀원 버전 호환: user_num getter
     * @deprecated getUserNum() 사용 권장
     */
    public Long getUser_num() {
        return this.userNum;
    }
    
    /**
     * 팀원 버전 호환: user_num setter
     * @deprecated setUserNum() 사용 권장
     */
    public void setUser_num(Long userNum) {
        this.userNum = userNum;
    }
    
    /**
     * 팀원 버전 호환: profile_image getter
     * @deprecated getProfileImage() 사용 권장
     */
    public String getProfile_image() {
        return this.profileImage;
    }
    
    /**
     * 팀원 버전 호환: profile_image setter
     * @deprecated setProfileImage() 사용 권장  
     */
    public void setProfile_image(String profileImage) {
        this.profileImage = profileImage;
    }
    
    /**
     * 팀원 버전 호환: birth_date getter
     * @deprecated getBirthDate() 사용 권장
     */
    public Date getBirth_date() {
        return this.birthDate;
    }
    
    /**
     * 팀원 버전 호환: birth_date setter
     * @deprecated setBirthDate() 사용 권장
     */
    public void setBirth_date(Date birthDate) {
        this.birthDate = birthDate;
    }
    
    /**
     * 팀원 버전 호환: join_date getter
     * @deprecated getJoinDate() 사용 권장
     */
    public Date getJoin_date() {
        return this.joinDate;
    }
    
    /**
     * 팀원 버전 호환: join_date setter
     * @deprecated setJoinDate() 사용 권장
     */
    public void setJoin_date(Date joinDate) {
        this.joinDate = joinDate;
    }
    
    // === 조인용 추가 필드 (패스권 정보 등) ===
    private String passName;     // 활성 패스권 이름
    private Date passEndDate;    // 패스권 만료일
    private String passStatus;   // 패스권 상태
    
    // === 계정 유형 관리 메서드 ===
    
    /**
     * 소셜 로그인 전용 계정인지 확인
     */
    public boolean isSocialUser() {
        return "SOCIAL".equals(this.accountType);
    }
    
    /**
     * 일반 계정인지 확인
     */
    public boolean isRegularUser() {
        return "REGULAR".equals(this.accountType);
    }
    
    /**
     * 계정 유형 설정 (대문자로 정규화)
     */
    public void setAccountType(String accountType) {
        this.accountType = accountType != null ? accountType.toUpperCase() : "REGULAR";
    }
    
    /**
     * 소셜 전용 계정 여부 확인 (비밀번호 기반)
     * @deprecated isSocialUser() 사용 권장 (account_type 기반)
     */
    public boolean isSocialOnlyAccount() {
        return password != null && password.startsWith("SOCIAL_");
    }
    
    // === 유틸리티 메서드 ===
    
    /**
     * 관리자 권한 체크
     */
    public boolean isAdmin() {
    	return "ADMIN".equalsIgnoreCase(userRole);
    }
    
    /**
     * 활성 계정 체크
     */
    public boolean isActive() {
        return "ACTIVE".equals(this.status);
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
     * 유효한 이메일이 있는지 확인 (NULL 값 고려)
     */
    public boolean hasValidEmail() {
        return email != null && !email.trim().isEmpty() && email.contains("@");
    }
    
    /**
     * 유효한 전화번호가 있는지 확인 (NULL 값 고려)
     */
    public boolean hasValidPhone() {
        return phone != null && !phone.trim().isEmpty();
    }
    
    /**
     * 계정 유형별 표시명 반환
     */
    public String getAccountTypeDisplayName() {
        if (accountType == null) return "일반";
        
        switch (accountType) {
            case "SOCIAL": return "소셜";
            case "REGULAR": return "일반";
            default: return accountType;
        }
    }
    
    /**
     * 디버깅용 문자열 표현 - profileImage 필드 포함
     */
    @Override
    public String toString() {
        return String.format("UserVO{userNum=%d, userId='%s', username='%s', email='%s', profileImage='%s', accountType='%s', status='%s'}", 
                           userNum, userId, username, email, profileImage, accountType, status);
    }
    
    private String statusMessage; // 상태 메시지용 임시 필드 (DB 저장 안함)
    
    // getter, setter
    public String getStatusMessage() { return statusMessage; }
    public void setStatusMessage(String statusMessage) { this.statusMessage = statusMessage; }
    
    private String userRole;     // USER_ROLE 컬럼 매핑용

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }


>>>>>>> b65c320 (Initial commit)
}