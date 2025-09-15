package net.koreate.hellking.user.service;

import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import net.koreate.hellking.user.dao.UserDAO;
import net.koreate.hellking.user.vo.UserAuthVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;

@Service("smsAuth")
public class SMSAuthService implements AuthService {
    
    @Autowired
    private DefaultMessageService messageService;
    
    @Autowired
    private UserDAO userDAO;
    
    // 임시 저장소 (실제로는 Redis 사용 권장)
    private Map<String, String> authCodeStore = new HashMap<>();
    private Map<String, Long> authTimeStore = new HashMap<>();
    
    @Override
    public boolean sendVerification(String phone, String type) {
        try {
            String authCode = generateAuthCode();
            
            Message message = new Message();
            message.setFrom("01012345678"); // 발신번호
            message.setTo(phone);
            message.setText("[헬킹] 인증번호는 " + authCode + " 입니다. 3분 내에 입력해주세요.");
            
            SingleMessageSentResponse response = messageService.sendOne(
                new SingleMessageSendingRequest(message)
            );
            
            if ("2000".equals(response.getStatusCode())) {
                authCodeStore.put(phone, authCode);
                authTimeStore.put(phone, System.currentTimeMillis());
                return true;
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean verifyCode(String phone, String code) {
        String storedCode = authCodeStore.get(phone);
        Long sentTime = authTimeStore.get(phone);
        
        if (storedCode != null && sentTime != null) {
            // 3분 유효시간 체크
            if (System.currentTimeMillis() - sentTime <= 180000) { // 3분
                if (storedCode.equals(code)) {
                    authCodeStore.remove(phone);
                    authTimeStore.remove(phone);
                    return true;
                }
            }
        }
        return false;
    }
    
    @Override
    public boolean sendVerificationToUser(Long userNum, String phone, String type) {
        try {
            String authCode = generateAuthCode();
            
            // DB에 인증코드 저장
            UserAuthVO auth = new UserAuthVO();
            auth.setUserNum(userNum);
            auth.setAuthType("SMS");
            auth.setAuthCode(authCode);
            
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.MINUTE, 3); // 3분 후 만료
            auth.setExpireTime(cal.getTime());
            
            userDAO.insertAuthCode(auth);
            
            // SMS 발송
            Message message = new Message();
            message.setFrom("01012345678");
            message.setTo(phone);
            message.setText("[헬킹] 인증번호는 " + authCode + " 입니다. 3분 내에 입력해주세요.");
            
            SingleMessageSentResponse response = messageService.sendOne(
                new SingleMessageSendingRequest(message)
            );
            
            return "2000".equals(response.getStatusCode());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean verifyCodeForUser(Long userNum, String code) {
        try {
            int result = userDAO.verifyAuthCode(userNum, code);
            if (result > 0) {
                userDAO.updateAuthVerified(userNum, code);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    private String generateAuthCode() {
        Random random = new Random();
        return String.format("%06d", random.nextInt(1000000));
    }
}