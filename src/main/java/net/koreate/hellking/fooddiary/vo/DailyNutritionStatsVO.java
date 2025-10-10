package net.koreate.hellking.fooddiary.vo;

import java.util.Date;

import lombok.Data;

/**
 * 일일 영양소 통계 VO
 */
@Data
public class DailyNutritionStatsVO {
    private Date recordDate;
    private Integer totalCalories;
    private Double totalProtein;
    private Double totalCarbs;
    private Double totalFat;
    private Integer targetCalories;
    private Integer mealCount;          // 기록된 식사 수
    
    /**
     * 목표 대비 달성률 계산
     */
    public Integer getCaloriesAchievementPercent() {
        if (targetCalories == null || targetCalories == 0) {
            return 0;
        }
        
        return Math.min(100, (totalCalories * 100) / targetCalories);
    }
    
    /**
     * 탄단지 비율 계산
     */
    public MacroRatioVO getMacroRatio() {
        MacroRatioVO ratio = new MacroRatioVO();
        
        // null 안전 처리
        double protein = (totalProtein != null) ? totalProtein : 0.0;
        double carbs = (totalCarbs != null) ? totalCarbs : 0.0;
        double fat = (totalFat != null) ? totalFat : 0.0;
        
        double totalGrams = protein + carbs + fat;
        if (totalGrams == 0) {
            ratio.setProteinPercent(0);
            ratio.setCarbsPercent(0);
            ratio.setFatPercent(0);
            return ratio;
        }
        
        ratio.setProteinPercent((int) Math.round((protein / totalGrams) * 100));
        ratio.setCarbsPercent((int) Math.round((carbs / totalGrams) * 100));
        ratio.setFatPercent((int) Math.round((fat / totalGrams) * 100));
        
        return ratio;
    }
    
    /**
     * 목표 초과 여부
     */
    public boolean isOverTarget() {
        return targetCalories != null && totalCalories > targetCalories * 1.2; // 20% 초과시
    }
    
    /**
     * 권장 섭취량 대비 부족 여부
     */
    public boolean isUnderRecommended() {
        return targetCalories != null && totalCalories < targetCalories * 0.8; // 80% 미만시
    }
}

