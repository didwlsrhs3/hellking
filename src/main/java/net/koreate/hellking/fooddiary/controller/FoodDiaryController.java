package net.koreate.hellking.fooddiary.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.common.exception.HellkingException;
import net.koreate.hellking.fooddiary.service.FoodDiaryService;
import net.koreate.hellking.fooddiary.vo.DailyNutritionStatsVO;
import net.koreate.hellking.fooddiary.vo.FoodNutritionVO;
import net.koreate.hellking.fooddiary.vo.FoodTypeVO;
import net.koreate.hellking.fooddiary.vo.UserFavoriteFoodVO;
import net.koreate.hellking.fooddiary.vo.UserFoodLogVO;
import net.koreate.hellking.fooddiary.vo.UserProfileVO;
import net.koreate.hellking.user.service.UserService;

@Controller
@RequestMapping("/fooddiary")
@Slf4j
public class FoodDiaryController {
    
    @Autowired
    private FoodDiaryService foodDiaryService;
    
    @Autowired
    private UserService userService;
    
    /**
     * 메인 대시보드
     */
    @GetMapping({"", "/"})
    public String main(Model model, HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            // 🔍 디버깅 로그 추가
            log.info("=== 푸드다이어리 메인 데이터 조회 시작 ===");
            log.info("userNum: {}", userNum);
            
            // 대시보드 데이터 조회
            Map<String, Object> dashboard = foodDiaryService.getDashboardData(userNum);
            log.info("dashboard 데이터: {}", dashboard);
            
            // ✅ 중요: Model에 데이터 추가
            model.addAllAttributes(dashboard);
            
            // 날짜 정보
            Date today = new Date();
            model.addAttribute("today", today);
            model.addAttribute("todayStr", foodDiaryService.formatDate(today));
            log.info("today: {}, todayStr: {}", today, foodDiaryService.formatDate(today));
            
            // 주간 통계 추가
            List<DailyNutritionStatsVO> weeklyStats = foodDiaryService.getWeeklyCaloriesStats(userNum);
            model.addAttribute("weeklyStats", weeklyStats);
            log.info("weeklyStats size: {}", weeklyStats != null ? weeklyStats.size() : 0);
            
            // ✅ Model에 추가된 데이터 확인
            log.info("Model attributes: {}", model.asMap());
            log.info("=== 푸드다이어리 메인 데이터 조회 완료 ===");
            
            return "fooddiary/main";
            
        } catch (Exception e) {
            log.error("푸드다이어리 메인 페이지 로딩 실패: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "데이터를 불러오는 중 오류가 발생했습니다.");
            return "fooddiary/main";
        }
    }
    
    /**
     * 음식 검색 페이지
     */
    @GetMapping("/search")
    public String search(@RequestParam(required = false) String keyword,
                        @RequestParam(required = false) String category,
                        Model model, HttpSession session) {
        
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        List<FoodTypeVO> foods = new ArrayList<>();
        
        List<UserFavoriteFoodVO> userFavorites = foodDiaryService.getUserFavoriteFoods(userNum);
        Set<Long> favoriteIds = userFavorites.stream()
            .map(UserFavoriteFoodVO::getFoodNum)
            .collect(Collectors.toSet());

        model.addAttribute("favoriteIds", favoriteIds);
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            foods = foodDiaryService.searchFoodTypes(keyword);
            model.addAttribute("keyword", keyword);
        } else if (category != null && !category.trim().isEmpty()) {
            foods = foodDiaryService.getFoodTypesByCategory(category);
            model.addAttribute("category", category);
        }
        
        model.addAttribute("foods", foods);
        model.addAttribute("categories", foodDiaryService.getFoodCategories());
        model.addAttribute("favoriteFoods", foodDiaryService.getUserFavoriteFoods(userNum));                
        
