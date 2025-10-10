package net.koreate.hellking.user.controller;

<<<<<<< HEAD
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.multipart.MultipartFile;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.user.vo.UserVO;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user/")
=======
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.common.utils.FileUtils;
import net.koreate.hellking.pass.service.PassService;
import net.koreate.hellking.pass.vo.UserPassVO;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.user.vo.SocialUserVO;
import net.koreate.hellking.user.vo.UserVO;

/**
 * 통합 UserController - 탈퇴 재가입 시스템 포함
 */
@Controller
@RequestMapping("/user/")
@Slf4j
>>>>>>> b65c320 (Initial commit)
public class UserController {
    
    @Autowired
    private UserService userService;
    
<<<<<<< HEAD
    // === ë¡œê·¸ì¸ ê´€ë ¨ ===
    @GetMapping("login")
    public String login() {
        return "user/login";
    }
    
    @PostMapping("login")
    public String loginPost(String userId, String password, HttpSession session,
                           RedirectAttributes rttr) {
        try {
            UserVO user = userService.login(userId, password, session);
            return "redirect:/";
        } catch (Exception e) {
=======
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    
    // === 로그인 관련 ===
    
    @GetMapping("login")
    public String login(Model model, HttpSession session) {
        // 세션에서 socialChoiceData 확인하여 모델에 전달
        Object socialChoiceData = session.getAttribute("socialChoiceData");
        if (socialChoiceData != null) {
            model.addAttribute("socialChoiceData", socialChoiceData);
            log.info("로그인 페이지에 socialChoiceData 전달 완료: {}", socialChoiceData);
        }
        
        // 성공 메시지가 있으면 전달
        String successMessage = (String) session.getAttribute("successMessage");
        if (successMessage != null) {
            model.addAttribute("message", successMessage);
            session.removeAttribute("successMessage");
            log.info("성공 메시지 전달: {}", successMessage);
        }
        
        return "user/login";
    }
        
    @Autowired
    private PassService passService;
    
    /**
     * 통합 로그인 처리 (두 버전 모두 호환)
     */
    @PostMapping("login")
    public String loginPost(String userId, String user_id, String password, 
                           HttpSession session, RedirectAttributes rttr) {
        try {
            String loginId = userId != null ? userId : user_id;
            UserVO user = userService.login(loginId, password, session);

            System.out.println("=== 로그인 직후 디버깅 ===");
            System.out.println("user 객체: " + user);
            System.out.println("user.getUserRole(): " + user.getUserRole());
            System.out.println("user.getUserNum(): " + user.getUserNum());

            // 강제로 세션에 저장
            if (user.getUserRole() == null) {
                System.out.println("userRole이 null이므로 강제로 ADMIN 설정");
                if (user.getUserNum() != null && user.getUserNum().equals(1L)) {
                    session.setAttribute("userRole", "ADMIN");
                }
            } else {
                session.setAttribute("userRole", user.getUserRole());
            };
            
            log.info("로그인 성공: {} ({}), Role: {}", user.getUsername(), user.getUserId(), user.getUserRole());
            return "redirect:/";
        } catch (Exception e) {
            log.error("로그인 실패: {}", e.getMessage());
>>>>>>> b65c320 (Initial commit)
            rttr.addFlashAttribute("message", e.getMessage());
            return "redirect:/user/login";
        }
    }
    
    @GetMapping("logout")
    public String logout(HttpSession session) {
        userService.logout(session);
<<<<<<< HEAD
        return "redirect:/";
    }
    
    // === íšŒì›ê°€ìž… ê´€ë ¨ ===
=======
        log.info("로그아웃 완료");
        return "redirect:/";
    }
    
    // === 회원가입 관련 ===
    
>>>>>>> b65c320 (Initial commit)
    @GetMapping("join")
    public String join() {
        return "user/join";
    }
    
<<<<<<< HEAD
    @PostMapping("joinPost")
    public String joinPost(UserVO user, RedirectAttributes rttr) {
        try {
            userService.registerUser(user);
            rttr.addFlashAttribute("message", "íšŒì›ê°€ìž…ì´ ì™„ë£Œë˜ì—ˆìŠµë‹ˆë‹¤.");
            return "redirect:/user/login";
        } catch (Exception e) {
=======
    /**
     * 수정된 회원가입 처리 메서드 - 재활성화 시스템 포함
     */
    @PostMapping("joinPost")
    public String joinPost(UserVO user, 
                          @RequestParam(value = "profileImageFile", required = false) MultipartFile profileImageFile, 
                          RedirectAttributes rttr) {
        try {
            log.info("회원가입/재가입 시도: {}", user.getUserId());
            log.info("프로필 이미지 파일 정보: {}", profileImageFile != null ? profileImageFile.getOriginalFilename() : "없음");
            
            String result;
            
            // 프로필 이미지가 있는 경우와 없는 경우 모두 동일한 메서드로 처리
            result = userService.userJoin(user, profileImageFile);
            
            // 결과에 따른 메시지 처리
            if ("SUCCESS".equals(result)) {
                rttr.addFlashAttribute("message", "회원가입이 완료되었습니다.");
            } else if ("REACTIVATED".equals(result)) {
                rttr.addFlashAttribute("message", "기존 계정이 재활성화되었습니다. 다시 오신 것을 환영합니다!");
            } else {
                throw new Exception("회원가입에 실패했습니다.");
            }
            
            return "redirect:/user/login";
            
        } catch (Exception e) {
            log.error("회원가입 실패: {}", e.getMessage());
            
            // 에러 메시지 세분화
            String errorMessage = e.getMessage();
            if (errorMessage.contains("이미 사용중인")) {
                rttr.addFlashAttribute("message", "이미 사용중인 정보입니다. 다른 정보로 시도해주세요.");
            } else if (errorMessage.contains("재활성화")) {
                rttr.addFlashAttribute("message", "계정 재활성화 중 오류가 발생했습니다. 관리자에게 문의해주세요.");
            } else if (errorMessage.contains("프로필 이미지")) {
                rttr.addFlashAttribute("message", "프로필 이미지 처리 중 오류가 발생했습니다: " + errorMessage);
            } else {
                rttr.addFlashAttribute("message", "회원가입 중 오류가 발생했습니다: " + errorMessage);
            }
            
            return "redirect:/user/join";
        }
    }
    
    /**
     * 팀원 버전 회원가입 호환
     */
    @PostMapping("joinPostOld")
    public String joinPostOld(UserVO vo, MultipartFile profileImage, RedirectAttributes rttr) {
        try {
            log.info("팀원 버전 회원가입 시도: {}", vo.getUserId());
            String message = userService.userJoin(vo, profileImage);
            rttr.addFlashAttribute("message", "SUCCESS".equals(message) ? "회원가입이 완료되었습니다." : "회원가입에 실패했습니다.");
            return "redirect:/user/login";
        } catch (Exception e) {
            log.error("회원가입 실패: {}", e.getMessage());
>>>>>>> b65c320 (Initial commit)
            rttr.addFlashAttribute("message", e.getMessage());
            return "redirect:/user/join";
        }
    }
    
<<<<<<< HEAD
    // === ë§ˆì´íŽ˜ì´ì§€ ===
=======
    // === 마이페이지 관련 ===
    
>>>>>>> b65c320 (Initial commit)
    @GetMapping("mypage")
    public String mypage(HttpSession session, Model model) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        Long userNum = userService.getCurrentUserNum(session);
<<<<<<< HEAD
        UserVO user = userService.getUserWithActivePass(userNum);
        model.addAttribute("user", user);
        return "user/mypage";
    }
    
=======
        UserVO user = userService.getCurrentUser(session);
        List<UserPassVO> activePasses = passService.getActivePasses(userNum);
        
        // 최근 활동 데이터 추가
        List<UserPassVO> recentPasses = passService.getUserPasses(userNum); // 최근 구매한 패스권들
        // QR 방문 기록도 가져올 수 있다면 추가
        
        model.addAttribute("user", user);
        model.addAttribute("activePasses", activePasses);
        model.addAttribute("recentPasses", recentPasses); // 추가
        
        return "user/mypage";
    }
    
    /**
     * 회원정보 수정 페이지 - 소셜 계정 NULL 값 처리 포함
     */
>>>>>>> b65c320 (Initial commit)
    @GetMapping("edit")
    public String edit(HttpSession session, Model model) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        UserVO user = userService.getCurrentUser(session);
<<<<<<< HEAD
        model.addAttribute("user", user);
        return "user/edit";
    }
    
