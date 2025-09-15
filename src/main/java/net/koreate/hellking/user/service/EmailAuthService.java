package net.koreate.hellking.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import net.koreate.hellking.user.dao.UserDAO;
import net.koreate.hellking.user.vo.UserAuthVO;

import java.util.*;

@Service("emailAuth")
public class EmailAuthService implements AuthService {
    
    @Autowired
    private JavaMailSender mailSender;
    
    @Autowired
    private UserDAO userDAO;
    
    // 임시 저장소
    private Map<String, String> authCodeStore = new HashMap<>();
    private Map<String, Long> authTimeStore = new HashMap<>();
    
    @Override
    public boolean sendVerification(String email, String type) {
        try {
            String authCode = generateAuthCode();
            
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("[헬킹] 이메일 인증번호");
            message.setText("인증번호는 " + authCode + " 입니다.\n3분 내에 입력해주세요.");
            
            mailSender.send(message);
            
            authCodeStore.put(email, authCode);
            authTimeStore.put(email, System.currentTimeMillis());
            return true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    @Override
    public boolean verifyCode(String email, String code) {
        String storedCode = authCodeStore.get(email);
        Long sentTime = authTimeStore.get(email);
        
        if (storedCode != null && sentTime != null) {
            if (System.currentTimeMillis() - sentTime <= 180000) { // 3분
                if (storedCode.equals(code)) {
                    authCodeStore.remove(email);
                    authTimeStore.remove(email);
                    return true;
                }
            }
        }
        return false;
    }
    
    @Override
    public boolean sendVerificationToUser(Long userNum, String email, String type) {
        try {
            String authCode = generateAuthCode();
            
            // DB에 인증코드 저장
            UserAuthVO auth = new UserAuthVO();
            auth.setUserNum(userNum);
            auth.setAuthType("EMAIL");
            auth.setAuthCode(authCode);
            
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.MINUTE, 3);
            auth.setExpireTime(cal.getTime());
            
            userDAO.insertAuthCode(auth);
            
            // 이메일 발송
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("[헬킹] 이메일 인증번호");
            message.setText("인증번호는 " + authCode + " 입니다.\n3분 내에 입력해주세요.");
            
            mailSender.send(message);
            return true;
            
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