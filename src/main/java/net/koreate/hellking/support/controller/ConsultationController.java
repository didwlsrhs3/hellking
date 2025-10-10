package net.koreate.hellking.support.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.support.service.ConsultationService;
import net.koreate.hellking.support.vo.ConsultationVO;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.user.vo.UserVO;

/**
 * 상담예약 컨트롤러
 */
@Controller
@RequestMapping("/support/consultation")
@Slf4j
public class ConsultationController {
    
    @Autowired
    private ConsultationService consultationService;
    
    @Autowired
    private UserService userService;
    
    /**
     * 상담예약 메인 페이지
     */
    @GetMapping("")
    public String consultation(HttpSession session, Model model) {
        // 로그인 체크
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        Long userNum = userService.getCurrentUserNum(session);
        UserVO currentUser = userService.getCurrentUser(session);
        
        // 사용자 정보
        model.addAttribute("user", currentUser);
        
        // 사용자의 기존 예약 목록
        List<ConsultationVO> consultations = consultationService.getUserConsultations(userNum);
        model.addAttribute("consultations", consultations);
        
        // 최근 예약 정보 (자동 입력용)
        ConsultationVO recentConsultation = consultationService.getRecentConsultation(userNum);
        model.addAttribute("recentConsultation", recentConsultation);
        
        return "support/consultation/main";
    }
    
    /**
     * 상담예약 신청 페이지
     */
    @GetMapping("/create")
    public String createForm(HttpSession session, Model model) {
        // 로그인 체크
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        UserVO currentUser = userService.getCurrentUser(session);
        model.addAttribute("user", currentUser);
        
        // 최근 예약 정보 (자동 입력용)
        Long userNum = userService.getCurrentUserNum(session);
        ConsultationVO recentConsultation = consultationService.getRecentConsultation(userNum);
        model.addAttribute("recentConsultation", recentConsultation);
        
        return "support/consultation/create";
    }
    
    /**
     * 상담예약 신청 처리
     */
    @PostMapping("/create")
    public String createPost(ConsultationVO consultation, 
                           HttpSession session, 
                           RedirectAttributes rttr) {
        try {
            // 로그인 체크
            if (!userService.isLoggedIn(session)) {
                return "redirect:/user/login";
            }
            
            Long userNum = userService.getCurrentUserNum(session);
            consultation.setUserNum(userNum);
            
            // 예약 등록
            boolean success = consultationService.createConsultation(consultation);
            
            if (success) {
                rttr.addFlashAttribute("message", "상담예약이 성공적으로 등록되었습니다. 확인 이메일을 발송했습니다.");
                rttr.addFlashAttribute("messageType", "success");
                return "redirect:/support/consultation";
            } else {
                throw new Exception("예약 등록에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("상담예약 등록 실패: {}", e.getMessage());
            rttr.addFlashAttribute("message", e.getMessage());
            rttr.addFlashAttribute("messageType", "error");
            return "redirect:/support/consultation/create";
        }
    }
    
    /**
     * 예약 가능한 시간 조회 (AJAX)
     */
    @PostMapping("/available-times")
    @ResponseBody
    public Map<String, Object> getAvailableTimes(@RequestParam String date) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date consultationDate = sdf.parse(date);
            
            List<String> availableTimes = consultationService.getAvailableTimeSlots(consultationDate);
            
            result.put("success", true);
            result.put("availableTimes", availableTimes);
            
        } catch (Exception e) {
            log.error("예약 가능 시간 조회 실패: {}", e.getMessage());
            result.put("success", false);
            result.put("message", "예약 가능 시간을 조회할 수 없습니다.");
        }
        
        return result;
    }
    
    /**
     * 상담예약 상세 보기
     */
    @GetMapping("/detail")
    public String detail(@RequestParam Long consultationNum, 
                        HttpSession session, 
                        Model model,
                        RedirectAttributes rttr) {
        try {
            // 로그인 체크
            if (!userService.isLoggedIn(session)) {
                return "redirect:/user/login";
            }
            
            ConsultationVO consultation = consultationService.getConsultation(consultationNum);
            
            if (consultation == null) {
                rttr.addFlashAttribute("message", "존재하지 않는 예약입니다.");
                rttr.addFlashAttribute("messageType", "error");
                return "redirect:/support/consultation";
            }
            
            Long currentUserNum = userService.getCurrentUserNum(session);
            
            // 본인 예약이 아니면 관리자만 접근 가능
            if (!consultation.getUserNum().equals(currentUserNum) && !userService.isAdmin(session)) {
                rttr.addFlashAttribute("message", "접근 권한이 없습니다.");
                rttr.addFlashAttribute("messageType", "error");
                return "redirect:/support/consultation";
            }
            
            model.addAttribute("consultation", consultation);
            
            return "support/consultation/detail";
            
        } catch (Exception e) {
            log.error("상담예약 상세 조회 실패: {}", e.getMessage());
            rttr.addFlashAttribute("message", "예약 정보를 조회할 수 없습니다.");
            rttr.addFlashAttribute("messageType", "error");
            return "redirect:/support/consultation";
        }
    }
    