    @PostMapping("editPost")
    public String editPost(UserVO user, HttpSession session, RedirectAttributes rttr) {
=======
        Long userNum = userService.getCurrentUserNum(session);
        
        // 소셜 계정의 NULL 값을 빈 문자열로 변환하여 UI에 표시
        if (user.getPhone() == null) {
            user.setPhone("");
        }
        if (user.getEmail() == null) {
            user.setEmail("");
        }
        
        List<SocialUserVO> socialAccounts = userService.getUserSocialAccounts(userNum);
        boolean isSocialUser = userService.isSocialUser(userNum);
        
        model.addAttribute("user", user);
        model.addAttribute("socialAccounts", socialAccounts);
        model.addAttribute("isSocialUser", isSocialUser);
        model.addAttribute("hasValidEmail", user.getEmail() != null && !user.getEmail().trim().isEmpty());
        
        return "user/edit";
    }

    @PostMapping("editPost")
    public String editPost(UserVO user, 
                          @RequestParam("profileImageFile") MultipartFile profileImageFile, 
                          HttpSession session, 
                          RedirectAttributes rttr) {
>>>>>>> b65c320 (Initial commit)
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            user.setUserNum(userNum);
            
<<<<<<< HEAD
            userService.updateUser(user);
            rttr.addFlashAttribute("message", "íšŒì›ì •ë³´ê°€ ìˆ˜ì •ë˜ì—ˆìŠµë‹ˆë‹¤.");
            return "redirect:/user/mypage";
        } catch (Exception e) {
            rttr.addFlashAttribute("message", "ìˆ˜ì •ì— ì‹¤íŒ¨í–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
=======
            // 프로필 이미지 처리 로직
            if (profileImageFile != null && !profileImageFile.isEmpty()) {
                try {
                    String uploadPath = session.getServletContext().getRealPath("/") + "upload/";
                    String uploadedFileName = FileUtils.uploadFile(uploadPath, profileImageFile);
                    user.setProfileImage(uploadedFileName);
                    log.info("프로필 이미지 업로드 성공: {}", uploadedFileName);
                    
                } catch (Exception e) {
                    log.error("프로필 이미지 업로드 실패: {}", e.getMessage(), e);
                    rttr.addFlashAttribute("message", "이미지 업로드에 실패했습니다: " + e.getMessage());
                    return "redirect:/user/edit";
                }
            }
            
            // 빈 문자열을 NULL로 변환하여 DB에 저장
            if (user.getEmail() != null && user.getEmail().trim().isEmpty()) {
                user.setEmail(null);
            }
            if (user.getPhone() != null && user.getPhone().trim().isEmpty()) {
                user.setPhone(null);
            }
            
            // 사용자 정보 업데이트 (프로필 이미지 포함)
            userService.updateUser(user);
            
            // 세션 정보 완전 새로고침 - DB에서 최신 데이터 조회
            UserVO updatedUser = userService.getUserByUserNum(userNum);
            session.setAttribute("loginUser", updatedUser);
            
            rttr.addFlashAttribute("message", "회원정보가 수정되었습니다.");
            return "redirect:/user/mypage";
            
        } catch (Exception e) {
            log.error("정보 수정 실패: {}", e.getMessage(), e);
            rttr.addFlashAttribute("message", "수정 중 오류가 발생했습니다: " + e.getMessage());
>>>>>>> b65c320 (Initial commit)
            return "redirect:/user/edit";
        }
    }
    
<<<<<<< HEAD
    // === ë¹„ë°€ë²ˆí˜¸ ë³€ê²½ ===
=======
    // === 비밀번호 변경 ===    

>>>>>>> b65c320 (Initial commit)
    @GetMapping("changePassword")
    public String changePassword(HttpSession session) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        return "user/changePassword";
    }
