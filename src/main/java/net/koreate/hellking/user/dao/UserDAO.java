package net.koreate.hellking.user.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.user.vo.UserVO;
import net.koreate.hellking.user.vo.UserAuthVO;
<<<<<<< HEAD
=======
import net.koreate.hellking.user.vo.SocialUserVO;
>>>>>>> b65c320 (Initial commit)
import java.util.Map;
import java.util.List;

@Mapper
public interface UserDAO {
    
    // === 기본 CRUD ===
<<<<<<< HEAD
    @Insert("INSERT INTO hk_users (user_id, username, email, phone, password, profile_image, birth_date, gender) " +
            "VALUES (#{userId}, #{username}, #{email}, #{phone}, #{password}, #{profileImage, jdbcType=VARCHAR}, #{birthDate, jdbcType=DATE}, #{gender, jdbcType=VARCHAR})")
    @Options(useGeneratedKeys = true, keyProperty = "userNum", keyColumn = "user_num")
    int insertUser(UserVO user);
    
    // 명시적 컬럼 매핑으로 수정
=======
    
    /**
     * 회원가입 - 통합 버전 (account_type 포함, NULL 값 처리 완성)
     */
    @Insert("INSERT INTO hk_users (user_id, username, email, phone, password, profile_image, birth_date, gender, account_type) " +
            "VALUES (#{userId}, #{username}, #{email, jdbcType=VARCHAR}, #{phone, jdbcType=VARCHAR}, #{password}, " +
            "#{profileImage, jdbcType=VARCHAR}, #{birthDate, jdbcType=DATE}, #{gender, jdbcType=VARCHAR}, #{accountType, jdbcType=VARCHAR})")
    @Options(useGeneratedKeys = true, keyProperty = "userNum", keyColumn = "user_num")
    int insertUser(UserVO user);
    
    /**
     * 팀원 버전 호환용 회원가입 메서드
     * @deprecated insertUser(UserVO) 사용 권장
     */
    @Insert("INSERT INTO hk_users (user_id, username, email, phone, password, profile_image, birth_date, gender, status, account_type) " +
            "VALUES (#{user_id}, #{username}, #{user_id}, #{phone, jdbcType=VARCHAR}, #{password}, #{profile_image, jdbcType=VARCHAR}, #{birth_date, jdbcType=DATE}, #{gender, jdbcType=VARCHAR}, #{status, jdbcType=VARCHAR}, 'REGULAR')")
    int memberJoin(UserVO vo);
    
    // === 사용자 조회 (명시적 컬럼 매핑 + account_type + USER_ROLE 추가) ===
    
>>>>>>> b65c320 (Initial commit)
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
<<<<<<< HEAD
        @Result(property = "status", column = "status")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status " +
=======
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status, account_type, user_role " +
>>>>>>> b65c320 (Initial commit)
            "FROM hk_users WHERE user_id = #{userId} AND status = 'ACTIVE'")
    UserVO selectByUserId(String userId);
    
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
<<<<<<< HEAD
        @Result(property = "status", column = "status")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status " +
            "FROM hk_users WHERE user_num = #{userNum}")
    UserVO selectByUserNum(Long userNum);
    
=======
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status, account_type, user_role " +
            "FROM hk_users WHERE user_num = #{userNum}")
    UserVO selectByUserNum(Long userNum);
    
    // === 팀원 버전 호환 메서드들 ===
    
    /**
     * 로그인 - 평문 비밀번호용 (팀원 버전 호환)
     * @deprecated selectByUserId 사용 후 BCrypt 검증 권장
     */
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status, account_type, user_role " +
            "FROM hk_users WHERE user_id = #{user_id} AND password = #{password}")
    UserVO login(@Param("user_id") String user_id, @Param("password") String password);
    
    /**
     * 팀원 버전 호환: ID로 사용자 검색
     * @deprecated selectByUserId 사용 권장
     */
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status, account_type, user_role " +
            "FROM hk_users WHERE user_id = #{user_id}")
    UserVO getUserById(String user_id);
    
    // === 이메일, 전화번호별 조회 (NULL 값 처리 강화 + USER_ROLE 추가) ===
    
>>>>>>> b65c320 (Initial commit)
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
<<<<<<< HEAD
        @Result(property = "status", column = "status")
    })
    @Select("SELECT * FROM hk_users WHERE email = #{email} AND status = 'ACTIVE'")
=======
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status, account_type, user_role " +
            "FROM hk_users WHERE email = #{email, jdbcType=VARCHAR} AND status = 'ACTIVE'")
