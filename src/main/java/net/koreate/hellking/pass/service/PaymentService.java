package net.koreate.hellking.pass.service;

import net.koreate.hellking.pass.vo.PaymentVO;

public interface PaymentService {
    String createPayment(Long userNum, Long passNum) throws Exception;
    boolean verifyPayment(String paymentId) throws Exception;
    PaymentVO getPaymentInfo(String paymentId);
    boolean cancelPayment(String paymentId, String reason) throws Exception;
}