package net.koreate.hellking.fooddiary.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.common.exception.HellkingException;
import net.koreate.hellking.fooddiary.dao.FoodDiaryDAO;
import net.koreate.hellking.fooddiary.vo.DailyNutritionStatsVO;
import net.koreate.hellking.fooddiary.vo.FoodNutritionVO;
import net.koreate.hellking.fooddiary.vo.FoodReferenceWeightVO;
import net.koreate.hellking.fooddiary.vo.FoodTypeVO;
import net.koreate.hellking.fooddiary.vo.UserFavoriteFoodVO;
import net.koreate.hellking.fooddiary.vo.UserFoodLogVO;
import net.koreate.hellking.fooddiary.vo.UserProfileVO;

@Service
@Transactional
@Slf4j
public class FoodDiaryService {
    
    @Autowired
    private FoodDiaryDAO foodDiaryDAO;
    
    // === 음식 타입 관련 메서드 ===
    
    /**
     * 모든 음식 목록 조회
     */
    public List<FoodTypeVO> getAllFoodTypes() {
        List<FoodTypeVO> foods = foodDiaryDAO.selectAllFoodTypes();
        
        // 각 음식의 참고 중량 정보 조회
        for (FoodTypeVO food : foods) {
            List<FoodReferenceWeightVO> weights = 
                foodDiaryDAO.selectReferenceWeightsByFoodNum(food.getFoodNum());
            food.setReferenceWeights(weights);
        }
        
        return foods;
    }
    
    /**
     * 카테고리별 음식 조회
     */
    public List<FoodTypeVO> getFoodTypesByCategory(String category) {
        return foodDiaryDAO.selectFoodTypesByCategory(category);
    }
    
    /**
     * 음식명 검색 (자동완성)
     */
    public List<FoodTypeVO> searchFoodTypes(String keyword) {
        if (keyword == null || keyword.trim().length() < 1) {
            return new ArrayList<>();
        }
        
        return foodDiaryDAO.searchFoodTypesByName(keyword.trim());
    }
    
    /**
     * 특정 음식 상세 정보 조회
     */
    public FoodTypeVO getFoodTypeDetail(Long foodNum) {
        FoodTypeVO food = foodDiaryDAO.selectFoodTypeByNum(foodNum);
        if (food == null) {
            throw new HellkingException("존재하지 않는 음식입니다.");
        }
        
        // 참고 중량 정보 추가
        List<FoodReferenceWeightVO> weights = 
            foodDiaryDAO.selectReferenceWeightsByFoodNum(foodNum);
        food.setReferenceWeights(weights);
        
        return food;
    }
    
    /**
     * 카테고리 목록 조회
     */
    public List<String> getFoodCategories() {
        return Arrays.asList("곡류", "채소류", "과일류", "육류", "유제품", "음료", "간식");
    }
    
    // === 음식 기록 관련 메서드 ===
    
    /**
     * 음식 섭취 기록 저장
     */
    @Transactional
    public boolean addFoodLog(Long userNum, Long foodNum, double amountGrams, 
                             String mealType, Date recordDate) {
        
        // 입력값 검증
        if (amountGrams <= 0 || amountGrams > 10000) {
            throw new HellkingException("섭취량은 0g 초과 10,000g 이하로 입력해주세요.");
        }
        
        // 음식 정보 조회
        FoodTypeVO foodType = foodDiaryDAO.selectFoodTypeByNum(foodNum);
        if (foodType == null) {
            throw new HellkingException("존재하지 않는 음식입니다.");
        }
        
        // 영양소 계산
        FoodNutritionVO nutrition = foodType.calculateNutrition(amountGrams);
        
        // 기록 생성
        UserFoodLogVO log = new UserFoodLogVO();
        log.setUserNum(userNum);
        log.setFoodNum(foodNum);
        log.setAmountGrams(amountGrams);
        log.setCaloriesConsumed(nutrition.getCalories());
        log.setProteinConsumed(nutrition.getProtein());
        log.setCarbsConsumed(nutrition.getCarbs());
        log.setFatConsumed(nutrition.getFat());
        log.setMealType(mealType != null ? mealType : "기타");
        log.setRecordDate(recordDate != null ? recordDate : new Date());
        
        // 일일 최대 칼로리 체크 (안전장치)
        checkDailyCalorieLimit(userNum, log.getRecordDate(), nutrition.getCalories());
        
        return foodDiaryDAO.insertUserFoodLog(log) > 0;
    }
    
