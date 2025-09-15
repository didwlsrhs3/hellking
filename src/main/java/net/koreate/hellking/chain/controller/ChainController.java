package net.koreate.hellking.chain.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import net.koreate.hellking.chain.service.ChainService;
import net.koreate.hellking.chain.vo.ChainVO;
import net.koreate.hellking.chain.vo.ChainSearchVO;
import net.koreate.hellking.user.service.UserService;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/chain/")
public class ChainController {
    
    @Autowired
    private ChainService chainService;
    
    @Autowired
    private UserService userService;
    
    // 가맹점 목록 페이지
    @GetMapping("list")
    public String list(Model model) {
        List<ChainVO> chains = chainService.getAllChains();
        Map<String, Object> recommended = chainService.getRecommendedChains();
        Map<String, Object> stats = chainService.getStatistics();
        
        model.addAttribute("chains", chains);
        model.addAttribute("recommended", recommended);
        model.addAttribute("stats", stats);
        
        return "chain/list";
    }
    
    // 가맹점 검색
    @GetMapping("search")
    public String search(ChainSearchVO searchVO, Model model) {
        if (searchVO.getKeyword() != null && !searchVO.getKeyword().trim().isEmpty()) {
            Map<String, Object> searchResult = chainService.searchChains(searchVO);
            model.addAttribute("searchResult", searchResult);
            model.addAttribute("searchVO", searchVO);
        }
        
        return "chain/search";
    }
    
    // 가맹점 상세 페이지
    @GetMapping("detail/{chainNum}")
    public String detail(@PathVariable Long chainNum, Model model, HttpSession session) {
        ChainVO chain = chainService.getChainDetail(chainNum);
        
        // 현재 사용자의 활성 패스권 확인
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum != null) {
            // 사용자의 활성 패스권 정보를 가져와서 QR 입장 가능 여부 체크
            model.addAttribute("canEnter", true); // 패스권 체크 로직
        }
        
        model.addAttribute("chain", chain);
        return "chain/detail";
    }
    
    // 지역별 가맹점
    @GetMapping("region/{region}")
    public String region(@PathVariable String region, Model model) {
        List<ChainVO> chains = chainService.getChainsByRegion(region);
        model.addAttribute("chains", chains);
        model.addAttribute("region", region);
        return "chain/region";
    }
    
    // 인기 가맹점
    @GetMapping("popular")
    public String popular(Model model) {
        List<ChainVO> popularChains = chainService.getPopularChains(20);
        List<ChainVO> topRatedChains = chainService.getTopRatedChains(20);
        
        model.addAttribute("popularChains", popularChains);
        model.addAttribute("topRatedChains", topRatedChains);
        
        return "chain/popular";
    }
    
    // AJAX - 가맹점 검색 자동완성
    @GetMapping("suggest")
    @ResponseBody
    public Map<String, Object> suggest(@RequestParam String keyword) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            System.out.println("=== 가맹점 검색 디버깅 ===");
            System.out.println("검색 키워드: " + keyword);
            
            ChainSearchVO searchVO = new ChainSearchVO();
            searchVO.setKeyword(keyword);
            searchVO.setSize(5); // 자동완성은 5개만
            
            System.out.println("SearchVO 생성 완료: " + searchVO.getKeyword());
            
            Map<String, Object> searchResult = chainService.searchChains(searchVO);
            System.out.println("서비스 호출 완료, 결과: " + searchResult);
            
            result.put("success", true);
            result.put("chains", searchResult.get("chains"));
            
            System.out.println("검색 완료, 반환할 가맹점 수: " + ((List)searchResult.get("chains")).size());
            System.out.println("========================");
            
        } catch (Exception e) {
            System.out.println("!!! 검색 중 예외 발생 !!!");
            System.out.println("예외 타입: " + e.getClass().getSimpleName());
            System.out.println("예외 메시지: " + e.getMessage());
            e.printStackTrace();
            System.out.println("========================");
            
            result.put("success", false);
            result.put("message", "검색 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }
    
    // AJAX - 가맹점 코드 유효성 검사
    @PostMapping("validateCode")
    @ResponseBody
    public Map<String, Object> validateCode(@RequestParam String chainCode) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean isValid = chainService.isValidChainCode(chainCode);
            result.put("success", true);
            result.put("valid", isValid);
            
            if (isValid) {
                ChainVO chain = chainService.getChainByCode(chainCode);
                result.put("chainName", chain.getChainName());
                result.put("address", chain.getAddress());
            }
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "코드 확인 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    // 내 주변 가맹점 (위치 기반)
    @GetMapping("nearby")
    public String nearby(Model model) {
        // 위치 기반 검색 페이지 (JavaScript로 위치 정보 받아서 처리)
        return "chain/nearby";
    }
    
    // AJAX - 위치 기반 가맹점 검색
    @PostMapping("nearbySearch")
    @ResponseBody
    public Map<String, Object> nearbySearch(@RequestParam double latitude, 
                                           @RequestParam double longitude,
                                           @RequestParam(defaultValue = "10") int radius) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 실제로는 위치 기반 검색 로직 구현 필요
            // 여기서는 전체 가맹점을 반환 (2주 프로젝트 범위)
            List<ChainVO> chains = chainService.getAllChains();
            
            result.put("success", true);
            result.put("chains", chains);
            result.put("message", "주변 가맹점을 찾았습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "위치 검색 중 오류가 발생했습니다.");
        }
        
        return result;
    }
}