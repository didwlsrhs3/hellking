package net.koreate.hellking.pass.dao;

import org.apache.ibatis.annotations.*;
import net.koreate.hellking.pass.vo.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface PassDAO {
    
    // === 패스권 상품 관리 ===
    @Select("SELECT pass_num as passNum, pass_name as passName, price, " +
            "duration_days as durationDays, description, is_active as isActive " +
            "FROM hk_passes WHERE is_active = 'Y' ORDER BY duration_days, price")
    List<PassVO> selectAllPasses();
    
    @Select("SELECT pass_num as passNum, pass_name as passName, price, " +
            "duration_days as durationDays, description, is_active as isActive " +
            "FROM hk_passes WHERE pass_num = #{passNum, jdbcType=NUMERIC}")
    PassVO selectByPassNum(Long passNum);
    
    @Insert("INSERT INTO hk_passes (pass_name, price, duration_days, description) " +
            "VALUES (#{passName}, #{price, jdbcType=NUMERIC}, #{durationDays, jdbcType=NUMERIC}, #{description})")
    int insertPass(PassVO pass);
    
    @Update("UPDATE hk_passes SET pass_name = #{passName}, price = #{price, jdbcType=NUMERIC}, " +
            "duration_days = #{durationDays, jdbcType=NUMERIC}, description = #{description} " +
            "WHERE pass_num = #{passNum, jdbcType=NUMERIC}")
    int updatePass(PassVO pass);
    
    @Update("UPDATE hk_passes SET is_active = #{isActive} WHERE pass_num = #{passNum, jdbcType=NUMERIC}")
    int updatePassStatus(@Param("passNum") Long passNum, @Param("isActive") String isActive);
    
    // === 사용자 패스권 관리 ===
    @Insert("INSERT INTO hk_user_passes (user_num, pass_num, start_date, end_date, payment_id, status) " +
            "VALUES (#{userNum, jdbcType=NUMERIC}, #{passNum, jdbcType=NUMERIC}, #{startDate}, #{endDate}, #{paymentId}, 'ACTIVE')")
    int insertUserPass(UserPassVO userPass);
    
    @Select("SELECT up.user_pass_num as userPassNum, up.user_num as userNum, up.pass_num as passNum, " +
            "up.start_date as startDate, up.end_date as endDate, up.status, " +
            "up.purchase_date as purchaseDate, up.payment_id as paymentId, " +
            "u.user_id as userId, u.username, p.pass_name as passName, p.price, p.duration_days as durationDays " +
            "FROM hk_user_passes up " +
            "JOIN hk_users u ON up.user_num = u.user_num " +
            "JOIN hk_passes p ON up.pass_num = p.pass_num " +
            "WHERE up.user_num = #{userNum, jdbcType=NUMERIC} " +
            "ORDER BY up.purchase_date DESC")
    List<UserPassVO> selectUserPasses(Long userNum);
    
    @Select("SELECT up.user_pass_num as userPassNum, up.user_num as userNum, up.pass_num as passNum, " +
            "up.start_date as startDate, up.end_date as endDate, up.status, " +
            "up.purchase_date as purchaseDate, up.payment_id as paymentId, " +
            "u.user_id as userId, u.username, p.pass_name as passName, p.price, p.duration_days as durationDays " +
            "FROM hk_user_passes up " +
            "JOIN hk_users u ON up.user_num = u.user_num " +
            "JOIN hk_passes p ON up.pass_num = p.pass_num " +
            "WHERE up.user_num = #{userNum, jdbcType=NUMERIC} AND up.status = 'ACTIVE' AND up.end_date >= SYSDATE " +
            "ORDER BY up.end_date")
    List<UserPassVO> selectActivePasses(Long userNum);
    
    @Select("SELECT up.user_pass_num as userPassNum, up.user_num as userNum, up.pass_num as passNum, " +
            "up.start_date as startDate, up.end_date as endDate, up.status, " +
            "up.purchase_date as purchaseDate, up.payment_id as paymentId, " +
            "u.user_id as userId, u.username, p.pass_name as passName, p.price, p.duration_days as durationDays " +
            "FROM hk_user_passes up " +
            "JOIN hk_users u ON up.user_num = u.user_num " +
            "JOIN hk_passes p ON up.pass_num = p.pass_num " +
            "WHERE up.user_pass_num = #{userPassNum, jdbcType=NUMERIC}")
    UserPassVO selectUserPassByNum(Long userPassNum);
    
    @Update("UPDATE hk_user_passes SET status = #{status} WHERE user_pass_num = #{userPassNum, jdbcType=NUMERIC}")
    int updateUserPassStatus(@Param("userPassNum") Long userPassNum, @Param("status") String status);
    
    // === 만료 처리 ===
    @Update("UPDATE hk_user_passes SET status = 'EXPIRED' " +
            "WHERE status = 'ACTIVE' AND end_date < SYSDATE")
    int updateExpiredPasses();
    
    // === 환불 관리 ===
    @Insert("INSERT INTO hk_refunds (user_pass_num, refund_amount, reason, status) " +
            "VALUES (#{userPassNum, jdbcType=NUMERIC}, #{refundAmount, jdbcType=NUMERIC}, #{reason}, 'REQUESTED')")
    int insertRefund(RefundVO refund);
    
    @Select("SELECT r.refund_num as refundNum, r.user_pass_num as userPassNum, " +
            "r.refund_amount as refundAmount, r.reason, r.status, r.request_date as requestDate, " +
            "up.pass_num as passNum, p.pass_name as passName, u.username, p.price as originalPrice " +
            "FROM hk_refunds r " +
            "JOIN hk_user_passes up ON r.user_pass_num = up.user_pass_num " +
            "JOIN hk_passes p ON up.pass_num = p.pass_num " +
            "JOIN hk_users u ON up.user_num = u.user_num " +
            "WHERE up.user_num = #{userNum, jdbcType=NUMERIC} " +
            "ORDER BY r.request_date DESC")
    List<RefundVO> selectRefundsByUserNum(Long userNum);
    
    @Select("SELECT r.refund_num as refundNum, r.user_pass_num as userPassNum, " +
            "r.refund_amount as refundAmount, r.reason, r.status, r.request_date as requestDate, " +
            "up.pass_num as passNum, p.pass_name as passName, u.username " +
            "FROM hk_refunds r " +
            "JOIN hk_user_passes up ON r.user_pass_num = up.user_pass_num " +
            "JOIN hk_passes p ON up.pass_num = p.pass_num " +
            "JOIN hk_users u ON up.user_num = u.user_num " +
            "ORDER BY r.request_date DESC")
    List<RefundVO> selectAllRefunds();
    
    @Update("UPDATE hk_refunds SET status = #{status}, process_date = SYSDATE, reject_reason = #{rejectReason} " +
            "WHERE refund_num = #{refundNum, jdbcType=NUMERIC}")
    int updateRefundStatus(@Param("refundNum") Long refundNum, @Param("status") String status, 
                          @Param("rejectReason") String rejectReason);
    
    // === 결제 관리 (개선된 버전) ===
    @Insert("INSERT INTO hk_payments (user_num, merchant_uid, amount, status, buyer_name, buyer_email, buyer_tel) " +
            "VALUES (#{userNum, jdbcType=NUMERIC}, #{merchantUid}, #{amount, jdbcType=NUMERIC}, #{status}, #{buyerName}, #{buyerEmail}, #{buyerTel})")
    int insertPayment(PaymentVO payment);
    
    // merchant_uid 기반 업데이트 (가장 많이 사용)
    @Update("UPDATE hk_payments SET " +
            "status = #{status, jdbcType=VARCHAR}, " +
            "payment_id = #{paymentId, jdbcType=VARCHAR}, " +
            "pay_method = #{payMethod, jdbcType=VARCHAR}, " +
            "card_name = #{cardName, jdbcType=VARCHAR}, " +
            "paid_at = SYSDATE " +
            "WHERE merchant_uid = #{merchantUid, jdbcType=VARCHAR}")
    int updatePaymentStatus(PaymentVO payment);
    
    // payment_id 기반 업데이트 (취소 등에 사용)
    @Update("UPDATE hk_payments SET " +
            "status = #{status, jdbcType=VARCHAR}, " +
            "pay_method = #{payMethod, jdbcType=VARCHAR}, " +
            "card_name = #{cardName, jdbcType=VARCHAR}, " +
            "paid_at = SYSDATE " +
            "WHERE payment_id = #{paymentId, jdbcType=VARCHAR}")
    int updatePaymentStatusByPaymentId(PaymentVO payment);
    
    @Select("SELECT payment_num as paymentNum, user_num as userNum, payment_id as paymentId, " +
            "merchant_uid as merchantUid, amount, status, pay_method as payMethod, " +
            "created_at as createdAt, paid_at as paidAt, card_name as cardName, bank_name as bankName, " +
            "buyer_name as buyerName, buyer_email as buyerEmail, buyer_tel as buyerTel " +
            "FROM hk_payments WHERE payment_id = #{paymentId}")
    PaymentVO selectPaymentByPaymentId(String paymentId);
    
    @Select("SELECT payment_num as paymentNum, user_num as userNum, payment_id as paymentId, " +
            "merchant_uid as merchantUid, amount, status, pay_method as payMethod, " +
            "created_at as createdAt, paid_at as paidAt, card_name as cardName, bank_name as bankName, " +
            "buyer_name as buyerName, buyer_email as buyerEmail, buyer_tel as buyerTel " +
            "FROM hk_payments WHERE merchant_uid = #{merchantUid}")
    PaymentVO selectPaymentByMerchantUid(String merchantUid);
    
    // 최근 결제 내역 조회 (디버깅용)
    @Select("SELECT payment_num as paymentNum, user_num as userNum, payment_id as paymentId, " +
            "merchant_uid as merchantUid, amount, status, pay_method as payMethod, " +
            "created_at as createdAt, paid_at as paidAt, card_name as cardName, bank_name as bankName, " +
            "buyer_name as buyerName, buyer_email as buyerEmail, buyer_tel as buyerTel " +
            "FROM hk_payments WHERE user_num = #{userNum, jdbcType=NUMERIC} " +
            "ORDER BY created_at DESC")
    List<PaymentVO> selectPaymentsByUserNum(Long userNum);
    
    // === 통계 ===
    @Select("SELECT COUNT(*) FROM hk_user_passes WHERE user_num = #{userNum, jdbcType=NUMERIC}")
    int getTotalPassCount(Long userNum);
    
    @Select("SELECT COUNT(*) FROM hk_user_passes WHERE user_num = #{userNum, jdbcType=NUMERIC} AND status = 'ACTIVE'")
    int getActivePassCount(Long userNum);
    
    @Select("SELECT COALESCE(SUM(p.price), 0) FROM hk_user_passes up " +
            "JOIN hk_passes p ON up.pass_num = p.pass_num WHERE up.user_num = #{userNum, jdbcType=NUMERIC}")
    Long getTotalSpentAmount(Long userNum);
    
    // === 관리자용 ===
    @Select("SELECT COUNT(*) FROM hk_user_passes WHERE status = 'ACTIVE'")
    int getTotalActivePassCount();
    
    @Select("SELECT p.pass_name, COUNT(*) as count FROM hk_user_passes up " +
            "JOIN hk_passes p ON up.pass_num = p.pass_num " +
            "WHERE up.purchase_date >= TRUNC(SYSDATE - 30) " +
            "GROUP BY p.pass_name ORDER BY count DESC")
    List<Map<String, Object>> getPopularPassesLastMonth();
}