>>>>>>> b65c320 (Initial commit)
    UserVO selectByEmail(String email);
    
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
<<<<<<< HEAD
        @Result(property = "status", column = "status")
    })
    @Select("SELECT * FROM hk_users WHERE phone = #{phone} AND status = 'ACTIVE'")
    UserVO selectByPhone(String phone);
    
    // 핵심 수정: NULL 값 처리를 위한 jdbcType 명시
    @Update("UPDATE hk_users SET " +
            "username = #{username}, " +
            "email = #{email}, " +
            "phone = #{phone}, " +
=======
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status, account_type, user_role " +
            "FROM hk_users WHERE phone = #{phone, jdbcType=VARCHAR} AND status = 'ACTIVE'")
    UserVO selectByPhone(String phone);
    
    // === 업데이트 (NULL 값 처리 완성) ===
    
    @Update("UPDATE hk_users SET " +
            "username = #{username}, " +
            "email = #{email, jdbcType=VARCHAR}, " +
            "phone = #{phone, jdbcType=VARCHAR}, " +
>>>>>>> b65c320 (Initial commit)
            "profile_image = #{profileImage, jdbcType=VARCHAR}, " +
            "birth_date = #{birthDate, jdbcType=DATE}, " +
            "gender = #{gender, jdbcType=VARCHAR} " +
            "WHERE user_num = #{userNum}")
    int updateUser(UserVO user);
    
    @Update("UPDATE hk_users SET password = #{password} WHERE user_num = #{userNum}")
    int updatePassword(@Param("userNum") Long userNum, @Param("password") String password);
    
    @Update("UPDATE hk_users SET status = 'INACTIVE' WHERE user_num = #{userNum}")
    int deactivateUser(Long userNum);
    
<<<<<<< HEAD
    // === 중복 체크 ===
    @Select("SELECT COUNT(*) FROM hk_users WHERE user_id = #{userId}")
    int checkDuplicateUserId(String userId);
    
    @Select("SELECT COUNT(*) FROM hk_users WHERE email = #{email}")
    int checkDuplicateEmail(String email);
    
    @Select("SELECT COUNT(*) FROM hk_users WHERE phone = #{phone}")
    int checkDuplicatePhone(String phone);
    
    // === 인증 관련 ===
=======
    /**
     * 팀원 버전 호환: 방문 시간 업데이트
     */
    @Update("UPDATE hk_users SET join_date = CURRENT_TIMESTAMP WHERE user_id = #{user_id}")
    void updateVistDate(String user_id);
    
    // === 중복 체크 (ACTIVE 계정만) - NULL 값 처리 강화 ===
    
    @Select("SELECT COUNT(*) FROM hk_users WHERE user_id = #{userId} AND status = 'ACTIVE'")
    int checkDuplicateUserIdActive(String userId);
    
    @Select("SELECT COUNT(*) FROM hk_users WHERE email = #{email, jdbcType=VARCHAR} AND status = 'ACTIVE'")
    int checkDuplicateEmailActive(String email);
    
    @Select("SELECT COUNT(*) FROM hk_users WHERE phone = #{phone, jdbcType=VARCHAR} AND status = 'ACTIVE'")
    int checkDuplicatePhoneActive(String phone);
    
    // === 기존 중복 체크 (모든 계정) - NULL 값 처리 강화 ===
    
    @Select("SELECT COUNT(*) FROM hk_users WHERE user_id = #{userId}")
    int checkDuplicateUserId(String userId);
    
    @Select("SELECT COUNT(*) FROM hk_users WHERE email = #{email, jdbcType=VARCHAR}")
    int checkDuplicateEmail(String email);
    
    @Select("SELECT COUNT(*) FROM hk_users WHERE phone = #{phone, jdbcType=VARCHAR}")
    int checkDuplicatePhone(String phone);
    
    // === 인증 관련 ===
    
>>>>>>> b65c320 (Initial commit)
    @Insert("INSERT INTO hk_user_auth (user_num, auth_type, auth_code, expire_time) " +
            "VALUES (#{userNum}, #{authType}, #{authCode}, #{expireTime})")
    int insertAuthCode(UserAuthVO auth);
    
    @Select("SELECT COUNT(*) FROM hk_user_auth " +
            "WHERE user_num = #{userNum} AND auth_code = #{authCode} AND expire_time >= SYSDATE AND is_verified = 'N'")
    int verifyAuthCode(@Param("userNum") Long userNum, @Param("authCode") String authCode);
    
    @Update("UPDATE hk_user_auth SET is_verified = 'Y' " +
            "WHERE user_num = #{userNum} AND auth_code = #{authCode}")
    int updateAuthVerified(@Param("userNum") Long userNum, @Param("authCode") String authCode);
    
    @Delete("DELETE FROM hk_user_auth WHERE user_num = #{userNum} AND auth_type = #{authType}")
    int deleteAuthCode(@Param("userNum") Long userNum, @Param("authType") String authType);
    
    // === 활성 패스권과 함께 조회 ===
