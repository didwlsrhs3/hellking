package net.koreate.hellking.chain.controller;

import org.springframework.beans.factory.annotation.Autowired;
<<<<<<< HEAD
=======
import org.springframework.beans.factory.annotation.Value;
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
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
=======
    @Value("${kakao.map.api-key:YOUR_API_KEY}")
    private String kakaoMapApiKey;
    
    // 가맹점 목록 페이지

	 @GetMapping("list")
	 public String list(@RequestParam(defaultValue = "rating_desc") String sortBy,
	                    @RequestParam(defaultValue = "1") int page,
	                    @RequestParam(defaultValue = "6") int size,
	                    Model model) {
	     
	     // 정렬 기준 검증
	     sortBy = chainService.validateSortBy(sortBy);
	     
	     // 페이징 적용된 가맹점 목록 조회
	     Map<String, Object> result = chainService.getChainsWithRatingSort(sortBy, page, size);
	     
	     // 추천 가맹점과 통계는 기존대로 유지
	     Map<String, Object> recommended = chainService.getRecommendedChains();
	     Map<String, Object> stats = chainService.getStatistics();
	     
	     // 페이지 네비게이션 정보 생성
	     Map<String, Object> pageNav = chainService.createPageNavigation(
	         (Integer) result.get("currentPage"), 
	         (Integer) result.get("totalPages"), 
	         5  // 5개 페이지 번호 표시
	     );
	     
	     // ===== 평점 디버그 로그 추가 (기존 코드 유지) =====
	     System.out.println("=== 가맹점 리스트 평점 확인 ===");
	     List<ChainVO> chains = (List<ChainVO>) result.get("chains");
	     for (ChainVO chain : chains) {
	         System.out.println(chain.getChainName() + " - 평점: " + chain.getAvgRating() + ", 리뷰수: " + chain.getReviewCount());
	     }
	     System.out.println("=============================");
	     
	     // ===== 페이징 디버그 로그 =====
	     System.out.println("=== 가맹점 리스트 페이징 처리 ===");
	     System.out.println("정렬기준: " + sortBy + " (" + chainService.getSortByDescription(sortBy) + ")");
	     System.out.println("현재페이지: " + result.get("currentPage") + "/" + result.get("totalPages"));
	     System.out.println("총 가맹점 수: " + result.get("totalCount"));
	     System.out.println("이번 페이지 가맹점 수: " + chains.size());
	     System.out.println("==============================");
	     
	     // 모델에 데이터 추가
	     model.addAttribute("chains", result.get("chains"));
	     model.addAttribute("currentPage", result.get("currentPage"));
	     model.addAttribute("totalPages", result.get("totalPages"));
	     model.addAttribute("totalCount", result.get("totalCount"));
	     model.addAttribute("hasNext", result.get("hasNext"));
	     model.addAttribute("hasPrev", result.get("hasPrev"));
	     model.addAttribute("sortBy", sortBy);
	     model.addAttribute("sortDescription", chainService.getSortByDescription(sortBy));
	     model.addAttribute("pageNav", pageNav);
	     
	     // 기존 데이터 유지
	     model.addAttribute("recommended", recommended);
	     model.addAttribute("stats", stats);
	     
	     return "chain/list";
	 }

    // 검색 메서드도 평점별 정렬 지원으로 개선
    @GetMapping("search")
    public String search(@RequestParam(required = false) String keyword,
                         @RequestParam(defaultValue = "rating_desc") String sortBy,
                         @RequestParam(defaultValue = "1") int page,
                         @RequestParam(defaultValue = "6") int size,
                         Model model) {
        
        // 검색어가 있는 경우에만 검색 실행
        if (keyword != null && !keyword.trim().isEmpty()) {
            // 정렬 기준 검증
            sortBy = chainService.validateSortBy(sortBy);
            
            // 검색 및 페이징 처리
            Map<String, Object> searchResult = chainService.searchChainsWithSort(keyword, sortBy, page, size);
            
            // 페이지 네비게이션 생성
            Map<String, Object> pageNav = chainService.createPageNavigation(
                (Integer) searchResult.get("currentPage"),
                (Integer) searchResult.get("totalPages"),
                5
            );
            
            // ===== 디버그 로그 =====
            System.out.println("=== 가맹점 검색 결과 ===");
            System.out.println("검색어: " + keyword);
            System.out.println("정렬: " + sortBy + " (" + chainService.getSortByDescription(sortBy) + ")");
            System.out.println("검색결과: " + searchResult.get("totalCount") + "개");
            System.out.println("현재페이지: " + searchResult.get("currentPage") + "/" + searchResult.get("totalPages"));
            System.out.println("===================");
            
            // 검색 결과를 모델에 추가
            model.addAttribute("searchResult", searchResult);
            model.addAttribute("chains", searchResult.get("chains"));
            model.addAttribute("currentPage", searchResult.get("currentPage"));
            model.addAttribute("totalPages", searchResult.get("totalPages"));
            model.addAttribute("totalCount", searchResult.get("totalCount"));
            model.addAttribute("hasNext", searchResult.get("hasNext"));
            model.addAttribute("hasPrev", searchResult.get("hasPrev"));
            model.addAttribute("pageNav", pageNav);
            model.addAttribute("sortBy", sortBy);
            model.addAttribute("sortDescription", chainService.getSortByDescription(sortBy));
            model.addAttribute("keyword", keyword);
            model.addAttribute("searched", true);
        } else {
            // 검색어가 없는 경우 빈 결과
            model.addAttribute("chains", List.of());
            model.addAttribute("totalCount", 0);
            model.addAttribute("searched", false);
        }
        
        return "chain/search";
    }    