    /**
     * 음식 기록 수정
     */
    @Transactional
    public boolean updateFoodLog(Long userNum, Long foodLogNum, double amountGrams, String mealType) {
        
        // 기존 기록 조회
        UserFoodLogVO existingLog = foodDiaryDAO.selectUserFoodLogByNum(foodLogNum);
        if (existingLog == null || !existingLog.getUserNum().equals(userNum)) {
            throw new HellkingException("수정 권한이 없는 기록입니다.");
        }
        
        // 당일 기록만 수정 가능
        if (!existingLog.isEditable()) {
            throw new HellkingException("당일 기록만 수정 가능합니다.");
        }
        
        // 입력값 검증
        if (amountGrams <= 0 || amountGrams > 10000) {
            throw new HellkingException("섭취량은 0g 초과 10,000g 이하로 입력해주세요.");
        }
        
        // 음식 정보 조회 및 영양소 재계산
        FoodTypeVO foodType = foodDiaryDAO.selectFoodTypeByNum(existingLog.getFoodNum());
        FoodNutritionVO nutrition = foodType.calculateNutrition(amountGrams);
        
        // 수정할 정보 설정
        existingLog.setAmountGrams(amountGrams);
        existingLog.setCaloriesConsumed(nutrition.getCalories());
        existingLog.setProteinConsumed(nutrition.getProtein());
        existingLog.setCarbsConsumed(nutrition.getCarbs());
        existingLog.setFatConsumed(nutrition.getFat());
        existingLog.setMealType(mealType);
        
        return foodDiaryDAO.updateUserFoodLog(existingLog) > 0;
    }
    
    /**
     * 음식 기록 삭제
     */
    @Transactional
    public boolean deleteFoodLog(Long userNum, Long foodLogNum) {
        
        // 기존 기록 조회 및 권한 확인
        UserFoodLogVO existingLog = foodDiaryDAO.selectUserFoodLogByNum(foodLogNum);
        if (existingLog == null || !existingLog.getUserNum().equals(userNum)) {
            throw new HellkingException("삭제 권한이 없는 기록입니다.");
        }
        
        // 당일 기록만 삭제 가능
        if (!existingLog.isEditable()) {
            throw new HellkingException("당일 기록만 삭제 가능합니다.");
        }
        
        return foodDiaryDAO.deleteUserFoodLog(foodLogNum, userNum) > 0;
    }
    
    /**
     * 특정 날짜의 음식 기록 조회
     */
    public List<UserFoodLogVO> getUserFoodLogsByDate(Long userNum, Date recordDate) {
        return foodDiaryDAO.selectUserFoodLogsByDate(userNum, recordDate);
    }
    
    /**
     * 식사별 음식 기록 조회 (맵 형태로 반환)
     */
    public Map<String, List<UserFoodLogVO>> getUserFoodLogsByMealType(Long userNum, Date recordDate) {
        List<UserFoodLogVO> logs = foodDiaryDAO.selectUserFoodLogsByDate(userNum, recordDate);
        
        Map<String, List<UserFoodLogVO>> mealGroups = new HashMap<>();
        mealGroups.put("아침", new ArrayList<>());
        mealGroups.put("점심", new ArrayList<>());
        mealGroups.put("저녁", new ArrayList<>());
        mealGroups.put("간식", new ArrayList<>());
        mealGroups.put("기타", new ArrayList<>());
        
        for (UserFoodLogVO log : logs) {
            String mealType = log.getMealType() != null ? log.getMealType() : "기타";
            mealGroups.get(mealType).add(log);
        }
        
        return mealGroups;
    }
    
    // === 일일 통계 관련 메서드 ===
    
