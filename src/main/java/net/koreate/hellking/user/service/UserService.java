package net.koreate.hellking.user.service;

<<<<<<< HEAD
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
=======
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.common.utils.FileUtils;
import net.koreate.hellking.user.dao.UserDAO;
import net.koreate.hellking.user.vo.SocialUserVO;
import net.koreate.hellking.user.vo.UserVO;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

/**
 * 통합 UserService - 탈퇴 재가입 시스템 포함
 */
@Service
@Transactional
@Slf4j
>>>>>>> b65c320 (Initial commit)
public class UserService {
    
    @Autowired
    private UserDAO userDAO;
    
    @Autowired
<<<<<<< HEAD
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
=======
    private BCryptPasswordEncoder passwordEncoder;
    
    @Autowired
    private ServletContext servletContext;
    
    @Autowired
    private DefaultMessageService messageService;
    
    @Autowired
    private JavaMailSender mailSender;
    
    @Value("${upload.path}")
    private String uploadPath;
    
    @Value("${profile.image.max.size}")
    private long maxProfileImageSize;
    
    @Value("${profile.image.allowed.types}")
    private String allowedImageTypes;
    
    @Value("${sms.from.number:}")
    private String fromNumber;
    
    private String realPath;
    
    // SMS/이메일 인증 코드 임시 저장소
    private Map<String, String> smsAuthCodes = new HashMap<>();
    private Map<String, Long> smsAuthTimes = new HashMap<>();
    private Map<String, String> emailAuthCodes = new HashMap<>();
    private Map<String, Long> emailAuthTimes = new HashMap<>();
    
    @PostConstruct
    public void initPath() {
        realPath = servletContext.getRealPath(File.separator + uploadPath);
        File file = new File(realPath);
        if (!file.exists()) {
            file.mkdirs();
            log.info("업로드 경로 생성 완료: {}", realPath);
        }
        
        File profilesDir = new File(realPath, "profiles");
        if (!profilesDir.exists()) {
            profilesDir.mkdirs();
            log.info("프로필 이미지 경로 생성 완료: {}", profilesDir.getAbsolutePath());
        }
        
        log.info("UserService 초기화 완료");
    }
    
    // === 핵심 세션 관리 메서드 ===
    
    public Long getCurrentUserNum(HttpSession session) {
        Long userNum = (Long) session.getAttribute("userNum");
        if (userNum != null) {
            return userNum;
        }
        
        UserVO userInfo = (UserVO) session.getAttribute("userInfo");
        if (userInfo != null && userInfo.getUserNum() != null) {
            return userInfo.getUserNum();
        }
        
        return null;
>>>>>>> b65c320 (Initial commit)
    }
    
    public UserVO getCurrentUser(HttpSession session) {
        Long userNum = getCurrentUserNum(session);
        if (userNum != null) {
            return userDAO.selectByUserNum(userNum);
        }
<<<<<<< HEAD
=======
        
        UserVO userInfo = (UserVO) session.getAttribute("userInfo");
        if (userInfo != null) {
            return userInfo;
        }
        
>>>>>>> b65c320 (Initial commit)
        return null;
    }
    
    public boolean isLoggedIn(HttpSession session) {
<<<<<<< HEAD
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
=======
        return getCurrentUserNum(session) != null || session.getAttribute("userInfo") != null;
    }
    
    public boolean isAdmin(HttpSession session) {
        UserVO user = getCurrentUser(session);
        if (user == null) {
            return false;
        }
        
        String[] adminUsers = {"admin", "aqunasl22"};
        for (String adminId : adminUsers) {
            if (adminId.equals(user.getUserId())) {
                return true;
            }
        }
        return false;
    }
    
    public String getCurrentSocialProvider(HttpSession session) {
        UserVO user = getCurrentUser(session);
        if (user != null && user.isSocialUser()) {
            List<SocialUserVO> socialAccounts = getUserSocialAccounts(user.getUserNum());
            if (!socialAccounts.isEmpty()) {
                return socialAccounts.get(0).getProvider();
            }
        }
        return null;
    }
    
    // === 회원가입 - 완전 수정된 버전 ===
    
    /**
     * 완전 수정된 회원가입 메서드 - 자동 재활성화 시스템
     */
    @Transactional(rollbackFor = Exception.class)
    public String userJoin(UserVO vo, MultipartFile profileImage) throws Exception {
        log.info("=== 회원가입/재가입 처리 시작 ===");
        log.info("시도 중인 이메일: {}, 아이디: {}", vo.getEmail(), vo.getUserId());
        
        // Step 1: 이메일로 기존 탈퇴 계정 확인
        if (vo.getEmail() != null && !vo.getEmail().trim().isEmpty()) {
            UserVO existingUser = findInactiveUserByEmail(vo.getEmail());
            if (existingUser != null) {
                log.info("탈퇴한 계정 발견 (이메일 기준): userNum={}, userId={}", 
                         existingUser.getUserNum(), existingUser.getUserId());
                return reactivateAccount(existingUser, vo, profileImage);
            }
        }
        
        // Step 2: 아이디로도 확인 (이메일이 다를 수 있으니)
        UserVO existingUserById = findInactiveUserById(vo.getUserId());
        if (existingUserById != null) {
            log.info("탈퇴한 계정 발견 (아이디 기준): userNum={}", existingUserById.getUserNum());
            return reactivateAccount(existingUserById, vo, profileImage);
        }
        
        // Step 3: 완전히 새로운 가입 처리
        return processNewUserJoin(vo, profileImage);
    }
    
