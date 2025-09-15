package net.koreate.hellking.designbody.vo;

import lombok.Data;
import java.util.Date;

@Data
public class DesignBodyEnrollVO {
    private Long enrollNum;
    private Long userNum;
    private Long programNum;
    private Date startDate;
    private Date endDate;
    private String status;          // 'ACTIVE', 'COMPLETED', 'CANCELLED'
    private String paymentId;
    private Date enrollDate;
    
    // 조인용 필드
    private String username;
    private String programName;
    private String programType;
    private String instructor;
    private Long price;
    
    // 진행률 계산
    private Integer progressPercent;
    
    public String getStatusText() {
        switch (status) {
            case "ACTIVE": return "진행중";
            case "COMPLETED": return "완료";
            case "CANCELLED": return "취소";
            default: return "대기";
        }
    }
}