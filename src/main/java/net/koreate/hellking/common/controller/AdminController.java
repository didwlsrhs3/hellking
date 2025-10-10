package net.koreate.hellking.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import net.koreate.hellking.common.service.AdminService;
import net.koreate.hellking.common.service.UserManagementService;
import net.koreate.hellking.common.vo.AdminStatsVO;
import net.koreate.hellking.common.vo.UserManagementVO;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private AdminService adminService;
    
    @Autowired
    private UserManagementService userManagementService;
    
    @RequestMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        
        // 권한 체크
        String userRole = (String) session.getAttribute("userRole");
        if (!"ADMIN".equalsIgnoreCase(userRole)) {
            return "redirect:/user/login";
        }
        
        try {
            // 통계 데이터 조회
            AdminStatsVO stats = adminService.getDashboardStats();
            model.addAttribute("stats", stats);
            model.addAttribute("passStats", stats.getPassStats());
            model.addAttribute("refundStats", stats.getRefundStats());
            model.addAttribute("chainVisitStats", stats.getChainVisitStats());
            model.addAttribute("recentUsers", stats.getRecentUsers());
            model.addAttribute("recentRefunds", stats.getRecentRefunds());
            model.addAttribute("recentVisits", stats.getRecentVisits());
            
            return "admin/dashboard";
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "대시보드 데이터를 불러오는 중 오류가 발생했습니다.");
            return "error/500";
        }
    }

    // === 회원 관리 기능 ===

    /**
     * 회원 관리 페이지
     */
    @RequestMapping("/users")
    public String userManagement(Model model, HttpSession session,
                                @RequestParam(defaultValue = "1") int page,
                                @RequestParam(required = false) String keyword) {
        
        // 권한 체크
        String userRole = (String) session.getAttribute("userRole");
        if (!"ADMIN".equalsIgnoreCase(userRole)) {
            return "redirect:/user/login";
        }
        
        try {
            Map<String, Object> result = userManagementService.getUserList(page, keyword);
            model.addAttribute("userList", result.get("users"));
            model.addAttribute("currentPage", result.get("currentPage"));
            model.addAttribute("totalPages", result.get("totalPages"));
            model.addAttribute("totalCount", result.get("totalCount"));
            model.addAttribute("keyword", result.get("keyword"));
            
            // 회원 상태 통계
            Map<String, Object> stats = userManagementService.getUserStats();
            model.addAttribute("userStats", stats);
            
            return "admin/users";
            
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("errorMessage", "회원 목록을 불러오는 중 오류가 발생했습니다.");
            return "error/500";
        }
    }

    /**
     * 회원 상세 정보
     */
    @RequestMapping("/users/detail/{userNum}")
    public String userDetail(@PathVariable Long userNum, Model model, HttpSession session) {
        // 디버깅 로그 추가
        Long sessionUserNum = (Long) session.getAttribute("userNum");
        System.out.println("=== userDetail 디버깅 ===");
        System.out.println("PathVariable userNum: " + userNum);
        System.out.println("Session userNum: " + sessionUserNum);
        
        UserManagementVO user = userManagementService.getUserDetail(userNum);
        System.out.println("조회된 user: " + user);
        
        if (user == null) {
            System.out.println("user가 null입니다!");
            return "redirect:/admin/users";
        }
        
        model.addAttribute("user", user);
        System.out.println("JSP로 이동: admin/userDetail");
        return "admin/userDetail";
    }

    /**
     * 회원 상태 변경 (AJAX)
     */
    @PostMapping("/users/updateStatus")
    @ResponseBody
    public Map<String, Object> updateUserStatus(@RequestParam Long userNum, 
                                               @RequestParam String status, 
                                               HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 권한 체크
        String userRole = (String) session.getAttribute("userRole");
        if (!"ADMIN".equalsIgnoreCase(userRole)) {
            response.put("success", false);
            response.put("message", "권한이 없습니다.");
            return response;
        }
        
        try {
            boolean success = userManagementService.updateUserStatus(userNum, status);
            response.put("success", success);
            response.put("message", success ? "상태가 변경되었습니다." : "상태 변경에 실패했습니다.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다.");
        }
        
        return response;
    }

    /**
     * 회원 역할 변경 (AJAX)
     */
    @PostMapping("/users/updateRole")
    @ResponseBody
    public Map<String, Object> updateUserRole(@RequestParam Long userNum, 
                                             @RequestParam String userRole, 
                                             HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 권한 체크
        String sessionUserRole = (String) session.getAttribute("userRole");
        if (!"ADMIN".equalsIgnoreCase(sessionUserRole)) {
            response.put("success", false);
            response.put("message", "권한이 없습니다.");
            return response;
        }
        
        try {
            boolean success = userManagementService.updateUserRole(userNum, userRole);
            response.put("success", success);
            response.put("message", success ? "역할이 변경되었습니다." : "역할 변경에 실패했습니다.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다.");
        }
        
        return response;
    }

    /**
     * 회원 삭제 (AJAX)
     */
    @PostMapping("/users/delete")
    @ResponseBody
    public Map<String, Object> deleteUser(@RequestParam Long userNum, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        
        // 권한 체크
        String userRole = (String) session.getAttribute("userRole");
        if (!"ADMIN".equalsIgnoreCase(userRole)) {
            response.put("success", false);
            response.put("message", "권한이 없습니다.");
            return response;
        }
        
        try {
            boolean success = userManagementService.deleteUser(userNum);
            response.put("success", success);
            response.put("message", success ? "회원이 삭제되었습니다." : "회원 삭제에 실패했습니다.");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다.");
        }
        
        return response;
    }
}