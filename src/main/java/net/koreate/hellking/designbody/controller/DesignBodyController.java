package net.koreate.hellking.designbody.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import net.koreate.hellking.designbody.service.DesignBodyService;
import net.koreate.hellking.designbody.vo.*;
import net.koreate.hellking.user.service.UserService;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/designbody/")
public class DesignBodyController {
    
    @Autowired
    private DesignBodyService designBodyService;
    
    @Autowired
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
            
            boolean success = designBodyService.enrollProgram(userNum, programNum, paymentId);
            result.put("success", success);
            result.put("message", success ? "프로그램 신청이 완료되었습니다!" : "신청에 실패했습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    // 내 프로그램 관리
    @GetMapping("my")
    public String myPrograms(HttpSession session, Model model) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
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
    @GetMapping("info/{programNum}")
    @ResponseBody
    public Map<String, Object> programInfo(@PathVariable Long programNum) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            DesignBodyVO program = designBodyService.getProgramDetail(programNum);
            result.put("success", true);
            result.put("program", program);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "프로그램 정보를 불러올 수 없습니다.");
        }
        
        return result;
    }
}