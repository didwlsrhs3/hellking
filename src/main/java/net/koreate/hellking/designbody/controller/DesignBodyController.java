package net.koreate.hellking.designbody.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import net.koreate.hellking.designbody.service.DesignBodyService;
<<<<<<< HEAD
=======
import net.koreate.hellking.designbody.service.ChainProgramService;
>>>>>>> b65c320 (Initial commit)
import net.koreate.hellking.designbody.vo.*;
import net.koreate.hellking.user.service.UserService;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

<<<<<<< HEAD
=======
/**
 * 디자인바디 컨트롤러 (기본 + 체인점 통합 버전)
 */
>>>>>>> b65c320 (Initial commit)
@Controller
@RequestMapping("/designbody/")
public class DesignBodyController {
    
    @Autowired
    private DesignBodyService designBodyService;
    
    @Autowired
<<<<<<< HEAD
    private UserService userService;
    
    // 디자인바디 메인 페이지
    @GetMapping("")
    public String main(Model model) {
        List<DesignBodyVO> allPrograms = designBodyService.getAllPrograms();
        Map<String, Object> recommended = designBodyService.getRecommendedPrograms();
        Map<String, Object> stats = designBodyService.getStatistics();
        
        model.addAttribute("programs", allPrograms);
        model.addAttribute("recommended", recommended);
        model.addAttribute("stats", stats);
        
        return "designbody/main";
    }
    
    // 프로그램 목록
    @GetMapping("programs")
    public String programs(@RequestParam(required = false) String type,
=======
    private ChainProgramService chainProgramService;
    
    @Autowired
    private UserService userService;
    
    // ===== 메인 페이지 =====
    
    /**
     * 디자인바디 메인 페이지 (체인점 프로그램 중심으로 변경)
     */
    @GetMapping("")
    public String main(Model model) {
        try {
            // 체인점 프로그램 추천
            Map<String, Object> chainRecommended = chainProgramService.getRecommendedChainPrograms();
            List<Map<String, Object>> chainStats = chainProgramService.getChainProgramStatistics();
            
            // 기존 통계도 유지
            Map<String, Object> stats = designBodyService.getStatistics();
            
            model.addAttribute("chainRecommended", chainRecommended);
            model.addAttribute("chainStats", chainStats);
            model.addAttribute("stats", stats);
            
            return "designbody/main";
        } catch (Exception e) {
            model.addAttribute("error", "페이지를 불러오는 중 오류가 발생했습니다.");
            return "designbody/main";
        }
    }
    
    // ===== 기존 방식(본사 직영) 프로그램 유지 =====
    
    /**
     * 기존 프로그램 목록 (본사 직영용 - 체인점 정보 없는 프로그램들)
     */
    @GetMapping("programs/legacy")
    public String legacyPrograms(@RequestParam(required = false) String type,
>>>>>>> b65c320 (Initial commit)
                          @RequestParam(required = false) String difficulty,
                          Model model) {
        
        List<DesignBodyVO> programs;
        
        if (type != null && !type.isEmpty()) {
            programs = designBodyService.getProgramsByType(type);
            model.addAttribute("currentType", type);
        } else if (difficulty != null && !difficulty.isEmpty()) {
            programs = designBodyService.getProgramsByDifficulty(difficulty);
            model.addAttribute("currentDifficulty", difficulty);
        } else {
            programs = designBodyService.getAllPrograms();
        }
        
        model.addAttribute("programs", programs);
<<<<<<< HEAD
        return "designbody/programs";
    }
    
    // 프로그램 상세
    @GetMapping("detail/{programNum}")
    public String detail(@PathVariable Long programNum, Model model, HttpSession session) {
        DesignBodyVO program = designBodyService.getProgramDetail(programNum);
        
        // 현재 사용자의 신청 여부 확인
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum != null) {
            List<DesignBodyEnrollVO> userEnrollments = designBodyService.getUserEnrollments(userNum);
            boolean alreadyEnrolled = userEnrollments.stream()
                .anyMatch(e -> e.getProgramNum().equals(programNum) && "ACTIVE".equals(e.getStatus()));
            model.addAttribute("alreadyEnrolled", alreadyEnrolled);
        }
        
        model.addAttribute("program", program);
        return "designbody/detail";
    }
    
    // 프로그램 신청 처리
    @PostMapping("enroll")
    @ResponseBody
    public Map<String, Object> enroll(@RequestParam Long programNum,
=======
        return "designbody/programs-legacy";
    }
    
    // ===== 새로운 체인점 프로그램 메인 라우팅 =====
    
