package net.koreate.hellking.fooddiary.vo;

import lombok.Data;

/**
 * 탄단지 비율 VO
 */
@Data  
public class MacroRatioVO {
    private Integer proteinPercent;     // 단백질 비율 (%)
    private Integer carbsPercent;       // 탄수화물 비율 (%)
    private Integer fatPercent;         // 지방 비율 (%)
    
    /**
     * 균형잡힌 식단 여부 체크
     */
    public boolean isBalanced() {
        // 권장 비율: 단백질 15-25%, 탄수화물 45-65%, 지방 20-35%
        return proteinPercent >= 15 && proteinPercent <= 25 &&
               carbsPercent >= 45 && carbsPercent <= 65 &&
               fatPercent >= 20 && fatPercent <= 35;
    }
}