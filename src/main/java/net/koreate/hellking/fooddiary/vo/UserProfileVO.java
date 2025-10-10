package net.koreate.hellking.fooddiary.vo;

import java.util.Date;

import lombok.Data;

/**
 * 사용자 신체정보 및 목표 VO
 */
@Data
public class UserProfileVO {
    private Long userNum;
    private String gender;              // 'M', 'F'
    private Integer age;
    private Double weightKg;            // 체중 (kg)
    private Double heightCm;            // 키 (cm)
    private Integer targetCalories;     // 목표 칼로리
    private String activityLevel;       // 활동량 수준
    private Date createdAt;
    private Date updatedAt;
    
    // 조인용 필드
    private String username;
    private String email;
    
    /**
     * BMI 계산
     */
    public Double calculateBMI() {
        if (weightKg == null || heightCm == null || heightCm == 0) {
            return null;
        }
        
        double heightM = heightCm / 100.0;
        double bmi = weightKg / (heightM * heightM);
        return Math.round(bmi * 10.0) / 10.0; // 소수점 1자리
    }
    
    /**
     * 권장 칼로리 계산 (Harris-Benedict 공식 기반)
     */
    public Integer calculateRecommendedCalories() {
        if (gender == null || age == null || weightKg == null || heightCm == null) {
            // 기본값 반환
            return "M".equals(gender) ? 2200 : 1800;
        }
        
        double bmr;
        if ("M".equals(gender)) {
            bmr = 88.362 + (13.397 * weightKg) + (4.799 * heightCm) - (5.677 * age);
        } else {
            bmr = 447.593 + (9.247 * weightKg) + (3.098 * heightCm) - (4.330 * age);
        }
        
        // 활동량 반영
        double activityMultiplier = getActivityMultiplier();
        int recommendedCalories = (int) Math.round(bmr * activityMultiplier);
        
        // 최소 칼로리 제한 적용
        int minCalories = "M".equals(gender) ? 1500 : 1200;
        return Math.max(recommendedCalories, minCalories);
    }
    
    private double getActivityMultiplier() {
        if (activityLevel == null) return 1.55; // 기본값: 보통
        
        switch (activityLevel) {
            case "LOW": return 1.2;      // 좌식 생활
            case "MODERATE": return 1.55; // 보통 활동
            case "HIGH": return 1.9;      // 활발한 활동
            default: return 1.55;
        }
    }
    
    /**
     * 목표 칼로리 검증
     */
    public boolean isValidTargetCalories(int calories) {
        int minCalories = "M".equals(gender) ? 1500 : 1200;
        int maxCalories = 4000; // 상한선
        
        return calories >= minCalories && calories <= maxCalories;
    }
    
    /**
     * 활동량 표시명
     */
    public String getActivityLevelDisplayName() {
        if (activityLevel == null) return "보통";
        
        switch (activityLevel) {
            case "LOW": return "낮음";
            case "MODERATE": return "보통";
            case "HIGH": return "높음";
            default: return activityLevel;
        }
    }
}
