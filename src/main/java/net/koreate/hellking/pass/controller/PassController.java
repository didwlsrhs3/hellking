package net.koreate.hellking.pass.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import net.koreate.hellking.pass.service.PassService;
import net.koreate.hellking.pass.vo.PassVO;
import net.koreate.hellking.pass.vo.RefundVO;
import net.koreate.hellking.pass.vo.UserPassVO;
import net.koreate.hellking.user.service.UserService;
import net.koreate.hellking.user.vo.UserVO;

@Controller
@RequestMapping("/pass/")
public class PassController {
    
    @Autowired
    private PassService passService;
    
    @Autowired
    private UserService userService;
    
    // 생성자에 디버깅 로그 추가
    public PassController() {
        System.out.println("=== PassController 생성됨 ===");
    }
    
    // === 패스권 목록 및 정보 ===
    @GetMapping("list")
    public String list(Model model) {
        System.out.println("\n=== PassController.list() 시작 ===");
        
        try {
            // 1. PassService 상태 확인
            System.out.println("1. PassService 확인:");
            System.out.println("   - passService 객체: " + passService);
            System.out.println("   - passService 클래스: " + passService.getClass().getName());
            
            // 2. PassDAO 직접 테스트
            System.out.println("2. 데이터 조회 시도:");
            List<PassVO> passes = passService.getAllPasses();
            System.out.println("   - 조회 결과: " + (passes != null ? passes.size() + "개" : "null"));
            
            // 3. 상세 데이터 출력
            if (passes != null && !passes.isEmpty()) {
                System.out.println("3. 패스권 상세 정보:");
                for (int i = 0; i < passes.size(); i++) {
                    PassVO pass = passes.get(i);
                    System.out.println("   패스권 " + (i+1) + ":");
                    System.out.println("     - passNum: " + pass.getPassNum());
                    System.out.println("     - passName: " + pass.getPassName());
                    System.out.println("     - price: " + pass.getPrice());
                    System.out.println("     - durationDays: " + pass.getDurationDays());
                    System.out.println("     - formattedPrice: " + pass.getFormattedPrice());
                    System.out.println("     - durationText: " + pass.getDurationText());
                }
            } else {
                System.out.println("3. ❌ 패스권 데이터가 비어있음");
            }
            
            model.addAttribute("passes", passes);
            System.out.println("4. Model에 데이터 추가 완료");
            
        } catch (Exception e) {
            System.out.println("❌ 오류 발생:");
            System.out.println("   - 메시지: " + e.getMessage());
            System.out.println("   - 클래스: " + e.getClass().getName());
            e.printStackTrace();
            
            // 빈 리스트라도 전달
            model.addAttribute("passes", new ArrayList<PassVO>());
        }
        
        System.out.println("=== PassController.list() 종료 ===\n");
        return "pass/list";
    }
    
    @GetMapping("info")
    public String info(Model model) {
        List<PassVO> passes = passService.getAllPasses();
        model.addAttribute("passes", passes);
        return "pass/info";
    }
    
    // === 패스권 구매 ===
    @GetMapping("purchase/{passNum}")
    public String purchase(@PathVariable Long passNum, Model model, HttpSession session) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        PassVO pass = passService.getPassByNum(passNum);
        if (pass == null) {
            return "redirect:/pass/list";
        }
        
        Long userNum = userService.getCurrentUserNum(session);
        UserVO user = userService.getCurrentUser(session);
        List<UserPassVO> activePasses = passService.getActivePasses(userNum);
        
        model.addAttribute("pass", pass);
        model.addAttribute("activePasses", activePasses);
        
        // 세션 정보를 모델에 추가
        model.addAttribute("userEmail", user.getEmail());
        model.addAttribute("username", user.getUsername());
        model.addAttribute("userPhone", user.getPhone());
        
