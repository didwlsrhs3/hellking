package net.koreate.hellking.designbody.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.koreate.hellking.chain.service.ChainService;
import net.koreate.hellking.chain.vo.ChainVO;
import net.koreate.hellking.designbody.service.ChainProgramService;
import net.koreate.hellking.designbody.vo.ChainProgramVO;
import net.koreate.hellking.designbody.vo.DesignBodyEnrollVO;
import net.koreate.hellking.user.service.UserService;

/**
 * 체인점 프로그램 관련 컨트롤러
 */
@Controller
@RequestMapping("/designbody/chain/")
public class ChainProgramController {
    
    @Autowired
    private ChainProgramService chainProgramService;
    
    @Autowired
    private ChainService chainService;
    
    @Autowired
    private UserService userService;
    
    // ===== 체인점 프로그램 메인 페이지 =====
    
    /**
     * 체인점 프로그램 메인 페이지
     */
    @GetMapping("")
    public String chainProgramMain(Model model) {
        try {
            Map<String, Object> recommended = chainProgramService.getRecommendedChainPrograms();
            List<Map<String, Object>> chainStats = chainProgramService.getChainProgramStatistics();
            List<ChainVO> allChains = chainService.getAllChains();
            
            model.addAttribute("recommended", recommended);
            model.addAttribute("chainStats", chainStats);
            model.addAttribute("chains", allChains);
            
            return "designbody/chain/main";
        } catch (Exception e) {
            model.addAttribute("error", "페이지를 불러오는 중 오류가 발생했습니다.");
            return "designbody/chain/main";
        }
    }
    
    // ===== 프로그램 목록 및 검색 =====
    
    /**
     * 전체 체인점 프로그램 목록
     */
    @GetMapping("programs")
    public String allChainPrograms(@RequestParam(required = false) String type,
                                  @RequestParam(required = false) String region,
                                  @RequestParam(required = false) String difficulty,
                                  @RequestParam(required = false) String keyword,
                                  @RequestParam(required = false) String sortBy,
                                  Model model) {
        try {
            Map<String, Object> searchResult = chainProgramService.searchProgramsWithFilters(
                keyword, type, region, difficulty, null, null, sortBy
            );
            
            List<ChainVO> allChains = chainService.getAllChains();
            
            model.addAttribute("programs", searchResult.get("programs"));
            model.addAttribute("totalCount", searchResult.get("totalCount"));
            model.addAttribute("chains", allChains);
            model.addAttribute("currentType", type);
            model.addAttribute("currentRegion", region);
            model.addAttribute("currentDifficulty", difficulty);
            model.addAttribute("currentKeyword", keyword);
            model.addAttribute("currentSortBy", sortBy);
            
            return "designbody/chain/programs";
        } catch (Exception e) {
            model.addAttribute("error", "프로그램 목록을 불러오는 중 오류가 발생했습니다.");
            model.addAttribute("programs", List.of());
            return "designbody/chain/programs";
        }
    }
    
