package net.koreate.hellking.common.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.koreate.hellking.common.dao.AdminDAO;
import net.koreate.hellking.common.vo.AdminStatsVO;
import net.koreate.hellking.common.vo.AdminStatsVO.RefundStatsVO;
import net.koreate.hellking.common.vo.AdminStatsVO.RecentUserVO;
import net.koreate.hellking.common.vo.AdminStatsVO.RecentRefundVO;
import net.koreate.hellking.common.vo.AdminStatsVO.RecentVisitVO;
import net.koreate.hellking.common.vo.AdminStatsVO.PassStatsVO;
import net.koreate.hellking.common.vo.AdminStatsVO.ChainVisitStatsVO;

@Service
public class AdminService {
    
    @Autowired
    private AdminDAO adminDAO;
    
    public AdminStatsVO getDashboardStats() {
        AdminStatsVO stats = new AdminStatsVO();
        
        // 기본 통계
        stats.setTotalUsers(adminDAO.getTotalUsers());
        stats.setNewUsersToday(adminDAO.getNewUsersToday());
        stats.setActivePasses(adminDAO.getActivePasses());
        stats.setExpiringSoon(adminDAO.getExpiringSoon());
        stats.setMonthlyRevenue(adminDAO.getMonthlyRevenue());
        stats.setTotalVisits(adminDAO.getTotalVisits());
        stats.setVisitSuccessRate(adminDAO.getVisitSuccessRate());
        stats.setLastUpdate(new Date());
        
        // 매출 성장률 계산 (더미 데이터)
        stats.setRevenueGrowth(12.5);
        
        // 차트 데이터
        List<PassStatsVO> passStats = adminDAO.getPassStats();
        stats.setPassStats(passStats);
        
        // 환불 통계 처리
        RefundStatsVO refundStats = adminDAO.getRefundStats();
        if (refundStats == null) {
            refundStats = new RefundStatsVO();
            refundStats.setRequested(0);
            refundStats.setApproved(0);
            refundStats.setCompleted(0);
            refundStats.setRejected(0);
        }
        stats.setRefundStats(refundStats);
        
        // 가맹점별 방문 통계
        List<ChainVisitStatsVO> chainVisitStats = adminDAO.getChainVisitStats();
        stats.setChainVisitStats(chainVisitStats);
        
        // 최근 활동 데이터
        List<RecentUserVO> recentUsers = adminDAO.getRecentUsers();
        if (recentUsers != null) {
            recentUsers.forEach(user -> {
                if (user != null) {
                    user.setTimeAgo(getTimeAgo(user.getJoinDate()));
                }
            });
        }
        stats.setRecentUsers(recentUsers);
        
        List<RecentRefundVO> recentRefunds = adminDAO.getRecentRefunds();
        if (recentRefunds != null) {
            recentRefunds.forEach(refund -> {
                if (refund != null) {
                    refund.setTimeAgo(getTimeAgo(refund.getRequestDate()));
                }
            });
        }
        stats.setRecentRefunds(recentRefunds);
        
        List<RecentVisitVO> recentVisits = adminDAO.getRecentVisits();
        if (recentVisits != null) {
            recentVisits.forEach(visit -> {
                if (visit != null) {
                    visit.setTimeAgo(getTimeAgo(visit.getVisitTime()));
                }
            });
        }
        stats.setRecentVisits(recentVisits);
        
        return stats;
    }
    
    // Date 타입으로 변경된 getTimeAgo 메소드
    private String getTimeAgo(Date date) {
        if (date == null) return "";
        
        Date now = new Date();
        long diffInMillis = now.getTime() - date.getTime();
        long minutes = diffInMillis / (60 * 1000);
        long hours = diffInMillis / (60 * 60 * 1000);
        long days = diffInMillis / (24 * 60 * 60 * 1000);
        
        if (minutes < 60) {
            return minutes + "분 전";
        } else if (hours < 24) {
            return hours + "시간 전";
        } else if (days < 7) {
            return days + "일 전";
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("MM.dd");
            return sdf.format(date);
        }
    }
}