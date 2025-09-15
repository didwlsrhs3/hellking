package net.koreate.hellking.designbody.vo;

import lombok.Data;
import java.util.Date;

@Data
public class DesignBodyVO {
    private Long programNum;
    private String programName;
    private String programType;     // 'DIET', 'MUSCLE', 'CARDIO', 'REHAB'
    private String difficulty;      // 'BEGINNER', 'INTERMEDIATE', 'ADVANCED'
    private Integer duration;       // 프로그램 기간 (일)
    private String description;
    private String instructor;
    private String imagePath;
    private Long price;
    private String isActive;
    private Date createdAt;
    
    // 부가 정보
    private String targetAudience;  // 대상자
    private String equipment;       // 필요 장비
    private String schedule;        // 스케줄 정보
    
    public String getFormattedPrice() {
        if (price != null && price > 0) {
            return String.format("%,d원", price);
        }
        return "무료";
    }
    
    public String getDifficultyText() {
        if (difficulty == null) {
            return "일반";
        }
        switch (difficulty) {
            case "BEGINNER": return "초급";
            case "INTERMEDIATE": return "중급";
            case "ADVANCED": return "고급";
            default: return "일반";
        }
    }
    
    public String getTypeText() {
        if (programType == null) {
            return "종합";  // null 체크 추가
        }
        switch (programType) {
            case "DIET": return "다이어트";
            case "MUSCLE": return "근력강화";
            case "CARDIO": return "유산소";
            case "REHAB": return "재활운동";
            default: return "종합";
        }
    }
}