package net.koreate.hellking.pass.vo;

import lombok.Data;
<<<<<<< HEAD
=======
import net.koreate.hellking.common.utils.EncryptionUtil;
>>>>>>> b65c320 (Initial commit)
import java.util.Date;

@Data
public class RefundVO {
    private Long refundNum;
    private Long userPassNum;
    private Long refundAmount;
    private String reason;
<<<<<<< HEAD
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
=======
    private String status;              // REQUESTED, APPROVED, REJECTED, COMPLETED
    private Date requestDate;
    private Date processDate;           // 처리일 (승인/거절/완료 시점)
    private String rejectReason;        // 거절 사유
    
    // 계좌 정보 (새로 추가)
    private String bankName;            // 은행명 (평문)
    private String accountNumber;       // 계좌번호 (DB에는 암호화 저장)
    private String accountHolder;       // 예금주명 (DB에는 암호화 저장)
    
    // 조인용 필드들
    private Long passNum;
    private String passName;
    private String username;
    private Long originalPrice;         // 원래 결제 금액
    
    // 표시용 필드들
    private String statusText;          // 상태 텍스트
    private String formattedRefundAmount; // 포맷된 환불 금액
    
    /**
     * DB에서 조회한 암호화된 계좌번호를 복호화
     */
    public void setEncryptedAccountNumber(String encryptedAccountNumber) {
        this.accountNumber = EncryptionUtil.decrypt(encryptedAccountNumber);
    }
    
    /**
     * DB 저장을 위한 계좌번호 암호화
     */
    public String getEncryptedAccountNumber() {
        return EncryptionUtil.encrypt(this.accountNumber);
    }
    
    /**
     * DB에서 조회한 암호화된 예금주명을 복호화
     */
    public void setEncryptedAccountHolder(String encryptedAccountHolder) {
        this.accountHolder = EncryptionUtil.decrypt(encryptedAccountHolder);
    }
    
    /**
     * DB 저장을 위한 예금주명 암호화
     */
    public String getEncryptedAccountHolder() {
        return EncryptionUtil.encrypt(this.accountHolder);
    }
    
    /**
     * 관리자 화면용 마스킹된 계좌번호
     */
    public String getMaskedAccountNumber() {
        return EncryptionUtil.maskAccountNumber(this.accountNumber);
    }
    
    /**
     * 관리자 화면용 마스킹된 예금주명
     */
    public String getMaskedAccountHolder() {
        return EncryptionUtil.maskName(this.accountHolder);
    }
    
    /**
     * 계좌 정보가 있는지 확인
     */
    public boolean hasAccountInfo() {
        return bankName != null && !bankName.trim().isEmpty() &&
               accountNumber != null && !accountNumber.trim().isEmpty() &&
               accountHolder != null && !accountHolder.trim().isEmpty();
    }
>>>>>>> b65c320 (Initial commit)
}