package net.koreate.hellking.fooddiary.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import net.koreate.hellking.fooddiary.vo.DailyNutritionStatsVO;
import net.koreate.hellking.fooddiary.vo.FoodReferenceWeightVO;
import net.koreate.hellking.fooddiary.vo.FoodTypeVO;
import net.koreate.hellking.fooddiary.vo.UserFavoriteFoodVO;
import net.koreate.hellking.fooddiary.vo.UserFoodLogVO;
import net.koreate.hellking.fooddiary.vo.UserProfileVO;

@Mapper
public interface FoodDiaryDAO {
    
    // === 음식 타입 관련 ===
    
    /**
     * 모든 활성 음식 목록 조회
     */
    @Select("SELECT food_num as foodNum, food_name as foodName, category, " +
            "calories_per_100g as caloriesPer100selectDailyNutritionStatsg, protein_per_100g as proteinPer100g, " +
            "carbs_per_100g as carbsPer100g, fat_per_100g as fatPer100g, " +
            "is_active as isActive, created_at as createdAt " +
            "FROM hk_food_types " +
            "WHERE is_active = 'Y' " +
            "ORDER BY category, food_name")
    List<FoodTypeVO> selectAllFoodTypes();
    
    /**
     * 카테고리별 음식 조회
     */
    @Select("SELECT food_num as foodNum, food_name as foodName, category, " +
            "calories_per_100g as caloriesPer100g, protein_per_100g as proteinPer100g, " +
            "carbs_per_100g as carbsPer100g, fat_per_100g as fatPer100g " +
            "FROM hk_food_types " +
            "WHERE category = #{category} AND is_active = 'Y' " +
            "ORDER BY food_name")
    List<FoodTypeVO> selectFoodTypesByCategory(String category);
    
    /**
     * 음식명으로 검색 (자동완성용)
     */
    @Select("SELECT food_num as foodNum, food_name as foodName, category, " +
            "calories_per_100g as caloriesPer100g " +
            "FROM hk_food_types " +
            "WHERE food_name LIKE '%' || #{keyword} || '%' AND is_active = 'Y' " +
            "ORDER BY food_name " +
            "FETCH FIRST 10 ROWS ONLY")
    List<FoodTypeVO> searchFoodTypesByName(String keyword);
    
    /**
     * 특정 음식 정보 조회
     */
    @Select("SELECT food_num as foodNum, food_name as foodName, category, " +
            "calories_per_100g as caloriesPer100g, protein_per_100g as proteinPer100g, " +
            "carbs_per_100g as carbsPer100g, fat_per_100g as fatPer100g " +
            "FROM hk_food_types WHERE food_num = #{foodNum}")
    FoodTypeVO selectFoodTypeByNum(Long foodNum);
    
    // === 참고 중량 관련 ===
    
    /**
     * 특정 음식의 참고 중량 목록 조회
     */
    @Select("SELECT reference_num as referenceNum, food_num as foodNum, " +
            "reference_unit as referenceUnit, weight_grams as weightGrams, description " +
            "FROM hk_food_reference_weights " +
            "WHERE food_num = #{foodNum} " +
            "ORDER BY weight_grams")
    List<FoodReferenceWeightVO> selectReferenceWeightsByFoodNum(Long foodNum);
    
    // === 사용자 음식 기록 관련 ===
    
    /**
     * 음식 섭취 기록 저장
     */
    @Insert("INSERT INTO hk_user_foods " +
            "(user_num, food_num, amount_grams, calories_consumed, protein_consumed, " +
            "carbs_consumed, fat_consumed, meal_type, record_date) " +
            "VALUES (#{userNum}, #{foodNum}, #{amountGrams}, #{caloriesConsumed}, " +
            "#{proteinConsumed}, #{carbsConsumed}, #{fatConsumed}, #{mealType}, #{recordDate})")
    int insertUserFoodLog(UserFoodLogVO log);
    
