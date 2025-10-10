package net.koreate.hellking.fooddiary.vo;

import lombok.Data;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;
import java.util.List;

/**
 * 음식 기본 정보 VO
 */
@Data
public class FoodTypeVO {
    private Long foodNum;
    private String foodName;
    private String category;
    private Double caloriesPer100g;      // 100g당 칼로리
    private Double proteinPer100g;       // 100g당 단백질(g)
    private Double carbsPer100g;         // 100g당 탄수화물(g)
    private Double fatPer100g;           // 100g당 지방(g)
    private String isActive;
    private Date createdAt;
    
    // 조인용 필드 - 참고 중량 정보
    private List<FoodReferenceWeightVO> referenceWeights;
    
    /**
     * 특정 중량에 대한 영양소 계산
     */
    public FoodNutritionVO calculateNutrition(double grams) {
        FoodNutritionVO nutrition = new FoodNutritionVO();
        
        double multiplier = grams / 100.0;
        
        // 칼로리는 반올림하여 정수로
        nutrition.setCalories((int) Math.round(caloriesPer100g * multiplier));
        
        // 영양소는 소수점 1자리까지
        nutrition.setProtein(round(proteinPer100g * multiplier, 1));
        nutrition.setCarbs(round(carbsPer100g * multiplier, 1));
        nutrition.setFat(round(fatPer100g * multiplier, 1));
        
        return nutrition;
    }
    
    /**
     * 소수점 반올림 유틸리티
     */
    private double round(double value, int places) {
        if (places < 0) throw new IllegalArgumentException();
        
        BigDecimal bd = new BigDecimal(value);
        bd = bd.setScale(places, RoundingMode.HALF_UP);
        return bd.doubleValue();
    }
    
    /**
     * 카테고리별 표시명 변환
     */
    public String getCategoryDisplayName() {
        if (category == null) return "기타";
        
        switch (category) {
            case "곡류": return "곡류";
            case "채소류": return "채소류";
            case "과일류": return "과일류";
            case "육류": return "육류/단백질";
            case "유제품": return "유제품";
            case "음료": return "음료";
            case "간식": return "간식/디저트";
            default: return category;
        }
    }
}