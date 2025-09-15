package net.koreate.hellking.chain.vo;

import lombok.Data;
import java.util.Date;

@Data
public class ChainVO {
    private Long chainNum;
    private String chainName;
    private String address;
    private String phone;
    private String description;
    private String imagePath;
    private Date createdAt;
    
    // 가맹점 코드 관련
    private String chainCode;    // 4자리 코드
    private String isActive;
    
    // 조인용 필드
    private Long reviewCount;    // 리뷰 수
    private Double avgRating;    // 평균 평점
    private Long visitCount;     // 방문 수
    
    // 거리 계산용 (검색 시 사용)
    private Double distance;
    private String distanceText;
    
    // 추가 정보
    private String facilities;   // 부대시설 정보
    private String operatingHours; // 운영시간
    private String parking;      // 주차 정보
    
    // 포매팅된 데이터
    public String getFormattedAddress() {
        if (address != null && address.length() > 20) {
            return address.substring(0, 20) + "...";
        }
        return address;
    }
    
    public String getFormattedRating() {
        if (avgRating != null) {
            return String.format("%.1f", avgRating);
        }
        return "0.0";
    }
    
    public String getReviewCountText() {
        if (reviewCount == null || reviewCount == 0) {
            return "리뷰 없음";
        }
        return reviewCount + "개 리뷰";
    }
}