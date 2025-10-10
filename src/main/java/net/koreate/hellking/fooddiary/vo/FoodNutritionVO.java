package net.koreate.hellking.fooddiary.vo;

import java.math.BigDecimal;
import java.math.RoundingMode;

import lombok.Data;

/**
 * 영양소 계산 결과 VO
 */
@Data
public class FoodNutritionVO {
    private Integer calories;    // 칼로리 (정수)
    private Double protein;      // 단백질 (g, 소수점 1자리)
    private Double carbs;        // 탄수화물 (g, 소수점 1자리)  
    private Double fat;          // 지방 (g, 소수점 1자리)
    
    /**
     * 영양소 합계 계산
     */
    public FoodNutritionVO add(FoodNutritionVO other) {
        FoodNutritionVO result = new FoodNutritionVO();
        result.setCalories(this.calories + other.calories);
        result.setProtein(round(this.protein + other.protein, 1));
        result.setCarbs(round(this.carbs + other.carbs, 1));
        result.setFat(round(this.fat + other.fat, 1));
        return result;
    }
    
    private double round(double value, int places) {
        BigDecimal bd = new BigDecimal(value);
        bd = bd.setScale(places, RoundingMode.HALF_UP);
        return bd.doubleValue();
    }
}