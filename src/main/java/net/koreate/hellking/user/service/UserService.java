package net.koreate.hellking.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import net.koreate.hellking.user.dao.UserDAO;
import net.koreate.hellking.user.vo.UserVO;

import javax.servlet.http.HttpSession;

@Service
@Transactional
public class UserService {
    
    @Autowired
    private UserDAO userDAO;
    
    @Autowired
    @Qualifier("smsAuth")
    private AuthService smsAuthService;
    
    @Autowired
    @Qualifier("emailAuth")
    private AuthService emailAuthService;
    
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    
    // === 전역에서 사용하는 핵심 메서드 ===
    public Long getCurrentUserNum(HttpSession session) {
        return (Long) session.getAttribute("userNum");
    }
    
    public UserVO getCurrentUser(HttpSession session) {
        Long userNum = getCurrentUserNum(session);
        if (userNum != null) {
            return userDAO.selectByUserNum(userNum);
        }
        return null;
    }
    
    public boolean isLoggedIn(HttpSession session) {
        return getCurrentUserNum(session) != null;
    }
    
    // === 회원가입 ===
    public boolean registerUser(UserVO user) throws Exception {
        // 중복 체크
        if (userDAO.checkDuplicateUserId(user.getUserId()) > 0) {
            throw new Exception("이미 사용중인 아이디입니다.");
        }
        if (userDAO.checkDuplicateEmail(user.getEmail()) > 0) {
            throw new Exception("이미 사용중인 이메일입니다.");
        }
        if (userDAO.checkDuplicatePhone(user.getPhone()) > 0) {
            throw new Exception("이미 사용중인 전화번호입니다.");
        }
        
        // 비밀번호 암호화
        String encryptedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encryptedPassword);
        
        // 기본 프로필 이미지 설정
        if (user.getProfileImage() == null || user.getProfileImage().trim().isEmpty()) {
            user.setProfileImage("avatar1.png");
        }
        
        return userDAO.insertUser(user) > 0;
    }
    
    // === 로그인 ===
    public UserVO login(String userId, String password, HttpSession session) throws Exception {
        UserVO user = userDAO.selectByUserId(userId);
        
        if (user == null) {
            throw new Exception("존재하지 않는 아이디입니다.");
        }
        
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new Exception("비밀번호가 올바르지 않습니다.");
        }
        
        if (!"ACTIVE".equals(user.getStatus())) {
            throw new Exception("비활성화된 계정입니다.");
        }
        
        // 디버깅: 사용자 정보 출력
        System.out.println("=== 로그인 디버깅 ===");
        System.out.println("UserVO 전체: " + user.toString());
        System.out.println("UserNum: " + user.getUserNum());
        System.out.println("UserId: " + user.getUserId());  
        System.out.println("Username: " + user.getUsername());
        System.out.println("UserNum이 null인가?: " + (user.getUserNum() == null));
        System.out.println("UserId가 null인가?: " + (user.getUserId() == null));
        System.out.println("=====================");
        
        // 세션 설정 - null 체크와 함께
        if (user.getUserNum() != null) {
            session.setAttribute("userNum", user.getUserNum());
            System.out.println("✅ userNum 세션 저장 성공: " + user.getUserNum());
        } else {
            System.out.println("❌ userNum이 null이어서 세션 저장 실패");
        }
        
        if (user.getUserId() != null && !user.getUserId().trim().isEmpty()) {
            session.setAttribute("userId", user.getUserId());
            System.out.println("✅ userId 세션 저장 성공: " + user.getUserId());
        } else {
            System.out.println("❌ userId가 null이거나 비어있어서 세션 저장 실패");
        }
        
        if (user.getUsername() != null && !user.getUsername().trim().isEmpty()) {
            session.setAttribute("username", user.getUsername());
            System.out.println("✅ username 세션 저장 성공: " + user.getUsername());
        } else {
            System.out.println("❌ username이 null이거나 비어있어서 세션 저장 실패");
        }
        
        // 세션 저장 후 확인
        System.out.println("=== 세션 저장 결과 ===");
        System.out.println("세션 userNum: " + session.getAttribute("userNum"));
        System.out.println("세션 userId: " + session.getAttribute("userId"));
        System.out.println("세션 username: " + session.getAttribute("username"));
        System.out.println("====================");
        
        return user;
    }
    
    // === 로그아웃 ===
    public void logout(HttpSession session) {
        session.invalidate();
    }
    
    // === 중복 체크 ===
    public boolean isUserIdAvailable(String userId) {
        return userDAO.checkDuplicateUserId(userId) == 0;
    }
    
    public boolean isEmailAvailable(String email) {
        return userDAO.checkDuplicateEmail(email) == 0;
    }
    
    public boolean isPhoneAvailable(String phone) {
        return userDAO.checkDuplicatePhone(phone) == 0;
    }
    
    // === 인증 관련 ===
    public boolean sendSMSAuthCode(String phone) {
        return smsAuthService.sendVerification(phone, "SMS");
    }
    
    public boolean verifySMSAuthCode(String phone, String code) {
        return smsAuthService.verifyCode(phone, code);
    }
    
    public boolean sendEmailAuthCode(String email) {
        return emailAuthService.sendVerification(email, "EMAIL");
    }
    
    public boolean verifyEmailAuthCode(String email, String code) {
        return emailAuthService.verifyCode(email, code);
    }
    
    // 사용자별 인증 (DB 기반)
    public boolean sendSMSAuthCodeToUser(Long userNum, String phone) {
        return smsAuthService.sendVerificationToUser(userNum, phone, "SMS");
    }
    
    public boolean verifySMSAuthCodeForUser(Long userNum, String code) {
        return smsAuthService.verifyCodeForUser(userNum, code);
    }
    
    // === 사용자 정보 관리 ===
    public UserVO getUserWithActivePass(Long userNum) {
        return userDAO.getUserWithActivePass(userNum);
    }
    
    public boolean updateUser(UserVO user) {
        return userDAO.updateUser(user) > 0;
    }
    
    public boolean updatePassword(Long userNum, String currentPassword, String newPassword) throws Exception {
        UserVO user = userDAO.selectByUserNum(userNum);
        
        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            throw new Exception("현재 비밀번호가 올바르지 않습니다.");
        }
        
        String encryptedNewPassword = passwordEncoder.encode(newPassword);
        return userDAO.updatePassword(userNum, encryptedNewPassword) > 0;
    }
    
    public boolean deactivateUser(Long userNum) {
        return userDAO.deactivateUser(userNum) > 0;
    }
    
    // === 아이디/패스워드 찾기 ===
    public String findUserId(String email, String phone) {
        return userDAO.findUserIdByEmailAndPhone(email, phone);
    }
    
    public boolean resetPassword(String userId, String email, String newPassword) throws Exception {
        Long userNum = userDAO.findUserNumForPasswordReset(userId, email);
        if (userNum == null) {
            throw new Exception("사용자 정보가 일치하지 않습니다.");
        }
        
        String encryptedPassword = passwordEncoder.encode(newPassword);
        return userDAO.updatePassword(userNum, encryptedPassword) > 0;
    }
}