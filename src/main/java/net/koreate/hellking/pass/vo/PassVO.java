package net.koreate.hellking.pass.vo;

import lombok.Data;
import java.util.Date;

@Data
public class PassVO {
    private Long passNum;
    private String passName;
    private Long price;
    private Integer durationDays;
    private String description;
    private String isActive;
    private Date createdAt;
    
    // 표시용 포맷된 필드들
    private String formattedPrice;    // 50,000원
    private String durationText;      // 30일권, 90일권 등

    // getDurationText() 메서드만 있고, getFormattedPrice() 로직이 없음
    
    public String getDurationText() {
        if (durationText == null && durationDays != null) {
            return durationDays + "일권";
        }
        return durationText;
    }
}