package net.koreate.hellking.qr.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.qr.vo.QRVisitVO;
import net.koreate.hellking.pass.vo.UserPassVO;
import net.koreate.hellking.chain.vo.ChainVO;
import java.util.List;
import java.util.Map;

@Mapper
public interface QRDAO {
    
    // === 방문 기록 관리 ===
<<<<<<< HEAD
    @Insert("INSERT INTO hk_qr_visits (user_num, chain_num, result, failure_reason) " +
            "VALUES (#{userNum}, #{chainNum}, #{result}, #{failureReason})")
    @Options(useGeneratedKeys = true, keyProperty = "visitNum")
    int insertVisit(QRVisitVO visit);
    
    @Select("SELECT v.*, u.user_id, u.username, c.chain_name, c.address as chain_address, cc.chain_code " +
            "FROM hk_qr_visits v " +
            "JOIN hk_users u ON v.user_num = u.user_num " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
=======
    // 방문 기록 삽입
    @Insert("INSERT INTO hk_qr_visits (user_num, chain_num, result, failure_reason) " +
            "VALUES (#{userNum}, #{chainNum}, #{result}, #{failureReason, jdbcType=VARCHAR})")
    int insertVisit(QRVisitVO visit);
    
    // 사용자별 방문 기록 조회 (명시적 alias 적용)
    @Select("SELECT " +
            "v.visit_num as visitNum, " +
            "v.user_num as userNum, " +
            "v.chain_num as chainNum, " +
            "v.visit_time as visitTime, " +
            "v.result as result, " +
            "v.failure_reason as failureReason, " +
            "u.user_id as userId, " +
            "u.username as username, " +
            "COALESCE(c.chain_name, '알 수 없는 가맹점') as chainName, " +
            "COALESCE(c.address, '') as chainAddress, " +
            "COALESCE(cc.chain_code, '') as chainCode " +
            "FROM hk_qr_visits v " +
            "JOIN hk_users u ON v.user_num = u.user_num " +
            "LEFT JOIN hk_chains c ON v.chain_num = c.chain_num " +
>>>>>>> b65c320 (Initial commit)
            "LEFT JOIN hk_chain_codes cc ON c.chain_num = cc.chain_num " +
            "WHERE v.user_num = #{userNum} " +
            "ORDER BY v.visit_time DESC")
    List<QRVisitVO> selectVisitsByUserNum(Long userNum);
    
<<<<<<< HEAD
    // Oracle ROWNUM 사용으로 수정
    @Select("SELECT * FROM (" +
            "SELECT v.*, u.user_id, u.username, c.chain_name, c.address as chain_address " +
=======
    // 가맹점별 최근 방문 기록 조회 (명시적 alias 적용)
    @Select("SELECT * FROM (" +
            "SELECT " +
            "v.visit_num as visitNum, " +
            "v.user_num as userNum, " +
            "v.chain_num as chainNum, " +
            "v.visit_time as visitTime, " +
            "v.result as result, " +
            "v.failure_reason as failureReason, " +
            "u.user_id as userId, " +
            "u.username as username, " +
            "c.chain_name as chainName, " +
            "c.address as chainAddress " +
>>>>>>> b65c320 (Initial commit)
            "FROM hk_qr_visits v " +
            "JOIN hk_users u ON v.user_num = u.user_num " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "WHERE v.chain_num = #{chainNum} " +
            "ORDER BY v.visit_time DESC" +
            ") WHERE ROWNUM <= #{limit}")
    List<QRVisitVO> selectRecentVisitsByChain(@Param("chainNum") Long chainNum, @Param("limit") int limit);
    
<<<<<<< HEAD
    // Oracle TRUNC 및 SYSDATE 사용으로 수정
    @Select("SELECT v.*, u.user_id, u.username, c.chain_name " +
=======
    // 오늘 전체 방문 기록 조회 (명시적 alias 적용)
    @Select("SELECT " +
            "v.visit_num as visitNum, " +
            "v.user_num as userNum, " +
            "v.chain_num as chainNum, " +
            "v.visit_time as visitTime, " +
            "v.result as result, " +
            "v.failure_reason as failureReason, " +
            "u.user_id as userId, " +
            "u.username as username, " +
            "c.chain_name as chainName " +
>>>>>>> b65c320 (Initial commit)
            "FROM hk_qr_visits v " +
            "JOIN hk_users u ON v.user_num = u.user_num " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "WHERE TRUNC(v.visit_time) = TRUNC(SYSDATE) " +
            "ORDER BY v.visit_time DESC")
    List<QRVisitVO> selectTodayVisits();
    
    // === 활성 패스권 조회 ===
<<<<<<< HEAD
    @Select("SELECT up.*, p.pass_name, u.username, u.user_id " +
            "FROM hk_user_passes up " +
            "JOIN hk_passes p ON up.pass_num = p.pass_num " +
            "JOIN hk_users u ON up.user_num = u.user_num " +
            "WHERE up.user_num = #{userNum} AND up.status = 'ACTIVE' AND up.end_date >= SYSDATE " +
            "ORDER BY up.end_date")
    List<UserPassVO> selectActivePassesByUserNum(Long userNum);
    
    // === 가맹점 코드로 조회 ===
    @Select("SELECT c.*, cc.chain_code " +
            "FROM hk_chains c " +
            "JOIN hk_chain_codes cc ON c.chain_num = cc.chain_num " +
            "WHERE cc.chain_code = #{chainCode} AND cc.is_active = 'Y'")
=======
    @Select("SELECT " +
            "up.user_pass_num as userPassNum, " +
            "up.user_num as userNum, " +
            "up.pass_num as passNum, " +
            "up.status as status, " +
            "up.start_date as startDate, " +
            "up.end_date as endDate, " +
            "up.created_at as createdAt, " +
            "p.pass_name as passName, " +
            "p.price as price, " +
            "p.duration_days as durationDays, " +
            "u.username as username, " +
            "u.user_id as userId " +
            "FROM hk_user_passes up " +
            "JOIN hk_passes p ON up.pass_num = p.pass_num " +
            "JOIN hk_users u ON up.user_num = u.user_num " +
            "WHERE up.user_num = #{userNum, jdbcType=NUMERIC} " +
            "AND up.status = 'ACTIVE' AND up.end_date >= SYSDATE " +
            "ORDER BY up.end_date")
    List<UserPassVO> selectActivePassesByUserNum(Long userNum);
    
    // === 가맹점 코드로 조회 (명시적 alias 매핑) ===
    @Select("SELECT " +
            "c.chain_num as chainNum, " +
            "c.chain_name as chainName, " +
            "c.address as address, " +
            "c.phone as phone, " +
            "c.description as description, " +
            "c.image_path as imagePath, " +
            "c.created_at as createdAt, " +
            "c.latitude as latitude, " +
            "c.longitude as longitude, " +
            "cc.chain_code as chainCode, " +
            "cc.is_active as isActive " +
            "FROM hk_chains c " +
            "JOIN hk_chain_codes cc ON c.chain_num = cc.chain_num " +
            "WHERE UPPER(TRIM(cc.chain_code)) = UPPER(TRIM(#{chainCode})) " +
            "AND cc.is_active = 'Y'")
>>>>>>> b65c320 (Initial commit)
    ChainVO selectChainByCode(String chainCode);
    
    // === 통계 조회 ===
    @Select("SELECT COUNT(*) FROM hk_qr_visits WHERE user_num = #{userNum} AND result = 'SUCCESS'")
    int getTotalSuccessVisitCount(Long userNum);
    
    @Select("SELECT COUNT(*) FROM hk_qr_visits WHERE user_num = #{userNum}")
    int getTotalVisitCount(Long userNum);
    
    @Select("SELECT COUNT(DISTINCT chain_num) FROM hk_qr_visits WHERE user_num = #{userNum} AND result = 'SUCCESS'")
    int getVisitedChainCount(Long userNum);
    
<<<<<<< HEAD
    // Oracle ROWNUM 사용으로 수정
    @Select("SELECT * FROM (" +
            "SELECT c.chain_name, COUNT(*) as visit_count " +
=======
    // 인기 가맹점 순위 (차트용 - 명시적 alias 적용)
    @Select("SELECT * FROM (" +
            "SELECT " +
            "c.chain_name as chain_name, " +
            "COUNT(*) as visit_count " +
>>>>>>> b65c320 (Initial commit)
            "FROM hk_qr_visits v " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "WHERE v.user_num = #{userNum} AND v.result = 'SUCCESS' " +
            "GROUP BY c.chain_num, c.chain_name " +
<<<<<<< HEAD
            "ORDER BY visit_count DESC" +
=======
            "ORDER BY COUNT(*) DESC" +  // <- COUNT(*) 직접 사용
>>>>>>> b65c320 (Initial commit)
            ") WHERE ROWNUM <= 5")
    List<Map<String, Object>> getTopVisitedChains(Long userNum);
    
    // === 최근 방문 기록 ===
<<<<<<< HEAD
    // Oracle ROWNUM 사용으로 수정
    @Select("SELECT * FROM (" +
            "SELECT v.*, c.chain_name " +
=======
    // 최근 성공 방문 기록 조회 (명시적 alias 적용)
    @Select("SELECT * FROM (" +
            "SELECT " +
            "v.visit_num as visitNum, " +
            "v.user_num as userNum, " +
            "v.chain_num as chainNum, " +
            "v.visit_time as visitTime, " +
            "v.result as result, " +
            "v.failure_reason as failureReason, " +
            "c.chain_name as chainName " +
>>>>>>> b65c320 (Initial commit)
            "FROM hk_qr_visits v " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "WHERE v.user_num = #{userNum} AND v.result = 'SUCCESS' " +
            "ORDER BY v.visit_time DESC" +
            ") WHERE ROWNUM <= #{limit}")
    List<QRVisitVO> getRecentSuccessVisits(@Param("userNum") Long userNum, @Param("limit") int limit);
    
    // === 중복 입장 체크 (같은 가맹점 1시간 이내) ===
<<<<<<< HEAD
    // Oracle INTERVAL 사용으로 수정
    @Select("SELECT COUNT(*) FROM hk_qr_visits " +
            "WHERE user_num = #{userNum} AND chain_num = #{chainNum} " +
            "AND visit_time >= (SYSDATE - INTERVAL '1' HOUR) AND result = 'SUCCESS'")
    int checkRecentVisit(@Param("userNum") Long userNum, @Param("chainNum") Long chainNum);
    
    // === 관리자용 통계 ===
    // Oracle TRUNC 사용으로 수정
=======
    @Select("SELECT COUNT(*) FROM hk_qr_visits " +
            "WHERE user_num = #{userNum, jdbcType=NUMERIC} " +
            "AND chain_num = #{chainNum, jdbcType=NUMERIC} " +
            "AND visit_time >= (SYSDATE - INTERVAL '1' HOUR) " +
            "AND result = 'SUCCESS'")
    int checkRecentVisit(@Param("userNum") Long userNum, @Param("chainNum") Long chainNum);
    
    // === 관리자용 통계 ===
>>>>>>> b65c320 (Initial commit)
    @Select("SELECT COUNT(*) FROM hk_qr_visits WHERE TRUNC(visit_time) = TRUNC(SYSDATE)")
    int getTodayTotalVisits();
    
    @Select("SELECT COUNT(*) FROM hk_qr_visits WHERE TRUNC(visit_time) = TRUNC(SYSDATE) AND result = 'SUCCESS'")
    int getTodaySuccessVisits();
    
<<<<<<< HEAD
    // Oracle ROWNUM 사용으로 수정
    @Select("SELECT * FROM (" +
            "SELECT c.chain_name, COUNT(*) as visit_count " +
=======
    // 오늘의 인기 가맹점 (관리자용 - 명시적 alias 적용)
    @Select("SELECT * FROM (" +
            "SELECT " +
            "c.chain_name as chain_name, " +
            "COUNT(*) as visit_count " +
>>>>>>> b65c320 (Initial commit)
            "FROM hk_qr_visits v " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "WHERE TRUNC(v.visit_time) = TRUNC(SYSDATE) AND v.result = 'SUCCESS' " +
            "GROUP BY c.chain_num, c.chain_name " +
            "ORDER BY visit_count DESC" +
            ") WHERE ROWNUM <= 10")
    List<Map<String, Object>> getTodayPopularChains();
}