        return "fooddiary/search";
    }
    
    /**
     * 음식 검색 API (AJAX)
     */
    @GetMapping("/api/search")
    @ResponseBody
    public Map<String, Object> searchFoodsApi(@RequestParam String keyword, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            List<FoodTypeVO> foods = foodDiaryService.searchFoodTypes(keyword);
            result.put("success", true);
            result.put("foods", foods);
            
        } catch (Exception e) {
            log.error("음식 검색 API 오류: {}", e.getMessage(), e);
            result.put("success", false);
            result.put("message", "검색 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 음식 상세 정보 조회 API
     */
    @GetMapping("/api/food/{foodNum}")
    @ResponseBody
    public Map<String, Object> getFoodDetail(@PathVariable Long foodNum, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            FoodTypeVO food = foodDiaryService.getFoodTypeDetail(foodNum);
            result.put("success", true);
            result.put("food", food);
            
        } catch (HellkingException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        } catch (Exception e) {
            log.error("음식 상세 정보 조회 오류: {}", e.getMessage(), e);
            result.put("success", false);
            result.put("message", "정보를 불러오는 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 영양소 계산 API
     */
    @GetMapping("/api/nutrition")
    @ResponseBody
    public Map<String, Object> calculateNutrition(@RequestParam Long foodNum,
                                                 @RequestParam double grams,
                                                 HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            FoodNutritionVO nutrition = foodDiaryService.calculateNutrition(foodNum, grams);
            result.put("success", true);
            result.put("nutrition", nutrition);
            
        } catch (HellkingException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        } catch (Exception e) {
            log.error("영양소 계산 오류: {}", e.getMessage(), e);
            result.put("success", false);
            result.put("message", "계산 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 음식 기록 추가
     */
    @PostMapping("/log")
    @ResponseBody
    public Map<String, Object> addFoodLog(@RequestParam Long foodNum,
                                         @RequestParam double amountGrams,
                                         @RequestParam String mealType,
                                         @RequestParam(required = false) String recordDateStr,
                                         HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            // 날짜 파싱
            Date recordDate = new Date(); // 기본값: 오늘
            if (recordDateStr != null && !recordDateStr.trim().isEmpty()) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                recordDate = sdf.parse(recordDateStr);
            }
            
            boolean success = foodDiaryService.addFoodLog(userNum, foodNum, amountGrams, mealType, recordDate);
            result.put("success", success);
            result.put("message", success ? "기록이 저장되었습니다." : "저장에 실패했습니다.");
            
        } catch (HellkingException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        } catch (Exception e) {
            log.error("음식 기록 저장 오류: {}", e.getMessage(), e);
            result.put("success", false);
            result.put("message", "저장 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 음식 기록 수정
     */
    @PutMapping("/log/{foodLogNum}")
    @ResponseBody
    public Map<String, Object> updateFoodLog(@PathVariable Long foodLogNum,
                                            @RequestParam double amountGrams,
                                            @RequestParam String mealType,
                                            HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            boolean success = foodDiaryService.updateFoodLog(userNum, foodLogNum, amountGrams, mealType);
            result.put("success", success);
            result.put("message", success ? "기록이 수정되었습니다." : "수정에 실패했습니다.");
            
        } catch (HellkingException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        } catch (Exception e) {
            log.error("음식 기록 수정 오류: {}", e.getMessage(), e);
            result.put("success", false);
            result.put("message", "수정 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 음식 기록 삭제
     */
    @DeleteMapping("/log/{foodLogNum}")
    @ResponseBody
    public Map<String, Object> deleteFoodLog(@PathVariable Long foodLogNum, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            boolean success = foodDiaryService.deleteFoodLog(userNum, foodLogNum);
            result.put("success", success);
            result.put("message", success ? "기록이 삭제되었습니다." : "삭제에 실패했습니다.");
            
        } catch (HellkingException e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        } catch (Exception e) {
            log.error("음식 기록 삭제 오류: {}", e.getMessage(), e);
            result.put("success", false);
            result.put("message", "삭제 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 특정 날짜 기록 조회
     */
    @GetMapping("/logs/{date}")
    public String viewLogsByDate(@PathVariable String date, Model model, HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date recordDate = sdf.parse(date);
            
            Map<String, List<UserFoodLogVO>> mealGroups = 
                foodDiaryService.getUserFoodLogsByMealType(userNum, recordDate);
            
            DailyNutritionStatsVO stats = 
                foodDiaryService.getDailyNutritionStats(userNum, recordDate);
            
            model.addAttribute("mealGroups", mealGroups);
            model.addAttribute("stats", stats);
            model.addAttribute("recordDate", recordDate);
            model.addAttribute("recordDateStr", date);
            
            return "fooddiary/daily";
            
        } catch (Exception e) {
            log.error("일별 기록 조회 오류: {}", e.getMessage(), e);
            return "redirect:/fooddiary/";
        }
    }
    
    /**
     * 통계 페이지
     */
    @GetMapping("/stats")
    public String stats(Model model, HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            // 주간 통계
            List<DailyNutritionStatsVO> weeklyStats = foodDiaryService.getWeeklyCaloriesStats(userNum);
            model.addAttribute("weeklyStats", weeklyStats);
            
            // 월간 평균
            Integer monthlyAvg = foodDiaryService.getMonthlyAverageCalories(userNum);
            model.addAttribute("monthlyAvg", monthlyAvg);
            
            // 카테고리별 통계
            List<Map<String, Object>> categoryStats = foodDiaryService.getCategoryStats(userNum);
            model.addAttribute("categoryStats", categoryStats);
            
            // 식사별 분포
            List<Map<String, Object>> mealDistribution = foodDiaryService.getMealTypeDistribution(userNum);
            model.addAttribute("mealDistribution", mealDistribution);
            
            // 전체 통계
            Map<String, Object> totalStats = foodDiaryService.getUserTotalStats(userNum);
            model.addAttribute("totalStats", totalStats);
            
            // 건강 점수
            Map<String, Object> healthScore = foodDiaryService.calculateHealthyEatingScore(userNum);
            model.addAttribute("healthScore", healthScore);
            
            return "fooddiary/stats";
            
        } catch (Exception e) {
            log.error("통계 페이지 로딩 오류: {}", e.getMessage(), e);
            model.addAttribute("errorMessage", "통계를 불러오는 중 오류가 발생했습니다.");
            return "fooddiary/stats";
        }
    }
    
    /**
     * 프로필 설정 페이지
     */
    @GetMapping("/profile")
    public String profile(Model model, HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        UserProfileVO profile = foodDiaryService.getUserProfile(userNum);
        model.addAttribute("profile", profile);
        
        return "fooddiary/profile";
    }
    
    /**
     * 프로필 저장
     */
    @PostMapping("/profile")
    public String saveProfile(@ModelAttribute UserProfileVO profile,
                             RedirectAttributes redirectAttributes,
                             HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            profile.setUserNum(userNum);
            boolean success = foodDiaryService.saveUserProfile(profile);
            
            if (success) {
                redirectAttributes.addFlashAttribute("successMessage", "프로필이 저장되었습니다.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "저장에 실패했습니다.");
            }
            
        } catch (HellkingException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            log.error("프로필 저장 오류: {}", e.getMessage(), e);
            redirectAttributes.addFlashAttribute("errorMessage", "저장 중 오류가 발생했습니다.");
        }
        
        return "redirect:/fooddiary/profile";
    }
    
    /**
     * 즐겨찾기 관리 페이지
     */
    @GetMapping("/favorites")
    public String favorites(Model model, HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        List<UserFavoriteFoodVO> favoriteFoods = foodDiaryService.getUserFavoriteFoods(userNum);
        List<UserFavoriteFoodVO> frequentFoods = foodDiaryService.getFrequentlyUsedFoods(userNum);
        
        model.addAttribute("favoriteFoods", favoriteFoods);
        model.addAttribute("frequentFoods", frequentFoods);
        
        return "fooddiary/favorites";
    }
    
    /**
     * 즐겨찾기 추가/제거
     */
 // FoodDiaryController.java의 toggleFavorite 메서드 수정
    @PostMapping("/favorites/{foodNum}")
    @ResponseBody
    public Map<String, Object> toggleFavorite(@PathVariable Long foodNum,
                                              @RequestParam(required = false) String action,
                                              HttpSession session,
                                              HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();
        
        // 🔍 디버깅 로그 추가
        log.info("즐겨찾기 요청 - foodNum: {}, action: '{}', userNum: {}", 
                 foodNum, action, userService.getCurrentUserNum(session));
        
        // 📝 요청 본문 전체 확인
        log.info("Request Content-Type: {}", request.getContentType());
        log.info("Request Method: {}", request.getMethod());
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            // 🔍 action 값 검증 강화
            if (action == null || action.trim().isEmpty()) {
                log.warn("action 파라미터가 null 또는 빈 값입니다. action: '{}'", action);
                result.put("success", false);
                result.put("message", "잘못된 요청입니다. action 파라미터가 필요합니다.");
                return result;
            }
            
            action = action.trim(); // 공백 제거
            
            boolean success;
            if ("add".equals(action)) {
                success = foodDiaryService.addFavoriteFood(userNum, foodNum);
                result.put("message", success ? "즐겨찾기에 추가되었습니다." : "추가에 실패했습니다.");
            } else if ("remove".equals(action)) {
                success = foodDiaryService.removeFavoriteFood(userNum, foodNum);
                result.put("message", success ? "즐겨찾기에서 제거되었습니다." : "제거에 실패했습니다.");
            } else {
                log.warn("유효하지 않은 action 값: '{}'", action);
                result.put("success", false);
                result.put("message", "잘못된 요청입니다. action은 'add' 또는 'remove'여야 합니다.");
                return result;
            }
            
            result.put("success", success);
            log.info("즐겨찾기 처리 완료 - success: {}, message: {}", success, result.get("message"));
            
        } catch (Exception e) {
            log.error("즐겨찾기 처리 오류: {}", e.getMessage(), e);
            result.put("success", false);
            result.put("message", "처리 중 오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 캘린더 페이지 (월별 기록 보기)
     */
    @GetMapping("/calendar")
    public String calendar(@RequestParam(required = false) String yearMonth,
                          Model model, HttpSession session) {
        Long userNum = userService.getCurrentUserNum(session);
        if (userNum == null) {
            return "redirect:/user/login";
        }
        
        try {
            // 년월 파싱 (기본값: 이번 달)
            Calendar cal = Calendar.getInstance();
            if (yearMonth != null && yearMonth.matches("\\d{4}-\\d{2}")) {
                String[] parts = yearMonth.split("-");
                cal.set(Calendar.YEAR, Integer.parseInt(parts[0]));
                cal.set(Calendar.MONTH, Integer.parseInt(parts[1]) - 1);
            }
            
            // 해당 월의 시작일과 종료일
            cal.set(Calendar.DAY_OF_MONTH, 1);
            Date startDate = cal.getTime();
            
            cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
            Date endDate = cal.getTime();
            
            // 해당 월의 기록 조회 - 올바른 메서드 사용
            List<DailyNutritionStatsVO> monthlyStats = foodDiaryService.getWeeklyCaloriesStats(userNum);
            
            model.addAttribute("monthlyStats", monthlyStats);
            model.addAttribute("currentYearMonth", 
                new SimpleDateFormat("yyyy-MM").format(cal.getTime()));
            
            return "fooddiary/calendar";
            
        } catch (Exception e) {
            log.error("캘린더 페이지 로딩 오류: {}", e.getMessage(), e);
            return "redirect:/fooddiary/";
        }
    }
    
    /**
     * 예외 처리
     */
    @ExceptionHandler(HellkingException.class)
    public String handleHellkingException(HellkingException e, Model model) {
        log.warn("푸드다이어리 비즈니스 예외: {}", e.getMessage());
        model.addAttribute("errorMessage", e.getMessage());
        return "fooddiary/main";
    }
    
    @ExceptionHandler(Exception.class)
    public String handleGenericException(Exception e, Model model) {
        log.error("푸드다이어리 시스템 오류: {}", e.getMessage(), e);
        model.addAttribute("errorMessage", "시스템 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
        return "fooddiary/main";
    }
}