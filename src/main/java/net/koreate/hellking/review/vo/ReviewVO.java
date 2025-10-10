package net.koreate.hellking.review.vo;

import lombok.Data;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
<<<<<<< HEAD
=======
import java.util.ArrayList;
import java.util.List;
>>>>>>> b65c320 (Initial commit)

@Data
public class ReviewVO {
    private Long reviewNum;
    private Long userNum;
    private Long chainNum;
    private Double rating;
    private String title;
    private String content;
<<<<<<< HEAD
    private Integer likeCount;        // Long → Integer로 변경
    private Integer dislikeCount;     // Long → Integer로 변경
    private String isExcellent;
    private Integer viewCount;        // Long → Integer로 변경
    private Timestamp createdAt;      // Date → Timestamp로 변경
=======
    private Integer likeCount;
    private Integer dislikeCount;
    private String isExcellent;
    private Integer viewCount;
    private Timestamp createdAt;
>>>>>>> b65c320 (Initial commit)
    
    // 조인용 필드
    private String username;
    private String userProfileImage;
    private String chainName;
    private String chainAddress;
<<<<<<< HEAD
    private Integer commentCount;     // Long → Integer로 변경
=======
    private Integer commentCount;
>>>>>>> b65c320 (Initial commit)
    
    // 현재 사용자의 좋아요/싫어요 상태
    private String currentUserLikeType; // 'LIKE', 'DISLIKE', null
    
<<<<<<< HEAD
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
=======
    // ===== 이미지 관련 필드 추가 =====
    // @JsonIgnore 제거 - 컴파일 문제 해결을 위해 임시 제거
    private List<ReviewImageVO> images = new ArrayList<>();
    
    // ===== Null-safe getter 메서드들 =====
    
>>>>>>> b65c320 (Initial commit)
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
<<<<<<< HEAD
=======
    
    // ===== 이미지 관련 메서드들 =====
    
    public List<ReviewImageVO> getImages() {
        return images != null ? images : new ArrayList<>();
    }

    public void setImages(List<ReviewImageVO> images) {
        this.images = images != null ? images : new ArrayList<>();
    }

    public boolean hasImages() {
        return images != null && !images.isEmpty();
    }

    public int getImageCount() {
        return images != null ? images.size() : 0;
    }

    public ReviewImageVO getFirstImage() {
        return hasImages() ? images.get(0) : null;
    }

    public String getFirstImagePath() {
        ReviewImageVO firstImage = getFirstImage();
        return firstImage != null ? firstImage.getImagePath() : null;
    }

    public String getFirstImageThumbnail() {
        ReviewImageVO firstImage = getFirstImage();
        return firstImage != null ? firstImage.getThumbnailPath() : null;
    }

    // 이미지 순서대로 정렬
    public void sortImagesByOrder() {
        if (images != null) {
            images.sort((img1, img2) -> {
                int order1 = img1.getImageOrder() != null ? img1.getImageOrder() : 999;
                int order2 = img2.getImageOrder() != null ? img2.getImageOrder() : 999;
                return Integer.compare(order1, order2);
            });
        }
    }
    
    // ===== 포매팅된 데이터 메서드들 =====
    
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
            return createdAt.toString();
        }
    }
    
    // ===== 우수리뷰 관련 메서드들 =====
    
    public boolean isExcellentReview() {
        int totalReactions = getLikeCount() + getDislikeCount();
        return "Y".equals(isExcellent) || totalReactions >= 5;
    }

    public boolean isCandidateReview() {
        int totalReactions = getLikeCount() + getDislikeCount();
        return totalReactions == 4;
    }

    public int getTotalReactions() {
        return getLikeCount() + getDislikeCount();
    }

    public int getNetLikes() {
        return getLikeCount() - getDislikeCount();
    }
>>>>>>> b65c320 (Initial commit)
}