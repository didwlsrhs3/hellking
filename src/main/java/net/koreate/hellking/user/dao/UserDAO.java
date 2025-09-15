package net.koreate.hellking.user.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.user.vo.UserVO;
import net.koreate.hellking.user.vo.UserAuthVO;
import java.util.Map;
import java.util.List;

@Mapper
public interface UserDAO {
    
    // === 기본 CRUD ===
    @Insert("INSERT INTO hk_users (user_id, username, email, phone, password, profile_image, birth_date, gender) " +
            "VALUES (#{userId}, #{username}, #{email}, #{phone}, #{password}, #{profileImage}, #{birthDate}, #{gender})")
    @Options(useGeneratedKeys = true, keyProperty = "userNum", keyColumn = "user_num")
    int insertUser(UserVO user);
    
    // 명시적 컬럼 매핑으로 수정
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
        @Result(property = "status", column = "status")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status " +
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
        @Result(property = "status", column = "status")
    })
    @Select("SELECT user_num, user_id, username, email, phone, password, profile_image, birth_date, gender, join_date, status " +
            "FROM hk_users WHERE user_num = #{userNum}")
    UserVO selectByUserNum(Long userNum);
    
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
        @Result(property = "status", column = "status")
    })
    @Select("SELECT * FROM hk_users WHERE email = #{email} AND status = 'ACTIVE'")
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
        @Result(property = "status", column = "status")
    })
    @Select("SELECT * FROM hk_users WHERE phone = #{phone} AND status = 'ACTIVE'")
    UserVO selectByPhone(String phone);
    
    @Update("UPDATE hk_users SET username = #{username}, email = #{email}, phone = #{phone}, " +
            "profile_image = #{profileImage}, birth_date = #{birthDate}, gender = #{gender} " +
            "WHERE user_num = #{userNum}")
    int updateUser(UserVO user);
    
    @Update("UPDATE hk_users SET password = #{password} WHERE user_num = #{userNum}")
    int updatePassword(@Param("userNum") Long userNum, @Param("password") String password);
    
    @Update("UPDATE hk_users SET status = 'INACTIVE' WHERE user_num = #{userNum}")
    int deactivateUser(Long userNum);
    
    // === 중복 체크 ===
    @Select("SELECT COUNT(*) FROM hk_users WHERE user_id = #{userId}")
    int checkDuplicateUserId(String userId);
    
    @Select("SELECT COUNT(*) FROM hk_users WHERE email = #{email}")
    int checkDuplicateEmail(String email);
    
    @Select("SELECT COUNT(*) FROM hk_users WHERE phone = #{phone}")
    int checkDuplicatePhone(String phone);
    
    // === 인증 관련 ===
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
    @Select("SELECT u.*, up.end_date as pass_end_date, p.pass_name, up.status as pass_status " +
            "FROM hk_users u " +
            "LEFT JOIN hk_user_passes up ON u.user_num = up.user_num AND up.status = 'ACTIVE' AND up.end_date >= SYSDATE " +
            "LEFT JOIN hk_passes p ON up.pass_num = p.pass_num " +
            "WHERE u.user_num = #{userNum}")
    UserVO getUserWithActivePass(Long userNum);
    
    // === 아이디/패스워드 찾기 ===
    @Select("SELECT user_id FROM hk_users WHERE email = #{email} AND phone = #{phone} AND status = 'ACTIVE'")
    String findUserIdByEmailAndPhone(@Param("email") String email, @Param("phone") String phone);
    
    @Select("SELECT user_num FROM hk_users WHERE user_id = #{userId} AND email = #{email} AND status = 'ACTIVE'")
    Long findUserNumForPasswordReset(@Param("userId") String userId, @Param("email") String email);
    
    // 디버깅용 메서드 (임시)
    @Select("SELECT user_num, user_id, username FROM hk_users WHERE user_id = #{userId}")
    Map<String, Object> selectUserDebugInfo(String userId);
}