    /**
     * 일일 영양소 통계 조회
     */
    public DailyNutritionStatsVO getDailyNutritionStats(Long userNum, Date recordDate) {
        // ✅ 날짜만 비교하도록 시간 부분 제거
        Calendar cal = Calendar.getInstance();
        cal.setTime(recordDate);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        Date dateOnly = cal.getTime();
        
        DailyNutritionStatsVO stats = foodDiaryDAO.selectDailyNutritionStats(userNum, dateOnly);
        
        // 목표 칼로리 설정
        UserProfileVO profile = foodDiaryDAO.selectUserProfile(userNum);
        if (profile != null && profile.getTargetCalories() != null) {
            stats.setTargetCalories(profile.getTargetCalories());
        } else {
            stats.setTargetCalories(2000);
        }
        
        return stats;
    }
    
    /**
     * 주간 칼로리 통계 (최근 7일)
     */
    public List<DailyNutritionStatsVO> getWeeklyCaloriesStats(Long userNum) {
        Date endDate = new Date();
        Date startDate = new Date(endDate.getTime() - TimeUnit.DAYS.toMillis(6)); // 7일 전
        
        return foodDiaryDAO.selectWeeklyCaloriesStats(userNum, startDate, endDate);
    }
    
    /**
     * 월간 평균 칼로리
     */
    public Integer getMonthlyAverageCalories(Long userNum) {
        Date endDate = new Date();
        Date startDate = new Date(endDate.getTime() - TimeUnit.DAYS.toMillis(29)); // 30일 전
        
        Integer avgCalories = foodDiaryDAO.selectMonthlyAverageCalories(userNum, startDate, endDate);
        return avgCalories != null ? avgCalories : 0;
    }
    
    // === 사용자 프로필 관련 메서드 ===
    
    /**
     * 사용자 프로필 조회
     */
    public UserProfileVO getUserProfile(Long userNum) {
        UserProfileVO profile = foodDiaryDAO.selectUserProfile(userNum);
        if (profile == null) {
            // 기본 프로필 생성
            profile = new UserProfileVO();
            profile.setUserNum(userNum);
            profile.setTargetCalories(2000); // 기본값
            profile.setActivityLevel("MODERATE");
        }
        return profile;
    }
    
    /**
     * 사용자 프로필 저장/수정
     */
    @Transactional
    public boolean saveUserProfile(UserProfileVO profile) {
        
        // 목표 칼로리 안전성 검증
        if (profile.getTargetCalories() != null) {
            if (!profile.isValidTargetCalories(profile.getTargetCalories())) {
                String gender = profile.getGender();
                int minCalories = "M".equals(gender) ? 1500 : 1200;
                throw new HellkingException(
                    String.format("목표 칼로리는 %d ~ 4000kcal 범위에서 설정해주세요. " +
                                "건강한 식단을 위해 최소 칼로리 제한을 적용합니다.", minCalories));
            }
        }
        
        // 나이 검증
        if (profile.getAge() != null && (profile.getAge() < 10 || profile.getAge() > 120)) {
            throw new HellkingException("나이는 10세 ~ 120세 범위에서 입력해주세요.");
        }
        
        // 체중 검증
        if (profile.getWeightKg() != null && (profile.getWeightKg() < 20 || profile.getWeightKg() > 300)) {
            throw new HellkingException("체중은 20kg ~ 300kg 범위에서 입력해주세요.");
        }
        
        // 키 검증
        if (profile.getHeightCm() != null && (profile.getHeightCm() < 100 || profile.getHeightCm() > 250)) {
            throw new HellkingException("키는 100cm ~ 250cm 범위에서 입력해주세요.");
        }
        
        return foodDiaryDAO.mergeUserProfile(profile) > 0;
    }
    
    // === 즐겨찾기 관련 메서드 ===
    
    /**
     * 즐겨찾기 음식 추가
     */
    @Transactional
    public boolean addFavoriteFood(Long userNum, Long foodNum) {
        
        // 중복 체크
        if (foodDiaryDAO.checkFavoriteFood(userNum, foodNum) > 0) {
            throw new HellkingException("이미 즐겨찾기에 등록된 음식입니다.");
        }
        
        // 음식 존재 여부 확인
        FoodTypeVO food = foodDiaryDAO.selectFoodTypeByNum(foodNum);
        if (food == null) {
            throw new HellkingException("존재하지 않는 음식입니다.");
        }
        
        return foodDiaryDAO.insertFavoriteFood(userNum, foodNum) > 0;
    }
    
