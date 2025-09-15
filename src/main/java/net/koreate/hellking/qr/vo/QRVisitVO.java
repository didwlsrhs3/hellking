package net.koreate.hellking.qr.vo;

import lombok.Data;
import java.util.Date;

@Data
public class QRVisitVO {
    private Long visitNum;
    private Long userNum;
    private Long chainNum;
    private Date visitTime;
    private String result;           // SUCCESS, FAILED
    private String failureReason;    // 실패 사유
    
    // 조인용 필드
    private String userId;
    private String username;
    private String chainName;
    private String chainAddress;
    private String chainCode;
    
    // 표시용 필드
    private String resultText;       // 성공/실패 텍스트
    private String visitTimeText;    // 포맷된 시간
}