    /**
     * 기존 탈퇴 계정 재활성화
     */
    private String reactivateAccount(UserVO existingUser, UserVO newData, MultipartFile profileImage) {
        try {
            log.info("기존 계정 재활성화 처리: userNum={}", existingUser.getUserNum());
            
            // 새로운 정보로 업데이트
            existingUser.setUsername(newData.getUsername());
            existingUser.setPassword(passwordEncoder.encode(newData.getPassword()));
            existingUser.setBirthDate(newData.getBirthDate());
            existingUser.setGender(newData.getGender());
            
            // 연락처 정보 업데이트 (NULL 처리)
            existingUser.setEmail(normalizeContactInfo(newData.getEmail()));
            existingUser.setPhone(normalizeContactInfo(newData.getPhone()));
            
            // 프로필 이미지 처리
            processProfileImage(existingUser, profileImage);
            
            // 계정 재활성화
            userDAO.reactivateUser(existingUser.getUserNum());
            userDAO.updateUser(existingUser);
            
            log.info("계정 재활성화 완료: userId={}", existingUser.getUserId());
            return "REACTIVATED";
            
        } catch (Exception e) {
            log.error("계정 재활성화 실패: {}", e.getMessage(), e);
            throw new RuntimeException("계정 재활성화 중 오류: " + e.getMessage());
        }
    }
    
    /**
     * 완전히 새로운 사용자 가입 처리
     */
    private String processNewUserJoin(UserVO vo, MultipartFile profileImage) throws Exception {
        log.info("새로운 사용자 가입 처리");
        
        // 기본값 설정
        vo.setProfileImage("avatar1.png");
        
        // 연락처 정보 NULL 처리 (UNIQUE 제약 조건 대응)
        vo.setEmail(normalizeContactInfo(vo.getEmail()));
        vo.setPhone(normalizeContactInfo(vo.getPhone()));
        
        if (vo.getAccountType() == null) {
            vo.setAccountType("REGULAR");
        }
        
        // 프로필 이미지 처리
        processProfileImage(vo, profileImage);
        
        // 비밀번호 암호화
        if (vo.getPassword() != null) {
            vo.setPassword(passwordEncoder.encode(vo.getPassword()));
        }
        
        // 중복 체크 (ACTIVE 계정만)
        if (userDAO.checkDuplicateUserIdActive(vo.getUserId()) > 0) {
            throw new Exception("이미 사용중인 아이디입니다.");
        }
        if (vo.getEmail() != null && userDAO.checkDuplicateEmailActive(vo.getEmail()) > 0) {
            throw new Exception("이미 사용중인 이메일입니다.");
        }
        if (vo.getPhone() != null && userDAO.checkDuplicatePhoneActive(vo.getPhone()) > 0) {
            throw new Exception("이미 사용중인 전화번호입니다.");
        }
        
        int result = userDAO.insertUser(vo);
        return result == 1 ? "SUCCESS" : "FAILED";
    }
    
    /**
     * 헬퍼 메서드들
     */
    private String normalizeContactInfo(String contact) {
        return (contact != null && !contact.trim().isEmpty()) ? contact.trim() : null;
    }
    
    private void processProfileImage(UserVO user, MultipartFile profileImage) {
        if (profileImage != null && !profileImage.isEmpty()) {
            try {
                log.info("프로필 이미지 업로드 시도: {}", profileImage.getOriginalFilename());
                
                // 파일 크기 검증
                long maxSize = Long.parseLong(String.valueOf(maxProfileImageSize));
                if (profileImage.getSize() > maxSize) {
                    throw new Exception("프로필 이미지 크기는 " + (maxSize / 1024 / 1024) + "MB를 초과할 수 없습니다.");
                }
                
                // 파일 확장자 검증
                String originalFilename = profileImage.getOriginalFilename();
                if (originalFilename != null) {
                    String extension = originalFilename.substring(originalFilename.lastIndexOf(".") + 1).toLowerCase();
                    if (!allowedImageTypes.contains(extension)) {
                        throw new Exception("지원하지 않는 이미지 형식입니다. 허용 형식: " + allowedImageTypes);
                    }
                }
                
                // FileUtils를 사용하여 파일 업로드
                String profileImg = FileUtils.uploadFile(realPath, profileImage);
                
                // 파일명 길이 제한 (이제 500자까지 가능하므로 여유롭게)
                if (profileImg.length() > 450) { // 여유분 50자
                    profileImg = truncateFileName(profileImg, 450);
                }
                
                user.setProfileImage(profileImg);
                log.info("프로필 이미지 처리 완료: {}", profileImg);
                
            } catch (Exception e) {
                log.warn("프로필 이미지 업로드 실패, 기본값 유지: {}", e.getMessage());
                // 프로필 이미지 실패해도 가입은 계속 진행
            }
        }
    }
    
    /**
     * 파일명 길이 제한 유틸리티
     */
    private String truncateFileName(String fileName, int maxLength) {
        if (fileName.length() <= maxLength) {
            return fileName;
        }
        
        String extension = "";
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex > 0) {
            extension = fileName.substring(dotIndex);
        }
        
        int lastSlashIndex = fileName.lastIndexOf('/');
        String pathPart = "";
        String fileNamePart = fileName;
        
        if (lastSlashIndex > 0) {
            pathPart = fileName.substring(0, lastSlashIndex + 1);
            fileNamePart = fileName.substring(lastSlashIndex + 1);
        }
        
        int maxFileNameLength = maxLength - pathPart.length() - extension.length();
        if (maxFileNameLength > 0) {
            String truncatedFileName = fileNamePart.substring(0, 
                Math.min(fileNamePart.lastIndexOf('.'), maxFileNameLength)) + extension;
            return pathPart + truncatedFileName;
        }
        