    /**
     * 즐겨찾기 음식 제거
     */
    @Transactional
    public boolean removeFavoriteFood(Long userNum, Long foodNum) {
        return foodDiaryDAO.deleteFavoriteFood(userNum, foodNum) > 0;
    }
    
    /**
     * 사용자 즐겨찾기 음식 목록
     */
    public List<UserFavoriteFoodVO> getUserFavoriteFoods(Long userNum) {
        return foodDiaryDAO.selectUserFavoriteFoods(userNum);
    }
    
    /**
     * 자주 사용하는 음식 추천 (자동 즐겨찾기 후보)
     */
    public List<UserFavoriteFoodVO> getFrequentlyUsedFoods(Long userNum) {
        Date startDate = new Date(new Date().getTime() - TimeUnit.DAYS.toMillis(30)); // 30일 전
        return foodDiaryDAO.selectFrequentlyUsedFoods(userNum, startDate);
    }
    
    // === 통계 및 분석 메서드 ===
    
    /**
     * 사용자 전체 통계
     */
    public Map<String, Object> getUserTotalStats(Long userNum) {
        Map<String, Object> stats = foodDiaryDAO.selectUserTotalStats(userNum);
        
        // 연속 기록 일수 추가
        Integer maxConsecutive = foodDiaryDAO.selectMaxConsecutiveDays(userNum);
        stats.put("maxConsecutiveDays", maxConsecutive != null ? maxConsecutive : 0);
        
        return stats;
    }
    
    /**
     * 카테고리별 섭취 통계 (최근 30일)
     */
    public List<Map<String, Object>> getCategoryStats(Long userNum) {
        Date startDate = new Date(new Date().getTime() - TimeUnit.DAYS.toMillis(29)); // 30일 전
        return foodDiaryDAO.selectCategoryStats(userNum, startDate);
    }
    
    /**
     * 식사 타입별 칼로리 분포 (최근 7일)
     */
    public List<Map<String, Object>> getMealTypeDistribution(Long userNum) {
        Date startDate = new Date(new Date().getTime() - TimeUnit.DAYS.toMillis(6)); // 7일 전
        return foodDiaryDAO.selectMealTypeDistribution(userNum, startDate);
    }
    
    /**
     * 건강한 식습관 점수 계산
     */
    public Map<String, Object> calculateHealthyEatingScore(Long userNum) {
        Map<String, Object> result = new HashMap<>();
        
        // 최근 7일 데이터 기준
        Date endDate = new Date();
        Date startDate = new Date(endDate.getTime() - TimeUnit.DAYS.toMillis(6));
        
        List<DailyNutritionStatsVO> weeklyStats = 
            foodDiaryDAO.selectWeeklyCaloriesStats(userNum, startDate, endDate);
        
        int totalScore = 0;
        int maxScore = 100;
        
        // 1. 꾸준한 기록 (30점)
        int recordDays = weeklyStats.size();
        int recordScore = Math.min(30, (recordDays * 30) / 7);
        totalScore += recordScore;
        
        // 2. 적정 칼로리 유지 (40점) 
        UserProfileVO profile = getUserProfile(userNum);
        int targetCalories = profile.getTargetCalories() != null ? 
                           profile.getTargetCalories() : 2000;
        
        int calorieScore = 0;
        for (DailyNutritionStatsVO stat : weeklyStats) {
            int dailyCalories = stat.getTotalCalories() != null ? stat.getTotalCalories() : 0;
            
            // 목표의 80~120% 범위면 만점
            if (dailyCalories >= targetCalories * 0.8 && dailyCalories <= targetCalories * 1.2) {
                calorieScore += 6; // 7일 기준 40점/7 ≈ 6점
            } else if (dailyCalories >= targetCalories * 0.6 && dailyCalories <= targetCalories * 1.4) {
                calorieScore += 3; // 절반 점수
            }
        }
        totalScore += Math.min(40, calorieScore);
        
        // 3. 다양한 카테고리 섭취 (30점)
        List<Map<String, Object>> categoryStats = getCategoryStats(userNum);
        int varietyScore = Math.min(30, categoryStats.size() * 5); // 카테고리당 5점
        totalScore += varietyScore;
        
        result.put("totalScore", totalScore);
        result.put("maxScore", maxScore);
        result.put("recordScore", recordScore);
        result.put("calorieScore", Math.min(40, calorieScore));
        result.put("varietyScore", varietyScore);
        result.put("recordDays", recordDays);
        
        // 격려 메시지
        String message = generateEncouragementMessage(totalScore, recordDays);
        result.put("message", message);
        
        return result;
    }
    
