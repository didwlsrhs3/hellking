package net.koreate.hellking.support.vo;

import lombok.Data;
import java.util.Date;

@Data
public class FAQVO {
    private Long faqNum;
    private String title;
    private String content;
    private Date createdAt;
    private Date updatedAt;
    private Long createdBy;
    private String status;
    private Long viewCount;
    
    // 조인용 필드
    private String createdByName; // 작성자 이름
    
    // 유틸리티 메서드
    public boolean isActive() {
        return "ACTIVE".equals(this.status);
    }
    
    public String getShortContent() {
        if (content != null && content.length() > 100) {
            return content.substring(0, 100) + "...";
        }
        return content;
    }
}
