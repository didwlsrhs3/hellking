package net.koreate.hellking.pass.vo;

import lombok.Data;
import java.util.Date;

@Data
public class RefundVO {
    private Long refundNum;
    private Long userPassNum;
    private Long refundAmount;
    private String reason;
    private String status;           // REQUESTED, APPROVED, REJECTED, COMPLETED
    private Date requestDate;
    private Date processDate;
    private String rejectReason;
    
    // 조인용 필드
    private String passName;
    private String username;
    private Long originalPrice;
    
    // 표시용 필드
    private String statusText;
    private String formattedRefundAmount;
}