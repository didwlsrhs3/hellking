package net.koreate.hellking.review.vo;

import lombok.Data;
import java.util.Date;

@Data
public class ReviewCommentVO {
    private Long commentNum;
    private Long reviewNum;
    private Long userNum;
    private String content;
    private Date createdAt;
    
    // 조인용 필드
    private String username;
    private String userProfileImage;
    
    public String getFormattedCreatedAt() {
        return createdAt != null ? createdAt.toString() : "";
    }
}