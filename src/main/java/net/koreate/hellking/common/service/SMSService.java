package net.koreate.hellking.common.service;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

/**
 * 간단한 SMS 인증 서비스 (팀원 버전 개선)
 */
@Service
@Slf4j
public class SMSService {
    
    @Autowired
    private DefaultMessageService messageService;
    
    // 임시 인증코드 저장소 (실제로는 Redis 권장)
    private Map<String, String> authCodes = new HashMap<>();
    private Map<String, Long> authTimes = new HashMap<>();
    
    /**
     * SMS 인증번호 발송
     */
    public Map<String, Object> sendSMS(String phoneNumber) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 6자리 인증번호 생성
            String code = generateAuthCode();
            
            Message message = new Message();
            message.setFrom("01077528140"); // 발신번호
            message.setTo(phoneNumber);
            message.setText("[헬킹] 인증번호는 " + code + " 입니다. 3분 내에 입력해주세요.");
            
            SingleMessageSentResponse response = messageService.sendOne(
                new SingleMessageSendingRequest(message)
            );
            
            log.info("SMS 발송 결과: {}", response.getStatusCode());
            
            if ("2000".equals(response.getStatusCode())) {
                // 성공시 임시 저장
                authCodes.put(phoneNumber, code);
                authTimes.put(phoneNumber, System.currentTimeMillis());
                
                result.put("success", true);
                result.put("message", "인증번호가 발송되었습니다.");
                result.put("code", code); // 개발용 (운영시 제거)
                result.put("result", response.getStatusCode());
            } else {
                result.put("success", false);
                result.put("message", "SMS 발송에 실패했습니다.");
                result.put("result", response.getStatusCode());
            }
            
        } catch (Exception e) {
            log.error("SMS 발송 오류: ", e);
            result.put("success", false);
            result.put("message", "SMS 발송 중 오류가 발생했습니다.");
            result.put("result", "ERROR");
        }
        
        return result;
    }
    
    /**
     * SMS 인증번호 확인
     */
    public Map<String, Object> verifySMS(String phoneNumber, String code) {
        Map<String, Object> result = new HashMap<>();
        
        String storedCode = authCodes.get(phoneNumber);
        Long sentTime = authTimes.get(phoneNumber);
        
        if (storedCode == null || sentTime == null) {
            result.put("success", false);
            result.put("message", "발송된 인증번호가 없습니다.");
            return result;
        }
        
        // 3분 유효시간 체크
        if (System.currentTimeMillis() - sentTime > 180000) {
            authCodes.remove(phoneNumber);
            authTimes.remove(phoneNumber);
            result.put("success", false);
            result.put("message", "인증번호가 만료되었습니다.");
            return result;
        }
        
        // 인증번호 일치 확인
        if (storedCode.equals(code)) {
            authCodes.remove(phoneNumber);
            authTimes.remove(phoneNumber);
            result.put("success", true);
            result.put("message", "인증이 완료되었습니다.");
        } else {
            result.put("success", false);
            result.put("message", "인증번호가 일치하지 않습니다.");
        }
        
        return result;
    }
    
    /**
     * 6자리 인증번호 생성
     */
    private String generateAuthCode() {
        Random random = new Random();
        return String.format("%06d", random.nextInt(1000000));
    }
    
    /**
     * 특정 번호의 인증 상태 초기화 (선택적)
     */
    public void clearAuthData(String phoneNumber) {
        authCodes.remove(phoneNumber);
        authTimes.remove(phoneNumber);
    }
}