        return "pass/purchase";
    }
    
    @PostMapping("createOrder")
    @ResponseBody
    public Map<String, Object> createOrder(Long passNum, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            String merchantUid = passService.createPaymentOrder(userNum, passNum);
            
            result.put("success", true);
            result.put("merchantUid", merchantUid);
            result.put("message", "주문이 생성되었습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "주문 생성에 실패했습니다: " + e.getMessage());
        }
        
        return result;
    }
    
    @PostMapping("completePurchase")
    @ResponseBody
    public Map<String, Object> completePurchase(Long passNum, String paymentId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            boolean success = passService.purchasePass(userNum, passNum, paymentId);
            
            result.put("success", success);
            result.put("message", success ? "패스권 구매가 완료되었습니다." : "구매에 실패했습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    // === 내 패스권 관리 ===
    @GetMapping("mypass")
    public String mypass(HttpSession session, Model model) {
        System.out.println("=== PassController mypass 메서드 호출됨 ===");
        System.out.println("세션 userNum: " + session.getAttribute("userNum"));
        
        if (!userService.isLoggedIn(session)) {
            System.out.println("로그인되지 않음 - 로그인 페이지로 리다이렉트");
            return "redirect:/user/login";
        }
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            System.out.println("현재 사용자 번호: " + userNum);
            
            List<UserPassVO> userPasses = passService.getUserPasses(userNum);
            List<UserPassVO> activePasses = passService.getActivePasses(userNum);
            List<RefundVO> refunds = passService.getRefunds(userNum);
            Map<String, Object> stats = passService.getUserPassStats(userNum);
            
            System.out.println("데이터 조회 완료:");
            System.out.println("- userPasses: " + (userPasses != null ? userPasses.size() : "null"));
            System.out.println("- activePasses: " + (activePasses != null ? activePasses.size() : "null"));
            System.out.println("- refunds: " + (refunds != null ? refunds.size() : "null"));
            System.out.println("- stats: " + stats);
            
            model.addAttribute("userPasses", userPasses);
            model.addAttribute("activePasses", activePasses);
            model.addAttribute("refunds", refunds);
            model.addAttribute("stats", stats);
            
            System.out.println("pass/mypass JSP로 리턴");
            return "pass/mypass";
            
        } catch (Exception e) {
            System.out.println("mypass 메서드에서 오류 발생: " + e.getMessage());
            e.printStackTrace();
            return "pass/list"; // 오류 시 임시로 list 페이지로
        }
    }
    
    @GetMapping("detail/{userPassNum}")
    public String detail(@PathVariable Long userPassNum, HttpSession session, Model model) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        UserPassVO userPass = passService.getUserPassByNum(userPassNum);
        if (userPass == null) {
            return "redirect:/pass/mypass";
        }
        
        // 소유자 확인
        Long currentUserNum = userService.getCurrentUserNum(session);
        if (!currentUserNum.equals(userPass.getUserNum())) {
            return "redirect:/pass/mypass";
        }
        
        model.addAttribute("userPass", userPass);
        return "pass/detail";
    }
    
    // === 환불 관리 ===
    @GetMapping("refund/{userPassNum}")
    public String refund(@PathVariable Long userPassNum, HttpSession session, Model model) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        
        UserPassVO userPass = passService.getUserPassByNum(userPassNum);
        if (userPass == null) {
            return "redirect:/pass/mypass";
        }
        
        // 소유자 확인
        Long currentUserNum = userService.getCurrentUserNum(session);
        if (!currentUserNum.equals(userPass.getUserNum())) {
            return "redirect:/pass/mypass";
        }
        
        // 환불 가능 여부 확인
        if (!userPass.getCanRefund()) {
            return "redirect:/pass/mypass";
        }
        
        model.addAttribute("userPass", userPass);
        return "pass/refund";
    }
    
    @PostMapping("requestRefund")
    @ResponseBody
    public Map<String, Object> requestRefund(Long userPassNum, String reason, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            Long userNum = userService.getCurrentUserNum(session);
            if (userNum == null) {
                result.put("success", false);
                result.put("message", "로그인이 필요합니다.");
                return result;
            }
            
            boolean success = passService.requestRefund(userPassNum, reason);
            
            result.put("success", success);
            result.put("message", success ? "환불 신청이 완료되었습니다." : "환불 신청에 실패했습니다.");
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", e.getMessage());
        }
        
        return result;
    }
    
    // === 패스권 신청/해지 (헤더 링크용) ===
    @GetMapping("apply")
    public String apply() {
        return "redirect:/pass/list";
    }
    
    @GetMapping("cancel")
    public String cancel(HttpSession session) {
        if (!userService.isLoggedIn(session)) {
            return "redirect:/user/login";
        }
        return "redirect:/pass/mypass";
    }
}