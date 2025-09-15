package net.koreate.hellking.common.util;

import java.util.Date;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;

public class RefundCalculator {
    
    /**
     * 환불 금액 계산
     * @param originalPrice 원래 가격
     * @param startDate 패스권 시작일
     * @param endDate 패스권 종료일
     * @param refundDate 환불 신청일
     * @return 환불 금액
     */
    public static Long calculateRefundAmount(Long originalPrice, Date startDate, Date endDate, Date refundDate) {
        LocalDate start = startDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate end = endDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate refund = refundDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        
        // 전체 기간 (일)
        long totalDays = ChronoUnit.DAYS.between(start, end);
        
        // 사용한 기간 (일)
        long usedDays = ChronoUnit.DAYS.between(start, refund);
        
        // 남은 기간 (일)
        long remainingDays = totalDays - usedDays;
        
        if (remainingDays <= 0) {
            return 0L; // 이미 다 사용한 경우
        }
        
        // 비례 환불 계산
        double refundRatio = (double) remainingDays / totalDays;
        
        // 수수료 10% 차감
        double refundAmount = originalPrice * refundRatio * 0.9;
        
        return Math.round(refundAmount);
    }
    
    /**
     * 환불 수수료 계산
     */
    public static Long calculateRefundFee(Long originalPrice, Date startDate, Date endDate, Date refundDate) {
        Long refundAmount = calculateRefundAmount(originalPrice, startDate, endDate, refundDate);
        return originalPrice - refundAmount;
    }
}