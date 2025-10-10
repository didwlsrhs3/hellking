package net.koreate.hellking.fooddiary.vo;

import java.util.Date;

import lombok.Data;

/**
 * 즐겨찾기 음식 VO
 */
@Data
public class UserFavoriteFoodVO {
    private Long userNum;
    private Long foodNum;
    private Date addedDate;
    
    // 조인용 필드
    private String foodName;
    private String category;
    private Double caloriesPer100g;
    
    /**
     * 자주 사용하는 음식인지 체크 (최근 7일 내 3회 이상 사용)
     */
    private Integer recentUsageCount;
    
    public boolean isFrequentlyUsed() {
        return recentUsageCount != null && recentUsageCount >= 3;
    }
}
