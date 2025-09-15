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
    @Insert("INSERT INTO hk_qr_visits (user_num, chain_num, result, failure_reason) " +
            "VALUES (#{userNum}, #{chainNum}, #{result}, #{failureReason})")
    @Options(useGeneratedKeys = true, keyProperty = "visitNum")
    int insertVisit(QRVisitVO visit);
    
    @Select("SELECT v.*, u.user_id, u.username, c.chain_name, c.address as chain_address, cc.chain_code " +
            "FROM hk_qr_visits v " +
            "JOIN hk_users u ON v.user_num = u.user_num " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "LEFT JOIN hk_chain_codes cc ON c.chain_num = cc.chain_num " +
            "WHERE v.user_num = #{userNum} " +
            "ORDER BY v.visit_time DESC")
    List<QRVisitVO> selectVisitsByUserNum(Long userNum);
    
    // Oracle ROWNUM 사용으로 수정
    @Select("SELECT * FROM (" +
            "SELECT v.*, u.user_id, u.username, c.chain_name, c.address as chain_address " +
            "FROM hk_qr_visits v " +
            "JOIN hk_users u ON v.user_num = u.user_num " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "WHERE v.chain_num = #{chainNum} " +
            "ORDER BY v.visit_time DESC" +
            ") WHERE ROWNUM <= #{limit}")
    List<QRVisitVO> selectRecentVisitsByChain(@Param("chainNum") Long chainNum, @Param("limit") int limit);
    
    // Oracle TRUNC 및 SYSDATE 사용으로 수정
    @Select("SELECT v.*, u.user_id, u.username, c.chain_name " +
            "FROM hk_qr_visits v " +
            "JOIN hk_users u ON v.user_num = u.user_num " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "WHERE TRUNC(v.visit_time) = TRUNC(SYSDATE) " +
            "ORDER BY v.visit_time DESC")
    List<QRVisitVO> selectTodayVisits();
    
    // === 활성 패스권 조회 ===
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
    ChainVO selectChainByCode(String chainCode);
    
    // === 통계 조회 ===
    @Select("SELECT COUNT(*) FROM hk_qr_visits WHERE user_num = #{userNum} AND result = 'SUCCESS'")
    int getTotalSuccessVisitCount(Long userNum);
    
    @Select("SELECT COUNT(*) FROM hk_qr_visits WHERE user_num = #{userNum}")
    int getTotalVisitCount(Long userNum);
    
    @Select("SELECT COUNT(DISTINCT chain_num) FROM hk_qr_visits WHERE user_num = #{userNum} AND result = 'SUCCESS'")
    int getVisitedChainCount(Long userNum);
    
    // Oracle ROWNUM 사용으로 수정
    @Select("SELECT * FROM (" +
            "SELECT c.chain_name, COUNT(*) as visit_count " +
            "FROM hk_qr_visits v " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "WHERE v.user_num = #{userNum} AND v.result = 'SUCCESS' " +
            "GROUP BY c.chain_num, c.chain_name " +
            "ORDER BY visit_count DESC" +
            ") WHERE ROWNUM <= 5")
    List<Map<String, Object>> getTopVisitedChains(Long userNum);
    
    // === 최근 방문 기록 ===
    // Oracle ROWNUM 사용으로 수정
    @Select("SELECT * FROM (" +
            "SELECT v.*, c.chain_name " +
            "FROM hk_qr_visits v " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "WHERE v.user_num = #{userNum} AND v.result = 'SUCCESS' " +
            "ORDER BY v.visit_time DESC" +
            ") WHERE ROWNUM <= #{limit}")
    List<QRVisitVO> getRecentSuccessVisits(@Param("userNum") Long userNum, @Param("limit") int limit);
    
    // === 중복 입장 체크 (같은 가맹점 1시간 이내) ===
    // Oracle INTERVAL 사용으로 수정
    @Select("SELECT COUNT(*) FROM hk_qr_visits " +
            "WHERE user_num = #{userNum} AND chain_num = #{chainNum} " +
            "AND visit_time >= (SYSDATE - INTERVAL '1' HOUR) AND result = 'SUCCESS'")
    int checkRecentVisit(@Param("userNum") Long userNum, @Param("chainNum") Long chainNum);
    
    // === 관리자용 통계 ===
    // Oracle TRUNC 사용으로 수정
    @Select("SELECT COUNT(*) FROM hk_qr_visits WHERE TRUNC(visit_time) = TRUNC(SYSDATE)")
    int getTodayTotalVisits();
    
    @Select("SELECT COUNT(*) FROM hk_qr_visits WHERE TRUNC(visit_time) = TRUNC(SYSDATE) AND result = 'SUCCESS'")
    int getTodaySuccessVisits();
    
    // Oracle ROWNUM 사용으로 수정
    @Select("SELECT * FROM (" +
            "SELECT c.chain_name, COUNT(*) as visit_count " +
            "FROM hk_qr_visits v " +
            "JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "WHERE TRUNC(v.visit_time) = TRUNC(SYSDATE) AND v.result = 'SUCCESS' " +
            "GROUP BY c.chain_num, c.chain_name " +
            "ORDER BY visit_count DESC" +
            ") WHERE ROWNUM <= 10")
    List<Map<String, Object>> getTodayPopularChains();
}