        return fileName.substring(0, maxLength);
    }
    
    /**
     * 탈퇴한 계정 찾기 헬퍼 메서드들
     */
    private UserVO findInactiveUserByEmail(String email) {
        if (email == null || email.trim().isEmpty()) return null;
        return userDAO.findInactiveUserByEmail(email);
    }
    
    private UserVO findInactiveUserById(String userId) {
        return userDAO.findInactiveUserById(userId);
    }
    
    // === 기본 사용자 관리 메서드들 ===
    
    public boolean registerUser(UserVO user) throws Exception {
        if (userDAO.checkDuplicateUserIdActive(user.getUserId()) > 0) {
            throw new Exception("이미 사용중인 아이디입니다.");
        }
        if (isEmailTaken(user.getEmail())) {
            throw new Exception("이미 사용중인 이메일입니다.");
        }
        if (isPhoneTaken(user.getPhone())) {
            throw new Exception("이미 사용중인 전화번호입니다.");
        }
        
        String encryptedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encryptedPassword);
        
        if (user.getProfileImage() == null || user.getProfileImage().trim().isEmpty()) {
            user.setProfileImage("avatar1.png");
        }
        if (user.getAccountType() == null) {
            user.setAccountType("REGULAR");
        }
>>>>>>> b65c320 (Initial commit)
        
        return userDAO.insertUser(user) > 0;
    }
    
