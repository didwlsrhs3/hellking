package net.koreate.hellking.review.vo;

import lombok.Data;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Data
public class ReviewVO {
    private Long reviewNum;
    private Long userNum;
    private Long chainNum;
    private Double rating;
    private String title;
    private String content;
    private Integer likeCount;        // Long → Integer로 변경
    private Integer dislikeCount;     // Long → Integer로 변경
    private String isExcellent;
    private Integer viewCount;        // Long → Integer로 변경
    private Timestamp createdAt;      // Date → Timestamp로 변경
    
    // 조인용 필드
    private String username;
    private String userProfileImage;
    private String chainName;
    private String chainAddress;
    private Integer commentCount;     // Long → Integer로 변경
    
    // 현재 사용자의 좋아요/싫어요 상태
    private String currentUserLikeType; // 'LIKE', 'DISLIKE', null
    
    // 포매팅된 데이터 메서드들
    public String getFormattedRating() {
        if (rating != null) {
            return String.format("%.1f", rating);
        }
        return "0.0";
    }
    
    public String getShortContent() {
        if (content != null && content.length() > 100) {
            return content.substring(0, 100) + "...";
        }
        return content != null ? content : "";
    }
    
    public String getFormattedCreatedAt() {
        if (createdAt == null) return "";
        
        try {
            // Timestamp를 LocalDateTime으로 변환
            LocalDateTime dateTime = createdAt.toLocalDateTime();
            LocalDateTime now = LocalDateTime.now();
            
            // 오늘 작성된 경우 - 시:분만 표시
            if (dateTime.toLocalDate().equals(now.toLocalDate())) {
                return dateTime.format(DateTimeFormatter.ofPattern("HH:mm"));
            }
            
            // 올해 작성된 경우 - 월-일만 표시
            if (dateTime.getYear() == now.getYear()) {
                return dateTime.format(DateTimeFormatter.ofPattern("MM-dd"));
            }
            
            // 작년 이전 - 년-월-일 표시
            return dateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } catch (Exception e) {
            // 변환 오류 시 기본 형식 반환
            return createdAt.toString();
        }
    }
    
    public boolean isExcellentReview() {
        return "Y".equals(isExcellent) || 
               (rating != null && rating >= 4.5 && 
                likeCount != null && likeCount >= 10);
    }
    
    // Null-safe getter 메서드들 추가
    public Integer getLikeCount() {
        return likeCount != null ? likeCount : 0;
    }
    
    public Integer getDislikeCount() {
        return dislikeCount != null ? dislikeCount : 0;
    }
    
    public Integer getViewCount() {
        return viewCount != null ? viewCount : 0;
    }
    
    public Integer getCommentCount() {
        return commentCount != null ? commentCount : 0;
    }
    
    public Double getRating() {
        return rating != null ? rating : 0.0;
    }
    
    public String getContent() {
        return content != null ? content : "";
    }
    
    public String getTitle() {
        return title != null ? title : "";
    }
    
    public String getUsername() {
        return username != null ? username : "Unknown";
    }
    
    public String getChainName() {
        return chainName != null ? chainName : "";
    }
    
    public String getUserProfileImage() {
        return userProfileImage != null ? userProfileImage : "default-avatar.png";
    }
    
    public String getChainAddress() {
        return chainAddress != null ? chainAddress : "";
    }
}