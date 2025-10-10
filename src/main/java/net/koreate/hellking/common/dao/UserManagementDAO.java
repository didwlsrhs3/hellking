package net.koreate.hellking.common.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.common.vo.UserManagementVO;
import java.util.List;
import java.util.Map;

@Mapper
public interface UserManagementDAO {
    
    /**
     * 회원 목록 조회 (페이징) - 명시적 alias 지정
     */
    @Select("SELECT * FROM (" +
            "SELECT ROWNUM rnum, u.* FROM (" +
            "SELECT user_num as userNum, user_id as userId, username, email, phone, " +
            "user_role as userRole, status, account_type as accountType, join_date as joinDate, " +
            "profile_image as profileImage, birth_date as birthDate, gender " +
            "FROM hk_users " +
            "ORDER BY join_date DESC" +
            ") u WHERE ROWNUM <= #{endRow}" +
            ") WHERE rnum >= #{startRow}")
    List<UserManagementVO> getUserList(@Param("startRow") int startRow, @Param("endRow") int endRow);
    
    /**
     * 전체 회원 수
     */
    @Select("SELECT COUNT(*) FROM hk_users")
    int getTotalUserCount();
    
    /**
     * 검색된 회원 목록 - 명시적 alias 지정
     */
    @Select("SELECT * FROM (" +
            "SELECT ROWNUM rnum, u.* FROM (" +
            "SELECT user_num as userNum, user_id as userId, username, email, phone, " +
            "user_role as userRole, status, account_type as accountType, join_date as joinDate, " +
            "profile_image as profileImage, birth_date as birthDate, gender " +
            "FROM hk_users " +
            "WHERE (user_id LIKE '%' || #{keyword} || '%' " +
            "OR username LIKE '%' || #{keyword} || '%' " +
            "OR email LIKE '%' || #{keyword} || '%') " +
            "ORDER BY join_date DESC" +
            ") u WHERE ROWNUM <= #{endRow}" +
            ") WHERE rnum >= #{startRow}")
    List<UserManagementVO> searchUsers(@Param("keyword") String keyword, 
                                     @Param("startRow") int startRow, 
                                     @Param("endRow") int endRow);
    
    /**
     * 검색된 회원 수
     */
    @Select("SELECT COUNT(*) FROM hk_users " +
            "WHERE (user_id LIKE '%' || #{keyword} || '%' " +
            "OR username LIKE '%' || #{keyword} || '%' " +
            "OR email LIKE '%' || #{keyword} || '%')")
    int getSearchUserCount(@Param("keyword") String keyword);
    
    /**
     * 회원 상세 조회 - 명시적 alias 지정
     */
    @Select("SELECT user_num as userNum, user_id as userId, username, email, phone, " +
            "user_role as userRole, status, account_type as accountType, join_date as joinDate, " +
            "profile_image as profileImage, birth_date as birthDate, gender " +
            "FROM hk_users WHERE user_num = #{userNum, jdbcType=NUMERIC}")
    UserManagementVO getUserDetail(@Param("userNum") Long userNum);
    
    /**
     * 회원 상태 변경
     */
    @Update("UPDATE hk_users SET status = #{status} WHERE user_num = #{userNum, jdbcType=NUMERIC}")
    int updateUserStatus(@Param("userNum") Long userNum, @Param("status") String status);
    
    /**
     * 회원 역할 변경
     */
    @Update("UPDATE hk_users SET user_role = #{userRole} WHERE user_num = #{userNum, jdbcType=NUMERIC}")
    int updateUserRole(@Param("userNum") Long userNum, @Param("userRole") String userRole);
    
    /**
     * 회원 삭제 (실제로는 상태 변경)
     */
    @Update("UPDATE hk_users SET status = 'DELETED' WHERE user_num = #{userNum, jdbcType=NUMERIC}")
    int deleteUser(@Param("userNum") Long userNum);
    
    /**
     * 회원의 패스권 개수 - jdbcType 명시
     */
    @Select("SELECT COUNT(*) FROM hk_user_passes WHERE user_num = #{userNum, jdbcType=NUMERIC} AND status = 'ACTIVE'")
    int getUserPassCount(@Param("userNum") Long userNum);
    
    /**
     * 회원의 방문 횟수 - jdbcType 명시
     */
    @Select("SELECT COUNT(*) FROM hk_qr_visits WHERE user_num = #{userNum, jdbcType=NUMERIC}")
    int getUserVisitCount(@Param("userNum") Long userNum);
    
    /**
     * 상태별 회원 수 통계
     */
    @Select("SELECT status, COUNT(*) as count FROM hk_users GROUP BY status")
    List<Map<String, Object>> getUserStatusStats();
}