    /**
     * 특정 체인점의 프로그램 목록
     */
    @GetMapping("chain/{chainNum}")
    public String chainPrograms(@PathVariable Long chainNum, Model model) {
        try {
            ChainVO chain = chainService.getChainDetail(chainNum);
            List<ChainProgramVO> programs = chainProgramService.getProgramsByChain(chainNum);
            Map<String, Object> chainStats = chainProgramService.getChainStatistics(chainNum);
            
            model.addAttribute("chain", chain);
            model.addAttribute("programs", programs);
            model.addAttribute("chainStats", chainStats);
            
            return "designbody/chain/chain-programs";
        } catch (Exception e) {
            model.addAttribute("error", "체인점 정보를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/designbody/chain/programs";
        }
    }
    
    /**
     * 프로그램 타입별 목록
     */
    @GetMapping("type/{type}")
    public String programsByType(@PathVariable String type, Model model) {
        try {
            List<ChainProgramVO> programs = chainProgramService.getProgramsByType(type);
            
            String typeText = getTypeText(type);
            
            model.addAttribute("programs", programs);
            model.addAttribute("currentType", type.toUpperCase());
            model.addAttribute("typeText", typeText);
            
            return "designbody/chain/type";
        } catch (Exception e) {
            model.addAttribute("error", "프로그램을 불러오는 중 오류가 발생했습니다.");
            model.addAttribute("programs", List.of());
            return "designbody/chain/type";
        }
    }
    
    // ===== 프로그램 상세 및 신청 =====
    
    /**
     * 체인점 프로그램 상세
     */
    @GetMapping("detail/{programNum}")
    public String programDetail(@PathVariable Long programNum, Model model, HttpSession session) {
        try {
            ChainProgramVO program = chainProgramService.getChainProgramDetail(programNum);
            ChainVO chain = chainService.getChainDetail(program.getChainNum());
            
            // 현재 사용자의 신청 여부 확인
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum != null) {
                List<DesignBodyEnrollVO> userEnrollments = chainProgramService.getUserChainEnrollments(userNum);
                boolean alreadyEnrolled = userEnrollments.stream()
                    .anyMatch(e -> e.getProgramNum().equals(programNum) && 
                                  e.getChainNum().equals(program.getChainNum()) && 
                                  "ACTIVE".equals(e.getStatus()));
                model.addAttribute("alreadyEnrolled", alreadyEnrolled);
            }
            
            // 같은 체인점의 다른 프로그램
            List<ChainProgramVO> otherPrograms = chainProgramService.getProgramsByChain(program.getChainNum())
                .stream()
                .filter(p -> !p.getProgramNum().equals(programNum))
                .limit(3)
                .collect(java.util.stream.Collectors.toList());
            
            model.addAttribute("program", program);
            model.addAttribute("chain", chain);
            model.addAttribute("otherPrograms", otherPrograms);
            
            return "designbody/chain/detail";
        } catch (Exception e) {
            model.addAttribute("error", "프로그램 정보를 불러오는 중 오류가 발생했습니다.");
            return "redirect:/designbody/chain/programs";
        }
    }
    
    /**
     * 체인점 프로그램 신청
     */
    @PostMapping("enroll")
    @ResponseBody
    public Map<String, Object> enrollProgram(@RequestParam Long programNum,
                                           @RequestParam Long chainNum,
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
            
            boolean success = chainProgramService.enrollChainProgram(userNum, programNum, chainNum, paymentId);
            result.put("success", success);
            result.put("message", success ? "프로그램 신청이 완료되었습니다!" : "신청에 실패했습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    // ===== 위치 기반 검색 =====
    
    /**
     * 근처 체인점 프로그램 검색
     */
    @GetMapping("nearby")
    public String nearbyPrograms(@RequestParam(required = false, defaultValue = "37.5665") Double latitude,
                               @RequestParam(required = false, defaultValue = "126.9780") Double longitude,
                               @RequestParam(required = false, defaultValue = "10") Integer radius,
                               @RequestParam(required = false) String type,
                               @RequestParam(required = false, defaultValue = "distance") String sortBy,
                               Model model) {
        try {
            Map<String, Object> searchResult = chainProgramService.searchNearbyPrograms(
                latitude, longitude, radius, type, sortBy
            );
            
            model.addAttribute("programs", searchResult.get("programs"));
            model.addAttribute("totalCount", searchResult.get("totalCount"));
            model.addAttribute("searchLatitude", latitude);
            model.addAttribute("searchLongitude", longitude);
            model.addAttribute("searchRadius", radius);
            model.addAttribute("currentType", type);
            model.addAttribute("currentSortBy", sortBy);
            
            return "designbody/chain/nearby";
        } catch (Exception e) {
            model.addAttribute("error", "근처 프로그램 검색 중 오류가 발생했습니다.");
            model.addAttribute("programs", List.of());
            return "designbody/chain/nearby";
        }
    }
    
    /**
     * AJAX - 근처 프로그램 검색
     */
    @GetMapping("api/nearby")
    @ResponseBody
    public Map<String, Object> searchNearbyAPI(@RequestParam Double latitude,
                                              @RequestParam Double longitude,
                                              @RequestParam(defaultValue = "10") Integer radius,
                                              @RequestParam(required = false) String type,
                                              @RequestParam(defaultValue = "distance") String sortBy) {
        try {
            return chainProgramService.searchNearbyPrograms(latitude, longitude, radius, type, sortBy);
        } catch (Exception e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("programs", List.of());
            result.put("message", "검색 중 오류가 발생했습니다.");
            return result;
        }
    }
    
    // ===== 개인 프로그램 관리 =====
    
    /**
     * 내 체인점 프로그램 관리
     */
    @GetMapping("my")
    public String myChainPrograms(HttpSession session, Model model) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            List<DesignBodyEnrollVO> myEnrollments = chainProgramService.getUserChainEnrollments(userNum);
            
            // 진행중인 프로그램과 완료된 프로그램 분리
            List<DesignBodyEnrollVO> activeEnrollments = myEnrollments.stream()
                .filter(e -> "ACTIVE".equals(e.getStatus()))
                .collect(java.util.stream.Collectors.toList());
            
            List<DesignBodyEnrollVO> completedEnrollments = myEnrollments.stream()
                .filter(e -> "COMPLETED".equals(e.getStatus()))
                .collect(java.util.stream.Collectors.toList());
            
            // 통계 정보
            Map<String, Object> stats = new HashMap<>();
            stats.put("totalCount", myEnrollments.size());
            stats.put("activeCount", activeEnrollments.size());
            stats.put("completedCount", completedEnrollments.size());
            
            model.addAttribute("myEnrollments", myEnrollments);
            model.addAttribute("activeEnrollments", activeEnrollments);
            model.addAttribute("completedEnrollments", completedEnrollments);
            model.addAttribute("stats", stats);
            
            return "designbody/chain/my";
        } catch (Exception e) {
            model.addAttribute("error", "내 프로그램 정보를 불러오는 중 오류가 발생했습니다.");
            return "designbody/chain/my";
        }
    }
    
