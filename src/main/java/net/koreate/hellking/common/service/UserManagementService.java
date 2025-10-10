package net.koreate.hellking.common.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import net.koreate.hellking.common.dao.UserManagementDAO;
import net.koreate.hellking.common.vo.UserManagementVO;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserManagementService {
    
    @Autowired
    private UserManagementDAO userManagementDAO;
    
    private static final int PAGE_SIZE = 20; // 한 페이지당 회원 수
    
    /**
     * 회원 목록 조회 (페이징, 검색)
     */
    public Map<String, Object> getUserList(int page, String keyword) {
        Map<String, Object> result = new HashMap<>();
        
        int startRow = (page - 1) * PAGE_SIZE + 1;
        int endRow = page * PAGE_SIZE;
        
        List<UserManagementVO> users;
        int totalCount;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            users = userManagementDAO.searchUsers(keyword, startRow, endRow);
            totalCount = userManagementDAO.getSearchUserCount(keyword);
        } else {
            users = userManagementDAO.getUserList(startRow, endRow);
            totalCount = userManagementDAO.getTotalUserCount();
        }
        
        // 날짜 포맷팅 및 추가 정보 설정
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
        for (UserManagementVO user : users) {
            if (user.getJoinDate() != null) {
                user.setFormattedJoinDate(sdf.format(user.getJoinDate()));
            }
            
            // 안전한 NULL 체크
            Long userNum = user.getUserNum();
            if (userNum != null && userNum > 0) {
                try {
                    user.setTotalPasses(userManagementDAO.getUserPassCount(userNum));
                    user.setTotalVisits(userManagementDAO.getUserVisitCount(userNum));
                } catch (Exception e) {
                    // 예외 발생 시 기본값 설정
                    user.setTotalPasses(0);
                    user.setTotalVisits(0);
                }
            } else {
                user.setTotalPasses(0);
                user.setTotalVisits(0);
            }
        }
        
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        
        result.put("users", users);
        result.put("currentPage", page);
        result.put("totalPages", totalPages);
        result.put("totalCount", totalCount);
        result.put("pageSize", PAGE_SIZE);
        result.put("keyword", keyword);
        
        return result;
    }
    
    /**
     * 회원 상세 정보 조회
     */
    public UserManagementVO getUserDetail(Long userNum) {
        UserManagementVO user = userManagementDAO.getUserDetail(userNum);
        if (user != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm");
            if (user.getJoinDate() != null) {
                user.setFormattedJoinDate(sdf.format(user.getJoinDate()));
            }
            user.setTotalPasses(userManagementDAO.getUserPassCount(userNum));
            user.setTotalVisits(userManagementDAO.getUserVisitCount(userNum));
        }
        return user;
    }
    
    /**
     * 회원 상태 변경
     */
    public boolean updateUserStatus(Long userNum, String status) {
        try {
            return userManagementDAO.updateUserStatus(userNum, status) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 회원 역할 변경
     */
    public boolean updateUserRole(Long userNum, String userRole) {
        try {
            return userManagementDAO.updateUserRole(userNum, userRole) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 회원 삭제 (실제로는 상태 변경)
     */
    public boolean deleteUser(Long userNum) {
        try {
            return userManagementDAO.deleteUser(userNum) > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * 회원 상태별 통계
     */
    public Map<String, Object> getUserStats() {
        List<Map<String, Object>> statusStats = userManagementDAO.getUserStatusStats();
        Map<String, Object> stats = new HashMap<>();
        
        // 기본값 설정
        stats.put("activecount", 0);
        stats.put("suspendedcount", 0);
        stats.put("deletedcount", 0);
        stats.put("inactivecount", 0);
        
        for (Map<String, Object> stat : statusStats) {
            String status = (String) stat.get("STATUS");
            Number count = (Number) stat.get("COUNT");
            
            if (status != null && count != null) {
                switch (status.toUpperCase()) {
                    case "ACTIVE":
                        stats.put("activecount", count.intValue());
                        break;
                    case "SUSPENDED":
                        stats.put("suspendedcount", count.intValue());
                        break;
                    case "DELETED":
                        stats.put("deletedcount", count.intValue());
                        break;
                    case "INACTIVE":
                        stats.put("inactivecount", count.intValue());
                        break;
                }
            }
        }
        
        return stats;
    }
}