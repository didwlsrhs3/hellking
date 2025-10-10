package net.koreate.hellking.designbody.vo;

import lombok.Data;
import java.util.Date;

@Data
public class DesignBodyEnrollVO {
<<<<<<< HEAD
    private Long enrollNum;
    private Long userNum;
    private Long programNum;
    private Date startDate;
    private Date endDate;
    private String status;          // 'ACTIVE', 'COMPLETED', 'CANCELLED'
    private String paymentId;
    private Date enrollDate;
    
    // 조인용 필드
=======
    // 기본 필드들
    private Long enrollNum;
    private Long userNum;
    private Long programNum;        // 이 필드가 있어야 getProgramNum() 생성됨
    private Long chainNum;          // 체인점 번호
    private Date startDate;
    private Date endDate;
    private String status;
    private String paymentId;
    private Date enrollDate;
    
    // 조인용 필드들
>>>>>>> b65c320 (Initial commit)
    private String username;
    private String programName;
    private String programType;
    private String instructor;
    private Long price;
<<<<<<< HEAD
    
    // 진행률 계산
    private Integer progressPercent;
    
    public String getStatusText() {
=======
    private String chainName;       // 조인용 체인점명
    private String chainAddress;    // 조인용 체인점주소
    
    // 계산용 필드
    private Integer progressPercent;
    
    // 수동 메서드
    public String getStatusText() {
        if (status == null) return "대기";
>>>>>>> b65c320 (Initial commit)
        switch (status) {
            case "ACTIVE": return "진행중";
            case "COMPLETED": return "완료";
            case "CANCELLED": return "취소";
            default: return "대기";
        }
    }
}