    /**
     * 프로그램 목록 - 체인점 프로그램으로 리다이렉트
     */
    @GetMapping("programs")
    public String programs() {
        return "redirect:/designbody/chain/programs";
    }
    
    /**
     * 프로그램 상세 - 체인점 프로그램인지 확인 후 적절히 라우팅
     */
    @GetMapping("detail/{programNum}")
    public String detail(@PathVariable Long programNum, Model model, HttpSession session) {
        try {
            // 먼저 체인점 프로그램인지 확인
            ChainProgramVO chainProgram = chainProgramService.getChainProgramDetail(programNum);
            
            if (chainProgram != null && chainProgram.getChainNum() != null) {
                // 체인점 프로그램이면 체인점 컨트롤러로 리다이렉트
                return "redirect:/designbody/chain/detail/" + programNum;
            } else {
                // 기존 본사 직영 프로그램
                DesignBodyVO program = designBodyService.getProgramDetail(programNum);
                
                // 현재 사용자의 신청 여부 확인
                Long userNum = userService.getCurrentUserNum(session);
                if (userNum != null) {
                    List<DesignBodyEnrollVO> userEnrollments = designBodyService.getUserEnrollments(userNum);
                    boolean alreadyEnrolled = userEnrollments.stream()
                        .anyMatch(e -> e.getProgramNum().equals(programNum) && "ACTIVE".equals(e.getStatus()));
                    model.addAttribute("alreadyEnrolled", alreadyEnrolled);
                }
                
                model.addAttribute("program", program);
                return "designbody/detail-legacy";
            }
        } catch (Exception e) {
            // 체인점 프로그램이 아니면 기존 방식으로 시도
            try {
                DesignBodyVO program = designBodyService.getProgramDetail(programNum);
                
                Long userNum = userService.getCurrentUserNum(session);
                if (userNum != null) {
                    List<DesignBodyEnrollVO> userEnrollments = designBodyService.getUserEnrollments(userNum);
                    boolean alreadyEnrolled = userEnrollments.stream()
                    	    .filter(enrollment -> "ACTIVE".equals(enrollment.getStatus()))
                    	    .anyMatch(enrollment -> enrollment.getProgramNum().equals(programNum));
                    model.addAttribute("alreadyEnrolled", alreadyEnrolled);
                }
                
                model.addAttribute("program", program);
                return "designbody/detail-legacy";
            } catch (Exception ex) {
                model.addAttribute("error", "프로그램 정보를 찾을 수 없습니다.");
                return "redirect:/designbody/chain/programs";
            }
        }
    }
    
    /**
     * 프로그램 타입별 - 체인점 프로그램으로 리다이렉트
     */
    @GetMapping("type/{type}")
    public String programsByType(@PathVariable String type) {
        return "redirect:/designbody/chain/type/" + type;
    }
    
    /**
     * 인기 프로그램 - 체인점 프로그램으로 리다이렉트
     */
    @GetMapping("popular")
    public String popular() {
        return "redirect:/designbody/chain/programs?sortBy=popular";
    }
    
    // ===== 프로그램 신청 처리 =====
    