>>>>>>> b65c320 (Initial commit)
    
    // 가맹점 상세 페이지
    @GetMapping("detail/{chainNum}")
    public String detail(@PathVariable Long chainNum, Model model, HttpSession session) {
        ChainVO chain = chainService.getChainDetail(chainNum);
        
<<<<<<< HEAD
        // 현재 사용자의 활성 패스권 확인
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum != null) {
            // 사용자의 활성 패스권 정보를 가져와서 QR 입장 가능 여부 체크
            model.addAttribute("canEnter", true); // 패스권 체크 로직
        }
        
        model.addAttribute("chain", chain);
=======
        // ===== 평점 디버그 로그 추가 =====
        System.out.println("=== 가맹점 평점 확인 ===");
        System.out.println("Chain: " + chain.getChainName());
        System.out.println("AVG Rating: " + chain.getAvgRating());
        System.out.println("Review Count: " + chain.getReviewCount());
        System.out.println("Formatted Rating: " + chain.getFormattedRating());
        System.out.println("=======================");
        
        // 현재 사용자의 활성 패스권 확인
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum != null) {
            model.addAttribute("canEnter", true);
        }
        
        model.addAttribute("chain", chain);
        model.addAttribute("kakaoMapApiKey", kakaoMapApiKey);
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
=======
    // 내 주변 가맹점 페이지
    @GetMapping("nearby")
    public String nearby(Model model) {
        model.addAttribute("kakaoMapApiKey", kakaoMapApiKey);
        return "chain/nearby";
    }
    
    // AJAX - 위치 기반 인근 가맹점 검색
    @PostMapping("nearbySearch")
    @ResponseBody
    public Map<String, Object> nearbySearch(@RequestParam double latitude, 
                                           @RequestParam double longitude,
                                           @RequestParam(defaultValue = "10") int radius,
                                           @RequestParam(defaultValue = "distance") String sortBy) {
        
        System.out.println("=== 컨트롤러: 인근 가맹점 검색 요청 ===");
        System.out.println("요청 파라미터 - 위도: " + latitude + ", 경도: " + longitude);
        System.out.println("반경: " + radius + "km, 정렬: " + sortBy);
        
        try {
            Map<String, Object> result = chainService.searchNearbyChains(latitude, longitude, radius, sortBy);
            
            System.out.println("서비스 결과: " + result);
            System.out.println("========================================");
            
            return result;
            
        } catch (Exception e) {
            System.err.println("컨트롤러에서 예외 발생: " + e.getMessage());
            e.printStackTrace();
            
            Map<String, Object> errorResult = new HashMap<>();
            errorResult.put("success", false);
            errorResult.put("chains", List.of());
            errorResult.put("totalCount", 0);
            errorResult.put("message", "위치 검색 중 오류가 발생했습니다: " + e.getMessage());
            
            return errorResult;
        }
    }
    
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
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
=======
    // AJAX - 추천 가맹점 (위치 기반)
    @PostMapping("recommended")
    @ResponseBody
    public Map<String, Object> getRecommendedChains(@RequestParam double latitude,
                                                    @RequestParam double longitude,
                                                    @RequestParam(defaultValue = "5") int limit) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            List<ChainVO> recommendedChains = chainService.getRecommendedNearbyChains(latitude, longitude, limit);
            
            result.put("success", true);
            result.put("chains", recommendedChains);
            result.put("message", "추천 가맹점을 찾았습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("chains", List.of());
            result.put("message", "추천 가맹점 조회 중 오류가 발생했습니다.");
>>>>>>> b65c320 (Initial commit)
        }
        
        return result;
    }
