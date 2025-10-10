package net.koreate.hellking.fooddiary.vo;

import java.util.Date;

import lombok.Data;

/**
 * 사용자 음식 섭취 기록 VO
 */
@Data
public class UserFoodLogVO {
    private Long foodLogNum;
    private Long userNum;
    private Long foodNum;
    private Double amountGrams;         // 섭취량 (g)
    private Integer caloriesConsumed;   // 섭취 칼로리 (정수)
    private Double proteinConsumed;     // 섭취 단백질 (g)
    private Double carbsConsumed;       // 섭취 탄수화물 (g)
    private Double fatConsumed;         // 섭취 지방 (g)
    private String mealType;            // 식사 타입
    private Date recordDate;            // 기록일
    private Date createdAt;
    
    // 조인용 필드
    private String foodName;
    private String category;
    private String username;
    
    /**
     * 식사 타입 표시명
     */
    public String getMealTypeDisplayName() {
        if (mealType == null) return "기타";
        
        switch (mealType) {
            case "아침": return "아침";
            case "점심": return "점심"; 
            case "저녁": return "저녁";
            case "간식": return "간식";
            default: return "기타";
        }
    }
    
    /**
     * 수정 가능 여부 (당일 기록만 수정 가능)
     */
    public boolean isEditable() {
        if (recordDate == null) return false;
        
        Date today = new Date();
        Date recordDateOnly = new Date(recordDate.getYear(), recordDate.getMonth(), recordDate.getDate());
        Date todayOnly = new Date(today.getYear(), today.getMonth(), today.getDate());
        
        return recordDateOnly.equals(todayOnly);
    }
}