    /**
     * 격려 메시지 생성 (긍정적 프레이밍)
     */
    private String generateEncouragementMessage(int score, int recordDays) {
        if (score >= 80) {
            return "훌륭해요! 건강한 식습관을 잘 유지하고 계시네요.";
        } else if (score >= 60) {
            return String.format("좋은 습관이에요! %d일 기록하셨네요. 꾸준히 하고 계시는군요.", recordDays);
        } else if (score >= 40) {
            return String.format("시작이 좋아요! %d일 기록 완료하셨어요.", recordDays);
        } else if (recordDays > 0) {
            return String.format("기록해주셔서 감사해요! %d일 기록하셨네요.", recordDays);
        } else {
            return "오늘부터 시작해보세요! 작은 기록부터 천천히 해보면 됩니다.";
        }
    }
    
    /**
     * 일일 최대 칼로리 체크 (안전장치)
     */
    private void checkDailyCalorieLimit(Long userNum, Date recordDate, int additionalCalories) {
        DailyNutritionStatsVO todayStats = foodDiaryDAO.selectDailyNutritionStats(userNum, recordDate);
        int currentCalories = todayStats.getTotalCalories() != null ? todayStats.getTotalCalories() : 0;
        
        // 일일 8000kcal 초과 방지 (극단적 수치 방지)
        if (currentCalories + additionalCalories > 8000) {
            throw new HellkingException("하루 총 칼로리가 8,000kcal를 초과할 수 없습니다. " +
                                      "건강을 위해 적절한 양의 음식을 기록해주세요.");
        }
    }
    
    /**
     * 메인 대시보드용 종합 정보
     */
    public Map<String, Object> getDashboardData(Long userNum) {
        Map<String, Object> dashboard = new HashMap<>();
        
        Date today = new Date();
        
        // 오늘의 영양소 통계
        DailyNutritionStatsVO todayStats = getDailyNutritionStats(userNum, today);
        dashboard.put("todayStats", todayStats);
        
        // 오늘의 식사별 기록
        Map<String, List<UserFoodLogVO>> mealGroups = getUserFoodLogsByMealType(userNum, today);
        dashboard.put("mealGroups", mealGroups);
        
        // 건강 점수
        Map<String, Object> healthScore = calculateHealthyEatingScore(userNum);
        dashboard.put("healthScore", healthScore);
        
        // 즐겨찾기 음식
        List<UserFavoriteFoodVO> favoriteFoods = getUserFavoriteFoods(userNum);
        dashboard.put("favoriteFoods", favoriteFoods.stream().limit(5).toArray());
        
        // 사용자 프로필
        UserProfileVO profile = getUserProfile(userNum);
        dashboard.put("profile", profile);
        
        return dashboard;
    }
    
    /**
     * 영양소 계산 유틸리티 (컨트롤러에서 AJAX 호출용)
     */
    public FoodNutritionVO calculateNutrition(Long foodNum, double grams) {
        FoodTypeVO food = foodDiaryDAO.selectFoodTypeByNum(foodNum);
        if (food == null) {
            throw new HellkingException("존재하지 않는 음식입니다.");
        }
        
        return food.calculateNutrition(grams);
    }
    
    /**
     * 식사 타입 목록
     */
    public List<String> getMealTypes() {
        return Arrays.asList("아침", "점심", "저녁", "간식", "기타");
    }
    
    /**
     * 날짜 형식 유틸리티
     */
    public String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }
}