<<<<<<< HEAD
    // === 로그인 ===
    public UserVO login(String userId, String password, HttpSession session) throws Exception {
        UserVO user = userDAO.selectByUserId(userId);
        
        if (user == null) {
            throw new Exception("존재하지 않는 아이디입니다.");
=======
    public UserVO login(String userId, String password, HttpSession session) throws Exception {
        System.out.println("=== UserService.login 메소드 시작 ===");
        System.out.println("요청된 userId: " + userId);
        
        UserVO user = userDAO.selectByUserId(userId);
        
        System.out.println("=== DB 조회 결과 ===");
        System.out.println("user 객체: " + user);
        if (user != null) {
            System.out.println("userNum: " + user.getUserNum());
            System.out.println("userId: " + user.getUserId());
            System.out.println("username: " + user.getUsername());
            System.out.println("userRole: " + user.getUserRole());
            System.out.println("accountType: " + user.getAccountType());
            System.out.println("status: " + user.getStatus());
        } else {
            System.out.println("user가 null입니다!");
            throw new Exception("존재하지 않는 사용자입니다.");
>>>>>>> b65c320 (Initial commit)
        }
        
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new Exception("비밀번호가 올바르지 않습니다.");
        }
        
        if (!"ACTIVE".equals(user.getStatus())) {
            throw new Exception("비활성화된 계정입니다.");
        }
        
<<<<<<< HEAD
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
=======
        System.out.println("=== setUserSession 호출 전 ===");
        System.out.println("user.getUserRole() 값: " + user.getUserRole());
        
        setUserSession(user, session);
        
        System.out.println("=== login 메소드 종료 ===");
        return user;
    }
    
>>>>>>> b65c320 (Initial commit)
    public void logout(HttpSession session) {
        session.invalidate();
    }
    
    // === 중복 체크 ===
<<<<<<< HEAD
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
=======
    
    public boolean isUserIdAvailable(String userId) {
        return userDAO.checkDuplicateUserIdActive(userId) == 0;
    }
    
    public boolean isEmailAvailable(String email) {
        return !isEmailTaken(email);
    }
    
    public boolean isPhoneAvailable(String phone) {
        return !isPhoneTaken(phone);
    }
    
    private boolean isEmailTaken(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return userDAO.checkDuplicateEmailActive(email) > 0;
    }
    
    private boolean isPhoneTaken(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        return userDAO.checkDuplicatePhoneActive(phone) > 0;
    }
    
    // === 사용자 정보 관리 ===
    
>>>>>>> b65c320 (Initial commit)
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
    
<<<<<<< HEAD
    // === 아이디/패스워드 찾기 ===
    public String findUserId(String email, String phone) {
        return userDAO.findUserIdByEmailAndPhone(email, phone);
    }
    
=======
>>>>>>> b65c320 (Initial commit)
    public boolean resetPassword(String userId, String email, String newPassword) throws Exception {
        Long userNum = userDAO.findUserNumForPasswordReset(userId, email);
        if (userNum == null) {
            throw new Exception("사용자 정보가 일치하지 않습니다.");
        }
        
        String encryptedPassword = passwordEncoder.encode(newPassword);
<<<<<<< HEAD
        return userDAO.updatePassword(userNum, encryptedPassword) > 0;
=======
        boolean success = userDAO.updatePassword(userNum, encryptedPassword) > 0;
        
        if (success) {
            sendPasswordResetCompleteEmail(email, userId);
        }
        
        return success;
    }
    
    // === 소셜 로그인 관리 ===
    
    public UserVO getUserBySocialId(String provider, String socialUserId) {
        try {
            log.info("소셜 ID로 사용자 조회: provider={}, socialId={}", provider, socialUserId);
            
            if (provider == null || socialUserId == null) {
                log.warn("소셜 ID 조회 파라미터가 null입니다: provider={}, socialId={}", provider, socialUserId);
                return null;
            }
            
            // 1차: 소셜 테이블 기반 조회 (INACTIVE 포함)
            UserVO user = userDAO.selectUserBySocialIdIncludeInactive(provider.toUpperCase(), socialUserId);
            
            if (user != null) {
                log.info("소셜 ID로 사용자 발견 (소셜 테이블): userId={}, status={}, accountType={}", 
                         user.getUserId(), user.getStatus(), user.getAccountType());
                return user;
            }
            
            log.info("소셜 테이블에서 찾지 못함. 이메일 기반 재활성화 계정 조회 시도");
            
            // 2차: 이메일 기반 재활성화 가능 계정 조회는 이메일이 있을 때만
            // 카카오처럼 이메일이 없는 경우는 건너뜀
            
            // 3차: 소셜 ID 기반 계정 히스토리 조회 (새로 추가!)
            // 이전에 같은 소셜 ID로 가입했던 계정이 있는지 확인
            log.info("소셜 ID 기반 계정 히스토리 조회 시도: provider={}, socialId={}", provider, socialUserId);
            
            UserVO historicalUser = findUserBySocialIdHistory(provider, socialUserId);
            if (historicalUser != null) {
                log.info("소셜 ID 히스토리에서 재활성화 가능 계정 발견: userId={}, status={}", 
                         historicalUser.getUserId(), historicalUser.getStatus());
                return historicalUser;
            }
            
            log.info("소셜 ID로 사용자를 찾을 수 없음: provider={}, socialId={}", provider, socialUserId);
            return null;
            
        } catch (Exception e) {
            log.error("소셜 ID로 사용자 조회 실패: provider={}, socialId={}, error={}", 
                      provider, socialUserId, e.getMessage(), e);
            return null;
        }
    }

    /**
     * 소셜 ID 기반 계정 히스토리 조회 (탈퇴 시 소셜 연동이 삭제된 경우 대비)
     */
    private UserVO findUserBySocialIdHistory(String provider, String socialUserId) {
        try {
            // 방법 1: 소셜 계정으로 만들어진 user_id 패턴으로 검색
            // 예: "kakao_4456315521_12345" 형태의 user_id 검색
            String userIdPattern = provider.toLowerCase() + "_" + socialUserId + "%";
            UserVO patternUser = userDAO.findUserByIdPattern(userIdPattern);
            
            if (patternUser != null && "INACTIVE".equals(patternUser.getStatus())) {
                log.info("소셜 ID 패턴으로 재활성화 계정 발견: {}", patternUser.getUserId());
                patternUser.setStatusMessage("FOUND_BY_SOCIAL_ID_PATTERN");
                return patternUser;
            }
            
            // 방법 2: 다른 히스토리 검색 로직 추가 가능
            
            return null;
            
        } catch (Exception e) {
            log.error("소셜 ID 히스토리 조회 실패: provider={}, socialId={}", provider, socialUserId, e);
            return null;
        }
    }

    /**
     * 재활성화 목적으로 소셜 사용자 정보 획득
     */
    private SocialUserVO getSocialUserInfoForReactivation(String provider, String socialUserId) {
        try {
            // 임시 SocialUserVO 생성 (이메일 조회용)
            SocialUserVO tempSocialUser = new SocialUserVO();
            tempSocialUser.setProvider(provider);
            tempSocialUser.setSocialUserId(socialUserId);
            
            // 실제 소셜 API 호출은 OAuthService를 통해 진행
            // 여기서는 세션에서 pendingSocialUser가 있는지 확인
            return tempSocialUser;
        } catch (Exception e) {
            log.error("재활성화용 소셜 정보 조회 실패: {}", e.getMessage());
            return null;
        }
    }

    
    public UserVO getUserByEmail(String email) {
        return userDAO.selectByEmailIncludeInactive(email);
    }
    
    public UserVO getUserByUserNum(Long userNum) {
        return userDAO.selectByUserNum(userNum);
    }
    
    public void setUserSession(UserVO user, HttpSession session) {
        System.out.println("=== setUserSession 메소드 시작 ===");
        System.out.println("전달받은 user.getUserRole(): " + user.getUserRole());
        
        if (user.getUserNum() != null) {
            session.setAttribute("userNum", user.getUserNum());
            System.out.println("userNum 세션 저장: " + user.getUserNum());
        }
        if (user.getUserId() != null) {
            session.setAttribute("userId", user.getUserId());
            System.out.println("userId 세션 저장: " + user.getUserId());
        }
        if (user.getUsername() != null) {
            session.setAttribute("username", user.getUsername());
            System.out.println("username 세션 저장: " + user.getUsername());
        }
        
        if (user.getUserRole() != null) {
            session.setAttribute("userRole", user.getUserRole());
            System.out.println("userRole 세션 저장: " + user.getUserRole());
        } else {
            System.out.println("userRole이 null이어서 세션에 저장하지 않음");
        }

        session.setAttribute("userInfo", user);
        System.out.println("=== setUserSession 메소드 종료 ===");
    }
    
    public List<SocialUserVO> getUserSocialAccounts(Long userNum) {
        try {
            return userDAO.selectSocialAccountsByUserNum(userNum);
        } catch (Exception e) {
            log.error("소셜 계정 목록 조회 실패: userNum={}", userNum, e);
            return new ArrayList<>();
        }
    }
    
    public SocialUserVO getSocialAccount(Long userNum, String provider) {
        try {
            List<SocialUserVO> accounts = getUserSocialAccounts(userNum);
            return accounts.stream()
                    .filter(account -> provider.equalsIgnoreCase(account.getProvider()))
                    .findFirst()
                    .orElse(null);
        } catch (Exception e) {
            log.error("소셜 계정 조회 실패: userNum={}, provider={}", userNum, provider, e);
            return null;
        }
    }    
    
    public boolean reactivateUser(Long userNum) {
        try {
            int result = userDAO.reactivateUser(userNum);
            if (result > 0) {
                log.info("계정 재활성화 성공: userNum={}", userNum);
                return true;
            }
            return false;
        } catch (Exception e) {
            log.error("계정 재활성화 실패: userNum={}", userNum, e);
            return false;
        }
    }
    
    public Map<String, Boolean> checkSocialLoginAvailable() {
        Map<String, Boolean> available = new HashMap<>();
        available.put("naver", true);
        available.put("kakao", true);
        available.put("google", true);
        return available;
    }
    
    // === 계정 유형 관리 ===
    
    public boolean isSocialUser(Long userNum) {
        try {
            UserVO user = userDAO.selectByUserNum(userNum);
            return user != null && "SOCIAL".equals(user.getAccountType());
        } catch (Exception e) {
            log.error("소셜 계정 확인 중 오류: userNum={}", userNum, e);
            return false;
        }
    }
    
    // === 아이디/비밀번호 찾기 ===
    
    public String findUserId(String email, String phone) {
        String userId = userDAO.findUserIdByEmailAndPhone(email, phone);
        
        if (userId != null) {
            try {
                sendUserIdFoundEmail(email, userId);
            } catch (Exception e) {
                log.error("아이디 찾기 결과 이메일 발송 실패: {}", e.getMessage());
            }
        }
        
        return userId;
    }
    
    public Long findUserNumForPasswordReset(String userId, String email) {
        return userDAO.findUserNumForPasswordReset(userId, email);
    }
    
    public boolean resetPasswordByUserId(String userId, String newPassword) throws Exception {
        UserVO user = userDAO.selectByUserId(userId);
        if (user == null) {
            throw new Exception("존재하지 않는 사용자입니다.");
        }
        
        String encryptedPassword = passwordEncoder.encode(newPassword);
        boolean success = userDAO.updatePassword(user.getUserNum(), encryptedPassword) > 0;
        
        if (success) {
            try {
                sendPasswordResetCompleteEmail(user.getEmail(), userId);
            } catch (Exception e) {
                log.error("비밀번호 재설정 완료 이메일 발송 실패: {}", e.getMessage());
            }
        }
        
        return success;
    }
    
    public boolean checkUserExists(String userId) {
        UserVO user = userDAO.selectByUserId(userId);
        return user != null;
    }
    
    public String findUserIdByEmail(String email) {
        String userId = userDAO.findUserIdByEmail(email);
        
        if (userId != null) {
            try {
                sendUserIdFoundEmail(email, userId);
            } catch (Exception e) {
                log.error("아이디 찾기 결과 이메일 발송 실패: {}", e.getMessage());
            }
        }
        
        return userId;
    }

    public String findUserIdByPhone(String phone) {
        return userDAO.findUserIdByPhone(phone);
    }
    
    // === SMS/이메일 인증 ===
    
    public boolean sendSMSAuthCode(String phone) {
        try {
            String authCode = String.format("%06d", new Random().nextInt(1000000));
            
            Message message = new Message();
            message.setFrom(fromNumber);
            message.setTo(phone);
            message.setText("[헬킹] 인증번호는 [" + authCode + "]입니다. 3분 내에 입력해주세요.");
            
            log.info("SMS 발송 시도 - From: {}, To: {}, Code: {}", fromNumber, phone, authCode);
            
            SingleMessageSentResponse response = messageService.sendOne(new SingleMessageSendingRequest(message));
            
            log.info("CoolSMS 응답 - StatusCode: {}, StatusMessage: {}", 
                     response.getStatusCode(), response.getStatusMessage());
            
            if ("2000".equals(response.getStatusCode())) {
                smsAuthCodes.put(phone, authCode);
                smsAuthTimes.put(phone, System.currentTimeMillis());
                
                log.info("SMS 인증 코드 발송 완료: {}", phone);
                return true;
            } else {
                log.error("SMS 발송 실패: {} - {}", response.getStatusCode(), response.getStatusMessage());
                return false;
            }
            
        } catch (Exception e) {
            log.error("SMS 발송 중 예외 발생: {}", e.getMessage(), e);
            return false;
        }
    }
    
    public boolean verifySMSAuthCode(String phone, String code) {
        try {
            String storedCode = smsAuthCodes.get(phone);
            Long sentTime = smsAuthTimes.get(phone);
            
            if (storedCode == null || sentTime == null) {
                log.warn("SMS 인증: 저장된 코드가 없음 - {}", phone);
                return false;
            }
            
            if (System.currentTimeMillis() - sentTime > 180000) {
                smsAuthCodes.remove(phone);
                smsAuthTimes.remove(phone);
                log.warn("SMS 인증: 시간 만료 - {}", phone);
                return false;
            }
            
            if (storedCode.equals(code)) {
                smsAuthCodes.remove(phone);
                smsAuthTimes.remove(phone);
                log.info("SMS 인증 성공: {}", phone);
                return true;
            } else {
                log.warn("SMS 인증: 코드 불일치 - {} (입력: {}, 저장: {})", phone, code, storedCode);
                return false;
            }
            
        } catch (Exception e) {
            log.error("SMS 인증 확인 중 예외: {}", e.getMessage(), e);
            return false;
        }
    }
    
    public boolean sendEmailAuthCode(String email) {
        try {
            String authCode = String.format("%06d", new Random().nextInt(1000000));
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setFrom("ceskalee@gmail.com", "헬킹 피트니스");
            helper.setTo(email);
            helper.setSubject("[헬킹] 이메일 인증번호");
            
            String content = buildAuthEmailContent(authCode);
            helper.setText(content, true);
            
            mailSender.send(message);
            
            emailAuthCodes.put(email, authCode);
            emailAuthTimes.put(email, System.currentTimeMillis());
            
            log.info("이메일 인증 코드 발송 완료: {}", email);
            return true;
            
        } catch (Exception e) {
            log.error("이메일 발송 실패: {}", e.getMessage());
            return false;
        }
    }
    
    public boolean verifyEmailAuthCode(String email, String code) {
        String storedCode = emailAuthCodes.get(email);
        Long sentTime = emailAuthTimes.get(email);
        
        if (storedCode == null || sentTime == null) {
            return false;
        }
        
        if (System.currentTimeMillis() - sentTime > 300000) {
            emailAuthCodes.remove(email);
            emailAuthTimes.remove(email);
            return false;
        }
        
        if (storedCode.equals(code)) {
            emailAuthCodes.remove(email);
            emailAuthTimes.remove(email);
            return true;
        }
        
        return false;
    }
    
    // === 이메일 발송 메서드들 ===
    
    private void sendUserIdFoundEmail(String email, String userId) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setFrom("ceskalee@gmail.com", "헬킹 피트니스");
            helper.setTo(email);
            helper.setSubject("[헬킹] 아이디 찾기 결과");
            
            String content = buildUserIdEmailContent(userId);
            helper.setText(content, true);
            
            mailSender.send(message);
            log.info("아이디 찾기 결과 이메일 발송 완료: {}", email);
            
        } catch (Exception e) {
            log.error("아이디 찾기 이메일 발송 오류: ", e);
            throw new RuntimeException("이메일 발송에 실패했습니다", e);
        }
    }
    
    private void sendPasswordResetCompleteEmail(String email, String userId) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setFrom("ceskalee@gmail.com", "헬킹 피트니스");
            helper.setTo(email);
            helper.setSubject("[헬킹] 비밀번호 재설정 완료");
            
            String content = buildPasswordResetEmailContent(userId);
            helper.setText(content, true);
            
            mailSender.send(message);
            log.info("비밀번호 재설정 완료 이메일 발송: {}", email);
            
        } catch (Exception e) {
            log.error("비밀번호 재설정 이메일 발송 오류: ", e);
            throw new RuntimeException("이메일 발송에 실패했습니다", e);
        }
    }
    
    private String buildAuthEmailContent(String authCode) {
        StringBuilder content = new StringBuilder();
        content.append("<div style='max-width: 600px; margin: 0 auto; font-family: Arial, sans-serif;'>");
        content.append("<div style='background: linear-gradient(135deg, #FF6A00, #ff8533); padding: 30px; text-align: center;'>");
        content.append("<h1 style='color: white; margin: 0; font-size: 24px;'>헬킹 피트니스</h1>");
        content.append("<p style='color: white; margin: 10px 0 0; font-size: 14px;'>전국 어디서나 자유롭게</p>");
        content.append("</div>");
        content.append("<div style='background: white; padding: 40px; border: 1px solid #E7E0D6;'>");
        content.append("<h2 style='color: #0F172A; text-align: center; margin-bottom: 30px;'>이메일 인증번호</h2>");
        content.append("<div style='background: #F4ECDC; padding: 20px; border-radius: 12px; text-align: center; margin: 30px 0;'>");
        content.append("<p style='color: #5B6170; margin-bottom: 10px; font-size: 14px;'>인증번호를 입력해주세요</p>");
        content.append("<h1 style='color: #FF6A00; font-size: 32px; font-weight: bold; margin: 0; letter-spacing: 8px;'>");
        content.append(authCode);
        content.append("</h1>");
        content.append("</div>");
        content.append("<p style='color: #5B6170; text-align: center; line-height: 1.6;'>");
        content.append("위 인증번호는 <strong>5분간</strong> 유효합니다.<br>");
        content.append("본인이 요청하지 않았다면 이 이메일을 무시해주세요.");
        content.append("</p>");
        content.append("</div>");
        content.append("<div style='background: #0F172A; padding: 20px; text-align: center;'>");
        content.append("<p style='color: #5B6170; margin: 0; font-size: 12px;'>");
        content.append("© 2024 HELLKING FITNESS. All rights reserved.");
        content.append("</p>");
        content.append("</div>");
        content.append("</div>");
        
        return content.toString();
    }
    
    private String buildUserIdEmailContent(String userId) {
        StringBuilder content = new StringBuilder();
        content.append("<div style='max-width: 600px; margin: 0 auto; font-family: Arial, sans-serif;'>");
        content.append("<div style='background: linear-gradient(135deg, #FF6A00, #ff8533); padding: 30px; text-align: center;'>");
        content.append("<h1 style='color: white; margin: 0; font-size: 24px;'>헬킹 피트니스</h1>");
        content.append("<p style='color: white; margin: 10px 0 0; font-size: 14px;'>전국 어디서나 자유롭게</p>");
        content.append("</div>");
        content.append("<div style='background: white; padding: 40px; border: 1px solid #E7E0D6;'>");
        content.append("<h2 style='color: #0F172A; text-align: center; margin-bottom: 30px;'>아이디 찾기 결과</h2>");
        content.append("<div style='background: #F4ECDC; padding: 20px; border-radius: 12px; text-align: center; margin: 30px 0;'>");
        content.append("<p style='color: #5B6170; margin-bottom: 10px; font-size: 14px;'>고객님의 아이디는</p>");
        content.append("<h2 style='color: #FF6A00; font-size: 24px; font-weight: bold; margin: 0;'>");
        content.append(userId);
        content.append("</h2>");
        content.append("<p style='color: #5B6170; margin-top: 10px; font-size: 14px;'>입니다.</p>");
        content.append("</div>");
        content.append("</div>");
        content.append("</div>");
        
        return content.toString();
    }
    
    private String buildPasswordResetEmailContent(String userId) {
        StringBuilder content = new StringBuilder();
        content.append("<div style='max-width: 600px; margin: 0 auto; font-family: Arial, sans-serif;'>");
        content.append("<div style='background: linear-gradient(135deg, #FF6A00, #ff8533); padding: 30px; text-align: center;'>");
        content.append("<h1 style='color: white; margin: 0; font-size: 24px;'>헬킹 피트니스</h1>");
        content.append("</div>");
        content.append("<div style='background: white; padding: 40px; border: 1px solid #E7E0D6;'>");
        content.append("<h2 style='color: #0F172A; text-align: center; margin-bottom: 30px;'>비밀번호 재설정 완료</h2>");
        content.append("<p style='text-align: center;'>아이디 " + userId + "의 비밀번호가 성공적으로 변경되었습니다.</p>");
        content.append("</div>");
        content.append("</div>");
        
        return content.toString();
    }
    
    // === 소셜 로그인 관련 추가 메서드들 ===
    
    @Transactional(rollbackFor = Exception.class)
    public UserVO createSocialUser(SocialUserVO socialUser) throws Exception {
        try {
            log.info("소셜 계정 생성 시작: provider={}, socialId={}, email={}", 
                     socialUser.getProvider(), socialUser.getSocialUserId(), socialUser.getSocialEmail());
            
            UserVO existingSocialUser = userDAO.selectUserBySocialIdIncludeInactive(
                socialUser.getProvider().toUpperCase(), socialUser.getSocialUserId());
            
            if (existingSocialUser != null) {
                if (!"ACTIVE".equals(existingSocialUser.getStatus())) {
                    reactivateUser(existingSocialUser.getUserNum());
                    existingSocialUser.setStatus("ACTIVE");
                    existingSocialUser.setStatusMessage("REACTIVATED");
                }
                return existingSocialUser;
            }
            
            if (socialUser.hasValidEmail()) {
                UserVO existingEmailUser = userDAO.selectByEmailIncludeInactive(socialUser.getSocialEmail());
                
                if (existingEmailUser != null) {
                    socialUser.setUserNum(existingEmailUser.getUserNum());
                    if (linkSocialAccount(socialUser)) {
                        if (!"ACTIVE".equals(existingEmailUser.getStatus())) {
                            reactivateUser(existingEmailUser.getUserNum());
                            existingEmailUser.setStatus("ACTIVE");
                            existingEmailUser.setStatusMessage("REACTIVATED_AND_LINKED");
                        } else {
                            existingEmailUser.setStatusMessage("LINKED");
                        }
                        return existingEmailUser;
                    }
                }
            }
            
            UserVO newUser = createNewSocialUserSafely(socialUser);
            newUser.setStatusMessage("NEW_CREATED");
            return newUser;
            
        } catch (Exception e) {
            log.error("소셜 계정 생성 실패: provider={}, error={}", socialUser.getProvider(), e.getMessage(), e);
            throw e;
        }
    }

    @Transactional(rollbackFor = Exception.class)
    private UserVO createNewSocialUserSafely(SocialUserVO socialUser) throws Exception {
        UserVO newUser = new UserVO();
        
        String uniqueUserId = generateUniqueUserId(socialUser.getProvider(), socialUser.getSocialUserId());
        newUser.setUserId(uniqueUserId);
        
        if (socialUser.getSocialName() != null && !socialUser.getSocialName().trim().isEmpty()) {
            newUser.setUsername(socialUser.getSocialName());
        } else {
            newUser.setUsername("소셜사용자" + System.currentTimeMillis() % 10000);
        }
        
        if (socialUser.hasValidEmail()) {
            if (userDAO.checkDuplicateEmailActive(socialUser.getSocialEmail()) > 0) {
                log.warn("이미 사용 중인 이메일: {}", socialUser.getSocialEmail());
                newUser.setEmail(null);
            } else {
                newUser.setEmail(socialUser.getSocialEmail());
                log.info("유효한 소셜 이메일 저장: {}", socialUser.getSocialEmail());
            }
        } else {
            newUser.setEmail(null);
            log.info("소셜 계정에 유효한 이메일이 없어 NULL로 설정: provider={}", socialUser.getProvider());
        }
        
        newUser.setPhone(null);
        newUser.setPassword("SOCIAL_ONLY_" + socialUser.getProvider().toUpperCase());
        
        if (socialUser.hasProfileImage()) {
            newUser.setProfileImage(socialUser.getSocialProfileImage());
        } else {
            newUser.setProfileImage("avatar1.png");
        }
        
        newUser.setStatus("ACTIVE");
        newUser.setAccountType("SOCIAL");
        
        int maxRetries = 3;
        for (int i = 0; i < maxRetries; i++) {
            try {
                int userResult = userDAO.insertSocialOnlyUser(newUser);
                if (userResult <= 0) {
                    throw new Exception("소셜 사용자 등록에 실패했습니다.");
                }
                
                socialUser.setUserNum(newUser.getUserNum());
                int socialResult = userDAO.insertSocialUser(socialUser);
                if (socialResult <= 0) {
                    throw new Exception("소셜 계정 정보 등록에 실패했습니다.");
                }
                
                log.info("새 소셜 계정 생성 완료: userId={}, userNum={}, provider={}, email={}", 
                         newUser.getUserId(), newUser.getUserNum(), socialUser.getProvider(), newUser.getEmail());
                
                return newUser;
                
            } catch (Exception e) {
                if (i == maxRetries - 1) {
                    throw e;
                }
                
                if (e.getMessage().contains("무결성") || e.getMessage().contains("duplicate") || 
                    e.getMessage().contains("unique") || e.getMessage().contains("ORA-00001")) {
                    log.warn("중복 오류 발생, 새 ID 생성 후 재시도: attempt={}/{}", i + 1, maxRetries);
                    uniqueUserId = generateUniqueUserId(socialUser.getProvider(), socialUser.getSocialUserId());
                    newUser.setUserId(uniqueUserId);
                    
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException ie) {
                        Thread.currentThread().interrupt();
                    }
                } else {
                    throw e;
                }
            }
        }
        
        throw new Exception("소셜 계정 생성에 " + maxRetries + "회 시도 후 실패했습니다.");
    }

    @Transactional(rollbackFor = Exception.class)
    public boolean linkSocialAccount(SocialUserVO socialUser) {
        try {
            SocialUserVO existing = getSocialAccount(socialUser.getUserNum(), socialUser.getProvider());
            if (existing != null) {
                log.warn("이미 연동된 소셜 계정: userNum={}, provider={}", socialUser.getUserNum(), socialUser.getProvider());
                return false;
            }
            
            int result = userDAO.insertSocialUser(socialUser);
            if (result > 0) {
                log.info("소셜 계정 연결 성공: userNum={}, provider={}", socialUser.getUserNum(), socialUser.getProvider());
                return true;
            }
            return false;
        } catch (Exception e) {
            if (e.getMessage().contains("무결성") || e.getMessage().contains("duplicate") || 
                e.getMessage().contains("unique") || e.getMessage().contains("ORA-00001")) {
                log.warn("소셜 계정 중복 연결 시도: userNum={}, provider={}", socialUser.getUserNum(), socialUser.getProvider());
                return false;
            }
            
            log.error("소셜 계정 연결 실패: {}", e.getMessage(), e);
            throw new RuntimeException("소셜 계정 연결 중 오류가 발생했습니다.", e);
        }
    }
    
    private String generateUniqueUserId(String provider, String socialUserId) {
        String baseId = provider.toLowerCase() + "_" + 
                       socialUserId.substring(0, Math.min(8, socialUserId.length())) + "_" +
                       System.currentTimeMillis() % 100000;
        
        if (baseId.length() > 45) {
            baseId = baseId.substring(0, 45);
        }
        
        String uniqueId = baseId;
        int counter = 1;
        
        while (userDAO.checkDuplicateUserId(uniqueId) > 0) {
            uniqueId = baseId + "_" + counter;
            counter++;
            
            if (counter > 1000) {
                uniqueId = provider.toLowerCase() + "_" + UUID.randomUUID().toString().substring(0, 8);
                break;
            }
        }
        
        log.info("고유 user_id 생성: {}", uniqueId);
        return uniqueId;
    }

    @Transactional(rollbackFor = Exception.class)
    public boolean unlinkSocialAccount(Long userNum, String provider, HttpSession session) {
        try {
            String currentProvider = getCurrentSocialProvider(session);
            if (provider.equalsIgnoreCase(currentProvider)) {
                log.warn("현재 로그인한 소셜 계정은 연동 해제할 수 없습니다: provider={}", provider);
                throw new RuntimeException("현재 로그인한 " + provider + " 계정은 연동 해제할 수 없습니다.");
            }
            
            boolean isSocialUser = isSocialUser(userNum);
            if (isSocialUser) {
                List<SocialUserVO> socialAccounts = getUserSocialAccounts(userNum);
                if (socialAccounts.size() <= 1) {
                    throw new RuntimeException("소셜 전용 계정은 마지막 소셜 계정을 해제할 수 없습니다.");
                }
            }
            
            int result = userDAO.deleteSocialUser(userNum, provider);
            if (result > 0) {
                log.info("소셜 계정 연동 해제 성공: userNum={}, provider={}", userNum, provider);
                return true;
            }
            return false;
        } catch (Exception e) {
            log.error("소셜 계정 연동 해제 실패: {}", e.getMessage(), e);
            throw new RuntimeException(e.getMessage());
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public boolean withdrawSocialUser(Long userNum) throws Exception {
        UserVO user = userDAO.selectByUserNum(userNum);
        if (user == null) {
            throw new Exception("존재하지 않는 사용자입니다.");
        }
        
        if (!isSocialUser(userNum)) {
            throw new Exception("일반 계정은 비밀번호 확인이 필요합니다.");
        }
        
        try {
            List<SocialUserVO> socialAccounts = userDAO.selectSocialAccountsByUserNum(userNum);
            for (SocialUserVO social : socialAccounts) {
                userDAO.deleteSocialUser(userNum, social.getProvider());
                log.info("소셜 계정 연동 해제: userNum={}, provider={}", userNum, social.getProvider());
            }
            
            boolean result = userDAO.deactivateUser(userNum) > 0;
            
            if (result) {
                log.info("소셜 전용 계정 탈퇴 완료: userNum={}, userId={}", userNum, user.getUserId());
            }
            
            return result;
            
        } catch (Exception e) {
            log.error("소셜 전용 계정 탈퇴 실패: userNum={}", userNum, e);
            throw e;
        }
    }
    
    // === 팀원 버전 호환 메서드들 ===
    
    public UserVO getUserById(String user_id) throws Exception {
        return userDAO.getUserById(user_id);
    }
    
    public void updateVisteDate(String user_id) throws Exception {
        userDAO.updateVistDate(user_id);
    }
    
    public void deleteYN(UserVO vo) throws Exception {
        userDAO.deleteYN(vo);
    }
    
    public boolean reactivateUserByEmail(String email) {
        UserVO inactiveUser = userDAO.selectByEmailIncludeInactive(email);
        if (inactiveUser != null && "INACTIVE".equals(inactiveUser.getStatus())) {
            return userDAO.reactivateUser(inactiveUser.getUserNum()) > 0;
        }
        return false;
    }
    
    public UserVO authenticate(String userId, String password) {
        try {
            UserVO user = userDAO.selectByUserId(userId);
            
            if (user != null && passwordEncoder.matches(password, user.getPassword())) {
                userDAO.updateVistDate(user.getUserId());
                return user;
            }
            
            return null;
            
        } catch (Exception e) {
            log.error("모바일 인증 중 오류 발생: {}", e.getMessage());
            return null;
        }
>>>>>>> b65c320 (Initial commit)
    }
}