    /**
     * 상담예약 취소
     */
    @PostMapping("/cancel")
    @ResponseBody
    public Map<String, Object> cancel(@RequestParam Long consultationNum, 
                                     HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 로그인 체크
            if (!userService.isLoggedIn(session)) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            Long userNum = userService.getCurrentUserNum(session);
            boolean success = consultationService.cancelConsultation(consultationNum, userNum);
            
            result.put("success", success);
            result.put("message", success ? "상담예약이 취소되었습니다." : "예약 취소에 실패했습니다.");
            
        } catch (Exception e) {
            log.error("상담예약 취소 실패: {}", e.getMessage());
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 관리자 - 상담예약 관리 메인 페이지
     */
    @GetMapping("/admin")
    public String adminMain(HttpSession session, Model model) {
        // 관리자 권한 체크
        if (!userService.isAdmin(session)) {
            return "redirect:/";
        }
        
        return "support/consultation/admin/main";
    }
    
    /**
     * 관리자 - 상담예약 목록 조회
     */
    @GetMapping("/admin/list")
    public String adminList(@RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "10") int pageSize,
                           @RequestParam(required = false) String status,
                           @RequestParam(required = false) String searchType,
                           @RequestParam(required = false) String searchKeyword,
                           @RequestParam(required = false) String startDate,
                           @RequestParam(required = false) String endDate,
                           HttpSession session,
                           Model model) {
        // 관리자 권한 체크
        if (!userService.isAdmin(session)) {
            return "redirect:/";
        }
        
        try {
            Map<String, Object> params = new HashMap<>();
            params.put("page", page);
            params.put("pageSize", pageSize);
            params.put("status", status);
            params.put("searchType", searchType);
            params.put("searchKeyword", searchKeyword);
            
            // 날짜 파라미터 처리
            if (startDate != null && !startDate.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                params.put("startDate", sdf.parse(startDate));
            }
            if (endDate != null && !endDate.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                params.put("endDate", sdf.parse(endDate));
            }
            
            Map<String, Object> result = consultationService.getConsultationsForAdmin(params);
            
            model.addAttribute("consultations", result.get("consultations"));
            model.addAttribute("totalCount", result.get("totalCount"));
            model.addAttribute("currentPage", result.get("currentPage"));
            model.addAttribute("pageSize", result.get("pageSize"));
            model.addAttribute("totalPages", result.get("totalPages"));
            
            // 검색 조건 유지
            model.addAttribute("status", status);
            model.addAttribute("searchType", searchType);
            model.addAttribute("searchKeyword", searchKeyword);
            model.addAttribute("startDate", startDate);
            model.addAttribute("endDate", endDate);
            
            return "support/consultation/admin/list";
            
        } catch (Exception e) {
            log.error("관리자 상담예약 목록 조회 실패: {}", e.getMessage());
            model.addAttribute("message", "목록을 조회할 수 없습니다.");
            model.addAttribute("messageType", "error");
            return "support/consultation/admin/main";
        }
    }
    
    /**
     * 관리자 - 상담예약 상세 보기
     */
    @GetMapping("/admin/detail")
    public String adminDetail(@RequestParam Long consultationNum,
                             HttpSession session,
                             Model model,
                             RedirectAttributes rttr) {
        // 관리자 권한 체크
        if (!userService.isAdmin(session)) {
            return "redirect:/";
        }
        
        try {
            ConsultationVO consultation = consultationService.getConsultation(consultationNum);
            
            if (consultation == null) {
                rttr.addFlashAttribute("message", "존재하지 않는 예약입니다.");
                rttr.addFlashAttribute("messageType", "error");
                return "redirect:/support/consultation/admin/list";
            }
            
            model.addAttribute("consultation", consultation);
            
            return "support/consultation/admin/detail";
            
        } catch (Exception e) {
            log.error("관리자 상담예약 상세 조회 실패: {}", e.getMessage());
            rttr.addFlashAttribute("message", "예약 정보를 조회할 수 없습니다.");
            rttr.addFlashAttribute("messageType", "error");
            return "redirect:/support/consultation/admin/list";
        }
    }
    
    /**
     * 관리자 - 상담예약 상태 변경
     */
    @PostMapping("/admin/status")
    @ResponseBody
    public Map<String, Object> adminUpdateStatus(@RequestParam Long consultationNum,
                                                @RequestParam String status,
                                                HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 관리자 권한 체크
            if (!userService.isAdmin(session)) {
                result.put("success", false);
                result.put("message", "관리자 권한이 필요합니다.");
                return result;
            }
            
            // 상태 업데이트 로직 구현 필요
            // consultationDAO.updateConsultationStatus(consultationNum, status);
            
            result.put("success", true);
            result.put("message", "상태가 변경되었습니다.");
            
        } catch (Exception e) {
            log.error("관리자 상담예약 상태 변경 실패: {}", e.getMessage());
            result.put("success", false);
            result.put("message", "상태 변경에 실패했습니다.");
        }
        
        return result;
    }
    
    /**
     * 관리자 - 오늘의 상담 목록 (대시보드용)
     */
    @GetMapping("/admin/today")
    @ResponseBody
    public Map<String, Object> adminTodayConsultations(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 관리자 권한 체크
            if (!userService.isAdmin(session)) {
                result.put("success", false);
                result.put("message", "관리자 권한이 필요합니다.");
                return result;
            }
            
            // 오늘의 상담 목록 조회 로직 구현
            // List<ConsultationVO> todayConsultations = consultationDAO.selectTodayConsultations();
            
            result.put("success", true);
            // result.put("consultations", todayConsultations);
            
        } catch (Exception e) {
            log.error("오늘의 상담 목록 조회 실패: {}", e.getMessage());
            result.put("success", false);
            result.put("message", "목록을 조회할 수 없습니다.");
        }
        
        return result;
    }
}