    /**
     * 프로그램 신청 처리 (기존 + 체인점 통합)
     */
    @PostMapping("enroll")
    @ResponseBody
    public Map<String, Object> enroll(@RequestParam Long programNum,
                                     @RequestParam(required = false) Long chainNum,
>>>>>>> b65c320 (Initial commit)
                                     @RequestParam(required = false) String paymentId,
                                     HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
<<<<<<< HEAD
            boolean success = designBodyService.enrollProgram(userNum, programNum, paymentId);
=======
            boolean success;
            
            if (chainNum != null) {
                // 체인점 프로그램 신청
                success = chainProgramService.enrollChainProgram(userNum, programNum, chainNum, paymentId);
            } else {
                // 기존 본사 직영 프로그램 신청
                success = designBodyService.enrollProgram(userNum, programNum, paymentId);
            }
            
>>>>>>> b65c320 (Initial commit)
            result.put("success", success);
            result.put("message", success ? "프로그램 신청이 완료되었습니다!" : "신청에 실패했습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
<<<<<<< HEAD
    // 내 프로그램 관리
    @GetMapping("my")
    public String myPrograms(HttpSession session, Model model) {
=======
    // ===== 개인 프로그램 관리 =====
    
    /**
     * 내 프로그램 관리 - 체인점 프로그램으로 리다이렉트
     */
    @GetMapping("my")
    public String myPrograms() {
        return "redirect:/designbody/chain/my";
    }
    
    /**
     * 기존 내 프로그램 관리 (본사 직영용)
     */
    @GetMapping("my/legacy")
    public String myLegacyPrograms(HttpSession session, Model model) {
>>>>>>> b65c320 (Initial commit)
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
<<<<<<< HEAD
        List<DesignBodyEnrollVO> myEnrollments = designBodyService.getUserEnrollments(userNum);
        List<DesignBodyEnrollVO> activeEnrollments = designBodyService.getActiveEnrollments(userNum);
        Map<String, Object> stats = designBodyService.getUserProgramStats(userNum);
        
        model.addAttribute("myEnrollments", myEnrollments);
        model.addAttribute("activeEnrollments", activeEnrollments);
        model.addAttribute("stats", stats);
        
        return "designbody/my";
    }
    
    // 프로그램 타입별 필터링
    @GetMapping("type/{type}")
    public String programsByType(@PathVariable String type, Model model) {
        List<DesignBodyVO> programs = designBodyService.getProgramsByType(type.toUpperCase());
        
        String typeText = "";
        switch (type.toUpperCase()) {
            case "DIET": typeText = "다이어트"; break;
            case "MUSCLE": typeText = "근력강화"; break;
            case "CARDIO": typeText = "유산소"; break;
            case "REHAB": typeText = "재활운동"; break;
        }
        
        model.addAttribute("programs", programs);
        model.addAttribute("currentType", type.toUpperCase());
        model.addAttribute("typeText", typeText);
        
        return "designbody/type";
    }
    
    // 인기 프로그램
    @GetMapping("popular")
    public String popular(Model model) {
        List<DesignBodyVO> popularPrograms = designBodyService.getPopularPrograms(12);
        model.addAttribute("programs", popularPrograms);
        return "designbody/popular";
    }
    
    // AJAX - 프로그램 간단 정보
=======
        try {
            List<DesignBodyEnrollVO> myEnrollments = designBodyService.getUserEnrollments(userNum);
            List<DesignBodyEnrollVO> activeEnrollments = designBodyService.getActiveEnrollments(userNum);
            Map<String, Object> stats = designBodyService.getUserProgramStats(userNum);
            
            model.addAttribute("myEnrollments", myEnrollments);
            model.addAttribute("activeEnrollments", activeEnrollments);
            model.addAttribute("stats", stats);
            
            return "designbody/my-legacy";
        } catch (Exception e) {
            model.addAttribute("error", "내 프로그램 정보를 불러오는 중 오류가 발생했습니다.");
            return "designbody/my-legacy";
        }
    }
    
    // ===== AJAX API - 기존 호환성 유지 =====
    
    /**
     * AJAX - 프로그램 간단 정보
     */
>>>>>>> b65c320 (Initial commit)
    @GetMapping("info/{programNum}")
    @ResponseBody
    public Map<String, Object> programInfo(@PathVariable Long programNum) {
        Map<String, Object> result = new HashMap<>();
        
        try {
<<<<<<< HEAD
            DesignBodyVO program = designBodyService.getProgramDetail(programNum);
            result.put("success", true);
            result.put("program", program);
=======
            // 먼저 체인점 프로그램인지 확인
            try {
                ChainProgramVO chainProgram = chainProgramService.getChainProgramDetail(programNum);
                if (chainProgram != null && chainProgram.getChainNum() != null) {
                    result.put("success", true);
                    result.put("program", chainProgram);
                    result.put("isChainProgram", true);
                    return result;
                }
            } catch (Exception e) {
                // 체인점 프로그램이 아니면 기존 방식으로 시도
            }
            
            // 기존 본사 직영 프로그램
            DesignBodyVO program = designBodyService.getProgramDetail(programNum);
            result.put("success", true);
            result.put("program", program);
            result.put("isChainProgram", false);
            
>>>>>>> b65c320 (Initial commit)
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "프로그램 정보를 불러올 수 없습니다.");
        }
        
        return result;
    }
<<<<<<< HEAD
=======
    
    // ===== 관리자용 기능 (필요시) =====
    
    /**
     * 관리자용 - 프로그램 통계
     */
    @GetMapping("admin/stats")
    @ResponseBody
    public Map<String, Object> getAdminStats(HttpSession session) {
        // 관리자 권한 체크
        if (!userService.isAdmin(session)) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "관리자 권한이 필요합니다.");
            return result;
        }
        
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 기존 본사 직영 프로그램 통계
            Map<String, Object> legacyStats = designBodyService.getStatistics();
            
            // 체인점 프로그램 통계
            List<Map<String, Object>> chainStats = chainProgramService.getChainProgramStatistics();
            
            result.put("success", true);
            result.put("legacyStats", legacyStats);
            result.put("chainStats", chainStats);
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "통계 조회 중 오류가 발생했습니다.");
        }
        
        return result;
    }
>>>>>>> b65c320 (Initial commit)
}