<<<<<<< HEAD
=======
    
>>>>>>> b65c320 (Initial commit)
    @Select("SELECT u.*, up.end_date as pass_end_date, p.pass_name, up.status as pass_status " +
            "FROM hk_users u " +
            "LEFT JOIN hk_user_passes up ON u.user_num = up.user_num AND up.status = 'ACTIVE' AND up.end_date >= SYSDATE " +
            "LEFT JOIN hk_passes p ON up.pass_num = p.pass_num " +
            "WHERE u.user_num = #{userNum}")
    UserVO getUserWithActivePass(Long userNum);
    
<<<<<<< HEAD
    // === 아이디/패스워드 찾기 ===
    @Select("SELECT user_id FROM hk_users WHERE email = #{email} AND phone = #{phone} AND status = 'ACTIVE'")
    String findUserIdByEmailAndPhone(@Param("email") String email, @Param("phone") String phone);
    
    @Select("SELECT user_num FROM hk_users WHERE user_id = #{userId} AND email = #{email} AND status = 'ACTIVE'")
    Long findUserNumForPasswordReset(@Param("userId") String userId, @Param("email") String email);
    
    // 디버깅용 메서드 (임시)
    @Select("SELECT user_num, user_id, username FROM hk_users WHERE user_id = #{userId}")
    Map<String, Object> selectUserDebugInfo(String userId);
