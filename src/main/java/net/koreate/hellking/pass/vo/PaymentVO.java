package net.koreate.hellking.pass.vo;

import lombok.Data;
import java.util.Date;

@Data
public class PaymentVO {
    private Long paymentNum;
    private Long userNum;
    private String paymentId;        // 포트원 결제 ID
    private String merchantUid;      // 가맹점 주문번호
    private Long amount;
    private String status;           // READY, PAID, CANCELLED, FAILED
    private String payMethod;        // card, trans, vbank 등
    private Date createdAt;
    private Date paidAt;
    
    // 결제 상세 정보
    private String cardName;         // 카드사명
    private String bankName;         // 은행명
    private String buyerName;
    private String buyerEmail;
    private String buyerTel;
}