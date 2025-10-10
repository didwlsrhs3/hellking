package net.koreate.hellking.common.vo;

import lombok.Data;
import java.util.Date;
import java.util.List;

/**
 * 관리자 대시보드 통계 데이터를 담는 VO
 */
@Data
public class AdminStatsVO {
    
    // === 기본 통계 ===
    private int totalUsers;        // 전체 회원수
    private int newUsersToday;     // 오늘 신규 가입자
    private int activePasses;      // 활성 패스권 수
    private int expiringSoon;      // 곧 만료될 패스권 수
    private long monthlyRevenue;   // 이달 매출
    private int totalVisits;       // 총 방문 횟수
    private double visitSuccessRate; // 방문 성공률
    private double revenueGrowth;  // 매출 성장률 (%)
    private Date lastUpdate;       // 마지막 업데이트 시간
    
    // === 차트 데이터 ===
    private List<PassStatsVO> passStats;         // 패스권 판매 통계
    private RefundStatsVO refundStats;           // 환불 현황 통계
    private List<ChainVisitStatsVO> chainVisitStats; // 가맹점별 방문 통계
    
    // === 최근 활동 데이터 ===
    private List<RecentUserVO> recentUsers;      // 최근 가입 회원
    private List<RecentRefundVO> recentRefunds;  // 최근 환불 요청
    private List<RecentVisitVO> recentVisits;    // 최근 방문 기록
    
    // === 유틸리티 메서드 ===
    
    /**
     * 매출 성장률을 백분율 문자열로 반환
     */
    public String getRevenueGrowthPercent() {
        return String.format("%.1f%%", revenueGrowth);
    }
    
    /**
     * 방문 성공률을 백분율 문자열로 반환
     */
    public String getVisitSuccessRatePercent() {
        return String.format("%.1f%%", visitSuccessRate);
    }
    
    /**
     * 월 매출을 포맷된 문자열로 반환
     */
    public String getFormattedMonthlyRevenue() {
        return String.format("%,d원", monthlyRevenue);
    }

    /**
     * 패스권 판매 통계 VO
     */
    @Data
    public static class PassStatsVO {
        private String passName;    // 패스권명
        private int soldCount;      // 판매량
        private long revenue;       // 매출
        
        /**
         * 포맷된 매출 반환
         */
        public String getFormattedRevenue() {
            return String.format("%,d원", revenue);
        }
    }

    /**
     * 환불 현황 통계 VO
     */
    @Data
    public static class RefundStatsVO {
        private int requested;  // 요청
        private int approved;   // 승인
        private int completed;  // 완료
        private int rejected;   // 거절
        
        /**
         * 총 환불 건수 반환
         */
        public int getTotal() {
            return requested + approved + completed + rejected;
        }
    }

    /**
     * 가맹점별 방문 통계 VO
     */
    @Data
    public static class ChainVisitStatsVO {
        private String chainName;   // 가맹점명
        private int successCount;   // 성공 횟수
        private int failCount;      // 실패 횟수
        
        /**
         * 총 방문 시도 횟수 반환
         */
        public int getTotalAttempts() {
            return successCount + failCount;
        }
        
        /**
         * 성공률 반환
         */
        public double getSuccessRate() {
            int total = getTotalAttempts();
            return total > 0 ? (double) successCount / total * 100 : 0.0;
        }
    }

    /**
     * 최근 가입 회원 VO
     */
    @Data
    public static class RecentUserVO {
        private Long userNum;
        private String userId;
        private String username;
        private String email;
        private Date joinDate;
        private String timeAgo;     // "2시간 전" 같은 상대 시간
        private String accountType; // REGULAR, SOCIAL
    }

    /**
     * 최근 환불 요청 VO
     */
    @Data
    public static class RecentRefundVO {
        private Long refundNum;
        private String userId;
        private String passName;
        private long refundAmount;
        private String status;      // REQUESTED, APPROVED, COMPLETED, REJECTED
        private Date requestDate;
        private String timeAgo;     // 상대 시간
        
        /**
         * 포맷된 환불 금액 반환
         */
        public String getFormattedRefundAmount() {
            return String.format("%,d원", refundAmount);
        }
        
        /**
         * 상태를 한국어로 반환
         */
        public String getStatusKorean() {
            switch (status) {
                case "REQUESTED": return "요청";
                case "APPROVED": return "승인";
                case "COMPLETED": return "완료";
                case "REJECTED": return "거절";
                default: return status;
            }
        }
    }

    /**
     * 최근 방문 기록 VO
     */
    @Data
    public static class RecentVisitVO {
        private Long visitNum;
        private String userId;
        private String chainName;
        private String status;      // SUCCESS, FAIL
        private Date visitTime;
        private String timeAgo;     // 상대 시간
        
        /**
         * 방문 결과를 한국어로 반환
         */
        public String getResult() {
            return "SUCCESS".equals(status) ? "성공" : "실패";
        }
    }
}