<<<<<<< HEAD
=======
    
    // 관리자용 - 좌표 정보 일괄 업데이트
    @PostMapping("admin/updateCoordinates")
    @ResponseBody
    public Map<String, Object> updateAllCoordinates(HttpSession session) {
        // 관리자 권한 체크 (실제 구현 시)
        // if (!isAdmin(session)) {
        //     Map<String, Object> error = new HashMap<>();
        //     error.put("success", false);
        //     error.put("message", "관리자 권한이 필요합니다.");
        //     return error;
        // }
        
        try {
            return chainService.updateAllCoordinates();
        } catch (Exception e) {
            Map<String, Object> result = new HashMap<>();
            result.put("success", false);
            result.put("message", "좌표 업데이트 중 오류가 발생했습니다: " + e.getMessage());
            return result;
        }
    }
    
    // 테스트용 - 거리 계산 확인
    @GetMapping("test/distance")
    @ResponseBody
    public Map<String, Object> testDistance(@RequestParam double lat1, @RequestParam double lng1,
                                           @RequestParam double lat2, @RequestParam double lng2) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 서비스에서 거리 계산 (KakaoMapService 사용)
            double distance = 0; // kakaoMapService.calculateDistance(lat1, lng1, lat2, lng2);
            
            result.put("success", true);
            result.put("distance", distance);
            result.put("formattedDistance", distance < 1 ? 
                String.format("%.0fm", distance * 1000) : 
                String.format("%.1fkm", distance));
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "거리 계산 중 오류: " + e.getMessage());
        }
        
        return result;
    }

    // AJAX용 페이징 처리 메서드 추가
    @PostMapping("listAjax")
    @ResponseBody
    public Map<String, Object> getChainListAjax(@RequestParam(defaultValue = "rating_desc") String sortBy,
                                               @RequestParam(defaultValue = "1") int page,
                                               @RequestParam(defaultValue = "6") int size) {
        try {
            sortBy = chainService.validateSortBy(sortBy);
            Map<String, Object> result = chainService.getChainsWithRatingSort(sortBy, page, size);
            
            // 페이지 네비게이션 추가
            Map<String, Object> pageNav = chainService.createPageNavigation(
                (Integer) result.get("currentPage"),
                (Integer) result.get("totalPages"),
                5
            );
            result.put("pageNav", pageNav);
            result.put("success", true);
            
            return result;
            
        } catch (Exception e) {
            System.err.println("AJAX 가맹점 목록 조회 오류: " + e.getMessage());
            Map<String, Object> errorResult = new HashMap<>();
            errorResult.put("success", false);
            errorResult.put("message", "가맹점 목록 조회 중 오류가 발생했습니다: " + e.getMessage());
            errorResult.put("chains", List.of());
            return errorResult;
        }
    }

    // AJAX용 검색 메서드 추가
    @PostMapping("searchAjax")
    @ResponseBody
    public Map<String, Object> searchChainsAjax(@RequestParam(required = false) String keyword,
                                              @RequestParam(defaultValue = "rating_desc") String sortBy,
                                              @RequestParam(defaultValue = "1") int page,
                                              @RequestParam(defaultValue = "6") int size) {
        try {
            if (keyword == null || keyword.trim().isEmpty()) {
                Map<String, Object> emptyResult = new HashMap<>();
                emptyResult.put("success", true);
                emptyResult.put("chains", List.of());
                emptyResult.put("totalCount", 0);
                emptyResult.put("message", "검색어를 입력해주세요.");
                return emptyResult;
            }
            
            sortBy = chainService.validateSortBy(sortBy);
            Map<String, Object> result = chainService.searchChainsWithSort(keyword, sortBy, page, size);
            
            Map<String, Object> pageNav = chainService.createPageNavigation(
                (Integer) result.get("currentPage"),
                (Integer) result.get("totalPages"),
                5
            );
            result.put("pageNav", pageNav);
            result.put("success", true);
            result.put("message", result.get("totalCount") + "개의 가맹점을 찾았습니다.");
            
            return result;
            
        } catch (Exception e) {
            System.err.println("AJAX 가맹점 검색 오류: " + e.getMessage());
            Map<String, Object> errorResult = new HashMap<>();
            errorResult.put("success", false);
            errorResult.put("message", "검색 중 오류가 발생했습니다: " + e.getMessage());
            errorResult.put("chains", List.of());
            return errorResult;
        }
    }
>>>>>>> b65c320 (Initial commit)
}