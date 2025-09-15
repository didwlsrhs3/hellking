package net.koreate.hellking.user.controller;

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
public class UserController {
    
    @Autowired
    private UserService userService;
    
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
            rttr.addFlashAttribute("message", e.getMessage());
            return "redirect:/user/login";
        }
    }
    
    @GetMapping("logout")
    public String logout(HttpSession session) {
        userService.logout(session);
        return "redirect:/";
    }
    
    // === íšŒì›ê°€ìž… ê´€ë ¨ ===
    @GetMapping("join")
    public String join() {
        return "user/join";
    }
    
    @PostMapping("joinPost")
    public String joinPost(UserVO user, RedirectAttributes rttr) {
        try {
            userService.registerUser(user);
            rttr.addFlashAttribute("message", "íšŒì›ê°€ìž…ì´ ì™„ë£Œë˜ì—ˆìŠµë‹ˆë‹¤.");
            return "redirect:/user/login";
        } catch (Exception e) {
            rttr.addFlashAttribute("message", e.getMessage());
            return "redirect:/user/join";
        }
    }
    
    // === ë§ˆì´íŽ˜ì´ì§€ ===
    @GetMapping("mypage")
    public String mypage(HttpSession session, Model model) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        Long userNum = userService.getCurrentUserNum(session);
        UserVO user = userService.getUserWithActivePass(userNum);
        model.addAttribute("user", user);
        return "user/mypage";
    }
    
    @GetMapping("edit")
    public String edit(HttpSession session, Model model) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        UserVO user = userService.getCurrentUser(session);
        model.addAttribute("user", user);
        return "user/edit";
    }
    
    @PostMapping("editPost")
    public String editPost(UserVO user, HttpSession session, RedirectAttributes rttr) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            user.setUserNum(userNum);
            
            userService.updateUser(user);
            rttr.addFlashAttribute("message", "íšŒì›ì •ë³´ê°€ ìˆ˜ì •ë˜ì—ˆìŠµë‹ˆë‹¤.");
            return "redirect:/user/mypage";
        } catch (Exception e) {
            rttr.addFlashAttribute("message", "ìˆ˜ì •ì— ì‹¤íŒ¨í–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
            return "redirect:/user/edit";
        }
    }
    
    // === ë¹„ë°€ë²ˆí˜¸ ë³€ê²½ ===
    @GetMapping("changePassword")
    public String changePassword(HttpSession session) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        return "user/changePassword";
    }
    
    @PostMapping("changePasswordPost")
    @ResponseBody
    public Map<String, Object> changePasswordPost(String currentPassword, String newPassword, 
                                                 HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            if (!userService.isLoggedIn(session)) {
                result.put("success", false);
                result.put("message", "ë¡œê·¸ì¸ì´ í•„ìš”í•©ë‹ˆë‹¤.");
                return result;
            }
            
            Long userNum = userService.getCurrentUserNum(session);
            boolean success = userService.updatePassword(userNum, currentPassword, newPassword);
            
            result.put("success", success);
            result.put("message", success ? "ë¹„ë°€ë²ˆí˜¸ê°€ ë³€ê²½ë˜ì—ˆìŠµë‹ˆë‹¤." : "ë¹„ë°€ë²ˆí˜¸ ë³€ê²½ì— ì‹¤íŒ¨í–ˆìŠµë‹ˆë‹¤.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    // === ì¤‘ë³µ ì²´í¬ API ===
    @GetMapping("checkUserId")
    @ResponseBody
    public Map<String, Object> checkUserId(String userId) {
        Map<String, Object> result = new HashMap<>();
        boolean available = userService.isUserIdAvailable(userId);
        result.put("available", available);
        result.put("message", available ? "ì‚¬ìš© ê°€ëŠ¥í•œ ì•„ì´ë””ìž…ë‹ˆë‹¤." : "ì´ë¯¸ ì‚¬ìš©ì¤‘ì¸ ì•„ì´ë””ìž…ë‹ˆë‹¤.");
        return result;
    }
    
    @GetMapping("checkEmail")
    @ResponseBody
    public Map<String, Object> checkEmail(String email) {
        Map<String, Object> result = new HashMap<>();
        boolean available = userService.isEmailAvailable(email);
        result.put("available", available);
        result.put("message", available ? "ì‚¬ìš© ê°€ëŠ¥í•œ ì´ë©”ì¼ìž…ë‹ˆë‹¤." : "ì´ë¯¸ ì‚¬ìš©ì¤‘ì¸ ì´ë©”ì¼ìž…ë‹ˆë‹¤.");
        return result;
    }
    
    @GetMapping("checkPhone")
    @ResponseBody
    public Map<String, Object> checkPhone(String phone) {
        Map<String, Object> result = new HashMap<>();
        boolean available = userService.isPhoneAvailable(phone);
        result.put("available", available);
        result.put("message", available ? "ì‚¬ìš© ê°€ëŠ¥í•œ ì „í™”ë²ˆí˜¸ìž…ë‹ˆë‹¤." : "ì´ë¯¸ ì‚¬ìš©ì¤‘ì¸ ì „í™”ë²ˆí˜¸ìž…ë‹ˆë‹¤.");
        return result;
    }
    
    // === ì¸ì¦ ê´€ë ¨ API ===
    @PostMapping("sendSMS")
    @ResponseBody
    public Map<String, Object> sendSMS(String phone) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            boolean success = userService.sendSMSAuthCode(phone);
            result.put("success", success);
            result.put("message", success ? "ì¸ì¦ë²ˆí˜¸ê°€ ë°œì†¡ë˜ì—ˆìŠµë‹ˆë‹¤." : "ë°œì†¡ì— ì‹¤íŒ¨í–ˆìŠµë‹ˆë‹¤.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "ì˜¤ë¥˜ê°€ ë°œìƒí–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
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
            result.put("message", success ? "ì¸ì¦ì´ ì™„ë£Œë˜ì—ˆìŠµë‹ˆë‹¤." : "ì¸ì¦ë²ˆí˜¸ê°€ ì˜¬ë°”ë¥´ì§€ ì•ŠìŠµë‹ˆë‹¤.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "ì˜¤ë¥˜ê°€ ë°œìƒí–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
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
            result.put("message", success ? "ì¸ì¦ë²ˆí˜¸ê°€ ë°œì†¡ë˜ì—ˆìŠµë‹ˆë‹¤." : "ë°œì†¡ì— ì‹¤íŒ¨í–ˆìŠµë‹ˆë‹¤.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "ì˜¤ë¥˜ê°€ ë°œìƒí–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
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
            result.put("message", success ? "ì¸ì¦ì´ ì™„ë£Œë˜ì—ˆìŠµë‹ˆë‹¤." : "ì¸ì¦ë²ˆí˜¸ê°€ ì˜¬ë°”ë¥´ì§€ ì•ŠìŠµë‹ˆë‹¤.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "ì˜¤ë¥˜ê°€ ë°œìƒí–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
        }
        
        return result;
    }
    
    // === ì•„ì´ë””/íŒ¨ìŠ¤ì›Œë“œ ì°¾ê¸° ===
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
                result.put("message", "ì•„ì´ë””ë¥¼ ì°¾ì•˜ìŠµë‹ˆë‹¤.");
            } else {
                result.put("success", false);
                result.put("message", "ì¼ì¹˜í•˜ëŠ” íšŒì›ì •ë³´ê°€ ì—†ìŠµë‹ˆë‹¤.");
            }
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "ì˜¤ë¥˜ê°€ ë°œìƒí–ˆìŠµë‹ˆë‹¤: " + e.getMessage());
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
            result.put("message", success ? "ë¹„ë°€ë²ˆí˜¸ê°€ ìž¬ì„¤ì •ë˜ì—ˆìŠµë‹ˆë‹¤." : "ë¹„ë°€ë²ˆí˜¸ ìž¬ì„¤ì •ì— ì‹¤íŒ¨í–ˆìŠµë‹ˆë‹¤.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    // === íšŒì›íƒˆí‡´ ===
    @GetMapping("withdraw")
    public String withdraw(HttpSession session) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        return "user/withdraw";
    }
    
    @PostMapping("withdrawPost")
    public String withdrawPost(String password, HttpSession session, RedirectAttributes rttr) {
        try {
            if (!userService.isLoggedIn(session)) {
                return "redirect:/user/login";
            }
            
            Long userNum = userService.getCurrentUserNum(session);
            
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
}