    /**
     * 사용자의 특정 날짜 음식 기록 조회
     */
    @Select("SELECT f.food_log_num as foodLogNum, f.user_num as userNum, f.food_num as foodNum, " +
            "f.amount_grams as amountGrams, f.calories_consumed as caloriesConsumed, " +
            "f.protein_consumed as proteinConsumed, f.carbs_consumed as carbsConsumed, " +
            "f.fat_consumed as fatConsumed, f.meal_type as mealType, " +
            "f.record_date as recordDate, f.created_at as createdAt, " +
            "ft.food_name as foodName, ft.category " +
            "FROM hk_user_foods f " +
            "JOIN hk_food_types ft ON f.food_num = ft.food_num " +
            "WHERE f.user_num = #{userNum} \r\n"
            + "AND TRUNC(f.record_date) = TRUNC(#{recordDate}) " +
            "ORDER BY f.created_at DESC")
    List<UserFoodLogVO> selectUserFoodLogsByDate(@Param("userNum") Long userNum, 
                                                @Param("recordDate") Date recordDate);
    
    /**
     * 특정 기록 조회
     */
    @Select("SELECT f.food_log_num as foodLogNum, f.user_num as userNum, f.food_num as foodNum, " +
            "f.amount_grams as amountGrams, f.calories_consumed as caloriesConsumed, " +
            "f.protein_consumed as proteinConsumed, f.carbs_consumed as carbsConsumed, " +
            "f.fat_consumed as fatConsumed, f.meal_type as mealType, " +
            "f.record_date as recordDate, ft.food_name as foodName " +
            "FROM hk_user_foods f " +
            "JOIN hk_food_types ft ON f.food_num = ft.food_num " +
            "WHERE f.food_log_num = #{foodLogNum}")
    UserFoodLogVO selectUserFoodLogByNum(Long foodLogNum);
    
    /**
     * 음식 기록 수정
     */
    @Update("UPDATE hk_user_foods SET " +
            "amount_grams = #{amountGrams}, calories_consumed = #{caloriesConsumed}, " +
            "protein_consumed = #{proteinConsumed}, carbs_consumed = #{carbsConsumed}, " +
            "fat_consumed = #{fatConsumed}, meal_type = #{mealType} " +
            "WHERE food_log_num = #{foodLogNum} AND user_num = #{userNum}")
    int updateUserFoodLog(UserFoodLogVO log);
    
    /**
     * 음식 기록 삭제
     */
    @Delete("DELETE FROM hk_user_foods " +
            "WHERE food_log_num = #{foodLogNum} AND user_num = #{userNum}")
    int deleteUserFoodLog(@Param("foodLogNum") Long foodLogNum, 
                         @Param("userNum") Long userNum);
    
    // === 일일 통계 관련 ===
    
    /**
     * 특정 날짜의 일일 영양소 통계
     */
    @Select("SELECT " +
            "#{recordDate} as recordDate, " +
            "COALESCE(SUM(calories_consumed), 0) as totalCalories, " +
            "COALESCE(SUM(protein_consumed), 0) as totalProtein, " +
            "COALESCE(SUM(carbs_consumed), 0) as totalCarbs, " +
            "COALESCE(SUM(fat_consumed), 0) as totalFat, " +
            "COUNT(*) as mealCount " +
            "FROM hk_user_foods " +
            "WHERE user_num = #{userNum} " +
            "AND TRUNC(record_date) = TRUNC(#{recordDate})") // ✅ TRUNC로 날짜만 비교
    DailyNutritionStatsVO selectDailyNutritionStats(@Param("userNum") Long userNum,
                                                   @Param("recordDate") Date recordDate);
    
