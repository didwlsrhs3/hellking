package net.koreate.hellking.qr.vo;

import lombok.Data;

@Data
public class QRVisitResult {
    private boolean success;
    private String message;
    private String chainName;
    private String chainAddress;
    private Long chainNum;
    private String failureReason;
    
    public static QRVisitResult success(String chainName, String chainAddress, Long chainNum) {
        QRVisitResult result = new QRVisitResult();
        result.setSuccess(true);
        result.setMessage("입장이 승인되었습니다.");
        result.setChainName(chainName);
        result.setChainAddress(chainAddress);
        result.setChainNum(chainNum);
        return result;
    }
    
    public static QRVisitResult failure(String reason) {
        QRVisitResult result = new QRVisitResult();
        result.setSuccess(false);
        result.setMessage("입장이 거부되었습니다.");
        result.setFailureReason(reason);
        return result;
    }
}