<<<<<<< HEAD
    
=======

    /**
     * 기존 AJAX용 비밀번호 변경 (JSON 응답)
     */
>>>>>>> b65c320 (Initial commit)
    @PostMapping("changePasswordPost")
    @ResponseBody
    public Map<String, Object> changePasswordPost(String currentPassword, String newPassword, 
                                                 HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            if (!userService.isLoggedIn(session)) {
                result.put("success", false);
<<<<<<< HEAD
                result.put("message", "ë¡œê·¸ì¸ì´ í•„ìš”í•©ë‹ˆë‹¤.");
=======
                result.put("message", "로그인이 필요합니다.");
>>>>>>> b65c320 (Initial commit)
                return result;
            }
            
            Long userNum = userService.getCurrentUserNum(session);
            boolean success = userService.updatePassword(userNum, currentPassword, newPassword);
            
            result.put("success", success);
<<<<<<< HEAD
            result.put("message", success ? "ë¹„ë°€ë²ˆí˜¸ê°€ ë³€ê²½ë˜ì—ˆìŠµë‹ˆë‹¤." : "ë¹„ë°€ë²ˆí˜¸ ë³€ê²½ì— ì‹¤íŒ¨í–ˆìŠµë‹ˆë‹¤.");
=======
            result.put("message", success ? "비밀번호가 변경되었습니다." : "비밀번호 변경에 실패했습니다.");
>>>>>>> b65c320 (Initial commit)
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
<<<<<<< HEAD
    
    // === ì¤‘ë³µ ì²´í¬ API ===
=======

    /**
     * 새로 추가: 폼 제출용 비밀번호 변경 (리다이렉트 응답)
     */
    @PostMapping("changePassword")
    public String changePasswordForm(String currentPassword, String newPassword, 
                                    HttpSession session, RedirectAttributes rttr) {
        try {
            if (!userService.isLoggedIn(session)) {
                return "redirect:/user/login";
            }
            
            // 입력값 검증
            if (currentPassword == null || currentPassword.trim().isEmpty()) {
                throw new Exception("현재 비밀번호를 입력해주세요.");
            }
            
            if (newPassword == null || newPassword.trim().isEmpty()) {
                throw new Exception("새 비밀번호를 입력해주세요.");
            }
            
            // 비밀번호 보안 요구사항 검증
            if (!isPasswordValid(newPassword)) {
                throw new Exception("새 비밀번호는 8자리 이상이며 영문 대소문자, 숫자, 특수문자를 각각 포함해야 합니다.");
            }
            
            Long userNum = userService.getCurrentUserNum(session);
            boolean success = userService.updatePassword(userNum, currentPassword, newPassword);
            
            if (success) {
                log.info("비밀번호 변경 성공: userNum={}", userNum);
                rttr.addFlashAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
                return "redirect:/user/edit";
            } else {
                throw new Exception("비밀번호 변경에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("비밀번호 변경 실패: {}", e.getMessage());
            rttr.addFlashAttribute("message", e.getMessage());
            return "redirect:/user/edit";
        }
    }

    /**
     * 비밀번호 보안 요구사항 검증 헬퍼 메서드
     */
    private boolean isPasswordValid(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }
        
        boolean hasUpper = password.matches(".*[A-Z].*");
        boolean hasLower = password.matches(".*[a-z].*");
        boolean hasDigit = password.matches(".*[0-9].*");
        boolean hasSpecial = password.matches(".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?].*");
        
        return hasUpper && hasLower && hasDigit && hasSpecial;
    }
    
    // === 중복 체크 API ===
    
>>>>>>> b65c320 (Initial commit)
    @GetMapping("checkUserId")
    @ResponseBody
    public Map<String, Object> checkUserId(String userId) {
        Map<String, Object> result = new HashMap<>();
        boolean available = userService.isUserIdAvailable(userId);
        result.put("available", available);
<<<<<<< HEAD
        result.put("message", available ? "ì‚¬ìš© ê°€ëŠ¥í•œ ì•„ì´ë””ìž…ë‹ˆë‹¤." : "ì´ë¯¸ ì‚¬ìš©ì¤‘ì¸ ì•„ì´ë””ìž…ë‹ˆë‹¤.");
=======
        result.put("message", available ? "사용 가능한 아이디입니다." : "이미 사용중인 아이디입니다.");
>>>>>>> b65c320 (Initial commit)
        return result;
    }
    
    @GetMapping("checkEmail")
    @ResponseBody
    public Map<String, Object> checkEmail(String email) {
        Map<String, Object> result = new HashMap<>();
        boolean available = userService.isEmailAvailable(email);
        result.put("available", available);
<<<<<<< HEAD
        result.put("message", available ? "ì‚¬ìš© ê°€ëŠ¥í•œ ì´ë©”ì¼ìž…ë‹ˆë‹¤." : "ì´ë¯¸ ì‚¬ìš©ì¤‘ì¸ ì´ë©”ì¼ìž…ë‹ˆë‹¤.");
=======
        result.put("message", available ? "사용 가능한 이메일입니다." : "이미 사용중인 이메일입니다.");
>>>>>>> b65c320 (Initial commit)
        return result;
    }
    
    @GetMapping("checkPhone")
    @ResponseBody
    public Map<String, Object> checkPhone(String phone) {
        Map<String, Object> result = new HashMap<>();
        boolean available = userService.isPhoneAvailable(phone);
        result.put("available", available);
<<<<<<< HEAD
        result.put("message", available ? "ì‚¬ìš© ê°€ëŠ¥í•œ ì „í™”ë²ˆí˜¸ìž…ë‹ˆë‹¤." : "ì´ë¯¸ ì‚¬ìš©ì¤‘ì¸ ì „í™”ë²ˆí˜¸ìž…ë‹ˆë‹¤.");
        return result;
    }
    
    // === ì¸ì¦ ê´€ë ¨ API ===
=======
        result.put("message", available ? "사용 가능한 전화번호입니다." : "이미 사용중인 전화번호입니다.");
        return result;
    }
    
    // === 인증 관련 API ===
    
>>>>>>> b65c320 (Initial commit)
    @PostMapping("sendSMS")
    @ResponseBody
    public Map<String, Object> sendSMS(String phone) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = userService.sendSMSAuthCode(phone);
            result.put("success", success);
<<<<<<< HEAD
            result.put("message", success ? "ì¸ì¦ë²ˆí˜¸ê°€ ë°œì†¡ë˜ì—ˆìŠµë‹ˆë‹¤." : "ë°œì†¡ì— ì‹¤íŒ¨í–ˆìŠµë‹ˆë‹¤.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "ì˜¤ë¥˜ê°€ ë°œìƒí–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
=======
            result.put("message", success ? "인증번호가 발송되었습니다." : "발송에 실패했습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
>>>>>>> b65c320 (Initial commit)
        }
        
        return result;
    }
    
    @PostMapping("verifySMS")
    @ResponseBody
    public Map<String, Object> verifySMS(String phone, String code) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = userService.verifySMSAuthCode(phone, code);
            result.put("success", success);
<<<<<<< HEAD
            result.put("message", success ? "ì¸ì¦ì´ ì™„ë£Œë˜ì—ˆìŠµë‹ˆë‹¤." : "ì¸ì¦ë²ˆí˜¸ê°€ ì˜¬ë°”ë¥´ì§€ ì•ŠìŠµë‹ˆë‹¤.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "ì˜¤ë¥˜ê°€ ë°œìƒí–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
=======
            result.put("message", success ? "인증이 완료되었습니다." : "인증번호가 올바르지 않습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
>>>>>>> b65c320 (Initial commit)
        }
        
        return result;
    }
    
    @PostMapping("sendEmail")
    @ResponseBody
    public Map<String, Object> sendEmail(String email) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = userService.sendEmailAuthCode(email);
            result.put("success", success);
<<<<<<< HEAD
            result.put("message", success ? "ì¸ì¦ë²ˆí˜¸ê°€ ë°œì†¡ë˜ì—ˆìŠµë‹ˆë‹¤." : "ë°œì†¡ì— ì‹¤íŒ¨í–ˆìŠµë‹ˆë‹¤.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "ì˜¤ë¥˜ê°€ ë°œìƒí–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
=======
            result.put("message", success ? "인증번호가 발송되었습니다." : "발송에 실패했습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
>>>>>>> b65c320 (Initial commit)
        }
        
        return result;
    }
    
    @PostMapping("verifyEmail")
    @ResponseBody
    public Map<String, Object> verifyEmail(String email, String code) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = userService.verifyEmailAuthCode(email, code);
            result.put("success", success);
<<<<<<< HEAD
            result.put("message", success ? "ì¸ì¦ì´ ì™„ë£Œë˜ì—ˆìŠµë‹ˆë‹¤." : "ì¸ì¦ë²ˆí˜¸ê°€ ì˜¬ë°”ë¥´ì§€ ì•ŠìŠµë‹ˆë‹¤.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "ì˜¤ë¥˜ê°€ ë°œìƒí–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
=======
            result.put("message", success ? "이메일 인증이 완료되었습니다." : "인증번호가 올바르지 않습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
>>>>>>> b65c320 (Initial commit)
        }
        
        return result;
    }
    
<<<<<<< HEAD
    // === ì•„ì´ë””/íŒ¨ìŠ¤ì›Œë“œ ì°¾ê¸° ===
=======
    // === 아이디/패스워드 찾기 ===
    
>>>>>>> b65c320 (Initial commit)
    @GetMapping("findId")
    public String findId() {
        return "user/findId";
    }
    
    @PostMapping("findIdPost")
    @ResponseBody
    public Map<String, Object> findIdPost(String email, String phone) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String userId = userService.findUserId(email, phone);
            if (userId != null) {
                result.put("success", true);
                result.put("userId", userId);
<<<<<<< HEAD
                result.put("message", "ì•„ì´ë””ë¥¼ ì°¾ì•˜ìŠµë‹ˆë‹¤.");
            } else {
                result.put("success", false);
                result.put("message", "ì¼ì¹˜í•˜ëŠ” íšŒì›ì •ë³´ê°€ ì—†ìŠµë‹ˆë‹¤.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "ì˜¤ë¥˜ê°€ ë°œìƒí–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
=======
                result.put("message", "아이디를 찾았습니다.");
            } else {
                result.put("success", false);
                result.put("message", "일치하는 회원정보가 없습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
>>>>>>> b65c320 (Initial commit)
        }
        
        return result;
    }
    
    @GetMapping("findPassword")
    public String findPassword() {
        return "user/findPassword";
    }
    
    @PostMapping("findPasswordPost")
    @ResponseBody
    public Map<String, Object> findPasswordPost(String userId, String email, String newPassword) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = userService.resetPassword(userId, email, newPassword);
            result.put("success", success);
<<<<<<< HEAD
            result.put("message", success ? "ë¹„ë°€ë²ˆí˜¸ê°€ ìž¬ì„¤ì •ë˜ì—ˆìŠµë‹ˆë‹¤." : "ë¹„ë°€ë²ˆí˜¸ ìž¬ì„¤ì •ì— ì‹¤íŒ¨í–ˆìŠµë‹ˆë‹¤.");
=======
            result.put("message", success ? "비밀번호가 재설정되었습니다." : "비밀번호 재설정에 실패했습니다.");
>>>>>>> b65c320 (Initial commit)
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
<<<<<<< HEAD
    // === íšŒì›íƒˆí‡´ ===
    @GetMapping("withdraw")
    public String withdraw(HttpSession session) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
=======
    // === 회원탈퇴 (소셜 사용자 지원) ===
    
    @GetMapping("withdraw")
    public String withdraw(HttpSession session, Model model) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        Long userNum = userService.getCurrentUserNum(session);
        boolean isSocialOnly = userService.isSocialUser(userNum);
        
        model.addAttribute("isSocialOnly", isSocialOnly);
>>>>>>> b65c320 (Initial commit)
        return "user/withdraw";
    }
    
    @PostMapping("withdrawPost")
    public String withdrawPost(String password, HttpSession session, RedirectAttributes rttr) {
        try {
            if (!userService.isLoggedIn(session)) {
                return "redirect:/user/login";
            }
            
            Long userNum = userService.getCurrentUserNum(session);
            
<<<<<<< HEAD
            // ë¹„ë°€ë²ˆí˜¸ í™•ì¸ í›„ ê³„ì • ë¹„í™œì„±í™”
            UserVO user = userService.getCurrentUser(session);
            // ìž„ì‹œë¡œ ë¹„ë°€ë²ˆí˜¸ ì²´í¬ ìƒëžµ (ì‹¤ì œë¡œëŠ” í™•ì¸ í•„ìš”)
            
            userService.deactivateUser(userNum);
            session.invalidate();
            
            rttr.addFlashAttribute("message", "íšŒì›íƒˆí‡´ê°€ ì™„ë£Œë˜ì—ˆìŠµë‹ˆë‹¤.");
            return "redirect:/";
            
        } catch (Exception e) {
            rttr.addFlashAttribute("message", "íšŒì›íƒˆí‡´ì— ì‹¤íŒ¨í–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
            return "redirect:/user/withdraw";
        }
    }
=======
            if (userService.isSocialUser(userNum)) {
                userService.withdrawSocialUser(userNum);
                log.info("소셜 전용 계정 탈퇴 완료: userNum={}", userNum);
            } else {
                if (password == null || password.trim().isEmpty()) {
                    throw new Exception("비밀번호를 입력해주세요.");
                }
                
                UserVO user = userService.getCurrentUser(session);
                if (!passwordEncoder.matches(password, user.getPassword())) {
                    throw new Exception("비밀번호가 올바르지 않습니다.");
                }
                
                userService.deactivateUser(userNum);
                log.info("일반 계정 탈퇴 완료: userNum={}, userId={}", userNum, user.getUserId());
            }
            
            session.invalidate();
            rttr.addFlashAttribute("message", "회원탈퇴가 완료되었습니다.");
            return "redirect:/";
            
        } catch (Exception e) {
            log.error("회원탈퇴 중 오류: {}", e.getMessage());
            rttr.addFlashAttribute("message", "회원탈퇴 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/user/withdraw";
        }
    }
    
    // === 추가 메서드들 ===
    
    /**
     * 아이디 존재 여부 확인
     */
    @PostMapping("checkUserExists")
    @ResponseBody
    public Map<String, Object> checkUserExists(String userId) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean exists = userService.checkUserExists(userId);
            result.put("exists", exists);
            result.put("message", exists ? "사용자 확인 완료" : "존재하지 않는 아이디입니다");
        } catch (Exception e) {
            log.error("사용자 확인 오류: {}", e.getMessage());
            result.put("exists", false);
            result.put("message", "오류가 발생했습니다");
        }
        
        return result;
    }
    
    /**
     * 비밀번호 재설정 (아이디만으로)
     */
    @PostMapping("resetPasswordByUserId")
    @ResponseBody
    public Map<String, Object> resetPasswordByUserId(String userId, String newPassword) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = userService.resetPasswordByUserId(userId, newPassword);
            result.put("success", success);
            result.put("message", success ? "비밀번호가 재설정되었습니다." : "비밀번호 재설정에 실패했습니다.");
        } catch (Exception e) {
            log.error("비밀번호 재설정 오류: {}", e.getMessage());
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    /**
     * 비밀번호 찾기를 위한 사용자 정보 확인
     */
    @PostMapping("checkUserForPasswordReset")
    @ResponseBody
    public Map<String, Object> checkUserForPasswordReset(String userId, String email) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.findUserNumForPasswordReset(userId, email);
            result.put("exists", userNum != null);
            result.put("message", userNum != null ? "사용자 정보가 확인되었습니다." : "아이디와 이메일이 일치하지 않습니다.");
        } catch (Exception e) {
            log.error("사용자 정보 확인 오류: {}", e.getMessage());
            result.put("exists", false);
            result.put("message", "오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 이메일로만 아이디 찾기
     */
    @PostMapping("findIdByEmail")
    @ResponseBody
    public Map<String, Object> findIdByEmail(String email) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String userId = userService.findUserIdByEmail(email);
            if (userId != null) {
                result.put("success", true);
                result.put("userId", userId);
                result.put("message", "아이디를 찾았습니다.");
            } else {
                result.put("success", false);
                result.put("message", "해당 이메일로 등록된 계정이 없습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    /**
     * 휴대폰번호로만 아이디 찾기
     */
    @PostMapping("findIdByPhone")
    @ResponseBody
    public Map<String, Object> findIdByPhone(String phone) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String userId = userService.findUserIdByPhone(phone);
            if (userId != null) {
                result.put("success", true);
                result.put("userId", userId);
                result.put("message", "아이디를 찾았습니다.");
            } else {
                result.put("success", false);
                result.put("message", "해당 휴대폰번호로 등록된 계정이 없습니다.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }    
    
    // === 팀원 버전 호환 메서드들 ===
    
    /**
     * 팀원 버전 호환: 아이디 중복 체크
     * @deprecated checkUserId 사용 권장
     */
    @GetMapping("uidCheck")
    @ResponseBody
    public boolean uidCheck(String user_id) throws Exception {
        UserVO user = userService.getUserById(user_id);
        return user == null;
    }
    
    /**
     * 소셜 계정 연동 해제 (AJAX) - 소셜 전용 계정 보호 및 현재 로그인 제공자 제한
     */
    @PostMapping("unlinkSocial")
    @ResponseBody
    public Map<String, Object> unlinkSocial(@RequestParam("provider") String provider,
                                           HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            if (!userService.isLoggedIn(session)) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            Long userNum = userService.getCurrentUserNum(session);
            
            // 현재 로그인 소셜 제공자와 같은지 확인
            String currentProvider = userService.getCurrentSocialProvider(session);
            if (provider.equalsIgnoreCase(currentProvider)) {
                result.put("success", false);
                result.put("message", "현재 로그인한 " + provider + " 계정은 연동 해제할 수 없습니다.");
                return result;
            }
            
            // 소셜 전용 계정 보호 - 마지막 소셜 계정 해제 방지
            boolean isSocialUser = userService.isSocialUser(userNum);
            if (isSocialUser) {
                List<SocialUserVO> socialAccounts = userService.getUserSocialAccounts(userNum);
                if (socialAccounts.size() <= 1) {
                    result.put("success", false);
                    result.put("message", "소셜 전용 계정은 마지막 소셜 계정을 해제할 수 없습니다. 계정에 로그인할 수 없게 됩니다.");
                    result.put("isSocialOnly", true);
                    return result;
                }
            }
            
            // 연동 해제 실행
            boolean success = userService.unlinkSocialAccount(userNum, provider.toUpperCase(), session);
            
            if (success) {
                result.put("success", true);
                result.put("message", provider + " 계정 연동이 해제되었습니다.");
                
                List<SocialUserVO> remainingSocialAccounts = userService.getUserSocialAccounts(userNum);
                result.put("remainingSocialAccounts", remainingSocialAccounts);
                result.put("remainingCount", remainingSocialAccounts.size());
            } else {
                result.put("success", false);
                result.put("message", "연동 해제에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("소셜 계정 연동 해제 오류: {}", e.getMessage(), e);
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }

    /**
     * 소셜 계정 목록 조회 (AJAX)
     */
    @GetMapping("getSocialAccounts")
    @ResponseBody
    public Map<String, Object> getSocialAccounts(HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            if (!userService.isLoggedIn(session)) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            Long userNum = userService.getCurrentUserNum(session);
            List<SocialUserVO> socialAccounts = userService.getUserSocialAccounts(userNum);
            boolean isSocialUser = userService.isSocialUser(userNum);
            String currentProvider = userService.getCurrentSocialProvider(session);
            
            result.put("success", true);
            result.put("socialAccounts", socialAccounts);
            result.put("isSocialUser", isSocialUser);
            result.put("currentProvider", currentProvider);
            result.put("canUnlinkAll", !isSocialUser || socialAccounts.size() > 1);
            
        } catch (Exception e) {
            log.error("소셜 계정 목록 조회 오류: {}", e.getMessage(), e);
            result.put("success", false);
            result.put("message", "오류가 발생했습니다.");
        }
        
        return result;
    }
    
    /**
     * 소셜 가입용 인증 코드 발송 (이메일/SMS)
     */
    @PostMapping("social/sendVerification")
    @ResponseBody
    public Map<String, Object> sendSocialVerification(@RequestParam String type, 
                                                     @RequestParam String contact,
                                                     HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = false;
            
            if ("email".equals(type)) {
                success = userService.sendEmailAuthCode(contact);
            } else if ("sms".equals(type)) {
                success = userService.sendSMSAuthCode(contact);
            }
            
            result.put("success", success);
            result.put("message", success ? 
                "인증번호가 발송되었습니다." : 
                "발송에 실패했습니다.");
            
        } catch (Exception e) {
            log.error("소셜 가입 인증 발송 실패: {}", e.getMessage());
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    /**
     * 소셜 가입용 인증 코드 확인
     */
    @PostMapping("social/verifyCode")
    @ResponseBody
    public Map<String, Object> verifySocialCode(@RequestParam String type,
                                               @RequestParam String contact,
                                               @RequestParam String code,
                                               HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = false;
            
            if ("email".equals(type)) {
                success = userService.verifyEmailAuthCode(contact, code);
            } else if ("sms".equals(type)) {
                success = userService.verifySMSAuthCode(contact, code);
            }
            
            result.put("success", success);
            result.put("message", success ? 
                "인증이 완료되었습니다." : 
                "인증번호가 올바르지 않습니다.");
            
        } catch (Exception e) {
            log.error("소셜 가입 인증 확인 실패: {}", e.getMessage());
            result.put("success", false);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return result;
    }

    /**
     * 소셜 가입 완료 처리 (추가 정보 입력 후)
     */
    @PostMapping("social/complete")
    public String completeSocialJoin(@RequestParam(required = false) String email,
                                    @RequestParam(required = false) String phone,
                                    @RequestParam(required = false) String birthDate,
                                    @RequestParam(required = false) String gender,
                                    HttpSession session,
                                    RedirectAttributes rttr) {
        try {
            if (!userService.isLoggedIn(session)) {
                throw new Exception("로그인이 필요합니다.");
            }
            
            UserVO currentUser = userService.getCurrentUser(session);
            
            if (!currentUser.isSocialUser()) {
                throw new Exception("소셜 계정이 아닙니다.");
            }
            
            UserVO updateUser = new UserVO();
            updateUser.setUserNum(currentUser.getUserNum());
            
            if (email != null && !email.trim().isEmpty()) {
                if (!userService.isEmailAvailable(email)) {
                    throw new Exception("이미 사용중인 이메일입니다.");
                }
                updateUser.setEmail(email.trim());
            } else {
                updateUser.setEmail(null);
            }
            
            if (phone != null && !phone.trim().isEmpty()) {
                if (!userService.isPhoneAvailable(phone)) {
                    throw new Exception("이미 사용중인 전화번호입니다.");
                }
                updateUser.setPhone(phone.trim());
            } else {
                updateUser.setPhone(null);
            }
            
            if (birthDate != null && !birthDate.trim().isEmpty()) {
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    updateUser.setBirthDate(sdf.parse(birthDate));
                } catch (Exception e) {
                    log.warn("생년월일 파싱 실패: {}", birthDate);
                }
            }
            
            if (gender != null && !gender.trim().isEmpty()) {
                updateUser.setGender(gender.trim());
            }
            
            boolean success = userService.updateUser(updateUser);
            
            if (success) {
                UserVO updatedUser = userService.getCurrentUser(session);
                userService.setUserSession(updatedUser, session);
                
                rttr.addFlashAttribute("message", "소셜 가입이 완료되었습니다!");
                return "redirect:/";
            } else {
                throw new Exception("정보 업데이트에 실패했습니다.");
            }
            
        } catch (Exception e) {
            log.error("소셜 가입 완료 처리 실패: {}", e.getMessage());
            rttr.addFlashAttribute("message", "가입 완료 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/user/mypage";
        }
    }

    /**
     * 소셜 가입 중단 처리
     */
    @PostMapping("social/cancel")
    public String cancelSocialJoin(HttpSession session, RedirectAttributes rttr) {
        try {
            session.removeAttribute("pendingSocialUser");
            session.removeAttribute("socialChoiceData");
            session.removeAttribute("socialJoinIntent");
            
            log.info("소셜 가입 중단 처리 완료");
            rttr.addFlashAttribute("message", "소셜 가입이 취소되었습니다.");
            return "redirect:/user/login";
            
        } catch (Exception e) {
            log.error("소셜 가입 중단 처리 실패: {}", e.getMessage());
            return "redirect:/user/login";
        }
    }
   
>>>>>>> b65c320 (Initial commit)
}