=======
    // === 아이디/패스워드 찾기 (NULL 값 처리 강화) ===
    
    @Select("SELECT user_id FROM hk_users WHERE email = #{email, jdbcType=VARCHAR} AND phone = #{phone, jdbcType=VARCHAR} AND status = 'ACTIVE'")
    String findUserIdByEmailAndPhone(@Param("email") String email, @Param("phone") String phone);
    
    @Select("SELECT user_num FROM hk_users WHERE user_id = #{userId} AND email = #{email, jdbcType=VARCHAR} AND status = 'ACTIVE'")
    Long findUserNumForPasswordReset(@Param("userId") String userId, @Param("email") String email);
    
    /**
     * 이메일로만 사용자 아이디 찾기
     */
    @Select("SELECT user_id FROM hk_users WHERE email = #{email, jdbcType=VARCHAR} AND status = 'ACTIVE'")
    String findUserIdByEmail(String email);

    /**
     * 휴대폰번호로만 사용자 아이디 찾기
     */
    @Select("SELECT user_id FROM hk_users WHERE phone = #{phone, jdbcType=VARCHAR} AND status = 'ACTIVE'")
    String findUserIdByPhone(String phone);
    
    // === 관리자용 ===
    
    @Select("SELECT * FROM hk_users ORDER BY join_date DESC")
    List<UserVO> getMemberList();
    
    @Update("UPDATE hk_users SET status = #{status} WHERE user_num = #{userNum}")
    void deleteYN(UserVO vo);
    
    // === 디버깅용 ===
    
    @Select("SELECT user_num, user_id, username FROM hk_users WHERE user_id = #{userId}")
    Map<String, Object> selectUserDebugInfo(String userId);
    
    // === 소셜 로그인 관련 ===

    /**
     * 소셜 사용자 정보 등록
     */
    @Insert("INSERT INTO hk_social_users (user_num, provider, social_user_id) " +
            "VALUES (#{userNum}, #{provider}, #{socialUserId})")
    @Options(useGeneratedKeys = true, keyProperty = "socialNum", keyColumn = "social_num")
    int insertSocialUser(SocialUserVO socialUser);

    /**
     * 소셜 ID와 제공자로 소셜 사용자 정보 조회
     */
    @Results({
        @Result(property = "socialNum", column = "social_num"),
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "provider", column = "provider"),
        @Result(property = "socialUserId", column = "social_user_id"),
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT social_num, user_num, provider, social_user_id, created_at " +
            "FROM hk_social_users " +
            "WHERE provider = #{provider} AND social_user_id = #{socialUserId}")
    SocialUserVO selectBySocialId(@Param("provider") String provider, @Param("socialUserId") String socialUserId);

    /**
     * 사용자 번호로 소셜 계정 목록 조회
     */
    @Results({
        @Result(property = "socialNum", column = "social_num"),
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "provider", column = "provider"),
        @Result(property = "socialUserId", column = "social_user_id"),
        @Result(property = "createdAt", column = "created_at")
    })
    @Select("SELECT social_num, user_num, provider, social_user_id, created_at " +
            "FROM hk_social_users " +
            "WHERE user_num = #{userNum}")
    List<SocialUserVO> selectSocialAccountsByUserNum(Long userNum);

    /**
     * 소셜 계정 연동 해제
     */
    @Delete("DELETE FROM hk_social_users WHERE user_num = #{userNum} AND provider = #{provider}")
    int deleteSocialUser(@Param("userNum") Long userNum, @Param("provider") String provider);

    /**
     * 소셜 계정으로 사용자 정보 조회 (JOIN) - ACTIVE만 + USER_ROLE 추가
     */
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT u.user_num, u.user_id, u.username, u.email, u.phone, u.password, " +
            "u.profile_image, u.birth_date, u.gender, u.join_date, u.status, u.account_type, u.user_role " +
            "FROM hk_users u " +
            "INNER JOIN hk_social_users s ON u.user_num = s.user_num " +
            "WHERE s.provider = #{provider} AND s.social_user_id = #{socialUserId} AND u.status = 'ACTIVE'")
    UserVO selectUserBySocialId(@Param("provider") String provider, @Param("socialUserId") String socialUserId);

    /**
     * 소셜 로그인용 사용자 등록 (account_type = 'SOCIAL') - NULL 값 처리 완성
     */
    @Insert("INSERT INTO hk_users (user_id, username, email, phone, password, profile_image, birth_date, gender, account_type) " +
            "VALUES (#{userId}, #{username}, #{email, jdbcType=VARCHAR}, #{phone, jdbcType=VARCHAR}, " +
            "#{password}, #{profileImage, jdbcType=VARCHAR}, #{birthDate, jdbcType=DATE}, #{gender, jdbcType=VARCHAR}, 'SOCIAL')")
    @Options(useGeneratedKeys = true, keyProperty = "userNum", keyColumn = "user_num")
    int insertSocialOnlyUser(UserVO user);
    
    /**
     * 계정 재활성화 (INACTIVE → ACTIVE)
     */
    @Update("UPDATE hk_users SET status = 'ACTIVE', join_date = CURRENT_TIMESTAMP WHERE user_num = #{userNum}")
    int reactivateUser(Long userNum);

    /**
     * 소셜 ID로 사용자 조회 (비활성 계정 포함) - 가장 중요! + USER_ROLE 추가
     */
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT u.user_num, u.user_id, u.username, u.email, u.phone, u.password, " +
            "u.profile_image, u.birth_date, u.gender, u.join_date, u.status, u.account_type, u.user_role " +
            "FROM hk_users u " +
            "INNER JOIN hk_social_users s ON u.user_num = s.user_num " +
            "WHERE s.provider = #{provider} AND s.social_user_id = #{socialUserId}")
    UserVO selectUserBySocialIdIncludeInactive(@Param("provider") String provider, @Param("socialUserId") String socialUserId);

    /**
     * 이메일로 사용자 조회 (비활성 계정 포함) + USER_ROLE 추가
     */
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status, account_type, user_role " +
            "FROM hk_users WHERE email = #{email, jdbcType=VARCHAR}")
    UserVO selectByEmailIncludeInactive(String email);
    
    // === 탈퇴 재가입 시스템용 추가 메서드 ===
    
    /**
     * 이메일로 탈퇴한 계정 찾기 (INACTIVE 상태만) + USER_ROLE 추가
     */
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status, account_type, user_role " +
            "FROM hk_users WHERE email = #{email, jdbcType=VARCHAR} AND status = 'INACTIVE'")
    UserVO findInactiveUserByEmail(String email);

    /**
     * 아이디로 탈퇴한 계정 찾기 (INACTIVE 상태만) + USER_ROLE 추가
     */
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status, account_type, user_role " +
            "FROM hk_users WHERE user_id = #{userId} AND status = 'INACTIVE'")
    UserVO findInactiveUserById(String userId);
    
    /**
     * 소셜 ID 패턴으로 사용자 검색 (재활성화 계정 찾기용) + USER_ROLE 추가
     */
    @Results({
        @Result(property = "userNum", column = "user_num"),
        @Result(property = "userId", column = "user_id"),
        @Result(property = "username", column = "username"),
        @Result(property = "email", column = "email"),
        @Result(property = "phone", column = "phone"),
        @Result(property = "password", column = "password"),
        @Result(property = "profileImage", column = "profile_image"),
        @Result(property = "birthDate", column = "birth_date"),
        @Result(property = "gender", column = "gender"),
        @Result(property = "joinDate", column = "join_date"),
        @Result(property = "status", column = "status"),
        @Result(property = "accountType", column = "account_type"),
        @Result(property = "userRole", column = "user_role")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status, account_type, user_role " +
            "FROM hk_users WHERE user_id LIKE #{pattern} AND status = 'INACTIVE' ORDER BY join_date DESC")
    UserVO findUserByIdPattern(String pattern);
>>>>>>> b65c320 (Initial commit)
}