package net.koreate.hellking.fooddiary.vo;

import lombok.Data;

/**
 * 음식 참고 중량 정보 VO
 */
@Data
public class FoodReferenceWeightVO {
    private Long referenceNum;
    private Long foodNum;
    private String referenceUnit;    // "1공기", "중간크기 1개" 등
    private Double weightGrams;      // 해당 단위의 그람수
    private String description;      // 추가 설명
    
    /**
     * 표시용 문자열 생성
     */
    public String getDisplayText() {
        return String.format("%s (약 %.0fg)", referenceUnit, weightGrams);
    }
}