package net.koreate.hellking.common.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.common.vo.AdminStatsVO;
import net.koreate.hellking.common.vo.AdminStatsVO.PassStatsVO;
import net.koreate.hellking.common.vo.AdminStatsVO.RefundStatsVO;
import net.koreate.hellking.common.vo.AdminStatsVO.ChainVisitStatsVO;
import net.koreate.hellking.common.vo.AdminStatsVO.RecentUserVO;
import net.koreate.hellking.common.vo.AdminStatsVO.RecentRefundVO;
import net.koreate.hellking.common.vo.AdminStatsVO.RecentVisitVO;
import java.util.List;

@Mapper
public interface AdminDAO {
    
    // === 기본 통계 쿼리 ===
    
    /**
     * 전체 회원 수
     */
    @Select("SELECT COUNT(*) FROM hk_users")
    int getTotalUsers();
    
    /**
     * 오늘 신규 가입자 수
     */
    @Select("SELECT COUNT(*) FROM hk_users WHERE TRUNC(join_date) = TRUNC(SYSDATE)")
    int getNewUsersToday();
    
    /**
     * 활성 패스권 수
     */
    @Select("SELECT COUNT(*) FROM hk_user_passes WHERE status = 'ACTIVE' AND end_date >= SYSDATE")
    int getActivePasses();
    
    /**
     * 곧 만료될 패스권 수 (7일 이내)
     */
    @Select("SELECT COUNT(*) FROM hk_user_passes WHERE status = 'ACTIVE' AND end_date BETWEEN SYSDATE AND SYSDATE + 7")
    int getExpiringSoon();
    
    /**
     * 이달 매출 - hk_passes와 hk_user_passes JOIN으로 계산
     */
    @Select("SELECT NVL(SUM(p.price), 0) FROM hk_passes p " +
            "INNER JOIN hk_user_passes up ON p.pass_num = up.pass_num " +
            "WHERE TO_CHAR(up.purchase_date, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM')")
    long getMonthlyRevenue();
    
    /**
     * 총 방문 횟수
     */
    @Select("SELECT COUNT(*) FROM hk_qr_visits")
    int getTotalVisits();
    
    /**
     * 방문 성공률 - result 컬럼 사용
     */
    @Select("SELECT CASE WHEN COUNT(*) = 0 THEN 0 ELSE " +
            "ROUND(COUNT(CASE WHEN result = 'SUCCESS' THEN 1 END) * 100.0 / COUNT(*), 1) END " +
            "FROM hk_qr_visits")
    double getVisitSuccessRate();
    
    // === 차트 데이터 쿼리 ===
    
    /**
     * 패스권별 판매 통계
     */
    @Select("SELECT p.pass_name as passName, " +
            "COUNT(up.user_pass_num) as soldCount, " +
            "NVL(SUM(p.price), 0) as revenue " +
            "FROM hk_passes p " +
            "LEFT JOIN hk_user_passes up ON p.pass_num = up.pass_num " +
            "AND TO_CHAR(up.purchase_date, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM') " +
            "GROUP BY p.pass_name, p.price " +
            "ORDER BY soldCount DESC")
    List<PassStatsVO> getPassStats();
    
    /**
     * 환불 현황 통계
     */
    @Select("SELECT " +
            "COUNT(CASE WHEN status = 'REQUESTED' THEN 1 END) as requested, " +
            "COUNT(CASE WHEN status = 'APPROVED' THEN 1 END) as approved, " +
            "COUNT(CASE WHEN status = 'COMPLETED' THEN 1 END) as completed, " +
            "COUNT(CASE WHEN status = 'REJECTED' THEN 1 END) as rejected " +
            "FROM hk_refunds " +
            "WHERE TO_CHAR(request_date, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM')")
    RefundStatsVO getRefundStats();
    
    /**
     * 가맹점별 방문 통계 (이번 달) - hk_chains 테이블 사용
     */
    @Select("SELECT c.chain_name as chainName, " +
            "COUNT(CASE WHEN v.result = 'SUCCESS' THEN 1 END) as successCount, " +
            "COUNT(CASE WHEN v.result = 'FAILED' THEN 1 END) as failCount " +
            "FROM hk_chains c " +
            "LEFT JOIN hk_qr_visits v ON c.chain_num = v.chain_num " +
            "AND TO_CHAR(v.visit_time, 'YYYY-MM') = TO_CHAR(SYSDATE, 'YYYY-MM') " +
            "GROUP BY c.chain_name " +
            "ORDER BY (successCount + failCount) DESC " +
            "FETCH FIRST 10 ROWS ONLY")
    List<ChainVisitStatsVO> getChainVisitStats();
    
    // === 최근 활동 데이터 ===
    
    /**
     * 최근 가입 회원 (최근 10명)
     */
    @Select("SELECT user_num as userNum, user_id as userId, username, email, " +
            "join_date as joinDate, account_type as accountType " +
            "FROM hk_users " +
            "ORDER BY join_date DESC " +
            "FETCH FIRST 10 ROWS ONLY")
    List<RecentUserVO> getRecentUsers();
    
    /**
     * 최근 환불 요청 (최근 10건)
     */
    @Select("SELECT r.refund_num as refundNum, u.user_id as userId, p.pass_name as passName, " +
            "r.refund_amount as refundAmount, r.status, r.request_date as requestDate " +
            "FROM hk_refunds r " +
            "INNER JOIN hk_user_passes up ON r.user_pass_num = up.user_pass_num " +
            "INNER JOIN hk_users u ON up.user_num = u.user_num " +
            "INNER JOIN hk_passes p ON up.pass_num = p.pass_num " +
            "ORDER BY r.request_date DESC " +
            "FETCH FIRST 10 ROWS ONLY")
    List<RecentRefundVO> getRecentRefunds();
    
    /**
     * 최근 방문 기록 (최근 20건) - result 컬럼과 hk_chains 테이블 사용
     */
    @Select("SELECT v.visit_num as visitNum, u.user_id as userId, " +
            "c.chain_name as chainName, v.result as status, v.visit_time as visitTime " +
            "FROM hk_qr_visits v " +
            "INNER JOIN hk_users u ON v.user_num = u.user_num " +
            "INNER JOIN hk_chains c ON v.chain_num = c.chain_num " +
            "ORDER BY v.visit_time DESC " +
            "FETCH FIRST 20 ROWS ONLY")
    List<RecentVisitVO> getRecentVisits();
    
    @Select("SELECT COUNT(*) FROM hk_user_passes WHERE user_num = #{userNum, jdbcType=NUMERIC} AND status = 'ACTIVE'")
    int getUserPassCount(@Param("userNum") Long userNum);

    @Select("SELECT COUNT(*) FROM hk_qr_visits WHERE user_num = #{userNum, jdbcType=NUMERIC}")
    int getUserVisitCount(@Param("userNum") Long userNum);
}