    /**
     * 주간 칼로리 통계 (최근 7일)
     */
    @Select("SELECT record_date as recordDate, " +
            "SUM(calories_consumed) as totalCalories " +
            "FROM hk_user_foods " +
            "WHERE user_num = #{userNum} " +
            "AND record_date >= #{startDate} AND record_date <= #{endDate} " +
            "GROUP BY record_date " +
            "ORDER BY record_date")
    List<DailyNutritionStatsVO> selectWeeklyCaloriesStats(@Param("userNum") Long userNum,
                                                         @Param("startDate") Date startDate,
                                                         @Param("endDate") Date endDate);
    
    /**
     * 월간 칼로리 평균
     */
    @Select("SELECT AVG(daily_calories) as avgCalories FROM (" +
            "SELECT record_date, SUM(calories_consumed) as daily_calories " +
            "FROM hk_user_foods " +
            "WHERE user_num = #{userNum} " +
            "AND record_date >= #{startDate} AND record_date <= #{endDate} " +
            "GROUP BY record_date" +
            ")")
    Integer selectMonthlyAverageCalories(@Param("userNum") Long userNum,
                                       @Param("startDate") Date startDate,
                                       @Param("endDate") Date endDate);
    
    // === 사용자 프로필 관련 ===
    
    /**
     * 사용자 프로필 조회
     */
    @Select("SELECT user_num as userNum, gender, age, weight_kg as weightKg, " +
            "height_cm as heightCm, target_calories as targetCalories, " +
            "activity_level as activityLevel, created_at as createdAt, " +
            "updated_at as updatedAt " +
            "FROM hk_user_profiles WHERE user_num = #{userNum}")
    UserProfileVO selectUserProfile(Long userNum);
    
    /**
     * 사용자 프로필 저장/수정 (MERGE 사용)
     */
    @Insert("MERGE INTO hk_user_profiles p " +
            "USING (SELECT #{userNum} as user_num FROM DUAL) s " +
            "ON (p.user_num = s.user_num) " +
            "WHEN MATCHED THEN UPDATE SET " +
            "gender = #{gender}, age = #{age}, weight_kg = #{weightKg}, " +
            "height_cm = #{heightCm}, target_calories = #{targetCalories}, " +
            "activity_level = #{activityLevel}, updated_at = CURRENT_TIMESTAMP " +
            "WHEN NOT MATCHED THEN INSERT " +
            "(user_num, gender, age, weight_kg, height_cm, target_calories, activity_level) " +
            "VALUES (#{userNum}, #{gender}, #{age}, #{weightKg}, #{heightCm}, " +
            "#{targetCalories}, #{activityLevel})")
    int mergeUserProfile(UserProfileVO profile);
    
    // === 즐겨찾기 관련 ===
    
    /**
     * 즐겨찾기 음식 추가
     */
    @Insert("INSERT INTO hk_user_favorite_foods (user_num, food_num) " +
            "VALUES (#{userNum}, #{foodNum})")
    int insertFavoriteFood(@Param("userNum") Long userNum, @Param("foodNum") Long foodNum);
    
    /**
     * 즐겨찾기 음식 제거
     */
    @Delete("DELETE FROM hk_user_favorite_foods " +
            "WHERE user_num = #{userNum} AND food_num = #{foodNum}")
    int deleteFavoriteFood(@Param("userNum") Long userNum, @Param("foodNum") Long foodNum);
    
    /**
     * 사용자 즐겨찾기 음식 목록
     */
    @Select("SELECT f.user_num as userNum, f.food_num as foodNum, f.added_date as addedDate, " +
            "ft.food_name as foodName, ft.category, ft.calories_per_100g as caloriesPer100g " +
            "FROM hk_user_favorite_foods f " +
            "JOIN hk_food_types ft ON f.food_num = ft.food_num " +
            "WHERE f.user_num = #{userNum} " +
            "ORDER BY f.added_date DESC")
    List<UserFavoriteFoodVO> selectUserFavoriteFoods(Long userNum);
    
