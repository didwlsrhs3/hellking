package net.koreate.hellking.pass.vo;

import lombok.Data;
import java.util.Date;

@Data
public class UserPassVO {
    private Long userPassNum;
    private Long userNum;
    private Long passNum;
    private Date startDate;
    private Date endDate;
    private String status;           // ACTIVE, EXPIRED, CANCELLED, REFUNDED
    private Date purchaseDate;
    private String paymentId;
    
    // 조인용 필드
    private String userId;
    private String username;
    private String passName;
    private Long price;
    private Integer durationDays;
    
    // 계산된 필드
    private Integer remainingDays;   // 남은 일수
    private Boolean isExpired;       // 만료 여부
    private Boolean canRefund;       // 환불 가능 여부
    
    // 표시용 필드
    private String statusText;       // 상태 텍스트
    private String formattedPrice;   // 포맷된 가격
}