    // ===== AJAX API =====
    
    /**
     * 프로그램 간단 정보 조회 (AJAX)
     */
    @GetMapping("api/program/{programNum}")
    @ResponseBody
    public Map<String, Object> getProgramInfo(@PathVariable Long programNum) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            ChainProgramVO program = chainProgramService.getChainProgramDetail(programNum);
            result.put("success", true);
            result.put("program", program);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "프로그램 정보를 불러올 수 없습니다.");
        }
        
        return result;
    }
    
    /**
     * 체인점별 프로그램 목록 조회 (AJAX)
     */
    @GetMapping("api/chain/{chainNum}/programs")
    @ResponseBody
    public Map<String, Object> getChainProgramsAPI(@PathVariable Long chainNum) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            List<ChainProgramVO> programs = chainProgramService.getProgramsByChain(chainNum);
            result.put("success", true);
            result.put("programs", programs);
            result.put("totalCount", programs.size());
        } catch (Exception e) {
            result.put("success", false);
            result.put("programs", List.of());
            result.put("message", "프로그램 목록을 불러올 수 없습니다.");
        }
        
        return result;
    }
    
    /**
     * 프로그램 검색 (AJAX)
     */
    @GetMapping("api/search")
    @ResponseBody
    public Map<String, Object> searchProgramsAPI(@RequestParam(required = false) String keyword,
                                                @RequestParam(required = false) String type,
                                                @RequestParam(required = false) String region,
                                                @RequestParam(required = false) String difficulty,
                                                @RequestParam(required = false) Long minPrice,
                                                @RequestParam(required = false) Long maxPrice,
                                                @RequestParam(required = false) String sortBy) {
        try {
            return chainProgramService.searchProgramsWithFilters(
                keyword, type, region, difficulty, minPrice, maxPrice, sortBy
            );
        } catch (Exception e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("programs", List.of());
            result.put("message", "검색 중 오류가 발생했습니다.");
            return result;
        }
    }
    
    // ===== 유틸리티 메서드 =====
    
    /**
     * 프로그램 타입 텍스트 변환
     */
    private String getTypeText(String type) {
        if (type == null) return "전체";
        
        switch (type.toUpperCase()) {
            case "DIET": return "다이어트";
            case "MUSCLE": return "근력강화";
            case "CARDIO": return "유산소";
            case "REHAB": return "재활운동";
            default: return "전체";
        }
    }
}