    /**
     * 즐겨찾기 여부 확인
     */
    @Select("SELECT COUNT(*) FROM hk_user_favorite_foods " +
            "WHERE user_num = #{userNum} AND food_num = #{foodNum}")
    int checkFavoriteFood(@Param("userNum") Long userNum, @Param("foodNum") Long foodNum);
    
    /**
     * 최근 많이 사용한 음식 (자동 즐겨찾기 추천용)
     */
    @Select("SELECT f.food_num as foodNum, ft.food_name as foodName, " +
            "ft.category, ft.calories_per_100g as caloriesPer100g, " +
            "COUNT(*) as recentUsageCount " +
            "FROM hk_user_foods f " +
            "JOIN hk_food_types ft ON f.food_num = ft.food_num " +
            "WHERE f.user_num = #{userNum} " +
            "AND f.record_date >= #{startDate} " +
            "GROUP BY f.food_num, ft.food_name, ft.category, ft.calories_per_100g " +
            "HAVING COUNT(*) >= 3 " +
            "ORDER BY COUNT(*) DESC " +
            "FETCH FIRST 10 ROWS ONLY")
    List<UserFavoriteFoodVO> selectFrequentlyUsedFoods(@Param("userNum") Long userNum,
                                                      @Param("startDate") Date startDate);
    
    // === 통계 및 분석 ===
    
    /**
     * 사용자 전체 통계
     */
    @Select("SELECT COUNT(*) as totalRecords, " +
            "COUNT(DISTINCT record_date) as totalDays, " +
            "AVG(daily_calories) as avgDailyCalories " +
            "FROM (" +
            "SELECT record_date, SUM(calories_consumed) as daily_calories " +
            "FROM hk_user_foods WHERE user_num = #{userNum} " +
            "GROUP BY record_date" +
            ")")
    Map<String, Object> selectUserTotalStats(Long userNum);
    
    /**
     * 카테고리별 섭취 통계 (최근 30일)
     */
    @Select("SELECT ft.category, " +
            "SUM(f.calories_consumed) as totalCalories, " +
            "COUNT(*) as recordCount " +
            "FROM hk_user_foods f " +
            "JOIN hk_food_types ft ON f.food_num = ft.food_num " +
            "WHERE f.user_num = #{userNum} " +
            "AND f.record_date >= #{startDate} " +
            "GROUP BY ft.category " +
            "ORDER BY SUM(f.calories_consumed) DESC")
    List<Map<String, Object>> selectCategoryStats(@Param("userNum") Long userNum,
                                                 @Param("startDate") Date startDate);
    
    /**
     * 식사 타입별 칼로리 분포 (최근 7일)
     */
    @Select("SELECT meal_type as mealType, " +
            "SUM(calories_consumed) as totalCalories, " +
            "AVG(calories_consumed) as avgCalories " +
            "FROM hk_user_foods " +
            "WHERE user_num = #{userNum} " +
            "AND record_date >= #{startDate} " +
            "GROUP BY meal_type " +
            "ORDER BY SUM(calories_consumed) DESC")
    List<Map<String, Object>> selectMealTypeDistribution(@Param("userNum") Long userNum,
                                                        @Param("startDate") Date startDate);
    
    /**
     * 기록 지속성 체크 (연속 기록 일수)
     */
    @Select("WITH consecutive_days AS ( " +
            "SELECT record_date, " +
            "ROW_NUMBER() OVER (ORDER BY record_date) - " +
            "ROW_NUMBER() OVER (PARTITION BY record_date ORDER BY record_date) as grp " +
            "FROM (SELECT DISTINCT record_date FROM hk_user_foods " +
            "WHERE user_num = #{userNum} ORDER BY record_date DESC) " +
            ") " +
            "SELECT MAX(cnt) as maxConsecutive FROM ( " +
            "SELECT COUNT(*) as cnt FROM consecutive_days GROUP BY grp" +
            ")")
    Integer selectMaxConsecutiveDays(Long userNum);
}